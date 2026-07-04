# Ticket Contract

Ein Ticket ist nur agentenfähig, wenn es seinen Erfolg selbst prüfbar macht.

## Ticket Maturity Rule

Ein Ticket bekommt nur `agent:ready`, wenn sein Agent Work Harness vollständig ist:

- klarer Agent Mode
- klare Autonomy
- klare Risk lane
- klarer Execution Mode
- klares Ziel
- konkreter Kontext
- begrenzte Boundary
- ausdrückliche Nicht-Ziele
- definierter Validierungsbefehl oder Validierungsablauf
- konkrete Evidence-Bedingung
- Closeout-Erwartung
- Attempt Budget & Escalation, wenn wiederholte Fix-, Review- oder Loop-Arbeit erwartet wird
- Operator Summary
- Review Recommendation
- Stop-Bedingung

Wenn ein Ticket morgens nicht selbst beweisen kann, dass es fertig ist, ist es zu groß oder zu unscharf.

## Ticket-Tiers

Der Contract kennt zwei Umfangsklassen. Beide erfuellen die Maturity Rule; sie unterscheiden sich nur darin, welche Bloecke ausgeschrieben werden müssen.

| Tier | Wann | Template |
|---|---|---|
| Light | Risk lane `low`, Mode `EXECUTING`, `Subagents: NOT_REQUIRED`, keine wiederholte Fix-/Review-/Loop-Arbeit erwartet, eine Oberflaeche, keine Protected Area/Release/externe Aktion | `templates/github_issue_task_low_risk.md` |
| Full | alles andere | `templates/github_issue_task.md` |

Low Risk Tickets lassen Execution-Mode-Details, Codex Subagent Instruction, Subagent Failure Policy und Attempt Budget & Escalation weg, weil deren Ausloeser per Definition nicht vorliegen. Goal, Context, Boundary, Acceptance Criteria, Verification, Evidence, Vault Impact, Closeout mit Operator Summary und Stop-Bedingung bleiben Pflicht.

Kippt waehrend der Arbeit ein Light-Kriterium (Risiko steigt, Scope waechst, Fix-Schleife beginnt, zweite Oberflaeche noetig), stoppt der Builder und das Ticket wird auf Full nachgeschaerft. Ein Light Ticket ist keine Abkuerzung an Evidence, Vault Impact oder Review of Record vorbei.

## Pflichtstruktur für agent:ready-Tickets

```markdown
## Agent Contract

Mode: EXECUTING | GRILLING | COORDINATING
Autonomy: prototype | standard | production
Risk lane: low | standard | protected | release

## Execution Mode

Subagents: NOT_REQUIRED | REQUIRED

If REQUIRED:
- why subagents are needed
- which subagents Codex must start
- whether they are read-only or may prepare separated edits
- whether Codex must wait for all results
- what Subagent Failure Policy applies if a subagent stalls or returns no usable result
- where the results and any degraded-mode decision must be documented

## Codex Subagent Instruction

Only required when `Subagents: REQUIRED`.

Use parallel subagents before implementation.
Spawn:
1. Explorer subagent: map relevant files, code paths, docs, affected contracts and symbols. No edits.
2. Test/validation subagent: inspect validation commands, checks and missing evidence. No edits.
3. Risk subagent: inspect correctness, security, data, permission and regression risks. No edits.

Wait for all subagents, but do not wait indefinitely.
If a required subagent stalls or returns no usable result, apply the Subagent Failure Policy: recover once, then either continue in degraded mode with Evidence or stop with `BLOCKED`.
Consolidate findings.
Then implement the smallest safe change.
Include subagent findings, failure markers and any degraded-mode decision in the PR closeout.

## Goal

Ein klarer Satz, der das erwartete Ergebnis beschreibt.

## Context

- Repo/path:
- Related issue/PR/doc:
- Source-of-truth files:
- Known risky areas:

## Boundary

- Allowed changes:
- Do not touch:
- Public/external actions require approval: yes/no

## Verification

- Required command/check:
- UI/browser/simulator proof:
- Evidence artifact expected:

## Attempt Budget & Escalation

Only required when the ticket expects repeated fix, review or loop work.

- Attempt budget:
- Attempts used:
- Last failed check/review point:
- Failure classification:
- Suspected root cause:
- Next action: continue | needs-fix | blocked | human decision | reviewer recommendation
- Recommended next reviewer:
- Operator extension granted: yes/no + by whom/where

## Closeout

- What changed:
- What was verified:
- Evidence:
- Vault Impact:
  - Vault update required: YES | NO
  - Area: Decision | Non-goal | Risk | Roadmap | UX/Brand | Architecture | Lesson | Method
  - Reason:
  - Suggested target file:
  - Proposed Markdown update:
  - Source evidence:
- Subagent Summary, wenn `Subagents: REQUIRED`:
  - Which subagents ran:
  - What each subagent found:
  - Which findings changed implementation:
  - Failure marker: none | subagent_timeout | subagent_no_result | subagent_blocked
  - Recovery attempted:
  - Degraded mode used: yes/no
  - Why degraded continuation was safe:
  - Replacement Evidence / Builder reconstruction:
- Remaining risk:
- Follow-up needed:
- Harness failure classification: none | missing_context | stale_context | missing_tool | missing_verifier | weak_guardrail | unclear_spec | model_limitation

## Operator Summary

- What changed:
- Validation:
- Evidence:
- Risk lane: low | standard | protected | release
- Auto-merge candidate: yes/no
- Human decision required: yes/no
- Claude Code Review Suggested: yes/no
- Reason:

## Review Recommendation

- Recommended reviewer: Codex | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason:
- Review ticket suggested: yes/no
- Review ticket created: yes/no
- Review ticket URL:
- Auto-merge blocked until review: yes/no

## Stop condition

Stop if context, boundary, tool, verifier, or product decision is missing.
```

## Execution Mode

Der `Execution Mode` beschreibt, ob ein Ticket einen ausdrücklichen Codex-Subagent-Lauf verlangt.

```markdown
## Execution Mode

Subagents: NOT_REQUIRED | REQUIRED
```

`Subagents: NOT_REQUIRED` bedeutet: Das Ticket verlangt keinen Subagent-Lauf; Codex kann innerhalb seiner normalen Builder-Arbeit ohne Subagents starten.

`Subagents: REQUIRED` bedeutet: Codex muss vor der Umsetzung die im Ticket genannten Subagents ausdrücklich starten. Eine reine Erlaubnis wie "Codex darf Subagents nutzen" erfüllt diese Pflicht nicht.

Wenn `Subagents: REQUIRED`, muss das Ticket eine konkrete `Codex Subagent Instruction` enthalten:

- warum Subagents nötig sind
- welche Subagents Codex starten muss
- ob sie read-only sind oder getrennte Edits vorbereiten dürfen
- ob Codex auf alle Ergebnisse warten muss
- welche Subagent Failure Policy bei haengenden oder nicht liefernden Subagents gilt
- wo die Ergebnisse dokumentiert werden müssen

Subagents sind interne Codex-Ausführungshelfer. Sie sind keine sichtbaren PM-, Operator- oder Review-of-Record-Rollen, setzen keine Workflow-Labels und ersetzen keine menschliche Entscheidung.

## Attempt Budget & Escalation

Attempt Budget & Escalation verhindert endlose Fix-, Review- und Retry-Loops. Es ist kein Budgetfile, kein Runner und kein neues Statusmodell.

Default-Regeln:

- Builder self-fix before PR: max 1.
- Automated `needs-fix` cycles on the same PR: max 2 unless the Operator explicitly extends.
- Subagent failure recovery stays governed by the Subagent Failure Policy: one targeted recovery, then degraded-with-Evidence or `BLOCKED`.
- Normal implementation steps, a first validation run, PR closeout edits, post-merge hygiene and Green Path next-ticket selection are not counted as attempts.

Wenn ein Attempt Budget erschoepft ist oder derselbe Fehler wiederkehrt, muss Codex vor einem weiteren Fix klassifizieren und dokumentieren:

- failure classification;
- last failed check or review point;
- suspected root cause;
- attempts used;
- recommended next reviewer or human decision;
- whether the Operator explicitly extended the budget.

Escalation bedeutet Evidence und Empfehlung, nicht automatische Claude-Code-Nutzung. Claude Code bleibt nur eine Empfehlung mit Human Gate.

Low-risk documentation work must not be burdened with mandatory heavy loop fields unless the ticket itself repeated work, fix cycles or escalation risk expects.

## Subagent Failure Policy

If `Subagents: REQUIRED`, Codex must not wait indefinitely.

For each required subagent, Codex must apply a failure policy:

1. Attempt one targeted recovery.
2. Request a checkpoint summary from the stalled subagent.
3. If no usable result arrives after one additional check cycle, mark the subagent as:
   - `subagent_timeout`
   - `subagent_no_result`
   - `subagent_blocked`
4. Continue in degraded mode only if:
   - the missing subagent was read-only;
   - the main Builder can safely reconstruct the analysis;
   - the missing result is not a critical, non-reconstructable risk check;
   - replacement analysis is documented as Evidence.
5. Otherwise stop with `BLOCKED`.

The PR closeout must document:

- which subagent failed or timed out;
- what recovery was attempted;
- whether the run continued degraded or blocked;
- why that decision was safe;
- what the main Builder checked instead;
- remaining risk.

`subagent_timeout`, `subagent_no_result` and `subagent_blocked` are Subagent Result markers, not replacements for Harness Failure Classification.

## Agent Modes

| Mode | Bedeutung | Bauregel |
|---|---|---|
| `EXECUTING` | Entscheidung ist getroffen; Ziel, Scope, Verifier und Evidence sind klar | Agent darf bauen |
| `GRILLING` | Entscheidung, Begriff, Scope oder Ziel ist unklar | Agent darf nicht bauen; erst klaeren oder Entscheidungsvorlage schreiben |
| `COORDINATING` | groessere Arbeit braucht Synthese, Subagent-/Teilpruefung oder mehrere Quellen | Agent koordiniert, schneidet und prüft; Umsetzung erst in klarer EXECUTING-Box |

`Autonomy` beschreibt, wie eigenstaendig der Agent innerhalb der Boundary handeln darf. `Risk lane` bestimmt Review-Schaerfe und Evidence-Tiefe. `Execution Mode` ist davon getrennt: Auch ein `EXECUTING`-Ticket kann `Subagents: REQUIRED` setzen, wenn die Umsetzung vorab interne Codex-Teilpruefungen braucht.

## Qualitätsgrenzen

Nicht agentenfähig:

- "verbessere das Design"
- "mach es schöner"
- "prüfe alles"
- "baue Feature X komplett"
- "funktioniert gut"
- keine Boundary
- kein Verifier
- keine Evidence-Bedingung

Agentenfähig:

- "ändere genau Bereich X"
- "führe Befehl Y aus"
- "Screenshot zeigt Zustand Z"
- "Test A ist grün"
- "PR enthält Evidence B"
- "bei fehlendem Tool klassifiziere als missing_tool und stoppe"

## Label-Regel

`agent:ready` ist keine Wunschliste. Das Label bedeutet:

> Dieses Ticket hat Context, Boundary, Verification und Closeout so klar definiert, dass Codex ohne zusätzliche menschliche Rückfrage beginnen kann.

`needs-human` bedeutet immer: Auto-Merge ist verboten und eine Operator-Entscheidung ist nötig. Es ist kein Synonym für eine positive Review- oder Merge-Freigabe.

`auto-merge:ok` bedeutet nur dann Grün, wenn ein Review of Record PASS vorliegt, keine gelben oder roten Labels gesetzt sind und die Operator Summary `Human decision required: no` ausweist.

## Teilprojekt- / Milestone-Regel

Produktwirksame `agent:ready`-Tickets brauchen einen GitHub Milestone. Der
Milestone modelliert das Teilprojekt im Projekt-Repo.

Ein Ticket ohne Milestone ist nur reif, wenn es ausdRücklich als nicht
teilprojektbezogen begründet ist:

- `meta`;
- `repo-hygiene`;
- reine Dokumentation ohne Produktversprechen;
- Tooling ohne Teilprojektbezug;
- Methoden- oder Templatepflege ohne Produktartefakt.

Ein fehlender Milestone bei produktwirksamen Tickets ist ein Reifeproblem im
Ticket Contract, kein Generatorproblem. Codex soll das als `unclear_spec` oder
`missing_context` klassifizieren, statt das Ticket in einem Lagebild kuenstlich
zuzuordnen.

## Scope-Regel

Die Boundary begrenzt die Arbeit. Wenn Codex außerhalb der Boundary ändern müsste, wird nicht improvisiert. Der Lauf stoppt mit `blocked` oder einer Harness Failure Classification.

## Evidence-Regel

Kein Ticket ist fertig ohne Evidence. Evidence kann klein sein, muss aber überprüfbar sein.

Beispiele:

- Build-Log-Ende
- Testergebnis
- Lint-Ergebnis
- Simulator-Screenshot
- Web-Preview-Screenshot
- Datei-/Diff-Zusammenfassung
- sauber dokumentierte Blockade mit Ursache
- Rohoutput bei Xcode-, Simulator-, Browser- oder Build-Validierung

Wenn `Subagents: REQUIRED`, muss die Evidence zusätzlich nennen, welche Subagents gestartet wurden, was sie gefunden haben und welche Findings die Umsetzung beeinflusst haben.

Wenn ein erforderlicher Subagent `subagent_timeout`, `subagent_no_result` oder `subagent_blocked` hat, muss die Evidence die Recovery, die degraded-mode-Entscheidung oder den `BLOCKED`-Stop, die Ersatzanalyse und das Restrisiko dokumentieren.

Wenn Attempt Budget & Escalation greift, muss die Evidence die verwendeten Versuche, den letzten fehlgeschlagenen Check oder Review-Punkt, die Failure Classification, die vermutete Ursache und die empfohlene nächste Prüf- oder Entscheidungsinstanz nennen.

## Closeout-Regel

Closeout is task local.

Was im Closeout zwingend passieren soll, muss im Ticket oder im konkreten Codex-Prompt stehen. Globale Contracts liefern Standardstruktur, aber keine impliziten Spezialpflichten.

Standard-Closeout-Ziel für PR-basierte Arbeit ist der PR Body. PR-Kommentare sind Ergaenzung oder Fallback, wenn der PR Body technisch nicht sinnvoll aktualisierbar ist oder zusaetzliche Evidence/Notes noetig sind.

Ein Review darf NEEDS-FIX setzen, wenn relevante Closeout-Pflichten nur verstreut in Kommentaren stehen und nicht im PR Body auffindbar oder verlinkt sind.

Keine Spezialanforderung darf nur unausgesprochen aus `AGENTS.md`, Skills oder allgemeinen Methoden-Dokumenten erwartet werden. Wenn ein Review später eine Closeout-Luecke findet, ist das ein Signal, die Ticket- oder Prompt-Anforderung expliziter zu machen.

Wenn `Subagents: REQUIRED`, muss der PR-Closeout die Subagent Summary als Primary Closeout Source enthalten: welche Subagents liefen, was sie fanden und welche Findings die Umsetzung beeinflusst haben.

Wenn die Subagent Failure Policy greift, muss der PR-Closeout auch Failure marker, Recovery, degraded-mode-Entscheidung, Ersatzanalyse und Restrisiko enthalten.

Wenn Attempt Budget & Escalation greift, muss der PR-Closeout die Attempt-Budget-Evidence als Primary Closeout Source enthalten. Ein weiterer Codex-Fix ohne diese Einordnung ist nicht grüner Green Path, sondern ein unklassifizierter Retry.

## Vault Impact Contract

Jeder PR-Closeout muss eine `Vault Impact`-Sektion enthalten. Diese Sektion ist der kanonische Contract; andere Templates sollen sie verwenden oder auf diese Sektion verweisen, aber keine abweichende Regel definieren.

```markdown
## Vault Impact
- Vault update required: YES | NO
- Area: Decision | Non-goal | Risk | Roadmap | UX/Brand | Architecture | Lesson | Method
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:
```

Regeln:

- `Vault update required: NO` gilt für rein lokale Implementierungs-, Test-, Format-, Refactor- oder Hygiene-Aenderungen ohne strategische, produktbezogene, architektonische oder methodische Aussage.
- `Vault update required: YES` gilt, wenn ein PR Strategie, Produktwahrheit, Architektur-Richtung, Nicht-Ziele, Risiken, Roadmap, UX-/Brand-Regeln, Lessons Learned oder AI-Betriebssystem-Methode veraendert oder klaert.
- Bei `YES` erstellt der PR-Closeout einen Vault Update Candidate: Area, Grund, vorgeschlagene Ziel-Datei, exakter Markdown-Vorschlag und Source Evidence mit Issue-/PR-/Review-/Commit-Link.
- Agenten dürfen den AI Vault nicht direkt verändern, ausser das Issue erlaubt es ausdRücklich. Ohne diese ausdRückliche Erlaubnis bleibt der Candidate Human Gate.
- GitHub bleibt operative Wahrheit für Arbeit, Status, Evidence und Review. Der AI Vault bleibt strategisches und produktbezogenes Gedächtnis; er ist kein operatives Taskboard.
- Wenn die passende Vault-Datei unbekannt ist, bleibt `Suggested target file` konkret soweit moeglich und markiert die Unsicherheit im `Reason`; der Candidate darf nicht erfunden oder als bereits eingetragen behauptet werden.

## Harness Failure Classification

Wenn ein Lauf scheitert oder nicht sauber abgeschlossen werden kann, wird der Harness-Fehler klassifiziert:

- `none`
- `missing_context`
- `stale_context`
- `missing_tool`
- `missing_verifier`
- `weak_guardrail`
- `unclear_spec`
- `model_limitation`

Diese Klassifikation beantwortet nicht nur, dass etwas scheiterte, sondern warum der Harness verbessert werden muss.

## Closeout-Format

```markdown
## Closeout

Status: done | partial | blocked

### Erledigt
- ...

### Validierung
- Befehl/Ablauf: ...
- Ergebnis: ...

### Evidence
- ...

### Vault Impact
- Vault update required: YES | NO
- Area: Decision | Non-goal | Risk | Roadmap | UX/Brand | Architecture | Lesson | Method
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:

### Subagent Summary
Nur erforderlich, wenn `Subagents: REQUIRED`.

- Which subagents ran:
- What each subagent found:
- Which findings changed implementation:
- Failure marker: none | subagent_timeout | subagent_no_result | subagent_blocked
- Recovery attempted:
- Degraded mode used: yes | no
- Why degraded continuation was safe:
- Replacement Evidence / Builder reconstruction:

### Attempt Budget & Escalation
Nur erforderlich, wenn das Ticket wiederholte Fix-, Review- oder Loop-Arbeit erwartet oder ein Budget erschoepft wurde.

- Attempt budget:
- Attempts used:
- Last failed check/review point:
- Failure classification:
- Suspected root cause:
- Next action: continue | needs-fix | blocked | human decision | reviewer recommendation
- Recommended next reviewer:
- Operator extension granted: yes/no + by whom/where

### Offen / Risiken
- ...

### Harness Failure Classification
- none | missing_context | stale_context | missing_tool | missing_verifier | weak_guardrail | unclear_spec | model_limitation

### Operator Summary
- What changed:
- Validation:
- Evidence:
- Risk lane: low | standard | protected | release
- Auto-merge candidate: yes | no
- Human decision required: yes | no
- Claude Code Review Suggested: yes | no
- Reason:

### Review Recommendation
- Recommended reviewer: Codex | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason:
- Review ticket suggested: yes | no
- Review ticket created: yes | no
- Review ticket URL:
- Auto-merge blocked until review: yes | no

### Nächster Schritt
- ...
```
