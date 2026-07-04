# Repo Migration Checklist

Diese Checkliste migriert ein bestehendes Projekt-Repo in den AI-Betriebssystem-2.0-Loop.

## 1. Repo einordnen

- [ ] Repo-Name dokumentiert
- [ ] Projekttyp klar: iOS, macOS, Web, Docs, Marketing
- [ ] Default-Branch bekannt
- [ ] Build-/Test-/Preview-Weg bekannt
- [ ] Release-Risiken bekannt
- [ ] Bei iOS/macOS/Apple-platform-Repos: Xcode 27 Skill-Loading als optionaler Apple-spezifischer Bedarf markiert

## 2. Labels prüfen

Pflichtlabels:

- [ ] `agent:ready`
- [ ] `agent:running`
- [ ] `needs-fix`
- [ ] `needs-human`
- [ ] `blocked`

Optional:

- [ ] `lane:ios`
- [ ] `lane:macos`
- [ ] `lane:web`
- [ ] `lane:docs`
- [ ] `lane:marketing`

## 3. Repo-Regeln ergänzen

- [ ] `AGENTS.md` im Projekt-Repo angelegt
- [ ] Operating Principle enthalten
- [ ] Ticket Maturity Rule enthalten
- [ ] Builder-Regeln enthalten
- [ ] Review-Regeln enthalten
- [ ] Evidence-Regeln enthalten
- [ ] repo-spezifische Build-/Testbefehle ergänzt
- [ ] Bei iOS/macOS/Apple-platform-Repos: `AGENTS.md` Loading Map verweist bedingt auf die Xcode 27 Skill-Note

## 4. Issue-Template ergänzen

- [ ] Ziel
- [ ] Scope
- [ ] Nicht-Ziele
- [ ] Skills
- [ ] Akzeptanzkriterien
- [ ] Validierung
- [ ] Evidence
- [ ] Closeout

## 5. Erstes Smoke-Test-Ticket

- [ ] kleiner, ungefährlicher Scope
- [ ] klare Validierung
- [ ] klare Evidence
- [ ] `agent:ready` gesetzt

## 6. Erster Loop

- [ ] Codex bearbeitet genau ein Ticket
- [ ] PR enthält `Closes #...`
- [ ] PR enthält Validierung
- [ ] PR enthält Evidence
- [ ] Claude Code reviewed gegen Issue
- [ ] genau eine Ampel gesetzt
- [ ] Mensch entscheidet

## 7. Danach

- [ ] Lessons nur bei Bedarf als PR in Methoden-Repo übernehmen
- [ ] keine operative Ticketliste im Vault pflegen
- [ ] keine Runner-/Dashboard-Logik ergänzen
- [ ] keine Xcode 27 Skill-Pflicht fuer Nicht-Apple-Tickets einfuehren

## Pilot-Empfehlung

Zuerst ein risikoarmes Web- oder Dokumentationsrepo migrieren. iOS erst nach einem lokalen Readiness-Ticket für Xcode, Simulator und Screenshot-Evidence.
