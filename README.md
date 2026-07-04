# AI-Betriebssystem Starter

Dies ist eine neutrale Starter-Installation fuer ein vollstaendiges AI-Betriebssystem mit AI Vault. Sie ist nicht als Light-Version gedacht: Ticket Contract, Review Contract, Label Contract, Green Path Completion, PM Signal Loop, Overnight Operations, Attempt Budget, Subagent Failure Policy, PROJECT.md-first Bootstrap, AGENTS.md Templates, Tool-Bootstrap-Pointer, Builder- und Reviewer-Prompts, Migration Runbooks, Demo-Projekt, Demo-Vault und Public Readiness Checks bleiben erhalten.

## Grundlogik

- GitHub ist die operative Wahrheit.
- Der AI Vault ist Strategie- und Projektgedaechtnis.
- `PROJECT.md` ist der Router fuer jedes Projekt.
- `AGENTS.md` ist der operative Agentenindex.
- Issues sind Arbeit.
- PRs sind Lieferung.
- Evidence entscheidet.
- Der Mensch bleibt das Gate.

## Inhalt

- `ai-betriebssystem/` enthaelt Methode, Contracts, Templates, Prompts, Skills, PM-Loop, Migration und neutrale Beispiele.
- `ai-vault/` ist eine leere, sinnvolle Vault-Erstinstallation fuer Obsidian.
- `examples/demo-project/` zeigt ein neutrales Projekt-Repo mit PROJECT.md, AGENTS.md, Labels, Ticket 0 und PR-Template.
- `examples/demo-vault/` zeigt, wie ein Vault-Projektbereich zum Demo-Projekt aussieht.
- `public-readiness/` dokumentiert Inventar, Sanitization und Release-Checks.
- `scripts/public-readiness-check.sh` prueft private Treffer, Secrets, Pflichtdateien, Pflichtlabels und lokale Altlasten.

## Start

1. Lies `START_HERE.md`.
2. Oeffne `ai-vault/` in Obsidian oder einem Markdown-Editor.
3. Kopiere `examples/demo-project/` als Vorlage fuer dein erstes echtes Projekt.
4. Ersetze Platzhalter wie `<OWNER>/<REPO>`, `<PROJECT_REPO_URL>`, `<LOCAL_CHECKOUT_PATH>` und `<AI_VAULT_PATH>`.
5. Lege Ticket 0 im Projekt-Repo an.
6. Nutze die Label-Semantik aus `ai-betriebssystem/contracts/labels.md` und `ai-betriebssystem/templates/labels.yml`.
7. Fuehre vor jeder Weitergabe `bash scripts/public-readiness-check.sh` aus.

## Wichtige Grenze

Der Starter enthaelt keine privaten Projekte, keine echten Roadmaps, keine echten Issue- oder PR-Historien, keine lokalen Pfade und keine Secrets. Die urspruenglichen lokalen Quellkopien wurden aus dem veroeffentlichbaren Starterbereich entfernt. Falls dieser Ordner selbst noch eine `.git`-Historie enthaelt, ist das in `RELEASE_READINESS.md` als Reinitialisierungsrisiko dokumentiert.

