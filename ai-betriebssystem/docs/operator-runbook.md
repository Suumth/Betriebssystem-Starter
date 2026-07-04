# Operator Runbook

Eine Seite für den Solo-Operator. Alles andere ist Referenz.

Der Operator hat pro Tag drei Berührungspunkte mit dem System: abends planen, morgens starten, danach Ampeln entscheiden. Dieses Runbook beschreibt nur diese Berührungspunkte. Es führt keinen Runner, kein Dashboard und keine neue Wahrheit ein.

## Abend: Tickets schneiden (10-20 Minuten)

1. Offene Arbeit in ChatGPT / Opus grillen, bis pro Ticket klar ist:
   - Ziel in einem Satz
   - Boundary (allowed / do not touch)
   - Verification (konkreter Befehl oder Ablauf)
   - Evidence-Bedingung
   - Stop-Bedingung
2. Ticket-Tier wählen:
   - **Low Risk** (`templates/github_issue_task_low_risk.md`): Risk lane low, keine Subagents, keine wiederholte Loop-Arbeit, eine Oberfläche.
   - **Full** (`templates/github_issue_task.md`): alles andere, insbesondere protected/release, `Subagents: REQUIRED` oder erwartete Fix-Zyklen.
3. Erst wenn das Ticket sich selbst prüfen kann: `agent:ready` setzen.

Faustregel: Wenn du beim Schreiben des Verification-Blocks zögern musst, ist das Ticket nicht reif.

## Morgen: Builder starten (2 Minuten)

1. Ein fokussiertes Repo wählen. Nur eines pro Lauf.
2. Builder-Prompt aus `prompts/builder-codex.md` in die Codex-App einfügen, `OWNER/REPO` ersetzen.
3. Nicht zusätzlich Kontext einfügen. Wenn Codex nach Kontext fragt, war das Ticket nicht reif — abends nachschärfen, nicht im Chat nachliefern.

Codex arbeitet in der Reihenfolge: `needs-fix` → `agent:running` → genau ein `agent:ready`.

## Danach: Review anstossen

1. Offene PRs prüfen: `gh pr list --repo OWNER/REPO`
2. Review of Record starten: `@codex review` am PR oder Reviewer-Prompt aus `prompts/reviewer-claude.md` (nur bei Eskalation, siehe `docs/model-resource-policy.md`).
3. Der Review endet mit genau einer Ampel.

## Ampel-Entscheidung

| Ampel | Labels | Operator-Aktion |
|---|---|---|
| Grün | `review:pass` + `auto-merge:ok` | Mergen: `gh pr merge <PR> --squash --delete-branch`. Danach macht Codex die Green-Path-Hygiene selbst. |
| Gelb | `review:pass` + `needs-human` | Entscheidungsvorlage im Review lesen, entscheiden, dann mergen oder Fix-Ticket priorisieren. |
| Rot | `needs-fix` | Nichts tun. Codex fixt im selben PR beim nächsten Lauf. Nach 2 erfolglosen Fix-Zyklen: Attempt-Budget-Evidence lesen und entscheiden. |
| Rot | `blocked` | Entscheidungsvorlage lesen, Option wählen, im Issue/PR antworten. |

Merken: `needs-human` ist nie eine Freigabe. `auto-merge:ok` nur bei vollständig grünen Kriterien (siehe `contracts/labels.md`).

## Befehls-Spickzettel

```bash
# Queue-Blick pro Repo
gh issue list --repo OWNER/REPO --label agent:ready
gh issue list --repo OWNER/REPO --label needs-fix
gh pr list --repo OWNER/REPO --label needs-human

# Hängt ein Lauf? agent:running ohne Branch/PR = stale Label
gh issue list --repo OWNER/REPO --label agent:running

# Grüner Merge
gh pr merge <PR> --squash --delete-branch
```

## Woche: Hygiene (einmal, 15 Minuten)

1. PM Signal Lauf mit `templates/pm-signal-prompt.md` für den Leiterblick.
2. Stale Labels prüfen: `agent:running` ohne aktiven Branch/PR zurücksetzen.
3. Wenn ein Lauf schlecht war: Harness Failure Classification prüfen und bei wiederkehrendem Muster eine Lesson nach `templates/lesson.md` schreiben. Jede Lesson endet mit einer expliziten Regelanpassungs-Entscheidung.

## Was der Operator nie tut

- Inhalte zwischen Tools kopieren. Nur Pointer und GitHub-URLs.
- `auto-merge:ok` setzen, wenn ein gelbes oder rotes Label steht.
- Claude Code als Standard-Station nutzen. Claude Code ist Eskalation nach expliziter Freigabe (`docs/model-resource-policy.md`, `prompts/builder-claude-code.md`).
- Projektwahrheit in Tool-Anweisungen oder Chat-Verläufe verschieben.
