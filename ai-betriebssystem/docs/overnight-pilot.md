# Overnight Pilot

## Ziel

Diese Pilotdokumentation bereitet die erste kontrollierte Pilotnacht fuer den
Overnight Operations Mode vor und haelt die Auswertung danach an einer Stelle
fest. Die Pilotnacht bleibt bewusst klein: genau 2 handverlesene
`risk:low`-Tickets, keine Limit-Erhoehung, keine Parallelitaets-Erweiterung,
kein Runner, kein Scheduler, kein Dashboard und kein Auto-Merge.

Der Pilot nutzt die gemergten Overnight-Artefakte als Grundlage:

- `docs/overnight-operations-mode.md`
- `templates/codex-overnight-loop-prompt.md`
- `templates/morning-operator-review.md`
- `docs/loop-readiness.md`
- `contracts/labels.md`
- `templates/labels.yml`

## Pilotumfang

Der Pilotlauf wird nur armiert, wenn der Operator vor dem Abend-Prompt genau
zwei konkrete Issues eintraegt. Beide muessen `risk:low` sein und vor dem Start
die Labels `agent:ready` und `overnight:approved` tragen.

| Slot | Issue | Warum `risk:low` | Nacht-Verifier | Erwarteter PR | Ergebnis |
|---|---|---|---|---|---|
| 1 | einzutragen vor Pilotstart | kleine Docs-/Template- oder Nachweisarbeit | einzutragen | offen | offen |
| 2 | einzutragen vor Pilotstart | kleine Docs-/Template- oder Nachweisarbeit | einzutragen | offen | offen |

Stop-Regel: Wenn vor dem Abend-Prompt nicht genau zwei passende
`risk:low`-Tickets eingetragen sind, startet keine Pilotnacht. Codex waehlt
nicht automatisch Ersatz-Tickets aus.

## Vorab-Checkliste fuer den Operator

- Genau 2 Pilot-Issues sind ausgewaehlt.
- Beide Pilot-Issues tragen `risk:low`, `agent:ready` und
  `overnight:approved`.
- Beide Pilot-Issues sind entscheidungsfrei und haben nachts lauffaehige
  Validation.
- Keine Protected-/Release-Codearbeit ist enthalten.
- Der erwartete Diff bleibt je Ticket klein: ca. 400 Zeilen und max. 15
  Dateien.
- Max. 2 Worktrees bleiben das Limit; fuer diesen Pilot gibt es keine
  Parallelitaets-Erweiterung.
- Max. 1 Fixloop je PR bleibt das Limit.
- Der Abend-Prompt nutzt `templates/codex-overnight-loop-prompt.md` und
  begrenzt die Issues explizit auf die zwei Pilot-Slots.
- Der Operator plant morgens eine Morning Review mit
  `templates/morning-operator-review.md`.

## Abend-Prompt

Der Pilot nutzt den normalen Overnight Prompt. Der Operator traegt Datum, Repo
und die zwei Issue-Nummern ein:

```markdown
Datum: `<YYYY-MM-DD>`
Repo: `<OWNER>/<AI_OS_METHOD_REPO>`
Optional eingeschraenkte Issues: `<#slot-1, #slot-2>`
```

Der Prompt bleibt ein operator-armierter `L2 Assisted` Lauf. Ein Label allein
startet nichts.

## Erwartete Nightly Summary

Die Nightly Summary wird bevorzugt im Batch-Issue gepostet. Falls kein
Batch-Issue existiert, steht sie als Kommentar im zuletzt bearbeiteten Issue
oder PR. Wenn praktikabel, verlinkt sie beide Pilot-Issues und alle erzeugten
PRs.

Pflichtinhalt:

- Date
- Repo
- Issues considered: genau 2
- Issues completed with PR
- Issues skipped
- Issues blocked
- Open PRs
- Validation summary
- Morning actions
- Merge candidates
- Needs-fix candidates
- Human decisions
- Harness failure classification

## Morning Review Ablauf

Ziel: Die Morning Review bleibt unter 30 Minuten.

1. Nightly Summary lesen.
2. Beide Pilot-Issues und ihre PRs oeffnen.
3. Pruefen, ob Heartbeats rekonstruierbar sind und spaetestens alle 45 Minuten
   aktiver Arbeit gesetzt wurden.
4. Pruefen, ob `agent:running` ohne aktuellen Heartbeat > 2h als
   stale-Kandidat behandelt werden muss.
5. PR Bodies gegen Evidence, Validation, Operator Summary, Review
   Recommendation und Harness Failure Classification pruefen.
6. Gruen/Gelb/Rot nach `templates/morning-operator-review.md` einordnen.
7. Merge bleibt Operator-Handlung und erfolgt nur nach Review of Record und
   geltender Merge Policy.

## Metriken

| Metrik | Ziel / Erfassung | Ergebnis nach Pilot |
|---|---|---|
| Anzahl bearbeiteter Tickets | genau 2 | offen |
| Anzahl PRs | 0 bis 2, je nach Skip/Blockade | offen |
| Anzahl blocked/skipped | Zahl plus Grund | offen |
| Morning Review Dauer | Ziel: unter 30 Minuten | offen |
| Evidence vollstaendig | ja/nein je PR | offen |
| Heartbeats rekonstruierbar | ja/nein je Issue/PR | offen |
| 45-Minuten-Heartbeat eingehalten | ja/nein je aktivem Ticket | offen |
| Stale-Kandidaten | `agent:running` + letzter Heartbeat > 2h | offen |

## Lessons Learned

Nach der Pilotnacht ausfuellen:

- Was lief ohne Operator-Rueckfrage?
- Welche Evidence war morgens sofort pruefbar?
- Welche Heartbeats halfen beim Rekonstruieren?
- Welche Stellen erzeugten Gelb/Rot?
- Welche Tickets haetten nicht overnight-freigegeben werden duerfen?
- Welche Regeln im Overnight Mode oder Morning Review muessen geschaerft
  werden?

## Limit-Regel nach dem Pilot

Keine Limits werden nach einer einzelnen Pilotnacht erhoeht.

Erhoehungen sind fruehestens nach mindestens 5 erfolgreichen Overnight Runs
erlaubt. Erfolgreich heisst:

- genau definierter Abend-Prompt.
- keine Nacht-Merges.
- keine ungeplante Scope-Ausweitung.
- Heartbeats rekonstruierbar.
- Morning Review unter 30 Minuten oder mit klarer Ursache fuer Abweichung.
- PR Evidence vollstaendig oder Skip/Blockade sauber dokumentiert.
- keine neue operative Wahrheit ausserhalb von GitHub.

Auch nach 5 erfolgreichen Naechten bleibt jede Limit-Erhoehung eine separate
Operator-Entscheidung mit eigenem Issue und Review.
