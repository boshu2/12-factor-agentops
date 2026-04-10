# The Twelve Factors

Doctrine behind the operational layer for coding agents. Twelve factors in four
tiers that turn ad-hoc agent work into bookkeeping, validation, and compounding
flows.

The twelve factors stay the primary public surface. The
[operator model](../docs/explanation/operator-model.md) is the compression
layer underneath them: a stateful environment carries continuity, replaceable
actors do scoped work, traces coordinate across sessions, selection gates
decide what survives, promotion loops compound intelligence, and governance
sets objective and boundaries.

---

## Operator Model Crosswalk

| Operator mechanism | What it means here | Primary factors |
|---|---|---|
| **Stateful environment** | Continuity lives in the repo, the artifacts, and the handoff surfaces | I, II, VI, VIII |
| **Replaceable actors** | Workers stay scoped, swappable, and easy to restart | III, X, XI |
| **Durable traces** | Commits, learnings, checkpoints, and failures coordinate work across sessions | II, VII, XII |
| **Selection gates** | Tests, review, ratchets, and outcome checks decide what survives | V, VI, IX |
| **Promotion loops** | Raw observations become reusable patterns and operating rules | VIII, XII |
| **Governance** | Humans and explicit constraints set objective, boundaries, and escalation | IV, V, IX, XI |

## Foundation (I--III)

The non-negotiable starting point.

| # | Factor | One-liner |
|---|--------|-----------|
| [I](./01-context-is-everything.md) | **Context Is Everything** | Load the right context; never let an agent fly blind. |
| [II](./02-track-everything-in-git.md) | **Track Everything in Git** | If it is not in git, it did not happen. |
| [III](./03-one-agent-one-job.md) | **One Agent, One Job** | One agent, one task. Compose specialists. |

## Flow (IV--VI)

How work moves from idea to done.

| # | Factor | One-liner |
|---|--------|-----------|
| [IV](./04-research-before-you-build.md) | **Research Before You Build** | Understand the problem before writing code. |
| [V](./05-validate-externally.md) | **Validate Externally** | Agents cannot judge their own work. |
| [VI](./06-lock-progress-forward.md) | **Lock Progress Forward** | Commit and checkpoint; never lose validated progress. |

## Knowledge (VII--IX)

Turn completions into reusable bookkeeping and organizational intelligence.

| # | Factor | One-liner |
|---|--------|-----------|
| [VII](./07-extract-learnings.md) | **Extract Learnings** | Every completion produces a reusable insight. |
| [VIII](./08-compound-knowledge.md) | **Compound Knowledge** | Wire learnings back into future work. |
| [IX](./09-measure-what-matters.md) | **Measure What Matters** | Track metrics that drive decisions. |

## Scale (X--XII)

Optional. Multi-agent and team-scale operations.

| # | Factor | One-liner |
|---|--------|-----------|
| [X](./10-isolate-workers.md) | **Isolate Workers** | Each worker gets its own environment. |
| [XI](./11-supervise-hierarchically.md) | **Supervise Hierarchically** | Supervisors manage workers, not peers. |
| [XII](./12-harvest-failures-as-wisdom.md) | **Harvest Failures as Wisdom** | Failures are data -- capture and feed them back. |
