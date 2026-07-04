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
  printf 'Created local setup file: setup.local.env\n'
else
  printf 'Using existing local setup file: setup.local.env\n'
fi

is_allowed_config_key() {
  case "$1" in
    PROJECT_NAME|GITHUB_OWNER|GITHUB_REPO|PROJECT_REPO_URL|AI_VAULT_PATH|LOCAL_CHECKOUT_PATH|IMPORT_LABELS|CREATE_TICKET_0|CREATE_VAULT_STRUCTURE)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

trim_spaces() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

strip_optional_quotes() {
  local value="$1"
  local first="${value:0:1}"
  local last="${value: -1}"

  if [ ${#value} -ge 2 ] && { [ "$first" = "'" ] || [ "$first" = '"' ]; } && [ "$first" = "$last" ]; then
    value="${value:1:${#value}-2}"
  fi

  printf '%s' "$value"
}

load_local_config() {
  local config_file="$1"
  local line key value

  while IFS= read -r line || [ -n "$line" ]; do
    line="$(trim_spaces "$line")"
    [ -z "$line" ] && continue
    case "$line" in \#*) continue ;; esac

    if [ "${line#export }" != "$line" ]; then
      line="${line#export }"
      line="$(trim_spaces "$line")"
    fi

    if [ "${line#*=}" = "$line" ]; then
      printf 'Ignoring invalid config line: %s\n' "$line" >&2
      continue
    fi

    key="$(trim_spaces "${line%%=*}")"
    value="${line#*=}"
    value="$(strip_optional_quotes "$value")"

    if is_allowed_config_key "$key"; then
      printf -v "$key" '%s' "$value"
    else
      printf 'Ignoring unsupported config key: %s\n' "$key" >&2
    fi
  done < "$config_file"
}

PROJECT_NAME="${PROJECT_NAME:-}"
GITHUB_OWNER="${GITHUB_OWNER:-}"
GITHUB_REPO="${GITHUB_REPO:-}"
PROJECT_REPO_URL="${PROJECT_REPO_URL:-}"
AI_VAULT_PATH="${AI_VAULT_PATH:-}"
LOCAL_CHECKOUT_PATH="${LOCAL_CHECKOUT_PATH:-}"
IMPORT_LABELS="${IMPORT_LABELS:-}"
CREATE_TICKET_0="${CREATE_TICKET_0:-}"
CREATE_VAULT_STRUCTURE="${CREATE_VAULT_STRUCTURE:-}"

load_local_config "setup.local.env"

LOCAL_CHECKOUT_PATH="${LOCAL_CHECKOUT_PATH:-$ROOT}"
IMPORT_LABELS="${IMPORT_LABELS:-yes}"
CREATE_TICKET_0="${CREATE_TICKET_0:-yes}"
CREATE_VAULT_STRUCTURE="${CREATE_VAULT_STRUCTURE:-yes}"

prompt_value() {
  local var_name="$1"
  local label="$2"
  local default_value="${3:-}"
  local answer=""

  if [ -t 0 ]; then
    if [ -n "$default_value" ]; then
      printf '%s [%s]: ' "$label" "$default_value" >&2
    else
      printf '%s: ' "$label" >&2
    fi
  fi

  if IFS= read -r answer; then
    :
  else
    answer=""
  fi

  if [ -z "$answer" ]; then
    answer="$default_value"
  fi

  printf -v "$var_name" '%s' "$answer"
}

prompt_yes_no() {
  local var_name="$1"
  local label="$2"
  local default_value="${3:-no}"
  local answer=""

  while true; do
    if [ -t 0 ]; then
      printf '%s [%s]: ' "$label" "$default_value" >&2
    fi

    if IFS= read -r answer; then
      :
    else
      answer=""
    fi

    [ -z "$answer" ] && answer="$default_value"
    case "$answer" in
      y|Y|yes|YES|Yes|j|J|ja|JA|Ja)
        printf -v "$var_name" 'yes'
        return 0
        ;;
      n|N|no|NO|No|nein|NEIN|Nein)
        printf -v "$var_name" 'no'
        return 0
        ;;
      *)
        if [ -t 0 ]; then
          printf 'Please answer yes or no.\n' >&2
        else
          printf -v "$var_name" '%s' "$default_value"
          return 0
        fi
        ;;
    esac
  done
}

printf '\nProject values\n'
prompt_value PROJECT_NAME "Project name" "$PROJECT_NAME"
prompt_value GITHUB_OWNER "GitHub owner or organization" "$GITHUB_OWNER"
prompt_value GITHUB_REPO "GitHub repository name" "$GITHUB_REPO"

if [ -z "$PROJECT_REPO_URL" ] && [ -n "$GITHUB_OWNER" ] && [ -n "$GITHUB_REPO" ]; then
  PROJECT_REPO_URL="https://github.com/${GITHUB_OWNER}/${GITHUB_REPO}"
fi

prompt_value PROJECT_REPO_URL "Project repository URL" "$PROJECT_REPO_URL"
prompt_value AI_VAULT_PATH "Local AI Vault path" "$AI_VAULT_PATH"
prompt_value LOCAL_CHECKOUT_PATH "Local checkout path" "$LOCAL_CHECKOUT_PATH"

printf '\nOptional steps\n'
prompt_yes_no IMPORT_LABELS "Import GitHub labels" "$IMPORT_LABELS"
prompt_yes_no CREATE_TICKET_0 "Create Ticket 0" "$CREATE_TICKET_0"
prompt_yes_no CREATE_VAULT_STRUCTURE "Create Vault project structure" "$CREATE_VAULT_STRUCTURE"

export PROJECT_NAME GITHUB_OWNER GITHUB_REPO PROJECT_REPO_URL
export AI_VAULT_PATH LOCAL_CHECKOUT_PATH IMPORT_LABELS CREATE_TICKET_0 CREATE_VAULT_STRUCTURE

python3 - <<'PY'
import os

keys = [
    "PROJECT_NAME",
    "GITHUB_OWNER",
    "GITHUB_REPO",
    "PROJECT_REPO_URL",
    "AI_VAULT_PATH",
    "LOCAL_CHECKOUT_PATH",
    "IMPORT_LABELS",
    "CREATE_TICKET_0",
    "CREATE_VAULT_STRUCTURE",
]

with open("setup.local.env", "w", encoding="utf-8") as handle:
    for key in keys:
        value = os.environ.get(key, "").replace("\r", " ").replace("\n", " ")
        handle.write(f"{key}={value}\n")
PY

printf '\nWrote local setup file: setup.local.env\n'

install_if_missing() {
  local source_path="$1"
  local target_path="$2"

  if [ -e "$target_path" ]; then
    printf 'Keeping existing file: %s\n' "$target_path"
    return 0
  fi

  mkdir -p "$(dirname "$target_path")"
  cp "$source_path" "$target_path"
  printf 'Created file: %s\n' "$target_path"
}

install_if_missing "examples/demo-project/PROJECT.md" "PROJECT.md"
install_if_missing "examples/demo-project/AGENTS.md" "AGENTS.md"
install_if_missing "examples/demo-project/docs/project-brief.md" "docs/project-brief.md"
install_if_missing "examples/demo-project/.github/labels.yml" ".github/labels.yml"
install_if_missing "examples/demo-project/.github/ISSUE_TEMPLATE/task.md" ".github/ISSUE_TEMPLATE/task.md"
install_if_missing "examples/demo-project/.github/pull_request_template.md" ".github/pull_request_template.md"

replace_placeholders() {
  python3 - "$@" <<'PY'
import os
import pathlib
import sys

owner = os.environ.get("GITHUB_OWNER", "")
repo = os.environ.get("GITHUB_REPO", "")
repo_full_name = f"{owner}/{repo}" if owner and repo else ""

replacements = {
    "<OWNER>/<REPO>": repo_full_name,
    "<PROJECT_REPO_URL>": os.environ.get("PROJECT_REPO_URL", ""),
    "<LOCAL_CHECKOUT_PATH>": os.environ.get("LOCAL_CHECKOUT_PATH", ""),
    "<AI_VAULT_PATH>": os.environ.get("AI_VAULT_PATH", ""),
    "<PROJECT_NAME>": os.environ.get("PROJECT_NAME", ""),
}

ordered = sorted(
    [(key, value) for key, value in replacements.items() if value],
    key=lambda item: len(item[0]),
    reverse=True,
)

for arg in sys.argv[1:]:
    path = pathlib.Path(arg)
    if not path.is_file():
        continue
    text = path.read_text(encoding="utf-8")
    updated = text
    for placeholder, value in ordered:
        updated = updated.replace(placeholder, value)
    if updated != text:
        path.write_text(updated, encoding="utf-8")
        print(f"Updated placeholders: {path}")
PY
}

replace_placeholders \
  "PROJECT.md" \
  "AGENTS.md" \
  "docs/project-brief.md" \
  ".github/ISSUE_TEMPLATE/task.md" \
  ".github/pull_request_template.md"

vault_project_slug() {
  python3 - <<'PY'
import os
import re

name = os.environ.get("PROJECT_NAME", "").strip() or "Project"
slug = re.sub(r"[^A-Za-z0-9]+", "_", name).strip("_")
print(slug or "Project")
PY
}

create_vault_structure() {
  if [ -z "$AI_VAULT_PATH" ]; then
    printf 'Skipping Vault structure: AI_VAULT_PATH is empty.\n'
    return 0
  fi

  local project_slug
  project_slug="$(vault_project_slug)"
  local target_dir="${AI_VAULT_PATH}/02_Projects/${project_slug}"
  mkdir -p "$target_dir"

  for source_path in ai-vault/02_Projects/_PROJECT_TEMPLATE/*.md; do
    local target_path="${target_dir}/$(basename "$source_path")"
    if [ -e "$target_path" ]; then
      printf 'Keeping existing Vault file: %s\n' "$target_path"
      continue
    fi
    cp "$source_path" "$target_path"
    replace_placeholders "$target_path"
    printf 'Created Vault file: %s\n' "$target_path"
  done
}

repo_slug=""
if [ -n "$GITHUB_OWNER" ] && [ -n "$GITHUB_REPO" ]; then
  repo_slug="${GITHUB_OWNER}/${GITHUB_REPO}"
elif [ -n "$PROJECT_REPO_URL" ]; then
  repo_slug="$(printf '%s' "$PROJECT_REPO_URL" | sed -E 's#^https://github.com/([^/]+/[^/.]+)(\.git)?/?$#\1#')"
  [ "$repo_slug" = "$PROJECT_REPO_URL" ] && repo_slug=""
fi

gh_ready() {
  if ! command -v gh >/dev/null 2>&1; then
    printf 'GitHub remote step unavailable: gh is not installed.\n'
    return 1
  fi

  if ! gh auth status >/dev/null 2>&1; then
    printf 'GitHub remote step unavailable: run gh auth login first.\n'
    return 1
  fi

  if [ -z "$repo_slug" ]; then
    printf 'GitHub remote step unavailable: set GITHUB_OWNER and GITHUB_REPO.\n'
    return 1
  fi

  return 0
}

import_labels() {
  local labels_file="config/github-labels.json"

  printf '\nImporting GitHub labels into %s\n' "$repo_slug"
  python3 - "$labels_file" <<'PY' | while IFS="$(printf '\t')" read -r name color description; do
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as handle:
    labels = json.load(handle)

for label in labels:
    print(f"{label['name']}\t{label['color']}\t{label.get('description', '')}")
PY
    if gh label edit "$name" --repo "$repo_slug" --color "$color" --description "$description" >/dev/null 2>&1; then
      printf 'Updated label: %s\n' "$name"
    elif gh label create "$name" --repo "$repo_slug" --color "$color" --description "$description" >/dev/null 2>&1; then
      printf 'Created label: %s\n' "$name"
    else
      printf 'Skipped label: %s\n' "$name"
    fi
  done
}

create_ticket_0() {
  local title="Ticket 0: AI readiness bootstrap"
  local body_file="examples/demo-project/docs/ticket-0-example.md"

  printf '\nCreating Ticket 0 in %s\n' "$repo_slug"
  if gh issue create --repo "$repo_slug" --title "$title" --body-file "$body_file" >/dev/null 2>&1; then
    printf 'Created Ticket 0.\n'
  else
    printf 'Skipped Ticket 0: gh issue create failed.\n'
  fi
}

if [ "$CREATE_VAULT_STRUCTURE" = "yes" ]; then
  create_vault_structure
else
  printf 'Skipping Vault structure.\n'
fi

bash scripts/public-readiness-check.sh

if [ "$IMPORT_LABELS" = "yes" ]; then
  if gh_ready; then
    import_labels
  fi
else
  printf '\nSkipping label import.\n'
fi

if [ "$CREATE_TICKET_0" = "yes" ]; then
  if gh_ready; then
    create_ticket_0
  fi
else
  printf 'Skipping Ticket 0 creation.\n'
fi

printf '\nSetup complete.\n'
printf '\nWhat happened:\n'
printf '%s\n' '- Local config written to setup.local.env.'
printf '%s\n' '- Project starter files were created only when missing.'
printf '%s\n' '- Existing project and Vault files were kept.'
printf '%s\n' '- Public readiness check passed before optional GitHub steps.'
printf '\nNext steps:\n'
printf '1. Review setup.local.env.\n'
printf '2. Review git diff for personalized files.\n'
printf '3. Open START_HERE.md and create Ticket 0.\n'
printf '4. Commit the project bootstrap when the diff matches your repo.\n'
printf '5. Keep GitHub as operative truth; use the AI Vault for strategy and project memory.\n'
