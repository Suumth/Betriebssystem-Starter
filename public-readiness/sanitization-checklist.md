# Sanitization Checklist

## Entfernen

- Private Quellkopien aus dem veröffentlichbaren Starterbereich.
- `.DS_Store`, `__MACOSX`, `.code-review-graph`, lokale Graph-Datenbanken.
- Obsidian Workspace State.
- Echte Projektordner und echte Vault-Inhalte.
- Echte PM-Historie und echte Issue-/PR-Listen.

## Neutralisieren

- Echte Repo-URLs zu `<PROJECT_REPO_URL>` oder `<AI_OS_METHOD_REPO_URL>`.
- Echte Repo-Namen zu `<OWNER>/<REPO>`.
- Lokale Pfade zu `<LOCAL_CHECKOUT_PATH>` oder `<AI_VAULT_PATH>`.
- Produktnamen zu `Demo Project`, `Example App`, `Example Web Project` oder `Example Apple Project`.
- Xcode Skill Routing als neutrales Apple-Platform-Pattern.
- PM Lagebild Defaults zu `example-org/example-repo`.

## Als Demo ersetzen

- Private Lessons durch neutrale Lessons in `ai-betriebssystem/lessons/`.
- Projektmigrationen durch generische Packs in `ai-betriebssystem/migration/projects/`.
- Vault-Projektstruktur durch `_PROJECT_TEMPLATE` und `examples/demo-vault/`.

## Bewusst behalten

- Vollständige Contracts.
- Review of Record Semantik.
- Green Path Completion.
- PM Signal Loop und PM Lagebild Generator.
- Overnight Operations Mode.
- Attempt Budget & Escalation.
- Subagent Failure Policy.
- Human Gate.
- Public Readiness Check.

## Offene Prüfung

- Root `.git` kann noch existieren. Nicht als Inhalt des Starterpakets übernehmen; für ein finales neues Repo frisch initialisieren.
- Falls neue Beispiele hinzugefügt werden, danach immer `bash scripts/public-readiness-check.sh` ausführen.

