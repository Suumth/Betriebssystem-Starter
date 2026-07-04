#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

printf 'AI-Betriebssystem Starter setup\n'
printf 'Repo: %s\n\n' "$(basename "$ROOT")"

required_paths=(
  "README.md"
  "START_HERE.md"
  "config/starter.config.example"
  "config/placeholders.json"
  "config/github-labels.json"
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

if [ ! -f "setup.local.env" ]; then
  cp config/starter.config.example setup.local.env
  printf 'Created local setup file: setup.local.env\n\n'
else
  printf 'Using existing local setup file: setup.local.env\n\n'
fi

set -a
. ./setup.local.env
set +a

bash scripts/public-readiness-check.sh

import_labels() {
  local repo="$1"
  local labels_file="config/github-labels.json"

  if ! command -v gh >/dev/null 2>&1; then
    printf '\nSkipping label import: gh is not installed.\n'
    return 0
  fi

  if ! gh auth status >/dev/null 2>&1; then
    printf '\nSkipping label import: gh is not logged in.\n'
    return 0
  fi

  printf '\nImporting GitHub labels into %s\n' "$repo"
  python3 - "$labels_file" <<'PY' | while IFS="$(printf '\t')" read -r name color description; do
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as handle:
    labels = json.load(handle)

for label in labels:
    print(f"{label['name']}\t{label['color']}\t{label.get('description', '')}")
PY
    if gh label edit "$name" --repo "$repo" --color "$color" --description "$description" >/dev/null 2>&1; then
      printf 'Updated label: %s\n' "$name"
    elif gh label create "$name" --repo "$repo" --color "$color" --description "$description" >/dev/null 2>&1; then
      printf 'Created label: %s\n' "$name"
    else
      printf 'Skipped label: %s\n' "$name"
    fi
  done
}

repo_slug=""
if [ -n "${GITHUB_OWNER:-}" ] && [ -n "${GITHUB_REPO:-}" ]; then
  repo_slug="${GITHUB_OWNER}/${GITHUB_REPO}"
elif [ -n "${PROJECT_REPO_URL:-}" ]; then
  repo_slug="$(printf '%s' "$PROJECT_REPO_URL" | sed -E 's#^https://github.com/([^/]+/[^/.]+)(\\.git)?/?$#\\1#')"
  [ "$repo_slug" = "$PROJECT_REPO_URL" ] && repo_slug=""
fi

if [ "${IMPORT_LABELS:-yes}" = "yes" ] && [ -n "$repo_slug" ]; then
  import_labels "$repo_slug"
elif [ "${IMPORT_LABELS:-yes}" = "yes" ]; then
  printf '\nSkipping label import: set GITHUB_OWNER and GITHUB_REPO in setup.local.env.\n'
else
  printf '\nSkipping label import: IMPORT_LABELS is not yes.\n'
fi

printf '\nNext steps:\n'
printf '1. Read START_HERE.md.\n'
printf '2. Open ai-vault/ in Obsidian or a Markdown editor.\n'
printf '3. Create Ticket 0 with examples/demo-project/docs/ticket-0-example.md.\n'
