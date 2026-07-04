#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

failures=0

note() {
  printf '%s\n' "$1"
}

fail() {
  failures=$((failures + 1))
  printf 'FAIL: %s\n' "$1"
}

pass() {
  printf 'PASS: %s\n' "$1"
}

release_paths=(
  "README.md"
  "START_HERE.md"
  "RELEASE_READINESS.md"
  ".gitignore"
  "config"
  "ai-betriebssystem"
  "ai-vault"
  "docs"
  "examples"
  "public-readiness"
  "scripts"
)

private_pattern="$(
  printf '%s' 'thor''sten|mu''us|thor''sten''mu''us|/Us''ers/|Documents/Cod''ex|AI Proj''ekte Vault|Su''umth|use''ful''magic|grill''cue|Sear''Cue|Doc''ument Cue|Doc''ument-Cue|AI Dash''board|AI-Dash''board1|com\.grill''cue'
)"
sensitive_pattern="$(
  printf '%s' 'g''hp_|git''hub_pat_|s''k-[A-Za-z0-9_-]{20,}|Bearer [A-Za-z0-9._-]{20,}|OPENAI_API''_KEY|ANTHROPIC_API''_KEY|pass''word|sec''ret|tok''en|api''_key'
)"
canonical_template_url="https://github.com/Su""umth/Betriebssystem-Starter/generate"
entrypoint_placeholder_pattern="<OWNER>|<REPO>|<AI_VAULT_PATH>|TODO_PRIVATE"

scan_args=()
for path in "${release_paths[@]}"; do
  [ -e "$path" ] && scan_args+=("$path")
done

if grep -RInEi "$private_pattern" "${scan_args[@]}" \
  --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.obsidian >/tmp/ai_os_private_hits_raw.txt; then
  grep -vF "$canonical_template_url" /tmp/ai_os_private_hits_raw.txt >/tmp/ai_os_private_hits.txt || true
  if [ -s /tmp/ai_os_private_hits.txt ]; then
    cat /tmp/ai_os_private_hits.txt
    fail "private pattern hits found"
  else
    pass "no private pattern hits"
  fi
else
  pass "no private pattern hits"
fi

if grep -RInE "$sensitive_pattern" "${scan_args[@]}" \
  --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.obsidian >/tmp/ai_os_sensitive_hits.txt; then
  cat /tmp/ai_os_sensitive_hits.txt
  fail "possible credential pattern hits found"
else
  pass "no possible credential pattern hits"
fi

if grep -RInE "$entrypoint_placeholder_pattern" README.md START_HERE.md >/tmp/ai_os_entrypoint_placeholder_hits.txt; then
  cat /tmp/ai_os_entrypoint_placeholder_hits.txt
  fail "entrypoint placeholder hits found"
else
  pass "no entrypoint placeholder hits"
fi

required_files=(
  "README.md"
  "START_HERE.md"
  "RELEASE_READINESS.md"
  ".gitignore"
  "config/README.md"
  "config/github-labels.json"
  "config/placeholders.json"
  "config/starter.config.example"
  "ai-betriebssystem/README.md"
  "ai-betriebssystem/START_HERE.md"
  "ai-betriebssystem/contracts/ticket-contract.md"
  "ai-betriebssystem/contracts/review-contract.md"
  "ai-betriebssystem/contracts/labels.md"
  "ai-betriebssystem/docs/green-path-completion.md"
  "ai-betriebssystem/docs/pm/pm-signal-loop.md"
  "ai-betriebssystem/docs/overnight-operations-mode.md"
  "ai-betriebssystem/prompts/builder-codex.md"
  "ai-betriebssystem/prompts/reviewer-claude.md"
  "ai-betriebssystem/templates/PROJECT.md"
  "ai-betriebssystem/templates/AGENTS.md"
  "ai-vault/00_START_HERE.md"
  "ai-vault/02_Projects/_PROJECT_TEMPLATE/Vision.md"
  "examples/demo-project/PROJECT.md"
  "examples/demo-project/AGENTS.md"
  "examples/demo-project/.github/labels.yml"
  "examples/demo-vault/00_START_HERE.md"
  "public-readiness/full-system-inventory.md"
  "public-readiness/sanitization-checklist.md"
  "scripts/setup.sh"
)

for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    pass "required file exists: $file"
  else
    fail "missing required file: $file"
  fi
done

while IFS= read -r -d '' script_file; do
  if bash -n "$script_file"; then
    pass "shell syntax valid: $script_file"
  else
    fail "shell syntax invalid: $script_file"
  fi
done < <(find scripts -type f -name "*.sh" -print0)

for json_file in config/*.json; do
  if python3 -m json.tool "$json_file" >/dev/null; then
    pass "json valid: $json_file"
  else
    fail "json invalid: $json_file"
  fi
done

if command -v git >/dev/null 2>&1 && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git ls-files --error-unmatch setup.local.env >/dev/null 2>&1; then
    fail "local setup file is tracked: setup.local.env"
  else
    pass "local setup file is not tracked"
  fi
fi

required_labels=(
  "agent:ready"
  "agent:running"
  "needs-fix"
  "needs-human"
  "blocked"
  "review:pass"
  "auto-merge:ok"
  "overnight:approved"
  "risk:low"
  "risk:standard"
  "risk:protected"
  "risk:release"
)

for label in "${required_labels[@]}"; do
  if grep -R -- "$label" config/github-labels.json ai-betriebssystem/templates/labels.yml examples/demo-project/.github/labels.yml ai-betriebssystem/contracts/labels.md >/dev/null; then
    pass "required label present: $label"
  else
    fail "missing required label: $label"
  fi
done

for legacy_label in "human-gate" "status:review" "status:done"; do
  if grep -RIn -- "$legacy_label" ai-betriebssystem examples/demo-project >/tmp/ai_os_legacy_label_hits.txt; then
    cat /tmp/ai_os_legacy_label_hits.txt
    fail "non-operative legacy label found: $legacy_label"
  else
    pass "legacy label absent: $legacy_label"
  fi
done

if find "${scan_args[@]}" \( -path "*/.git" -o -path "*/.git/*" \) -prune -o \( -name ".DS_Store" -o -name "__MACOSX" -o -name "__pycache__" -o -name "*.pyc" -o -name ".code-review-graph" -o -name "graph.db" \) -print | grep . >/tmp/ai_os_local_artifacts.txt; then
  cat /tmp/ai_os_local_artifacts.txt
  fail "local artifacts found"
else
  pass "no local artifacts found"
fi

if find ai-betriebssystem ai-vault docs examples public-readiness scripts -name ".git" -print | grep . >/tmp/ai_os_nested_git.txt; then
  cat /tmp/ai_os_nested_git.txt
  fail "nested git history found in release area"
else
  pass "no nested git history in release area"
fi

if [ -d ".git" ]; then
  note "WARN: root .git exists; reinitialize before publishing a clean starter repo."
fi

if [ "$failures" -ne 0 ]; then
  printf '\nPublic readiness failed with %d issue(s).\n' "$failures"
  exit 1
fi

printf '\nPublic readiness passed.\n'
