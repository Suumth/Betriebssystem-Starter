---
name: implement-spec
description: Use when executing an approved multi-task implementation plan or coordinated implementation wave with explicit dependencies.
disable-model-invocation: true
---

# Implement Spec v2

Read canonical root `AGENTS.md` first, then applicable narrower operating-model/contract authorities, governing issue/spec/ADR and approved plan. Do not require or recreate root `AGENTS.override.md`.

## Roles and plan gate

External **ChatGPT GPT-5.6 Sol XHigh** is Planning Authority. **Luna Max** is manager-only and writes no product code. **Luna XHigh** owns implementation/fixes/intent-aware merger work. Every completed implementation gets a **fresh Luna XHigh read-only exact-head review**; implementers/fixers never self-approve. Coordinated waves end with **fresh Codex Sol XHigh** as release/integration authority.

Missing required plan → `BLOCKED: PLAN_REQUIRED`; material missing product/UX/domain/persistence/API/migration/security/architecture decision → `BLOCKED: PLAN_INCOMPLETE`. Execution agents do not create/materially rewrite missing planning. `PLAN_NOT_REQUIRED` requires explicit external Planning Authority approval for a small isolated/mechanical change.

## Safe frontier and state

Compute blocker-ready work, then remove unsafe concurrency using **dependency blockers + planned write-set overlap + shared foundations + ownership**. Dependency-ready alone is insufficient. Serialize shared schemas/primitives/interfaces/config/migrations/generated assets/test harnesses unless ownership is explicitly partitioned.

Maintain resumable task/base-SHA/write-set/verification/reviewer/fix/integration/merge state using any repository-defined canonical operational state rather than creating a competing one.

## Worker, review and integration loop

Each Luna-XHigh worker receives one bounded task, exact plan section, write ownership/non-ownership, exact base, integrated blockers, tests and acceptance evidence. Newly unblocked work starts from the **current applicable integration HEAD after all blockers are integrated**. A plan-defined alternate base is valid only if it contains every integrated blocker and is equivalent to the applicable integration state.

Implement only the owned slice; run focused verification/TDD at applicable seams. Commit/push behavior obeys narrower Human Gates, including governance/skill-contract rules.

After implementation: fresh Luna read-only review of the exact head. Critical/Important finding → Luna fix → verification → **different fresh Luna** review of the new exact head. Minor findings are fixed when cheap or explicitly dispositioned.

A Luna-XHigh merger integrates reviewed work by intent and runs focused integration verification. If merge/rebase/cherry-pick/conflict resolution or another integration action changes the reviewed SHA/tree, a **fresh Luna XHigh read-only review of the actual integration HEAD** is mandatory before marking integrated, advancing the frontier or making it merge-eligible.

Standalone/independently mergeable work requires a current independent review of its final exact integration head. Coordinated waves hand directly from Luna Max to fresh Codex Sol XHigh; no routine return to the user/external planner.

## Closed release loop

Fresh Codex Sol XHigh reviews final workstream heads and combined state, coordinates Luna-XHigh integration/fixes, requires focused/full gates plus fresh Luna whole-wave read-only review, reviews the exact combined head itself, and after material fixes requires verification → fresh Luna re-review → Sol re-review. Preferred target: `Critical 0 / Important 0 / Minor 0`.

`SOL_RELEASE_APPROVED` requires Critical=0 and Important=0, explicit Minor disposition and truthful external-gate state.

## Exact head + exact base landing

Approval binds the exact reviewed integration/head SHA **and exact reviewed target/base SHA**. Any approved-head or target/base movement before landing, generated-file change, conflict resolution, rebase or content change invalidates it.

Immediately before merge, re-read both head and target/base and require the approved tuple. Use an expected-head guard where supported. Mechanical squash/merge/rebase of exact approved content against the unchanged reviewed base is closeout; verify target HEAD/tree and merged PR state. If landing requires conflict/content changes, base moved, or repository policy requires an atomic base guard the platform cannot supply, obtain fresh review/gate.

## Gate truth and control-plane Human Gates

Unavailable/external CI/security evidence remains blocked/unknown, never PASS. A required unavailable gate may be bypassed only when canonical policy already marks it optional or itself defines a Human Gate for a waiver and human authorization is recorded. External Sol planning alone cannot waive validation.

Routine validated code merge is autonomous only where canonical policy grants it. Existing **governance/operating-rule and skill-contract Human Gates remain binding**, alongside destructive/irreversible, credential/signing, deployment/publishing and other project gates. `implement-spec` cannot autonomously alter or waive its own governance controls.

## Attribution

Derived from Matt Pocock's `mattpocock/skills` `implement-spec` workflow under the MIT license. See `.agents/skills/LICENSE.mattpocock`.
