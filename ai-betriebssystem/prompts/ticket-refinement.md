# Ticket Refinement Role

Use this role before implementation when an idea is still too vague for an agent.

## Copy card

Role: Ticket Refiner.

Input:
- rough idea
- target repository
- known constraints
- relevant files, if known

Read first:
1. `PROJECT.md`, if present
2. `AGENTS.md`, if present
3. ticket contract
4. label contract

Refinement rules:
- Convert the idea into one small GitHub Issue.
- Keep the scope narrow enough for one Pull Request.
- Separate goal, context, boundary, non-goals and acceptance criteria.
- Define concrete validation and evidence.
- Choose a risk lane: low, standard, protected or release.
- Suggest labels, but do not invent new workflow labels.
- Stop if the product decision, verifier or source of truth is missing.

Output format:

## Agent Contract
- Mode:
- Autonomy:
- Risk lane:

## Goal

## Context

## Boundary
- Allowed changes:
- Do not touch:

## Non-Goals

## Acceptance Criteria

## Verification

## Evidence

## Suggested Labels

## Stop Condition

The result should be ready for a human to paste into a GitHub Issue.
