# Project Bootstrap Runbook

Dieses Runbook macht aus einer Produktidee ein bootstrap-fertiges
AI-Betriebssystem-2.0-Projekt. Es setzt die Bootstrap-Konvention aus
`docs/bootstrap-loop.md` und das Template-Set aus `templates/` praktisch um.

Der Ablauf ist tool-unabhängig: ChatGPT, Claude, Codex, Gemini und spätere
KI-Tools starten alle über dieselbe `PROJECT.md` im Repo-Root.

## 1. Voraussetzungen

- GitHub-Zugriff auf das Ziel-Repo oder Berechtigung, ein neues Repo anzulegen.
- Ein benannter Projektname und eine grobe Produktidee.
- Ein AI-Vault-Projektbereich oder die Entscheidung, ihn jetzt anzulegen.
- Kenntnis, ob das Projekt iOS, macOS, Web, Docs, Marketing oder ein anderer Typ ist.
- Bei iOS/macOS/Apple-platform-Projekten: Entscheidung, ob die Xcode 27 Skill-Note als bedingte Loading-Map-Quelle eingebunden wird.
- Mindestens ein realistischer Validierungspfad:
  - Docs: `git diff --check`
  - Web: Build/Lint/Preview, falls vorhanden
  - iOS/macOS: Xcode-/Simulator-/Build-Befehl, falls vorhanden
  - unbekannt: fehlenden Verifier als `missing_verifier` markieren
- Keine geheimen Tokens, lokalen Privatpfade oder Vault-Inhalte als Cloud-KI-Pflichtkontext.

## 2. Eingaben für ein neues Projekt

Sammle diese Felder, bevor Dateien angelegt werden:

| Feld | Wert |
|---|---|
| Projektname |  |
| GitHub-Repo-URL |  |
| Default-Branch |  |
| Projekttyp |  |
| lokaler Checkout-Pfad für lokale Agenten |  |
| AI-Vault-Projektordner |  |
| AI-Vault-Online-Einstieg für Cloud-KIs |  |
| Produktvision |  |
| Zielnutzer |  |
| Nicht-Ziele |  |
| Protected Areas |  |
| erster realistischer Verifier |  |

Wenn ein Feld fehlt, triff die kleinste sinnvolle Annahme und markiere sie im
Project Brief oder in Ticket 0. Nur echter fehlender Zugriff blockiert den
Bootstrap.

## 3. Bootstrap-Schritte

1. GitHub-Repo anlegen oder vorhandenes Repo bestimmen.
2. Lokalen Checkout auf `main` oder den Default-Branch synchronisieren.
3. `PROJECT.md` aus `templates/PROJECT.md` in den Repo-Root kopieren.
4. `AGENTS.md` aus `templates/AGENTS.md` in den Repo-Root kopieren.
   - Bei iOS/macOS/Apple-platform-Projekten die bedingte Xcode 27 Loading-Map-Regel aktivieren.
5. `README.md` anlegen oder prüfen:
   - Menschlicher Einstieg
   - kurzer Produktzweck
   - Verweis auf `PROJECT.md` für KI-Arbeit
6. Project Brief aus `templates/project-brief.md` nach `docs/project-brief.md` kopieren.
7. AI-Vault-Dateien aus `templates/ai-vault/` im Vault-Projektbereich anlegen oder vorhandene gleichwertige Dateien mappen.
8. Issue-Template aus `templates/github_issue_task.md` übernehmen.
9. PR-Template aus `templates/pull-request-template.md` übernehmen oder den PR-Body-Standard im Repo dokumentieren.
10. Labels aus `templates/labels.yml` per Label-Sync oder manuell in GitHub anlegen.
11. Tool-Projektanweisungen auf den dünnen Pointer aus `templates/chatgpt-project-instructions.md` reduzieren.
12. Ticket 0 aus `templates/ticket-0-bootstrap.md` erstellen und erst nach vollständigem Contract mit `agent:ready` markieren.
13. Einen kleinen Agentenlauf beweisen: Branch, PR, Validation Evidence, Review of Record, Green Path Completion.

## 4. Erwartete Dateien

Im Projekt-Repo:

```text
PROJECT.md
AGENTS.md
README.md
docs/project-brief.md
.github/ISSUE_TEMPLATE/task.md
.github/pull_request_template.md
.github/labels.yml
```

Im AI Vault oder in einem gleichwertigen online erreichbaren Strategie-Bereich:

```text
Vision.md
Zielbild.md
Produktbrief.md
Roadmap.md
Entscheidungen.md
Risiken.md
Lessons Learned.md
```

Die Dateinamen dürfen projektspezifisch abweichen, wenn `PROJECT.md` die
konkreten Pfade eindeutig referenziert.

## 5. Erwartete GitHub-Konfiguration

Pflichtlabels:

- `agent:ready`
- `agent:running`
- `needs-fix`
- `needs-human`
- `blocked`
- `review:pass`
- `auto-merge:ok`

Optionale Risikolabels:

- `risk:low`
- `risk:standard`
- `risk:protected`
- `risk:release`

Issue- und PR-Konfiguration:

- Task Issues enthalten Agent Contract, Goal, Context, Boundary, Verification, Evidence, Closeout, Operator Summary und Review Recommendation.
- Apple-platform Tasks nennen `Xcode 27` unter Skills nur, wenn SwiftUI, Xcode, iOS/macOS Builds, Simulator/Device, StoreKit, Live Activity, Widget, Watch oder Apple-platform QA betroffen sind.
- PRs enthalten `Closes #<issue>`, Summary, Changed Files, Validation Evidence und bewusst vertagte Punkte.
- `needs-human` ist kein Grün-Signal.
- Auto-Merge braucht Review of Record PASS, `review:pass`, separate Operator-/Human-Gate-Freigabe, `auto-merge:ok`, keine roten/gelben Labels und `Human decision required: no`.

## 6. Ticket-0-Erzeugung

Ticket 0 beweist nur die Agentenfähigkeit des Repos. Es ist kein Featureticket.

Empfohlene Ticket-0-Form:

```text
Title: Ticket 0: Bootstrap proof
Labels: agent:ready, risk:low
Template: templates/ticket-0-bootstrap.md
Goal: Prove that PROJECT.md, AGENTS.md, Project Brief, labels, templates and validation path are enough for an agent run.
Verifier: git diff --check plus repo-specific check if present.
Non-goals: no product feature, no broad architecture rewrite, no credential or Vault copy.
```

Ticket 0 ist reif, wenn ein Agent ohne weitere Rückfrage starten kann und der
PR-Body danach beweist:

- welche Bootstrap-Dateien angelegt oder geprüft wurden
- welcher Verifier lief
- welche Quellen noch fehlen oder bewusst vertagt sind
- ob der Harness Failure `none` oder eine konkrete Klassifikation ist

## 7. Validation

Mindestvalidierung für den Bootstrap-PR:

```bash
git diff --check
```

Zusätzlich ausführen, falls vorhanden:

- Markdownlint oder andere Markdown-Checks
- YAML-Parse für Label-Dateien
- Build/Test/Lint des Zielprojekts
- Preview-/Screenshot-Smoke für UI-Projekte

Wenn ein Check nicht existiert, dokumentiere das im PR-Body. Wenn ein Check
existiert, aber wegen Tooling oder Zugriff nicht läuft, klassifiziere den
Harness Failure als `missing_tool`, `missing_verifier` oder `stale_context`.

## 8. Closeout-Erwartung

Der Bootstrap-PR ist die Primary Closeout Source und enthält:

- `Closes #<ticket-0-issue>`
- Summary
- Changed Files
- Validation Evidence
- Evidence Artifacts
- bewusst vertagte Punkte
- Harness Failure Classification
- Operator Summary
- Review Recommendation

Ein Bootstrap gilt als erfolgreich, wenn:

- `PROJECT.md` im Repo-Root existiert und über GitHub erreichbar ist
- jedes KI-Tool denselben Einstiegspunkt bekommt
- `PROJECT.md` auf AI-Vault-Quellen verweist, ohne sie vollständig zu duplizieren
- `AGENTS.md`, Project Brief, Issue-/PR-Templates und Labels vorhanden oder bewusst gemappt sind
- Ticket 0 ohne weitere Rückfrage bearbeitet werden kann
- Validation Evidence im PR-Body steht
- nach grünem Merge `main` synchronisiert und sauber ist

## 9. Fertiger Startprompt

Nutze diesen Prompt für ChatGPT, Claude, Codex, Gemini oder ein anderes KI-Tool,
wenn ein neues Projekt vorbereitet werden soll:

```text
Arbeite als Bootstrap-Agent für ein neues AI-Betriebssystem-2.0-Projekt.

Ziel:
Bereite aus der folgenden Produktidee ein bootstrap-fertiges Projekt-Setup vor.
Das Ergebnis muss PROJECT.md-first sein: Jede KI liest später zuerst
PROJECT.md im Repo-Root und danach nur die dort verlinkten Quellen.

Produktidee:
<kurze Produktidee einfügen>

Projektangaben:
- Projektname:
- GitHub-Repo-URL oder neuer Repo-Wunsch:
- Projekttyp:
- Default-Branch:
- lokaler Checkout-Pfad für lokale Agenten, falls bekannt:
- AI-Vault-Projektordner oder gewünschter Ordner:
- AI-Vault-Online-Einstieg für Cloud-KIs, falls vorhanden:
- bekannte Nicht-Ziele:
- bekannte Protected Areas:
- erster realistischer Verifier:

Arbeitsregeln:
1. Lies zuerst die Methode aus dem AI-Betriebssystem-2.0-Repo:
   - docs/bootstrap-loop.md
   - templates/project-start-pack.md
   - templates/PROJECT.md
   - templates/AGENTS.md
   - templates/project-brief.md
   - templates/ticket-0-bootstrap.md
   - templates/pull-request-template.md
   - templates/labels.yml
   - templates/ai-vault/
2. Erzeuge oder plane diese Dateien:
   - PROJECT.md
   - AGENTS.md
   - README.md
   - docs/project-brief.md
   - .github/ISSUE_TEMPLATE/task.md
   - .github/pull_request_template.md
   - .github/labels.yml
   - AI-Vault-Dateien für Vision, Zielbild, Produktbrief, Roadmap, Entscheidungen, Risiken und Lessons Learned
3. PROJECT.md ist der zentrale Einstiegspunkt für ChatGPT, Claude, Codex, Gemini und spätere Tools.
4. Tool-spezifische Projektanweisungen dürfen nur auf die GitHub-URL von PROJECT.md zeigen.
5. Kopiere keine lange Vault-Strategie in Tool-Anweisungen. PROJECT.md referenziert Vault-Quellen nur.
6. Erstelle Ticket 0 aus templates/ticket-0-bootstrap.md.
7. Setze agent:ready erst, wenn Ticket 0 ohne Rückfrage bearbeitbar ist.
8. Führe mindestens git diff --check aus und alle vorhandenen Repo-/Markdown-Checks.
9. Dokumentiere Annahmen, fehlende Quellen und bewusst vertagte Punkte im PR-Body.

Lieferformat:
- angelegte/geänderte Dateien
- GitHub-Konfiguration und Labels
- Ticket-0-Text
- Validation Evidence
- bewusst vertagte Punkte
- Harness Failure Classification
- klare Aussage, ob das Projekt bootstrap-fertig ist
```
