# PM Signal Loop

## Definition

Der PM Signal Loop verdichtet Projektstand aus GitHub-Artefakten zu einem steuerbaren Signal für den Operator.

PM Signal bedeutet: ein belastbarer, quellengebundener Blick auf Fortschritt, Blocker, Risiken, Entscheidungen und nächste Schritte. Es ist kein Ersatz für Delivery, Review oder Product Decisions.

## Ziel

Ziel ist Leiterblick und Projektsteuerung:

- Wo stehen die Teilprojekte?
- Was wurde seit dem letzten Signal geliefert?
- Was ist blockiert?
- Welche Risiken wachsen?
- Welche Entscheidungen sind als Nächstes nötig?
- Welche Issues, Risk Log-Updates oder Contract Updates sollten entstehen?

## Quellen

PM-Signale entstehen aus GitHub- und Repo-Artefakten:

- GitHub Issues
- PRs
- Labels
- Commits
- `docs/pm/*.md`
- `docs/adr/*.md`
- Risk Log
- Decision Log

## Nicht-Quellen

Nicht als operative Projektwahrheit verwenden:

- AI Vault
- zweite Roadmap neben GitHub
- separates Kanban

Der AI Vault kann Denk- oder Entwurfsarbeit enthalten. Operativ zählt nur, was in GitHub oder bewusst freigegebenen Repo-Dokumenten sichtbar ist.

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

## Ablauf

1. GitHub-Artefakte lesen.
2. Stand je Teilprojekt verdichten.
3. Fortschritt, Blocker, Risiken und Entscheidungen erkennen.
4. `docs/pm/status.md` oder ein PM-Review-Issue aktualisieren oder vorschlagen.
5. Neue Issues, Risk Log-Updates oder Contract Updates vorschlagen.

## Output

Ein PM-Signal sollte enthalten:

1. Overall Status: Green | Yellow | Red
2. Teilprojekt-Tabelle
3. Delivered Since Last Signal
4. Open Risks
5. Critical Missing Pieces
6. Next Operator Decisions
7. Suggested Issues / Updates
8. Confidence / Missing Evidence

## Regeln

- Keine zweite Projektwahrheit erzeugen.
- Keine erledigte Arbeit ohne Issue, PR, Commit oder Closeout behaupten.
- Neue Arbeit als Issue vorschlagen oder anlegen, wenn das ausdrücklich erlaubt ist.
- Harte Entscheidungen als Decision Log oder ADR sichtbar machen.
- Risiken im Risk Log oder als Issue sichtbar machen.
- PM Signal darf verdichten, aber nicht still neue Roadmap-Realität schaffen.

## Frequenz

PM-Signal-Läufe passen:

- on demand
- vor größeren Planungsblöcken
- nach mehreren gemergten PRs
- vor Wochenstart oder Wochenabschluss

## Nicht im MVP

- kein PM-Daemon
- kein Pflicht-Dashboard
- keine automatische Wochenmemo-Maschinerie
- kein zweites Kanban
