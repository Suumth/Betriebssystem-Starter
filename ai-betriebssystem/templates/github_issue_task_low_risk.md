# GitHub Issue Task Template (Light)

Fuer kleine, risikoarme Tickets. Der Ticket Contract gilt weiter, aber ohne schwere Loop-Felder.

Nur verwenden, wenn ALLE Kriterien gelten:

- Risk lane: `low`
- Mode: `EXECUTING`
- `Subagents: NOT_REQUIRED`
- keine wiederholte Fix-, Review- oder Loop-Arbeit erwartet
- eine Oberflaeche (z. B. nur Docs, nur ein Modul)
- keine Protected Area, kein Release, keine externe Aktion

Wenn eines nicht gilt oder waehrend der Arbeit eintritt: auf das volle Template
`templates/github_issue_task.md` wechseln bzw. stoppen und das Ticket nachschaerfen.

---

## Agent Contract

Mode: EXECUTING
Autonomy: prototype | standard
Risk lane: low
Subagents: NOT_REQUIRED

## Goal

Ein klarer Satz.

## Context

- Repo/path:
- Source-of-truth files:

## Boundary

- Allowed changes:
- Do not touch:

## Acceptance Criteria

- [ ] Kriterium 1 ist konkret pruefbar.
- [ ] Kriterium 2 nennt erwartetes Ergebnis.

## Verification

- Required command/check:
- Evidence artifact expected:

## Closeout

PR Body als Primary Closeout Source mit:

- What changed:
- Validation:
- Evidence:
- Vault Impact:
  - Vault update required: YES | NO
  - Area: Decision | Non-goal | Risk | Roadmap | UX/Brand | Architecture | Lesson | Method
  - Reason:
  - Suggested target file:
  - Proposed Markdown update:
  - Source evidence:
- Remaining risk:
- Operator Summary:
  - Auto-merge candidate: yes | no
  - Human decision required: yes | no
- Harness failure classification: none | missing_context | stale_context | missing_tool | missing_verifier | weak_guardrail | unclear_spec | model_limitation

Light Tickets umgehen keine Evidence, kein Vault Impact und keinen Review of Record. Builder-Regeln unveraendert: kein `needs-human`, `review:pass` oder `auto-merge:ok` durch den Builder; bei NEEDS-FIX am selben Branch/PR weiterarbeiten.

## Stop condition

Stop, wenn Kontext, Boundary, Tool, Verifier oder eine Produktentscheidung fehlt — oder wenn ein Light-Kriterium kippt (Risiko, Scope-Wachstum, zweite Oberflaeche, Fix-Schleife).

## Label vor Start

Nur setzen, wenn das Ticket reif ist: `agent:ready`.
