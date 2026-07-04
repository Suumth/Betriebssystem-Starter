# Skill: Reviewer

Purpose: review one pull request against its linked GitHub issue and make the next decision obvious.

## Check

- goal
- scope
- non-goals
- acceptance criteria
- validation
- evidence
- Vault Impact
- unnecessary changes
- product, architecture and UX risks

## Outcome

Choose one result:

- PASS/Gruen -> `review:pass` + `auto-merge:ok`; remove `needs-human`, `needs-fix` and `blocked`
- PASS/Gelb -> `review:pass` + `needs-human`; remove `auto-merge:ok`; include Review Recommendation
- NEEDS-FIX/Rot -> set `needs-fix`; remove `needs-human`, `blocked`, `review:pass` and `auto-merge:ok`
- BLOCKED/Rot -> set `blocked`; remove `needs-human`, `needs-fix`, `review:pass` and `auto-merge:ok`

## Good Review

A good review is concrete, issue-based and actionable.

No PASS without `Vault Impact` in the PR body or clearly linked PR evidence. If
`Vault update required: YES`, require a concrete Vault Update Candidate and
explicit source evidence. Agents must not directly mutate the AI Vault unless
the issue explicitly allows it.

## Boundary

The Reviewer does not merge, release or redefine the ticket.

`needs-human` blocks Auto-Merge. It is not approval.
