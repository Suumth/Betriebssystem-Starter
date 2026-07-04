# Project Brief Template

Diese Datei gehört in das jeweilige Projekt-Repo, zum Beispiel als `docs/project-brief.md`. Sie ist die versionierte Projektbeschreibung für ChatGPT, Codex, Reviewer und Menschen.

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

- Cloud-KIs wie ChatGPT, Claude und Gemini können keine lokalen Pfade lesen.
- Tool-spezifische Projektanweisungen dürfen deshalb nur GitHub-URLs der repo-basierten Projektanweisung referenzieren.
- Lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` sind ausschließlich Fallbacks für lokale Agenten wie Codex.
- AI-Vault-Inhalte, die Cloud-KIs benötigen, müssen als GitHub-Dateien, GitHub-Referenzen oder geeignete Projekt-Repo-Spiegelung erreichbar sein.
- Die kanonische strategische Wahrheit bleibt im AI Vault; Online-Spiegelungen sind Einstiege für KI-Tools.

## Zielbild / Produktversprechen

Ein bis drei Sätze. Beschreibe, welchen Nutzen das Produkt liefern soll. Keine Marketing-Roadmap, keine lange Featureliste.

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

## Design- / Qualitätsbar

- Was muss sich für Nutzer gut anfühlen?
- Welche bestehenden Designregeln oder Referenzen gelten?
- Welche Sprache, Tonalität oder Claim-Grenzen gelten?
- Welche Barrierefreiheits-, Performance- oder Zuverlässigkeitsgrenzen gelten?

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
- Bekannte nicht vertrauenswürdige oder veraltete Informationen:

## Offene Risiken

| Risiko | Quelle | Auswirkung | Nächster Schritt |
|---|---|---|---|
|  |  |  |  |

## Nächste sinnvolle Tickets

Diese Liste ist kein zweites Kanban. Sie ist ein Startvorschlag und muss in GitHub Issues überführt oder dort bestätigt werden.

1. Ticket Null:
2. Nächstes kleines EXECUTING-Ticket:
3. Nächstes GRILLING-Ticket:
4. Nächster Review-/PM-Signal-Lauf:

## Source-of-Truth Notes

- Operative Wahrheit liegt in GitHub Issues, PRs, Labels, Commits und Repo-Dateien.
- Die repo-basierte Projektanweisung ist der KI-einheitliche Einstieg für ChatGPT, Claude, Codex und spätere Tools.
- Tool-spezifische Projektanweisungen sind nur Bootstrap-Pointer auf die repo-basierte Projektanweisung.
- Methodische Wahrheit liegt im AI-Betriebssystem-Repo.
- Strategische Wahrheit, Zielbild, Produktgedächtnis, Entscheidungen und Nicht-Ziele liegen im AI Vault.
- Diese Datei darf Orientierung geben, aber keine offenen GitHub-Arbeiten ersetzen.
- Wenn diese Datei von GitHub abweicht, gilt GitHub für operative Arbeit.
- Wenn diese Datei vom AI Vault abweicht, gilt der AI Vault für Strategie und Produktgedächtnis.
- Kein KI-Tool bekommt eigene Sonderwahrheit.
