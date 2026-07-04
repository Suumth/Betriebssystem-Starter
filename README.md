# AI-Betriebssystem Starter

Ein GitHub-zentrierter Starter für KI-gestützte Projektarbeit.

Für Teams und Solo-Builder, die mit KI-Agenten arbeiten wollen, ohne die Kontrolle über Tickets, Pull Requests, Evidence und menschliche Entscheidungen zu verlieren.

Du nutzt dieses Repo als Template, führst einmal `scripts/setup.sh` aus und startest danach Ticket 0 in deinem eigenen Projekt.

## 2-Minuten-Start

1. Klicke [Use this template](https://github.com/Suumth/Betriebssystem-Starter/generate).
2. Erzeuge daraus ein neues Repo für dein Projekt.
3. Klone dein neues Repo lokal.
4. Führe im Repo aus:

```bash
bash scripts/setup.sh
```

Danach hast du:

- `PROJECT.md` als Router für KI-Tools
- `AGENTS.md` mit Arbeitsregeln
- GitHub-Labels und Templates
- einen AI-Vault-Startbereich
- ein erstes Ticket-0-Muster

Weiter geht es mit [`START_HERE.md`](START_HERE.md).

## Was ist das?

Der Starter ist eine öffentliche Erstinstallation für ein AI-Betriebssystem mit AI Vault. Er verbindet GitHub, klare Agentenregeln, Review-Evidence und strategisches Projektgedächtnis.

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

## Was nach dem Setup passiert

1. Du prüfst `setup.local.env`.
2. Du liest `START_HERE.md`.
3. Du öffnest den AI Vault in Obsidian oder einem Markdown-Editor.
4. Du startest Ticket 0.
5. Ein Agent arbeitet auf Basis von `PROJECT.md`, `AGENTS.md` und dem Ticket.
6. Ein Pull Request liefert Evidence.
7. Der Mensch entscheidet über Review, Merge und nächste Schritte.

## Was dieses Repo nicht ist

- kein autonomer Runner
- kein Ersatz für GitHub Issues oder Pull Requests
- kein Ersatz für menschliche Produktentscheidungen
- kein Speicher für private Strategien oder echte Kundendaten
- kein fertiges Dashboard oder SaaS-Produkt

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
