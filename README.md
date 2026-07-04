# AI Operating System Starter

A GitHub-centered starter kit for AI-assisted project work.

Use it when you want AI agents to work on real tickets, produce reviewable pull requests, and stay under human control.

The operating model is simple:

- GitHub is the operational source of truth.
- Issues define the work.
- Pull requests deliver evidence.
- Reviews create decision signals.
- Humans keep the final gate.
- The AI Vault is project memory and strategy, not the task system.

This starter is for teams and solo builders using AI agents without losing control of scope, review, evidence or decisions.

## 2-Minute Start

1. Click [Use this template](https://github.com/Suumth/Betriebssystem-Starter/generate).
2. Create a new repository for your project.
3. Clone your new repository locally.
4. Run the setup script:

```bash
bash scripts/setup.sh
```

After setup you have:

- `PROJECT.md` as the router for AI tools
- `AGENTS.md` with agent rules and boundaries
- GitHub labels and templates
- an AI Vault starter area
- a Ticket 0 pattern for the first agent loop

Continue with [`START_HERE.md`](START_HERE.md).

## What Happens After Setup

1. Review `setup.local.env`.
2. Open `START_HERE.md`.
3. Open the AI Vault in Obsidian or any Markdown editor.
4. Create Ticket 0.
5. Let an AI agent work from `PROJECT.md`, `AGENTS.md` and the ticket.
6. Deliver the result as a pull request with evidence.
7. Keep merge, release and protected decisions behind the Human Gate.

## What This Repo Is Not

- not an autonomous runner
- not a replacement for GitHub Issues or pull requests
- not a replacement for human product decisions
- not a place for private strategies, customer data or credentials
- not a finished dashboard or SaaS product

## Deutsche Kurzfassung

Ein GitHub-zentrierter Starter für KI-gestützte Projektarbeit.

Für Teams und Solo-Builder, die mit KI-Agenten arbeiten wollen, ohne die Kontrolle über Tickets, Pull Requests, Evidence und menschliche Entscheidungen zu verlieren.

Du nutzt dieses Repo als Template, führst einmal `scripts/setup.sh` aus und startest danach Ticket 0 in deinem eigenen Projekt.

Die operative Logik bleibt einfach:

- GitHub ist die operative Wahrheit für Issues, PRs, Labels, Reviews und Evidence.
- Der AI Vault ist Projektgedächtnis und Strategie, nicht der operative Tasklog.
- `PROJECT.md` routet jedes Projekt.
- `AGENTS.md` beschreibt Agentenrollen, Grenzen und Stop-Regeln.
- Issues sind Arbeit.
- PRs sind Lieferung.
- Evidence entscheidet.
- Der Mensch bleibt das Human Gate.

## Für wen?

- Für Produkt- und Engineering-Teams, die Agentenarbeit reproduzierbar machen wollen.
- Für Einzelpersonen, die Projekte mit klaren Tickets, Reviews und Evidence führen wollen.
- Für Organisationen, die AI-Tooling nutzen wollen, ohne operative Wahrheit aus GitHub herauszuziehen.

## Package Contents

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
- `config/` dokumentiert die personalisierbaren Werte und den Placeholder-Contract.
- `examples/demo-project/` zeigt ein neutrales Projekt-Repo mit `PROJECT.md`, `AGENTS.md`, Labels, Ticket 0 und PR-Template.
- `examples/demo-vault/` zeigt, wie ein Vault-Projektbereich zum Demo-Projekt aussieht.
- `docs/first-installation.md` und `docs/first-project.md` erklären die Installation und das erste Projekt im Detail.
- `public-readiness/` dokumentiert Inventar, Sanitization und Release-Checks.
- `scripts/public-readiness-check.sh` prüft private Treffer, sensible Treffer, Pflichtdateien, Pflichtlabels und lokale Altlasten.

## Nach dem Setup

1. Lies `START_HERE.md`.
2. Öffne `ai-vault/` in Obsidian oder einem Markdown-Editor.
3. Füll bei Bedarf `setup.local.env`; die Vorlage liegt in `config/starter.config.example`.
4. Nutze `examples/demo-project/` als Vorlage für dein erstes echtes Projekt.
5. Lege Ticket 0 im Projekt-Repo an.
6. Nutze die Label-Semantik aus `ai-betriebssystem/contracts/labels.md` und `ai-betriebssystem/templates/labels.yml`.
7. Führe vor jeder Weitergabe `bash scripts/public-readiness-check.sh` aus.

## Wichtige Grenze

Der Starter enthält keine privaten Projekte, keine echten Roadmaps, keine echten Issue- oder PR-Historien, keine lokalen Pfade und keine Secrets.
