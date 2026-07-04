# Skill: Ticket Worker

Purpose: build one ready GitHub issue into one reviewable pull request.

## Flow

1. Read the issue.
2. Check Agent Mode, Execution Mode, Autonomy, Risk lane, goal, scope, non-goals and acceptance criteria.
3. Reuse existing branch or PR when present.
4. If `Subagents: REQUIRED`, start the requested subagents and apply the Subagent Failure Policy if one stalls or returns no usable result.
5. Make the smallest useful change.
6. Run the validation from the issue.
7. Add evidence.
8. Write a closeout.

## Agent Modes

- `EXECUTING`: build inside the boundary.
- `GRILLING`: do not build; clarify decision, term or scope first.
- `COORDINATING`: coordinate synthesis or partial checks before implementation.

## Execution Mode

- `Subagents: NOT_REQUIRED`: work as a single Builder run.
- `Subagents: REQUIRED`: start requested internal subagents before implementation, consolidate findings and include them in the PR closeout.

## Subagent Failure Policy

If a required subagent stalls, times out or returns no usable result:

1. Attempt one targeted recovery by requesting a checkpoint summary or re-prompting the same bounded task.
2. If no usable result arrives after one additional check cycle, mark `subagent_timeout`, `subagent_no_result` or `subagent_blocked`.
3. Continue in degraded mode only when the missing subagent was read-only, the Builder can reconstruct the analysis, no critical non-reconstructable risk check is missing and replacement Evidence is documented.
4. Otherwise stop with `BLOCKED`.

## Skill Patterns

- `plan-then-implement`
- `grill-with-docs`
- `simplify-pass`
- `cross-system-audit`

## Priority

1. `needs-fix`
2. `agent:running`
3. one `agent:ready`

## Evidence Examples

- build result
- test result
- lint result
- screenshot
- preview result
- documented blocker
- subagent failure marker and degraded-mode replacement Evidence

## Closeout Checklist

- Update PR body as the primary closeout source
- Link issue
- Include validation commands and results
- Include evidence paths
- Include subagent findings when `Subagents: REQUIRED`
- Include subagent failure status, recovery attempt, degraded/block decision, replacement Evidence and remaining risk when the Subagent Failure Policy is used
- Include operator summary
- Include review recommendation
- Include harness failure classification
- Add PR comment only as fallback/supplement
- If supplement is used, link/reference it from PR body
- Do not set review/merge labels

## Boundary

The Ticket Worker does not merge or release.
