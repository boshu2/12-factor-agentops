# codex proposal — round 1
## Organizing principle
The organizing principle is a closed operational control loop: define the fitness target, bound the environment that may act, run work in replaceable cells, select what survives, and feed the result back into future loops. The order is dependency order inside that loop: a factor earns its place when later factors cannot be trusted without it.

## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
|---|---|---|---|
| 1 | Set the Fitness Function | Define the goal, budget, boundary, success signal, and stop condition before the agent starts. | Aim |
| 2 | Curate Context | Load the right context for the next decision; more context is not more memory. | Aim |
| 3 | Track Durable State | Put work state, decisions, evidence, and handoffs in git or a git-indexed record. | Aim |
| 4 | Bound Authority | Give every agent the least privilege needed, sandbox untrusted work, and make blast radius explicit. | Bound |
| 5 | One Agent, One Job | Give each actor one scoped task and a fresh context at real phase boundaries. | Bound |
| 6 | Research Before You Build | Discover existing patterns, constraints, and negative results before changing integrated code. | Bound |
| 7 | Isolate Workers | Parallel workers share only gated coordination state, never mutable working state. | Filter |
| 8 | Validate Externally | The worker emits claims and evidence; an independent gate writes the binding verdict. | Filter |
| 9 | Lock Progress Forward | Validated work ratchets into shared state; regression needs explicit recorded reversal. | Filter |
| 10 | Extract Learnings | Every non-trivial session produces the work product and provenance-backed lessons, including failed attempts. | Learn |
| 11 | Compound Knowledge | Gate, inject, cite, refresh, and decay learnings so future sessions start smarter. | Learn |
| 12 | Supervise Hierarchically | Every worker has one escalation path; failures move up with evidence and authority flows down. | Learn |

## Grouping
The grouping is **Aim → Bound → Filter → Learn**, one pass through the control loop.

**Aim (1-3)** sets the target and the state surface. A system cannot choose useful context or measure progress until it knows what fitness means; it cannot hand off or audit work unless durable state exists outside the current session.

**Bound (4-6)** constrains what may act. Permissions cap damage, scoped actors cap cognitive drift, and research caps integration ignorance before any worker changes the world.

**Filter (7-9)** decides what survives. Isolation keeps parallel attempts independent, validation supplies an external verdict, and the ratchet makes accepted work stable enough for later agents to trust.

**Learn (10-12)** closes and scales the loop. Extraction creates memory, compounding gets memory back into future contexts, and supervision governs retry, escalation, and coordination when the same loop is replicated across many workers.

## What changed vs the current set & why
Added **Bound Authority** as a first-class factor. Security, permissions, sandboxing, prompt-injection resistance, and blast-radius control are not validation details; they are preconditions for letting write-capable agents touch real systems.

Moved **Measure What Matters** to the front as **Set the Fitness Function**. Measurement is governance, not a knowledge-tier afterthought. The useful primitive is not a dashboard; it is the explicit definition of goal, budget, boundary, stop condition, and outcome signals that every later gate uses.

Kept **Context**, **Git**, **One Agent**, **Research**, **Validate**, **Ratchet**, **Extract**, **Compound**, **Isolate**, and **Supervise**, but reordered them by dependency instead of adoption altitude. The old Foundation/Flow/Knowledge/Scale tiers were a reasonable on-ramp, but they did not explain why IX followed VIII or why X-XI waited until the end.

Collapsed **Harvest Failures as Wisdom** into **Extract Learnings** and **Compound Knowledge**. Negative knowledge is important, but it is not a separate primitive: failed attempts are captured by extraction, promoted or rejected by the knowledge gate, and injected before future planning by the compounding loop. Keeping XII standalone duplicates VIII and makes the set look padded.

Sharpened overstated claims into operational rules. The recut avoids invented token thresholds, pseudo-math, absolute "always" language, and literal "everything in git" claims where a git-indexed reference is the real invariant.

## Open disagreements with the other two proposals
Round 1 is independent, and I have not read the other proposals. No observed disagreements yet.

Positions I expect to defend in Round 2: measurement belongs first as the fitness function, security must be early rather than buried under validation, and failure harvesting should not survive as a standalone factor unless the others can show a mechanism distinct from extraction plus compounding.
