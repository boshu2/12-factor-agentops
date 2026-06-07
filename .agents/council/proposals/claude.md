# Claude (Opus 4.8) proposal — round 1

QUORUM: no — round 1, independent derivation; have not read codex or gemini proposals.

## Organizing principle

**Dependency chain as lifecycle.** The factors follow a strict dependency order: each factor earns its position because you cannot do it well without the ones before it. Read I→XII, they trace the lifecycle of a unit of work — from constraining the agent before it acts, through executing the work, persisting the outputs, and governing the system's trajectory. The four groups are phases of this lifecycle, not independent tiers or a maturity ladder.

## The 12 factors (in order)

| # | Factor name | One-line rule | Group |
|---|-------------|---------------|-------|
| I | Context Is Everything | Manage what enters the context window like you manage what enters production. | Constrain |
| II | One Agent, One Job | Each agent gets a scoped task and fresh context. Never reuse a saturated window. | Constrain |
| III | Least Privilege | Grant minimum permissions. Sandbox by default. Contain the blast radius. | Constrain |
| IV | Research Before You Build | Understand the problem space before generating code. | Execute |
| V | Isolate Workers | Each worker gets its own workspace with zero shared mutable working state. | Execute |
| VI | Validate Externally | An independent checker writes the binding verdict. No agent grades its own work. | Execute |
| VII | Track Everything in Git | If it's not in git, it didn't happen. | Persist |
| VIII | Lock Progress Forward | Once work passes validation, it ratchets — monotonic by default. | Persist |
| IX | Extract Learnings | Every session produces two outputs: the work product and the lessons learned. | Persist |
| X | Compound Knowledge | Learnings — including failures — flow back into future sessions automatically. | Govern |
| XI | Supervise Hierarchically | Build supervision trees. Escalation flows up, never sideways. | Govern |
| XII | Measure Outcomes | Track fitness toward goals, not activity metrics. | Govern |

## Grouping

Four phases, three factors each. The organizing principle is the **lifecycle of a unit of work through the system**, ordered by dependency:

### Constrain (I–III): What must be true before the agent acts?

These are preconditions. Get them wrong and nothing downstream is reliable.

- **I → II dependency:** Context discipline is the insight; scoping is how you implement it. You can't keep context focused without bounded tasks.
- **II → III dependency:** Once you know what the agent *does* (scope), you must bound what it's *allowed to do* (permissions). Least privilege requires knowing the scope first.

### Execute (IV–VI): How does work flow through the agent?

These govern the actual work, assuming constraints are set.

- **III → IV:** With boundaries set, the first productive act is research — understand before building.
- **IV → V:** Research informs the work plan; isolation provides each worker a clean workspace to execute it without interference.
- **V → VI:** Isolated work produces artifacts that need an external verdict before they earn trust.

### Persist (VII–IX): How does work survive the session?

These capture value, assuming execution produced validated artifacts.

- **VI → VII:** Validated work goes into the durable record. Git is the system of record, not a scratchpad.
- **VII → VIII:** Tracked, validated work is locked against regression — progress is monotonic.
- **VIII → IX:** With progress locked, the session's lessons (not just its artifacts) are extracted for future use.

### Govern (X–XII): How does the system learn and steer?

These close the loop. They assume the persistence mechanisms exist and ask: is the whole system getting better?

- **IX → X:** Extracted learnings close the flywheel when injected into future sessions. Negative knowledge (failures, dead ends) compounds here too — it's not a separate factor, it's knowledge.
- **X → XI:** A compounding multi-agent system needs hierarchical authority to coordinate: who decides, who escalates, who restarts.
- **XI → XII:** The governed system needs outcome measurement to know whether it's actually improving — fitness toward goals, not activity theater.

### Why this order and not the current one

The current order (Foundation/Flow/Knowledge/Scale) is a **maturity ladder** — "start here, grow into this." That's a fine adoption guide but a bad organizing principle: it doesn't explain *why* Context comes before Git, or why Measure is in Knowledge instead of Scale. The factors feel interchangeable within tiers because the tiers are buckets, not phases.

The dependency chain fixes this. Every position is earned: you literally cannot Lock Progress (VIII) without Tracking (VII) without Validation (VI). The order is falsifiable — if you can show factor N works fine without N-1, the ordering claim is wrong and should be fixed. That's a real constraint on the structure, not a presentation choice.

## What changed vs the current set & why

### Added
- **III. Least Privilege** (NEW) — the single biggest gap flagged by the audit. A doctrine for operating write-capable agent fleets had zero coverage of permissions, sandboxing, blast radius, prompt injection defense, or secrets management. This is not optional — it's a precondition for safe execution, which is why it sits in Constrain before any work begins. Covers: sandbox-by-default, minimum permission grants, blast-radius containment, untrusted-input awareness, secrets hygiene.

### Merged
- **Old XII (Harvest Failures as Wisdom) → absorbed into X (Compound Knowledge).** The audit flagged this as "likely collapses into VIII." I agree: negative knowledge (failed approaches, dead ends, anti-patterns) is just knowledge that compounds through the same flywheel. "Prune the search space" is a metaphor, not a distinct mechanism. The genuinely distinct ideas — that negative knowledge is often more valuable than positive, and that fresh-agent-on-failure is the right recovery pattern — survive as emphasis within Factor X, not as a separate factor. This frees a slot for the security factor without padding.

### Moved / reordered
- **Old II (Track Everything in Git) → VII.** Git tracking moved from "foundation" to "persist." In the current set it sits at position 2 as infrastructure; in the dependency chain it belongs after validation (VI) — you track *validated* work in the durable record. Git is used throughout, but the *factor* (the discipline of "if it's not in git, it didn't happen") is about persistence, not setup.
- **Old III (One Agent, One Job) → II.** Slight promotion: scoping is the second constraint (after context), not the third foundation item. The dependency is tight — you can't manage context without bounded scope.
- **Old IX (Measure What Matters) → XII.** The audit correctly identified this as governance, not knowledge. It was "wedged into the Knowledge tier to fill 4×3." In the dependency chain it's the final feedback signal — the meta-level question "is the system actually improving?" — which makes it the natural capstone.
- **Old X (Isolate Workers) → V.** Isolation moved from the Scale tier (implying "only for fleets") to Execute. Solo developers use worktrees; isolation is an execution pattern at every altitude, not a scale concern.

### Renamed
- **"Measure What Matters" → "Measure Outcomes."** Slightly more precise; "what matters" is a tautology. Outcomes = fitness toward goals, which is the actual claim.
- **Group names:** Foundation/Flow/Knowledge/Scale → **Constrain/Execute/Persist/Govern.** Each name is a verb that states what the phase does, not a noun that labels a bucket.

### Preserved distinctions (per audit)
- **II (Scope, temporal) vs V (Isolation, concurrent):** One Agent One Job is about bounding a single agent's task over time; Isolate Workers is about preventing interference between concurrent agents. Same axis (independence), different dimensions. Both kept, separated by the Execute boundary.
- **V (Isolation, peer independence) vs XI (Supervision, authority hierarchy):** Isolation says peers don't interfere; supervision says authority flows up. Kept in different phases — execution vs governance.
- **IX (Extract, write) vs X (Compound, read/inject):** The write and read halves of the knowledge loop. Kept in adjacent phases (Persist → Govern) where the dependency is explicit.

## Open disagreements with the other two proposals

Round 1 — I have not read the codex or gemini proposals. No disagreements to report yet. Will engage in round 2.
