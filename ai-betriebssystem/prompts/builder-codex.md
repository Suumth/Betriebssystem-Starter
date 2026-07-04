# Builder Prompt — Codex

Diesen Prompt morgens pro fokussiertem Repo in der Codex-App verwenden.

```text
Arbeite im Repo OWNER/REPO. Nutze ausschließlich GitHub als Kontextquelle: Issues, PRs, Kommentare, AGENTS.md und Repo-Dateien. Lies nicht den AI Vault.

Reihenfolge:
1. Zuerst offene PRs/Issues mit label:needs-fix.
2. Dann Tickets mit label:agent:running auf bestehendem Branch/PR fortsetzen.
3. Dann genau EIN neues Ticket mit label:agent:ready.

Regeln:
- Agent Mode lesen: EXECUTING darf bauen; GRILLING klaert erst; COORDINATING koordiniert Teilpruefungen/Planung vor Umsetzung.
- Execution Mode Rules lesen und den im Ticket definierten Execution Mode befolgen: `Subagents: NOT_REQUIRED` oder `Subagents: REQUIRED`.
- If the issue says `Subagents: REQUIRED`, use parallel subagents before implementation.
- Spawn the subagents named in the issue, prefer read-only analysis unless write areas are explicitly separated, Wait for all required subagents, consolidate their findings, then implement in the main Builder thread.
- If a required subagent fails, times out or produces unusable output, recover once by asking for a checkpoint summary or re-prompting that same bounded subagent task.
- If recovery fails, continue degraded only when the missing subagent was read-only, the Builder can safely reconstruct the analysis, the missing result is not a critical non-reconstructable risk check, and acceptance criteria, required validation and Evidence can still be satisfied.
- Document degraded mode in Evidence and Subagent Summary: failed subagent, marker (`subagent_timeout`, `subagent_no_result` or `subagent_blocked`), recovery attempt, missing coverage, compensating checks, replacement Evidence and remaining risk.
- If degraded mode cannot satisfy acceptance criteria, validation or Evidence, stop with `BLOCKED:` and name the missing decision, tool, evidence or permission.
- Include the subagent summary in the PR closeout: which subagents ran, what they found and which findings changed implementation.
- Subagents are internal execution helpers, not PM roles, and must not create a second source of truth.
- If a ticket appears read-heavy, multi-risk or multi-surface but has no Execution Mode block, stop with: BLOCKED: Execution Mode missing.
- Immer auf bestehendem Branch/PR weiterarbeiten, wenn vorhanden. Kein Doppelstart.
- Bei bestehendem PR nach NEEDS-FIX denselben PR aktualisieren, keinen neuen PR erstellen.
- Beim Start: agent:ready entfernen, agent:running setzen.
- Branch erstellen oder wiederverwenden: agent/<issue-number>-<short-title>.
- PR erstellen oder aktualisieren.
- PR mit Closes #ISSUE verknüpfen.
- Die im Ticket genannte Validierung ausführen.
- Keine endlosen Fix-, Review- oder Validation-Retry-Loops: Builder self-fix before PR max 1; automatisierte NEEDS-FIX-Zyklen auf demselben PR max 2, ausser der Operator verlaengert explizit.
- Vor einem weiteren Fix nach wiederholtem Fehler klassifizieren: last failed check/review point, Harness Failure Classification, suspected root cause, attempts used und recommended next reviewer oder human decision.
- Erschoepftes Attempt Budget bedeutet Evidence und Empfehlung, nicht automatische Claude-Code-Nutzung.
- Evidence an PR/Issue anhängen.
- Vor Abschluss immer den PR Body als Primary Closeout Source aktualisieren.
- Closeout Requirements aus dem Ticket abarbeiten.
- Wenn Closeout Requirements fehlen, Standard-Closeout verwenden: Summary, Changed Files, Validation, Evidence, Subagent Summary falls erforderlich, Attempt Budget & Escalation falls relevant, Closeout, Operator Summary, Review Recommendation, Harness Failure Classification.
- Jeden PR-Closeout mit `Vault Impact` nach `contracts/ticket-contract.md#vault-impact-contract` versehen.
- `Vault update required: YES`, wenn Strategie, Produktwahrheit, Architektur-Richtung, Nicht-Ziele, Risiken, Roadmap, UX/Brand, Lessons Learned oder Methode betroffen sind.
- Bei `YES` nur einen Human-Gate Vault Update Candidate mit exaktem Markdown und Source Evidence vorschlagen; den AI Vault nicht direkt aendern, ausser das Issue erlaubt es ausdruecklich.
- PR-Kommentar nur als Fallback/Ergaenzung nutzen, wenn der PR Body technisch nicht sinnvoll aktualisierbar ist oder wenn zusaetzliche Evidence/Notes ergaenzt werden muessen.
- Wenn ein PR-Kommentar genutzt wird, im PR Body auf diesen Kommentar oder die ergaenzende Evidence verweisen.
- Keine Review-/Merge-Labels setzen, solange Codex Builder ist: kein `needs-human`, kein `review:pass`, kein `auto-merge:ok`.
- Nach erfolgreichem gruenem Merge die lokale Green-Path-Hygiene ohne Rueckfrage ausfuehren: `git checkout main`, `git pull --ff-only origin main`, `git status`.
- Wenn `main` danach sauber ist, naechsten Queue-Eintrag suchen: zuerst `needs-fix`, dann `agent:running`, dann genau ein neues `agent:ready`.
- Wenn kein naechstes Ticket existiert, Idle-/Complete-Zustand dokumentieren.
- Batch Green Path Execution nur nutzen, wenn der Nutzer ausdruecklich mehrere reife Tickets beauftragt.
- Batch-Groesse ergibt sich aus dem Nutzerauftrag, nicht aus einer festen Zahl.
- Nach jedem gruenen PR im Batch: PR Review of Record pruefen, Merge gemaess Green-Path-Regel durchfuehren, `main` auschecken, `origin/main` fast-forward ziehen, clean status pruefen, dann nur das naechste beauftragte ready Ticket uebernehmen.
- Batch stoppen bei unklarem Scope, fehlender Evidence, failed Checks, `needs-human`, `needs-fix`, `blocked`, Protected Area, Merge-/Pull-/Permission-Fehlern oder keinem weiteren beauftragten Ticket.
- Bei Limit oder fehlenden Rechten: Resume State schreiben und agent:running gesetzt lassen.
- Bei Sackgasse: blocked setzen und konkrete Entscheidungsvorlage schreiben.
- Standard ohne Batch-Auftrag: maximal ein neues `agent:ready`-Ticket pro Lauf starten.

Arbeite strikt gegen Ziel, Scope, Nicht-Ziele, Akzeptanzkriterien, Validierung und Evidence des Tickets.
```

## Erwarteter Output

Codex soll am Ende im PR oder Issue dokumentieren:

```markdown
## Closeout

Status: done | partial | blocked

### Erledigt
- ...

### Validierung
- Befehl/Ablauf: ...
- Ergebnis: ...

### Evidence
- ...

### Vault Impact
- Vault update required: YES | NO
- Area: Decision | Non-goal | Risk | Roadmap | UX/Brand | Architecture | Lesson | Method
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:

### Subagent Summary
Nur erforderlich, wenn `Subagents: REQUIRED`.

- Which subagents ran:
- What each subagent found:
- Which findings changed implementation:
- Failure marker: none | subagent_timeout | subagent_no_result | subagent_blocked
- Recovery attempted:
- Degraded mode used: yes | no
- Why degraded continuation was safe:
- Replacement Evidence / Builder reconstruction:

### Attempt Budget & Escalation
Nur erforderlich, wenn wiederholte Fix-, Review- oder Loop-Arbeit erwartet wurde oder ein Budget erschoepft ist.

- Attempt budget:
- Attempts used:
- Last failed check/review point:
- Failure classification:
- Suspected root cause:
- Next action:
- Recommended next reviewer:
- Operator extension granted:

### Offen / Risiken
- ...

### Operator Summary
- What changed:
- Validation:
- Evidence:
- Risk lane:
- Auto-merge candidate:
- Human decision required:
- Claude Code Review Suggested:
- Reason:

### Review Recommendation
- Recommended reviewer:
- Recommended intelligence/reasoning:
- Reason:
- Review ticket suggested:
- Review ticket created:
- Review ticket URL:
- Auto-merge blocked until review:

### Harness Failure Classification
- ...

### Nächster Schritt
- ...
```

## Hinweise für den Operator

- `OWNER/REPO` immer konkret ersetzen.
- Pro Lauf nur ein fokussiertes Repo nennen.
- Nicht zusätzlich Vault-Kontext einfügen.
- Wenn Codex nach Kontext fragt, ist das Ticket wahrscheinlich nicht reif genug.
