# Project Brief Template

Diese Datei gehoert in das jeweilige Projekt-Repo, zum Beispiel als `docs/project-brief.md`. Sie ist die versionierte Projektbeschreibung fuer ChatGPT, Codex, Reviewer und Menschen.

## Product Identity

- Product name:
- Repo URL:
- Canonical repo-based project instruction:
- Primary owner/operator:
- Project type: iOS | macOS | Web | Docs | Marketing | Other

## Source Map

Der Project Brief ist eine kompakte Projektkarte. Er ersetzt nicht die repo-basierte Projektanweisung und kopiert keine lange Strategie aus dem AI Vault.

| Source | GitHub URL / online entrypoint | Local fallback for Codex | Responsibility |
|---|---|---|---|
| Repo-based project instruction |  |  | Canonical working instruction for all KI tools |
| AI-Betriebssystem |  |  | Method source |
| Project repo |  |  | Operational source |
| Project AGENTS.md |  |  | Repo operating rules |
| AI Vault online entrypoint |  |  | Strategy and product memory entrypoint |
| AI Vault strategy |  |  | Strategy reference |
| AI Vault target picture |  |  | Target-picture reference |
| AI Vault decisions / non-goals |  |  | Decision reference |
| AI Vault risks / roadmap |  |  | Risk and roadmap reference |
| AI Vault product brief |  |  | Product-memory reference |

## Online-first Source Policy

- Cloud-KIs wie ChatGPT, Claude und Gemini koennen keine lokalen Pfade lesen.
- Tool-spezifische Projektanweisungen duerfen deshalb nur GitHub-URLs der repo-basierten Projektanweisung referenzieren.
- Lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` sind ausschliesslich Fallbacks fuer lokale Agenten wie Codex.
- AI-Vault-Inhalte, die Cloud-KIs benoetigen, muessen als GitHub-Dateien, GitHub-Referenzen oder geeignete Projekt-Repo-Spiegelung erreichbar sein.
- Die kanonische strategische Wahrheit bleibt im AI Vault; Online-Spiegelungen sind Einstiege fuer KI-Tools.

## Zielbild / Produktversprechen

Ein bis drei Saetze. Beschreibe, welchen Nutzen das Produkt liefern soll. Keine Marketing-Roadmap, keine lange Featureliste.

## Zielnutzer

- Primary user:
- Secondary user:
- Explicit non-users:

## Nicht-Ziele

- Nicht-Ziel 1:
- Nicht-Ziel 2:
- Nicht-Ziel 3:

## Protected Areas

Bereiche, die besondere Vorsicht, Review-Tiefe oder menschliche Entscheidung brauchen.

| Area | Warum protected? | Erwartete Evidence | Reviewer / Gate |
|---|---|---|---|
| Beispiel: Billing | Geldfluss | Test-/Sandbox-Evidence | Human decision |
| Beispiel: Safety copy | Nutzervertrauen / Risiko | Copy-Review | ChatGPT Pro / Human |

## Validierungsarten

| Arbeitstyp | Pflicht-Validierung | Evidence |
|---|---|---|
| Code | Build/Test/Lint konkret nennen | Rohoutput oder Testende |
| UI | Preview/Screenshot/Browser/Simulator | Screenshot oder sichtbarer Zustand |
| Docs | Markdown-/Link-/Scope-Check | Diff- und Check-Ergebnis |
| Release | Release-spezifische Gate-Checks | Signierte Evidence / Review |

## Design- / Qualitaetsbar

- Was muss sich fuer Nutzer gut anfuehlen?
- Welche bestehenden Designregeln oder Referenzen gelten?
- Welche Sprache, Tonalitaet oder Claim-Grenzen gelten?
- Welche Barrierefreiheits-, Performance- oder Zuverlaessigkeitsgrenzen gelten?

## Wichtige Labels

Pflichtlabels aus dem AI-Betriebssystem:

- `agent:ready`
- `agent:running`
- `needs-fix`
- `needs-human`
- `blocked`
- `review:pass`
- `auto-merge:ok`

Projekt-spezifische optionale Labels:

- `lane:ios`
- `lane:macos`
- `lane:web`
- `lane:docs`
- `lane:marketing`
- weitere:

## Typische Ticket-Arten

| Ticket-Art | Mode | Risk lane | Beispiel-Verifier |
|---|---|---|---|
| Smoke-Test | EXECUTING | low | Build/Test/Screenshot |
| Feature-Slice | EXECUTING | standard | Tests + Evidence |
| Unklare Produktfrage | GRILLING | standard | Entscheidungsvorlage |
| Release-Vorbereitung | COORDINATING | release | Gate-Liste + Human decision |

## Startzustand / aktueller Stand

- Aktueller Produktstatus:
- Aktueller technischer Status:
- Letzter belastbarer Loop / PR / Release:
- Bekannte nicht vertrauenswuerdige oder veraltete Informationen:

## Offene Risiken

| Risiko | Quelle | Auswirkung | Naechster Schritt |
|---|---|---|---|
|  |  |  |  |

## Naechste sinnvolle Tickets

Diese Liste ist kein zweites Kanban. Sie ist ein Startvorschlag und muss in GitHub Issues ueberfuehrt oder dort bestaetigt werden.

1. Ticket Null:
2. Naechstes kleines EXECUTING-Ticket:
3. Naechstes GRILLING-Ticket:
4. Naechster Review-/PM-Signal-Lauf:

## Source-of-Truth Notes

- Operative Wahrheit liegt in GitHub Issues, PRs, Labels, Commits und Repo-Dateien.
- Die repo-basierte Projektanweisung ist der KI-einheitliche Einstieg fuer ChatGPT, Claude, Codex und spaetere Tools.
- Tool-spezifische Projektanweisungen sind nur Bootstrap-Pointer auf die repo-basierte Projektanweisung.
- Methodische Wahrheit liegt im AI-Betriebssystem-Repo.
- Strategische Wahrheit, Zielbild, Produktgedaechtnis, Entscheidungen und Nicht-Ziele liegen im AI Vault.
- Diese Datei darf Orientierung geben, aber keine offenen GitHub-Arbeiten ersetzen.
- Wenn diese Datei von GitHub abweicht, gilt GitHub fuer operative Arbeit.
- Wenn diese Datei vom AI Vault abweicht, gilt der AI Vault fuer Strategie und Produktgedaechtnis.
- Kein KI-Tool bekommt eigene Sonderwahrheit.
