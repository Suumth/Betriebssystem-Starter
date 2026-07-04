# Model and Resource Policy

## Kernsatz

Codex macht die Hauptarbeit.

ChatGPT Pro und Claude Opus schneiden, bewerten und formulieren Tickets auf Basis des AI-Betriebssystems.

Claude Code ist keine Standardstation im Loop. Claude Code wird nur vorgeschlagen, wenn ein externer Review oder eine Umsetzung mit Claude Code sinnvoll ist. Die Entscheidung trifft der Mensch.

Attempt budgets begrenzen wiederholte Fix- und Review-Schleifen. Sie sind keine Budgetdateien und kein Tool-Zwang.

## Rollen

| Rolle | Standardaufgabe | Verbrauchslogik |
| --- | --- | --- |
| ChatGPT Pro | Ticket-Schnitt, Harness-Design, Priorisierung, Entscheidungsvorlagen | Planungsressource |
| Claude Opus | Sparring, Architektur, Ticket-Reife, Risikoanalyse | Planungs-/Denkressource |
| Codex | Builder, Standard-Umsetzung, Standard-Fix, Evidence, PR | Hauptarbeitsressource |
| Codex Subagents | interne read-only Prüfung im Codex-Lauf | Standard-Qualitaetsschicht, sofern verfuegbar |
| @codex review | GitHub Review of Record | Standard-Review-Spur |
| Claude Code | externer Review oder Umsetzung bei Risiko/Komplexitaet | knappe Premium-Ressource, nur nach menschlicher Freigabe |
| Mensch | Merge, Claude-Code-Freigabe, Produkt-/Risikoentscheidung | Human Gate |

## Grundregel

Claude Code wird nicht automatisch verbraucht.

Wenn ein Ticket oder PR einen Claude-Code-Review oder eine Claude-Code-Umsetzung nahelegt, wird das im Ticket, PR oder Closeout als Empfehlung formuliert:

```text
Claude Code Review Suggested: yes/no
Reason:
Human decision required: yes/no
```

Ohne menschliche Freigabe bleibt der Standardpfad Codex.

## Standardpfad

```text
ChatGPT Pro / Claude Opus formulieren agent:ready Ticket
→ Codex baut
→ Codex Subagent Board prüft intern, falls verfuegbar
→ Codex fixt vor PR maximal einmal selbst
→ automatisierte `needs-fix`-Zyklen auf demselben PR laufen maximal zweimal, ausser der Operator verlaengert explizit
→ @codex review schreibt Review of Record in GitHub
→ Mensch merged PASS-Faelle
```

## Claude-Code-Review nur als Vorschlag

Claude Code Review kann vorgeschlagen werden bei:

- `risk:high`
- Security / Auth / Secrets
- Datenschutz / Recht / Safety Claims
- StoreKit / Payment / Entitlements / Signing
- Release / TestFlight / App Store
- grosse Architekturentscheidung
- grosse Refactors
- fehlende oder widerspruechliche Evidence
- Codex Subagent Board uneinig
- @codex review unsicher
- menschliches Bauchgefuehl

Formulierung im Closeout:

```markdown
### External Review Recommendation
- Claude Code Review Suggested: yes | no
- Reason:
- Human decision required: yes | no
```

## Claude-Code-Umsetzung nur als Vorschlag

Claude Code Production/Implementation kann vorgeschlagen werden bei:

- komplexem UI-/UX-Flow
- groesserer Architektur-/Domain-Modellierung
- schwer reproduzierbarem Bug
- breitem Refactor über mehrere Module
- Aufgabe, bei der Codex mehrfach am Harness scheitert

Aber:

- Keine automatische Umstellung auf Claude Code.
- Kein Claude-Code-Lauf ohne menschliche Freigabe.
- Nach Freigabe laeuft die Umsetzung mit `prompts/builder-claude-code.md`; Review of Record und Human Merge Gate bleiben unveraendert.
- Wenn Limits knapp sind, bleibt Codex Default.
- Wiederholtes Scheitern erzeugt zuerst Evidence: Failure Classification, letzter fehlgeschlagener Check oder Review-Punkt, vermutete Ursache, Attempts used und Empfehlung.

Formulierung:

```markdown
### Implementation Recommendation
- Keep in Codex: yes | no
- Claude Code Suggested: yes | no
- Reason:
- Human decision required: yes | no
```

## Ticket-Erstellung

ChatGPT Pro und Claude Opus erstellen keine Arbeit aus dem Bauch heraus. Sie beziehen ihre Arbeitsweise aus dem AI-Betriebssystem:

- Harness Model
- Ticket Contract
- Review Contract
- Labels
- AGENTS Templates
- Lessons
- repo-spezifische AGENTS.md

Jedes Ticket muss Codex-faehig sein, bevor es `agent:ready` bekommt.

## Review-Policy

Standard-Review:

- Codex Subagent Board intern
- @codex review als GitHub Review of Record

Externer Review:

- Claude Code nur nach menschlicher Entscheidung
- keine Standardpflicht für kleine oder mittlere Tickets

## Ressourcenprinzip

High-value Claude-Code-Limits werden für Situationen reserviert, in denen echte externe Modell-/Tooltrennung Wert schafft.

Nicht für:

- reine Dokumentation
- kleine Harness-Tickets
- Standard-Smokes
- einfache Build-/Evidence-PRs
- klare Bugfixes mit guter Validation

Dafür:

- Risiko
- Architektur
- Produktentscheidung
- schwer pruefbare Aenderungen
- mehrdeutige Evidence
- Release-nahe Arbeit

## Produktdefinition

Das AI-Betriebssystem 2.0 optimiert nicht darauf, moeglichst viele Agenten einzusetzen.

Es optimiert darauf, Codex als Hauptarbeitskraft in einem starken Harness arbeiten zu lassen und knappe Premium-Reviewer nur dort einzusetzen, wo ihr Grenznutzen hoch ist.
