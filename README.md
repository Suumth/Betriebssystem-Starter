# AI-Betriebssystem Starter

Dies ist eine neutrale Starter-Installation für ein AI-Betriebssystem mit AI Vault. Sie enthält Ticket Contract, Review Contract, Label Contract, Green Path Completion, PM Signal Loop, Overnight Operations, Attempt Budget, Subagent Failure Policy, PROJECT.md-first Bootstrap, AGENTS.md Templates, Tool-Bootstrap-Pointer, Builder- und Reviewer-Prompts, Migration Runbooks, Demo-Projekt, Demo-Vault und Public Readiness Checks.

## English Summary

This starter repository provides a neutral first installation of an AI operating system for project work.

It follows a simple operating principle: GitHub is the operational source of truth. Issues define the work, pull requests deliver evidence, reviews create a clear decision signal, and the human operator keeps the final gate.

The package includes:

- an AI operating system method folder with contracts, templates, prompts, skills, PM loops and migration notes
- an AI Vault starter structure for strategy, decisions, risks, lessons and project memory
- a demo project with `PROJECT.md`, `AGENTS.md`, labels, ticket example and PR template
- a demo vault showing how project context can be structured outside the operative repo
- public readiness checks to keep the starter package clean before sharing

The goal is not to replace GitHub, Jira, Obsidian or AI tools. The goal is to connect them with a small, explicit operating model so AI agents can work on real tickets, produce reviewable results and remain under human control.

## Grundlogik

- GitHub ist die operative Wahrheit.
- Der AI Vault ist Strategie- und Projektgedächtnis.
- `PROJECT.md` ist der Router für jedes Projekt.
- `AGENTS.md` ist der operative Agentenindex.
- Issues sind Arbeit.
- PRs sind Lieferung.
- Evidence entscheidet.
- Der Mensch bleibt das Gate.

## Inhalt

- `ai-betriebssystem/` enthält Methode, Contracts, Templates, Prompts, Skills, PM-Loop, Migration und neutrale Beispiele.
- `ai-vault/` ist eine leere, sinnvolle Vault-Erstinstallation für Obsidian.
- `examples/demo-project/` zeigt ein neutrales Projekt-Repo mit PROJECT.md, AGENTS.md, Labels, Ticket 0 und PR-Template.
- `examples/demo-vault/` zeigt, wie ein Vault-Projektbereich zum Demo-Projekt aussieht.
- `public-readiness/` dokumentiert Inventar, Sanitization und Release-Checks.
- `scripts/public-readiness-check.sh` prüft private Treffer, Secrets, Pflichtdateien, Pflichtlabels und lokale Altlasten.

## Start

1. Lies `START_HERE.md`.
2. Öffne `ai-vault/` in Obsidian oder einem Markdown-Editor.
3. Kopiere `examples/demo-project/` als Vorlage für dein erstes echtes Projekt.
4. Ersetze Platzhalter wie `<OWNER>/<REPO>`, `<PROJECT_REPO_URL>`, `<LOCAL_CHECKOUT_PATH>` und `<AI_VAULT_PATH>`.
5. Lege Ticket 0 im Projekt-Repo an.
6. Nutze die Label-Semantik aus `ai-betriebssystem/contracts/labels.md` und `ai-betriebssystem/templates/labels.yml`.
7. Führe vor jeder Weitergabe `bash scripts/public-readiness-check.sh` aus.

## Wichtige Grenze

Der Starter enthält keine privaten Projekte, keine echten Roadmaps, keine echten Issue- oder PR-Historien, keine lokalen Pfade und keine Secrets.
