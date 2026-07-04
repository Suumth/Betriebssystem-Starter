# Release Readiness

Status: ready

## Zielbild

Vollständige neutrale AI-Betriebssystem-Starterinstallation.

## Enthaltene Funktionen

- Ticket Contract
- Review Contract
- Label Contract
- PROJECT.md-first
- AGENTS.md
- Codex Builder Prompt
- Reviewer Prompt
- Green Path
- PM Signal Loop
- PM Lagebild
- Overnight Operations
- Attempt Budget
- Subagent Failure Policy
- Xcode Skill Routing als neutrales Apple-Platform-Pattern
- Migration/Bootstrap-Runbooks
- Lessons-Struktur
- AI Vault Starter
- Demo Project
- Demo Vault
- Public Readiness Check

## Entfernte private Inhalte

- Private Projektordner aus dem veröffentlichbaren Starterbereich.
- Echte Vault-Projektinhalte, Roadmaps, Entscheidungen, Risiken, Lessons und Research-Notizen.
- Echte PM-Historie und Issue-/PR-Listen.
- Lokale Graph-Datenbanken, Finder-Artefakte und Obsidian Workspace State.

## Neutralisierte Inhalte

- Repo-URLs durch `<PROJECT_REPO_URL>` und `<AI_OS_METHOD_REPO_URL>`.
- Repo-Namen durch `<OWNER>/<REPO>`.
- Lokale Pfade durch `<LOCAL_CHECKOUT_PATH>` und `<AI_VAULT_PATH>`.
- Produktnamen durch Demo- und Example-Bezeichnungen.
- Projektmigrationen durch generische Bootstrap-Packs.
- Lessons durch neutrale Lessons.
- PM Lagebild Defaults durch Beispielwerte.

## Bewusst nicht enthalten

- Echte private Projekte.
- Echte private Produktnamen.
- Echte Roadmaps oder Projektverlaeufe.
- Echte GitHub-Owner, Issues, PRs oder Accountdaten.
- Secrets, Zugangsdaten oder lokale Workspace-State-Dateien.
- Eine übernommene Unterordner-Git-Historie in `ai-betriebssystem/`, `ai-vault/`, `examples/`, `docs/`, `public-readiness/` oder `scripts/`.

## Validierung

Auszuführen vor Weitergabe:

```bash
bash scripts/public-readiness-check.sh
find . -name ".DS_Store" -o -name "__MACOSX" -o -name ".code-review-graph" -o -name ".git"
grep -RInE '<private-patterns>' . --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.obsidian
grep -RInE '<credential-patterns>' . --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.obsidian
```

Der Public Readiness Check prüft private Treffer, credential-aehnliche Treffer, lokale Pfade, Pflichtdateien, Pflichtlabels, Vault Starter, Demo-Projekt, Demo-Vault, lokale Artefakte und verschachtelte Git-Historie im Release-Bereich.

## Risiken

- Empfehlung: für ein neues privates GitHub-Repo einen frischen Ordner oder frischen Git-Init verwenden und nur die neutralen Starterdateien importieren.
- Die privaten Quellkopien wurden aus dem veröffentlichbaren Starterbereich entfernt und lokal neben dem Starterordner archiviert.

## Empfehlung

Ready for new private GitHub repo: yes.


## Clean Export Note

Dieser Clean Export enthält keine `.git`-Historie, keine `.code-review-graph`, keine `.DS_Store` und kein `__MACOSX`.
