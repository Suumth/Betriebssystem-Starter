# PROJECT.md Template

Copy this file into the project repository root as `PROJECT.md`. This is the
canonical project instruction for ChatGPT, Claude, Codex, Gemini and future AI
tools.

Tool-specific project instructions must only point to the GitHub URL of this
file. Do not copy product truth into ChatGPT, Claude, Codex or other tool
settings.

## Project Identity

- Project name:
- Product type: iOS | macOS | Web | Docs | Marketing | Other
- Project repository:
- Canonical `PROJECT.md` GitHub URL:
- Local checkout path for local agents:
- AI-Betriebssystem method repository: `<AI_OS_METHOD_REPO_URL>`
- Project `AGENTS.md`:
- Project Brief:
- AI Vault canonical project folder:
- AI Vault online entrypoint for Cloud KIs:

## Source Router

| Source | Role | Use for |
|---|---|---|
| Project repository | Operational truth | Issues, PRs, labels, code, repo docs, validation evidence and current status |
| AI-Betriebssystem 2.0 | Method truth | Ticket Contract, Review Contract, labels, prompts, templates and Green Path rules |
| AI Vault | Strategy and product memory | Vision, target picture, decisions, non-goals, roadmap, risks and lessons |

If sources disagree:

- The project repository wins for current operational state.
- The AI Vault wins for strategy and product memory.
- AI-Betriebssystem wins for method and loop contracts.
- The mismatch must become an issue, decision note or Vault update proposal.

## Online-first Source Policy

- Cloud KIs must receive GitHub URLs or other online entrypoints, not local paths.
- Local paths are fallback context only for local agents such as Codex.
- AI Vault content needed by Cloud KIs must be available through GitHub, an
  online entrypoint or a controlled project-repo mirror.
- Mirrors are access copies, not a new strategic source of truth.

## Key Sources

| Source | GitHub URL / online entrypoint | Local fallback | Purpose |
|---|---|---|---|
| This `PROJECT.md` |  |  | Canonical AI entrypoint |
| `AGENTS.md` |  |  | Repo-specific agent rules |
| Project Brief |  |  | Compact project source map |
| AI-Betriebssystem | <AI_OS_METHOD_REPO_URL> |  | Method source |
| Ticket Contract |  |  | Issue maturity and closeout |
| Review Contract |  |  | Review of Record and merge signal |
| Bootstrap Loop |  |  | Project bootstrap convention |
| Xcode 27 skill note, Apple projects only | GitHub URL of `skills/xcode-27.md` or project-local equivalent | Local Codex fallback/reference only, if present | Conditional Apple-platform skill routing |
| AI Vault Vision |  |  | Strategic north star |
| AI Vault Target Picture |  |  | Desired product state |
| AI Vault Product Brief |  |  | Product memory |
| AI Vault Roadmap |  |  | Milestones and sequencing |
| AI Vault Decisions |  |  | ADRs and decision history |
| AI Vault Risks |  |  | Known risks and mitigations |
| AI Vault Lessons Learned |  |  | Reusable learning |

## Working Rules

- Start every task by reading this file and the issue or PR at hand.
- Read `AGENTS.md` before editing.
- Use GitHub Issues, PRs, labels and repo files as operational truth.
- Use AI Vault references for strategy, not for hidden operational instructions.
- Do not broaden scope beyond the issue boundary.
- Do not claim success without validation evidence.
- Keep PR bodies as the primary closeout source.
- After a green merge, synchronize `main` before starting the next queue item.

## Teilprojekte & Produktversprechen

Teilprojekte sind GitHub Milestones im Projekt-Repo. Produktversprechen sind
keine Ticket-Zaehlstaende; sie werden nur mit Evidence-Link und Human-/
Operator-Entscheidung bestaetigt.

Leitplanken:

- maximal 7 Teilprojekte je Projekt.
- maximal 4 Produktversprechen je Teilprojekt.
- Status ist nur `offen` oder `bestätigt`.
- `bestätigt` ist nur mit Evidence-Link erlaubt.

| Teilprojekt / Milestone | Produktversprechen | Status (`offen` / `bestätigt`) | Evidence-Link | phasenkritisch (`ja` / `nein`) |
|---|---|---|---|---|
|  |  | offen |  | nein |

## Required Labels

- `agent:ready`
- `agent:running`
- `needs-fix`
- `needs-human`
- `blocked`
- `review:pass`
- `auto-merge:ok`

Optional risk labels:

- `risk:low`
- `risk:standard`
- `risk:protected`
- `risk:release`

## Validation Map

| Work type | Required validation | Evidence |
|---|---|---|
| Docs/templates | `git diff --check` plus repo markdown checks if present | PR body with changed files and check result |
| Code |  |  |
| UI/browser |  |  |
| iOS/macOS |  |  |
| Release/protected area |  |  |

## Ticket 0

Ticket 0 proves that this project is agent-ready. It should check or complete:

- `PROJECT.md`
- `AGENTS.md`
- Project Brief
- Issue template
- PR template or PR body standard
- labels
- validation path
- one small smoke-test or docs-only proof

Ticket 0 must not introduce product scope unless the issue explicitly says so.

## No Duplication

- Tool-specific instructions are bootstrap pointers to this file.
- Product strategy belongs in the AI Vault.
- Current work belongs in GitHub and repo files.
- Method rules belong in AI-Betriebssystem.
- If a tool setting, chat, or issue contains unique truth, move it into the
  correct durable source or mark it as a decision needed.
