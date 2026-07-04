# Generic Apple Project Bootstrap Pack

Dieses neutrale Pack zeigt, wie ein Apple-Platform-Projekt in das AI-Betriebssystem aufgenommen wird.

## Quellen

- Project repository: `<PROJECT_REPO_URL>`
- PROJECT.md: `<PROJECT_MD_GITHUB_URL>`
- Local checkout fallback: `<LOCAL_CHECKOUT_PATH>`
- AI Vault folder: `<AI_VAULT_PATH>`
- Method repository: `<AI_OS_METHOD_REPO_URL>`

## Apple-spezifische Hinweise

- Xcode Skill Routing bleibt ein neutrales Pattern.
- Simulator-, Device-, Signing- und Release-Arbeit sind getrennte Risikoebenen.
- Runtime Evidence darf nur behauptet werden, wenn sie wirklich erzeugt wurde.

## Ticket 0

Install and prove the PROJECT.md-first bootstrap layer for Example Apple Project without changing app behavior.

## Validation

- Repo- und Scheme-Discovery sind dokumentiert oder als Human Gate markiert.
- Keine Bundle IDs, Accounts oder Signing-Geheimnisse im Starter.
- Review of Record trennt Build-Evidence von Runtime-Evidence.

