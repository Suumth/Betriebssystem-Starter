# AGENTS.md Template

Copy this file into a project repository as `AGENTS.md` and add repo-specific build, test and preview commands.

## Operating Principle

GitHub is the operational source of truth for execution.

This repository uses an Agent Work Harness. The agent is not the system; the harness is the system around the agent: instructions, tools, boundaries, verification, evidence, closeout and human gates.

This `AGENTS.md` is the Root Agent Index, not a knowledge base. Keep it short. Put longer details in repo files and link them with `read when ...` rules.

The repository also uses Agent Substrate: shared terms, Agent Modes, reusable skill patterns and a Loading Map for repo-local docs.

## Loading Map

Read only the detail docs relevant to the task:

- read `docs/agents/glossary.md` when a term, label, Agent Mode or role is unclear
- read `docs/agents/verification.md` when validation, artifacts or Evidence are unclear
- read `docs/agents/protected-areas.md` when Risk lane is `protected` or `release`
- read `docs/adr/*.md` when a task touches an architectural decision
- for Apple-platform repos only, read the repo-local or GitHub-reachable Xcode 27 skill note when a task touches SwiftUI, Xcode, iOS/macOS builds, simulators, device testing, StoreKit, Live Activity, Widget, Watch or Apple-platform QA

These files are optional. Do not create them as overhead unless the repo actually needs them.

## Overnight Operations Mode

If a prompt names an `Overnight Run`, read
`docs/overnight-operations-mode.md` before selecting or editing issues.

Night rules:

- no merge at night
- no Protected-/Release-Code-PRs at night
- only work issues with `agent:ready` + `overnight:approved` and an explicit
  evening prompt
- Heartbeats are required
- PRs need Evidence and remain for morning Operator decision

## Ticket Maturity

`agent:ready` means: context, boundary, acceptance criteria, verification, evidence, closeout and stop condition are clear enough that the agent can start without extra prompting.

Every `agent:ready` issue must also define an Execution Mode with `Subagents: NOT_REQUIRED` or `Subagents: REQUIRED`.

## Agent Contract Fields

- Mode: `EXECUTING | GRILLING | COORDINATING`
- Autonomy: `prototype | standard | production`
- Risk lane: `low | standard | protected | release`
- Execution Mode: `Subagents: NOT_REQUIRED | REQUIRED`

## Agent Modes

- `EXECUTING`: decision is made; the agent may build inside the boundary.
- `GRILLING`: decision, term or scope is unclear; the agent must clarify before building.
- `COORDINATING`: larger work needs synthesis, subagent-style checks or multiple partial reviews before execution.

## Execution Mode Rules

Every `agent:ready` issue must define one of:

- `Subagents: NOT_REQUIRED`
- `Subagents: REQUIRED`

If `Subagents: NOT_REQUIRED`, work as a single Builder run.

If `Subagents: REQUIRED`, Codex must explicitly start the requested subagents before implementation. It is not enough to merely know that subagents are allowed.

For REQUIRED tickets, Codex must:

1. Spawn the subagents named in the issue or Builder handoff.
2. Prefer read-only analysis subagents unless the issue explicitly separates write areas.
3. Wait for all required subagents, but do not wait indefinitely.
4. If a required subagent fails, times out or returns unusable output, attempt one targeted recovery by asking for a checkpoint summary or re-prompting the same bounded task.
5. If recovery fails, continue in degraded mode only when the missing subagent was read-only, the Builder can safely reconstruct the analysis, the missing result is not a critical non-reconstructable risk check, and replacement analysis is documented as Evidence.
6. If degraded mode cannot satisfy acceptance criteria, required validation or Evidence, stop explicitly with `BLOCKED`.
7. Consolidate findings before editing.
8. Implement the smallest safe change in the main Builder thread.
9. Include subagent findings, failure marker, recovery attempt, degraded-mode decision, replacement Evidence and remaining risk in the PR closeout.
10. Keep one responsible PR and one evidence trail.

Subagent Result markers:

- `subagent_timeout`
- `subagent_no_result`
- `subagent_blocked`

Subagents are internal execution helpers, not PM roles. They must not create a second source of truth.

If a read-heavy, multi-risk or multi-surface ticket has no Execution Mode block, stop with:

```text
BLOCKED: Execution Mode missing.
```

## Required Labels

- `agent:ready`
- `agent:running`
- `needs-fix`
- `needs-human`
- `blocked`
- `review:pass`
- `auto-merge:ok`

`needs-human` means Auto-Merge is forbidden and an Operator decision is required. `auto-merge:ok` is the only positive Auto-Merge signal.

## Agent Loop

Before editing, act as Critic:

- challenge the task
- identify missing context
- identify risky assumptions
- identify unclear done criteria
- stop if context, boundary or verification is missing

Then act as Builder:

- make the smallest safe change
- stay inside the boundary
- do not broaden the task

Then act as Verifier:

- run the required checks
- do not claim success without evidence
- classify failures instead of hiding them

Then act as Recorder:

- post closeout
- name changed files
- name checks and evidence
- include `Vault Impact` according to `contracts/ticket-contract.md#vault-impact-contract`
- name remaining risk
- classify harness failure if any

## Skill Patterns

Use these as work patterns, not as a zoo of required agents:

- `plan-then-implement`: clarify goal, boundary and verifier before making changes
- `grill-with-docs`: in `GRILLING`, test unclear terms or decisions against repo docs before building
- `simplify-pass`: reduce scope before adding complexity
- `cross-system-audit`: check contracts, templates, prompts and docs against each other when a rule changes

## Builder Summary

Build one issue into one reviewable pull request. Include validation, evidence and closeout.

Codex is the default builder and main work resource. Claude Code is only a recommended premium resource when risk, complexity or tool separation justifies it.

Codex acts as Builder-Orchestrator when the issue requires subagents: it starts the requested internal execution helpers, waits for their results, applies the Subagent Failure Policy when needed, consolidates findings and keeps the implementation in the main Builder thread.

Do not set `needs-human`, `review:pass` or `auto-merge:ok` yourself while acting only as Builder. `review:pass` belongs to Review of Record; `auto-merge:ok` requires separate Operator/Human Gate acceptance.

Every PR closeout must include `Vault Impact`. Use `Vault update required: YES`
when the PR affects strategy, product truth, architecture direction,
non-goals, risks, roadmap, UX/brand guidance, lessons learned or method rules.
Use `NO` for purely local implementation or hygiene changes. If `YES`, propose
a Human-Gate Vault Update Candidate with exact Markdown and source evidence;
do not directly edit the AI Vault unless the issue explicitly allows it.

## Reviewer Summary

Review the pull request against the linked issue. Choose one outcome: PASS, NEEDS-FIX or BLOCKED.

No PASS without evidence. No review without ticket context.

No PASS without a `Vault Impact` section in the PR body or clearly linked PR
evidence. If `Vault update required: YES`, the PR must include a concrete Vault
Update Candidate and must not imply direct AI Vault mutation by an agent without
explicit issue permission.

When `Subagents: REQUIRED`, no PASS if required subagent findings or Subagent Failure Policy evidence are missing from the PR body or clearly linked PR evidence.

PASS can be Grün or Gelb:

- Grün: `review:pass` and merge recommendation; `auto-merge:ok` only after separate Operator/Human Gate acceptance; no `needs-human`, `needs-fix` or `blocked`.
- Gelb: `review:pass` and `needs-human`; Auto-Merge is forbidden until the Operator decides.
- Rot: `needs-fix` or `blocked`; no merge.

## Evidence Summary

Every pull request should include summary, changed files, validation result, evidence, Vault Impact, known risks, Operator Summary and Review Recommendation.

For `Subagents: REQUIRED`, Evidence must include subagent findings and any `subagent_timeout`, `subagent_no_result`, `subagent_blocked` or degraded mode decision.

For Xcode, simulator, browser or build work, prefer raw command output or artifact evidence over summaries.

## Operator Summary

Every PR closeout should include:

- What changed
- Validation
- Evidence
- Risk lane: low | standard | protected | release
- Auto-merge candidate: yes | no
- Human decision required: yes | no
- Claude Code Review Suggested: yes | no
- Reason

## Review Recommendation

Gelb and Rot must recommend the next reviewer instead of leaving the Operator to infer it:

- Recommended reviewer: Codex | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason
- Review ticket suggested: yes | no
- Review ticket created: yes | no
- Review ticket URL
- Auto-merge blocked until review: yes | no

## Harness Failure Classification

Use one of:

- `none`
- `missing_context`
- `stale_context`
- `missing_tool`
- `missing_verifier`
- `weak_guardrail`
- `unclear_spec`
- `model_limitation`

## Full Template

See `templates/project-operating-rules.md` for the complete project-level rules.
