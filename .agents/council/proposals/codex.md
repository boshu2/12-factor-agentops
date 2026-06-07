QUORUM: yes

# codex proposal — round 3
## Organizing principle
The organizing principle is the **operational control loop**: prepare the stateful environment, bound the actor, select what survives, then govern the next pass. The order is dependency order inside that loop, not an adoption ladder: each factor appears where downstream factors would be unsafe, unauditable, or unsteerable without it.

## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
|---|---|---|---|
| 1 | Context Is Everything | Manage what enters the context window like you manage what enters production. | Prepare |
| 2 | Track Everything in Git | Version the durable record: code, task state, decisions, evidence, handoffs, and artifact references. | Prepare |
| 3 | One Agent, One Job | Give each agent one scoped task and fresh context at real phase boundaries. | Prepare |
| 4 | Enforce Least Privilege | Grant minimum permissions, sandbox by default, and contain the blast radius. | Bound |
| 5 | Research Before You Build | Map existing code, constraints, and prior attempts before changing integrated systems. | Bound |
| 6 | Isolate Workers | Parallel workers share only gated coordination state, never mutable working state. | Bound |
| 7 | Validate Externally | The worker emits claims and evidence; an independent checker writes the binding verdict. | Select |
| 8 | Lock Progress Forward | Validated changes ratchet into shared state; reversal is explicit, justified, and recorded. | Select |
| 9 | Extract Learnings | Every session produces the work product and provenance-backed lessons, including failed attempts. | Select |
| 10 | Compound Knowledge | Gate, inject, cite, refresh, and decay learnings so future sessions start smarter. | Govern |
| 11 | Supervise Hierarchically | Give every worker one escalation path; supervisors reassign, reframe, or escalate with authority. | Govern |
| 12 | Measure Outcomes | Define the fitness target and track outcomes against it; optimize for goals, not activity. | Govern |

## Grouping
The groups are **Prepare -> Bound -> Select -> Govern**.

**Prepare (1-3)** establishes the stateful environment before any actor mutates it. Context determines what the agent can reason from, git gives that context and evidence a durable record, and scope turns the record into one agent-sized job.

**Bound (4-6)** constrains what may act and how much damage it can do. Least privilege bounds authority, research bounds ignorance, and isolation bounds interference between concurrent attempts.

**Select (7-9)** decides what earns trust. External validation turns claims into verdicts, the ratchet promotes accepted work into stable shared state, and extraction captures what the selected attempt taught before the session disappears.

**Govern (10-12)** closes the loop. Compounding feeds governed memory into future sessions, hierarchy routes failures and authority, and outcome measurement decides whether the system is actually moving toward its goals. Factor XII then feeds the next Factor I: measured outcomes refine the next context, scope, budget, and stop condition.

## What changed vs the current set & why
Added **Enforce Least Privilege** as the missing security factor. A doctrine for write-capable agents needs least privilege, sandboxing, secrets hygiene, prompt-injection resistance, and explicit blast-radius control before execution begins.

Merged old **Harvest Failures as Wisdom** into **Extract Learnings** and **Compound Knowledge**. Negative knowledge is important, but its mechanisms are capture, gating, injection, citation, decay, and fresh escalation. That is the knowledge loop applied to failed attempts, not a separate primitive.

Kept **Measure Outcomes** last. "Define the fitness target" and "measure outcomes over time" happen at different moments, but they are one control-loop factor: the target, the sensor, and the feedback signal define fitness. Placing it first makes the loop look like a one-shot planning checklist; placing it last preserves its distinctive governance role while making clear that its output becomes the next cycle's input.

Kept **Track Everything in Git** early. The audited overstatement is fixed in the one-line rule: git is the durable index of record for state and artifact references, not necessarily the storage backend for every byte. It must exist before isolation, validation, ratcheting, handoffs, and learning can work.

Moved **Isolate Workers** out of the old Scale tier into the execution dependency chain. Isolation is not fleet-only; it is the condition that makes parallel claims attributable and validation trustworthy.

Settled naming on the canonical public forms where they still work: **Context Is Everything** over "Curate Context," **Track Everything in Git** over "Track Durable State," and **Measure Outcomes** over "Set the Fitness Function." The body carries the precision the audit requires without losing the aphoristic surface.

## Open disagreements with the other two proposals
None. Final convergence: same 12, same order, same group boundaries, measurement last as **Measure Outcomes**, and groups **Prepare**, **Bound**, **Select**, **Govern**.
