# Release Checklist

## First Public Release

- [ ] GitHub Template repository ist aktiviert.
- [ ] Description ist gesetzt: `A GitHub-centered starter kit for AI-assisted project work with tickets, PR evidence, human gates, agent prompts, and an AI Vault.`
- [ ] Topics sind gesetzt: `ai-agents`, `ai-operating-system`, `github-workflow`, `obsidian`, `project-management`, `agentic-workflows`, `codex`, `claude-code`, `ai-vault`.
- [ ] Erste Release wird als Draft vorbereitet, zum Beispiel `v0.1.0`.
- [ ] Release wird erst nach Review of Record und Human Gate veröffentlicht.
- [ ] Release Notes nennen Template-Nutzung, Setup, Ticket 0, GitHub als operative Wahrheit und AI Vault als Projektgedächtnis.

## Public Readiness

- [ ] `bash scripts/public-readiness-check.sh` läuft grün.
- [ ] Keine privaten Muster im veröffentlichbaren Bereich.
- [ ] Keine Secret-Muster im veröffentlichbaren Bereich.
- [ ] Keine `.DS_Store`, `__MACOSX` oder `.code-review-graph`.
- [ ] Keine `.git`-Historie in `ai-betriebssystem/`, `ai-vault/`, `examples/`, `docs/`, `public-readiness/` oder `scripts/`.
- [ ] `README.md` und `START_HERE.md` erklären den Einstieg.
- [ ] AI Vault kann in Obsidian geöffnet werden.
- [ ] Demo-Projekt zeigt PROJECT.md, AGENTS.md, Ticket 0, Review of Record, PR Closeout und Green Path.
- [ ] Demo-Vault zeigt Projektgedächtnis.
- [ ] Release Readiness ist ehrlich aktualisiert.
