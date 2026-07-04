# Branch Protection Helper

The starter includes an opt-in helper script for maintainers who want to make the evidence gate enforceable in GitHub branch protection.

## Script

```bash
scripts/apply-branch-protection.sh OWNER/REPO [branch] [--apply]
```

Dry-run is the default. Without `--apply`, the script prints the planned API route and JSON configuration but performs no write action.

## Preconditions

- GitHub CLI `gh` is installed.
- `gh auth status` succeeds.
- The operator has permission to change branch protection in the target repository.

## Protected checks

The helper configures these required status checks:

- `pr-contract`
- `shell-checks`
- `python-tests`
- `public-readiness`

It also requires one approving pull request review, enforces admins, requires linear history, and disables force pushes and branch deletion.

## Apply

Run the dry-run first:

```bash
scripts/apply-branch-protection.sh OWNER/REPO main
```

Apply only after reviewing the printed configuration:

```bash
scripts/apply-branch-protection.sh OWNER/REPO main --apply
```

Applying branch protection is an external write action and remains an operator decision.
