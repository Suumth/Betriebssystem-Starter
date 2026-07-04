# Green Path Completion

## Kernsatz

Ein Green Path endet nicht mit dem Merge-Befehl. Er endet erst, wenn das lokale Repo wieder sauber auf `main` steht und Codex entweder das nächste `agent:ready` Ticket übernimmt oder einen konkreten Stop-Grund dokumentiert.

Diese Regel ist Methode, keine neue Automation. Sie führt keinen Runner, keine GitHub Action, kein Dashboard und keine Auto-Merge-Implementierung ein.

## Batch Green Path Execution

Batch Green Path Execution bedeutet: Der Nutzer beauftragt Codex ausdrücklich mit mehreren reifen Tickets in einem Lauf. Die Batch-Größe ergibt sich aus dem Nutzerauftrag, nicht aus einer festen Zahl und nicht aus automatischer Queue-Ausweitung.

In einem solchen Ticket-Batch schliesst Codex nach jedem grünen PR zuerst den Green Path vollständig ab, bevor das nächste beauftragte Ticket gestartet wird:

```text
1. PR Review of Record prüfen.
2. Merge gemäß Green-Path-Regel durchführen.
3. git checkout main
4. git pull --ff-only origin main
5. git status
6. Nur bei sauberem main: nächstes beauftragtes, reifes Ticket übernehmen.
```

Batch Green Path Execution erlaubt keine blinde Bearbeitung beliebiger Queue-Einträge. Fortsetzung ist nur erlaubt, wenn das nächste Ticket Teil des ausdrücklichen Nutzerauftrags ist und weiterhin reif ist.

### Green Criteria für Batch-Fortsetzung

Codex darf im Batch nur fortsetzen, wenn alle Kriterien gelten:

- PR Review of Record ist grün oder die vom Nutzer beauftragte Merge-Freigabe liegt ausdrücklich vor.
- erforderliche Checks und Validierung sind erfolgreich oder als nicht erforderlich dokumentiert.
- keine Labels oder Signale blockieren den Merge: kein `needs-human`, `needs-fix` oder `blocked`.
- keine Protected Area, Release-Entscheidung, Waiver-Entscheidung oder ungeklärte Evidence blockiert.
- Merge und lokaler Sync sind erfolgreich abgeschlossen.
- `git status` zeigt nach `git checkout main` und `git pull --ff-only origin main` einen sauberen Stand.

## Pflichtablauf nach grünem Merge

Wenn ein PR nach Review of Record und Merge-Freigabe erfolgreich gemerged wird, führt Codex die sicheren Green-Path-Schritte ohne Rückfrage aus:

```text
1. gh pr merge <PR> --squash --delete-branch
2. git checkout main
3. git pull --ff-only origin main
4. git status
5. Wenn sauber: nächstes agent:ready Ticket suchen/wählen und fortsetzen.
```

Safe Green-Path-Schritte werden ausgeführt, nicht bestätigt. Dazu gehören `git checkout main`, `git pull --ff-only origin main` und `git status`, wenn der Merge erfolgreich war und kein Stop-Grund vorliegt.

## Nächstes Ticket

Nach sauberem `main` gilt wieder die Standard-Reihenfolge:

1. zuerst offene PRs/Issues mit `needs-fix`
2. dann Tickets mit `agent:running` als Resume-Kandidaten
3. dann genau ein neues Ticket mit `agent:ready`

Wenn kein nächstes bearbeitbares Ticket existiert, dokumentiert Codex den Idle-/Complete-Zustand im aktuellen Lauf und stoppt.

Bei Batch Green Path Execution ersetzt der Nutzerauftrag die offene Queue-Suche: Codex nimmt nach sauberem `main` nur das nächste beauftragte ready Ticket aus dem Batch. Wenn kein weiteres beauftragtes Ticket übrig ist, ist der Batch abgeschlossen.

## Stop-Gründe

Codex stoppt statt weiterzulaufen, wenn einer dieser Gründe eintritt:

- Merge fehlgeschlagen
- Checks fehlgeschlagen oder fehlen, obwohl sie im Ticket, Review oder Merge-Gate verlangt sind
- `git checkout main` fehlgeschlagen
- `git pull --ff-only origin main` fehlgeschlagen
- Working tree nach Sync dirty
- Merge-Konflikt
- fehlende GitHub- oder `gh`-Berechtigung
- fehlende lokale Tool-Berechtigung
- `needs-human`
- `needs-fix`
- `blocked`
- Protected-/Release-/Waiver-Entscheidung erforderlich
- Scope unklar
- Evidence fehlt oder ist unklar
- kein weiteres beauftragtes Ticket im Batch

Der Stop muss einen konkreten nächsten Schritt nennen: Fix, Review, Human Gate, Berechtigung klären, fehlende Evidence nachziehen oder Ticket nachschärfen.

## Abgrenzung

Diese Regel erlaubt keine blinde Fortsetzung über Stop-Gründe hinweg. Sie sagt nur: Nach einem grünen, erfolgreichen Merge fragt Codex nicht mehr nach mechanischer lokaler Hygiene, sondern erledigt sie und nimmt danach den nächsten klaren Queue-Eintrag.
