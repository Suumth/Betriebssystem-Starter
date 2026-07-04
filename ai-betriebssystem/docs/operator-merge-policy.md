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

> Harness liefert Ampel. Der Mensch bleibt finaler Freigabe-Operator; bei Grün
> ist diese Freigabe eine knappe separate Operator-Aktion statt technischer
> Codeprüfung.

## Ampellogik

### Grün: mechanischer Merge nach Human Gate erlaubt

Mechanischer Merge ist erlaubt, wenn der PR folgende Bedingungen erfüllt:

- Issue ist verlinkt
- Scope eingehalten
- Validation bestanden
- Evidence vorhanden
- Review of Record PASS
- `review:pass` gesetzt oder eindeutig im Review of Record dokumentiert
- kein `needs-fix`
- kein `blocked`
- kein `needs-human`
- separate Operator-/Human-Gate-Freigabe ist in GitHub dokumentiert
- `auto-merge:ok` ist durch Operator-Aktion gesetzt oder ausdrücklich beauftragt
- `Human decision required: no`
- `Claude Code Review Suggested: no` oder durch Mensch abgelehnt

Der Review of Record darf `auto-merge:ok` empfehlen, aber nicht als finale
Merge-Autorisierung setzen. `auto-merge:ok` ist kein AI-Review-Ergebnis,
sondern die dokumentierte Operator-Freigabe nach PASS.

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

Protected path / Denylist surfaces from `contracts/protected-path-denylist.md`
are not green auto-merge candidates by default. A PR that touches `.env`,
credentials, auth, payments, billing, deployment, migration, signing, release,
app-store or publication surfaces needs explicit issue scope, protected-surface
validation and Human Gate handling before merge.

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

- Grün: Operator-Freigabe und danach mechanischer Merge
- Gelb: Operator-Entscheidung mit Review-Empfehlung
- Rot: Fix oder blocked mit Review-/Fix-Empfehlung

## Green Path Completion

Ein grüner Merge darf erst nach separater Operator-/Human-Gate-Freigabe
ausgeführt werden. Er ist erst abgeschlossen, wenn Codex danach die lokale
Hygiene ausgeführt hat:

```text
gh pr merge <PR> --squash --delete-branch
git checkout main
git pull --ff-only origin main
git status
```

Diese sicheren Green-Path-Schritte werden nach erfolgreichem, freigegebenem
Merge ausgeführt, nicht erneut bestätigt. Wenn `main` sauber ist, sucht Codex
in der Standardreihenfolge nach dem nächsten bearbeitbaren Ticket: `needs-fix`,
dann `agent:running`, dann genau ein neues `agent:ready`.

Wenn kein nächstes Ticket existiert, dokumentiert Codex den Idle-/Complete-Zustand. Wenn ein Stop-Grund wie fehlgeschlagener Merge, fehlgeschlagener Pull, dirty Working Tree, fehlende Berechtigung, `needs-human`, `needs-fix`, `blocked`, Protected-/Release-Entscheidung oder unklare Evidence vorliegt, stoppt Codex mit Entscheidungsvorlage.

Wenn ein wiederholter Fix-/Review-/Validation-Loop Stagnation zeigt, gilt `contracts/ticket-contract.md#stagnation-escalation`: keine blinden Retry-Loops. Codex dokumentiert Harness Failure Classification, letzte gescheiterte Evidence und die naechste Aktion als targeted fix, review ticket, Harness Learning Candidate, `needs-human` oder `blocked`.

## Batch Green Path Execution

Wenn der Nutzer ausdrücklich einen Ticket-Batch beauftragt, darf Codex nach jedem grünen PR mit dem nächsten beauftragten, reifen Ticket fortsetzen. Die Batch-Größe kommt aus dem Nutzerauftrag, nicht aus einer festen Zahl.

Vor jeder Fortsetzung muss der vorherige Green Path abgeschlossen sein:

```text
PR Review of Record prüfen
separate Operator-/Human-Gate-Freigabe prüfen
Merge gemäß Green-Path-Regel durchführen
git checkout main
git pull --ff-only origin main
git status
nächstes beauftragtes ready Ticket übernehmen
```

Stop gilt bei unklarem Scope, fehlender Evidence, failed Checks, `needs-human`, `needs-fix`, `blocked`, Protected Area, Merge-/Pull-/Permission-Fehlern oder keinem weiteren beauftragten Ticket.

Details: `docs/green-path-completion.md`.

## Local Direct-Main Mode

Der Standardmodus bleibt PR-basiert: Branch, PR Evidence, Review of Record und
Merge-Freigabe. Local Direct-Main Mode ist eine ausdrückliche Ausnahme für
lokale Codex-Läufe auf einem eng begrenzten Ticket oder einer eng begrenzten
Wave.

Local Direct-Main Mode ist nur erlaubt, wenn der Operator ihn für den konkreten
Scope ausdrücklich autorisiert. Dann gelten diese Mindestregeln:

- von aktuellem lokalem `main` starten
- `git checkout main` vor dem Ticket ausführen
- `git pull --ff-only origin main` vor dem Ticket ausführen
- normale Commits und normalen `git push` verwenden
- kein Force-Push
- kein Umgehen von Repository Protection
- keine Veröffentlichung, wenn Validation oder Scope unklar ist
- nur die freigegebenen Dateien ändern

Wenn PRs in diesem Modus übersprungen werden, ersetzt Issue-Closeout-Evidence
die PR Evidence nur für diesen ausdrücklich autorisierten Lauf. Jedes
abgeschlossene Issue braucht dann einen Closeout-Kommentar mit:

- geänderten Dateien
- Implementierungszusammenfassung
- ausgeführten Verification Commands
- lokaler Output-Zusammenfassung
- Review-Ergebnis oder Waiver
- Commit SHA
- Limitations / Non-Claims

### Known-Failing Gate

Ein bekannter fehlschlagender Check darf nur dann als nicht blockierend behandelt
werden, wenn alle Bedingungen erfüllt sind:

- der Fehler ist verstanden und dokumentiert
- ein konkretes Follow-up-Ticket besitzt den Fix
- das aktuelle Ticket hat den Fehler nicht erzeugt oder verschlechtert
- der Issue-Closeout nennt den bekannten Fehler explizit als nicht blockierend

Shell-/Runtime-Fehler, neue Failure durch das aktuelle Ticket oder unklare
Validation bleiben blockierend.

### Review Waiver

Ein erforderlicher Review darf nur durch ausdrückliche Operator-Anweisung
erlassen werden, zum Beispiel bei einem lokalen Tooling-Ausfall oder einem
gleichwertigen nicht-codebezogenen Blocker. Ein Waiver ersetzt nicht die
Validation.

Der Closeout muss dann enthalten:

- `Review of Record: WAIVED by operator`
- Grund des Waivers
- exakter Tool- oder Prozessfehler, falls vorhanden
- Aussage, dass die geforderte Validation trotzdem bestanden hat

### Lokale Toolchain-Kompatibilität

Public-Readiness-Checks und lokale Starter-Checks sollen auf macOS-Default-
Werkzeugen laufen, soweit das ohne neue Abhängigkeiten vernünftig möglich
ist. Besonders wichtig:

- `/bin/bash` 3.2 kompatibel bleiben, ausser das Repository dokumentiert
  ausdrücklich eine neuere Bash-Anforderung
- `python3` nicht stillschweigend als `python` voraussetzen, weil macOS nicht
  immer ein `python`-Binary bereitstellt

Das ist keine vollständige Plattform-Support-Matrix. Es ist eine
Public-Readiness-Regel für lokale Operator-Läufe.

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
