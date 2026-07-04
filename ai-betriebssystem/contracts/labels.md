# Label Contract

AI-Betriebssystem 2.0 nutzt im MVP fünf operative Workflow-Labels, ein
Overnight-Freigabelabel und zwei Merge-/Review-Signale.

## Operative Labels

| Label | Wer setzt | Bedeutung |
|---|---|---|
| `agent:ready` | ChatGPT / Opus | Ticket ist reif und darf von Codex bearbeitet werden |
| `agent:running` | Codex | Ticket läuft oder ist auf bestehendem Branch/PR fortzusetzen |
| `needs-fix` | Review of Record | PR braucht konkrete Nacharbeit durch Codex |
| `needs-human` | Reviewer / Codex | Mensch muss entscheiden; Auto-Merge ist verboten |
| `blocked` | jeder Agent | Ohne menschliche Entscheidung oder externe Voraussetzung geht es nicht weiter |

## Merge- und Review-Signale

| Label | Wer setzt | Bedeutung |
|---|---|---|
| `review:pass` | Review of Record | Der verlinkte PR wurde gegen das Issue geprüft und mit PASS bewertet |
| `auto-merge:ok` | Review of Record / Operator | Der PR ist ein Grün-Fall und darf mechanisch gemerged werden, wenn alle Grün-Kriterien weiterhin gelten |

## Overnight-Freigabelabel

| Label | Wer setzt | Wer entfernt | Bedeutung | Nicht-Bedeutung |
|---|---|---|---|---|
| `overnight:approved` | Operator oder ausdrückliche Operator-Anweisung | Codex nach PR-Erstellung, Skip oder Blockade | Bereits reifes `agent:ready` Ticket darf im nächsten operator-armierten Overnight Run ausgewählt werden | Startet keinen Lauf allein, ersetzt kein Statuslabel und erlaubt keinen Nacht-Merge |

## Bedeutung der Labels

### agent:ready

Das Ticket erfüllt den Ticket Contract. Codex darf es ohne Rückfrage starten.

Voraussetzungen:

- Ziel klar
- Scope begrenzt
- Nicht-Ziele definiert
- Akzeptanzkriterien prüfbar
- Validierung konkret
- Evidence definiert

### agent:running

Codex hat begonnen oder ein bestehender Lauf muss fortgesetzt werden.

Wichtig: Ohne Runner ist dieses Label kein perfekter Lock. Branch und PR sind die echte Fortschrittswahrheit.

### needs-fix

Der Review of Record hat konkrete Nacharbeit gefordert. Codex arbeitet am selben Branch/PR weiter. Kein neuer Parallel-PR.

### needs-human

Der PR braucht eine Operator-Entscheidung. Solange `needs-human` gesetzt ist, ist Auto-Merge verboten.

Typische Gründe:

- Produkt-, Rechts-, Safety-, Release- oder Risikoentscheidung
- uneindeutige Evidence
- Review-Uneinigkeit
- bewusstes Risiko trotz sonst guter Validierung

`needs-human` ist kein Freigabe-Synonym. Ein grüner PR braucht stattdessen `review:pass`, `auto-merge:ok` und darf kein `needs-human` tragen.

### blocked

Der Agent kann nicht sinnvoll fortsetzen. Der Kommentar muss eine konkrete Entscheidungsvorlage enthalten.

### overnight:approved

`overnight:approved` ist das einzige zusätzliche Auswahllabel für Overnight
Operations Mode. Es darf nur zusammen mit `agent:ready` für Overnight-Auswahl
verwendet werden.

Semantik:

- Wird vom Operator oder auf ausdrückliche Operator-Anweisung gesetzt.
- Bedeutet: Dieses bereits reife Ticket darf in einem konkreten, abends
  armierten Overnight Run bearbeitet werden.
- Bedeutet nicht: automatische Ausführung ohne Abend-Prompt.
- Bedeutet nicht: Status, Review, Grün-Freigabe oder Merge-Erlaubnis.
- Ist kein Ersatz für `agent:ready`, `agent:running`, `blocked`,
  `needs-fix` oder `needs-human`.
- Wird nach PR-Erstellung, Skip oder Blockade entfernt.

Ein Label allein startet keinen Lauf. Der Abend-Prompt armiert den Run.

### review:pass

`review:pass` dokumentiert den Review of Record. Das Signal bedeutet nur:

- PR wurde gegen das verlinkte Issue geprüft.
- Ziel, Scope, Nicht-Ziele, Akzeptanzkriterien, Validierung und Evidence wurden bewertet.
- Ergebnis ist PASS.

`review:pass` alleine erlaubt noch keinen Auto-Merge. Auto-Merge braucht zusätzlich `auto-merge:ok` und alle Grün-Kriterien aus der Operator Merge Policy.

### auto-merge:ok

`auto-merge:ok` ist das explizite Grün-Signal. Es darf nur gesetzt werden, wenn:

- Issue verlinkt ist
- Scope eingehalten wurde
- Validation bestanden wurde
- Evidence vorhanden ist
- `review:pass` gesetzt ist oder der Review of Record eindeutig PASS sagt
- kein `needs-fix`
- kein `blocked`
- kein `needs-human`
- `Human decision required: no`
- `Claude Code Review Suggested: no` oder `Claude Code Review Suggested: yes` mit explizit dokumentierter Operator-Ablehnung

Wenn eines dieser Kriterien nicht erfüllt ist, darf `auto-merge:ok` nicht gesetzt werden.

## Statusregeln für Codex

Beim Start eines Tickets:

- `agent:ready` entfernen
- `agent:running` setzen
- Branch `agent/<issue-number>-<short-title>` erstellen oder wiederverwenden

Bei Fertigstellung:

- PR erstellen oder aktualisieren
- PR mit `Closes #<issue-number>` verknüpfen
- Validierung ausführen
- Evidence anhängen
- Closeout schreiben
- bei Overnight Runs `overnight:approved` entfernen
- `agent:running` entfernen
- kein `needs-human`, `review:pass` oder `auto-merge:ok` selbst setzen, solange Codex nur Builder ist

Bei Limit-/Rechte-Abbruch:

- `agent:running` bleibt gesetzt
- Branch/PR bleiben bestehen
- Kommentar `Resume State` schreiben:
  - erledigt
  - offen
  - nächster Schritt
  - Blockade, falls vorhanden

## Statusregeln für Review of Record

Review-Ergebnis:

- PASS/Grün -> `review:pass` und `auto-merge:ok` setzen, `needs-fix`, `blocked` und `needs-human` entfernen
- PASS/Gelb -> `review:pass` und `needs-human` setzen, `auto-merge:ok` entfernen, Review Recommendation schreiben
- NEEDS-FIX/Rot -> `needs-fix` setzen, `needs-human`, `review:pass` und `auto-merge:ok` entfernen, Fix-Empfehlung schreiben
- BLOCKED/Rot -> `blocked` setzen, `needs-human`, `needs-fix`, `auto-merge:ok` und `review:pass` entfernen, Entscheidungsvorlage schreiben

`blocked` ist stärker als `needs-human`. Beide Labels sollen nicht parallel als Standardzustand stehen, außer ein Contract begründet den Sonderfall ausdrücklich.

## Optionale Lane-Tags

Lane-Tags sind nur Filterhilfe, keine Steuerung:

- `lane:ios`
- `lane:macos`
- `lane:web`
- `lane:docs`
- `lane:marketing`

Im MVP sind sie optional. Sie dürfen keine zusätzliche operative Logik erzeugen.

## Nicht verwenden im MVP

- lange Statusmodelle
- mehrere Review-Ampeln gleichzeitig
- `status:*`-Parallelwelt
- Runner-spezifische Claim-/Lease-Labels
- weitere Auto-Merge-Labels neben `auto-merge:ok`
- weitere Overnight-Labels wie `stale`, `abandoned`, `night`, `heartbeat`,
  `batch`, `worktree` oder `run:*`
