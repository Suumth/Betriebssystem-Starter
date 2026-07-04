# Operator Merge Policy

## Kernsatz

Der Mensch ist kein Code-Reviewer.

Der Mensch ist Freigabe-Operator. Code-Prüfung bedeutet in diesem Betriebssystem: Der Mensch beauftragt ChatGPT, Codex, @codex review oder bei Bedarf Claude Code mit der Prüfung. Mehr technische Codebeurteilung wird vom Menschen nicht erwartet.

## Warum

Wenn der Mensch den Code nicht selbst beurteilen kann, erzeugt ein hartes manuelles Merge-Gate nur scheinbare Sicherheit.

Sicherheit entsteht stattdessen durch den Harness:

- klare Tickets
- Branches
- PRs
- Validation
- Evidence
- Review of Record
- Auto-Merge-Ampel
- Eskalation bei Risiko

## Rollen

| Rolle | Aufgabe |
| --- | --- |
| Codex Builder | Umsetzung, Tests, Evidence, PR |
| Codex Review / @codex review | Standard-Codeprüfung und Review of Record |
| ChatGPT Pro | Meta-Review, Ticket-Schnitt, Entscheidungsvorlage, optional PR-Prüfung |
| Claude Code | Premium-/Eskalationsreview oder Umsetzung nach menschlicher Freigabe |
| Mensch | Freigabe-Operator, Risikowahl, Merge-Policy-Entscheidung |

## Merge-Prinzip

Nicht:

> Mensch liest Code und entscheidet technisch.

Sondern:

> Harness liefert Ampel. Mensch entscheidet nur bei Gelb/Rot oder bei bewusstem Risiko.

## Ampellogik

### Grün: Auto-Merge erlaubt

Auto-Merge ist erlaubt, wenn der PR folgende Bedingungen erfüllt:

- Issue ist verlinkt
- Scope eingehalten
- Validation bestanden
- Evidence vorhanden
- Review of Record PASS
- `review:pass` gesetzt oder eindeutig im Review of Record dokumentiert
- kein `needs-fix`
- kein `blocked`
- kein `needs-human`
- `auto-merge:ok` gesetzt
- `Human decision required: no`
- `Claude Code Review Suggested: no` oder durch Mensch abgelehnt

### Gelb: Operator-Entscheidung

Mensch entscheidet, wenn:

- `needs-human` gesetzt ist
- `Claude Code Review Suggested: yes`
- Evidence nicht eindeutig ist
- risk:protected betroffen ist
- Review uneinig ist
- Validation teilweise ist
- Produktentscheidung möglich ist

Solange `needs-human` gesetzt ist, ist Auto-Merge verboten. `needs-human` ist ein Gelb-Signal, kein Merge- oder Freigabe-Synonym.

Die Entscheidung lautet dann nicht: Code lesen.

Sondern:

- Codex nochmal prüfen lassen
- ChatGPT Pro PR prüfen lassen
- Claude Code Review freigeben
- abends Batch-Review laufen lassen
- Risiko akzeptieren
- nicht mergen

### Gelb/Rot Review-Empfehlung

Bei Gelb und Rot muss der Harness eine konkrete Review-Empfehlung liefern. Der Operator soll nicht selbst herausfinden müssen, wen er beauftragt.

Pflichtfelder:

```markdown
### Review Recommendation
- Recommended reviewer: Codex | @codex review | ChatGPT Pro | Claude Code | Human decision only
- Recommended intelligence/reasoning: low | medium | high | highest available
- Reason:
- Review ticket suggested: yes | no
- Review ticket created: yes | no
- Review ticket URL:
- Auto-merge blocked until review: yes | no
```

Empfehlungslogik:

| Situation | Empfehlung |
| --- | --- |
| unklare Evidence, kleiner Scope | `@codex review`, medium |
| unklare Evidence, produktnah | `ChatGPT Pro`, high oder `@codex review`, high |
| Bug-/Logikrisiko | `Codex`, high oder `@codex review`, high |
| Protected Area ohne Release-Nähe | `@codex review`, high; Claude Code nur vorschlagen |
| Safety / Legal / Privacy / StoreKit / Signing / Release | `Claude Code Suggested: yes`, highest available; Human decision required |
| Modell-/Tool-Grenze von Codex erreicht | `Claude Code Suggested: yes`, high/highest available |
| reine Operator-Frage ohne Codeprüfung | `Human decision only` |

### Reviewticket-Regel

Wenn Gelb/Rot nicht mit einem kurzen PR-Kommentar entscheidbar ist, soll direkt ein Reviewticket vorgeschlagen oder angelegt werden.

Reviewticket anlegen bei:

- Review braucht mehr als einen kurzen Kommentar
- mehrere offene Fragen
- Protected Area
- risk:release
- Claude Code Suggested: yes
- Evidence muss nachgezogen werden
- Fix braucht neuen Scope

Reviewticket nicht anlegen bei:

- klarer `needs-fix` Kommentar reicht
- kleiner Doku-/Evidence-Mangel
- mechanischer Nachweis fehlt und kann im selben PR ergänzt werden

Reviewticket-Titel:

```text
Review: <PR title> (#<PR number>)
```

Reviewticket muss enthalten:

```markdown
## Review Goal

## Context
- PR:
- Issue:
- Risk lane:
- Why review is needed:

## Recommended Reviewer
- Tool/model:
- Intelligence/reasoning:
- Reason:

## Review Questions
- ...

## Expected Output
- PASS / NEEDS-FIX / BLOCKED
- Evidence assessment
- Merge recommendation
```

### Rot: Kein Merge

Kein Merge bei:

- `needs-fix`
- `blocked`
- fehlender Validation
- fehlender Evidence
- Scope-Ausweitung ohne Freigabe
- offener Produkt-/Safety-/Legal-/Privacy-/Release-Entscheidung

Auch bei Rot gilt: Der Harness liefert eine Review- oder Fix-Empfehlung inklusive Tool und Intelligenzstufe.

## Protected Areas

Protected Areas dürfen von Codex bearbeitet werden, wenn das Ticket sauber geschnitten ist.

Sie dürfen aber nicht blind gemerged werden.

Protected Areas brauchen stärkere Evidence, einen expliziten Review of Record oder eine Operator-Entscheidung.

Beispiele:

- BLE
- Watch
- Live Activity
- Notifications
- StoreKit
- Signing / Entitlements / Bundle ID
- Safety / Legal / Privacy
- Release / TestFlight / App Store

## Tagesbranch-Logik

Codex darf tagsüber auf Branches arbeiten. Branches sind Arbeitsräume, nicht Freigaben.

Abends oder nach Batch-Ende werden PRs nach Ampel sortiert:

- Grün: Auto-Merge oder mechanischer Merge
- Gelb: Operator-Entscheidung mit Review-Empfehlung
- Rot: Fix oder blocked mit Review-/Fix-Empfehlung

## Green Path Completion

Ein grüner Merge ist erst abgeschlossen, wenn Codex danach die lokale Hygiene ausgeführt hat:

```text
gh pr merge <PR> --squash --delete-branch
git checkout main
git pull --ff-only origin main
git status
```

Diese sicheren Green-Path-Schritte werden nach erfolgreichem Merge ausgeführt, nicht bestätigt. Wenn `main` sauber ist, sucht Codex in der Standardreihenfolge nach dem nächsten bearbeitbaren Ticket: `needs-fix`, dann `agent:running`, dann genau ein neues `agent:ready`.

Wenn kein nächstes Ticket existiert, dokumentiert Codex den Idle-/Complete-Zustand. Wenn ein Stop-Grund wie fehlgeschlagener Merge, fehlgeschlagener Pull, dirty Working Tree, fehlende Berechtigung, `needs-human`, `needs-fix`, `blocked`, Protected-/Release-Entscheidung oder unklare Evidence vorliegt, stoppt Codex mit Entscheidungsvorlage.

## Batch Green Path Execution

Wenn der Nutzer ausdrücklich einen Ticket-Batch beauftragt, darf Codex nach jedem grünen PR mit dem nächsten beauftragten, reifen Ticket fortsetzen. Die Batch-Größe kommt aus dem Nutzerauftrag, nicht aus einer festen Zahl.

Vor jeder Fortsetzung muss der vorherige Green Path abgeschlossen sein:

```text
PR Review of Record prüfen
Merge gemäß Green-Path-Regel durchführen
git checkout main
git pull --ff-only origin main
git status
nächstes beauftragtes ready Ticket übernehmen
```

Stop gilt bei unklarem Scope, fehlender Evidence, failed Checks, `needs-human`, `needs-fix`, `blocked`, Protected Area, Merge-/Pull-/Permission-Fehlern oder keinem weiteren beauftragten Ticket.

Details: `docs/green-path-completion.md`.

## PR-Closeout Pflichtfelder

Jeder PR soll für den Operator lesbar sein:

```markdown
### Vault Impact
- Vault update required: YES | NO
- Area: Decision | Non-goal | Risk | Roadmap | UX/Brand | Architecture | Lesson | Method
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:

### Operator Summary
- What changed:
- Validation:
- Evidence:
- Risk lane: low | standard | protected | release
- Auto-merge candidate: yes | no
- Human decision required: yes | no
- Claude Code Review Suggested: yes | no
- Reason:

### Review Recommendation
- Recommended reviewer:
- Recommended intelligence/reasoning:
- Reason:
- Review ticket suggested:
- Review ticket created:
- Review ticket URL:
- Auto-merge blocked until review:
```

`Vault Impact` folgt dem kanonischen Contract in
`contracts/ticket-contract.md#vault-impact-contract`. Der Operator behandelt
Vault Update Candidates als Human Gate; sie sind keine direkte Vault-Mutation
durch den Agenten.

## Wichtigster Satz

Du bist nicht der Code-Reviewer.

Du bist der Freigabe-Operator.

Der Harness muss dir die Ampel und die nächste Review-Beauftragung liefern.
