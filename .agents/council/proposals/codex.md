QUORUM: yes

# codex proposal — round 2
## Organizing principle
The organizing principle is the **closed operational control loop**: aim the work, bound the actor, select what survives, then adapt the system for the next pass. The order is dependency order, not adoption order: each factor appears where later factors would be unsafe, unauditable, or directionless without it.

## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
|---|---|---|---|
| 1 | Set the Fitness Function | Define success, budget, risk boundary, evidence, and stop condition; measure outcomes, not motion. | Aim |
| 2 | Curate Context | Load only the context the next decision needs; compress and reload deliberately. | Aim |
| 3 | Track Durable State | Keep task state, decisions, evidence, handoffs, and artifact references in a git-indexed record. | Aim |
| 4 | One Agent, One Job | Give each worker one scoped task and fresh context at real phase boundaries. | Bound |
| 5 | Enforce Least Privilege | Grant only the permissions the scoped job needs; sandbox untrusted work and contain blast radius. | Bound |
| 6 | Research Before You Build | Map existing code, constraints, and prior attempts before mutating integrated systems. | Bound |
| 7 | Isolate Workers | Concurrent workers get separate workspaces, contexts, and mutable working state. | Select |
| 8 | Validate Externally | The worker emits claims and evidence; an independent gate writes the binding verdict. | Select |
| 9 | Lock Progress Forward | Validated changes ratchet into shared state; reversal is explicit, justified, and recorded. | Select |
| 10 | Extract Learnings | Capture decisions, patterns, surprises, and failed attempts with provenance before the session disappears. | Adapt |
| 11 | Compound Knowledge | Gate, inject, cite, refresh, and decay learnings so future sessions start smarter. | Adapt |
| 12 | Supervise Hierarchically | Give every worker one escalation path; supervisors reassign, reframe, or escalate with authority. | Adapt |

## Grouping
The groups are **Aim -> Bound -> Select -> Adapt**.

**Aim (1-3)** establishes the reference signal and the state surface. Fitness comes first because "relevant context," "minimum privilege," "valid evidence," and "progress" are undefined until the goal, budget, risk boundary, and stop condition are explicit. Durable state belongs here, not after validation, because issue state, research notes, permission decisions, handoffs, evidence, and failed attempts must survive before they are promoted.

**Bound (4-6)** constrains the actor before mutation. Scope precedes permission because least privilege is only meaningful relative to a job. Research follows both: once the actor is scoped and bounded, it can inspect the existing system and choose an approach that fits.

**Select (7-9)** separates attempts from accepted state. Isolation makes concurrent attempts independent and attributable; validation decides which claims survive; the ratchet makes accepted work stable enough for the next agent to trust.

**Adapt (10-12)** closes the loop and scales it. Extraction captures what the run taught, compounding injects governed knowledge into the next run, and hierarchy handles retries, escalation, and coordination when many loops run at once. Measurement is not lost at the end: the runtime signals from validation, ratchets, citations, cost, and intervention feed back into Factor 1 for the next pass.

## What changed vs the current set & why
Added **Enforce Least Privilege** as a first-class factor. Security, permissions, sandboxing, prompt-injection resistance, secrets hygiene, and blast-radius control are prerequisites for write-capable agents, not footnotes under validation.

Recast **Measure What Matters** as **Set the Fitness Function** and placed it first. Claude and Gemini were right that measurement is governance feedback, but the stronger primitive is the control-loop reference signal: before any agent acts, the system must know what counts as better, what risk is acceptable, what evidence will prove progress, and when to stop. The feedback role remains by looping runtime measurements back into Factor 1.

Kept **Track Durable State** early. Claude's "persist after validation" position correctly protects trusted shared state, but it conflates recording with promotion. Git-indexed state is needed before validation for issues, constraints, research findings, evidence, handoffs, and negative results; ratcheting later decides what becomes accepted shared progress.

Placed **Isolate Workers** in the selection phase, before validation and ratcheting. Gemini was right that isolation matters most at fleet scale, but the dependency is execution-time: without isolated workspaces and contexts, claims are contaminated and verdicts are hard to trust. Fleet governance builds on isolation; it does not create it.

Merged **Harvest Failures as Wisdom** into **Extract Learnings** plus **Compound Knowledge**. Negative knowledge is crucial, but its mechanisms are capture, gate, inject, cite, and decay. That is the knowledge loop applied to failed attempts, not a separate primitive.

Renamed and tightened several factors to remove the audited overclaims: no invented context thresholds, no pseudo-math, no absolutist research rule, no raw-git merge fantasy for structured data, no "zero shared mutable state" without the working-state qualifier, and no deterministic OTP analogy for stochastic agents.

## Open disagreements with the other two proposals
No remaining structural disagreement from my side. The converged landing chooses: fitness first, git-indexed durable state early, isolation before validation as part of selection, and four control-loop groups named **Aim**, **Bound**, **Select**, and **Adapt**.
