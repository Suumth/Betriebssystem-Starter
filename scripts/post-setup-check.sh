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
hits_file="${TMPDIR:-/tmp}/post_setup_hits.$$"
trap 'rm -f "$hits_file"' EXIT

if [ ! -f "$placeholder_file" ]; then
  fail "placeholders.json missing, cannot determine scan scope"
  printf '\nPost-setup check failed with %d issue(s).\n' "$failures"
  exit 1
fi

read_placeholders() {
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
}

read_setup_scope() {
  python3 - "$placeholder_file" <<'PY'
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as handle:
    data = json.load(handle)

for item in data.get("setupMayUpdate", []):
    if item:
        print(item)
PY
}

collect_scope_files() {
  local scope

  while IFS= read -r scope; do
    [ -z "$scope" ] && continue

    if [ -f "$scope" ]; then
      printf '%s\n' "$scope"
    elif [ -d "$scope" ]; then
      find "$scope" \
        -path "*/_PROJECT_TEMPLATE/*" -prune -o \
        -type f -print
    fi
  done < <(read_setup_scope)
}

placeholders=()
while IFS= read -r placeholder; do
  placeholders+=( "$placeholder" )
done < <(read_placeholders)

files=()
while IFS= read -r file; do
  files+=( "$file" )
done < <(collect_scope_files | sort -u)

placeholder_count="${#placeholders[@]}"
file_count="${#files[@]}"

for ((placeholder_index = 0; placeholder_index < placeholder_count; placeholder_index++)); do
  placeholder="${placeholders[$placeholder_index]}"
  [ -z "$placeholder" ] && continue
  for ((file_index = 0; file_index < file_count; file_index++)); do
    file="${files[$file_index]}"
    if grep -nF -- "$placeholder" "$file" >"$hits_file"; then
      while IFS=: read -r line _; do
        fail "${file}:${line} contains ${placeholder}"
      done <"$hits_file"
    fi
  done
done

if [ "$failures" -ne 0 ]; then
  printf '\nPost-setup check failed with %d issue(s).\n' "$failures"
  exit 1
fi

pass "no unresolved setup placeholders found in setupMayUpdate scope"
printf '\nPost-setup check passed.\n'
