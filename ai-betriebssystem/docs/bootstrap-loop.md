# Bootstrap Loop

Der Bootstrap Loop beschreibt, wie aus einer neuen Projektidee ein
arbeitsfaehiges, KI-kompatibles Projekt-Setup im AI-Betriebssystem 2.0 wird.
Er steht vor dem Delivery Loop: Erst wenn ein Projekt bootstrap-fertig ist,
können Issues, PRs, Reviews und Green Path Completion verlaesslich laufen.

## 1. Nordstern

Jede KI bekommt denselben Einstiegspunkt:

```text
ChatGPT / Claude / Codex / Gemini / zukuenftige Modelle
        |
        v
PROJECT.md im Repo-Root
        |
        +-- AGENTS.md
        +-- README.md
        +-- GitHub Issues / PRs / Labels
        +-- AI Vault Referenzen
```

Der Loop ist PROJECT.md-first, nicht Codex-first. Tool-spezifische
Projektanweisungen dürfen nur dünne Bootstrap-Pointer sein. Sie zeigen auf
die GitHub-URL von `PROJECT.md` und erzeugen keine eigene Projektwahrheit.

## 2. Zielarchitektur

Ein bootstrap-fertiges Projekt hat drei Quellen mit klar getrennten Rollen:

| Quelle | Rolle | Operative Wahrheit? |
|---|---|---|
| Projekt-Repo | Arbeit, Issues, PRs, Labels, Evidence, `PROJECT.md`, `AGENTS.md`, Code und Repo-Dateien | Ja |
| AI-Betriebssystem 2.0 | Methode, Contracts, Prompts, Templates, Review- und Green-Path-Regeln | Ja, für Methode |
| AI Vault | Strategie, Zielbild, Produktgedächtnis, Entscheidungen, Nicht-Ziele und langfristige Risiken | Nein |

Das Projekt-Repo bleibt der Ort, an dem Agenten im Betrieb handeln. Der AI
Vault bleibt die strategische Quelle, wird aber von `PROJECT.md` nur referenziert
und bei Bedarf über GitHub- oder Repo-Dateien online erreichbar gemacht.

## 3. Rollen der Root-Dateien

### PROJECT.md

`PROJECT.md` ist die kanonische Root-Datei jedes Projekt-Repos. Sie ist der
erste Lesepunkt für alle KI-Tools und muss über GitHub erreichbar sein.

Mindestinhalt:

- Projektidentitaet und Repo-URL
- GitHub-URL zu `PROJECT.md`
- lokale Fallback-Pfade nur für lokale Agenten
- Link auf das AI-Betriebssystem als Methodenquelle
- Link auf `AGENTS.md`
- AI-Vault-Referenzen als Source Map, nicht als Vollkopie
- aktuelle Arbeitsregeln für Tickets, PRs, Review und Green Path
- klare No-Duplication-Regel für Tool-Anweisungen

### AGENTS.md

`AGENTS.md` enthält repo-spezifische Arbeitsregeln für Agenten:

- erlaubte und geschützte Pfade
- Build-, Test- und Validierungsbefehle
- Repo-spezifische Risiken
- branch-, commit- und PR-Regeln
- erwartete Evidence
- Hinweise auf lokale Besonderheiten

`AGENTS.md` ist operativ und darf konkreter sein als `PROJECT.md`.

### README.md

`README.md` richtet sich an Menschen. Es beschreibt Produkt, Zweck, Installation
und Nutzung. Es darf auf `PROJECT.md` verweisen, ersetzt aber nicht die
KI-Projektanweisung.

### AI Vault

Der AI Vault ist Strategie- und Produktgedächtnis. `PROJECT.md` verweist auf
die relevanten Vault-Dateien oder online gespiegelten Einstiegspunkte, dupliziert
sie aber nicht vollständig. Wenn ein Cloud-Tool Vault-Kontext braucht, muss
dieser über GitHub erreichbar sein oder kontrolliert ins Projekt-Repo gespiegelt
werden.

## 4. Definition: Projekt ist bootstrap-fertig

Ein Projekt ist bootstrap-fertig, wenn mindestens diese Artefakte vorhanden und
über GitHub auffindbar sind:

- `PROJECT.md` im Repo-Root
- `AGENTS.md` im Repo-Root
- `README.md`
- Task-/Issue-Template nach AI-Betriebssystem Ticket Contract
- PR-Template oder dokumentierter PR-Body-Standard
- erwartete operative Labels
- Ticket 0 als erstes Bootstrap-Issue
- Project Brief oder kompakte Source Map im Repo
- referenzierte AI-Vault-Einstiegspunkte
- dokumentierter Build-/Validation-Pfad
- klare Green-Path-Regel nach Merge

Bootstrap-fertig bedeutet nicht, dass das Produkt fertig ist. Es bedeutet, dass
ein Agent ohne Rueckfrage ein reifes Ticket lesen, einen Branch erstellen,
validieren, Evidence liefern und einen PR reviewbar machen kann.

## 5. Standard-AI-Vault-Struktur

Die genaue Vault-Struktur darf projektspezifisch bleiben. `PROJECT.md` muss aber
mindestens auf diese Inhaltsarten zeigen:

- Strategie oder Zielbild
- Produktbrief
- Nicht-Ziele
- Entscheidungen oder ADRs
- Risiken
- Roadmap oder nächste Meilensteine
- relevante Research-/Design-Quellen

Wenn lokale Vault-Pfade verwendet werden, sind sie nur Fallbacks für lokale
Agenten. Cloud-KIs bekommen GitHub-URLs, gespiegelte Repo-Dateien oder eine
andere online erreichbare Quelle.

## 6. Bootstrap-Ablauf

1. Projektidee benennen.
2. Projekt-Repo bestimmen oder anlegen.
3. AI-Vault-Projektbereich bestimmen.
4. `PROJECT.md` aus `templates/PROJECT.md` erstellen.
5. `AGENTS.md` aus dem Agenten-Template erstellen.
6. `README.md` auf Menschennutzen und `PROJECT.md`-Verweis prüfen.
7. Issue-/PR-Templates installieren oder anpassen.
8. Operative Labels aus `templates/labels.yml` anlegen.
9. Ticket 0 aus `templates/ticket-0-bootstrap.md` erstellen.
10. Erstes kleines Smoke-Test- oder Docs-Ticket schneiden.
11. Agentenlauf beweisen: Branch, PR, Validation Evidence, Review of Record.
12. Nach grünem Merge `main` synchronisieren und Green Path Completion
    dokumentieren.

## 7. Erwartete GitHub-Labels

Pflichtlabels für den MVP:

- `agent:ready`
- `agent:running`
- `needs-fix`
- `needs-human`
- `blocked`
- `review:pass`
- `auto-merge:ok`

Optionale Risikohinweise dürfen ergaenzen, aber keine zweite Statuslogik
erzeugen:

- `risk:low`
- `risk:standard`
- `risk:protected`
- `risk:release`

## 8. Erwartete Issue- und PR-Templates

Das Issue-Template muss den Ticket Contract abbilden:

- Agent Contract
- Goal
- Context
- Boundary
- Verification
- Closeout
- Operator Summary
- Review Recommendation
- Stop condition

Der PR-Body muss mindestens enthalten:

- `Closes #<issue>`
- Summary
- Changed files
- Validation Evidence
- bewusst vertagte Punkte
- Human decision required: yes/no
- Review recommendation

## 9. Ticket-0-Konvention

Ticket 0 ist kein Produktfeature. Es ist der Bootstrap-Beweis für ein neues
Projekt-Repo.

Zweck:

- prüfen, ob `PROJECT.md`, `AGENTS.md`, Templates, Labels und Source Map
  zusammen funktionieren
- ein erstes kleines, risikoarmes Ticket erzeugen
- beweisen, dass ein Agent ohne Zusatzbriefing starten kann

Mindestinhalt von Ticket 0:

- Agent Contract: `Mode: EXECUTING`, passende Autonomy und Risk lane
- Ziel: Bootstrap-Setup prüfen oder vervollständigen
- Boundary: nur Bootstrap-/Repo-Regeldateien
- Nicht-Ziele: keine Produktfeatures, keine breite Architekturarbeit
- Verification: `git diff --check` plus vorhandene Repo-Checks
- Evidence: PR-Body mit geaenderten Dateien und Validation Output
- Stop condition: fehlender Repo-Zugriff, fehlende Labels oder unklare
  kanonische Quellen

Ticket 0 darf nach erfolgreichem Bootstrap geschlossen werden. Danach entstehen
normale Delivery-Tickets.

## 10. Migrationsbezug für bestehende Projekte

Bestehende Projekte werden nicht auf einmal umgebaut. Migration bedeutet:

1. Aktuelle operative Wahrheit im Repo lesen.
2. Vault- und Strategiequellen inventarisieren.
3. `PROJECT.md` als kanonischen KI-Einstieg ergaenzen.
4. Tool-spezifische Projektanweisungen auf Bootstrap-Pointer reduzieren.
5. `AGENTS.md`, Templates und Labels gegen die AI-Betriebssystem-Contracts
   abgleichen.
6. Ein kleines Migrationsticket schneiden und beweisen.

Bei Konflikten gilt:

- Projekt-Repo gewinnt für aktuellen operativen Zustand.
- AI Vault gewinnt für Strategie und Produktgedächtnis.
- AI-Betriebssystem gewinnt für Methode und Loop-Vertraege.
- Abweichungen werden als Issue, Decision oder Vault-Update sichtbar gemacht.

## 11. Bewusst nicht Teil des Bootstrap-Loops

- kein eigener Runner als Startvoraussetzung
- keine Dashboard-Pflicht
- keine vollautomatische Repo-Registry
- keine lokale Pfadpflicht für Cloud-KIs
- keine duplizierte Strategie in Tool-Projektanweisungen
- keine Migration aller Projekte in einem Schritt

## 12. Template-Set

Das wiederverwendbare Bootstrap-Set liegt unter `templates/`:

- `templates/PROJECT.md`
- `templates/AGENTS.md`
- `templates/project-brief.md`
- `templates/project-start-pack.md`
- `templates/github_issue_task.md`
- `templates/ticket-0-bootstrap.md`
- `templates/pull-request-template.md`
- `templates/labels.yml`
- `templates/ai-vault/vision.md`
- `templates/ai-vault/target-picture.md`
- `templates/ai-vault/product-brief.md`
- `templates/ai-vault/roadmap.md`
- `templates/ai-vault/decisions.md`
- `templates/ai-vault/risks.md`
- `templates/ai-vault/lessons-learned.md`
