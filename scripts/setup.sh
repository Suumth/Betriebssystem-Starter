#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

printf 'AI-Betriebssystem Starter setup\n'
printf 'Repo: %s\n\n' "$(basename "$ROOT")"

required_paths=(
  "README.md"
  "START_HERE.md"
  "ai-betriebssystem"
  "ai-vault"
  "examples/demo-project"
  "scripts/public-readiness-check.sh"
)

for path in "${required_paths[@]}"; do
  if [ ! -e "$path" ]; then
    printf 'Missing required path: %s\n' "$path" >&2
    exit 1
  fi
done

bash scripts/public-readiness-check.sh

printf '\nNext steps:\n'
printf '1. Read START_HERE.md.\n'
printf '2. Open ai-vault/ in Obsidian or a Markdown editor.\n'
printf '3. Create Ticket 0 with examples/demo-project/docs/ticket-0-example.md.\n'
