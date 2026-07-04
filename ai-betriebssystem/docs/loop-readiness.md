# Loop Readiness

Loop Readiness is a preflight rubric for repeated agent work. It is not a new state
system, runner, dashboard, label family, cron job or second source of truth.

The operational truth remains GitHub: Issues, PRs, labels, repo files and PR
bodies. Loop Readiness only helps the operator decide whether a repeated agent
loop is clear enough to run without drifting into context burn, stale context or
unreviewable work.

GitHub is the operational source of truth for loop execution. The Vault is not
read during execution and is not an operational taskboard.

## When to Use It

Use Loop Readiness before work that repeats, coordinates or spans more than one
surface:

- `COORDINATING` mode.
- Batch Green Path Execution.
- PM Signal Loop runs.
- repeated review, triage or fix loops.
- multi-surface work across contracts, templates, prompts, docs or project repos.
- project bootstraps and migrations.

It is not required for:

- small documentation fixes.
- simple low-risk `EXECUTING` tickets.
- one-off smoke tasks with clear verification.
- narrow PR follow-ups where the issue, verifier and closeout are already clear.

## Rubric

| Area | Question | Minimum evidence |
| --- | --- | --- |
| Purpose / Scope | Why should this loop run, and what is explicitly out of scope? | Issue goal, boundary and stop condition |
| Watched Scope | Which repo, branches, PRs and tickets may the loop inspect or change? | Explicit repo/branch/PR/ticket scope |
| Trigger | What starts the loop? | Issue, PR review, label, PM Signal request or operator instruction |
| Cadence | Is this manual, operator-prompted, evening-prompted or batch work? | Trigger/cadence stated without requiring a runner |
| Action | What may the agent change or inspect? | Allowed files, forbidden files and expected artifact |
| Maker / Checker | Who builds and who checks? | Builder role, Review of Record and any required Subagents |
| Proof | What proves success? | Required command, review evidence, smoke result or manual check |
| Memory | Where does durable evidence live? | PR body, issue, repo doc, decision note or risk note |
| Stop | What ends or blocks the loop? | Merged PR, explicit stop, `BLOCKED`, `needs-human` or follow-up issue |
| Cost / Attempts | How far may the loop retry? | Attempt budget, fix-cycle cap or escalation rule |
| Safety | What protected or release risk blocks action? | Human handoff trigger, protected-path rule or denylist reference if available |
| Observability | How can a reviewer reconstruct the run? | Closeout, evidence, labels, PR body and linked comments |

If one row cannot be answered, the loop is not ready. Convert the gap into a
clearer issue, review request, PM Signal prompt or human decision instead of
letting the loop infer missing rules.

## Readiness Levels

Loop Readiness only permits MVP-safe operation:

- `L0 Draft`: the loop idea exists, but purpose, proof or stop rules are still
  incomplete. Do not execute as a repeated loop.
- `L1 Report-only`: the loop may inspect and summarize. It can propose issues,
  PR evidence or decision notes, but it does not change product artifacts
  without a normal ticket.
- `L2 Assisted`: the loop may make bounded repo changes through normal GitHub
  Issues, PRs, validation and Review of Record. Human gates still apply.
- `L2 PR-producing action`: only allowed when the ticket is mature, validation
  is defined, Evidence Gate is satisfied, Review of Record is available and the
  Operator Merge Policy still controls merge.
- `L3 Release/protected blocked`: release or protected-surface work stops at
  evidence, review recommendation and Human Gate unless the ticket explicitly
  authorizes the protected action.
- `L3 Unattended`: not allowed in the MVP.

`L2 Assisted` is the maximum level for this repository. Anything that needs
unattended scheduling, auto-fix, auto-merge, broad repo mutation or hidden state
is outside the MVP.

A loop is not ready for autonomous PR-producing work if validation or Review of
Record is missing.

### Overnight Runs stay L2 Assisted

An operator-armed Overnight Run is `L2 Assisted` with time-shifted supervision,
not a higher autonomy level.

Why it stays L2:

- The explicit evening prompt starts the run.
- `agent:ready` plus `overnight:approved` only selects eligible tickets; a label
  alone starts nothing.
- Codex may create bounded branches, validation evidence and PRs.
- No merge happens at night.
- The Morning Review remains the human merge gate.
- GitHub remains the operational truth: Issues, PRs, labels, repo files and PR
  bodies.

Still outside the MVP:

- cron
- scheduler
- independent bot cycle
- auto-merge
- hidden run state or another source of truth outside GitHub
- automatic ticket creation at night

See `docs/overnight-operations-mode.md` for the mode rules, limits, heartbeat
format and Morning Review handoff.

## Guardrails

Loop Readiness must not introduce:

- `STATE.md` or `LOOP.md` as required operational files.
- cron, runner, dashboard or GitHub Actions requirements.
- new loop labels or status categories.
- package dependencies or tool setup requirements.
- a second source of truth next to GitHub.
- automatic Claude Code fallback.

## Attempt Budget & Escalation

Attempt budgets apply only to repeated fix, review or loop work. They do not
count normal implementation steps, the first validation run, closeout edits,
post-merge hygiene or Green Path next-ticket selection.

For run-wide limits, stop conditions and operator kill actions, use
`contracts/run-budget-kill-switch.md`.

Default caps:

- Builder self-fix before PR: max 1.
- Automated `needs-fix` cycles on the same PR: max 2 unless the Operator
  explicitly extends.
- Required-subagent recovery: governed by the Subagent Failure Policy, not by a
  separate retry loop.

If the budget is exhausted or the same failure repeats, stop and document:

- attempts used.
- last failed check or review point.
- Harness Failure Classification.
- suspected root cause.
- next action and recommended next reviewer.
- whether the Operator explicitly extended the budget.

Escalation is evidence plus a recommendation. It is not automatic Claude Code
fallback and it does not create a new label, state file, runner or dashboard.

## Optional `loop-audit` Diagnostic

`loop-audit` from the external loop-engineering repo may be used as optional
manual/local diagnostic guidance only.

Example, if an operator explicitly wants a local diagnostic pass:

```bash
npx @cobusgreyling/loop-audit . --suggest
```

This command is not a CI gate, required dependency, required setup step, source
of truth or replacement for the Ticket Contract, Review Contract or PR body. Do
not add package files, workflows, runner behavior or PASS criteria for it.

If a diagnostic finding matters, copy the substance into GitHub as one of:

- a GitHub issue.
- PR evidence.
- a decision note.
- a risk note.
- a method-doc update.

AI-Betriebssystem contracts override external tool suggestions. Do not import
`STATE.md`, `LOOP.md`, loop labels, runner/cron behavior, package dependencies
or unattended `L3` automation from the external repo.

## Closeout Use

When a PR uses Loop Readiness, its closeout should state:

- which readiness level applied.
- which rubric gaps were found, if any.
- whether attempt budget or escalation rules were needed, exhausted or extended.
- why no runner, dashboard, state file, cron or new labels were introduced.
