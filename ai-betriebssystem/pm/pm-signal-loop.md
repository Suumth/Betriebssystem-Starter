# PM Signal Loop

Der PM Signal Loop ergänzt den Delivery Loop des AI-Betriebssystems 2.0. Er ist kein Dashboard, kein zweites Kanban und keine neue operative Wahrheit. Er verdichtet GitHub-Artefakte zu einem steuerbaren Projektbild.

## Ziel

Nicht nur Tickets abarbeiten, sondern regelmäßig erkennen:

- Wo stehen die Teilprojekte?
- Was wurde seit dem letzten Signal geliefert?
- Was hängt?
- Was ist kritisch?
- Welche Entscheidungen braucht der Operator?
- Welche Issues, Risiken oder Contract Updates sollten sichtbar gemacht werden?

## Grundformel

```text
Trigger -> Action -> Proof -> Memory -> Stop
```

| Phase | Bedeutung im PM Signal Loop | Artefakt |
|---|---|---|
| Trigger | Operator braucht Projektstand oder Wochen-/Batch-Abschluss | Auftrag, PM-Review-Issue, Label |
| Action | GitHub-Artefakte lesen und verdichten | Issues, PRs, Labels, Commits, Closeouts |
| Proof | Aussagen auf konkrete Artefakte zurückführen | Issue-/PR-/Commit-Belege |
| Memory | Verdichtung dauerhaft nutzbar machen | `pm/status.md`, `pm/risk_log.md`, `pm/decision-log.md`, Issue-Vorschläge |
| Stop | Signal ist abgeschlossen oder blockiert | Statusbericht, Missing Evidence, Follow-up-Issues |

## Quellen

Der PM Signal Loop liest nur operative oder bewusst freigegebene Quellen:

| Quelle | Verwendung |
|---|---|
| GitHub Issues | offene Arbeit, Epics, Teilprojekte, Blocker |
| Pull Requests | gelieferte Arbeit, Evidence, Closeouts, Review Status |
| Labels | Ampel, Risiko, Agentenstatus, Priorität |
| Commits | tatsächliche Änderungen |
| `pm/*.md` | verdichtete Projektsteuerung, nicht operative Wahrheit |
| ADRs / Decision Log | harte Entscheidungen und Richtungswechsel |
| Risk Log | wiederkehrende oder eskalierte Risiken |

Der AI Vault bleibt Denk- und Entwurfsort. Er ist keine operative PM-Wahrheit.

## PM-Lagebild

Das PM-Lagebild ist eine read-only Ergänzung zur Projektleiter-Sicht. Es wird
aus GitHub und dem Produktversprechen-Register in `PROJECT.md` abgeleitet.

Regeln:

- PM Signal bleibt operator-initiiert.
- Das Lagebild setzt keine Stati, Labels, Milestones oder Produktversprechen.
- Es ersetzt nicht GitHub, Issues, PRs, Review of Record oder Human Gate.
- Teilprojekte werden als GitHub Milestones modelliert.
- Produktversprechen werden im `PROJECT.md` geführt und nur per Human-/
  Operator-Entscheidung mit Evidence-Link bestätigt.
- Details stehen in `contracts/teilprojekt-contract.md`.

## Standardoutput

```markdown
## Project Signal

### Overall Status
Green | Yellow | Red

### Teilprojekte
| Teilprojekt | Zustand / Beleg | Blocker | Risiko | Nächste Entscheidung |
|---|---|---|---|---|

### Delivered Since Last Signal
- ...

### Open Risks
- ...

### Critical Missing Pieces
- ...

### Next Operator Decisions
- ...

### Suggested Issues / Updates
- ...

### Confidence / Missing Evidence
- ...
```

## Regeln

```text
PM Signal darf verdichten, aber nicht heimlich Projektwahrheit verschieben.
Neue Arbeit wird als Issue vorgeschlagen oder angelegt.
Neue Regeln werden als Contract-/Template-Änderung vorgeschlagen.
Risiken werden im Risk Log oder als Issue sichtbar gemacht.
Entscheidungen werden im Decision Log oder ADR sichtbar gemacht.
Keine erledigte Arbeit behaupten ohne Issue, PR, Commit oder Closeout.
```

## Frequenz im MVP

- On demand durch Operator.
- Vor größeren Planungsblöcken.
- Nach mehreren gemergten PRs.
- Vor Wochenstart oder Wochenabschluss.

Nicht im MVP:

- kein PM-Daemon
- kein separates Dashboard als Pflicht
- keine automatische Wochenmemo-Maschinerie
- kein zweites Kanban neben GitHub
