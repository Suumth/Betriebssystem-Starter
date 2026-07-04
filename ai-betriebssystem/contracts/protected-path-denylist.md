# Protected Path Denylist and Human Gate Contract

The Protected Path Denylist marks files, domains and surfaces that require escalation before autonomous edits or green auto-merge.

This contract preserves the existing Risk lane model. It does not create new labels, scanners, runners or automation enforcement.

## Denylist

Agents must escalate or require explicit ticket permission before editing paths or domains involving:

- `.env` and `.env.*`;
- Secrets, credentials and keys;
- authentication / authorization / auth flows;
- payments / billing;
- production infrastructure, deployment or hosting configuration;
- migrations or destructive data changes;
- signing, release, app-store or publication surfaces where applicable.

Project repos may add narrower protected paths in their own `AGENTS.md`, `PROJECT.md` or project docs. Local project additions cannot weaken this starter denylist.

## Required Handling

If a PR touches a denylisted path or protected domain, the ticket or PR evidence must show:

- explicit issue scope allowing that surface;
- Risk lane `protected` or `release` when appropriate;
- validation specific to the protected surface;
- Human Gate handling: who must decide, approve or merge;
- remaining risk and rollback or follow-up notes where relevant.

Without those fields, Codex must stop, mark the work `needs-human` or `blocked`, or narrow the diff away from the protected surface.

## Review and Auto-Merge

Review of Record must not PASS a PR that touches denylisted/protected surfaces without explicit issue scope, validation and Human Gate handling.

Denylisted/protected surfaces are not green auto-merge candidates by default. They may become merge candidates only after the protected scope, validation, Risk lane and Human Gate are all reviewable in GitHub evidence.

## Non-Goals

- No new labels.
- No scanner or CI enforcement.
- No automatic path ownership model.
- No permission to edit protected surfaces without ticket scope.
