# Run Budget and Kill Switch Contract

Run Budget and Kill Switch rules keep agent loops bounded before they consume excessive time, budget or trust.

This contract is a GitHub-native decision control. It is not a usage meter, scheduler, dashboard, runner or guarantee about actual model resource usage.

## When It Applies

Use this contract when a ticket, batch, overnight run or review loop expects repeated fix, review, retry, subagent or degraded-mode work.

Low-risk one-pass documentation work may reference this contract without filling every field, unless repeated work starts or a budget is exhausted.

## Budget Fields

Every bounded run should define the smallest useful set of these fields:

- max issues per run:
- max fix attempts per PR/item:
- max subagent/degraded-mode retries:
- max risky files or protected paths touched before escalation:
- max PRs created by one run, if applicable:
- stop conditions:
- operator extension allowed: yes/no + where documented:

Default starter guidance:

- max issues per run: 1 unless the operator explicitly authorizes a batch.
- max fix attempts per PR/item: 2 after the first review or validation failure, unless the operator extends.
- max subagent/degraded-mode retries: 1 targeted recovery per failed required subagent.
- max risky files or protected paths touched before escalation: 0 without an explicit Human Gate; 1 with clear ticket authorization and review evidence.
- max PRs created by one run: 1 unless the operator explicitly authorizes more.

## Stop Conditions

Stop, document evidence and move to `blocked` or `needs-human` when any of these stop conditions occur:

- required validation is missing, unavailable or cannot be made reliable inside the ticket boundary;
- the same failure repeats after the allowed fix attempts;
- the root cause remains unclear after the allowed investigation/fix attempts;
- degraded-mode evidence is missing, unsafe or not reconstructable;
- a protected path, sensitive access surface or release surface would be touched without explicit Human Gate;
- the diff grows beyond the ticket boundary;
- publishing would require force-push, protection bypass or unclear validation.

## Kill Switch Actions

Operator kill actions use the existing label and closeout model:

- remove `agent:ready` when the ticket should not be picked up again automatically;
- add `blocked` when work cannot continue without external state or decision;
- add `needs-human` when an operator decision, protected-path approval or product judgment is required;
- leave `agent:running` only while work is actively in progress;
- document the reason, last evidence, attempts used and recommended next action in the issue or PR closeout.

This contract creates no new labels. Existing signals remain:

- `agent:ready`
- `agent:running`
- `needs-fix`
- `needs-human`
- `blocked`
- `review:pass`
- `auto-merge:ok`
- `overnight:approved`

## Closeout Evidence

When this contract applies, closeout evidence must include:

- max issues per run:
- max fix attempts per PR/item:
- max subagent/degraded-mode retries:
- max risky files or protected paths touched before escalation:
- max PRs created by one run, if applicable:
- attempts used:
- last failed check/review point:
- stop condition hit, if any:
- operator extension granted: yes/no + by whom/where:
- next action: continue | needs-fix | blocked | needs-human | reviewer recommendation

Budget fields are evidence and decision controls. They are not claims about exact resource spend, model internals or hidden tool cost.
