# Ticket 0: Prove the First Loop

## Goal

Make one harmless documentation change that proves the AI workflow works.

## Allowed

- Update `docs/project-brief.md`.
- Add one sentence describing this project.

## Do not touch

- scripts
- workflows
- labels
- release files
- credentials
- branch protection
- protected paths
- product code

## Not This Ticket

- Not a product feature.
- Not a full method migration.
- Not an autonomous runner test.
- Not an auto-merge request.

## Validation Evidence

Run:

```bash
bash scripts/post-setup-check.sh
```

If available, also run:

```bash
bash scripts/public-readiness-check.sh
```

Paste the command output into the PR body.

## Stop

Open a PR.
Do not merge.
Human Gate decides.
