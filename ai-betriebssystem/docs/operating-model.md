# Operating Model

## Ziel

AI-Betriebssystem 2.0 reduziert Copy-Paste zwischen ChatGPT, Codex, Claude Code und Projekt-Repos. Der operative Kontext liegt in GitHub: Issues, PRs, Kommentare, Labels, AGENTS.md und Repo-Dateien.

Es ist zugleich Agent Substrate: Root Agent Index, gemeinsame Begriffe, Agent Modes, Skill-Muster und Loading Map für repo-lokale Detaildokumente.

## Nicht-Ziele im MVP

- kein eigener Runner
- kein lokaler Orchestrator
- kein Dashboard
- kein Multi-Repo-Scanner
- kein blindes Auto-Merge ohne Review of Record, Evidence und `auto-merge:ok`
- keine sichtbaren Subagent-PM-Rollen und kein Subagenten-Organigramm
- keine zweite operative Wahrheit im AI Vault
- keine automatische Self-Improvement-Maschinerie

## Rollen

| Rolle | Tool | Aufgabe |
|---|---|---|
| Builder-Orchestrator | Codex-App | Ticket lesen, Branch/PR bearbeiten, bei `Subagents: REQUIRED` interne Subagents koordinieren, validieren, Evidence liefern |
| Reviewer | Codex Review / @codex review | Standard-Review of Record: PR gegen Issue prüfen, Evidence bewerten, Ampel setzen |
| Escalation Reviewer | Claude Code | Optionale Premium-/Eskalationsressource bei Risiko, Protected Areas, Release, Safety, Privacy, komplexer Architektur oder Operator-Entscheidung |
| Operator | Mensch | Tagesfokus setzen, Merge entscheiden, unklare Produkt-/Architekturfragen klären |
| Planner | ChatGPT / Opus | Epics schneiden, reife Tickets formulieren, agent:ready setzen |

Codex bleibt der sichtbare Builder-Lauf. Interne Subagents sind ein expliziter Execution Mode, keine sichtbaren PM-Rollen und keine zweite operative Wahrheit.

## Agent Modes

| Mode | Wann verwenden | Folge |
|---|---|---|
| `EXECUTING` | Entscheidung, Scope, Verifier und Evidence sind klar | Agent darf bauen |
| `GRILLING` | Entscheidung, Begriff oder Scope ist unklar | Agent klärt zuerst; keine Umsetzung |
| `COORDINATING` | größere Arbeit braucht Synthese, Subagent-/Teilprüfung oder mehrere Quellen | Agent koordiniert und schneidet umsetzbare Teilboxen; Subagent-Findings müssen im PR-Closeout verdichtet werden |

Codex may be instructed to use internal Subagents as an explicit Execution Mode, for example when an issue says `Subagents: REQUIRED`.

If a required subagent stalls or returns no usable result, Codex must apply the Subagent Failure Policy: attempt one targeted recovery, then either continue in degraded mode with replacement Evidence or stop with `BLOCKED`.

Degraded mode is safe only when the missing subagent was read-only, the Builder can reconstruct the analysis, no critical non-reconstructable risk check is missing and the PR body documents the marker (`subagent_timeout`, `subagent_no_result` or `subagent_blocked`), recovery, replacement Evidence and remaining risk.

## Quellenhierarchie

1. GitHub Issue / PR im Projekt-Repo
2. `AGENTS.md` im Projekt-Repo als Root Agent Index
3. Repo-Dateien
4. Methoden-Repo AI-Betriebssystem 2.0
5. AI Vault nur als strategische Referenz für Menschen, nicht für operative Agentenläufe

`AGENTS.md` soll dünn bleiben. Längere Details werden als Loading Map per `read when ...` auf Repo-Dateien wie `docs/agents/glossary.md`, `docs/agents/verification.md`, `docs/agents/protected-areas.md` oder `docs/adr/*.md` verwiesen. Diese Dateien sind optional und werden nur angelegt, wenn ein Repo sie wirklich braucht.

## Projektanweisungs-Hierarchie

Die kanonische Projektanweisung liegt versioniert im Projekt-Repo, bevorzugt als `PROJECT.md`. Alternativ ist `docs/project-instructions.md` erlaubt, wenn der Pfad im Startpaket und in Tool-Anweisungen eindeutig genannt ist.

Cloud-KIs wie ChatGPT, Claude oder Gemini haben keinen lokalen Dateizugriff. Ihre Tool-Projektanweisungen dürfen deshalb keine lokalen Pfade referenzieren und müssen auf die GitHub-URL der repo-basierten Projektanweisung zeigen.

Lokale Pfade wie `<LOCAL_CHECKOUT_PATH>` sind ausschließlich Fallbacks für lokale Agenten wie Codex.

ChatGPT-, Claude-, Codex-, Gemini- und andere KI-Projektanweisungen sind nur Bootstrap-Pointer auf diese repo-basierte Projektanweisung. Kein KI-Tool bekommt eigene Sonderwahrheit.

Die repo-basierte Projektanweisung enthält den Drei-Quellen-Router:

1. AI-Betriebssystem = Methode, Ticket-Schnitt, Green Path, Review und Evidence.
2. Projekt-Repo = operative Wahrheit, Issues, PRs, `AGENTS.md`, Code, Labels, Status und Evidence.
3. AI Vault = Strategie, Zielbild, Produktgedächtnis, Entscheidungen und Nicht-Ziele.

Projektwahrheit wird nicht in Tool-Projektanweisungen dupliziert. Strategische Wahrheit wird nicht in zufällige Issue-Kommentare verschoben.

Der AI Vault bleibt die kanonische Quelle für Strategie und Produktgedächtnis. Inhalte, die Cloud-KIs benötigen, müssen als GitHub-Dateien, über GitHub referenziert oder in geeigneter Form ins Projekt-Repo gespiegelt werden. Die Spiegelung ist ein Online-Einstieg, keine neue strategische Wahrheit.

## Standard-Loop

```text
Plan -> Ticket -> Build -> Evidence -> Review -> Fix oder Human Gate -> Merge -> Local Sync -> Next Ticket oder Stop
```

## Abends: Planung

ChatGPT / Opus formulieren Tickets so, dass sie morgens ohne Rückfrage bearbeitet werden können. Ein Ticket wird nur `agent:ready`, wenn es maschinell prüfbar ist.

## Morgens: Build

Codex bekommt eine kontextfreie Anweisung pro Repo. Die Reihenfolge ist strikt:

1. offene PRs/Issues mit `needs-fix`
2. Tickets mit `agent:running` als Resume-Kandidaten
3. genau ein neues Ticket mit `agent:ready`

Codex liest das Ticket, arbeitet auf bestehendem oder neuem Branch, erstellt/aktualisiert einen PR, validiert und hängt Evidence an. Wenn das Ticket `Subagents: REQUIRED` sagt, agiert Codex als Builder-Orchestrator: interne Subagents starten, auf Ergebnisse warten, Findings verdichten und die Umsetzung im Haupt-Builder-Lauf verantworten.

`Subagents: REQUIRED` bedeutet nicht endlos warten. Wenn ein required Subagent hängt oder kein brauchbares Ergebnis liefert, versucht Codex einmal Recovery. Danach geht es nur degraded mit Evidence weiter, wenn die Safety-Kriterien erfüllt sind; sonst stoppt Codex mit `BLOCKED`.

## Danach: Review

Der Review of Record prüft offene PRs gegen ihre verlinkten Issues. Das Ergebnis ist genau eine Ampel:

- Grün = `review:pass` + `auto-merge:ok`, wenn alle Grün-Kriterien gelten
- Gelb = `needs-human`, Auto-Merge verboten, Operator-Entscheidung nötig
- Rot = `needs-fix` oder `blocked`, kein Merge

## Review Isolation

Ein Review darf in einem separaten Chat, Thread oder App-Review-Kontext laufen, wenn das Tool es unterstützt. Das ist UI-/Execution-Isolation, kein neuer Wahrheitsort.

GitHub remains the Review of Record: linked Issue, PR diff, PR body / Closeout, validation and Evidence, review comment or review submission and labels.

Der Review of Record prüft vor PASS auch `Vault Impact` nach
`contracts/ticket-contract.md#vault-impact-contract`. Vault Update Candidates
bleiben Human Gate; Agenten verändern den AI Vault nicht direkt, außer das
Issue erlaubt es ausdrücklich.

Bei Tickets mit `Subagents: REQUIRED` prüft der Review of Record zusätzlich, ob die Subagents im PR-Closeout genannt sind, was sie gefunden haben, welche Findings die Umsetzung beeinflusst haben und ob relevante Findings umgesetzt, out of scope oder blockiert begründet wurden.

Wenn die Subagent Failure Policy greift, prüft der Review of Record zusätzlich, ob `subagent_timeout`, `subagent_no_result`, `subagent_blocked` oder degraded mode mit Recovery, Ersatzanalyse, Safety-Begründung und Restrisiko im PR Body oder klar verlinkter PR-Evidence dokumentiert sind.

## Nach grünem Merge

Ein Green Path endet nicht beim Merge. Nach erfolgreichem grünem Merge führt Codex ohne Rückfrage `git checkout main`, `git pull --ff-only origin main` und `git status` aus. Ist `main` sauber, nimmt Codex den nächsten Queue-Eintrag nach Standardreihenfolge auf: zuerst `needs-fix`, dann `agent:running`, dann genau ein neues `agent:ready`.

Stop statt Fortsetzung gilt bei fehlgeschlagenem Merge, fehlgeschlagenem Checkout/Pull, dirty Working Tree, fehlenden Berechtigungen, `needs-human`, `needs-fix`, `blocked`, Protected-/Release-/Waiver-Entscheidung, unklarem Scope oder fehlender Evidence.

Details stehen in `docs/green-path-completion.md`.

## Batch Green Path Execution

Batch Green Path Execution gilt nur bei ausdrücklichem Nutzerauftrag für mehrere reife Tickets. Die Batch-Größe ergibt sich aus diesem Auftrag, nicht aus einer festen Zahl.

Nach jedem grünen PR prüft Codex den PR Review of Record, merged gemäß Green-Path-Regel, checkt `main` aus, zieht `origin/main` fast-forward, prüft den clean status und übernimmt erst dann das nächste beauftragte ready Ticket.

Codex stoppt den Batch bei unklarem Scope, fehlender Evidence, failed Checks, `needs-human`, `needs-fix`, `blocked`, Protected Area, Merge-/Pull-/Permission-Fehlern oder wenn kein weiteres beauftragtes Ticket übrig ist.

## Human Gates

Beim Menschen bleiben:

- Merge-Freigabe
- finale Produktentscheidung
- unklare Architekturentscheidungen
- hohes Risiko
- Veröffentlichungen wie App Store, TestFlight, Kunde, Website-Deploy
- Änderungen an Betriebsregeln und Skills

## Fortschritt ohne Runner

`agent:running` ist ein Resume-Hinweis, kein perfekter Lock. Wenn ein App-Lauf hart abbricht, kann das Label hängen bleiben. Deshalb gilt:

- Branch/PR sind die Fortschrittswahrheit.
- `agent:running` ist ein Suchanker für Fortsetzung.
- Der nächste Codex-Lauf prüft zuerst, ob ein Branch oder PR existiert.

## Maßstab

Das System ist erfolgreich, wenn der Mensch morgens keine Inhalte zwischen Tools kopieren muss und trotzdem entscheidungsfähige PRs mit Evidence sieht.
