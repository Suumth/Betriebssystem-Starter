# GitHub Issue Task Template

## Agent Contract

Mode: EXECUTING | GRILLING | COORDINATING
Autonomy: prototype | standard | production
Risk lane: low | standard | protected | release
Overnight-fähig: yes/no — Begründung: verifier nachts lauffähig? entscheidungsfrei? klein genug? risk <= standard? keine Protected-/Release-Codearbeit?

## Execution Mode

Subagents: NOT_REQUIRED | REQUIRED

If REQUIRED:
- why subagents are needed
- which subagents Codex must start
- whether they are read-only or may prepare separated edits
- whether Codex must wait for all results
- what Subagent Failure Policy applies if a subagent stalls or returns no usable result
- where the results and any degraded-mode decision must be documented

## Goal

Beschreibe das gewünschte Ergebnis in einem klaren Satz.

## Context

- Repo/path:
- Related issue/PR/doc:
- Source-of-truth files:
- Known risky areas:

Mode-Hinweis:

- `EXECUTING`: Entscheidung ist getroffen, Agent darf bauen.
- `GRILLING`: Entscheidung/Begriff/Scope ist unklar, Agent darf nicht bauen; erst klären.
- `COORDINATING`: größere Arbeit braucht Synthese/Subagent-/Teilprüfungsbedarf.

Execution-Mode-Hinweis:

- `Subagents: NOT_REQUIRED`: Das Ticket verlangt keinen Subagent-Lauf.
- `Subagents: REQUIRED`: Codex muss vor der Umsetzung die konkret genannten Subagents starten. Eine reine Erlaubnis wie "Codex darf Subagents nutzen" reicht nicht.
- `Subagents: REQUIRED` heisst nicht endlos warten: Codex muss bei einem hängenden oder unbrauchbaren Subagent einmal Recovery versuchen und danach entweder mit Evidence in degraded mode fortfahren oder mit `BLOCKED` stoppen.
- Subagents sind interne Codex-Ausführungshelfer, keine sichtbaren PM-, Operator- oder Review-of-Record-Rollen.

## Boundary

- Allowed changes:
- Do not touch:
- Public/external actions require approval: yes/no
- Protected path / Denylist handling:
  - Does this touch `.env`, credentials, auth, payments, billing, deployment, migration, signing, release, app-store or publication surfaces? yes/no
  - If yes: explicit permission, Risk lane, validation and Human Gate required per `contracts/protected-path-denylist.md`.

## Skills

Welche Kontextregeln gelten?

Beispiele:

- Web Preview
- iOS Simulator
- macOS App
- Xcode 27
- Documentation
- Marketing Copy

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

## Subagent Failure Policy

Only required when `Subagents: REQUIRED`.

- Recovery attempted: yes/no + summary
- Subagent result marker: none | subagent_timeout | subagent_no_result | subagent_blocked
- Degraded mode used: yes/no
- Why degraded continuation was safe:
- Replacement Evidence / Builder reconstruction:
- Unsafe to continue -> BLOCKED: yes/no + reason

Degraded mode is allowed only when the missing subagent was read-only, the Builder can safely reconstruct the analysis, and the missing result is not a critical, non-reconstructable risk check.

## Acceptance Criteria

- [ ] Kriterium 1 ist konkret prüfbar.
- [ ] Kriterium 2 nennt erwartetes Ergebnis.
- [ ] Kriterium 3 vermeidet Bauchgefühl.

## Verification

- Required command/check:
- UI/browser/simulator proof:
- Evidence artifact expected:

## Attempt Budget & Escalation

Only required when the ticket expects repeated fix, review or loop work.
Use `contracts/run-budget-kill-switch.md` for run-wide limits, stop conditions and operator kill actions.

- Run Budget and Kill Switch reference:
- Max issues per run:
- Max fix attempts per PR/item:
- Attempt budget:
- Attempts used:
- Last failed check/review point:
- Failure classification:
- Suspected root cause:
- Next action: continue | needs-fix | blocked | human decision | reviewer recommendation
- Recommended next reviewer:
- Operator extension granted: yes/no + by whom/where

Default caps, unless the ticket narrows them:

- Builder self-fix before PR: max 1.
- Automated `needs-fix` cycles on the same PR: max 2 unless the Operator explicitly extends.
- Exhausted budget requires Evidence and a recommendation, not automatic Claude Code fallback.

## Evidence

Welche Nachweise müssen in PR oder Issue?

- Build-Log-Ende oder Rohoutput
- Testergebnis
- Screenshot / Preview / Simulator-Artefakt
- Diff-Zusammenfassung
- Fehlerklassifikation, falls blockiert
- Wenn `Subagents: REQUIRED`: gestartete Subagents, Befunde und umsetzungsrelevante Entscheidungen
- Wenn Subagent Failure Policy greift: `subagent_timeout`, `subagent_no_result` oder `subagent_blocked`, Recovery, degraded-mode-Entscheidung, Ersatzanalyse und Restrisiko
- Wenn Attempt Budget & Escalation greift: verwendete Versuche, letzter fehlgeschlagener Check/Review-Punkt, Failure Classification, vermutete Ursache und empfohlene nächste Prüf- oder Entscheidungsinstanz

## Closeout Requirements

Codex muss vor Abschluss den PR Body als Primary Closeout Source aktualisieren. Review of Record muss dort primär finden können:

- Summary
- Changed Files
- Validation
- Evidence
- Subagent Evidence Capsule, wenn `Subagents: REQUIRED`
- Subagent Failure Policy Evidence, wenn Recovery, degraded mode oder `BLOCKED` genutzt wurde
- Attempt Budget & Escalation inklusive Run Budget and Kill Switch, wenn wiederholte Fix-/Review-/Loop-Arbeit erwartet wurde oder ein Budget erschöpft ist
- Vault Impact nach `contracts/ticket-contract.md#vault-impact-contract`
- Closeout
- Operator Summary
- Review Recommendation
- Harness Failure Classification

Fallback/Ergänzung: Ein PR-Kommentar ist nur erlaubt, wenn der PR Body technisch nicht sinnvoll aktualisierbar ist oder wenn zusätzliche Evidence/Notes ergänzt werden müssen. Wenn ein PR-Kommentar wichtige Closeout-Information enthält, muss der PR Body kurz darauf verweisen.

Wenn dieses Ticket besondere Closeout-Pflichten hat, müssen sie hier explizit stehen. Globale Contracts, Skills oder `AGENTS.md` liefern Struktur und Erinnerung, ersetzen aber keine task lokalen Spezialanforderungen.

Builder-Regeln:

- Codex darf als Builder nicht `needs-human`, `review:pass` oder `auto-merge:ok` setzen.
- Bei NEEDS-FIX-Follow-up arbeitet Codex auf demselben Branch/PR weiter und erstellt keinen neuen Parallel-PR.
- `needs-fix` bleibt stehen, bis Review of Record es entfernt.

## Closeout

Am Ende dokumentieren:

- What changed
- What was verified
- Evidence
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
  - Degraded mode used: yes | no
  - Why degraded continuation was safe:
  - Replacement Evidence / Builder reconstruction:
  - Remaining risk:
- Attempt budget, attempts used, last failed check/review point, failure classification and next recommended reviewer, wenn Attempt Budget & Escalation greift
- Run Budget and Kill Switch evidence, wenn run-weite Limits, stop conditions oder operator kill actions genutzt wurden
- Remaining risk
- Follow-up needed
- Harness failure classification
- Operator Summary
- Review Recommendation

Erlaubte Harness Failure Classification:

- `none`
- `missing_context`
- `stale_context`
- `missing_tool`
- `missing_verifier`
- `weak_guardrail`
- `unclear_spec`
- `model_limitation`

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

## Stop condition

Stop if context, boundary, tool, verifier, product decision, safe degraded-mode evidence or exhausted-attempt-budget evidence is missing.

## Label vor Start

Nur setzen, wenn das Ticket reif ist: `agent:ready`.
