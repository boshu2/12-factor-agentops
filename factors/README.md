# The Twelve Factors

Operational discipline for working with AI agents. Twelve rules organized into four tiers -- foundation through scale -- that turn chaotic agent workflows into repeatable, compounding systems.

---

## Foundation (I--III)

The non-negotiable starting point. Get these right or nothing else matters.

| # | Factor | Rule |
|---|--------|------|
| [I](./01-context-is-everything.md) | **Context Is Everything** | Load the right context at the right time; never let an agent fly blind. |
| [II](./02-track-everything-in-git.md) | **Track Everything in Git** | If it is not in git, it did not happen. |
| [III](./03-one-agent-one-job.md) | **One Agent, One Job** | Single responsibility -- one agent, one task, compose specialists. |

## Workflow (IV--VI)

How work moves from idea to done.

| # | Factor | Rule |
|---|--------|------|
| [IV](./04-research-before-you-build.md) | **Research Before You Build** | Understand the problem space before writing a single line of code. |
| [V](./05-validate-externally.md) | **Validate Externally** | Agents cannot judge their own work; use external checks. |
| [VI](./06-lock-progress-forward.md) | **Lock Progress Forward** | Commit, checkpoint, never lose validated progress. |

## Knowledge (VII--IX)

Turn individual completions into organizational intelligence.

| # | Factor | Rule |
|---|--------|------|
| [VII](./07-extract-learnings.md) | **Extract Learnings** | Every completion produces a reusable insight -- capture it. |
| [VIII](./08-compound-knowledge.md) | **Compound Knowledge** | Knowledge compounds; wire learnings back into future work. |
| [IX](./09-measure-what-matters.md) | **Measure What Matters** | Track the metrics that drive decisions, ignore vanity numbers. |

## Scale (X--XII)

Optional factors for multi-agent and team-scale operations.

| # | Factor | Rule |
|---|--------|------|
| [X](./10-isolate-workers.md) | **Isolate Workers** | Each worker gets its own environment -- no shared mutable state. |
| [XI](./11-supervise-hierarchically.md) | **Supervise Hierarchically** | Supervisors manage workers; workers never manage each other. |
| [XII](./12-harvest-failures-as-wisdom.md) | **Harvest Failures as Wisdom** | Failures are data -- capture, analyze, and feed them back. |
