# ChatGPT Project Onboarding for Existing Repos

Diese Checkliste migriert bestehende Projekt-Repos in ein duennes ChatGPT-Projekt mit AI-Betriebssystem-2.0-Regeln. Sie ersetzt nicht `migration/repo-migration-checklist.md`, sondern ergaenzt sie um den ChatGPT-Projektstart.

## 1. Bestehende Regeln scannen

- [ ] `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` oder aehnliche Agent-Dateien finden
- [ ] README und `docs/` auf Build-/Test-/Preview-Regeln pruefen
- [ ] vorhandene Issue Templates pruefen
- [ ] vorhandene Labels pruefen
- [ ] Protected Areas aus Code, Docs, Releases oder Produktkontext notieren
- [ ] widerspruechliche Regeln markieren, nicht still ueberschreiben

## 2. Projektbeschreibung erstellen

- [ ] `docs/project-brief.md` aus `templates/project-brief.md` anlegen oder vorhandene Datei angleichen
- [ ] Produktname und Repo URL eintragen
- [ ] kanonischen Pfad fuer die repo-basierte Projektanweisung festlegen, bevorzugt `PROJECT.md`
- [ ] GitHub-URL der kanonischen repo-basierten Projektanweisung eintragen
- [ ] lokale Pfade nur als Codex-Fallback markieren
- [ ] AI-Betriebssystem, Projekt-Repo und AI Vault im Source Map eintragen
- [ ] AI Vault Schluesseldateien referenzieren: Strategie, Zielbild, Entscheidungen, Nicht-Ziele, Risiken, Roadmap und Produktbrief
- [ ] Online-Einstieg fuer AI-Vault-Inhalte festlegen, die Cloud-KIs benoetigen
- [ ] Zielbild knapp aus bestehenden Repo-Dateien ableiten
- [ ] Nicht-Ziele explizit machen
- [ ] Protected Areas und Review-Gates benennen
- [ ] Validierungsarten mit realen lokalen/GitHub-Checks fuellen
- [ ] offene Risiken als Risiken markieren, nicht als erledigte Fakten

## 3. Repo-basierte Projektanweisung anlegen

- [ ] bestehende lange ChatGPT-/Claude-/Codex-Projektanweisungen sammeln
- [ ] dauerhaft gueltige Arbeitsregeln in `PROJECT.md` oder `docs/project-instructions.md` ueberfuehren
- [ ] sicherstellen, dass diese Datei ueber GitHub erreichbar ist
- [ ] Tool-spezifische Details, alte Logs und veraltete Produktwahrheit verwerfen statt mitzuschleppen
- [ ] Online-first Source Policy aus `templates/project-instructions.md` uebernehmen
- [ ] Drei-Quellen-Router aus `templates/project-instructions.md` uebernehmen:
  - [ ] AI-Betriebssystem = Methode, Ticket-Schnitt, Green Path, Review, Evidence
  - [ ] Projekt-Repo = operative Wahrheit, Issues, PRs, AGENTS.md, Code und Status
  - [ ] AI Vault = Strategie, Zielbild, Produktgedaechtnis, Entscheidungen und Nicht-Ziele
- [ ] AI-Vault-Inhalte, die ChatGPT, Claude, Gemini oder andere Cloud-KIs benoetigen, als GitHub-Dateien, GitHub-Referenzen oder geeignete Projekt-Repo-Spiegelung erreichbar machen
- [ ] AI-Vault-Produktbrief als Quelle verlinken, nicht in die Tool-Anweisung kopieren
- [ ] Project Brief, `AGENTS.md`, relevante Docs und AI-Vault-Fundorte verlinken
- [ ] No-Duplication-Regel eintragen: Kein KI-Tool bekommt eigene Sonderwahrheit

## 4. Tool-Projektanweisungen verschlanken

- [ ] neue Anweisung aus `templates/chatgpt-project-instructions.md` kopieren
- [ ] `PROJECT_INSTRUCTION_GITHUB_URL` auf die GitHub-URL der repo-basierten Projektanweisung setzen
- [ ] lange Produktdetails aus ChatGPT-/Claude-/Codex-Projektanweisungen entfernen
- [ ] alle Tool-Anweisungen durch denselben minimalen Bootstrap-Pointer ersetzen
- [ ] lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` aus Cloud-KI-Projektanweisungen entfernen
- [ ] keine tool-spezifische Sonderwahrheit behalten
- [ ] sicherstellen, dass die repo-basierte Projektanweisung die Quellen AI-Betriebssystem, Projekt-Repo und AI Vault verlinkt

## 5. Bestehende Issues labeln und bereinigen

- [ ] offene Issues gegen Ticket Contract pruefen
- [ ] unreife Tickets nicht mit `agent:ready` labeln
- [ ] zu grosse Tickets in kleinere EXECUTING- oder GRILLING-Boxen schneiden
- [ ] stale oder doppelte Issues kommentieren/schliessen, falls menschlich freigegeben
- [ ] bestehende PRs auf `needs-fix`, `blocked` oder Review-Bedarf pruefen

## 6. Ticket Null definieren

- [ ] kleinster risikoarmer Scope gewaehlt
- [ ] kein Produktentscheid noetig
- [ ] Verifier real ausfuehrbar
- [ ] Evidence eindeutig
- [ ] Nicht-Ziele hart gesetzt
- [ ] Closeout Requirements im Ticket enthalten
- [ ] erst danach `agent:ready` setzen

## 7. Green Path pruefen

- [ ] Codex kann genau ein Ticket starten
- [ ] Branch/PR-Name oder bestehender PR ist eindeutig
- [ ] PR kann `Closes #...` enthalten
- [ ] Validierung laeuft oder fehlendes Tool wird als `missing_tool` klassifiziert
- [ ] PR Body kann Primary Closeout Source sein
- [ ] Review of Record kann Gruen/Gelb/Rot gegen Issue entscheiden
- [ ] Nach gruenem Merge sind `git checkout main`, `git pull --ff-only origin main` und `git status` als sichere Schritte ohne Rueckfrage akzeptiert
- [ ] Bei sauberem `main` kann Codex den naechsten Queue-Eintrag suchen: `needs-fix`, `agent:running`, genau ein neues `agent:ready`
- [ ] Wenn kein naechstes Ticket existiert, wird Idle-/Complete-Zustand dokumentiert

## 8. Design Evidence nur bei UI-Produkten aktivieren

- [ ] UI-Produkt? ja/nein
- [ ] Falls ja: erwartete Screens, Preview oder Simulator-/Browser-Evidence definieren
- [ ] Falls nein: keine Design-Evidence-Pflicht einfuehren
- [ ] Marketing- oder Claim-Pruefungen als eigene Protected Area markieren, falls relevant

## 9. Stop-Regeln

Stoppe die Migration und schreibe eine Entscheidungsvorlage, wenn:

- das Projekt-Repo nicht eindeutig ist
- es widerspruechliche Agent-Regeln gibt
- kein realistischer Verifier existiert
- Protected Areas nicht identifizierbar sind
- Tool-Projektanweisungen als Wissensspeicher gebraucht werden sollen
- keine kanonische repo-basierte Projektanweisung angelegt werden kann
- die repo-basierte Projektanweisung nicht ueber GitHub erreichbar gemacht werden kann
- benoetigte AI-Vault-Inhalte fuer Cloud-KIs keinen online erreichbaren Einstieg haben
- Produktwahrheit nur im Vault oder in ChatGPT liegt und nicht versioniert ist
- Green-Path-Hygiene wegen Merge-/Sync-Fehler, dirty Working Tree oder fehlender Berechtigung nicht sicher ausgefuehrt werden kann

## Done

Die Migration ist abgeschlossen, wenn:

- repo-basierte Projektanweisung als KI-einheitlicher Einstieg versioniert ist
- repo-basierte Projektanweisung ueber GitHub erreichbar ist
- Tool-Projektanweisungen nur Bootstrap-Pointer enthalten
- Projektbeschreibung versioniert im Repo liegt
- Issues/Labels mit dem Ticket Contract vereinbar sind
- Ticket Null bereit ist oder ein GRILLING-Ticket die fehlenden Entscheidungen klaert
- Green Path Completion nach Merge dokumentiert und lokal ausfuehrbar ist
- keine Runtime-, App-, Runner-, Dashboard- oder GitHub-Action-Dateien eingefuehrt wurden
