# Gemini 3.5 Flash proposal — round 1

## Organizing principle
The 12 factors are organized by **The Operational Lifecycle of Bounded Autonomy**, a logical dependency chain tracing a run from initialization to scaling. An agentic system must first configure its environment and authorization boundaries (Tier 1), formulate plans and execute them safely (Tier 2), capture and feed back insights from those runs (Tier 3), and finally scale to coordinated multi-agent fleets (Tier 4). Each tier establishes the structural prerequisites for the next, moving from the setup of a single actor to the governance of a fleet.

## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
|---|---|---|---|
| 1 | **Context Is Everything** | Load only relevant context; avoid attention-diluting slop. | Environment & Authorization |
| 2 | **Track Everything in Git** | Version all state changes; establish a clear path of reversion and recovery. | Environment & Authorization |
| 3 | **One Agent, One Job** | Limit execution scope to a single task; compose specialists rather than generalists. | Environment & Authorization |
| 4 | **Enforce Least Privilege** | Run workers in restricted environments; validate authorization boundaries before executing write actions. | Environment & Authorization |
| 5 | **Research Before You Build** | Verify assumptions and map dependencies before modifying code. | Safe Execution |
| 6 | **Validate Externally** | Never let an agent grade its own work; run external test gates to verify correctness. | Safe Execution |
| 7 | **Lock Progress Forward** | Commit verified checkpoints; never regress past a cleared gate. | Safe Execution |
| 8 | **Extract Learnings** | Document every completion and failure; record insights as durable trace history. | Knowledge Promotion |
| 9 | **Compound Knowledge** | Feed positive patterns and negative warnings back into the agent context; run a continuous improvement loop. | Knowledge Promotion |
| 10 | **Isolate Workers** | Provide isolated environments for concurrent agents; prevent shared mutable working state. | Fleet Governance |
| 11 | **Supervise Hierarchically** | Orchestrate agents through a clear delegation chain; separate workers from supervisors. | Fleet Governance |
| 12 | **Measure What Matters** | Monitor fleet performance against business outcomes; avoid activity metrics. | Fleet Governance |

## Grouping
The factors are organized into four sequential tiers based on the **Operational Lifecycle**:
1. **Environment & Authorization (Factors 1–4):** Prepares the stateful environment, defines the temporary actor, and establishes security and permission boundaries before execution begins.
2. **Safe Execution (Factors 5–7):** Covers the active mutation phase. Agents plan, modify state, and run selection gates to lock in progress and ensure correctness.
3. **Knowledge Promotion (Factors 8–9):** Captures traces from completions and failures, promoting them into reusable context for subsequent sessions.
4. **Fleet Governance (Factors 10–12):** Controls scale, ensuring concurrency safety, explicit supervisor-worker hierarchies, and metric-driven alignment with business goals.

Each group builds on the previous one. A fleet cannot be governed (Tier 4) without a system for compounding learnings (Tier 3), which itself requires verified execution (Tier 2) running inside a secure, versioned context (Tier 1).

## What changed vs the current set & why
- **Added Security/Permissions as Factor 4 (Enforce Least Privilege):** Addressed the critical gap in the original set. Agents with write access must operate under least privilege, using sandboxes, token constraints, and input sanitization to limit the blast radius of prompt injections or malicious inputs.
- **Merged Factor XII (Harvest Failures) into Factor IX (now Factor 9: Compound Knowledge):** Factor XII was redundant with Factor VIII; both are promotion loops. Merging them produces a single, robust "Compound Knowledge" factor that handles both positive patterns and negative warnings (failures as data).
- **Moved Factor IX (Measure What Matters) to Factor 12 (Fleet Governance):** Originally mis-tiered in "Knowledge", metrics are a fleet-level governance and feedback mechanism, not a repository of learning.
- **Removed pseudo-math, invented numbers, and absolutism:**
  - *Context Is Everything:* Removed the arbitrary "40% utilization rule" and qualified "lost in the middle" as a training tendency rather than a universal law.
  - *Track Everything in Git:* Clarified git-merge limitations for structured data, and specified that git tracks code and reference hashes, while massive/binary assets are placed in designated storage.
  - *One Agent, One Job:* Removed the arbitrary "50-exchange / 70%" threshold limits.
  - *Research Before You Build:* Softened the absolutist "always / no exceptions" tone.
  - *Validate Externally:* Refined the "single-writer" separation, acknowledging worker-authored tests (TDD) as a useful but weaker self-authored gate, while external validation remains the binding verdict.
  - *Lock Progress Forward:* Fixed the objective bug cross-referencing Factor III (now points to Factor 6: Validate Externally) and toned down "perfect filters."
  - *Compound Knowledge:* Eliminated the dimensionally incoherent `retrieval x citation > decay` formula.
  - *Isolate Workers:* Softened "zero shared mutable state" to "no shared mutable *working* state," acknowledging that the task tracker or Git repository are inherently shared but should not be written to concurrently by active workers.
  - *Supervise Hierarchically:* Corrected links to external frameworks, removed the claim that root supervisors never crash, and adjusted the Erlang/OTP analogy to reflect the stochastic nature of agent recovery rather than deterministic process restarts.

## Open disagreements with the other two proposals
None yet. This is Round 1, derived independently.
