# Contributing

Thank you for improving the AI Operating System Starter.

This repository is a starter template, so contributions must keep the package generic, public-safe and easy to copy into another repository.

## Contribution path

1. Open or choose a GitHub Issue.
2. Keep the scope small enough for one Pull Request.
3. Follow the ticket contract and label contract.
4. Open a Pull Request with validation evidence.
5. Let the PR Contract Check and CI run.
6. Wait for a Review of Record before merge.

Use the root GitHub templates when opening work against this starter:

- `.github/ISSUE_TEMPLATE/task.md`
- `.github/pull_request_template.md`

## Required gates

Every Pull Request should satisfy:

- linked Issue or clear rationale
- filled Pull Request body
- validation evidence
- Review of Record section
- Human Gate section
- Operator Summary
- Review Recommendation
- green CI
- green PR Contract Check

The PR Contract Check is a required repository gate. It checks that the Pull Request body contains the required evidence and decision sections and that label combinations do not contradict the label contract.

## Public-safety rules

Do not add:

- private project names
- customer data
- local paths
- credentials
- real internal roadmaps
- product-specific claims that do not belong in a generic starter

Run before proposing public release changes:

```bash
bash scripts/public-readiness-check.sh
```

## Review expectations

A reviewer compares the Pull Request against the linked Issue and returns exactly one decision signal:

- `PASS`
- `NEEDS-FIX`
- `BLOCKED`

A PASS does not replace the Human Gate for release, protected or external decisions.
