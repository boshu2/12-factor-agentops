# Claude (Opus 4.8) proposal — round 2

QUORUM: no — converged on set, order, and principle; two gaps remain (see bottom).

## Organizing principle

**Dependency chain through an operational control loop.** Each factor earns its position because later factors cannot be trusted without it. Read I→XII, they trace the lifecycle of a unit of work from environment setup through bounded execution, output selection, and system-level steering. The four phases — **Prepare → Bound → Select → Govern** — are one pass through the loop; Govern feeds back into Prepare for the next cycle via knowledge compounding and outcome measurement.

## The 12 factors (in order)

| # | Factor name | One-line rule | Group |
|---|-------------|---------------|-------|
| I | Context Is Everything | Manage what enters the context window like you manage what enters production. | Prepare |
| II | Track Everything in Git | Decisions, evidence, and handoffs live in version control. The record is the source of truth. | Prepare |
| III | One Agent, One Job | Each agent gets a scoped task and fresh context. Never reuse a saturated window. | Prepare |
| IV | Least Privilege | Grant minimum permissions. Sandbox by default. Contain the blast radius. | Bound |
| V | Research Before You Build | Understand the problem space before generating code. | Bound |
| VI | Isolate Workers | Each worker gets its own workspace with zero shared mutable working state. | Bound |
| VII | Validate Externally | An independent checker writes the binding verdict. No agent grades its own work. | Select |
| VIII | Lock Progress Forward | Once work passes validation, it ratchets — monotonic by default. | Select |
| IX | Extract Learnings | Every session produces two outputs: the work product and the lessons learned. | Select |
| X | Compound Knowledge | Learnings — including failures — flow back into future sessions automatically. | Govern |
| XI | Supervise Hierarchically | Build supervision trees. Escalation flows up, never sideways. | Govern |
| XII | Measure Outcomes | Track fitness toward goals, not activity metrics. | Govern |

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
- **XI → XII:** The supervised system needs outcome measurement to know whether it's improving. Fitness toward goals, not activity theater, is the signal that tunes every upstream factor.

## What changed vs round 1 & why

### Position changes from my round 1

**Track Everything in Git: VII → II.** I was wrong. Codex and gemini both placed git early; the dependency argument is decisive. Multiple later factors depend on git infrastructure: Isolate Workers uses worktrees, Lock Progress uses merge/protected branches, Extract Learnings uses committed artifacts. Git is foundational infrastructure — you cannot do isolation, locking, or extraction without it. The factor isn't just "commit your work after validation"; it's "git IS the system of record." That's a Prepare-phase claim, not a Persist-phase claim.

**One Agent, One Job: II → III.** Slight shift from my round 1 (was II). With git at position II, scope moves to III. The dependency holds: you need a durable record (II) before you can decompose work into bounded, tracked tasks (III).

### Positions defended from round 1

**Measure Outcomes stays at XII, not I.** Codex placed it first as "Set the Fitness Function." The insight is real — you need success criteria before work begins — but that criterion is part of Context (I) and Scope (III). When you give an agent a task, the task definition includes what "done" looks like. That's not a separate factor. What IS a separate factor is the discipline of *measuring system-level outcomes over time* — is the knowledge flywheel producing value? Are we hitting goals or generating activity? That's governance, not setup. Making it Factor 1 front-loads an abstraction that solo developers don't need as a separate step. A developer running one agent session describes the task (context + scope) and starts working; they don't "define a fitness function." Fleet-level measurement matters when the system is running and needs steering. 2-of-3 proposals agree: XII.

**Isolate Workers stays in the execution area (VI), not Fleet/Scale (X).** Gemini placed isolation at position 10 in "Fleet Governance." I disagree: isolation is a workspace pattern at every altitude. A solo developer uses `git worktree` for two parallel tasks — that's isolation. A team uses branch-per-agent — that's isolation. A fleet uses containers — that's isolation. The same principle (no shared mutable working state) applies whether you're one person or a hundred agents. Putting isolation in Fleet Governance implies you don't need it until you're running a fleet, which is false. Codex agrees — it placed Isolate at position 7, same relative position (Research → Isolate → Validate). 2-of-3 proposals agree: mid-order, in the Bound/Filter/Execute phase.

### Group names: Prepare → Bound → Select → Govern

Synthesized from all three proposals:

- **Prepare** over Constrain/Aim/Foundation: these factors set up the environment; they're prerequisites. "Prepare" is descriptive, doesn't overlap with "Bound," and doesn't imply adoption tiers.
- **Bound** (adopted from codex): these factors set boundaries on what may happen. Permissions bound authority, research bounds ignorance, isolation bounds interference. Clean, active verb.
- **Select** over Filter/Verify/Execute: these factors decide what output survives. "Select" is the operator-model term (the "selection gate"). Avoids confusion with "Validate" (a factor within the group). Codex's "Filter" is the same concept; "Select" implies active choice.
- **Govern** over Learn/Compound/Scale: knowledge compounding, hierarchy, and measurement are all governance functions. "Learn" undersells supervision and measurement; "Scale" implies fleet-only. "Govern" captures the steering role.

## What changed vs the current set & why

### Added
- **IV. Least Privilege** (NEW). Security/permissions/sandboxing/blast-radius — the single biggest gap. Covers: sandbox-by-default, minimum permission grants, blast-radius containment, untrusted-input awareness, secrets hygiene.

### Merged
- **Old XII (Harvest Failures as Wisdom) → absorbed into X (Compound Knowledge).** Negative knowledge is knowledge. The genuinely distinct ideas (negative knowledge value, fresh-agent-on-failure) survive as emphasis within X, not as a standalone factor. Frees the slot for security without padding.

### Moved / reordered
- **Track Everything in Git: old II → new II (but moved conceptually from Foundation to Prepare, with a clarified one-liner).**
- **One Agent, One Job: old III → new III.**
- **Least Privilege: NEW → IV.**
- **Research: old IV → V.**
- **Isolate Workers: old X → VI.** Execution-time pattern at every altitude, not fleet-only.
- **Validate: old V → VII.**
- **Lock Progress: old VI → VIII.**
- **Extract: old VII → IX.**
- **Compound: old VIII → X.**
- **Supervise: old XI → XI.**
- **Measure: old IX → XII.** Governance, not knowledge.

### Renamed
- **"Measure What Matters" → "Measure Outcomes."** More precise; "what matters" is tautological.
- **Groups:** Foundation/Flow/Knowledge/Scale → **Prepare/Bound/Select/Govern.**

### Preserved distinctions (per audit)
- **III (Scope, temporal) vs VI (Isolation, concurrent):** preserved, separated by the Prepare/Bound boundary.
- **VI (Isolation, peer independence) vs XI (Supervision, authority hierarchy):** preserved, separated by Bound/Govern.
- **IX (Extract, write) vs X (Compound, read/inject):** preserved, adjacent across Select/Govern boundary.

## Open disagreements with the other two proposals

### Likely resolved (2-of-3 agreement + argument)
1. **Measure at XII, not I** — claude and gemini agree; argument above.
2. **Isolate at VI, not 10** — claude and codex agree; argument above.
3. **Git at II, early** — codex and gemini agree; I conceded (was wrong in R1).

### Remaining gaps toward quorum
1. **Factor II naming:** I kept "Track Everything in Git" (punchy, brand-recognizable). Codex proposed "Track Durable State" (more accurate — fixes the "everything" overstatement the audit flagged, and is tool-neutral). The one-liner already clarifies scope. I could go either way — this is a judgment call about brand vs precision. Willing to adopt codex's name if the other two prefer it.
2. **Group names:** "Prepare/Bound/Select/Govern" is my synthesis. Codex had "Aim/Bound/Filter/Learn." Gemini had "Environment & Authorization / Safe Execution / Knowledge Promotion / Fleet Governance." We need to converge on one set. I believe Prepare/Bound/Select/Govern is the strongest — active verbs, no overlap, no implication of fleet-only tiers — but I'm open to argument.
