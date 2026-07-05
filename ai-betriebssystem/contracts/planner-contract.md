# Planner Contract

Der Repository Planner macht aus einem menschlichen Ziel einen pruefbaren,
menschlich freigebbaren Arbeitsplan. Er ersetzt das manuelle Ticketschreiben,
nicht das Human Gate.

## Grundsatz

GitHub bleibt operative Wahrheit. Der Planner ist eine lesende Rolle:

- Er liest GitHub (Issues, PRs, Labels, Milestones, Reviews, Closeouts) und
  Repo-Dateien (`PROJECT.md`, `AGENTS.md`, Contracts, Tests, Docs, Lessons).
- Er liest nicht den AI Vault als operativen Kontext.
- Er schreibt genau ein Artefakt: ein Plan Issue nach
  `templates/plan-issue.md`.
- Er setzt niemals selbst `agent:ready`. Reife entsteht erst durch
  menschliche Plan-Freigabe.

Kurz:

> Der Planner schlaegt Arbeit vor. Der Mensch gibt Arbeit frei. Der Builder
> beweist Arbeit.

## Rollentrennung

| Rolle | Aufgabe | Grenze |
|---|---|---|
| Strategic Planner (Mensch + AI Vault) | Was bauen wir, warum | keine operative Ticketarbeit |
| Repository Planner | Ziel in Architekturanalyse, Risiken, Abhaengigkeiten und Ticket-Stack zerlegen | setzt kein `agent:ready`, merged nicht, baut nicht |
| Builder | ein reifes Ticket in einen beweisbaren PR verwandeln | plant nicht neu, erweitert keine Boundary |
| Review of Record | PR gegen Issue pruefen, Ampel setzen | plant nicht, redefiniert kein Ticket |
| Operator | Plan freigeben, Ampeln entscheiden, mergen | schreibt keine Tickets mehr von Hand als Standardweg |

Der Repository Planner ist eine Faehigkeitsrolle, kein Tool. Welche App oder
welches Modell die Rolle ausfuehrt, ist austauschbar und wird nicht im
Contract festgelegt.

## Input: Goal Issue

Der Planner startet nur auf ein Goal Issue nach `templates/goal-issue.md`.

Ein Goal Issue ist reif fuer Planung, wenn es enthaelt:

- ein Ziel in einem Satz;
- das Ziel-Repo;
- bekannte Nicht-Ziele, soweit vorhanden;
- bekannte Grenzen (Protected Areas, Deadlines, Budget), soweit vorhanden.

Fehlt das Ziel oder das Repo, stoppt der Planner mit einer konkreten
Rueckfrage im Goal Issue. Er erfindet kein Ziel.

## Output: Plan Issue

Der Planner erzeugt genau ein Plan Issue nach `templates/plan-issue.md` mit:

1. Architecture Read: Wie ist der relevante Repo-Bereich heute gebaut, mit
   Datei-/Pfadbelegen.
2. Affected Areas: betroffene Bereiche, Contracts, Templates, Tests.
3. Open Work Check: offene Issues und PRs, die das Ziel beruehren,
   ueberschneiden oder blockieren.
4. Risks: konkrete Risiken mit vorgeschlagener Risk lane je Ticket.
5. Dependency Table: Ticket, depends_on, blocks, Boundary-Overlap ja/nein.
6. Ticket-Stack: Wave 1 voll ausgearbeitet, spaetere Waves nur als Skizze.
7. Non-Goals des Plans.
8. Confidence / Missing Evidence.

Jedes Wave-1-Ticket im Plan muss den Ticket Contract vollstaendig erfuellen
(`contracts/ticket-contract.md`), inklusive Tier-Wahl (Light/Full), Agent
Mode, Risk lane, Boundary, Verification, Evidence und Stop-Bedingung. Ein
Planner-Ticket, das die Ticket Maturity Rule nicht erfuellt, ist kein
Planungsergebnis, sondern ein Entwurf und muss als solcher markiert sein.

## Rolling-Wave-Regel

Der Planner erzeugt keinen vollstaendigen Detailplan im Voraus.

- Wave 1 umfasst 3 bis 5 Tickets, voll ausgearbeitet.
- Spaetere Waves stehen nur als Titel plus Ein-Satz-Skizze im Plan Issue.
- Nach Merge der Wave liest der Planner das Repo neu und arbeitet die
  naechste Wave aus. Der Repo-Zustand nach dem Merge ist die Wahrheit, nicht
  der alte Plan.
- Ein im Voraus ausformulierter Detailplan ueber viele Waves ist
  `stale_context` auf Planungsebene und verletzt diesen Contract.

## Parallelisierungs-Regel

- Zwei Tickets duerfen nur dann gemeinsam in einer Wave freigegeben werden,
  wenn ihre `Allowed changes`-Mengen disjunkt sind und keine
  Abhaengigkeitskante zwischen ihnen besteht.
- Foundation-Arbeit (Arbeit, die andere Tickets als Voraussetzung nennen)
  wird zuerst sequenziert.
- Integrationsarbeit, die mehrere Wave-Ergebnisse zusammenfuehrt, bekommt
  ein eigenes Ticket mit eigener Boundary. Sie wird nicht implizit in einem
  Einzelticket versteckt.
- Bei Boundary-Overlap gilt: sequenzieren oder zusammenfuehren, nie parallel.

## Schnitt-Regeln

Teilen, wenn:

- ein Ticket mehr als einen unabhaengigen Verification-Pfad braucht;
- mehr als eine Oberflaeche oder Lane betroffen ist;
- ein Light-Kriterium waehrend der Planung kippt;
- der erwartete Diff die Review-Faehigkeit einer Sitzung uebersteigt.

Zusammenfuehren, wenn:

- ein Ticket ohne sein Vorgaenger-Ticket nicht sinnvoll reviewbar ist;
- der Contract-Overhead den Arbeitsinhalt uebersteigt.

Neu planen, wenn:

- wiederholt `unclear_spec` oder `missing_context` in derselben Area
  klassifiziert wird;
- die reale Kopplung im Repo vom geplanten Dependency-Graph abweicht;
- ein Ticket nach `agent:ready` geteilt oder zusammengefuehrt werden musste.

## Human Gate

- Der Mensch prueft und genehmigt den Plan, nicht jedes Ticket einzeln.
- Erst nach dokumentierter Plan-Freigabe im Plan Issue duerfen die
  Wave-1-Tickets als Issues angelegt und `agent:ready` gesetzt werden.
- Tickets mit Risk lane `protected` oder `release` behalten zusaetzlich ihr
  bestehendes Einzel-Human-Gate nach `docs/operating-model.md`. Die
  Plan-Freigabe ersetzt kein bestehendes Gate.
- Ein abgelehnter oder geaenderter Plan wird im Plan Issue dokumentiert.
  Der Planner passt an; er diskutiert nicht am Gate vorbei.

## Traceability

Jedes vom Planner geschnittene Ticket traegt im Ticket-Body:

```markdown
Planned-by: Repository Planner (Plan Issue #N)
Wave: n
```

Das ist Rueckverfolgbarkeit, kein neues Label und keine neue Statuswelt.

## Learning-Regel

Der Planner verbessert sich ueber denselben Mechanismus wie alle Rollen:
Lessons mit Regelanpassungs-Entscheidung (`templates/lesson.md`).

Nach Abschluss einer Wave oder eines Milestones liest ein Planning Retro
folgende Signale aus GitHub:

- `needs-fix`-Zyklen je Ticket, je Tier und Typ;
- Anteil `unclear_spec` und `missing_context` an der Harness Failure
  Classification;
- Ticket-Neuschnitt nach `agent:ready` (Split oder Merge im Flug);
- Review-Zyklen bis PASS;
- tatsaechliche vs. geplante Parallelitaet je Wave;
- Wave-Stabilitaet: wie viele Tickets unveraendert bis Merge ueberleben;
- Vault-Impact-Kalibrierung: Planner-Vorhersage vs. bestaetigter Impact.

Verboten als Planner-Signale (gleiche Regel wie im Teilprojekt Contract):
Prozentzahlen, Scores, Velocity, Burndowns, Forecasts, reine
Ticket-Zaehlstaende als Erfolgsmass.

Jede Regelanpassung an diesem Contract, am Ticket Contract oder an den
Planner-Templates bleibt human-gated. Es gibt keine automatische
Self-Improvement-Maschinerie.

## Stop-Bedingungen

Der Planner stoppt mit konkreter Rueckfrage statt zu raten, wenn:

- das Goal Issue kein pruefbares Ziel enthaelt;
- eine Produkt-, Architektur- oder Risikoentscheidung fehlt, die nur der
  Mensch treffen kann;
- der Repo-Zustand dem Ziel widerspricht (dann: Widerspruch benennen);
- offene PRs oder Issues dasselbe Ziel bereits bearbeiten (dann: Kollision
  benennen statt doppelt planen).

## Nicht-Ziele dieses Contracts

- kein automatisches `agent:ready` durch den Planner;
- keine automatische Mehrwellen-Ausfuehrung ohne Checkpoint;
- kein zweites Planungs-Wahrheitssystem neben GitHub;
- keine neuen Labels;
- kein Runner, kein Cron, kein Dashboard als Voraussetzung.
