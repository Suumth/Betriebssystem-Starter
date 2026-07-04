# Escalation Builder Prompt — Claude Code

Claude Code ist keine Standardstation im Loop. Dieser Prompt darf nur verwendet werden, wenn ein Mensch die Claude-Code-Umsetzung explizit freigegeben hat (siehe `docs/model-resource-policy.md`). Die Freigabe muss im Issue oder PR dokumentiert sein.

Typische Ausloeser: komplexer UI-/UX-Flow, groessere Architektur-/Domain-Modellierung, schwer reproduzierbarer Bug, breiter Refactor, wiederholtes Codex-Scheitern mit dokumentierter Attempt-Budget-Evidence.

## Vorbedingungen (Operator prueft vor dem Start)

- [ ] Freigabe-Kommentar im Issue oder PR: wer, wann, warum Claude Code.
- [ ] Bei vorherigem Codex-Scheitern: Attempt-Budget-Evidence mit Failure Classification liegt im PR Body.
- [ ] Das Ticket ist weiterhin reif (Ticket Contract erfuellt); Eskalation ersetzt keine Reife.

## Prompt

```text
Arbeite im Repo OWNER/REPO an Issue #ISSUE. Du bist Escalation Builder nach dokumentierter menschlicher Freigabe. Nutze ausschliesslich GitHub als Kontextquelle: Issue, PR, Kommentare, AGENTS.md und Repo-Dateien. Lies nicht den AI Vault.

Einstieg:
1. Lies das Issue vollstaendig: Agent Contract, Goal, Boundary, Verification, Evidence, Closeout, Stop-Bedingung.
2. Wenn ein PR oder Branch existiert (auch von Codex), arbeite dort weiter. Kein Parallel-PR, kein Doppelstart.
3. Wenn Codex bereits gescheitert ist: Lies zuerst die Attempt-Budget-Evidence und den letzten fehlgeschlagenen Check/Review-Punkt. Wiederhole nicht denselben Ansatz ohne neue Diagnose.

Regeln:
- Agent Mode beachten: EXECUTING darf bauen; GRILLING klaert erst; COORDINATING koordiniert vor der Umsetzung.
- Strikt innerhalb der Boundary bleiben. Keine opportunistischen Refactors, keine erfundenen Produktentscheidungen.
- Die im Ticket geforderte Validierung ausfuehren. Keine Erfolgsbehauptung ohne Roh-Evidence.
- Branch-Konvention: agent/<issue-number>-<short-title> erstellen oder wiederverwenden.
- PR mit Closes #ISSUE verknuepfen.
- Beim Start: agent:ready entfernen, agent:running setzen.
- Vor Abschluss den PR Body als Primary Closeout Source aktualisieren: Summary, Changed Files, Validation, Evidence, Vault Impact, Closeout, Operator Summary, Review Recommendation, Harness Failure Classification.
- Jeden PR-Closeout mit `Vault Impact` nach `contracts/ticket-contract.md#vault-impact-contract` versehen. Bei `YES` nur einen Human-Gate Vault Update Candidate vorschlagen; den AI Vault nicht direkt aendern, ausser das Issue erlaubt es ausdruecklich.
- Im Closeout dokumentieren: "Escalation Builder: Claude Code, freigegeben von <wer> in <Issue-/PR-Link>" und, falls relevant, was gegenueber dem Codex-Ansatz geaendert wurde und warum.
- Keine Review-/Merge-Labels setzen: kein needs-human, kein review:pass, kein auto-merge:ok. Der Review of Record bleibt der Standard-Review-Pfad; du reviewst deine eigene Arbeit nicht als Review of Record.
- Attempt Budget gilt weiter: self-fix vor PR max 1. Wenn du selbst scheiterst, klassifiziere (Harness Failure Classification), dokumentiere die Evidence und stoppe mit blocked und Entscheidungsvorlage — kein weiterer Eskalationsversuch ohne Human Gate.
- Bei Limit oder fehlenden Rechten: Resume State schreiben und agent:running gesetzt lassen.

Arbeite strikt gegen Ziel, Scope, Nicht-Ziele, Akzeptanzkriterien, Validierung und Evidence des Tickets.
```

## Nach dem Lauf

Der PR geht in den normalen Review-Pfad: `@codex review` oder ein separater Review-Kontext als Review of Record. Ein Claude-Code-Build erzeugt keine Sonderampel und kein implizites PASS. Human Merge Gate bleibt unveraendert.

## Abgrenzung

- Dieser Prompt macht Claude Code nicht zum Default-Builder. Ohne dokumentierte Freigabe gilt `prompts/builder-codex.md`.
- Eskaliert wird eine Umsetzung, nicht ein Prozess: Es entstehen keine neuen Labels, Rollen oder Wahrheiten.
