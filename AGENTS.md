# Standard AI Engineering Orchestration

Owner decision: 2026-08-27. These rules are the repository-level orchestration authority for new implementation runs. Already active work may finish under its original execution contract unless explicitly restarted.

- External **ChatGPT GPT-5.6 Sol XHigh** is Planning Authority for plan-required work.
- **Luna Max** is the `implement-spec` manager and writes no product code.
- **Luna XHigh** owns implementation, fixes and intent-aware merging.
- Every completed implementation slice gets a **fresh Luna XHigh read-only review**; implementers/fixers never self-approve.
- If intent-aware integration changes the reviewed SHA/tree, the **actual integration HEAD** gets a fresh independent Luna XHigh read-only review before the frontier advances or that work becomes merge-eligible.
- Coordinated multi-ticket/multi-PR waves end with fresh **Codex Sol XHigh** `CODEX_SOL_RELEASE_ORCHESTRATOR` for combined review, Luna fix/re-review coordination, exact-state approval and merge coordination.

Missing required plan → `BLOCKED: PLAN_REQUIRED`; material missing product/UX/domain/persistence/API/migration/security/architecture decision → `BLOCKED: PLAN_INCOMPLETE`. Execution agents do not create/rewrite the plan. `PLAN_NOT_REQUIRED` is available only when explicitly set by the external planning owner for a small mechanical/isolated change.

For approved multi-task work use `.agents/skills/implement-spec/SKILL.md`. Compute a **safe frontier** from blockers plus write-set overlap, shared foundations and ownership; use isolated worktrees/branches from the latest applicable integration HEAD; maintain resumable exact-head/review/merge state; require fresh Luna review after implementation, after blocking fixes, and after integration changes the reviewed state.

Coordinated waves hand directly from Luna Max to fresh Codex Sol XHigh after implementation completion. Do not return to the user/external planner for routine final integration approval. `SOL_RELEASE_APPROVED` is bound to the exact reviewed integration/head SHA **and exact reviewed target/base SHA**. Any approved-head or target/base movement before landing invalidates it. Never convert unavailable CI/security evidence to PASS. After permitted landing, verify the target HEAD/tree, update/close work items and use the merged HEAD as authority for subsequent planning.

Routine validated **product/repository code merge** after independent exact-head approval is not itself a Human Gate where existing policy permits it. Existing project-specific Human Gates remain binding, including unresolved-product, destructive/irreversible, credential/signing, production-deployment/publishing, validation-waiver, **governance/operating-rule and skill-contract changes**. The standard must not autonomously modify or waive its own control plane.
