# Review Contract

Der Reviewer prüft nicht allgemein, sondern immer PR gegen verlinktes Issue.

## Ziel

Reviewer sollen PRs so prüfen, dass der Operator eine entscheidungsfähige Ampel sieht:

- Grün: `review:pass` + `auto-merge:ok`; mechanischer Merge erlaubt, wenn alle Grün-Kriterien weiterhin gelten
- Gelb: `needs-human`; Auto-Merge verboten, Operator-Entscheidung nötig
- Rot: `needs-fix` oder `blocked`; kein Merge, konkrete Fix- oder Entscheidungsempfehlung nötig

## Review-Quellen

Der Reviewer nutzt ausschließlich:

1. verlinktes GitHub Issue
2. PR-Beschreibung
3. PR-Diff
4. PR-Kommentare und Evidence
5. `AGENTS.md`
6. Repo-Dateien, soweit für die Prüfung erforderlich

Der AI Vault wird nicht gelesen.

## Review Isolation

A review may run in a separate chat, thread or app review context when the tool supports it. That is execution/UI isolation, not a separate source of truth.

The Review of Record remains GitHub:

- linked Issue
- PR diff
- PR body / Closeout
- validation and Evidence
- review comment or review submission
- labels

If the linked issue says `Subagents: REQUIRED`, Review of Record must additionally check:

- Were the required subagents named in the closeout?
- Did the Builder summarize what each subagent found?
- Did the Builder state which findings affected implementation?
- Were relevant findings either implemented, marked out of scope or blocked with reason?

No PASS if required subagent evidence is missing from the PR body or clearly linked PR evidence.

If a PR documents `subagent_timeout`, `subagent_no_result`, `subagent_blocked` or degraded mode, Review of Record must also check:

- Was one targeted recovery attempted?
- Is the failure marker explicit?
- Was degraded mode justified by read-only scope, reconstructable analysis and no critical non-reconstructable missing check?
- Is replacement Evidence documented?
- Is remaining risk stated?

No PASS if subagent failure or degraded-mode evidence is missing, unsafe or only documented outside the PR body / clearly linked PR evidence.

Review of Record must also check `Vault Impact` before PASS. The canonical
format and rules live in `contracts/ticket-contract.md#vault-impact-contract`.
No PASS if the PR closeout lacks `Vault Impact`, if the PR marks Vault update
required as `YES` without a concrete Vault Update Candidate, or if the PR
implies that an agent may directly mutate the AI Vault without explicit issue
permission.

## Prüfpunkte

Der Reviewer prüft:

- Ist das Ziel erfüllt?
- Wurde der Scope eingehalten?
- Wurden Nicht-Ziele respektiert?
- Ist jedes Akzeptanzkriterium einzeln belegt?
- Wurde die im Ticket geforderte Validierung ausgeführt?
- Ist die Evidence ausreichend?
- Ist `Vault Impact` im PR Body sichtbar und nach `contracts/ticket-contract.md#vault-impact-contract` ausgefüllt?
- Bei `Subagents: REQUIRED`: Sind Subagent-Closeout und Subagent-Evidence im PR Body oder klar verlinkter PR-Evidence sichtbar?
- Bei degraded mode: Sind `subagent_timeout`, `subagent_no_result` oder `subagent_blocked`, Recovery, Ersatzanalyse und Restrisiko reviewbar dokumentiert?
- Bei wiederholter Fix-, Review- oder Loop-Arbeit: Dokumentiert der PR Attempt Budget, Attempts used, letzten fehlgeschlagenen Check/Review-Punkt, Harness Failure Classification, vermutete Ursache, nächste Aktion und warum ein weiterer Codex-Fix sinnvoll ist oder nicht?
- Wenn der PR einen Harness Learning Candidate erstellt oder empfiehlt: Enthält er Claim / Lesson, Evidence Source, Confidence: 1-5, Scope, Applies To, Proposed Target, Proposed Update, Human Gate required: yes und den Non-goal, dass der Candidate nicht aktiv ist, bis er per PR und Review of Record gemerged wurde?
- Bei Failure-Mode-Mapping: Sind alle geforderten Symptome enthalten, nur bestehende Harness Failure Classification Werte genutzt und konkrete Standardreaktionen genannt?
- Gibt es unnötige Änderungen?
- Gibt es Sicherheits-, Architektur-, Produkt- oder UX-Risiken?
- Ist der PR klein genug, um entschieden zu werden?

## Ergebnisformat

Der Review endet mit genau einem Ergebnis und ordnet es Grün, Gelb oder Rot zu.

### PASS

Bedeutung: PR erfüllt das Ticket ausreichend. PASS ist der Review of Record, aber nicht automatisch ein Human Gate.

Aktion:

- `review:pass` setzen oder im Review eindeutig als Review of Record PASS dokumentieren
- `needs-fix` entfernen, falls vorhanden
- `blocked` entfernen, falls vorhanden
- Wenn alle Grün-Kriterien erfüllt sind: `needs-human` entfernen und `auto-merge:ok` setzen
- Wenn eine Operator-Entscheidung nötig ist: `needs-human` setzen und `auto-merge:ok` entfernen
- kurze Merge-Entscheidungsvorlage schreiben

Kommentarformat:

```markdown
## Review Result: PASS

### Ampel
Grün | Gelb

### Operator Summary
- What changed:
- Validation:
- Evidence:
- Risk lane:
- Auto-merge candidate: yes | no
- Human decision required: yes | no
- Claude Code Review Suggested: yes | no
- Reason:

### Entscheidungsvorlage
Der PR erfüllt das verlinkte Issue ausreichend.

### Geprüft
- Ziel: erfüllt
- Scope: eingehalten
- Akzeptanzkriterien: erfüllt
- Validierung: ausgeführt
- Evidence: ausreichend

### Hinweise / Restrisiken
- ...

### Review Recommendation
- Recommended reviewer: none | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason:
- Review ticket suggested: yes | no
- Review ticket created: yes | no
- Review ticket URL:
```

### NEEDS-FIX

Bedeutung: PR ist grundsätzlich fortsetzbar, aber nicht entscheidungsreif.

Aktion:

- `needs-fix` setzen
- `needs-human` entfernen, falls vorhanden
- `review:pass` entfernen, falls vorhanden
- `auto-merge:ok` entfernen, falls vorhanden
- konkrete Fix-Anweisung schreiben

Kommentarformat:

```markdown
## Review Result: NEEDS-FIX

### Blockierende Punkte
- ...

### Konkrete Fix-Anweisung für Codex
1. ...
2. ...
3. ...

### Erforderliche Evidence nach Fix
- ...

### Review Recommendation
- Recommended reviewer: Codex | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason:
- Review ticket suggested: yes | no
- Review ticket created: yes | no
- Review ticket URL:
- Auto-merge blocked until review: yes
```

### BLOCKED

Bedeutung: Agent kann ohne menschliche Entscheidung nicht sinnvoll weitermachen.

Aktion:

- `blocked` setzen
- `needs-human` entfernen, falls vorhanden
- `needs-fix` entfernen, falls vorhanden
- `auto-merge:ok` entfernen, falls vorhanden
- `review:pass` entfernen, falls vorhanden
- Entscheidungsvorlage schreiben

Kommentarformat:

```markdown
## Review Result: BLOCKED

### Warum blockiert
- ...

### Benötigte menschliche Entscheidung
- ...

### Optionen
- Option A: ...
- Option B: ...

### Review Recommendation
- Recommended reviewer: Codex | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason:
- Review ticket suggested: yes | no
- Review ticket created: yes | no
- Review ticket URL:
- Auto-merge blocked until review: yes
```

## Harte Review-Regeln

- Kein PASS ohne Evidence.
- Kein PASS ohne `Vault Impact` im PR Body oder klar verlinkter PR-Evidence.
- Kein PASS, wenn `Vault update required: YES` gesetzt ist und Area, Reason, Suggested target file, Proposed Markdown update oder Source evidence fehlen.
- Kein PASS, wenn der PR direkte AI-Vault-Änderungen durch Agenten behauptet oder impliziert, ohne dass das Issue diese Vault-Änderung ausdrücklich erlaubt.
- Kein PASS, wenn `Subagents: REQUIRED` gilt und die erforderliche Subagent-Evidence im PR Body oder klar verlinkter PR-Evidence fehlt.
- Kein PASS, wenn `subagent_timeout`, `subagent_no_result`, `subagent_blocked` oder degraded mode genutzt wurde und Recovery, Ersatzanalyse, Safety-Begründung oder Restrisiko fehlen.
- Kein PASS bei wiederholter Fix-, Review- oder Loop-Arbeit ohne Attempt-Budget-Evidence, letzten fehlgeschlagenen Check/Review-Punkt, Harness Failure Classification, vermutete Ursache und nächste Aktion.
- Kein PASS für einen Harness Learning Candidate, wenn Source Evidence, Confidence: 1-5, Scope, Proposed Target, Human Gate oder der Hinweis fehlt, dass der Candidate nicht aktiv ist, bis er per PR und Review of Record gemerged wurde.
- Kein PASS bei Failure-Mode-Mapping, wenn ein geforderter Failure Mode fehlt, neue Classification-/Label-/State-Werte eingeführt werden, eine Standardreaktion fehlt oder die Mapping-Sprache eine verpflichtende Workflow-State-Machine statt diagnostischer Guidance erzeugt.
- Kein Review ohne Ticketbezug.
- Keine vagen Fix-Hinweise.
- Kein Schönreden.
- Kein neues Ziel erfinden.
- Keine Architekturentscheidung implizit treffen, wenn das Ticket sie nicht enthält.
- `needs-human` nie als Auto-Merge-Freigabe verwenden.
- `auto-merge:ok` nie setzen, wenn `needs-human`, `needs-fix` oder `blocked` gesetzt ist.
- Claude Code nur als Premium-/Eskalationsressource empfehlen, nicht als Standardpflicht.

## Review-Schärfe

Der Reviewer darf streng sein. Ein `needs-fix` ist kein Scheitern, sondern der normale geschlossene Loop.
