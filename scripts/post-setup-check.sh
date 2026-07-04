#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

failures=0

fail() {
  failures=$((failures + 1))
  printf 'FAIL: %s\n' "$1"
}

pass() {
  printf 'PASS: %s\n' "$1"
}

placeholder_file="config/placeholders.json"
fallback_placeholders=(
  "<OWNER>"
  "<REPO>"
  "<OWNER>/<REPO>"
  "<PROJECT_REPO_URL>"
  "<AI_OS_METHOD_REPO_URL>"
  "<LOCAL_CHECKOUT_PATH>"
  "<AI_VAULT_PATH>"
  "<PROJECT_NAME>"
)

read_placeholders() {
  if [ -f "$placeholder_file" ]; then
    python3 - "$placeholder_file" <<'PY'
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as handle:
    data = json.load(handle)

for item in data.get("placeholders", []):
    value = item.get("placeholder")
    if value:
        print(value)
PY
  else
    printf '%s\n' "${fallback_placeholders[@]}"
  fi
}

excluded_dirs=(
  "ai-betriebssystem/templates"
  "ai-betriebssystem/migration"
  "examples"
  "config"
  "public-readiness"
  ".git"
)

find_args=(.)
for dir in "${excluded_dirs[@]}"; do
  find_args+=( -path "./${dir}" -prune -o )
done
find_args+=( -type f -print )

mapfile -t files < <(find "${find_args[@]}" | sort)
mapfile -t placeholders < <(read_placeholders)

for placeholder in "${placeholders[@]}"; do
  [ -z "$placeholder" ] && continue
  for file in "${files[@]}"; do
    [ "$file" = "./scripts/post-setup-check.sh" ] && continue
    if grep -nF -- "$placeholder" "$file" >/tmp/post_setup_hits.txt; then
      while IFS=: read -r line _; do
        fail "${file#./}:${line} contains ${placeholder}"
      done </tmp/post_setup_hits.txt
    fi
  done
done

rm -f /tmp/post_setup_hits.txt

if [ "$failures" -ne 0 ]; then
  printf '\nPost-setup check failed with %d issue(s).\n' "$failures"
  exit 1
fi

pass "no unresolved setup placeholders found outside template areas"
printf '\nPost-setup check passed.\n'
