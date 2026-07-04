# Project Start Pack

Dieses Startpaket richtet ein neues Projekt-Repo für den AI-Betriebssystem-2.0-Loop ein. Es erzeugt keine Runtime, keinen Runner und kein Dashboard.

## Ziel

Nach dieser Checkliste hat ein neues Repo genug Substrate, damit jedes KI-Tool denselben Online-Einstieg nutzt: zuerst die repo-basierte Projektanweisung über GitHub, danach die dort verlinkten Quellen.

## 1. Repo-Grundlagen

- [ ] GitHub-Repo angelegt
- [ ] Default-Branch bekannt
- [ ] lokaler Checkout vorhanden
- [ ] Build-/Test-/Preview-Weg bekannt oder bewusst als offen markiert
- [ ] README beschreibt nur den noetigen Einstieg

## 2. Repo-basierte Projektanweisung

- [ ] Kanonischer Pfad gewaehlt: `PROJECT.md` oder explizit `docs/project-instructions.md`
- [ ] `PROJECT.md` aus `templates/PROJECT.md` angelegt
- [ ] kanonische Projektanweisung über GitHub erreichbar
- [ ] GitHub-URL der kanonischen Projektanweisung eingetragen
- [ ] lokaler Pfad nur als Codex-Fallback eingetragen, falls noetig
- [ ] AI-Betriebssystem-Repo GitHub-URL als Methodenquelle eingetragen
- [ ] Projekt-Repo GitHub-URL als operative Quelle eingetragen
- [ ] AI Vault Projektordner als kanonische Strategie- und Produktgedächtnisquelle eingetragen
- [ ] AI Vault Online-Einstieg für Cloud-KIs eingetragen
- [ ] AI Vault Schluesseldateien verlinkt:
  - [ ] Strategie:
  - [ ] Zielbild:
  - [ ] Entscheidungen:
  - [ ] Nicht-Ziele:
  - [ ] Risiken:
  - [ ] Roadmap:
  - [ ] Produktbrief:
- [ ] Project Brief und `AGENTS.md` verlinkt
- [ ] Online-first Source Policy enthalten:
  - [ ] Tool-Anweisungen für ChatGPT, Claude, Gemini usw. referenzieren keine lokalen Pfade
  - [ ] Tool-Anweisungen zeigen auf die GitHub-URL der kanonischen Projektanweisung
  - [ ] lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` sind nur Fallbacks für lokale Agenten wie Codex
- [ ] Drei-Quellen-Router enthalten:
  - [ ] AI-Betriebssystem = Methode, Ticket-Schnitt, Green Path, Review, Evidence
  - [ ] Projekt-Repo = Issues, PRs, Labels, AGENTS.md, Code, operative Evidence und Status
  - [ ] AI Vault = Strategie, Zielbild, Entscheidungen, Nicht-Ziele, Risiken, Roadmap und Produktgedächtnis
- [ ] AI-Vault-Inhalte, die Cloud-KIs brauchen, sind als GitHub-Dateien, GitHub-Referenzen oder geeignete Projekt-Repo-Spiegelung erreichbar
- [ ] No-Duplication-Regel enthalten: Kein KI-Tool bekommt eigene Sonderwahrheit
- [ ] Tool-Anweisungen dürfen nur auf diese repo-basierte Projektanweisung zeigen
- [ ] Wenn Projekttyp iOS/macOS/Apple-platform ist: Xcode 27 Skill-Note als GitHub-URL in der Source Map verlinken und lokalen Xcode-27-Referenzpfad nur als Codex/local-agent fallback markieren

## 3. Root Agent Index

- [ ] `AGENTS.md` im Projekt-Repo aus `templates/AGENTS.md` übernommen
- [ ] repo-spezifische Build-, Test- und Preview-Befehle ergänzt
- [ ] Loading Map nur auf tatsaechlich vorhandene Repo-Dateien verlinkt
- [ ] Bei iOS/macOS/Apple-platform-Repos: bedingte Loading-Map-Regel für Xcode 27 Skills ergänzt
- [ ] Protected Areas entweder benannt oder als "keine bekannt" markiert

## 4. Labels

- [ ] `.github/labels.yml` oder manuelle Labels angelegt
- [ ] `agent:ready`
- [ ] `agent:running`
- [ ] `needs-fix`
- [ ] `needs-human`
- [ ] `blocked`
- [ ] `review:pass`
- [ ] `auto-merge:ok`
- [ ] optionale Lane-Tags nur bei echtem Nutzen angelegt

## 5. Issue Template

- [ ] Issue Template aus `templates/github_issue_task.md` übernommen
- [ ] PR Template aus `templates/pull-request-template.md` übernommen oder PR-Body-Standard im Repo dokumentiert
- [ ] Ticket Contract sichtbar
- [ ] Closeout Requirements sichtbar
- [ ] Review Recommendation sichtbar
- [ ] Stop condition sichtbar

## 6. Project Brief

- [ ] `docs/project-brief.md` aus `templates/project-brief.md` angelegt
- [ ] Produktname und Repo URL eingetragen
- [ ] kanonische repo-basierte Projektanweisung verlinkt
- [ ] GitHub-URL der kanonischen repo-basierten Projektanweisung verlinkt
- [ ] AI Vault Projektordner und Schluesseldateien referenziert, nicht kopiert
- [ ] AI Vault Schluesseldateien enthalten Strategie, Zielbild, Entscheidungen, Nicht-Ziele, Risiken, Roadmap und Produktbrief
- [ ] AI Vault Dateien aus `templates/ai-vault/` angelegt oder auf bestehende gleichwertige Dateien gemappt
- [ ] Online-Einstieg für AI-Vault-Inhalte verlinkt, die Cloud-KIs benoetigen
- [ ] Zielbild und Zielnutzer knapp beschrieben
- [ ] Nicht-Ziele benannt
- [ ] Protected Areas benannt
- [ ] Validierungsarten konkretisiert
- [ ] Design-/Qualitaetsbar konkretisiert
- [ ] Startzustand und offene Risiken eingetragen

## 7. Tool-Projektanweisungen

- [ ] ChatGPT-Projekt angelegt
- [ ] ChatGPT-Projektanweisung aus `templates/chatgpt-project-instructions.md` kopiert
- [ ] `PROJECT_INSTRUCTION_GITHUB_URL` auf die GitHub-URL der repo-basierten Projektanweisung gesetzt
- [ ] Claude-/Codex-/andere KI-Projektanweisungen nutzen denselben minimalen Pointer, falls vorhanden
- [ ] keine lokalen Pfade wie `<LOCAL_CHECKOUT_PATH>` in Cloud-KI-Projektanweisungen verwendet
- [ ] keine langen Produktdetails in Tool-Projektanweisungen kopiert
- [ ] keine tool-spezifische Sonderwahrheit eingefuehrt
- [ ] alle Tool-Anweisungen sagen: zuerst repo-basierte Projektanweisung über GitHub lesen und danach nach ihr arbeiten

## 8. Ticket Null

Ticket Null ist der erste kleine Beweis, dass das Repo agentenfaehig ist.

- [ ] Ticket Null aus `templates/ticket-0-bootstrap.md` erstellt
- [ ] Scope risikoarm
- [ ] Mode: `EXECUTING`
- [ ] Risk lane: `low`
- [ ] klarer Verifier
- [ ] klare Evidence
- [ ] keine Produktentscheidung noetig
- [ ] `agent:ready` erst nach vollständigem Ticket Contract gesetzt

Gute Ticket-Null-Beispiele:

- Docs-only Scope-Check
- Build-/Test-Smoke ohne Feature-Aenderung
- Screenshot-/Preview-Smoke für UI-Produkte
- AGENTS.md- und Issue-Template-Installation mit Markdown-Prüfung

## 9. Optional: Design Evidence Loop

Nur für UI-Produkte aktivieren.

- [ ] Referenz-Screens oder Designquelle benannt
- [ ] erwarteter sichtbarer Zustand beschrieben
- [ ] Screenshot-/Preview-Evidence definiert
- [ ] Claim- und Copy-Grenzen festgelegt

Nicht für reine Backend-, Docs- oder Methoden-Repos erzwingen.

## 10. Lokale Codex-Projektkonfiguration

- [ ] lokaler Repo-Pfad in Codex korrekt
- [ ] relevante Build-/Testtools lokal verfuegbar oder als fehlend dokumentiert
- [ ] keine Vault-Dateien als operative Kontextquelle eingebunden
- [ ] keine geheimen Tokens in Repo-Dateien oder Projektanweisungen

## 11. Green Path Completion

- [ ] Nach erfolgreichem grünem Merge fuehrt Codex lokale Hygiene ohne Rueckfrage aus
- [ ] `git checkout main`
- [ ] `git pull --ff-only origin main`
- [ ] `git status`
- [ ] bei sauberem `main` nächstes `needs-fix`, `agent:running` oder genau ein neues `agent:ready` suchen
- [ ] wenn kein nächstes Ticket existiert, Idle-/Complete-Zustand dokumentieren
- [ ] Stop-Gründe aus `docs/green-path-completion.md` bekannt

## 12. Batch Green Path Execution

- [ ] Batch Green Path Execution nur bei ausdRücklichem Nutzerauftrag verwenden
- [ ] Batch-Groesse kommt aus dem Nutzerauftrag, nicht aus einer festen Zahl
- [ ] nach jedem grünen PR den PR Review of Record prüfen
- [ ] Merge gemaess Green-Path-Regel durchfuehren
- [ ] `git checkout main`
- [ ] `git pull --ff-only origin main`
- [ ] `git status`
- [ ] nur bei sauberem `main` das nächste beauftragte ready Ticket übernehmen
- [ ] Stop-Gründe bekannt: unklarer Scope, fehlende Evidence, failed Checks, `needs-human`, `needs-fix`, `blocked`, Protected Area, Merge-/Pull-/Permission-Fehler oder kein weiteres beauftragtes Ticket

## Done

Das Startpaket ist fertig, wenn:

- jede KI zuerst die repo-basierte Projektanweisung liest
- Cloud-KIs die repo-basierte Projektanweisung über GitHub erreichen können
- Tool-Projektanweisungen nur Bootstrap-Pointer sind
- Projektwahrheit im Repo/GitHub liegt
- strategische Wahrheit und Produktgedächtnis im AI Vault verankert sind
- Ticket Null ohne Rueckfrage von Codex bearbeitet werden kann
- der erste PR seine Evidence im PR Body oder eindeutig verlinkt dokumentieren kann
- nach grünem Merge lokales `main` sauber synchronisiert wird, bevor der nächste Queue-Eintrag startet
- ein ausdRücklicher Ticket-Batch nach jedem Green Path synchronisiert und nur mit beauftragten ready Tickets fortgesetzt wird
