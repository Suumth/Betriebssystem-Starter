# Builder Review Handoff

## Regel

Nach erfolgreicher PR-Erstellung, Validierung und Evidence ist die Builder-Arbeit erst abgeschlossen, wenn der PR reviewfaehig geschlossen ist.

Der Builder endet nicht nur mit Code oder Doku. Er aktualisiert den PR Body als Primary Closeout Source, so dass Review of Record oder Merge-Freigabe ohne Rueckfrage moeglich sind.

PR-Kommentare dürfen Evidence oder Notes ergaenzen, ersetzen aber nicht die Standardquelle. Wenn ein PR-Kommentar wichtige Closeout-Information enthält, muss der PR Body darauf verweisen.

Die Review-/Merge-Signale `review:pass`, `auto-merge:ok` und `needs-human` gehören nicht zum reinen Builder-Handoff. `needs-human` bedeutet Gelb und blockiert Auto-Merge.

## Warum

Im ersten Pilot mit `<OWNER>/<REPO>#13` / PR `#14` wurde sichtbar:

- Codex lieferte korrekt.
- Claude Code konnte sauber reviewen.
- Ein zu früh gesetztes `needs-human` kann den Reviewer-Prompt stören und blockiert Auto-Merge.

## Konsequenz

Builder-Handoff bedeutet:

- PR ist erstellt oder aktualisiert.
- Validation ist dokumentiert.
- Evidence ist dokumentiert.
- Reviewfaehiger PR-Closeout ist vorhanden.
- Review of Record kann den Closeout primaer aus dem PR Body lesen und dort erkennen:
  - was geaendert wurde
  - welche Evidence existiert
  - welche Risiken oder offenen Punkte bleiben
  - ob `Human decision required` gilt
  - ob `Claude Code Review Suggested` gilt
  - welche Harness Failure Classification gilt
- PR-Kommentare ergaenzen nur; relevante Kommentar-Evidence ist im PR Body verlinkt oder kurz benannt.
- Reviewer entscheidet Grün, Gelb oder Rot.
