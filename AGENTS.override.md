# Standard AI Engineering Orchestration

Owner decision: 2026-08-27. This is the repository-level orchestration authority for new implementation runs.

If `AGENTS.md` exists, read it immediately after this file and apply its product/security/validation/Human-Gate rules. This override wins on model selection, delegation topology, review ownership, routine merge ownership and `implement-spec` orchestration. Already active work may finish under its original execution contract unless explicitly restarted.

- External **ChatGPT GPT-5.6 Sol XHigh** is Planning Authority for plan-required work.
- **Luna Max** is the `implement-spec` manager and writes no product code.
- **Luna XHigh** owns implementation, fixes and intent-aware merging.
- Every completed implementation slice gets a **fresh Luna XHigh read-only review**.
- Coordinated multi-ticket/multi-PR waves end with fresh **Codex Sol XHigh** `CODEX_SOL_RELEASE_ORCHESTRATOR` for combined review, Luna fix/re-review coordination, exact-SHA approval and merge coordination.

Missing required plan → `BLOCKED: PLAN_REQUIRED`; material missing product/UX/domain/persistence/API/migration/security/architecture decision → `BLOCKED: PLAN_INCOMPLETE`. Execution agents do not create/rewrite the plan. `PLAN_NOT_REQUIRED` is available only when explicitly set by the external planning owner for a small mechanical/isolated change.

For approved multi-task work use `.agents/skills/implement-spec/SKILL.md`. Compute a **safe frontier** from blockers plus write-set overlap, use isolated worktrees/branches from the latest applicable integration HEAD, maintain resumable exact-head/review/merge state, require fresh Luna review after implementation and after blocking fixes, and merge by intent with focused integration verification.

Coordinated waves hand directly from Luna Max to fresh Codex Sol XHigh after implementation completion. Do not return to the user/external planner for routine final integration approval. `SOL_RELEASE_APPROVED` is exact-SHA-bound; any later change invalidates it. Never convert unavailable CI/security evidence to PASS. After merge, verify the target HEAD, update/close work items and use the merged HEAD as authority for subsequent planning.

Routine validated code merge after independent exact-head approval is not itself a Human Gate. Genuine project-specific unresolved-product, destructive/irreversible, credential/signing, production-deployment/publishing and validation-waiver gates remain binding.
