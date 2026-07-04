# START HERE

This is the second-level method guide.

If you are new, start with `FIRST_LOOP.md` first. Do not learn the whole system before trying it. Run one safe loop, open one PR, stop at Human Gate, then come back here to understand the deeper operating model.

## Try First

- `FIRST_LOOP.md` gives you one primary path: setup, Ticket 0, Builder prompt, one tiny evidence-backed change, PR review and Human Gate.

## Then Understand

Use this file after the first loop to understand how the starter connects three sources:

1. Project repo: GitHub is the operational source of truth for Issues, PRs, code, labels, reviews and evidence.
2. AI Vault: project memory for strategy, target picture, decisions, risks, lessons and research.
3. AI operating system: method, contracts, templates, prompts, PM loop and readiness rules.

The AI Vault is useful after the first loop. It is not required before the first PR.

## Reference

- `PROJECT.md` routes each project.
- `AGENTS.md` defines agent roles, boundaries and stop rules.
- Review of Record creates the decision signal.
- Human Gate stays with the operator for merge, release and protected decisions.
- Contracts, prompts and docs in `ai-betriebssystem/` are reference material once the first loop works.

## Deutsche Kurzfassung

Dieses Paket richtet ein AI-Betriebssystem wie eine saubere Erstinstallation ein. Es verbindet drei Quellen:

1. Projekt-Repo: operative Wahrheit für Issues, PRs, Code, Labels, Reviews und Evidence.
2. AI Vault: Projektgedächtnis für Strategie, Zielbild, Entscheidungen, Risiken, Lessons und Research.
3. AI-Betriebssystem: Methode, Contracts, Templates, Prompts, PM-Loop und Readiness-Regeln.

## In 30 Minuten zum ersten Projekt

1. Starte mit `FIRST_LOOP.md`, wenn du neu bist.
2. Öffne nach dem ersten PR `ai-vault/00_START_HERE.md` und lies die Vault-Rollen.
3. Kopiere `ai-vault/02_Projects/_PROJECT_TEMPLATE/` in einen neuen Projektordner im Vault.
4. Kopiere `examples/demo-project/` in dein neues Projekt-Repo oder übernimm die Dateien einzeln.
5. Passe im Projekt-Repo `PROJECT.md` an. Diese Datei sagt jedem AI-Tool, wo operative Wahrheit, Vault und Methode liegen.
6. Passe `AGENTS.md` an. Diese Datei legt fest, welche Agentenrollen, Grenzen und Tool-Regeln im Repo gelten.
7. Importiere die Labels aus `examples/demo-project/.github/labels.yml`.
8. Erstelle Ticket 0 mit `examples/demo-project/docs/ticket-0-example.md` als Vorlage, falls setup es nicht erstellt hat.
9. Bearbeite Ticket 0 mit Builder-Prompt und Review of Record getrennt.
10. Liefere per PR. Die PR-Beschreibung muss Validation Evidence, Risiken, Human Gate und Review-Empfehlung enthalten.
11. Nach Merge fließen echte Erkenntnisse in Vault-Dateien wie `Entscheidungen.md`, `Risiken.md` und `Lessons-Learned.md` zurück.

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
