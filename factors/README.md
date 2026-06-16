# The Twelve Factors

Doctrine behind the operational layer for coding agents. Twelve factors grouped
by a four-phase operational lifecycle, **Prepare → Bound → Select → Govern**,
that a unit of work passes through, with Govern feeding back into Prepare. The
phases are a reading lens, not a strict dependency chain.

These phases line up with the [CDLC](https://bodenfuller.com/writing/cdlc)
context lifecycle. **Prepare** builds and ships the context (Generate, Compile,
Distribute, Deliver). **Select** tests it. **Govern** observes and adapts.
**Bound** is the odd one out on purpose: least privilege, research, and
isolation are a guardrail axis that wraps every phase, not a stage the work
passes through.

The twelve factors stay the primary public surface. The
[operator model](../docs/explanation/operator-model.md) is the compression
layer underneath them: a stateful environment carries continuity, replaceable
actors do scoped work, traces coordinate across sessions, selection gates
decide what survives, promotion loops compound intelligence, and governance
sets objective and boundaries.

## Loops within loops

The four phases are a loop, not a line. Govern feeds back into Prepare, so a unit of work circles Prepare → Bound → Select → Govern and around again. That loop runs at three nested timescales at once. Gene Kim calls them the [three developer loops](../docs/explanation/three-developer-loops.md): an Inner loop of seconds to minutes (write, test, fix), a Middle loop of hours to days (coordinate agents, build a feature), and an Outer loop of weeks to months (architecture, process, org). Inside a single turn runs a tighter loop still: validate, lock, learn, compound (VII → VIII → IX → X), the ratchet that fires every time work clears a gate.

Loops within loops is the point. A pipeline runs once and ends; a loop compounds. The model you run is rented and roughly the same as everyone else's; what compounds is the loop, and the loops nested inside it, that turn each pass into context the next pass starts from. The twelve factors are the discipline that keeps every one of those loops closing instead of leaking.

---

## Operator Model Crosswalk

| Operator mechanism | What it means here | Primary factors |
|---|---|---|
| **Stateful environment** | Continuity lives in the repo, the artifacts, and the handoff surfaces | I, II, X |
| **Replaceable actors** | Workers stay scoped, swappable, and easy to restart | III, VI, XI |
| **Bounded authority** | Least privilege, sandboxing, and blast-radius limits cap what an agent may do | IV |
| **Durable traces** | Commits, learnings, checkpoints, and failures coordinate work across sessions | II, IX |
| **Selection gates** | Tests, review, ratchets, and outcome checks decide what survives | VII, VIII, XII |
| **Promotion loops** | Raw observations (and failures) become reusable patterns and operating rules | IX, X |
| **Governance** | Humans and explicit constraints set objective, boundaries, and escalation | IV, VII, XI, XII |

## Prepare · Generate → Deliver (I–III)

Set up the environment before the agent acts. In CDLC terms, this is where context is generated, compiled, distributed, and delivered.

| # | Factor | One-liner |
|---|--------|-----------|
| [I](./01-context-is-everything.md) | **Context Is Everything** | Load the right context; never let an agent fly blind. |
| [II](./02-track-everything-in-git.md) | **Track Everything in Git** | If it is not in git, it did not happen. |
| [III](./03-one-agent-one-job.md) | **One Agent, One Job** | One agent, one task. Compose specialists. |

## Bound · guardrail axis (IV–VI)

Constrain what an agent may do before it touches anything real. This is the safety axis that wraps the whole CDLC rather than occupying one of its phases.

| # | Factor | One-liner |
|---|--------|-----------|
| [IV](./04-enforce-least-privilege.md) | **Enforce Least Privilege** | An agent acts inside an envelope it cannot widen — not even on untrusted input. |
| [V](./05-research-before-you-build.md) | **Research Before You Build** | Understand the integration surface before writing code. |
| [VI](./06-isolate-workers.md) | **Isolate Workers** | Concurrent workers share only gated coordination state. |

## Select · Test (VII–IX)

Decide what survives: prove it, lock it, learn from it. This is the CDLC's Test phase, where context is validated against real behavior.

| # | Factor | One-liner |
|---|--------|-----------|
| [VII](./07-validate-externally.md) | **Validate Externally** | The worker claims; an independent checker writes the verdict. |
| [VIII](./08-lock-progress-forward.md) | **Lock Progress Forward** | Validated work ratchets; regression takes an explicit reversal. |
| [IX](./09-extract-learnings.md) | **Extract Learnings** | Every non-trivial session produces a reusable insight, failures included. |

## Govern · Observe + Adapt (X–XII)

Steer the system and feed back into the next cycle. In CDLC terms, this is Observe and Adapt: watch outcomes, then improve the context the next pass starts from.

| # | Factor | One-liner |
|---|--------|-----------|
| [X](./10-compound-knowledge.md) | **Compound Knowledge** | Wire learnings — positive and negative — back into future work. |
| [XI](./11-supervise-hierarchically.md) | **Supervise Hierarchically** | Escalate up with evidence; a stuck worker's job goes to a fresh agent. |
| [XII](./12-measure-outcomes.md) | **Measure Outcomes** | Track fitness toward goals, not activity — the feedback that closes the loop. |
