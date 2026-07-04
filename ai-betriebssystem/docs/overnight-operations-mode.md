# Overnight Operations Mode

## Executive Summary

Overnight Operations Mode ist eine operator-armierte Batch Green Path Execution.
Der Operator startet abends einen ausdruecklichen Lauf. Codex bearbeitet nachts
nur reife, freigegebene Issues, erstellt PRs mit Evidence und stoppt bei
unklaren Entscheidungen. Nachts wird nicht gemerged. Morgens entscheidet der
Operator anhand der Nightly Summary, der PR Bodies und der GitHub-Ampel.

Der Modus ist keine neue Plattform, kein Runner, kein Scheduler und keine
operative Wahrheit neben GitHub. Er bleibt Loop Readiness `L2 Assisted`: Der
Abend-Prompt ist der Trigger, das Morning Merge Gate bleibt menschlich.

## Die 10 harten Gesetze des Overnight Mode

1. Ein Overnight Run startet nur durch einen ausdruecklichen Abend-Prompt des
   Operators.
2. Bearbeitet werden nur offene Issues mit `agent:ready` und
   `overnight:approved`.
3. Ein Label allein startet keinen Lauf.
4. Nachts entstehen Branches, Evidence und PRs; nachts entstehen keine Merges.
5. Codex setzt auf eigenen Builder-PRs nicht `review:pass`,
   `auto-merge:ok` oder `needs-human`.
6. Protected- und Release-Code-Lanes sind nachts code-read-only.
7. GitHub bleibt die operative Wahrheit: Issues, PRs, Labels, Repo-Dateien und
   PR Bodies.
8. Jeder Issue-Lauf hat genau einen Worktree, einen Branch und einen PR.
9. Heartbeats sind Pflicht, wenn ein Lauf startet, stoppt, blockiert oder einen
   PR erzeugt.
10. Stop-Regeln schlagen Durchsatz. Wenn Evidence, Scope, Tool, Review oder
    Entscheidung fehlt, stoppt Codex statt zu raten.

## Minimal Viable Overnight Mode

Der MVP besteht nur aus:

- Abend-Prompt mit expliziter Armierung.
- Auswahl offener Issues mit `agent:ready` und `overnight:approved`.
- Bearbeitung in begrenzten Worktrees und Branches.
- PR-Erstellung mit Validation Evidence und Closeout.
- Nightly Summary fuer den Operator.
- Morning Review durch den Operator.

Nicht Teil des MVP sind Cron, Scheduler, Runner, Dashboard, GitHub Action,
Auto-Merge, eigene Bot-Zyklen, neue State-Dateien oder eine zweite Wahrheit.

## Autonomiematrix

| Kategorie | Sicher autonom | Bedingt autonom | Niemals autonom |
|---|---|---|---|
| Ticket-Auswahl | Offene `agent:ready` + `overnight:approved` Issues aus dem Abend-Prompt | Eingeschraenkte Issue-Nummern aus dem Prompt | Beliebige Queue-Erweiterung |
| Code/Doku-Aenderung | Kleine Docs, Templates, Tests, klar begrenzte Repo-Dateien | Standard-Risiko-Code mit starker lokaler Validation | Protected-/Release-Code nachts schreiben |
| Validation | Im Ticket genannte lokale Checks | Plausible Ersatzchecks mit dokumentiertem Gap | Erfolg ohne Evidence behaupten |
| Labels | `agent:ready` entfernen, `agent:running` setzen, `overnight:approved` nach PR/Skip/Blockade entfernen | `blocked` nur mit Entscheidungsvorlage | Eigene PRs mit `review:pass` oder `auto-merge:ok` gruenschalten |
| PRs | Draft/ready PR mit Evidence und `Closes #...` | PR mit offenem Restrisiko und Review Recommendation | Nacht-Merge oder Selbstreview als Review of Record |
| Entscheidungen | Scope-Treue, mechanische Repo-Hygiene, Stop bei roten Kriterien | Gelb-Faelle fuer Morning Review vorbereiten | Produkt-, Safety-, Legal-, Privacy-, Release- oder Waiver-Entscheidungen treffen |

## Ticket-Reifegrad fuer `overnight:approved`

`overnight:approved` darf nur ein bereits reifes `agent:ready` Issue fuer einen
konkreten Overnight Run vormerken. Es ersetzt `agent:ready` nicht.

Ein Ticket ist overnight-reif, wenn alle Punkte gelten:

- Ziel, Scope, Nicht-Ziele und Akzeptanzkriterien sind konkret.
- Required Verification ist nachts lokal oder ueber GitHub plausibel laufbar.
- Der Lauf ist entscheidungsfrei oder enthaelt klare Stop-Regeln.
- Risk lane ist `low` oder `standard`.
- Keine Protected- oder Release-Codearbeit ist erforderlich.
- Erwarteter Diff bleibt im Limit: ca. 400 Zeilen und max. 15 Dateien.
- Es ist kein menschlicher Waiver, keine Produktentscheidung und kein externer
  Zugang noetig.
- Execution Mode ist gesetzt; Subagents sind entweder `NOT_REQUIRED` oder
  konkret beschrieben.

Der Operator oder eine ausdrueckliche Operator-Anweisung setzt
`overnight:approved`. Codex entfernt es nach PR-Erstellung, Skip oder Blockade.

## Worktree-Modell

Jeder Overnight-Issue-Lauf folgt diesem Modell:

```text
ein Issue = ein Worktree = ein Branch = ein PR
```

Regeln:

- Maximal 4 Tickets je Overnight Run.
- Maximal 2 parallele Worktrees.
- Branches folgen der Repo-Konvention, zum Beispiel
  `codex/issue-<nummer>-<kurztitel>`.
- Ein bestehender Issue-Branch wird wiederverwendet, wenn das Issue bereits
  `agent:running` ist oder der PR eindeutig fortgesetzt werden muss.
- Keine zwei Agenten arbeiten gleichzeitig am selben Issue, Branch oder PR.
- Unrelated dirty state wird nicht uebernommen, gestaged oder bereinigt.

## Heartbeat-Format und Pflichtzeitpunkte

Heartbeats sind GitHub-Kommentare am Issue oder PR. Sie muessen kurz,
maschinenlesbar und fuer den Operator scanbar sein.

Copy-paste-Format:

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

Pflichtzeitpunkte:

- Start des Overnight Runs.
- Auswahl eines Issues.
- Branch/Worktree angelegt oder wiederverwendet.
- PR erstellt oder aktualisiert.
- Validation fehlgeschlagen.
- Issue geskippt.
- Blockade oder Stop.
- Nightly Summary am Ende des Laufs.

Zusaetzlich zu diesen Pflichtzeitpunkten gilt: Bei aktiver Arbeit muss
spaetestens alle 45 Minuten ein Heartbeat gepostet werden. Ein Morning Review
wertet `agent:running` plus letzter Heartbeat > 2h als stale-Kandidat.

Die Nightly Summary wird bevorzugt im Batch-Issue gepostet. Falls kein
Batch-Issue existiert, steht sie als Kommentar im letzten bearbeiteten Issue
oder PR. Wenn praktikabel, verlinkt die Summary die betroffenen Issues und PRs.

## Resume-Entscheidungsbaum

```text
1. Gibt es einen offenen PR zum Issue?
   - ja: PR lesen, Branch fortsetzen, keine Parallel-PR erstellen.
   - nein: weiter mit 2.
2. Traegt das Issue `agent:running`?
   - ja: Branch/Kommentar/Evidence suchen; wenn unklar, Heartbeat mit Resume Gap.
   - nein: weiter mit 3.
3. Traegt das Issue `agent:ready` + `overnight:approved`?
   - ja: neu starten, Labelstatus aktualisieren.
   - nein: skippen, nicht improvisieren.
4. Ist der Scope nachts entscheidungsfrei?
   - ja: umsetzen.
   - nein: blockieren oder fuer Morning Review markieren.
5. Ist Validation ausfuehrbar?
   - ja: laufen lassen und Evidence in PR Body.
   - nein: stoppen, fehlenden Verifier konkret benennen.
```

## Stop-Regeln und Anti-Spam-Limits

Codex stoppt oder skippt, wenn eines gilt:

- mehr als 4 Tickets im Run noetig waeren.
- mehr als 2 Worktrees parallel noetig waeren.
- mehr als 1 Fixloop je PR noetig waere.
- der erwartete Diff ca. 400 Zeilen oder 15 Dateien ueberschreitet.
- bereits 6 offene Agent-PRs im Repo existieren.
- Protected-/Release-Code geschrieben werden muesste.
- Required Verification fehlt oder nachts nicht lauffaehig ist.
- Scope, Akzeptanzkriterien oder Nicht-Ziele fehlen.
- ein Produkt-, Safety-, Legal-, Privacy-, Release- oder Waiver-Entscheid
  noetig ist.
- GitHub-Zugriff, Push, Branch oder Worktree nicht sauber funktionieren.
- ein bestehender PR oder Branch uneindeutig ist.

Anti-Spam:

- Keine Kommentarflut. Heartbeats an Pflichtzeitpunkten und spaetestens alle
  45 Minuten aktiver Arbeit.
- Kein Issue mehrfach kommentieren, wenn derselbe Stop-Grund unveraendert ist.
- Keine neuen Follow-up-Issues nachts, ausser der Abend-Prompt erlaubt es
  ausdruecklich.
- Keine Label-Explosion. `overnight:approved` ist das einzige
  Overnight-Auswahllabel.

## Subagent-Regeln fuer Overnight

Subagents sind interne Codex-Ausfuehrungshelfer, keine neue operative Rolle.

- `Subagents: NOT_REQUIRED`: keine Subagents starten.
- `Subagents: REQUIRED`: nur die im Issue beschriebenen Subagents starten.
- Bevorzugt read-only Subagents fuer Exploration, Validation und Risiko.
- Ein haengender oder unbrauchbarer Subagent bekommt maximal einen Recovery-
  Versuch.
- Degraded mode ist nur erlaubt, wenn die fehlende Analyse read-only war, sicher
  rekonstruierbar ist und keine kritische Risiko- oder Verifier-Pruefung fehlt.
- Subagent-Ergebnisse, Recovery, degraded-mode-Entscheidung und Restrisiko
  stehen im PR Body.

## Verhaeltnis zu Batch Green Path und Loop Readiness L2

Overnight Operations Mode ist eine spezielle, zeitversetzte Form von Batch
Green Path Execution:

- Der Operator beauftragt abends einen Batch.
- Codex arbeitet bounded, evidence-first und PR-basiert.
- Der Green Path endet nachts beim PR und der Nightly Summary, nicht beim Merge.
- Morgens prueft der Operator die Ampel und entscheidet ueber Merge, Review,
  Fix oder Blockade.

Loop Readiness bleibt `L2 Assisted`, weil:

- der Abend-Prompt den Lauf explizit startet.
- GitHub die Wahrheit bleibt.
- PRs Review of Record und Morning Merge Gate brauchen.
- kein Cron, Scheduler, Bot-Zyklus, Auto-Merge oder hidden state existiert.

## Was ausdruecklich nicht gebaut wird

- Kein Dashboard.
- Kein Runner.
- Kein Cron oder Scheduler.
- Keine GitHub Action.
- Kein Auto-Merge.
- Kein eigener Run-State wie `NIGHT.md`, `STATE.md` oder `LOOP.md`.
- Keine operative Wahrheit ausserhalb von GitHub.
- Keine Labels fuer `stale`, `abandoned`, `night`, `heartbeat`, `batch`,
  `worktree` oder `run:*`.
- Keine automatische Ticket-Erzeugung nachts.
- Keine Protected-/Release-Code-PRs bei Nacht.
