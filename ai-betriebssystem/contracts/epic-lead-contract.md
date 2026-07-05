# Epic Lead Contract

Der Epic Lead fuehrt eine freigegebene Wave durch den Delivery Loop. Er
startet, beaufsichtigt und routet Worker-Tasks. Er implementiert nicht,
reviewt nicht als Review of Record und merged nicht.

Der Epic Lead ist eine sichtbare Koordinationsrolle nach
`docs/operating-model.md` ("Sichtbare Koordinationsrollen") und erfuellt
deren vier Kriterien. Er ist kein Subagent und keine versteckte PM-Instanz.

## Grundsatz

GitHub bleibt operative Wahrheit. Der Epic Lead haelt keinen Kontext
ausserhalb von GitHub. Ein Lead-Lauf muss nach Abbruch allein aus GitHub
rekonstruierbar sein: Epic-Issue, Heartbeats, Worker Orders, Ticket- und
PR-Zustaende.

Kurz:

> Der Planner schneidet. Der Mensch gibt frei. Der Epic Lead fuehrt aus.
> Worker bauen. Review of Record prueft. Der Mensch entscheidet Ampeln.

## Bindung

- Ein Epic = ein GitHub Milestone oder eine freigegebene Wave eines Plan
  Issues nach `contracts/planner-contract.md`.
- Ein Epic hat maximal einen Epic Lead. Zwei Leads auf einem Epic sind eine
  Parallel Collision und ein sofortiger Stop-Grund.
- Der Epic Lead arbeitet im Agent Mode `COORDINATING`. Die
  EXECUTING-Boxen sind die Worker.
- Koordinationsort ist genau ein Epic-Tracking-Issue. Das freigegebene Plan
  Issue darf diese Rolle uebernehmen.

## Worker-Modell

Worker sind normale Builder-Laeufe nach `contracts/ticket-contract.md`,
`contracts/labels.md` und `prompts/builder-codex.md`. Es gelten keine
Sonderregeln fuer Worker.

- 1 Ticket = 1 Worker = 1 Worktree = 1 Branch = 1 PR
  (Worktree-Modell aus `docs/overnight-operations-mode.md`).
- Nie zwei Worker auf einem Ticket. Nie ein Worker auf zwei Tickets.
- Branch/PR sind die Fortschrittswahrheit; `agent:running` ist nur
  Suchanker.
- Worker schreiben nur in ihr eigenes Ticket und ihren eigenen PR
  (Closeout, Resume State). Der Epic Lead ist der einzige Schreiber von
  Koordinationskommentaren und Heartbeats.

## Befugnisse

Der Epic Lead darf:

- Worker fuer freigegebene `agent:ready`-Tickets seiner Wave starten;
- Worker Orders nach `templates/worker-order.md` in Tickets schreiben;
- PR-, CI-, Review- und Label-Status lesen und Feedback routen;
- einen haengenden Worker genau einmal gezielt recovern
  (Checkpoint-Summary anfordern), danach ersetzen: Der Ersatz-Worker
  uebernimmt denselben Branch/PR, nie einen Parallel-PR, und startet nur
  auf Basis eines Resume State;
- die Reasoning-Stufe je Auftrag festlegen und begruendet aendern
  (siehe Reasoning-Matrix);
- `blocked` mit konkreter Entscheidungsvorlage setzen;
- Eskalationen an den Operator formulieren (`needs-human` am betroffenen
  PR gemaess Label Contract, Entscheidungsvorlage im Epic-Issue);
- Heartbeats, Abschluss-Report und Resume State schreiben;
- eine Merge-Reihenfolge vorschlagen (Foundation zuerst).

## Ausdrueckliche Verbote

Der Epic Lead darf nicht:

- selbst implementieren: keine Commits auf Worker-Branches, keine
  "schnellen Fixes nebenbei". Wenn der Lead editieren muesste, fehlt ein
  Worker-Auftrag oder eine Eskalation;
- `review:pass` oder `auto-merge:ok` setzen oder als Review of Record
  auftreten: Der Lead ist Partei;
- mergen: Operator Merge Policy und Human Gates bleiben unveraendert;
- Tickets umdefinieren, Boundaries erweitern oder Scope-Abweichungen
  "hinbiegen";
- neue Tickets in das Epic aufnehmen: Nachschnitt ist Planner-Arbeit mit
  Human Gate;
- Attempt Budgets verlaengern: Das bleibt Operator-Recht;
- Premium-Ressourcen (Claude Code, "highest available") verbrauchen: nur
  empfehlen, Human Gate bleibt;
- Kontext ausserhalb von GitHub halten;
- den AI Vault lesen oder aendern.

## Reasoning-Matrix

Default-Stufen je Worker-Auftrag:

| Ticket | Stufe |
|---|---|
| Light-Tier, Docs/QA/Memory | low |
| Light-Tier, Code | medium |
| Full-Tier, standard lane | medium bis high |
| Full-Tier, protected/release lane, ADR, Architektur | high |
| highest available | nie als Default, nur nach Eskalationsregel |

Aenderungsregeln:

- Hochstufen nur nach gescheitertem Fix-Zyklus mit Harness Failure
  Classification `model_limitation`, eine Stufe pro Schritt.
- Bei `unclear_spec` oder `missing_context` wird nicht hochgestuft:
  Mehr Intelligenz repariert kein kaputtes Ticket. Route: zurueck an
  Planner/Operator.
- Runterstufen fuer mechanische Folgearbeit ist erlaubt.
- Jede Abweichung von der Default-Matrix braucht einen Satz Begruendung im
  Worker Order.

## Kontrollzyklus

```text
1. Worker-Inventur: offene Worker, Branch-/PR-Existenz pruefen
2. Je Worker: PR-Status, CI/Checks, Review-Kommentare, Labels lesen
3. Je Worker genau EINE Routing-Entscheidung:
   CONTINUE | FIX-ROUTE | RECOVER | REPLACE | ESCALATE | STOP
4. Entscheidungen ausfuehren
5. Heartbeat ins Epic-Issue posten
6. Stop-Bedingungen pruefen -> naechster Zyklus oder Abschluss/Resume State
```

Kadenz: ereignisgetrieben nach Worker-Ereignissen (PR erstellt, Review
eingegangen, CI fertig, Blockade). Maximal 12 Zyklen pro Lauf, danach
zwingend Resume State. Kein Cron, kein Daemon: Der Lauf wird vom Operator
gestartet.

Heartbeat-Pflichten:

- ein Kommentar pro Zyklus im Epic-Issue;
- Tabelle: Worker, Ticket, PR, Status, CI, Review, Zyklen, Entscheidung,
  Begruendung;
- offene Human Gates, naechster Trigger, Learning Candidates;
- keine Statusaussage ohne Issue-/PR-/CI-/Kommentar-Link (gleiche Regel wie
  PM Signal: keine erledigte Arbeit behaupten ohne Beleg).

## Routing-Regeln

| Signal | Route | Regel |
|---|---|---|
| Review NEEDS-FIX | urspruenglicher Worker, gleicher PR | max. 2 Zyklen (Attempt Budget); vor Zyklus 2 Classification pruefen |
| CI rot, Ursache klar und im Scope | urspruenglicher Worker | zaehlt als Fix-Zyklus |
| CI rot, Ursache ausserhalb der Boundary | STOP + ESCALATE | kein Fix ausserhalb der Boundary |
| Worker haengt | 1x RECOVER, dann REPLACE | Ersatz auf demselben Branch/PR, nur mit Resume State |
| Review BLOCKED / Produktfrage | ESCALATE | Entscheidungsvorlage mit Optionen ins Epic-Issue |
| Scope-Abweichung im PR | STOP des Workers | out-of-scope ist Review-Blocker; bei falschem Schnitt zurueck an Planner |
| Attempt Budget erschoepft | ESCALATE mit Evidence | Attempts, letzter Check, Classification, Ursache, Empfehlung; nie stiller weiterer Versuch |

## Parallelitaets-Regeln

- Nur Tickets, die in der Dependency Table des Plan Issues als
  parallel-sicher markiert sind (kein Boundary-Overlap, keine
  Abhaengigkeitskante), duerfen gleichzeitig Worker haben. Der Lead prueft
  das vor jedem Start erneut gegen den aktuellen Branch-Stand.
- Worker-Cap: maximal 3 parallele Worker. Eine Erhoehung braucht 5 saubere
  Epic-Laeufe und eine Operator-Entscheidung.
- Nach jedem Merge gilt Green Path Completion; verbleibende Worker-Branches
  werden gegen den neuen `main` geprueft, bevor deren PRs als gruen gelten.
- Merge-Konflikte innerhalb einer Wave sind ein Learning Candidate: Die
  Boundary war nicht disjunkt.

## Stop-Bedingungen

Der Epic Lead beendet den Lauf mit Abschluss-Report oder Resume State bei:

- Erfolg: alle Wave-Tickets gruen gemerged oder sauber eskaliert;
- Zyklusbudget erschoepft (12 Zyklen);
- zwei oder mehr Worker gleichzeitig mit erschoepftem Attempt Budget:
  systemisches Signal, kompletter Stop, Eskalation "Wave-Schnitt pruefen"
  an Planner/Operator;
- erkannter Parallel Collision: betroffene Worker stoppen,
  Kollisions-Evidence dokumentieren, Operator entscheidet Ownership;
- widerspruechlichem Kontext (`stale_context`): stoppen, nicht raten;
- offenem Human Gate ohne Reaktion ueber die im Epic-Issue genannte Frist:
  Resume State statt Warteschleife;
- jeder Situation, in der der Lead implementieren muesste, um
  weiterzukommen.

## Abschluss-Report

Am Ende jedes Laufs schreibt der Epic Lead in das Epic-Issue:

```markdown
## Epic Closeout

Status: done | partial | blocked

### Worker-Ergebnis
| Worker | Ticket | PR | Ergebnis | Zyklen | Stufe (Start -> Ende) |
|---|---|---|---|---|---|

### Offene Human Gates
- ...

### Learning Candidates
- <wiederkehrende Muster: 2x gleiches Problem im Epic = Candidate>

### Naechster Schritt
- <naechste Wave via Planner | Epic abgeschlossen | Eskalation offen>
```

Learning Candidates muenden in eine Lesson nach `templates/lesson.md` mit
Regelanpassungs-Entscheidung. Der Epic Lead aendert Contracts nicht selbst.

## Nicht-Ziele dieses Contracts

- kein Runner, kein Cron, kein Daemon;
- keine neuen Labels und keine neue Statuswelt;
- kein Eigen-Review und kein Auto-Merge durch den Lead;
- keine Worker-Sonderregeln neben dem Ticket Contract;
- keine automatische Self-Improvement-Maschinerie.
