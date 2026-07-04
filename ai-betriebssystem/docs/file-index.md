# File Index

## Root

- `README.md` — Einstieg, Kernsatz, KI-einheitlicher Einstieg, Ebenen, MVP-Umfang, Builder-Orchestrator-Abgrenzung und Startreihenfolge.

## Operating Model

- `docs/operator-runbook.md` — Ein-Seiten-Tagesanleitung für den Solo-Operator: Abend-Planung, Morgen-Start, Ampel-Entscheidung, Befehls-Spickzettel und Wochenhygiene.
- `docs/glossary.md` — kanonische Begriffsdefinitionen; bei Widerspruch zwischen Dokumenten gilt das Glossar.
- `docs/operating-model.md` — Rollen, Quellenhierarchie, Agent Modes, Subagent Failure Policy, Review Isolation, Vault-Impact-Gate, Standard-Loop und Human Gates.
- `docs/harness-model.md` — Agent Work Harness, Agent Substrate, Agent Contract, Agent Modes, Loading Map, Skill-Muster, Harness-Failure-Klassifikation und diagnostische Loop-Failure-Mapping-Tabelle.
- `docs/loop-readiness.md` — optionale Preflight-Rubrik für koordinierende oder wiederholte Agent-Loops, inklusive Attempt Budget und optionaler `loop-audit`-Diagnosenotiz ohne neue Gates.
- `docs/model-resource-policy.md` — Codex als Hauptarbeitskraft, Attempt-Budget-Disziplin und Claude Code nur nach Vorschlag und menschlicher Freigabe.
- `docs/operator-merge-policy.md` — Operator-Rolle, Merge-Ampel, Review-Beauftragung, Vault-Impact-Human-Gate, Batch Green Path Execution und Local Direct-Main Mode mit Waiver-Regeln.
- `docs/green-path-completion.md` — Pflichtablauf nach grünem Merge: lokales `main` synchronisieren, Status prüfen, nächstes Ticket, Batch Green Path Execution oder Stop.
- `docs/overnight-operations-mode.md` — operator-armierter Overnight Operations Mode mit L2-Einordnung, Limits, Heartbeats, Resume-Regeln und Nacht-Merge-Verbot.
- `docs/overnight-pilot.md` — kontrollierte erste Pilotnacht für Overnight Operations Mode mit 2 `risk:low`-Slots, Operator-Checkliste, Metriken und Lessons Learned.
- `docs/bootstrap-loop.md` — PROJECT.md-first Bootstrap-Konvention für neue und bestehende Projekt-Repos.

## PM Signal

- `pm/lagebild.py` — stdlib-only read-only Generator für das PM-Portfolio-Lagebild aus GitHub und `PROJECT.md`.
- `pm/portfolio.md` — generierte PM-Portfolio-Ableitung; nicht manuell pflegen, sondern mit `pm/lagebild.py` neu erzeugen.
- `pm/test_lagebild.py` — Tests für PROJECT-Register-Parsing, Rendering ohne Prozentzeichen und read-only `gh`-Guard.
- `docs/pm/pm-signal-loop.md` — PM-Signal-Loop als GitHub-basierte Projektstandsverdichtung.
- `docs/pm/project-status-template.md` — Template für Project Signal, Status, Risiken, Entscheidungen und Missing Evidence.
- `docs/pm/project-map-template.md` — einfache 9-Teilprojekt-Sicht ohne zweite Roadmap.
- `docs/pm/risk_log-template.md` — Risk Log-Template mit Quelle, Mitigation und Links zu GitHub/ADR-Artefakten.

## Contracts

- `contracts/ticket-contract.md` — Reife-Regel, Ticket-Tiers (Light/Full), Agent Contract mit Mode/Autonomy/Risk lane, Execution Mode, Attempt Budget & Escalation, Subagent Failure Policy, Subagent Evidence Capsule, Evidence, Closeout, Vault Impact und Harness-Failure-Klassifikation.
- `contracts/review-contract.md` — Review-Prüfung, Review Isolation, Ampeln, Vault-Impact-, Attempt-Budget-, Failure-Mode-, Subagent-Evidence-Capsule- und degraded-mode-Checks sowie Kommentarformate.
- `contracts/run-budget-kill-switch.md` — Run Budget and Kill Switch Guardrail mit max issues per run, max fix attempts, stop conditions, operator kill actions und ohne neue Labels.
- `contracts/teilprojekt-contract.md` — PM-Lagebild-Konvention: Teilprojekte als GitHub Milestones, Produktversprechen in `PROJECT.md`, read-only Ampel-/Zustandsableitung ohne zweite Wahrheit.
- `contracts/labels.md` — operative Workflow-Labels, Review-of-Record-Signal und Auto-Merge-Signal.

## Prompts

- `prompts/builder-codex.md` — morgendlicher Builder-Prompt für Codex mit Agent Mode, Execution Mode Rules, Attempt Budget, Subagent Failure Policy, Batch Green Path Execution, Vault Impact und Closeout-Pflichtfeldern.
- `prompts/builder-claude-code.md` — Escalation-Builder-Prompt für Claude Code, nur nach dokumentierter menschlicher Freigabe gemäß Model Resource Policy.
- `prompts/builder-review-handoff.md` — Regel, dass Review-/Merge-Signale erst nach dem Builder-Handoff kommen.
- `prompts/reviewer-claude.md` — kompakter Reviewer-Prompt mit Review Isolation, Vault-Impact-, Attempt-Budget-, Failure-Mode-, Subagent-Evidence-/degraded-mode-Checks und Grün/Gelb/Rot-Semantik; Details stehen im Review Contract.

## Templates

- `templates/AGENTS.md` — Root-Agent-Index-Vorlage für Projekt-Repos mit Loading Map, Agent Modes, Execution Mode Rules, Subagent Failure Policy, Vault Impact und Critic/Builder/Verifier/Recorder-Loop.
- `templates/PROJECT.md` — direkt kopierbare Root-Vorlage für die kanonische Projektanweisung inklusive Teilprojekt-/Produktversprechen-Register.
- `templates/project-operating-rules.md` — ausführliche Projekt-Regelvorlage mit Agent Substrate, Execution Mode Rules, Subagent Failure Policy, Vault Impact und Skill-Mustern.
- `templates/github_issue_task.md` — GitHub-Issue-Task Template mit Agent Contract, Mode, Autonomy, Risk lane, Execution Mode, Attempt Budget & Escalation, Run Budget and Kill Switch, Subagent Failure Policy, Subagent Evidence Capsule, Vault Impact und Codex Subagent Instruction.
- `templates/github_issue_task_low_risk.md` — Light Ticket Template für risikoarme EXECUTING-Tickets ohne Subagents und ohne erwartete Loop-Arbeit.
- `templates/lesson.md` — Lesson-Template mit Pflichtblock Regelanpassung, damit Loop-Erkenntnisse in Contracts, Prompts und Templates zurückfliessen.
- `templates/harness-learning-candidate.md` — PR-gated Template für wiederholte Harness-Learnings; Candidate ist nicht aktive Policy bis Review of Record und Merge.
- `templates/codex-overnight-loop-prompt.md` — abends nutzbarer Codex-Prompt für einen operator-armierten Overnight Run.
- `templates/morning-operator-review.md` — Morgen-Checkliste mit Nightly-Summary-Einstieg, GitHub-Abfragen, Ampellogik und Delegationsregeln.
- `templates/ticket-0-bootstrap.md` — erstes Bootstrap-Issue zum Nachweis der Agentenfähigkeit eines neuen Projekt-Repos.
- `templates/pull-request-template.md` — PR-Body-Template mit Validation Evidence, Vault Impact, Operator Summary und Review Recommendation.
- `templates/labels.yml` — direkt nutzbares Label-Set für GitHub oder Label-Sync.
- `templates/pm-signal-prompt.md` — wiederverwendbarer Prompt für PM-Signal-Läufe.
- `templates/chatgpt-project-instructions.md` — minimale Tool-Projektanweisung als GitHub-URL-Bootstrap-Pointer auf die repo-basierte Projektanweisung.
- `templates/project-instructions.md` — kanonische repo-basierte Projektanweisung für `PROJECT.md` oder `docs/project-instructions.md` mit Drei-Quellen-Router und Online-first Source Policy.
- `templates/project-brief.md` — versionierbare Projektbeschreibung und Online-first Source Map für neue und bestehende Projekt-Repos.
- `templates/project-start-pack.md` — Startpaket-Checkliste für neue Projekt-Repos mit GitHub-erreichbarer repo-basierter Projektanweisung.
- `templates/ai-vault/` — Vault-Vorlagen für Vision, Zielbild, Produktbrief, Roadmap, Entscheidungen, Risiken und Lessons Learned.

## Skills

- `skills/xcode-27.md` — repo-facing Routingnotiz für lokale Xcode 27 Skill-Referenzen; nur Apple-platform-Arbeit, Cloud-KI über GitHub-Note, lokaler Pfad nur Codex/local-agent fallback.
- `skills/ticket-worker.md` — kurzer Skill für Builder-Arbeit mit Agent Modes, Execution Mode, Subagent Failure Policy und Skill-Mustern.
- `skills/reviewer.md` — kurzer Skill für Review-Arbeit mit Vault-Impact-Gate und Grün/Gelb/Rot-Semantik.

## Migration

- `migration/repo-migration-checklist.md` — Checkliste für bestehende Projekt-Repos.
- `migration/project-bootstrap-runbook.md` — praktisches Runbook samt Startprompt für neue PROJECT.md-first Projekt-Bootstraps.
- `migration/chatgpt-project-onboarding.md` — Migration bestehender Repos von langen Tool-Anweisungen zu repo-basierter Projektanweisung plus Project Brief.
- `migration/projects/generic-apple-project-bootstrap-pack.example.md` — generisches PROJECT.md-first Migrationspaket für Apple-Platform-Projekte.
- `migration/projects/generic-web-project-bootstrap-pack.example.md` — generisches PROJECT.md-first Migrationspaket für Web-/Docs-Projekte.
- `migration/projects/method-repo-bootstrap-pack.example.md` — PROJECT.md-first Selbstmigrationspaket für ein Methodenrepo.

## Lessons

- `lessons/bootstrap-loop.example.md` — neutrale Erkenntnisse aus einem ersten erfolgreichen Bootstrap-Loop.
- `lessons/review-isolation.example.md` — neutrales Beispiel für Review-Isolation, Evidence-Nacharbeit und Review of Record.

## Legacy

- `legacy/legacy-runner-notes.md` — verworfene Runner-/Dashboard-Architektur und wiederverwendbare Muster.
