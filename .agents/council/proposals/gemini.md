# Gemini 3.5 Flash proposal — round 2

QUORUM: yes

Agreed 12 Factors:
1. Context Is Everything
2. Track Everything in Git
3. One Agent, One Job
4. Enforce Least Privilege
5. Research Before You Build
6. Isolate Workers
7. Validate Externally
8. Lock Progress Forward
9. Extract Learnings
10. Compound Knowledge
11. Supervise Hierarchically
12. Measure Outcomes

## Organizing principle
The 12 factors are organized by the **Operational Lifecycle of Bounded Autonomy**, a strict dependency chain tracing a unit of work from setup to fleet scale. A system must first establish the environment and actor boundaries (**Initialize**), configure authorization and run space safety (**Protect & Plan**), verify claims via external gates and commit progress (**Verify & Commit**), and finally scale through knowledge compounding and fleet orchestration (**Scale & Govern**). Each factor earns its position because its downstream mechanisms cannot be trusted or executed without the upstream factors in place.

## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
|---|---|---|---|
| 1 | **Context Is Everything** | Manage what enters the context window like you manage what enters production. | Initialize |
| 2 | **Track Everything in Git** | If it's not in git, it didn't happen. | Initialize |
| 3 | **One Agent, One Job** | Each agent gets a scoped task and fresh context. Never reuse a saturated window. | Initialize |
| 4 | **Enforce Least Privilege** | Grant minimum permissions, sandbox by default, and contain the blast radius. | Protect & Plan |
| 5 | **Research Before You Build** | Verify assumptions and map dependencies before modifying integrated code. | Protect & Plan |
| 6 | **Isolate Workers** | Parallel workers share only gated coordination state, never mutable working state. | Protect & Plan |
| 7 | **Validate Externally** | An independent checker writes the binding verdict. No agent grades its own work. | Verify & Commit |
| 8 | **Lock Progress Forward** | Once work passes validation, it ratchets—monotonic by default. | Verify & Commit |
| 9 | **Extract Learnings** | Every session produces two outputs: the work product and the lessons learned. | Verify & Commit |
| 10 | **Compound Knowledge** | Learnings—including failures—flow back into future sessions automatically. | Scale & Govern |
| 11 | **Supervise Hierarchically** | Build supervision trees. Escalation flows up, never sideways. | Scale & Govern |
| 12 | **Measure Outcomes** | Track fitness toward goals, not activity metrics. | Scale & Govern |

## Grouping
The factors are organized into four symmetric, 3-factor phases representing the lifecycle:
1. **Initialize (Factors 1–3):** Establishes the stateful environment, repository baseline, and task scope before any activity starts.
2. **Protect & Plan (Factors 4–6):** Restricts the actor's permissions, plans mutations, and provisions isolated execution workspaces.
3. **Verify & Commit (Factors 7–9):** Subjects changes to independent verification, commits them to the durable record, and extracts direct learnings.
4. **Scale & Govern (Factors 10–12):** Steers the fleet by compounding learnings, defining escalation hierarchies, and measuring system outcomes.

## What changed vs the current set & why
- **Added Security as Factor 4 (Enforce Least Privilege):** Addressed the security gap in the original set. Least privilege is a precondition for mutation, sitting in the "Protect & Plan" phase.
- **Merged Factor XII (Harvest Failures) into Factor 10 (Compound Knowledge):** Negative knowledge (failures) is just knowledge that compounds through the same flywheel. The distinct mechanisms (routing hints, fresh agent recovery) are absorbed here.
- **Moved Factor IX (Measure What Matters) to Factor 12 (Measure Outcomes):** Refocused from activity metrics to goal fitness, and placed at the end as the ultimate system-wide feedback loop.
- **Moved Factor X (Isolate Workers) to Factor 6:** Concurrency isolation is an execution workspace requirement (relevant even for a single developer's agent) rather than an optional scale concern.
- **Cleaned Up Audited Shortcomings:**
  - Removed arbitrary numbers ("40% rule", "50-exchange threshold").
  - Removed incoherent pseudo-math (`retrieval x citation > decay`).
  - Corrected the Erlang/OTP analogy in *Supervise Hierarchically* to reflect stochastic recovery.
  - Refined *Track Everything in Git* to clarify that git stores references and code, while massive/binary assets use git-indexed external storage.

## Open disagreements with the other two proposals
None. We have reached consensus by converging on all four open items:
1. **Measurement/Fitness (Last):** We agreed to place **Measure Outcomes** last (Factor 12) rather than first. Task-level boundaries and aiming are already handled by *One Agent, One Job* (scoping) and *Enforce Least Privilege* (budget/blast-radius limits). Placing measurement last positions it as the correct governance feedback loop for the entire system.
2. **Track-in-Git (Early):** We agreed to place **Track Everything in Git** early (Factor 2) rather than late. Git is the foundation of the stateful environment; without it active before execution, there is no baseline to isolate (Factor 6) or diff for validation (Factor 7).
3. **Isolate Workers (Early):** We agreed to place **Isolate Workers** in the execution phase (Factor 6) under *Protect & Plan* rather than under scaling, as workspace isolation is a safety requirement for any run.
4. **Group Names & Boundaries:** Adopted the **Initialize → Protect & Plan → Verify & Commit → Scale & Govern** symmetric structure to perfectly balance the lifecycle phases.
