# First Agent Loop

## Ablauf

1. Mensch wählt ein Issue aus.
2. Builder liest `PROJECT.md`, `AGENTS.md`, Ticket Contract und task lokalen Scope.
3. Builder arbeitet lokal, sammelt Evidence und erstellt einen PR oder PR-Entwurf.
4. Reviewer prüft getrennt als Review of Record.
5. Mensch entscheidet über Human Gate, Merge oder Fix-Schleife.
6. Nach Merge wird Wissen in Vault und Projekt-Dokumente zurückgespiegelt.

## Green Path

Ein Green Path braucht:

- passendes Issue
- enger Scope
- saubere Labels
- eindeutige Validation Evidence
- Review of Record PASS
- `auto-merge:ok` nur nach PASS
- keine offenen Human Gates

## Kein Green Path

Bei `needs-human`, `blocked`, `risk:protected`, `risk:release`, fehlender Evidence, Secret-/Pfad-Treffern oder unklarem Review darf der Loop nicht automatisch fertiggemeldet werden.

