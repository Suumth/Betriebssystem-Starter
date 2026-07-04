# Lesson: Review Isolation

## Kontext

Builder und Reviewer duerfen im selben Arbeitsfluss vorkommen, aber nicht dieselbe Rolle fuer dieselbe Lieferung vermischen.

## Beobachtung

Ein Review of Record ist nur belastbar, wenn er Scope, Evidence, Risiko, Label-Semantik und Human Gate unabhaengig prueft.

## Regel

`review:pass` darf erst nach einem echten Review of Record gesetzt werden. `auto-merge:ok` setzt zusaetzlich voraus, dass keine `needs-fix`, `needs-human` oder `blocked` Signale offen sind.

