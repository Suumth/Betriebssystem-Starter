# First Installation

## Ziel

Am Ende hast du ein Projekt-Repo mit `PROJECT.md`, `AGENTS.md`, Labels, Ticket 0, PR-Template und einem leeren Vault-Projektbereich.

## Voraussetzungen

- Ein GitHub-Repo für operative Arbeit.
- Einen lokalen Markdown-Editor oder Obsidian für den Vault.
- Ein lokales AI-Tool wie Codex, Claude Code oder ein anderes Tool, das Repo-Dateien lesen kann.
- Optional: `gh`, wenn das Setup Labels importieren oder Ticket 0 für dich anlegen soll. Der Starter führt Remote-GitHub-Aktionen nur aus, wenn du optionale Setup-Schritte ausdrücklich aktivierst und `gh` authentifiziert ist.

## Installation

1. Lege ein neues privates Methodenrepo oder einen lokalen Starterordner an.
2. Kopiere den Inhalt dieses Starters hinein.
3. Initialisiere Git frisch, wenn du den Starter veröffentlichen oder weiterentwickeln willst.
4. Öffne `ai-vault/` in Obsidian.
5. Lege dein erstes Projekt anhand von `docs/first-project.md` an.
6. Öffne `FIRST_LOOP.md` und starte Ticket 0 mit dem Builder-Prompt aus der Setup-Ausgabe.
7. Führe nach dem Setup optional `bash scripts/post-setup-check.sh` aus, um nicht aufgelöste Platzhalter außerhalb der Template-Bereiche zu finden.

## Optional: Branch Protection

Nach dem ersten erfolgreichen CI- und PR-Contract-Lauf kannst du Branch Protection bewusst als Operator-Entscheidung aktivieren. Der Helfer ist dokumentiert in `ai-betriebssystem/docs/branch-protection-helper.md`.

## Reinitialisierung

Wenn in diesem Ordner bereits `.git` existiert, übernimm diese Historie nicht ungeprüft in ein neues Repo. Erstelle für ein finales Starter-Repo einen frischen Git-Stand und importiere nur die neutralen Dateien.
