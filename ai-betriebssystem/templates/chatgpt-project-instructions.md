# Tool Project Instruction Template

Diese Vorlage ist für ChatGPT-, Claude-, Gemini- oder andere Cloud-KI-Projektanweisungen gedacht. Sie bleibt absichtlich winzig: Das KI-Tool bekommt nur einen Online-Bootstrap-Pointer auf die repo-basierte Projektanweisung.

## Copy Template

```text
Lies zuerst die repo-basierte Projektanweisung:
PROJECT_INSTRUCTION_GITHUB_URL

Arbeite danach ausschließlich nach dieser Anweisung und den dort verlinkten Quellen.
Dupliziere keine Projektwahrheit in diese Tool-Anweisung.
Kein KI-Tool bekommt eigene Sonderwahrheit.
```

## Fill-In Rules

- `PROJECT_INSTRUCTION_GITHUB_URL` auf die kanonische Projektanweisung im Projekt-Repo setzen, bevorzugt die GitHub-URL zu `PROJECT.md`.
- Falls das Projekt bewusst einen anderen Pfad nutzt, z. B. `docs/project-instructions.md`, muss die GitHub-URL auf genau diesen Pfad zeigen.
- Tool-spezifische Projektanweisungen dürfen keine lokalen Pfade wie `<LOCAL_CHECKOUT_PATH>` referenzieren.
- Lokale Pfade sind ausschließlich Fallbacks für lokale Agenten wie Codex und gehören nicht in Cloud-KI-Projektanweisungen.
- Keine Produktdetails, Roadmap, Ticketliste, Strategie, Build-Logs oder Tool-Sonderregeln in diese Tool-Anweisung kopieren.
- Die repo-basierte Projektanweisung enthält den Drei-Quellen-Router: AI-Betriebssystem, Projekt-Repo und AI Vault mit online erreichbaren Einstiegspunkten für Cloud-KIs.

## Anti-Patterns

Nicht in Tool-Projektanweisungen aufnehmen:

- vollständige Produktstrategie
- aktuelle Roadmap
- offene Ticketliste
- Architekturdetails
- Build- und Testlogs
- lokale Dateipfade wie `<LOCAL_CHECKOUT_PATH>`
- AI-Vault-Inhalte als Kopie
- tool-spezifische Sonderwahrheit für ChatGPT, Claude, Codex oder spätere KI-Tools

Stattdessen gehören diese Inhalte in die repo-basierte Projektanweisung oder in die dort verlinkten Quellen.
