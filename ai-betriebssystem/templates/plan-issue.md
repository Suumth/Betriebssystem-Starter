# Plan Issue Template

Kopiervorlage fuer das Ergebnis eines Repository-Planner-Laufs nach
`contracts/planner-contract.md`. Ein Plan Issue ist die menschlich
pruefbare Entscheidungsvorlage: Der Operator gibt den Plan frei, nicht
jedes Ticket einzeln.

Ein Plan Issue bekommt nie selbst `agent:ready`.

---

```markdown
# Plan: <Ziel in einem Satz>

## Plan Contract

Typ: Plan (kein Arbeitsticket, kein agent:ready)
Goal Issue: #<N>
Ziel-Repo: OWNER/REPO
Planner-Lauf: <Datum, YYYY-MM-DD>
Wave: <n> von <geschaetzt gesamt>
Status: Entwurf | zur Freigabe | freigegeben | abgelehnt | ueberholt

## 1. Architecture Read

Wie ist der relevante Bereich heute gebaut? Nur belegbare Aussagen mit
Datei-/Pfadangabe.

- <Aussage> — Beleg: `pfad/datei.md`
- <Aussage> — Beleg: `pfad/datei.py`

## 2. Affected Areas

| Bereich | Dateien/Pfade | Betroffene Contracts/Templates | Betroffene Tests |
|---|---|---|---|
|  |  |  |  |

## 3. Open Work Check

Offene Issues und PRs, die dieses Ziel beruehren:

| Issue/PR | Bezug | Konflikt/Ueberschneidung | Konsequenz fuer den Plan |
|---|---|---|---|
|  |  |  |  |

## 4. Risks

| Risiko | Betroffenes Ticket | Vorgeschlagene Risk lane | Begruendung |
|---|---|---|---|
|  |  |  |  |

## 5. Dependency Table

| Ticket | depends_on | blocks | Boundary-Overlap mit | Parallel-sicher |
|---|---|---|---|---|
| T1 | — |  | — | ja |
| T2 | T1 |  | — | nein |

Regel: Nur Tickets ohne Abhaengigkeitskante und ohne Boundary-Overlap
duerfen parallel in dieselbe Wave.

## 6. Ticket-Stack

### Wave <n> (voll ausgearbeitet, 3-5 Tickets)

Jedes Ticket erfuellt den Ticket Contract vollstaendig. Je Ticket:

#### T<x>: <Titel>

- Typ: Foundation | Research | ADR | Refactoring | Feature | QA | Review | Documentation | Release | Memory
- Tier: Light | Full (nach `contracts/ticket-contract.md`)
- Agent Mode: EXECUTING | GRILLING | COORDINATING
- Risk lane: low | standard | protected | release
- Milestone: <Milestone oder begruendete Ausnahme>
- Warum jetzt / was schaltet es frei:
- Worker-Order-Vorgabe:
  - Reasoning-Stufe: low | medium | high | highest available
  - Begruendung der Stufe: <1 Satz nach
    contracts/epic-lead-contract.md#reasoning-matrix>
  - Hinweis: Plan-/Lead-Uebergabe, keine Worker-Freigabe.
- Vollstaendiger Ticket-Body: <eingebettet oder als klar markierter
  Entwurfsblock nach `templates/github-issue-task.md` bzw.
  `templates/github-issue-task-light.md`>
- Traceability im Ticket-Body:
  - `Planned-by: Repository Planner (Plan Issue #N)`
  - `Wave: <n>`

### Spaetere Waves (nur Skizze)

| Ticket | Ein-Satz-Skizze | Vermutete Abhaengigkeit |
|---|---|---|
|  |  |  |

Spaetere Waves werden erst nach Merge der aktuellen Wave und erneuter
Repo-Analyse ausgearbeitet. Diese Skizzen sind Orientierung, keine Zusage.

## 7. Non-Goals dieses Plans

- <was dieser Plan ausdruecklich nicht loest>

## 8. Confidence / Missing Evidence

- Sicher belegt: <...>
- Unsicher / angenommen: <...>
- Fehlende Entscheidung durch den Menschen: <...>

## Freigabe (Human Gate)

- Plan geprueft von: <Operator>
- Datum:
- Entscheidung: freigegeben | geaendert freigegeben | abgelehnt
- Aenderungen/Auflagen:
- Hinweis: Tickets mit Risk lane `protected` oder `release` behalten ihr
  Einzel-Human-Gate zusaetzlich zur Plan-Freigabe.

## Nach der Freigabe

1. Wave-Tickets als Issues anlegen (mit Traceability-Zeilen).
2. `agent:ready` setzen — erst jetzt, nie durch den Planner selbst.
3. Nach Merge der Wave: Repo neu analysieren, naechste Wave in diesem oder
   einem Folge-Plan-Issue ausarbeiten.
4. Planning-Retro-Signale fuer die Lesson sammeln
   (`contracts/planner-contract.md#learning-regel`).
```

---

## Regeln

- Prozentzahlen, Scores, Velocity, Burndowns und Forecasts sind auch im
  Plan Issue verboten (gleiche Regel wie `contracts/teilprojekt-contract.md`).
- Jede Architekturaussage braucht einen Datei- oder Link-Beleg. Ein Plan
  ohne Belege ist ein Entwurf, keine Entscheidungsvorlage.
- Ein Plan, dessen Wave gemerged wurde, ist verbraucht. Die naechste Wave
  braucht eine frische Repo-Analyse; alte Planstaende werden als
  `ueberholt` markiert, nicht weitergepflegt.
