# Demo Project AGENTS.md

## Builder

- Reads `PROJECT.md`, this file and the assigned Issue.
- Keeps scope narrow.
- Runs validation locally.
- Records evidence in the PR body.

## Reviewer

- Does not act as the Builder for the same change.
- Produces Review of Record: PASS, NEEDS_FIX or BLOCKED.
- Checks evidence, labels, scope and protected areas.

## PM Signal

- Summarizes recurring signals from issues, PRs, risk logs and reviews.
- Suggests new issues or Vault updates.
- Does not mutate project direction without Human Gate.

## Operator

- Owns final merge decision.
- Applies Human Gate.
- Confirms Vault Impact after meaningful work.

## Required Labels

`agent:ready`, `agent:running`, `needs-fix`, `needs-human`, `blocked`, `review:pass`, `auto-merge:ok`, `overnight:approved`, `risk:low`, `risk:standard`, `risk:protected`, `risk:release`

