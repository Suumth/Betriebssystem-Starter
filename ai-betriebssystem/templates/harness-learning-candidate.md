# Harness Learning Candidate

A Harness Learning Candidate captures repeated evidence that the method,
contract, template, skill or documentation layer may need improvement. It is a
proposal, not active policy.

Learning Candidates live in GitHub. They become operative only after a normal
Issue or PR, Review of Record and merge. Local logs, private chat notes and
Vault notes can provide source evidence, but they do not become operational
truth by themselves.

Use this template when repeated work shows one of these patterns:

- repeated same Harness Failure Classification
- repeated missing verifier or missing evidence
- stale context causing rework
- unclear spec pattern repeated across tickets
- model or tool limitation that needs a method rule

Do not use it for one-off local mistakes, product decisions without repeated
evidence or changes that need direct Vault mutation. A Vault update remains a
Vault Impact candidate unless the ticket explicitly permits the agent to edit
the Vault.

```markdown
# Harness Learning Candidate: <short title>

## Claim / Lesson

What durable lesson should the harness consider?

## Evidence Source

- Issue:
- PR:
- Review of Record:
- Command/output or artifact:
- Related Harness Failure Classification:

## Confidence

Confidence: 1-5

## Scope

Scope: repo | method | product | release | review

## Applies To

- Repo or project type:
- Agent role:
- Ticket or PR pattern:

## Proposed Target

Proposed target: AGENTS.md | contract | template | skill | docs | Vault update candidate

Suggested file:

## Proposed Update

- Exact proposed Markdown, or a concise patch description:

## Human Gate

Human Gate required: yes

Reason:

## Non-goal

This candidate is not active policy until merged through PR and Review of
Record.

## Review Notes

- Risk lane:
- Validation needed:
- Remaining uncertainty:
```
