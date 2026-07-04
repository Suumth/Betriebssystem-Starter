# Ticket 0 Bootstrap Template

Use this as the first `agent:ready` issue in a newly bootstrapped project.

## Agent Contract

Mode: EXECUTING
Autonomy: standard
Risk lane: low

## Goal

Prove that this repository is bootstrap-fertig and can be worked by an AI agent
from `PROJECT.md` without additional briefing.

## Context

- Repo/path:
- Related docs:
  - `PROJECT.md`
  - `AGENTS.md`
  - `docs/project-brief.md`
  - issue template:
  - PR template or PR body standard:
- AI-Betriebssystem reference:
  - `docs/bootstrap-loop.md`
  - `templates/project-start-pack.md`

## Boundary

- Allowed changes:
  - bootstrap files
  - repo docs
  - issue/PR templates
  - label documentation
  - one minimal smoke-test or docs-only proof
- Do not touch:
  - product features
  - protected/release areas
  - sensitive credentials
  - unrelated roadmap or Vault content
- Public/external actions require approval: no, if limited to this repository.

## Acceptance Criteria

- [ ] `PROJECT.md` exists at the repo root and is the canonical AI entrypoint.
- [ ] `PROJECT.md` points to AI Vault sources instead of duplicating them fully.
- [ ] `AGENTS.md` exists and names repo-specific validation rules.
- [ ] Project Brief or source map exists.
- [ ] Required labels are present or explicitly documented for creation.
- [ ] Issue template covers Agent Contract, Boundary, Verification, Evidence and Closeout.
- [ ] PR template or PR body standard covers Summary, Changed Files, Validation Evidence and deferred points.
- [ ] A minimal verifier is documented and runnable or a missing verifier is classified.

## Verification

- Required command/check:
  - `git diff --check`
  - add repo-specific markdown/build/test checks here:
- UI/browser/simulator proof:
  - not required unless this is a UI project and the smoke proof says so
- Evidence artifact expected:
  - PR body with changed files, validation result and remaining risks

## Closeout

- What changed:
- What was verified:
- Evidence:
- Remaining risk:
- Follow-up needed:
- Harness failure classification: none | missing_context | stale_context | missing_tool | missing_verifier | weak_guardrail | unclear_spec | model_limitation

### Operator Summary

- What changed:
- Validation:
- Evidence:
- Risk lane: low
- Auto-merge candidate: yes/no
- Human decision required: yes/no
- Claude Code Review Suggested: yes/no
- Reason:

### Review Recommendation

- Recommended reviewer: Codex
- Recommended intelligence/reasoning: medium
- Reason: Bootstrap proof checks method wiring, templates and validation evidence.
- Review ticket suggested: no
- Review ticket created: no
- Review ticket URL:
- Auto-merge blocked until review: no

## Stop Condition

Stop and classify the harness failure if repository access, labels, canonical
sources, validation commands or ownership boundaries are missing.

## Label vor Start

Set `agent:ready` only after the issue is complete enough to run without another
human prompt.
