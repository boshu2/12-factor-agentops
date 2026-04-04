# The Operator Model Behind the 12 Factors

The twelve factors are the practical operating rules. This document names the simpler operator model underneath them.

The point is not to replace the factors with a new vocabulary. The point is to explain why the factors work together as one system.

---

## Thesis

Reliable agent operations do not come from one session holding everything in its head.

They come from a **stateful environment** that carries continuity across time, while **replaceable actors** do bounded work inside it. The environment accumulates traces, subjects them to selection gates, promotes the survivors into reusable knowledge, and stays aligned through governance.

That is the operator model behind the twelve factors.

---

## The Six Primitives

### 1. Stateful Environment

Continuity lives outside the current actor.

In practice that means:
- repo history
- briefs and handoff notes
- issues and plans
- tests and validation artifacts
- learnings and failure logs
- explicit rules and operating constraints

The environment is where memory, trust, and coordination survive session boundaries.

### 2. Replaceable Actors

Agents, humans, and tools operate best as bounded workers, not as irreplaceable sources of continuity.

If the system depends on one session remembering everything, it is fragile. If a fresh worker can resume from the environment with a tight brief and a clear scope, the system is robust.

### 3. Durable Traces

Work leaves marks in the environment:
- commits
- notes
- checkpoints
- citations
- validation reports
- failures

Those traces coordinate work across sessions. They let later workers see what changed, what was tried, what was accepted, and what should happen next.

### 4. Selection Gates

Not every trace should survive.

Tests, review, ratchets, checklists with teeth, deploy gates, and outcome metrics act as **selection gates**. They decide what gets accepted into shared state, what gets sent back for revision, and what gets rejected.

### 5. Promotion Loops

Compounding happens when raw traces move upward:

`observation -> validated learning -> reusable pattern -> default guidance`

These **promotion loops** are how a system gets smarter over time. Without them, you have storage. With them, you have adaptation.

### 6. Governance

Governance sets the objective, boundaries, and escalation path.

Humans, policies, role boundaries, and explicit constraints determine:
- what the work is for
- what risks are acceptable
- when review is required
- when to stop, escalate, or override

Governance does not do the work directly. It shapes the work so autonomy remains useful and safe.

---

## Factor Crosswalk

| Factor | Primary operator mechanism | What it contributes |
|---|---|---|
| **I. Context Is Everything** | Stateful environment | Keeps continuity in bounded, reloadable context instead of one overloaded session |
| **II. Track Everything in Git** | Durable traces | Preserves memory, provenance, and resumability in versioned artifacts |
| **III. One Agent, One Job** | Replaceable actors | Keeps workers scoped, swappable, and easy to restart |
| **IV. Research Before You Build** | Governance | Clarifies objective, constraints, and evidence before action |
| **V. Validate Externally** | Selection gates | Ensures the environment, not the author, decides what survives |
| **VI. Lock Progress Forward** | Selection gates | Ratchets accepted work into durable state so later work cannot quietly erase it |
| **VII. Extract Learnings** | Durable traces | Turns completed work into reusable evidence instead of lost experience |
| **VIII. Compound Knowledge** | Promotion loops | Feeds validated learnings back into future sessions so performance improves over time |
| **IX. Measure What Matters** | Governance | Keeps the system aligned to outcomes rather than activity theater |
| **X. Isolate Workers** | Replaceable actors | Prevents hidden coupling when multiple workers operate in parallel |
| **XI. Supervise Hierarchically** | Governance | Makes escalation, coordination, and boundary-setting explicit |
| **XII. Harvest Failures as Wisdom** | Promotion loops | Converts failed attempts into preventative knowledge and better future choices |

---

## Why This Does Not Replace the 12 Factors

The operator model is a compression layer, not a rebrand.

The twelve factors remain the primary surface because they tell practitioners what to do:
- keep context bounded
- track work durably
- validate externally
- compound knowledge

The operator model simply explains why those practices cohere:
- continuity belongs in the environment
- actors should be replaceable
- traces should outlive the session
- gates should decide what survives
- promotion should improve the next run
- governance should set the mission and the limits

Keep the factors for readability. Use the operator model for conceptual compression.

---

## Relation to Tooling

This repo stays broader than any single tool or plugin.

The AgentOps plugin is a reference implementation of many of these mechanics for coding workflows. But the model is more general than that. The same discipline applies anywhere agents operate across time:
- software delivery
- research
- writing
- operations
- hybrid human/agent workflows

The public surface here is still the twelve factors. The operator model explains the machinery beneath them.
