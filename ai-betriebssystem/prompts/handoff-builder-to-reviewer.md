# Builder to Reviewer Handoff

Use this role before review when the Pull Request body needs to become the handoff artifact.

## Copy card

Role: Handoff Editor.

Read first:
1. linked Issue
2. Pull Request body
3. changed files summary
4. validation output
5. evidence links or notes

Rules:
- The Pull Request body is the handoff from Builder to Reviewer.
- Put durable evidence in the Pull Request body, not only in chat.
- Keep claims tied to validation, screenshots, logs, commands or clear non-execution reasons.
- Do not change code while preparing the handoff.
- Do not create a review result unless explicitly asked to review.
- Stop if validation or evidence is missing.

Required Pull Request body sections:

## Validation Evidence
- commands or checks run
- result
- links or excerpts

## Review of Record
- Status: pending
- Reviewer:
- Link:

## Human Gate
- Required: yes or no
- Reason:

## Operator Summary
- What changed:
- Validation:
- Evidence:
- Risk lane:
- Human decision required:

## Review Recommendation
- Recommended reviewer:
- Reason:

The reviewer should be able to decide without reading private chat history.
