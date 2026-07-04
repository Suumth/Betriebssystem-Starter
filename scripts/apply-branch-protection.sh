#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

APPLY="no"
BRANCH="main"
REPO=""

usage() {
  cat <<'EOF'
Usage: scripts/apply-branch-protection.sh OWNER/REPO [branch] [--apply]

Dry-run is the default. Pass --apply to write branch protection with gh.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --apply)
      APPLY="yes"
      ;;
    */*)
      REPO="$1"
      ;;
    *)
      BRANCH="$1"
      ;;
  esac
  shift
done

if [ -z "$REPO" ]; then
  usage
  printf 'FAIL: missing OWNER/REPO argument\n'
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  printf 'FAIL: gh is not installed\n'
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  printf 'FAIL: gh is not authenticated\n'
  exit 1
fi

JSON_FILE="$(mktemp)"
trap 'rm -f "$JSON_FILE"' EXIT

cat >"$JSON_FILE" <<'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": [
      "pr-contract",
      "shell-checks",
      "python-tests",
      "public-readiness"
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1
  },
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false
}
JSON

ROUTE="repos/${REPO}/branches/${BRANCH}/protection"

printf 'PASS: planned route: %s\n' "$ROUTE"
printf 'PASS: planned branch protection JSON:\n'
cat "$JSON_FILE"

if [ "$APPLY" != "yes" ]; then
  printf '\nPASS: dry-run only; no GitHub write was performed\n'
  exit 0
fi

gh api -X PUT "$ROUTE" --input "$JSON_FILE" >/dev/null
printf 'PASS: branch protection applied for %s branch %s\n' "$REPO" "$BRANCH"
