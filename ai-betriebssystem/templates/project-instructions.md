# Repo-Based Project Instruction Template

Diese Vorlage wird im jeweiligen Projekt-Repo als kanonische Projektanweisung abgelegt, bevorzugt als `PROJECT.md`. Alternativ ist `docs/project-instructions.md` erlaubt, wenn das Projekt diesen Pfad explizit im Startpaket und in Tool-Bootstrap-Anweisungen nennt.

Die Datei muss über GitHub erreichbar sein. Cloud-KIs wie ChatGPT, Claude oder Gemini bekommen eine GitHub-URL zu dieser Datei, keinen lokalen Pfad.

Tool-spezifische Projektanweisungen für ChatGPT, Claude, Codex oder spätere KI-Tools dürfen nur auf diese Datei zeigen. Kein KI-Tool bekommt eigene Sonderwahrheit.

## Project Identity

- Project:
- Canonical instruction path: `PROJECT.md`
- Canonical instruction GitHub URL:
- Local instruction path for Codex fallback:
- Project repo GitHub URL:
- AI-OS method repo GitHub URL: `<AI_OS_METHOD_REPO_URL>`
- AI Vault canonical project folder:
- AI Vault online entrypoint for Cloud KIs:
- AI Vault key files: strategy, target picture, decisions, non-goals, risks, roadmap, product brief

## Online-first Source Policy

- Tool-spezifische Projektanweisungen für ChatGPT, Claude, Gemini und andere Cloud-KIs dürfen keine lokalen Pfade referenzieren.
- Sie müssen auf die GitHub-URL dieser repo-basierten Projektanweisung verweisen.
- Diese repo-basierte Projektanweisung muss daher über GitHub erreichbar sein, z. B. als `PROJECT.md` oder `docs/project-instructions.md`.
- Lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` sind ausschließlich Fallbacks für lokale Agenten wie Codex.
- Jede KI erhält dieselbe minimale Bootstrap-Anweisung: zuerst diese Projektanweisung über GitHub lesen, danach ausschließlich nach den hier definierten Quellen arbeiten.

## Drei-Quellen-Router

1. AI-Betriebssystem repo
   - Rolle: Methode, Ticket-Schnitt, Agent Contract, Green Path, Review, Evidence, Labels, Prompts und Templates.
   - Hier klären: Wie Arbeit geschnitten, validiert, reviewed, geschlossen und nach Merge hygienisch fortgesetzt wird.
2. Projekt-Repo
   - Rolle: operative Wahrheit.
   - Hier klären: Issues, PRs, Kommentare, Labels, AGENTS.md, Code, Repo-Dateien, Build-/Test-Evidence und aktueller Status.
3. AI Vault
   - Rolle: Strategie und Produktgedächtnis.
   - Hier klären: Strategie, Zielbild, Produktentscheidungen, Nicht-Ziele, langfristige Risiken, Roadmap und Produktbrief.

## AI Vault Access for Cloud KIs

Der AI Vault bleibt die kanonische Wahrheit für Strategie, Zielbild und Produktgedächtnis. Cloud-KIs können lokale Vault-Pfade aber nicht lesen.

AI-Vault-Inhalte, die ChatGPT, Claude, Gemini oder andere Cloud-KIs benötigen, müssen deshalb online erreichbar gemacht werden:

- als GitHub-Dateien,
- über GitHub referenziert,
- oder in geeigneter Form ins Projekt-Repo gespiegelt.

Die Spiegelung ist ein Online-Einstieg für KI-Tools, nicht die neue strategische Wahrheit. Wenn Spiegelung und AI Vault abweichen, muss der Unterschied als Aktualisierungsbedarf markiert werden.

## Key Sources

| Source | GitHub URL / online entrypoint | Local fallback for Codex | Purpose |
|---|---|---|---|
| AI-Betriebssystem |  |  | Method source |
| Project repo |  |  | Operational source |
| Project AGENTS.md |  |  | Repo operating rules |
| Project Brief |  |  | Source map and compact brief |
| Xcode 27 skill note, Apple projects only | GitHub URL of `skills/xcode-27.md` or project-local equivalent | Local Codex fallback/reference only, if present | Conditional Apple-platform skill routing |
| AI Vault online entrypoint |  |  | Strategy and product memory entrypoint |
| AI Vault strategy |  |  | Strategy reference |
| AI Vault target picture |  |  | Target-picture reference |
| AI Vault decisions |  |  | Decision reference |
| AI Vault non-goals |  |  | Non-goals reference |
| AI Vault risks/roadmap |  |  | Risk and roadmap reference |
| AI Vault product brief |  |  | Product-memory reference |

## Working Rules

- Vor Ticket-Erstellung relevante Quellen prüfen: Methode im AI-Betriebssystem, operative Lage im Projekt-Repo, strategischen Kontext im AI Vault.
- Tickets nach dem AI-Betriebssystem Ticket Contract und den Regeln aus `AGENTS.md` im Projekt-Repo schneiden.
- Ein Ticket bekommt nur `agent:ready`, wenn Ziel, Boundary, Nicht-Ziele, Akzeptanzkriterien, Validierung, Evidence, Closeout und Stop condition klar sind.
- Bei Unsicherheit grillen, nicht bauen: erst Begriffe, Scope, Produktentscheidung oder fehlende Evidence klären.
- Keine neue Projektwahrheit im KI-Tool erfinden. Unklare Punkte als Fragen, Issue-Vorschläge oder Decision-/Vault-Update-Vorschläge ausgeben.
- Keine erledigte Arbeit behaupten ohne Repo-Evidence: Issue, PR, Commit, Review, Closeout oder versionierte Datei.
- Nach erfolgreichem grünem Merge endet der Green Path erst nach lokaler Hygiene: `git checkout main`, `git pull --ff-only origin main`, `git status`, danach nächstes bearbeitbares Ticket oder dokumentierter Stop.

## No-Duplication Rule

- Tool-spezifische Projektanweisungen sind nur Bootstrap-Pointer auf diese Datei.
- Tool-spezifische Projektanweisungen für Cloud-KIs zeigen auf die GitHub-URL dieser Datei, nicht auf lokale Pfade.
- Diese Datei verweist auf Projektwahrheit, statt lange Strategie oder Roadmaps zu kopieren.
- Strategische Wahrheit gehört in den AI Vault, nicht in Tool-Anweisungen und nicht in zufällige Issue-Kommentare.
- Operative Wahrheit gehört ins Projekt-Repo, nicht in ChatGPT-, Claude-, Codex- oder andere Tool-Anweisungen.
- Methodische Wahrheit gehört ins AI-Betriebssystem-Repo.

## Expected Output

- reife GitHub-Issues
- knappe Entscheidungsvorlagen
- Review-/PM-Signale mit belegbarer Evidence
- keine duplizierte Produktdokumentation in Tool-Projektanweisungen
