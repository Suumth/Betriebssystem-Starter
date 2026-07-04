# AI-Betriebssystem 2.0

**App-first. GitHub-zentriert. Kein Runner im MVP. Ein echtes Repo, wenige Labels, klare Prompts, beweisbare PRs.**

Dieses Repository ist das Methoden-Repo für das AI-Betriebssystem 2.0. Es enthält die Betriebsweise, Prompts, Verträge, Vorlagen und Skill-Notizen, mit denen bestehende Projekt-Repos agentenfähig gemacht werden.

Das AI-Betriebssystem 2.0 ist keine neue Plattform und kein Dashboard. Es ist eine einfache Betriebsweise, die vorhandene Werkzeuge nutzt: GitHub hält die operative Wahrheit, KI-Tools wie ChatGPT, Codex und Claude lesen denselben repo-basierten Einstieg, und Reviews verdichten das Ergebnis zu einer menschlich entscheidbaren Ampel.

## Kernsatz

> GitHub hält den Kontext, die Apps führen aus, Tickets beweisen ihre eigene Reife, PRs beweisen ihre Lieferung, und der Mensch entscheidet nur noch über Ampeln.

Zusatzregel:

> Jeder Agentenlauf muss entweder ein Produktartefakt verbessern, ein Systemartefakt verbessern oder ein belastbares PM-Signal erzeugen. Sonst war es nur Aktivität.

Für den Tagesbetrieb reicht eine Seite: `docs/operator-runbook.md`. Kanonische Begriffe stehen in `docs/glossary.md`.

Neue fokussierte Einstiege:

- Low Risk Tickets: `templates/github_issue_task_low_risk.md`
- Lessons mit Regelanpassungs-Entscheidung: `templates/lesson.md`
- Claude-Code-Eskalation nach menschlicher Freigabe: `prompts/builder-claude-code.md`

## Drei Ebenen

| Ebene | Rolle | Operative Wahrheit? |
|---|---|---|
| Projekt-Repos | Arbeit: Code, Issues, PRs, Evidence, AGENTS.md | Ja |
| AI-Betriebssystem 2.0 | Methode: Prompts, Contracts, Vorlagen, Skills, PM-Signal-Loop | Ja, für Methode |
| AI Vault | Kontext: Strategie, Denken, Referenzen | Nein |

**Harte Regel:** Agenten lesen im Betrieb nur GitHub und Repo-Dateien. Der AI Vault ist kein operativer Kontext für Codex oder Claude Code.

## KI-einheitlicher Einstieg

Jedes Projekt bekommt eine repo-basierte Projektanweisung, bevorzugt `PROJECT.md`. Diese Datei ist der kanonische Einstieg für ChatGPT, Claude, Gemini, Codex und spätere KI-Tools.

Cloud-KIs haben keinen lokalen Dateizugriff. Deshalb gilt online-first: Tool-spezifische Projektanweisungen dürfen keine lokalen Pfade referenzieren und müssen auf die GitHub-URL der kanonischen Projektanweisung zeigen.

Tool-spezifische Projektanweisungen sind nur Bootstrap-Pointer:

```text
Lies zuerst die repo-basierte Projektanweisung:
<GitHub URL to PROJECT.md or docs/project-instructions.md>

Arbeite danach ausschließlich nach dieser Anweisung und den dort verlinkten Quellen.
Dupliziere keine Projektwahrheit in diese Tool-Anweisung.
```

Kein KI-Tool bekommt eigene Sonderwahrheit. Lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` sind ausschließlich Fallbacks für lokale Agenten wie Codex.

Die repo-basierte Projektanweisung enthält den Router auf AI-Betriebssystem als Methodenquelle, Projekt-Repo als operative Wahrheit und AI Vault als Strategie-/Produktgedächtnisquelle.

Der AI Vault bleibt die kanonische Wahrheit für Strategie, Zielbild und Produktgedächtnis. Inhalte, die Cloud-KIs benötigen, müssen aber online erreichbar sein: als GitHub-Dateien, über GitHub referenziert oder in geeigneter Form ins Projekt-Repo gespiegelt.

## MVP-Minimalmodell

Der MVP ist absichtlich klein. Er muss zuerst in einem Pilot-Repo nachweisen, dass ein Ticket ohne weitere Rückfragen zu einem prüfbaren PR und einer klaren Merge-Ampel führt.

### Pflicht im MVP

- ein Pilot-Repo
- fünf operative Labels
- `AGENTS.md` im Pilot-Repo
- über GitHub erreichbares `PROJECT.md` oder eine explizit benannte repo-basierte Projektanweisung im Pilot-Repo
- ein Task-/Issue-Template mit Ticket Contract
- minimale Tool-Projektanweisungen als Bootstrap-Pointer auf die repo-basierte Projektanweisung
- ein versionierter Project Brief im Projekt-Repo
- ein Codex-Builder-Prompt
- Codex als Builder-Orchestrator, wenn Tickets `Subagents: REQUIRED` setzen
- ein Claude-Code-Reviewer-Prompt
- ein kleines reifes Smoke-Test-Ticket
- PR Body als Primary Closeout Source
- Review of Record mit Ampelentscheidung
- Human Merge Gate
- Green Path Completion nach grünem Merge

### Optional im MVP

- Repo Context Pack über Repomix
- `docs/pm/status.md`
- Risk Log
- Decision Log
- Skill-Notizen
- PM Signal als manuell angestoßener Review-Lauf

### Nicht im MVP

- kein schwerer eigener Runner
- kein Morning-Script
- keine GitHub Action als Startvoraussetzung
- kein cron
- kein Dashboard als Voraussetzung
- kein Multi-Repo-Scanner
- keine Repo-Registry
- kein Subagenten-Organigramm und keine sichtbaren Subagent-PM-Rollen
- keine automatische Self-Improvement-Maschinerie
- kein zweites PM-System neben GitHub

Interne Codex-Subagents sind nur als expliziter Execution Mode erlaubt, wenn ein Ticket sie verlangt. GitHub bleibt auch dann der Review of Record und die operative Wahrheit.

## Loop-Disziplin

Jeder relevante Lauf folgt derselben Struktur:

```text
Trigger -> Action -> Proof -> Memory -> Stop
```

| Phase | Leitfrage | Artefakt |
|---|---|---|
| Trigger | Warum läuft der Agent jetzt? | Issue, PR Review, PM-Review-Issue, Label, Operator-Auftrag |
| Action | Was wurde konkret verändert oder geprüft? | Branch, Commit, PR, Review-Kommentar, Status-Update |
| Proof | Woran ist Erfolg erkennbar? | Tests, Build, Smoke, Evidence, Screenshot, Review Result |
| Memory | Was bleibt dauerhaft nutzbar? | PR Body, Closeout, Decision Log, Risk Log, Lessons, Template-Anpassung |
| Stop | Warum ist der Lauf fertig oder blockiert? | merged, needs-fix, blocked, needs-human, follow-up issue |

Für wiederholte, koordinierende oder multi-surface Läufe gilt vor dem Start
die optionale Preflight-Rubrik in `docs/loop-readiness.md`. Sie ergänzt die
GitHub-zentrierte Arbeitsweise, führt aber keinen Runner, kein Dashboard und
keine zweite operative Wahrheit ein.

## Standard-Loop: Delivery Loop

```text
Abends:
ChatGPT / Opus grillen unklare Arbeit, schneiden reife Tickets und setzen agent:ready.

Morgens:
Codex arbeitet in einem Repo: agent:ready -> agent:running -> PR.
Codex baut, validiert, erstellt/aktualisiert PR und hängt Evidence in den PR Body.

Danach:
Review of Record prüft offene PRs gegen ihre Issues.
Der Review setzt oder empfiehlt `review:pass`, Gelb (`needs-human`) oder Rot (`needs-fix` / `blocked`). `auto-merge:ok` bleibt eine separate Operator-/Human-Gate-Aktion nach PASS.

Mensch:
liest Ampel, entscheidet, merged oder priorisiert Fix.

Nach grünem Merge:
Codex führt ohne Rückfrage lokale Hygiene aus: `git checkout main`, `git pull --ff-only origin main`, `git status`.
Wenn `main` sauber ist, sucht Codex den nächsten Queue-Eintrag: needs-fix, agent:running oder genau ein neues agent:ready.

Memory:
Commit, PR Body, Closeout, Lessons nur bei Bedarf, Contract-/Template-Anpassung.
```

## PM Signal Loop

Der PM Signal Loop ist ein nachgelagerter Steuerungs-Loop für den Leiterblick. Er ersetzt kein Dashboard und keine zweite Wahrheit. Im MVP darf er manuell laufen und nur verdichten.

```text
GitHub Issues / PRs / Labels / Commits / Decisions lesen
-> Stand je Teilprojekt verdichten
-> Fortschritt, Blocker, Risiken und nächste Entscheidungen erkennen
-> optional docs/pm/status.md oder PM-Review-Issue aktualisieren
-> ggf. neue Issues, Risk Log-Updates oder Contract-Anpassungen vorschlagen
```

Regel:

> PM Signal darf verdichten, aber nicht heimlich Projektwahrheit verschieben. Neue Arbeit wird als Issue sichtbar. Harte Entscheidungen werden als Decision Log oder ADR sichtbar. Risiken werden im Risk Log oder als Issue sichtbar.

## Startreihenfolge

1. Dieses Methoden-Repo stabil halten.
2. Ein Pilot-Repo auswählen.
3. Dort fünf Labels, `AGENTS.md`, repo-basierte Projektanweisung, Task Template, Project Brief und optional `docs/pm/` ergänzen.
4. ChatGPT-, Claude-, Codex- oder andere Tool-Projektanweisungen nur als dünne Bootstrap-Pointer auf die repo-basierte Projektanweisung einrichten.
5. Ein kleines reifes Smoke-Test-Ticket erstellen.
6. Codex/Claude-Loop einmal echt beweisen.
7. Green Path Completion beweisen: Merge, lokales `main` synchronisieren, Status sauber, nächstes Ticket oder dokumentierter Stop.
8. Danach PM Signal Lauf für den Leiterblick ausführen.
9. Danach weitere Repos nacheinander migrieren.

## Struktur

```text
docs/        Operating Model, Harness Model, Operator Runbook, Glossar, Policies
contracts/   Ticket-, Review- und Label-Verträge
prompts/     Pflicht-Prompts für Codex, Claude Code und PM Signal
templates/   AGENTS.md, GitHub-Issue-Templates, Low-Risk-Task-Templates, Lesson- und PM-Status-Templates
skills/      kurze Rollen- und Skill-Routingnotizen
pm/          PM Signal Loop, Projektstatus, Risk Log, Decision Log
lessons/     dokumentierte Loop-Erkenntnisse mit Regelanpassungs-Entscheidung
migration/   Checkliste für bestehende Repos
legacy/      verworfene Architekturentscheidungen aus 1.0
```

## Status

MVP-Methoden-Repo. Der nächste operative Schritt ist die Auswahl eines Pilot-Repos und ein kleines Smoke-Test-Ticket, das den Loop beweist.
