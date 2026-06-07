# Gemini 3.5 Flash proposal — round 3

QUORUM: yes

Agreed 12 Factors:
1. Context Is Everything
2. Track Durable State
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
The 12 factors are organized by the **Operational Lifecycle of Bounded Autonomy**, a closed control loop representing the dependency chain of a unit of work from preparation to governance feedback. Each factor is positioned such that downstream stages cannot be safely executed, verified, or measured without the upstream factors in place. The four symmetric phases — **Prepare → Bound → Select → Govern** — represent one complete pass through this control loop, where the final governance signals feed back to optimize preparation for the next cycle.

## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
|---|---|---|---|
| 1 | **Context Is Everything** | Manage what enters the context window like you manage what enters production. | Prepare |
| 2 | **Track Durable State** | Decisions, evidence, and handoffs live in version-control or a git-indexed record. | Prepare |
| 3 | **One Agent, One Job** | Each agent gets a scoped task and fresh context. Never reuse a saturated window. | Prepare |
| 4 | **Enforce Least Privilege** | Grant minimum permissions, sandbox by default, and contain the blast radius. | Bound |
| 5 | **Research Before You Build** | Verify assumptions and map dependencies before modifying integrated code. | Bound |
| 6 | **Isolate Workers** | Parallel workers share only gated coordination state, never mutable working state. | Bound |
| 7 | **Validate Externally** | An independent checker writes the binding verdict. No agent grades its own work. | Select |
| 8 | **Lock Progress Forward** | Once work passes validation, it ratchets—monotonic by default. | Select |
| 9 | **Extract Learnings** | Every session produces two outputs: the work product and the lessons learned. | Select |
| 10 | **Compound Knowledge** | Learnings—including failures—flow back into future sessions automatically. | Govern |
| 11 | **Supervise Hierarchically** | Build supervision trees. Escalation flows up, never sideways. | Govern |
| 12 | **Measure Outcomes** | Track fitness toward goals, not activity metrics. | Govern |

## Grouping
The factors are organized into four symmetric, 3-factor phases of the operational control loop:
1. **Prepare (Factors 1–3):** Establishes the context, versioned baseline, and task scope before execution.
2. **Bound (Factors 4–6):** Restricts permissions, plans mutations, and provisions isolated workspaces.
3. **Select (Factors 7–9):** Subjects work to external selection gates, ratchets validated progress, and extracts direct learnings.
4. **Govern (Factors 10–12):** Steers the fleet via knowledge compounding, orchestration hierarchies, and ongoing outcome measurement.

---

## Resolution of Final Structural Disagreements & Naming Differences

### 1. The Measurement Factor: Last (Measure Outcomes) vs. First (Set the Fitness Function)
We have resolved the measurement placement by positioning **Measure Outcomes** at **XII (Last)**. 
- *The Closed Loop:* Upfront target setting (budget, goal, risk boundaries) for a single run and ongoing outcome measurement are the front and back of the same control loop.
- *Redundancy Resolution:* At the start of a single task, defining the goal and budget is already structurally handled by **One Agent, One Job** (task scoping) and **Enforce Least Privilege** (setting permission/resource limits). Separating this into a first factor is redundant.
- *Governance Capstone:* Conversely, ongoing measurement of fleet-wide metrics (intervention rates, latency, regressions, prompt drift) is a distinct governance primitive that cannot be folded into task scoping. Placed last, it functions as the ultimate feedback loop that steers the system and informs how upstream factors are prepared for the next cycle.

### 2. Settle the 3 Naming Differences
- **Context Is Everything vs. Curate Context:** We converged on **Context Is Everything**. It is the iconic Factor I of the doctrine. While "Curate Context" represents the action, "Context Is Everything" remains the most memorable and punchy aphorism.
- **Track Everything in Git vs. Track Durable State:** We converged on **Track Durable State**. This is more precise and tool-neutral than "Track Everything in Git." It addresses the audit's warning against the overstatement of git's capacity to store massive databases or binaries directly, framing it instead as a version-control or git-indexed record.
- **Measure Outcomes vs. Set the Fitness Function:** Having agreed to place the factor last, we converged on **Measure Outcomes**. This reflects the governance and feedback function rather than the task-input setup phase.

### 3. Group Names & Boundaries
We converged on the symmetric **Prepare → Bound → Select → Govern** structure. 
- **Prepare** sets up the environment.
- **Bound** limits what may happen.
- **Select** (the operator-model "selection gate") determines what survives.
- **Govern** compounds knowledge and steers the entire system.
This avoids fleet-only connotations (like "Scale") or generic terms (like "Flow").
