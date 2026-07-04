# Glossar

Kanonische Begriffsdefinitionen des AI-Betriebssystems 2.0.

Andere Dokumente dürfen Begriffe für Prompt-Tauglichkeit wiederholen, aber nicht abweichend definieren. Bei Widerspruch gilt dieses Glossar. Ein `cross-system-audit` prüft Contracts, Prompts, Templates und Docs gegen diese Definitionen.

## Arbeit und Struktur

| Begriff | Definition |
|---|---|
| Ticket | Ein GitHub Issue, das seinen Erfolg selbst prüfbar macht: Ziel, Boundary, Verification, Evidence, Closeout, Stop-Bedingung. |
| Agent Contract | Der Pflichtblock eines `agent:ready`-Tickets: Mode, Autonomy, Risk lane, Goal, Context, Boundary, Verification, Closeout, Stop condition. |
| Boundary | Die explizite Grenze eines Laufs: erlaubte Änderungen, Do-not-touch, Freigabepflicht für externe Aktionen. Außerhalb der Boundary wird nicht improvisiert, sondern gestoppt. |
| Verification | Der konkrete Befehl, Ablauf oder Proof, der Erfolg maschinell oder manuell prüfbar macht. |
| Evidence | Überprüfbarer Nachweis der Verification: Rohoutput, Testergebnis, Screenshot, dokumentierte Blockade. Evidence darf nie größer interpretiert werden, als sie ist (Non-Proof Boundary). |
| Closeout | Der Abschlussbericht eines Laufs. Für PR-basierte Arbeit ist der PR Body die Primary Closeout Source; PR-Kommentare sind Ergänzung oder Fallback und müssen im PR Body referenziert werden. |
| Operator Summary | Kompakter Entscheidungsblock im Closeout: was sich änderte, Validation, Evidence, Risk lane, Auto-merge-Kandidat, Human decision required. |
| Review Recommendation | Empfehlungsblock im Closeout oder Review: empfohlener nächster Reviewer und Begründung. Eine Empfehlung, kein automatischer Verbrauch. |
| Lesson | Dokumentierte Erkenntnis aus einem realen Loop nach `templates/lesson.md`. Eine Lesson ist erst vollständig, wenn eine Regelanpassungs-Entscheidung getroffen wurde (auch "keine nötig" ist eine Entscheidung). |

## Modi und Lanes

| Begriff | Definition |
|---|---|
| Agent Mode | Arbeitsmodus vor dem Start: `EXECUTING` (bauen erlaubt), `GRILLING` (erst klären, nicht bauen), `COORDINATING` (Synthese/Teilprüfung koordinieren, Umsetzung erst in klarer EXECUTING-Box). |
| Autonomy | Erlaubte Eigenständigkeit innerhalb des Mode: `prototype`, `standard`, `production`. |
| Risk lane | Review- und Evidence-Schärfe: `low`, `standard`, `protected`, `release`. |
| Execution Mode | Ob ein Ticket interne Codex-Subagents verlangt: `Subagents: NOT_REQUIRED` oder `Subagents: REQUIRED`. Eine reine Erlaubnis erfüllt REQUIRED nicht. |
| Ticket-Tier | Umfangsklasse eines Tickets: Light (Risk lane low, keine Subagents, keine Loop-Arbeit, eine Oberfläche) oder Full (alles andere). Siehe `contracts/ticket-contract.md`. |

## Subagents und Budgets

| Begriff | Definition |
|---|---|
| Subagent | Interner Ausführungshelfer des Builders. Keine PM-Rolle, kein Label-Setzer, keine zweite Wahrheit. |
| Subagent Failure Policy | Bei hängendem oder unbrauchbarem required Subagent: genau eine gezielte Recovery, dann degraded mode mit Evidence oder `BLOCKED`. |
| Degraded mode | Fortsetzung ohne ein required Subagent-Ergebnis. Nur sicher, wenn der Subagent read-only war, der Builder die Analyse rekonstruieren kann, kein kritischer nicht-rekonstruierbarer Risiko-Check fehlt und Ersatzanalyse als Evidence dokumentiert ist. |
| Subagent Result Marker | `subagent_timeout`, `subagent_no_result`, `subagent_blocked`. Marker für Subagent-Ausfälle; kein Ersatz für die Harness Failure Classification. |
| Attempt Budget | Obergrenze für wiederholte Fix-/Review-/Loop-Arbeit. Default: Builder self-fix vor PR max 1; automatisierte `needs-fix`-Zyklen am selben PR max 2, außer der Operator verlängert explizit. Normale Umsetzung, erste Validation, Closeout-Edits und Green-Path-Hygiene zählen nicht. |
| Escalation | Evidence plus Empfehlung nach erschöpftem Budget. Nie automatischer Claude-Code-Fallback. |

## Review und Merge

| Begriff | Definition |
|---|---|
| Review of Record | Die maßgebliche Prüfung eines PR gegen sein verlinktes Issue, dokumentiert in GitHub: Review-Kommentar/-Submission plus Labels. UI-Isolation (separater Chat/Thread) ändert daran nichts. |
| Ampel | Das eine Review-Ergebnis: Grün (`review:pass` + Merge-Empfehlung), Gelb (`review:pass` + `needs-human`), Rot (`needs-fix` oder `blocked`). |
| Human Gate | Entscheidung, die beim Menschen bleibt: Merge, Produkt-/Architektur-/Risikoentscheidung, Veröffentlichung, Änderung an Betriebsregeln, Claude-Code-Freigabe. |
| Auto-Merge | Mechanischer Merge eines Grün-Falls. Nur erlaubt mit `review:pass`, separater Human-Gate-Freigabe, `auto-merge:ok`, ohne gelbe/rote Labels und mit `Human decision required: no`. |
| Green Path | Der störungsfreie Weg eines Tickets: Build → Evidence → Review PASS → Human Gate → Merge. |
| Green Path Completion | Pflichtabschluss nach grünem Merge: `git checkout main`, `git pull --ff-only origin main`, `git status`, dann nächster Queue-Eintrag oder dokumentierter Stop. |
| Batch Green Path Execution | Mehrere reife Tickets in einem Lauf, nur bei ausdrücklichem Nutzerauftrag. Nach jedem grünen PR erst vollständige Green Path Completion. |
| Resume State | Kommentar bei Abbruch durch Limit/Rechte: erledigt, offen, nächster Schritt, Blockade. `agent:running` bleibt gesetzt. |

## Diagnose und Steuerung

| Begriff | Definition |
|---|---|
| Harness Failure Classification | Warum ein Lauf scheiterte, als Harness-Signal: `none`, `missing_context`, `stale_context`, `missing_tool`, `missing_verifier`, `weak_guardrail`, `unclear_spec`, `model_limitation`. |
| PM Signal | Verdichteter Projektstand aus GitHub-Artefakten für den Leiterblick. Darf verdichten, aber keine Projektwahrheit verschieben. |
| Loop Readiness | Optionale Preflight-Rubrik für wiederholte oder koordinierende Läufe: Purpose, Trigger, Action, Maker/Checker, Proof, Memory, Stop, Cost/Attempts. Maximal `L2 Assisted` im MVP. |
| Root Agent Index | `AGENTS.md` als dünne Startdatei im Projekt-Repo, die per Loading Map auf Details verweist. |
| Loading Map | `read when ...`-Hinweise, die Detaildokumente nur bei Bedarf laden. |
| AI Vault | Strategie- und Produktgedächtnis für Menschen. Kein operativer Kontext für Agentenläufe. |

## Rollen

| Begriff | Definition |
|---|---|
| Planner | ChatGPT / Opus: Epics schneiden, reife Tickets formulieren, `agent:ready` setzen. |
| Builder / Builder-Orchestrator | Codex: Ticket bauen, validieren, Evidence liefern; bei `Subagents: REQUIRED` interne Subagents koordinieren. |
| Reviewer | Codex Review / `@codex review`: Standard-Review of Record. |
| Escalation Reviewer / Escalation Builder | Claude Code: Premium-Ressource für Review oder Umsetzung, nur nach dokumentierter menschlicher Freigabe (`prompts/builder-claude-code.md`). |
| Operator | Der Mensch: Tagesfokus, Ampel-Entscheidungen, Merge, Human Gates. Siehe `docs/operator-runbook.md`. |
