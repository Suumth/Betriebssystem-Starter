# Morning Operator Review

Ziel: Der Operator entscheidet den Overnight Run in unter 30 Minuten. Nicht
alles lesen; erst die Nightly Summary, dann GitHub-Ampel, dann nur die
abweichenden PRs.

## Vorbereitung

Setze das Repo fuer die Abfragen:

```bash
REPO="<owner>/<repo>"
SINCE="<YYYY-MM-DDT18:00:00Z>"
```

Lies zuerst die `Nightly Summary` aus dem Overnight Run. Sie ist der Index,
nicht die Wahrheit. Die Wahrheit bleibt GitHub: Issues, PRs, Labels, Checks,
Review-Kommentare und PR Bodies.

## Reihenfolge der Morning Review

1. Nightly Summary scannen.
2. Blockierte oder menschliche Entscheidungen zuerst klaeren.
3. Nacht-PRs nach Ampel sortieren.
4. `needs-fix` an Codex zurueckgeben.
5. Stale/abandoned Kandidaten entscheiden.
6. Nur Gruen-Kandidaten mergen oder fuer Review of Record freigeben.

30-Minuten-Regel: Wenn nach 30 Minuten mehr als ein roter oder unklarer Fall
offen ist, stoppe die Review und erstelle gezielte Follow-up-Auftraege. Kein
Bulk-Merge unter Zeitdruck.

## GitHub-Abfragen

Blockiert / braucht Mensch:

```bash
gh issue list --repo "$REPO" --state open --label blocked --limit 50
gh issue list --repo "$REPO" --state open --label needs-human --limit 50
gh pr list --repo "$REPO" --state open --label blocked --limit 50
gh pr list --repo "$REPO" --state open --label needs-human --limit 50
```

Naechtliche Agent-PRs:

```bash
gh pr list --repo "$REPO" --state open --author "@me" --search "created:>=$SINCE" --limit 50
gh pr list --repo "$REPO" --state open --search "overnight in:body created:>=$SINCE" --limit 50
```

`agent:running` / stale Kandidaten:

```bash
gh issue list --repo "$REPO" --state open --label agent:running --limit 50
gh issue list --repo "$REPO" --state open --search "label:agent:running updated:<$(date -u -v-1d +%Y-%m-%d)" --limit 50
```

Stale-Auswertung: Ein Issue mit `agent:running` ist ein stale-Kandidat, wenn
der letzte Overnight Heartbeat aelter als 2h ist oder Branch-/PR-Aktivitaet
nicht zum letzten Heartbeat passt. Dann zuerst Resume-Kontext pruefen, nicht
blind mergen oder neu starten.

Alte offene Agent-PRs / abandoned Kandidaten:

```bash
gh pr list --repo "$REPO" --state open --search "author:app/codex updated:<$(date -u -v-3d +%Y-%m-%d)" --limit 50
gh pr list --repo "$REPO" --state open --search "author:@me updated:<$(date -u -v-3d +%Y-%m-%d)" --limit 50
```

Review-/Merge-Signale:

```bash
gh pr list --repo "$REPO" --state open --label review:pass --limit 50
gh pr list --repo "$REPO" --state open --label auto-merge:ok --limit 50
gh pr list --repo "$REPO" --state open --label needs-fix --limit 50
```

Wenn `date -v` lokal nicht verfuegbar ist, ersetze den Datumswert manuell im
Format `YYYY-MM-DD`.

## Ampellogik

Gruen / merge-ready candidate:

- PR verlinkt genau ein erwartetes Issue oder einen klaren Issue-Batch.
- PR Body enthaelt Summary, Changed Files, Validation, Evidence, Operator
  Summary, Review Recommendation und Harness Failure Classification.
- Validation ist bestanden oder sauber als nicht erforderlich begruendet.
- Review of Record ist PASS.
- `review:pass` und `auto-merge:ok` sind gesetzt, keine roten/gelben Labels.
- `Human decision required: no`.

Gelb / needs-fix oder Review noetig:

- Validation ist teilweise, Evidence ist unklar oder Review fehlt.
- Risk lane ist `standard` mit Grundsatznaehe oder `protected`.
- `needs-fix` ist gesetzt oder der PR Body empfiehlt weiteren Review.
- Aktion: direkt an Codex zurueckgeben oder Review durch Codex/Fable/Claude
  beauftragen.

Rot / blocked oder fehlende Evidence:

- `blocked` oder `needs-human` ist gesetzt.
- Required Verification fehlt.
- Scope wurde erweitert.
- Protected-/Release-Code wurde nachts geschrieben.
- Produkt-, Safety-, Legal-, Privacy-, Release- oder Waiver-Entscheidung fehlt.
- Aktion: nicht mergen; Operator-Entscheidung oder gezielten Follow-up-Auftrag
  formulieren.

Stale / Resume-Entscheidung:

- Issue traegt `agent:running`, aber es gibt keinen aktuellen PR, keinen
  aktuellen Heartbeat oder der letzte Heartbeat ist aelter als 2h.
- PR ist seit mehreren Tagen offen und nicht in Review.
- Aktion: Resume an Codex, schließen, blockieren oder neu schneiden.

Abandoned Kandidat:

- Alter Agent-PR ohne aktuelle Evidence, Review oder klares Issue.
- Aktion: nicht mergen; Codex mit Resume/Closeout beauftragen oder PR schliessen.

## Delegationsregeln

Direkt zurueck an Codex:

- fehlender kleiner Nachweis.
- kleiner `needs-fix` Punkt.
- PR Body unvollstaendig.
- mechanischer Konflikt nach neuerem `main`.

Review durch Codex/Fable/Claude:

- Evidence ist vorhanden, aber die Bewertung braucht eine zweite Sicht.
- Grundsatzdoku, Contract oder Template-Regel wurde geaendert.
- Risiko ist `standard` mit groesserer Reichweite.
- Protected Area wurde tagsueber vorbereitet und braucht Review of Record.

Operator-Entscheidung:

- Produkt-, Safety-, Legal-, Privacy-, Release- oder Waiver-Frage.
- `needs-human` ist gesetzt.
- Claude Code Review Suggested: yes.
- Auto-Merge-Ampel ist Gelb oder Rot.

## Merge-Regel

Nachts keine Merges. Morgens entscheidet der Operator. Der Operator kann
mechanisch mergen, wenn die Gruen-Kriterien der Operator Merge Policy erfuellt
sind. Bei Gelb oder Rot wird nicht gemerged, sondern delegiert, gefixt oder
blockiert.
