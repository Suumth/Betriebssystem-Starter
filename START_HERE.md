# START HERE

Dieses Paket richtet ein AI-Betriebssystem wie eine saubere Erstinstallation ein. Es verbindet drei Quellen:

1. Projekt-Repo: operative Wahrheit für Issues, PRs, Code, Labels, Reviews und Evidence.
2. AI Vault: Projektgedächtnis für Strategie, Zielbild, Entscheidungen, Risiken, Lessons und Research.
3. AI-Betriebssystem: Methode, Contracts, Templates, Prompts, PM-Loop und Readiness-Regeln.

## In 30 Minuten zum ersten Projekt

1. Öffne `ai-vault/00_START_HERE.md` und lies die Vault-Rollen.
2. Kopiere `ai-vault/02_Projects/_PROJECT_TEMPLATE/` in einen neuen Projektordner im Vault.
3. Kopiere `examples/demo-project/` in dein neues Projekt-Repo oder übernimm die Dateien einzeln.
4. Passe im Projekt-Repo `PROJECT.md` an. Diese Datei sagt jedem AI-Tool, wo operative Wahrheit, Vault und Methode liegen.
5. Passe `AGENTS.md` an. Diese Datei legt fest, welche Agentenrollen, Grenzen und Tool-Regeln im Repo gelten.
6. Importiere die Labels aus `examples/demo-project/.github/labels.yml`.
7. Erstelle Ticket 0 mit `examples/demo-project/docs/ticket-0-example.md` als Vorlage.
8. Bearbeite Ticket 0 mit Builder-Prompt und Review of Record getrennt.
9. Liefere per PR. Die PR-Beschreibung muss Validation Evidence, Risiken, Human Gate und Review-Empfehlung enthalten.
10. Nach Merge fließen echte Erkenntnisse in Vault-Dateien wie `Entscheidungen.md`, `Risiken.md` und `Lessons-Learned.md` zurück.

## Was Codex macht

Codex kann Tickets ausführen, Dateien ändern, lokale Checks laufen lassen, Evidence sammeln und PR-Text vorbereiten. Codex ersetzt aber nicht den Review of Record und nicht die menschliche Freigabe für geschützte Bereiche, Releases, Kosten, Accounts oder irreversible Aktionen.

## Fortgeschrittene Funktionen

- Green Path Completion: `ai-betriebssystem/docs/green-path-completion.md`
- PM Signal Loop: `ai-betriebssystem/docs/pm/pm-signal-loop.md`
- Overnight Operations Mode: `ai-betriebssystem/docs/overnight-operations-mode.md`
- Attempt Budget & Escalation: `ai-betriebssystem/docs/loop-readiness.md`
- Subagent Failure Policy: `ai-betriebssystem/contracts/ticket-contract.md`
- Operator Merge Policy: `ai-betriebssystem/docs/operator-merge-policy.md`
- Model Resource Policy: `ai-betriebssystem/docs/model-resource-policy.md`
