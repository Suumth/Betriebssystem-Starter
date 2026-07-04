# Codex Overnight Loop Prompt

Datum: `<YYYY-MM-DD>`

Repo: `<owner>/<repo>`

Optional eingeschraenkte Issues: `<#12, #34>` oder `alle passenden`

## Auftrag

Fuehre genau einen operator-armierten Overnight Run aus. Dieser Lauf ist Loop
Readiness `L2 Assisted`, keine unbeaufsichtigte Automation.

Lies zuerst:

- `docs/overnight-operations-mode.md`
- `docs/loop-readiness.md`
- `docs/green-path-completion.md`
- `contracts/ticket-contract.md`
- `contracts/labels.md`
- `templates/pull-request-template.md`, falls vorhanden

## Auswahl

Bearbeite nur offene Issues, die alle Bedingungen erfuellen:

- `agent:ready`
- `overnight:approved`
- nicht `needs-human`
- nicht `needs-fix`
- nicht `blocked`
- im Prompt nicht ausgeschlossen
- falls Issue-Nummern eingeschraenkt wurden: nur diese Issues

Sortierung:

1. zuerst explizit genannte Issue-Nummern in Prompt-Reihenfolge.
2. sonst aelteste passende offene Issues zuerst.
3. kein beliebiges Nachladen weiterer Tickets.

## Harte Limits

- Max. 4 Tickets in diesem Run.
- Max. 2 parallele Worktrees.
- Max. 1 Fixloop je PR.
- Ziel-Diff je Ticket: ca. 400 Zeilen / max. 15 Dateien.
- Max. 6 offene Agent-PRs im Repo.
- Protected- und Release-Code-Lanes sind nachts code-read-only.
- Keine neue operative Wahrheit ausserhalb von GitHub.
- Keine neuen Labels ausser den im Repo-Contract definierten.

## Worktree- und Branch-Regeln

- Ein Issue = ein Worktree = ein Branch = ein PR.
- Nutze Branches nach Repo-Konvention, zum Beispiel
  `codex/issue-<nummer>-<kurztitel>`.
- Wenn ein passender Issue-PR existiert, setze denselben Branch fort.
- Erstelle keinen Parallel-PR zum selben Issue.
- Unrelated dirty state nicht uebernehmen, nicht loeschen und nicht stagen.

## Execution Mode

- Wenn `Subagents: NOT_REQUIRED`: keine Subagents starten.
- Wenn `Subagents: REQUIRED`: die im Issue genannten Subagents vor der Umsetzung
  starten, Ergebnisse konsolidieren und Subagent Failure Policy anwenden.
- Subagents sind interne Helfer. Sie erzeugen keine zweite Wahrheit und keine
  sichtbare PM-Rolle.

## Heartbeats

Poste Heartbeats an den Pflichtzeitpunkten aus
`docs/overnight-operations-mode.md` mit diesem Format:

Zusaetzlich zu diesen Pflichtzeitpunkten: Bei aktiver Arbeit spaetestens alle
45 Minuten einen Heartbeat posten.

```markdown
### Overnight Heartbeat
- Time: YYYY-MM-DD HH:MM TZ
- Issue: #<number>
- Branch: <branch-or-none>
- PR: <url-or-none>
- State: selected | running | pr-opened | skipped | blocked | stopped | summary
- Done:
- Next:
- Evidence:
- Stop reason: none | <reason>
```

## Umsetzung

Fuer jedes ausgewaehlte Issue:

1. Issue, Kommentare, Labels und bestehende PRs lesen.
2. `agent:ready` entfernen und `agent:running` setzen.
3. Worktree/Branch vorbereiten oder bestehenden Issue-Branch fortsetzen.
4. Kleinste sichere Aenderung umsetzen.
5. Required Verification aus dem Issue ausfuehren.
6. PR erstellen oder aktualisieren.
7. PR Body als Primary Closeout Source aktualisieren.
8. `Closes #<issue-number>` in den PR Body aufnehmen.
9. Evidence, bekannte Risiken, Operator Summary, Review Recommendation und
   Harness Failure Classification dokumentieren.
10. `agent:running` und `overnight:approved` entfernen, sobald PR, Skip oder
    Blockade sauber dokumentiert ist.

## PR- und Review-Regeln

- PR nur mit Evidence.
- Keine Review-/Auto-Merge-Labels durch Codex auf eigene Builder-PRs.
- Codex setzt auf eigenen PRs nicht `review:pass`, `auto-merge:ok` oder
  `needs-human`.
- Review of Record bleibt ein separater Review-Schritt.
- Operator Summary muss `Human decision required` und
  `Claude Code Review Suggested` enthalten.

## KEIN MERGE

Nachts gilt: KEIN MERGE.

Auch bei erfolgreicher Validation, sauberem PR und scheinbar gruenem Scope
endet der Nachtlauf beim PR und der Nightly Summary. Merges sind
Operator-Handlungen im Morning Review.

## Stop-Regeln

Stoppe oder skippe, wenn:

- ein hartes Limit ueberschritten wuerde.
- Scope, Verification, Evidence oder Toolzugang fehlt.
- Protected-/Release-Code geschrieben werden muesste.
- eine menschliche Produkt-, Safety-, Legal-, Privacy-, Release- oder
  Waiver-Entscheidung noetig ist.
- ein bestehender Branch/PR uneindeutig ist.
- ein Check wiederholt fehlschlaegt und der eine Fixloop verbraucht ist.

Dokumentiere den Stop-Grund als Heartbeat und im PR/Issue.

## Abschluss: Nightly Summary

Am Ende poste eine Nightly Summary. Ort:

- bevorzugt im Batch-Issue.
- falls kein Batch-Issue existiert: als Kommentar im letzten bearbeiteten Issue
  oder PR.
- wenn praktikabel: betroffene Issues und PRs verlinken.

```markdown
### Nightly Summary
- Date:
- Repo:
- Issues considered:
- Issues completed with PR:
- Issues skipped:
- Issues blocked:
- Open PRs:
- Validation summary:
- Morning actions:
- Merge candidates:
- Needs-fix candidates:
- Human decisions:
- Harness failure classification:
```
