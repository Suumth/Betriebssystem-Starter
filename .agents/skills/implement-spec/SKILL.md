---
name: implement-spec
description: Use when executing an approved multi-task implementation plan or coordinated implementation wave with explicit dependencies.
disable-model-invocation: true
---

# Implement Spec v2

Apply `AGENTS.override.md` and preserve Matt Pocock's dependency-graph/frontier/worktree core.

External ChatGPT GPT-5.6 Sol XHigh owns plan-required plans. Luna Max is manager-only. Luna XHigh owns implementation, fixes and intent-aware merging. Every completed slice gets a fresh Luna-XHigh read-only reviewer. Coordinated waves end with fresh Codex Sol XHigh `CODEX_SOL_RELEASE_ORCHESTRATOR`.

Before workers start, verify the approved plan exists, belongs to the work, covers requirements/decisions/acceptance/testing obligations, and leaves no material product/UX/domain/persistence/API/migration/security/architecture decision open. Missing plan → `BLOCKED: PLAN_REQUIRED`; material gap → `BLOCKED: PLAN_INCOMPLETE`. Do not create/rewrite the plan here. `PLAN_NOT_REQUIRED` requires explicit external planning-owner approval.

Compute blocker-ready tasks, then remove unsafe write overlap. Dependency-ready is not automatically parallel-safe. Serialize shared schemas/interfaces/config/migrations/generated assets/test harnesses unless ownership is explicitly partitioned. Maintain resumable task/base/head/write-set/verification/reviewer/fix/integration state.

Each Luna-XHigh worker gets one bounded task, exact plan section, write ownership, exact base, blocker commits, tests and acceptance evidence. Newly unblocked workers start from the latest applicable integration HEAD. Implement only the owned slice, use TDD at applicable stable seams, verify, commit and report exact head/evidence.

After every implementation, Luna Max dispatches a **fresh read-only Luna XHigh reviewer**. Critical/Important findings go to a Luna fix worker, then verification and a **different fresh reviewer** of the new exact head. A Luna merger integrates reviewed work **by intent**, runs focused integration verification, and only then marks the task integrated and recomputes the safe frontier.

Implementation-complete requires all plan tasks integrated, complete plan/spec coverage, truthful checks, no unresolved Critical/Important fresh-Luna findings, satisfied acceptance evidence and an exact integration head.

For coordinated waves, issue/task readiness is not release completion. Luna Max MUST dispatch fresh Codex Sol XHigh; do not return to the user/external planner for routine final integration approval. Sol reviews final workstreams and the combined head, delegates integration/fixes to Luna XHigh, requires full/focused gates plus fresh Luna whole-wave review, and after fixes requires verification → fresh Luna re-review → Sol re-review.

Preferred target: `Critical 0 / Important 0 / Minor 0`. `SOL_RELEASE_APPROVED` requires Critical=0 and Important=0, explicit Minor disposition and truthful non-PASS external gates. Approval is exact-SHA-bound; any subsequent change invalidates it. Never relabel unavailable CI/security evidence as PASS; otherwise use `BLOCKED: EXTERNAL_GATE` when policy does not permit release.

After merge, verify target HEAD, update/close work items and make the merged HEAD authority for the next planning cycle. Routine validated code merge is not itself a Human Gate; genuine repository-specific external/destructive/release/waiver gates remain binding.

## Upstream attribution

Derived from Matt Pocock's `mattpocock/skills` `implement-spec` workflow under the MIT license. See `.agents/skills/LICENSE.mattpocock`.
