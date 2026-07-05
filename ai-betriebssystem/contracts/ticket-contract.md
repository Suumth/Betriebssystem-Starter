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

Der Contract kennt zwei Umfangsklassen. Beide erfüllen die Maturity Rule; sie unterscheiden sich nur darin, welche Blöcke ausgeschrieben werden müssen.

| Tier | Wann | Template |
|---|---|---|
| Light | Risk lane `low`, Mode `EXECUTING`, `Subagents: NOT_REQUIRED`, keine wiederholte Fix-/Review-/Loop-Arbeit erwartet, eine Oberfläche, keine Protected Area/Release/externe Aktion | `templates/github_issue_task_low_risk.md` |
| Full | alles andere | `templates/github_issue_task.md` |

Low Risk Tickets lassen Execution-Mode-Details, Codex Subagent Instruction, Subagent Failure Policy und Attempt Budget & Escalation weg, weil deren Auslöser per Definition nicht vorliegen. Goal, Context, Boundary, Acceptance Criteria, Verification, Evidence, Vault Impact, Closeout mit Operator Summary und Stop-Bedingung bleiben Pflicht.

Kippt während der Arbeit ein Light-Kriterium (Risiko steigt, Scope wächst, Fix-Schleife beginnt, zweite Oberfläche nötig), stoppt der Builder und das Ticket wird auf Full nachgeschärft. Ein Light Ticket ist keine Abkürzung an Evidence, Vault Impact oder Review of Record vorbei.

## Optionale Traceability-Felder

Planner- oder Epic-Lead-Wellen dürfen Ticket-Bodies mit zwei optionalen
Traceability-Feldern ergänzen:

```markdown
Planned-by: <Plan Issue, Goal Issue oder Epic>
Wave: <freigegebene Wave oder Plan-Abschnitt>
```

`Planned-by:` verweist auf das Plan Issue, Goal Issue oder Epic, aus dem das
Ticket geschnitten wurde. `Wave:` benennt die freigegebene Wave oder den
Plan-Abschnitt, in dem das Ticket ausgeführt wird.

Diese Felder dienen nur der Rückverfolgbarkeit. Sie sind keine zweite Wahrheit
neben GitHub-Issue, Branch und PR, erzeugen keine neuen Labels und starten,
releasen oder genehmigen keine Arbeit automatisch. Sie ersetzen insbesondere
kein `agent:ready`, keine Operator-Freigabe, keinen Review of Record und keine
Merge-Freigabe.

Bestehende Tickets bleiben rückwärtskompatibel: Fehlen `Planned-by:` oder
`Wave:`, ist das allein kein Contract-Verstoß. Die Ticket Maturity Rule bleibt
unverändert vollständig maßgeblich; ein Ticket ohne klares Ziel, Boundary,
Verification, Evidence, Closeout, Operator Summary, Review Recommendation oder
Stop-Bedingung wird durch Traceability-Felder nicht reif.

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
- Subagent Evidence Capsule, wenn `Subagents: REQUIRED`:
  - Which subagents ran:
  - Explorer findings:
  - Test/Validation findings:
  - Risk findings:
  - Findings used by Builder:
  - Findings out of scope or blocked:
  - Failure marker: none | subagent_timeout | subagent_no_result | subagent_blocked
  - Recovery attempted:
  - Degraded mode used: yes/no
  - Why degraded continuation was safe:
  - Replacement Evidence / Builder reconstruction:
  - Remaining risk:
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
- welche Subagent Failure Policy bei hängenden oder nicht liefernden Subagents gilt
- wo die Ergebnisse dokumentiert werden müssen

Subagents sind interne Codex-Ausführungshelfer. Sie sind keine sichtbaren PM-, Operator- oder Review-of-Record-Rollen, setzen keine Workflow-Labels und ersetzen keine menschliche Entscheidung.

## Attempt Budget & Escalation

Attempt Budget & Escalation verhindert endlose Fix-, Review- und Retry-Loops. Es ist kein Budgetfile, kein Runner und kein neues Statusmodell.

Run-weite Limits, operator kill actions und stop conditions stehen im separaten `contracts/run-budget-kill-switch.md`. Ticket-lokale Attempt-Felder bleiben die knappe Closeout-Evidence fuer wiederholte Fix-, Review- oder Loop-Arbeit.

Default-Regeln:

- Builder self-fix before PR: max 1.
- Automated `needs-fix` cycles on the same PR: max 2 unless the Operator explicitly extends.
- Subagent failure recovery stays governed by the Subagent Failure Policy: one targeted recovery, then degraded-with-Evidence or `BLOCKED`.
- Normal implementation steps, a first validation run, PR closeout edits, post-merge hygiene and Green Path next-ticket selection are not counted as attempts.

Wenn ein Attempt Budget erschöpft ist oder derselbe Fehler wiederkehrt, muss Codex vor einem weiteren Fix klassifizieren und dokumentieren:

- failure classification;
- last failed check or review point;
- suspected root cause;
- attempts used;
- recommended next reviewer or human decision;
- whether the Operator explicitly extended the budget.

Escalation bedeutet Evidence und Empfehlung, nicht automatische Claude-Code-Nutzung. Claude Code bleibt nur eine Empfehlung mit Human Gate.

Low-risk documentation work must not be burdened with mandatory heavy loop fields unless the ticket itself repeated work, fix cycles or escalation risk expects.

## Stagnation Escalation

Stagnation means a fix, review or validation loop is no longer learning from evidence. It is not solved by another blind Codex retry.

Stagnation is triggered when any of these appear:

- the same or materially similar `needs-fix` returns after a retry;
- validation or evidence is missing repeatedly;
- the same Harness Failure Classification repeats;
- a fix attempt fails and the suspected root cause is still unclear.

When Stagnation appears, Codex must fill Attempt Budget & Escalation evidence before any further fix:

- Attempts used:
- Last failed check/review point:
- Harness Failure Classification:
- Suspected root cause:
- Why another Codex fix is or is not justified:
- Next action: continue | needs-fix | blocked | human decision | review ticket | learning candidate

Required response:

- small mechanical gap: one more targeted fix is allowed if the evidence names the gap and verifier;
- unclear or repeated issue: create or suggest a review ticket;
- method or rule failure: create or suggest a Harness Learning Candidate;
- external, product, protected-path or safety decision: use `needs-human` or `blocked`.

Stagnation preserves GitHub as the operational source of truth. Review tickets, blocked decisions and Harness Learning Candidates must be documented in GitHub evidence. Human Gate stays required for protected decisions and for activating any method/rule change.

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

## Subagent Evidence Capsule

If `Subagents: REQUIRED`, the PR closeout must contain a fixed `Subagent Evidence Capsule` as reviewable GitHub evidence.

The capsule is mandatory because Review of Record must be able to evaluate subagent use without reading local chats or hidden context. Subagents remain advisory and read-only unless the ticket explicitly allows more; they do not mutate the repo, Vault or GitHub state independently.

Required fields:

- Which subagents ran:
- Explorer findings:
- Test/Validation findings:
- Risk findings:
- Findings used by Builder:
- Findings out of scope or blocked:
- Failure marker: none | subagent_timeout | subagent_no_result | subagent_blocked
- Recovery attempted:
- Degraded mode used: yes | no
- Why degraded continuation was safe:
- Replacement Evidence / Builder reconstruction:
- Remaining risk:

Explorer findings cover context discovery, scope boundaries and relevant source-of-truth files.
Test/Validation findings cover checks run or proposed, verifier gaps and any validation limits.
Risk findings cover safety, data, release, product, Vault, protected-path or contract risks.

If a required subagent returns `subagent_timeout`, `subagent_no_result` or `subagent_blocked`, the capsule must show the recovery attempt, replacement evidence, degraded-mode justification and remaining risk. If that evidence is missing or unsafe, Codex must stop with `BLOCKED` instead of treating degraded mode as green.

## Agent Modes

| Mode | Bedeutung | Bauregel |
|---|---|---|
| `EXECUTING` | Entscheidung ist getroffen; Ziel, Scope, Verifier und Evidence sind klar | Agent darf bauen |
| `GRILLING` | Entscheidung, Begriff, Scope oder Ziel ist unklar | Agent darf nicht bauen; erst klären oder Entscheidungsvorlage schreiben |
| `COORDINATING` | größere Arbeit braucht Synthese, Subagent-/Teilprüfung oder mehrere Quellen | Agent koordiniert, schneidet und prüft; Umsetzung erst in klarer EXECUTING-Box |

`Autonomy` beschreibt, wie eigenständig der Agent innerhalb der Boundary handeln darf. `Risk lane` bestimmt Review-Schärfe und Evidence-Tiefe. `Execution Mode` ist davon getrennt: Auch ein `EXECUTING`-Ticket kann `Subagents: REQUIRED` setzen, wenn die Umsetzung vorab interne Codex-Teilprüfungen braucht.

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

`auto-merge:ok` bedeutet nur dann Grün, wenn ein Review of Record PASS vorliegt,
die separate Operator-/Human-Gate-Freigabe dokumentiert ist, keine gelben oder
roten Labels gesetzt sind und die Operator Summary `Human decision required: no`
ausweist.

## Teilprojekt- / Milestone-Regel

Produktwirksame `agent:ready`-Tickets brauchen einen GitHub Milestone. Der
Milestone modelliert das Teilprojekt im Projekt-Repo.

Ein Ticket ohne Milestone ist nur reif, wenn es ausdrücklich als nicht
teilprojektbezogen begründet ist:

- `meta`;
- `repo-hygiene`;
- reine Dokumentation ohne Produktversprechen;
- Tooling ohne Teilprojektbezug;
- Methoden- oder Templatepflege ohne Produktartefakt.

Ein fehlender Milestone bei produktwirksamen Tickets ist ein Reifeproblem im
Ticket Contract, kein Generatorproblem. Codex soll das als `unclear_spec` oder
`missing_context` klassifizieren, statt das Ticket in einem Lagebild künstlich
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

Wenn `Subagents: REQUIRED`, muss die Evidence zusätzlich eine `Subagent Evidence Capsule` enthalten, die Explorer findings, Test/Validation findings, Risk findings, Findings used by Builder und Findings out of scope or blocked getrennt nennt.

Wenn ein erforderlicher Subagent `subagent_timeout`, `subagent_no_result` oder `subagent_blocked` hat, muss die Capsule die Recovery, die degraded-mode-Entscheidung oder den `BLOCKED`-Stop, die Ersatzanalyse und das Restrisiko dokumentieren.

Wenn Attempt Budget & Escalation greift, muss die Evidence die verwendeten Versuche, den letzten fehlgeschlagenen Check oder Review-Punkt, die Failure Classification, die vermutete Ursache und die empfohlene nächste Prüf- oder Entscheidungsinstanz nennen.

## Closeout-Regel

Closeout is task local.

Was im Closeout zwingend passieren soll, muss im Ticket oder im konkreten Codex-Prompt stehen. Globale Contracts liefern Standardstruktur, aber keine impliziten Spezialpflichten.

Standard-Closeout-Ziel für PR-basierte Arbeit ist der PR Body. PR-Kommentare sind Ergänzung oder Fallback, wenn der PR Body technisch nicht sinnvoll aktualisierbar ist oder zusätzliche Evidence/Notes nötig sind.

Ein Review darf NEEDS-FIX setzen, wenn relevante Closeout-Pflichten nur verstreut in Kommentaren stehen und nicht im PR Body auffindbar oder verlinkt sind.

Keine Spezialanforderung darf nur unausgesprochen aus `AGENTS.md`, Skills oder allgemeinen Methoden-Dokumenten erwartet werden. Wenn ein Review später eine Closeout-Lücke findet, ist das ein Signal, die Ticket- oder Prompt-Anforderung expliziter zu machen.

Wenn `Subagents: REQUIRED`, muss der PR-Closeout die `Subagent Evidence Capsule` als Primary Closeout Source enthalten: welche Subagents liefen, welche Explorer-, Test/Validation- und Risk-Befunde entstanden, welche Findings die Umsetzung beeinflusst haben und welche Findings out of scope oder blocked waren.

Wenn die Subagent Failure Policy greift, muss die Capsule auch Failure marker, Recovery, degraded-mode-Entscheidung, Ersatzanalyse und Restrisiko enthalten.

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

- `Vault update required: NO` gilt für rein lokale Implementierungs-, Test-, Format-, Refactor- oder Hygiene-Änderungen ohne strategische, produktbezogene, architektonische oder methodische Aussage.
- `Vault update required: YES` gilt, wenn ein PR Strategie, Produktwahrheit, Architektur-Richtung, Nicht-Ziele, Risiken, Roadmap, UX-/Brand-Regeln, Lessons Learned oder AI-Betriebssystem-Methode verändert oder klärt.
- Bei `YES` erstellt der PR-Closeout einen Vault Update Candidate: Area, Grund, vorgeschlagene Ziel-Datei, exakter Markdown-Vorschlag und Source Evidence mit Issue-/PR-/Review-/Commit-Link.
- Agenten dürfen den AI Vault nicht direkt verändern, außer das Issue erlaubt es ausdrücklich. Ohne diese ausdrückliche Erlaubnis bleibt der Candidate Human Gate.
- GitHub bleibt operative Wahrheit für Arbeit, Status, Evidence und Review. Der AI Vault bleibt strategisches und produktbezogenes Gedächtnis; er ist kein operatives Taskboard.
- Wenn die passende Vault-Datei unbekannt ist, bleibt `Suggested target file` konkret soweit möglich und markiert die Unsicherheit im `Reason`; der Candidate darf nicht erfunden oder als bereits eingetragen behauptet werden.

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

## Harness Learning Candidate

Ein `Harness Learning Candidate` ist der sichere Weg, aus wiederholten
Harness-Fehlern eine mögliche Regel-, Template-, Skill- oder Doku-Anpassung zu
machen. Er ist kein automatischer Lernspeicher und keine aktive Policy.

Codex soll einen Learning Candidate vorschlagen oder als Issue/PR-Teil
dokumentieren, wenn wiederholte Evidence eines dieser Muster zeigt:

- dieselbe Harness Failure Classification wiederholt sich;
- Verifier oder Evidence fehlen wiederholt;
- stale context verursacht wiederholt Nacharbeit;
- ein unclear-spec-Muster wiederholt sich über mehrere Tickets;
- eine Modell- oder Tool-Grenze braucht eine Methodenregel.

Pflichtfelder:

- Claim / Lesson;
- Evidence Source;
- Confidence: 1-5;
- Scope: repo | method | product | release | review;
- Applies To;
- Proposed Target: AGENTS.md | contract | template | skill | docs | Vault update candidate;
- Proposed Update;
- Human Gate required: yes;
- Non-goal: candidate is not active policy until merged.

Der Candidate lebt in GitHub und wird erst nach normalem Issue oder PR, Review
of Record und Merge operativ. Lokale Logs, Chatnotizen oder Vault-Notizen sind
nur Quell-Evidence; sie sind keine zweite operative Wahrheit. Vault-Änderungen
bleiben Vault Impact Candidates, außer das Ticket erlaubt direkte Vault-Edits
ausdrücklich.

Template: `templates/harness-learning-candidate.md`.

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

### Subagent Evidence Capsule
Nur erforderlich, wenn `Subagents: REQUIRED`.

- Which subagents ran:
- Explorer findings:
- Test/Validation findings:
- Risk findings:
- Findings used by Builder:
- Findings out of scope or blocked:
- Failure marker: none | subagent_timeout | subagent_no_result | subagent_blocked
- Recovery attempted:
- Degraded mode used: yes | no
- Why degraded continuation was safe:
- Replacement Evidence / Builder reconstruction:
- Remaining risk:

### Attempt Budget & Escalation
Nur erforderlich, wenn das Ticket wiederholte Fix-, Review- oder Loop-Arbeit erwartet oder ein Budget erschöpft wurde.

- Run Budget and Kill Switch reference: `contracts/run-budget-kill-switch.md`
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
