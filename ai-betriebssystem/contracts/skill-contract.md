# Skill Registry Contract

The Skill Registry documents reusable agent methods as versioned Markdown artifacts.

Skills are context/method artifacts, not executable agents, plugins, runners, tool sandboxes or self-modifying automation. They may guide a Builder or Reviewer, but they do not override contracts, Review of Record, Human Gate, ticket boundary, labels or validation requirements.

Skill changes become active only after PR, Review of Record and merge.

No direct Vault mutation is allowed unless a ticket explicitly permits it. Otherwise skill-related Vault notes stay Vault Impact candidates with Human Gate.

## Markdown-only Skill Format

Each registry skill should use this safe Markdown-only shape:

```markdown
# Skill: <Name>

Purpose:

When to use:

When not to use:

Inputs:

Expected output:

Evidence rule:

Failure modes:

Version / last changed:

Source evidence:
```

## Required Fields

- `# Skill: <Name>` names the reusable method.
- `Purpose` states the job in one or two sentences.
- `When to use` gives concrete trigger conditions.
- `When not to use` protects scope and non-goals.
- `Inputs` names required issue, PR, repo or artifact context.
- `Expected output` names the reviewable artifact or decision.
- `Evidence rule` says what GitHub evidence must exist before claiming success.
- `Failure modes` names likely blockers or Harness Failure Classification values.
- `Version / last changed` records a human-readable version or date.
- `Source evidence` links the issue, PR, review, lesson or Harness Learning Candidate that justified the skill.

## Governance

- Skills are Markdown-only method guidance.
- Skills are not executable and do not install dependencies.
- Skills cannot lower validation, Vault Impact, Review of Record or Human Gate requirements.
- A skill may suggest a workflow, but the linked ticket remains the source of truth for scope and acceptance criteria.
- A skill may recommend a Harness Learning Candidate, but the Candidate is not active policy until PR, Review of Record and merge.

## Starter Candidates

Useful starter skills include:

- Review of Record: consistent PR review against a linked issue.
- Vault Impact: checking whether a change needs a Vault Update Candidate.
- PM Signal: summarizing GitHub project state without becoming a second source of truth.
- Xcode Simulator Evidence: collecting Apple-platform build, simulator or screenshot proof when a ticket requires it.

Candidate skill names are not implementation requirements. Add or change skills only through normal PR review.
