# Project Operating Rules Template

Diese Datei enthält die ausführliche Vorlage für Projekt-Repos. Der Inhalt kann in die jeweilige `AGENTS.md` des Ziel-Repos übernommen werden.

## Operating Principle

GitHub is the operational source of truth for execution. Relevant context lives in Issues, PRs, comments, labels, repository files and the project-level AGENTS file.

The project-level `AGENTS.md` is the Root Agent Index, not a knowledge base. It should stay thin and point to longer details with `read when ...` rules.

This repo can use Agent Substrate: shared terms, Agent Modes, skill patterns and a Loading Map for optional repo-local docs.

## Loading Map

Add only the entries the target repo needs:

- read `docs/agents/glossary.md` when terms, labels, Agent Modes or roles are unclear
- read `docs/agents/verification.md` when validation, Evidence or artifacts are unclear
- read `docs/agents/protected-areas.md` when Risk lane is `protected` or `release`
- read `docs/adr/*.md` when an architectural decision is touched
- Apple-platform repos may add: read the AI-OS Xcode 27 skill note when a task touches SwiftUI, Xcode, iOS/macOS builds, simulators, device testing, StoreKit, Live Activity, Widget, Watch or Apple-platform QA

These docs are optional. Do not create them as mandatory overhead for small repos.

## Ticket Maturity

A ticket is ready only when success can be proven by validation and evidence:

- Agent Mode is explicit: `EXECUTING`, `GRILLING` or `COORDINATING`
- Execution Mode is explicit: `Subagents: NOT_REQUIRED` or `Subagents: REQUIRED`
- Autonomy is explicit: `prototype`, `standard` or `production`
- Risk lane is explicit: `low`, `standard`, `protected` or `release`
- clear goal
- limited scope
- explicit non-goals
- testable acceptance criteria
- concrete validation
- required evidence

## Agent Modes

- `EXECUTING`: decision is made; the agent may build.
- `GRILLING`: decision, term or scope is unclear; the agent must clarify before building.
- `COORDINATING`: larger work needs synthesis, subagent-style checks or partial reviews before execution.

## Execution Mode Rules

- `Subagents: NOT_REQUIRED`: work as a single Builder run.
- `Subagents: REQUIRED`: start the requested internal subagents before implementation and summarize findings in the PR closeout.

If a required subagent stalls, times out or returns no usable result, apply the Subagent Failure Policy:

1. Attempt one targeted recovery.
2. Request a checkpoint summary or re-prompt the same bounded task.
3. If no usable result arrives after one additional check cycle, mark `subagent_timeout`, `subagent_no_result` or `subagent_blocked`.
4. Continue in degraded mode only when the missing subagent was read-only, the Builder can reconstruct the analysis, no critical non-reconstructable risk check is missing and replacement Evidence is documented.
5. Otherwise stop with `BLOCKED`.

The PR closeout must document the failure marker, recovery attempt, degraded/block decision, replacement Evidence and remaining risk.

## Skill Patterns

Use these as work patterns, not as required new agents:

- `plan-then-implement`
- `grill-with-docs`
- `simplify-pass`
- `cross-system-audit`

## Builder Flow

1. Read the full issue.
2. Reuse an existing branch or PR for the same issue when available.
3. Work inside the documented scope.
4. Run the validation from the issue.
5. Add evidence to the PR or issue.
6. Add `Vault Impact` according to `contracts/ticket-contract.md#vault-impact-contract`.
7. Add a closeout with done, validation, evidence, Vault Impact, open items and next step.

## Review Flow

1. Review the PR against the linked issue.
2. Check each acceptance criterion.
3. Check validation and evidence.
4. Check `Vault Impact`; no PASS if the section is missing, if `YES` lacks a concrete Vault Update Candidate, or if the PR implies direct AI Vault mutation without explicit issue permission.
5. If `Subagents: REQUIRED`, check subagent findings and any Subagent Failure Policy Evidence.
6. Choose one outcome: PASS, NEEDS-FIX or BLOCKED.

## Status Labels

- `agent:ready`: ticket may be started
- `agent:running`: work exists or should be resumed
- `needs-fix`: same PR needs follow-up work
- `needs-human`: human decision needed
- `blocked`: external decision or prerequisite missing

## Evidence

Every PR should include:

- summary
- changed files
- validation command or flow
- validation result
- evidence artifact or log excerpt
- Vault Impact
- known risks

When `Subagents: REQUIRED`, evidence should also include subagent findings and any `subagent_timeout`, `subagent_no_result`, `subagent_blocked` or degraded mode decision.

## Repo-specific Additions

Add only what is needed for the target repo:

- build command
- test command
- preview command
- simulator/device notes
- release restrictions
- product-specific tone or safety notes
- Apple/Xcode project skill loading:
  - Cloud-KI entrypoint: GitHub URL of the repo-facing AI-OS Xcode 27 skill note.
  - Local Codex fallback/reference only: local Xcode 27 reference folder, if present.
  - Do not require Xcode 27 skills for non-Apple work.
  - Do not treat Xcode 27 skills as subagents, labels, runners or proof of validation.
