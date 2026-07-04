# Agent Work Harness

## Leitidee

Das AI-Betriebssystem 2.0 ist kein Runner und kein Dashboard. Es ist ein GitHub-zentrierter Agent Work Harness und ein Agent Substrate.

Der Produktwert liegt nicht darin, dass Codex oder Claude Code irgendwie Code schreiben. Der Wert liegt darin, dass jeder Agentenlauf eine klare Arbeitsbox bekommt:

- Kontext
- Grenze
- Werkzeug
- Prüfpfad
- Evidence
- Closeout
- Human Gate

Kurz:

> Nicht Magie automatisieren. Arbeit agentenfaehig machen.

## Agent Substrate

Agent Substrate ist der gemeinsame Unterbau, der Agenten in unterschiedlichen Repos dieselbe Sprache und dieselben Einstiegspunkte gibt.

| Baustein | Bedeutung |
| --- | --- |
| Root Agent Index | `AGENTS.md` als dünne Startdatei, die auf weitere Dokumente verweist |
| Gemeinsame Begriffe | einheitliche Bedeutungen für Ticket, Boundary, Evidence, Review of Record, Human Gate und Auto-Merge-Ampel |
| Agent Modes | `EXECUTING`, `GRILLING` und `COORDINATING` als Arbeitsmodus vor dem Start |
| Skill-Muster | wiederkehrende Arbeitsweisen wie `plan-then-implement`, `grill-with-docs`, `simplify-pass`, `cross-system-audit` |
| Loading Map | `read when ...`-Hinweise, die nur relevante Detaildocs laden |

Das Substrate ist kein Agenten-Zoo und keine automatische Self-Improvement-Maschinerie. Es macht vorhandene Agenten lauffaehig, ohne neue Runner- oder Dashboard-Pflichten einzufuehren.

## Definition

Ein Agent Work Harness ist die operative Umgebung, die Agentenarbeit wiederholbar und pruefbar macht.

| Baustein | Bedeutung |
| --- | --- |
| Instructions | `AGENTS.md`, Ticket Contract, Rollenbeschreibung |
| Tools | Codex App, Claude Code App, GitHub, Tests, Simulator, Browser |
| Sandboxes | Branches, erlaubte Pfade, Draft-PRs, keine externen Aktionen ohne Freigabe |
| Guardrails | Boundaries, Do-not-touch, Stop-Regeln, Human Gates |
| Memory | GitHub Issues, PR-Kommentare, Lessons, durable Docs |
| Evals | Tests, Builds, Smokes, Screenshots, Evidence-Artefakte |
| Observability | Closeout, Review-Kommentar, Statuslabel, Run-Protokoll |
| PM Signal | Verdichteter Projektstand aus GitHub Issues, PRs, Labels, Commits und Decisions |

## Closeout as Harness

Closeout is part of the harness.

Der Harness ist nicht nur Ausfuehrung und Verification. Ohne verwertbaren Closeout kann der Operator keine Ampelentscheidung treffen.

Observability braucht eine stabile Closeout-Quelle. Für PR-basierte Arbeit ist der PR Body die primaere Operator-/Reviewer-Oberflaeche; PR-Kommentare können ergaenzen oder als technischer Fallback dienen, müssen dann aber im PR Body referenziert werden.

Closeout Requirements gehoeren deshalb in den Agent Contract oder den konkreten Codex-Prompt. `AGENTS.md`, Contracts und Skills können erinnern und strukturieren, ersetzen aber keine expliziten task lokalen Closeout-Pflichten.

## PM Signal

PM Signal ist ein verdichteter Projektstand aus GitHub Issues, PRs, Labels, Commits und Decisions. Es ist Teil der Control Plane: Es hilft dem Operator, Fortschritt, Blocker, Risiken und Entscheidungen zu sehen.

PM Signal ersetzt kein Dashboard und keine zweite Wahrheit. Es liest GitHub-Artefakte und bewusst freigegebene Repo-Dokumente wie `docs/pm/*.md`, `docs/adr/*.md`, Risk Logs oder Decision Logs. Der AI Vault bleibt Denk- und Entwurfsort; für operative PM-Steuerung zaehlen GitHub und Repo-Artefakte.

Leitregel:

> Jeder Agentenlauf muss entweder ein Produktartefakt verbessern, ein Systemartefakt verbessern oder ein belastbares PM-Signal erzeugen. Sonst war es nur Aktivitaet.

## Agent Contract

Jedes `agent:ready`-Ticket braucht einen expliziten Agent Contract.

```markdown
## Agent Contract

Mode: EXECUTING | GRILLING | COORDINATING
Autonomy: prototype | standard | production
Risk lane: low | standard | protected | release

Goal:
One clear sentence describing the intended outcome.

Context:
- Repo/path:
- Related issue/PR/doc:
- Source-of-truth files:
- Known risky areas:

Boundary:
- Allowed changes:
- Do not touch:
- Public/external actions require approval: yes/no

Verification:
- Required command/check:
- UI/browser/simulator proof:
- Evidence artifact expected:

Closeout:
- What changed:
- What was verified:
- Remaining risk:
- Follow-up needed:

Stop condition:
- Stop if context, boundary, tool, verifier, or product decision is missing.
```

## Agent Modes

Der Agent Mode entscheidet, ob gebaut werden darf.

| Mode | Bedeutung | Erlaubte Aktion |
| --- | --- | --- |
| `EXECUTING` | Entscheidung ist getroffen, Scope und Verifier sind klar | Agent darf bauen, validieren und PR/Evidence liefern |
| `GRILLING` | Entscheidung, Begriff, Scope oder Ziel ist unklar | Agent darf nicht bauen; erst klaeren, schneiden oder Entscheidungsvorlage schreiben |
| `COORDINATING` | groessere Arbeit braucht Synthese, Subagent-/Teilpruefungen oder mehrere Quellen | Agent koordiniert Analyse, Teilpruefungen und einen umsetzbaren Plan; Umsetzung nur nach klarer EXECUTING-Box |

`Autonomy` beschreibt die erlaubte Eigenstaendigkeit innerhalb des Modes. `Risk lane` beschreibt die Review- und Evidence-Schaerfe.

## Docs as Loading Map

`AGENTS.md` soll ein Root Agent Index sein, keine Wissensdatenbank. Es enthält kurze Regeln und verweist per `read when ...` auf Details.

Optionale repo-lokale Detaildocs:

- `docs/agents/glossary.md` — read when Begriffe, Labels oder Modes unklar sind
- `docs/agents/verification.md` — read when Validation, Evidence oder Artefakte zu bestimmen sind
- `docs/agents/protected-areas.md` — read when Protected Areas oder Risk lanes betroffen sind
- `docs/adr/*.md` — read when eine Architekturentscheidung beruehrt wird

Diese Dateien sind Empfehlungen für groessere Repos, kein Pflicht-Overhead für jedes Projekt.

## Skill-Muster

Skill-Muster beschreiben Arbeitsweisen, nicht neue Standardagenten:

- `plan-then-implement`: erst Ziel, Boundary und Verifier festziehen, dann bauen
- `grill-with-docs`: im `GRILLING`-Mode unklare Begriffe oder Entscheidungen gegen Repo-Dokumente prüfen
- `simplify-pass`: vor groesserer Umsetzung Scope reduzieren und unnötige Komplexitaet entfernen
- `cross-system-audit`: bei systemübergreifenden Aenderungen betroffene Contracts, Templates, Prompts und Docs gegeneinander prüfen

## Agent Loop

Der Standardloop besteht aus fuenf Rollenmomenten. Diese müssen nicht zwingend fuenf separate Agents sein; sie können innerhalb eines Codex- oder Claude-Laufs als Denk- und Arbeitsphasen gelten.

Für wiederholte oder koordinierende Läufe beschreibt `docs/loop-readiness.md`
eine optionale Preflight-Rubrik. Sie klaert Purpose, Trigger, Action, Proof,
Memory, Stop und Cost/Attempts, ohne Runner-, Dashboard-, State-File- oder
Label-Pflichten einzufuehren.

### 1. Critic

Vor jeder Aenderung:

- Task challengen.
- Fehlenden Kontext erkennen.
- Riskante Annahmen markieren.
- Unklare Done-Kriterien benennen.
- Stoppen, wenn Kontext, Boundary oder Verification fehlt.

### 2. Builder

- Kleinste sichere Aenderung machen.
- Innerhalb der Boundary bleiben.
- Keine opportunistischen Refactors.
- Keine Produktentscheidungen erfinden.

### 3. Verifier

- Geforderte Checks ausführen.
- Keine Erfolgsbehauptung ohne Evidence.
- Fehler klassifizieren statt schoenreden.

### 4. Recorder

- Closeout posten.
- Geaenderte Dateien nennen.
- Checks und Roh-Evidence dokumentieren.
- Risiken und offene Punkte benennen.

### 5. Fix Loop

Wenn Verification oder Review fehlschlaegt:

- Failure klassifizieren.
- Wenn eindeutig und im Scope: im selben PR fixen.
- Wenn unklar, ausserhalb Scope oder Entscheidung noetig: `blocked` / Human Gate.

## Harness Failure Classification

Schlechte Agentenlaeufe werden nicht zuerst als Modellfehler betrachtet. Sie werden als Harness-Signal klassifiziert.

Erlaubte Werte:

- `none`
- `missing_context`
- `stale_context`
- `missing_tool`
- `missing_verifier`
- `weak_guardrail`
- `unclear_spec`
- `model_limitation`

Beispiele:

| Symptom | Wahrscheinliche Klassifikation |
| --- | --- |
| Agent fragt nach Ziel | `unclear_spec` |
| Agent rät Produktverhalten | `missing_context` |
| Build kann nicht laufen | `missing_tool` |
| Ticket hat keine Validation | `missing_verifier` |
| Agent aendert zu viele Dateien | `weak_guardrail` |
| Kontext widerspricht sich | `stale_context` |
| Modell scheitert trotz gutem Harness | `model_limitation` |

### Loop Failure Mode Mapping

This mapping is diagnostic guidance under the existing Harness Failure
Classification. It does not create new labels, workflow states, runner logic or
mandatory process for simple tickets.

| Failure mode symptom | Likely existing classification | Standard reaction |
| --- | --- | --- |
| Infinite Fix Loop | `weak_guardrail`; also `missing_verifier` if the failing check is not decisive, or `unclear_spec` if the target keeps moving | Stop at the attempt budget. Record attempts used, last failed check or review point, suspected root cause and recommended next reviewer or human decision. Continue only with a concrete same-PR `needs-fix`; otherwise `blocked`. |
| State Rot | `stale_context`; also `missing_context` if the current source of truth is absent | Stop and refresh GitHub issue, PR and repo-file evidence. Resolve conflicting context before another fix. Use `blocked` if no authoritative source can be chosen. |
| Verifier Theater | `missing_verifier`; also `weak_guardrail` if vague evidence is accepted | No PASS. Require a concrete command, manual check, artifact or reviewable evidence. Use `needs-fix` for missing evidence; `blocked` if the verifier cannot exist in scope. |
| Token Burn | `weak_guardrail`; also `unclear_spec` or `missing_context` depending on why the agent is wandering | Stop repeated exploration. Narrow scope, restate acceptance criteria or produce PM signal / human decision. Do not run another broad retry without classification. |
| Scope Over-Reach | `weak_guardrail`; also `unclear_spec` if the boundary was not explicit | Treat extra changes as review blockers. Remove out-of-scope work or ask for a human boundary decision. Strengthen issue boundary before retry. |
| Parallel Collision | `weak_guardrail`; also `stale_context` if branches or PRs diverged | Stop duplicate work. Reuse the existing branch or PR, pick one GitHub source of truth and document collision evidence. Escalate to human decision if ownership cannot be resolved. |
| Comprehension Debt | `missing_context`; also `unclear_spec`; `model_limitation` only after context, spec and verifier are adequate | Add missing context or split the ticket. Ask a narrow human decision if the missing concept cannot be reconstructed from GitHub and repo files. Block instead of guessing. |
| Escalation Failure | `weak_guardrail`; also `missing_tool`, `missing_verifier` or `unclear_spec` depending on what made escalation unusable | Document attempts, failed review/check point, root cause and next reviewer. If the required tool, reviewer or evidence is unavailable, mark `blocked` instead of starting another Codex fix. |

## Produktdefinition

Besser als:

> GitHub-zentriertes AI-Betriebssystem, das Codex/Claude über Tickets arbeiten laesst.

Ist:

> Ein GitHub-zentrierter Agent Work Harness, der Codex und Claude Code mit klaren Aufgaben, Grenzen, Prüfpfaden und Closeouts in wiederholbare Engineering-Loops bringt.

## Konsequenz

Die Kernfrage lautet nicht:

> Wie starten wir Agents automatisch?

Sondern:

> Hat jeder Agentenlauf Context, Boundary, Verifier, Evidence und Closeout?

Automatisierung kommt später. Der Harness kommt zuerst.
