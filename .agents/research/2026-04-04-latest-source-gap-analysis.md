---
id: research-2026-04-04-latest-source-gap-analysis
type: research
date: 2026-04-04
rig: 12factor
---

# Research: Latest Source Gap Analysis

**Repo root:** `/Users/fullerbt/gt/12factor`  
**Remote:** `git@github.com:boshu2/12-factor-agentops.git`  
**Branch analyzed:** `main` tracking `origin/main`  
**Sync check:** `git fetch --prune origin` + `rev-list --left-right --count HEAD...origin/main` => `0 0`

## Summary

The current `12factor` repo is already on a newer doctrine than the AgentOps positioning docs I was looking at earlier. It has already pivoted to v3:

- operational discipline, not validation-only
- knowledge compounding as the hero
- solo-first adoption path
- scale factors explicitly optional
- AgentOps plugin framed as reference implementation, not prerequisite

So the work here is **not** "port AgentOps repo wording into 12factor." The real work is a narrower delta:

1. preserve the strong v3 factor-first framing
2. integrate the newer control-plane/operator-model lessons where they are missing
3. make the relationship between the 12 factors and the underlying operator mechanics more explicit

## What I Verified

### The source of truth is the local `12factor` repo

This is the actual latest source I should analyze:

- `/Users/fullerbt/gt/12factor`
- `origin/main` points to `git@github.com:boshu2/12-factor-agentops.git`
- local `main` is clean and exactly in sync with `origin/main`

No separate newer upstream branch exists in this clone right now.

### The repo already completed the v3 pivot

The strongest evidence is in:

- `README.md`
- `factors/README.md`
- `docs/plans/2026-02-15-pivot-design.md`
- `.agents/research/2026-02-15-v3-docs-rewrite-inventory.md`

Current repo claims are:

- "The Operational Discipline for Working With AI Agents"
- "The model isn't the problem. The operations are."
- knowledge compounding as the core differentiator
- 4 tiers: Foundation, Workflow, Knowledge, Scale
- "without tooling" paths for practical adoption

This means the repo is already beyond the old "shift-left validation for coding agents" slice.

## What Is Strong Already

### 1. The top-level README is directionally right

`README.md` is already results-first, operational, and portable:

- solo developer entry point
- institutional memory/compounding hook
- plugin as optional reference implementation
- factor tiers that justify escalation

### 2. Factor VIII is already correctly treated as the hero

`factors/08-compound-knowledge.md` is the strongest current factor because it makes the flywheel explicit:

- extract
- gate
- store
- inject
- cite
- decay

That is already close to the newer environment-as-intelligence view.

### 3. The repo is already broader than coding-only

Unlike the AgentOps repo, this repo is intentionally the broader doctrine layer for "working with AI agents," not just coding-agent lifecycle tooling.

That broader scope should remain.

## What Is Missing

### 1. The operator-model compression is mostly implicit, not explicit

The current repo explains the factors well, but it does **not** currently compress them into the newer operator primitives:

- fitness gradient
- stateful environment
- replaceable actors
- stigmergic traces
- selection gates
- evolutionary promotion
- governance

Search evidence:

- `operator_model_hits=0`
- `stateful_env_hits=0`
- `control_plane_hits=7` but mostly in explanatory/heritage docs, not in the core doctrine surfaces

The repo has the pieces. It does not yet state the compression cleanly.

### 2. "Environment carries continuity" is still under-expressed in core surfaces

The repo strongly describes:

- context discipline
- git-backed continuity
- external validation
- knowledge compounding

But the specific insight that **the environment carries memory, coordination, trust, and adaptation while actors stay replaceable** is not explicit in the main surfaces.

This matters because it explains why the factors hang together as one system instead of twelve good habits.

### 3. Selection gates and governance are present but not surfaced as first-class doctrine

Factor V covers external validation well. But the broader idea of **selection gates** as the mechanism that decides what survives is still dispersed across:

- validation
- checkpointing
- review
- decay
- failure harvesting

Likewise governance exists in pieces, but not as a clearly named cross-cutting mechanism:

- human review
- boundaries
- optionality
- hierarchical supervision

The doctrine would get sharper if these became more explicit.

### 4. Provenance is present, but promotion is not clearly named as a general mechanism

The repo already talks about:

- git as memory
- citations
- audit trails
- harvested failures

But the broader promotion loop is hidden inside the knowledge flywheel instead of explained as a reusable control-plane mechanism:

- raw trace
- validated learning
- reusable pattern
- preventive rule

That promotion ladder should be made more visible.

## What Should Change

### A. Do not rewrite the repo around the AgentOps three-gap contract

This is the main trap.

The `12factor` repo should **not** be flattened into:

- judgment validation
- durable learning
- loop closure

Those are excellent product-contract terms for AgentOps. But `12factor` is a broader doctrine repo. It should stay factor-first and principle-first.

Instead, the right move is:

- keep the 12 factors as the public organizing surface
- add an explicit operator-model crosswalk underneath them

### B. Add one explicit "operator model" document and map the factors to it

Highest-leverage change:

- add a new explanatory doc under `docs/explanation/` or `docs/principles/`
- title shape: "The Operator Model Behind the 12 Factors" or similar

That doc should explain:

- the environment is the intelligence substrate
- workers are replaceable
- traces coordinate behavior across sessions
- gates select what survives
- promotion loops make future sessions better
- governance sets objective and boundaries

Then map each factor to those primitives.

This gives the repo a strong conceptual compression without rewriting all factor names.

### C. Update README and factor index to expose that crosswalk

The core README likely needs only a small addition:

- one short section after "Why These Factors?" or before "Reference Implementation"
- explain that the twelve factors are the public operating rules and the operator model is the system-level compression underneath them

`factors/README.md` should likely gain:

- a short table: factor -> primary operator mechanism

### D. Tighten the most central factor docs with the new language

The factors most likely worth touching first are:

- `factors/01-context-is-everything.md`
- `factors/05-validate-externally.md`
- `factors/08-compound-knowledge.md`
- `factors/12-harvest-failures-as-wisdom.md`

Why these four:

- I = stateful environment / bounded activation
- V = selection gates / governance
- VIII = promotion loops / compounding substrate
- XII = negative knowledge / stigmergic traces / evolutionary adaptation

These already contain the right ideas; they need better compression, not replacement.

### E. Defer broad doc sweeps until the new crosswalk is settled

There are many files in `docs/` that could eventually reflect the new lessons. Do not start there.

Settle first:

1. operator-model crosswalk doc
2. README touch-up
3. factors index touch-up
4. 4 factor docs

Only then decide whether explanation/reference/tutorial docs need secondary alignment.

## Concrete Change Set

### Phase 1: Doctrine anchor

- Add operator-model explainer doc
- Update `README.md`
- Update `factors/README.md`

### Phase 2: Core factor compression

- Update Factor I
- Update Factor V
- Update Factor VIII
- Update Factor XII

### Phase 3: Secondary alignment

- Review `docs/principles/comparison-table.md`
- Review `docs/explanation/from-theory-to-production.md`
- Review `docs/principles/evolution-of-12-factor.md`

These are the most likely secondary docs to need crosswalk updates once the doctrine anchor exists.

## Recommended Planning Rules

If this becomes an implementation epic, hold these constraints:

1. Keep the 12 factors as the primary public surface.
2. Do not port AgentOps product language over wholesale.
3. Add a crosswalk, not a replacement.
4. Prefer conceptual compression over repo-wide copy churn.
5. Touch core doctrine surfaces first, explanation surfaces second.

## Bottom Line

The latest source is:

- `/Users/fullerbt/gt/12factor`
- synced to `origin/main`

What needs to change is **not** a top-to-bottom rewrite.

The repo is already on the right side of the big pivot. The next step is to make the deeper operator logic explicit:

- environment carries continuity
- actors are replaceable
- traces coordinate work
- gates decide survival
- promotion loops compound intelligence
- governance bounds the system

That should be added as the compression layer beneath the existing twelve factors, not as a replacement for them.
