# Green Path Example

## Preconditions

- Issue has `agent:ready`.
- Risk lane is `risk:low` or `risk:standard`.
- Builder and Reviewer are separate.
- Checks pass.
- Review of Record is PASS.
- `review:pass` is present.
- Operator has separately accepted the Human Gate after PASS.
- `auto-merge:ok` is present only after PASS and separate Operator acceptance.
- No `needs-human`, `needs-fix` or `blocked`.

## Closeout

After merge, update Vault decisions, risks or lessons only if the work created stable knowledge.
