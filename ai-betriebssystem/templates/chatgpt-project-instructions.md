# Tool Project Instruction Template

Diese Vorlage ist fuer ChatGPT-, Claude-, Gemini- oder andere Cloud-KI-Projektanweisungen gedacht. Sie bleibt absichtlich winzig: Das KI-Tool bekommt nur einen Online-Bootstrap-Pointer auf die repo-basierte Projektanweisung.

## Copy Template

```text
Lies zuerst die repo-basierte Projektanweisung:
PROJECT_INSTRUCTION_GITHUB_URL

Arbeite danach ausschliesslich nach dieser Anweisung und den dort verlinkten Quellen.
Dupliziere keine Projektwahrheit in diese Tool-Anweisung.
Kein KI-Tool bekommt eigene Sonderwahrheit.
```

## Fill-In Rules

- `PROJECT_INSTRUCTION_GITHUB_URL` auf die kanonische Projektanweisung im Projekt-Repo setzen, bevorzugt die GitHub-URL zu `PROJECT.md`.
- Falls das Projekt bewusst einen anderen Pfad nutzt, z. B. `docs/project-instructions.md`, muss die GitHub-URL auf genau diesen Pfad zeigen.
- Tool-spezifische Projektanweisungen duerfen keine lokalen Pfade wie `<LOCAL_CHECKOUT_PATH>` referenzieren.
- Lokale Pfade sind ausschliesslich Fallbacks fuer lokale Agenten wie Codex und gehoeren nicht in Cloud-KI-Projektanweisungen.
- Keine Produktdetails, Roadmap, Ticketliste, Strategie, Build-Logs oder Tool-Sonderregeln in diese Tool-Anweisung kopieren.
- Die repo-basierte Projektanweisung enthaelt den Drei-Quellen-Router: AI-Betriebssystem, Projekt-Repo und AI Vault mit online erreichbaren Einstiegspunkten fuer Cloud-KIs.

## Anti-Patterns

Nicht in Tool-Projektanweisungen aufnehmen:

- vollstaendige Produktstrategie
- aktuelle Roadmap
- offene Ticketliste
- Architekturdetails
- Build- und Testlogs
- lokale Dateipfade wie `<LOCAL_CHECKOUT_PATH>`
- AI-Vault-Inhalte als Kopie
- tool-spezifische Sonderwahrheit fuer ChatGPT, Claude, Codex oder spaetere KI-Tools

Stattdessen gehoeren diese Inhalte in die repo-basierte Projektanweisung oder in die dort verlinkten Quellen.
