# AI-Betriebssystem Starter

Ein neutraler Starter für Teams, die AI-Agentenarbeit über GitHub, klare Tickets, Evidence und verbindliche Human Gates steuern wollen.

## Schnellstart

1. Klicke [Use this template](https://github.com/Suumth/Betriebssystem-Starter/generate).
2. Erzeuge daraus dein neues GitHub-Repo.
3. Klone das neue Repo lokal und wechsle in den Repo-Ordner.
4. Führe genau diesen Setup-Befehl aus:

```bash
bash scripts/setup.sh
```

Danach führt dich `START_HERE.md` durch das erste Projekt und Ticket 0.

## Was ist das?

Der Starter ist eine öffentliche Erstinstallation für ein AI-Betriebssystem mit AI Vault. Er bringt Methode, Contracts, Templates, Prompts, Demo-Projekt, Demo-Vault und Readiness-Checks mit.

Die operative Logik bleibt einfach:

- GitHub ist die operative Wahrheit für Issues, PRs, Labels, Reviews und Evidence.
- Der AI Vault ist Projektgedächtnis und Strategie, nicht der operative Tasklog.
- `PROJECT.md` routet jedes Projekt.
- `AGENTS.md` beschreibt Agentenrollen, Grenzen und Stop-Regeln.
- Issues sind Arbeit.
- PRs sind Lieferung.
- Evidence entscheidet.
- Der Mensch bleibt das Human Gate.

## Für wen ist es?

- Für Produkt- und Engineering-Teams, die Agentenarbeit reproduzierbar machen wollen.
- Für Einzelpersonen, die Projekte mit klaren Tickets, Reviews und Evidence führen wollen.
- Für Organisationen, die AI-Tooling nutzen wollen, ohne operative Wahrheit aus GitHub herauszuziehen.

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

## Was ist enthalten?

- `START_HERE.md` ist der vertiefende Einstieg nach dem Quickstart.
- `ai-betriebssystem/` enthält Methode, Contracts, Templates, Prompts, Skills, PM-Loop, Migration und neutrale Beispiele.
- `ai-vault/` ist eine leere, sinnvolle Vault-Erstinstallation für Obsidian oder einen Markdown-Editor.
- `examples/demo-project/` zeigt ein neutrales Projekt-Repo mit `PROJECT.md`, `AGENTS.md`, Labels, Ticket 0 und PR-Template.
- `examples/demo-vault/` zeigt, wie ein Vault-Projektbereich zum Demo-Projekt aussieht.
- `docs/first-installation.md` und `docs/first-project.md` erklären die Installation und das erste Projekt im Detail.
- `public-readiness/` dokumentiert Inventar, Sanitization und Release-Checks.
- `scripts/public-readiness-check.sh` prüft private Treffer, sensible Treffer, Pflichtdateien, Pflichtlabels und lokale Altlasten.

## Nach dem Setup

1. Lies `START_HERE.md`.
2. Öffne `ai-vault/` in Obsidian oder einem Markdown-Editor.
3. Nutze `examples/demo-project/` als Vorlage für dein erstes echtes Projekt.
4. Lege Ticket 0 im Projekt-Repo an.
5. Nutze die Label-Semantik aus `ai-betriebssystem/contracts/labels.md` und `ai-betriebssystem/templates/labels.yml`.
6. Führe vor jeder Weitergabe `bash scripts/public-readiness-check.sh` aus.

## Wichtige Grenze

Der Starter enthält keine privaten Projekte, keine echten Roadmaps, keine echten Issue- oder PR-Historien, keine lokalen Pfade und keine Secrets.
