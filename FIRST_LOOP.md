# First Loop

Do not learn the whole system first. Run one safe loop.

This path proves that your repo, ticket, AI tool and Human Gate work together. It does not require the AI Vault, PM Signal, full contracts or automation.

## One Primary Path

1. Use this template to create your project repository.
2. Run setup:

```bash
bash scripts/setup.sh
```

3. Open Ticket 0.
4. Copy the Builder prompt from the setup output.
5. Let the AI tool create one tiny evidence-backed documentation change.
6. Review the pull request.
7. Stop at Human Gate before merge.

## Ticket 0

Ticket 0 should prove the workflow with one harmless documentation change. It is not a product task, migration project, automation rollout or release.

Use `examples/demo-project/docs/ticket-0-example.md` as the shape if setup did not create the issue for you.

## Builder Prompt

Copy this into your AI coding tool:

```text
You are the Builder for this repository.

Read:
- PROJECT.md
- AGENTS.md
- Ticket 0

Goal:
Complete only the smallest safe onboarding change.
Add validation evidence to the PR body.
Open a PR or explain why no PR is needed.
Stop before merge. Human Gate remains with the operator.
```

## Boundaries

- No hidden background agents.
- No autonomous runner.
- No scheduler.
- No dashboard.
- No auto-merge.
- No direct AI Vault mutation.

The AI Vault is optional until after the first PR. Use it later for memory, decisions, risks and lessons.

After the first loop works, continue with `START_HERE.md`.
