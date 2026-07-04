# Skill Registry

This folder holds Markdown-only skill notes for recurring agent work.

The canonical registry rules are in `../contracts/skill-contract.md`. A skill note is method context, not executable code. It does not create an agent, install dependencies, override a ticket, mutate the Vault or bypass Review of Record or Human Gate.

Skill changes are active only after PR, Review of Record and merge.

## Candidate Starter Skills

Candidate registry entries can cover:

- Review of Record: PR review against a linked GitHub issue.
- Vault Impact: checking whether a change needs a Vault Update Candidate.
- PM Signal: summarizing GitHub Issues, PRs and labels without creating a second source of truth.
- Xcode Simulator Evidence: collecting build, simulator and screenshot evidence for Apple-platform tickets.

Candidates should follow the Skill Registry contract:

- purpose;
- when to use;
- when not to use;
- inputs;
- expected output;
- evidence rule;
- failure modes;
- version / last changed;
- source evidence.

Existing short skill notes can remain lightweight until a ticket explicitly upgrades them to the full registry format.
