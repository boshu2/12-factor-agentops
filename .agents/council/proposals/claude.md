# Claude (Opus 4.8) proposal — round 3 (final)

QUORUM: yes

Agreed 12 factors:
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

**Dependency chain through an operational control loop.** Each factor earns its position because later factors cannot be trusted without it. Read I→XII, they trace the lifecycle of a unit of work from environment setup through bounded execution, output selection, and system-level steering. The four phases — **Prepare → Bound → Select → Govern** — are one pass through the loop; Govern feeds back into Prepare for the next cycle via knowledge compounding and outcome measurement.

## The 12 factors (in order)

| # | Factor name | One-line rule | Group |
|---|-------------|---------------|-------|
| I | Context Is Everything | Manage what enters the context window like you manage what enters production. | Prepare |
| II | Track Everything in Git | Decisions, evidence, and handoffs live in version control. The record is the source of truth. | Prepare |
| III | One Agent, One Job | Each agent gets a scoped task and fresh context. Never reuse a saturated window. | Prepare |
| IV | Enforce Least Privilege | Grant minimum permissions. Sandbox by default. Contain the blast radius. | Bound |
| V | Research Before You Build | Understand the problem space before generating code. | Bound |
| VI | Isolate Workers | Each worker gets its own workspace with zero shared mutable working state. | Bound |
| VII | Validate Externally | An independent checker writes the binding verdict. No agent grades its own work. | Select |
| VIII | Lock Progress Forward | Once work passes validation, it ratchets — monotonic by default. | Select |
| IX | Extract Learnings | Every session produces two outputs: the work product and the lessons learned. | Select |
| X | Compound Knowledge | Learnings — including failures — flow back into future sessions automatically. | Govern |
| XI | Supervise Hierarchically | Build supervision trees. Escalation flows up, never sideways. | Govern |
| XII | Measure Outcomes | Define what fitness means. Track outcomes toward goals, not activity metrics. | Govern |

## Grouping

Four phases, three factors each. One pass through the operational control loop:

### Prepare (I–III): Set up the environment

What must exist before any agent acts. These are prerequisites — get them wrong and nothing downstream is reliable.

- **I → II:** Context discipline requires a durable record to persist across sessions. Git is the backbone that makes context, handoffs, and evidence reviewable and recoverable.
- **II → III:** The versioned record enables bounded, scoped tasks. You decompose work into agent-sized units tracked against that record.

### Bound (IV–VI): Constrain what may act

Guardrails set before execution. These bound authority, ignorance, and interference.

- **III → IV:** Once you know what the agent does (scope), you bound what it's *allowed* to do. Least privilege requires knowing the scope first.
- **IV → V:** With authority bounded, the first productive act is research — understand before building. Research caps integration ignorance before any worker changes the world.
- **V → VI:** Research informs the plan; each worker gets an isolated workspace (worktree, container, sandbox) so parallel execution doesn't create invisible coupling.

### Select (VII–IX): Decide what survives

The selection gate. Work enters as claims; this phase decides what earns trust, gets locked, and yields lessons.

- **VI → VII:** Isolated work produces artifacts. An independent gate — not the worker — writes the binding verdict.
- **VII → VIII:** Validated work ratchets into shared state. Regression requires explicit, recorded reversal.
- **VIII → IX:** Locked progress is the substrate from which learnings are extracted — what worked, what failed, what the next session needs to know.

### Govern (X–XII): Steer the system

Close the loop. These assume persistence mechanisms exist and ask: is the whole system getting smarter?

- **IX → X:** Extracted learnings close the flywheel when gated, injected, cited, and decayed. Negative knowledge (failed approaches, dead ends) compounds here too — it's not a separate factor, it's knowledge.
- **X → XI:** A compounding multi-agent system needs hierarchical authority: who decides, who escalates, who restarts a failed worker. Supervision is the structural governance over coordination.
- **XI → XII:** The supervised system needs outcome measurement to know whether it's improving. Fitness toward goals, not activity theater, is the signal that tunes every upstream factor for the next pass through the loop.

## Resolution of the final disagreements

### Measurement placement: XII (last), not I (first)

This was the last structural disagreement. Codex argued for position I ("Set the Fitness Function"): define goal, budget, risk boundary, evidence, and stop condition before the agent starts, because every downstream gate consumes it. Claude and gemini argued for position XII ("Measure Outcomes"): system-level fitness tracking is governance feedback that closes the control loop.

**Resolution: "define the fitness target" and "measure outcomes over time" are the SAME factor — the front and back of one control loop.** In control theory, the setpoint (reference signal) and the sensor (measurement) are both parts of the same control mechanism. You cannot measure without a definition; the definition is dead without measurement. One discipline, two temporal aspects. The question reduces to: which placement makes the loop structure clearest?

**Position XII wins on three grounds:**

1. **Task-level fitness is already in Context + Scope.** When you give an agent a task, the task definition *includes* what success looks like — acceptance criteria, stop conditions, constraints. That's not a separate factor; it's how Context (I) and Scope (III) work well. You can't scope a bounded task without stating what "done" means. The fitness definition codex wants at position I is *embedded in the factors that are already there*, not missing from them.

2. **System-level fitness IS the distinct discipline.** The question that needs its own slot is: "is the overall system improving?" — goal completion rates, knowledge flywheel value, recurrence patterns, not token throughput or session counts. This is governance feedback that steers every upstream factor. That's position XII.

3. **Loop clarity.** Position XII makes the control loop explicit: I→XI produces and compounds work; XII measures whether the system is actually getting better; XII's signal feeds back into I (which context to load next cycle, which goals to pursue). Position I would collapse the loop — making the factor both the start and the feedback endpoint — which hides the signal path instead of revealing it.

**Honoring codex's insight:** The one-liner for XII now opens with "Define what fitness means" — the upfront definition is part of the discipline, not a separate factor. Codex was right that you need a reference signal; the resolution is that the reference signal lives inside Context/Scope for each task and inside Measure Outcomes for the system.

### Naming resolutions

**"Context Is Everything" over "Curate Context."** 2-of-3 used some form of the original name. "Context Is Everything" states the *insight* (context quality determines everything); "Curate" states the *action* (which belongs in the body). The name should grab you with the why; the body teaches the how. "Curate" also carries a slightly precious connotation; "Context Is Everything" is plain and direct.

**"Track Everything in Git" over "Track Durable State."** 2-of-3 kept the original name. "Track Everything in Git" is concrete, actionable, and memorable — it tells you exactly what to do. "Track Durable State" is accurate but abstract ("durable state" is engineering jargon). Git is not a vendor; it's universal infrastructure. Naming it is fine — the Heroku 12-factor names specific things too ("Codebase," "Backing Services"). The "everything" overstatement flagged by the audit is handled in the one-liner ("decisions, evidence, and handoffs") and the body (which clarifies git-indexed storage for large artifacts).

**"Measure Outcomes" over "Set the Fitness Function."** The placement at XII determines the name. "Measure Outcomes" describes what the factor asks you to DO at position XII: measure system-level fitness. "Set the Fitness Function" describes an upfront configuration step, which mismatches a governance-feedback position. The one-liner integrates codex's insight: "Define what fitness means. Track outcomes toward goals, not activity metrics." Both the definition and the measurement are covered.

**"Enforce Least Privilege"** — all three proposals converged on this or near-equivalent. "Enforce" adds the active verb that parallels most other factor names (Track, Research, Isolate, Validate, Lock, Extract, Compound, Supervise, Measure).

### Group names: Prepare → Bound → Select → Govern

- **Prepare** over Initialize/Aim: "prepare the environment" is descriptive, doesn't overlap with "Bound," and doesn't imply adoption tiers. "Aim" made sense when fitness was first; with fitness at XII, "Prepare" is more accurate. "Initialize" is slightly too technical.
- **Bound** (adopted from codex): permissions bound authority, research bounds ignorance, isolation bounds interference. Clean, active verb. 2-of-3 used this exact word.
- **Select** (adopted from codex): decides what output survives. The operator-model term for the selection gate. Avoids confusion with "Validate" (a factor within the group). 2-of-3 used this exact word.
- **Govern** over Adapt/Learn/Scale: captures all three factors — knowledge compounding (learning), supervision (authority), measurement (steering). "Adapt" undersells supervision; "Learn" undersells measurement; "Scale" implies fleet-only. "Govern" is comprehensive.

## What changed vs the current set & why

### Added
- **IV. Enforce Least Privilege** (NEW). Security/permissions/sandboxing/blast-radius — the single biggest gap. Covers: sandbox-by-default, minimum permission grants, blast-radius containment, untrusted-input awareness, secrets hygiene.

### Merged
- **Old XII (Harvest Failures as Wisdom) → absorbed into X (Compound Knowledge).** Negative knowledge is knowledge that compounds through the same flywheel. The genuinely distinct ideas (negative-knowledge value, fresh-agent-on-failure) survive as emphasis within X.

### Moved / reordered
- **Isolate Workers: old X → VI.** Execution-time workspace pattern at every altitude, not fleet-only.
- **Measure Outcomes: old IX → XII.** Governance feedback, not knowledge-tier filler.
- All other factors maintain their relative order from the current set; positions shift to accommodate the new security factor and the reordering of Isolate and Measure.

### Renamed
- **"Least Privilege" → "Enforce Least Privilege."** Active verb prefix.
- **"Measure What Matters" → "Measure Outcomes."** More precise; "what matters" is tautological.
- **Groups:** Foundation/Flow/Knowledge/Scale → **Prepare/Bound/Select/Govern.** Active verbs, one control-loop pass, no adoption-tier implication.

### Preserved distinctions (per audit)
- **III (Scope, temporal) vs VI (Isolation, concurrent):** separated by the Prepare/Bound boundary.
- **VI (Isolation, peer independence) vs XI (Supervision, authority hierarchy):** separated by Bound/Govern.
- **IX (Extract, write) vs X (Compound, read/inject):** adjacent across Select/Govern boundary.

## Open disagreements with the other two proposals

None. The structural questions are resolved:

1. **Measurement at XII** — all factors, all names, all positions match the gemini round 2 proposal exactly. Codex's round 2 differed only on measurement placement (I vs XII) and naming; the arguments above resolve both in favor of XII / "Measure Outcomes." Codex's genuine insight (you need a reference signal) is honored in the one-liner and distributed across Context + Scope + Measure Outcomes.

2. **Naming** — "Context Is Everything," "Track Everything in Git," and "Measure Outcomes" win on 2-of-3 preference, brand recognition, and placement-accuracy grounds. "Enforce Least Privilege" is unanimous.

3. **Group names** — Prepare/Bound/Select/Govern synthesizes the best elements from all three proposals, uses active verbs, avoids tier implications, and matches the control-loop principle.

The converged set matches the gemini round 2 proposal on all 12 factors, their order, and the 3-3-3-3 grouping. The only differences are group names (where I believe Prepare/Bound/Select/Govern is the strongest candidate) and minor one-liner wording — both of which are expression, not structure.
