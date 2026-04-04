---
id: research-2026-04-04-operator-model-phase-2-discovery
type: research
date: 2026-04-04
rig: 12factor
---

# Research: Operator-Model Phase 2 Discovery

## Objective

Identify the next focused enhancement wave for `12factor` after the operator-model doctrine pass, using:

- the current `12factor` repo as the doctrine surface
- the current `AgentOps` repo as the product/reference implementation surface
- the mined operator-kernel knowledge in `~/.agents`

This is not a request for a broad rewrite. It is a request for a narrower phase-2 refinement plan.

## Goal

Enhance the `12factor` doctrine after the operator-model pass by aligning the next refinement wave with the current `AgentOps` repo contract and the mined operator-kernel knowledge, without flattening `12factor` into AgentOps product language.

## Inputs Reviewed

### 12factor doctrine surfaces

- `README.md`
- `factors/README.md`
- `factors/01-context-is-everything.md`
- `factors/05-validate-externally.md`
- `factors/08-compound-knowledge.md`
- `factors/12-harvest-failures-as-wisdom.md`
- `docs/explanation/operator-model.md`
- `docs/principles/comparison-table.md`
- `docs/principles/evolution-of-12-factor.md`
- `docs/explanation/from-theory-to-production.md`

### AgentOps repo contract surfaces

- `/Users/fullerbt/gt/agentops/crew/nami/README.md`
- `/Users/fullerbt/gt/agentops/crew/nami/PRODUCT.md`
- `/Users/fullerbt/gt/agentops/crew/nami/docs/context-lifecycle.md`
- `/Users/fullerbt/gt/agentops/crew/nami/docs/software-factory.md`
- `/Users/fullerbt/gt/agentops/crew/nami/docs/agentops-brief.md`

### Mined operator-kernel knowledge

- `/Users/fullerbt/.agents/knowledge/operator-model.md`
- `/Users/fullerbt/.agents/knowledge/stateful-environment-stateless-agents.md`
- `/Users/fullerbt/.agents/knowledge/corpus-hidden-patterns.md`
- `/Users/fullerbt/.agents/topics/planning-and-validation-loops.md`
- `/Users/fullerbt/.agents/topics/handoff-and-provenance.md`
- `/Users/fullerbt/.agents/topics/context-orchestration.md`
- `/Users/fullerbt/.agents/topics/distributed-cognition.md`

## History Search / Ranked Packet

### Direct `ao` search results

- `ao search` for the doctrine objective: no direct hits
- `ao lookup` for the doctrine objective: no direct hits
- `.agents/findings/`: no active findings surfaced

### Carry-forward environment signals

The startup context and `.agents/rpi/next-work.jsonl` surfaced one indirectly relevant item:

1. **Medium relevance**: add `target_repo` to `next-work.jsonl` schema
   - Why it matters here: the existing harvest mixes `12factor` doctrine work with cross-repo AgentOps process learnings, which makes later discovery noisier than it should be.

Low-relevance carry-forward items exist around SVG stale framing and cycle-0 sweeps, but they do not materially affect the next doctrine refinement wave.

### Ranked packet summary

1. **Operator-kernel alignment is now explicit in core doctrine surfaces**.
2. **Secondary explanatory surfaces still lag the new compression**.
3. **Fitness gradient and provenance remain under-expressed in `12factor` compared with the mined kernel**.
4. **Cross-repo harvest hygiene is still weak**, which explains why doctrine discovery can feel noisier than the actual kernel warrants.

## Findings

### 1. The fresh doctrine pass fixed the right layer

`12factor` is now aligned at the core doctrine surface:

- `README.md` exposes the operator model cleanly
- `factors/README.md` now offers a factor-to-operator crosswalk
- Factors I, V, VIII, and XII now explicitly cover environment continuity, replaceable actors, traces, selection gates, promotion loops, and governance
- `docs/explanation/operator-model.md` provides the missing compression layer

This means the repo is no longer missing the central operator-model bridge.

### 2. AgentOps still centers the three-gap product contract

The current `AgentOps` repo remains explicit about its product framing:

- **judgment validation**
- **durable learning**
- **loop closure**

That is still the correct product contract for AgentOps. It packages the coding-agent slice of the problem. It is narrower than `12factor` and should stay narrower.

The important overlap is beneath that contract:

- environment-carried continuity
- software-factory control plane
- replaceable workers
- validation gates
- flywheel closure

So the correct relationship is:

- `12factor` = broader doctrine and public factor surface
- `AgentOps` = productized implementation of a narrower coding-agent lane inside that broader doctrine

### 3. The mined kernel is now clearer than the docs that surround it

The strongest mined operator knowledge is consistent:

- context orchestration is healthy
- distributed cognition is healthy
- provenance-backed handoff is healthy
- planning and validation loops are the actual spine

The clearest compression from the mined corpus is:

- bounded context over maximal context
- worker chains over single-agent heroics
- provenance before canon
- validation before closure
- promotion before more capture

This means the next doctrine refinement should not invent new themes. It should expose the themes the corpus already supports well.

### 4. The biggest remaining doctrinal hole is fitness gradient

The operator-model knowledge treats **fitness gradient** as a first-class primitive.

The current `12factor` repo still mostly implies that concept through:

- validation
- ratchets
- goals
- measurement

But it does not yet say, cleanly and repeatedly, that:

> measurement and validation together define the system's fitness gradient.

That is the next highest-value compression to add.

### 5. The second remaining hole is provenance as a trust surface

The mined corpus treats provenance as load-bearing:

- handoff and provenance are healthy topics
- provenance is repeatedly treated as a gate on trust
- the environment should know where a belief came from and how much to trust it

`12factor` currently mentions git, tracking, learnings, citations, and failures, but provenance is still more implicit than explicit outside the new operator-model explainer.

That gap likely belongs in:

- Factor VII (`Extract Learnings`)
- secondarily in comparison/evolution/explanation docs

### 6. The secondary docs still lag the core doctrine

Three files stand out:

1. `docs/principles/comparison-table.md`
   - still useful, but it does not yet expose the operator model beneath the factor mapping

2. `docs/principles/evolution-of-12-factor.md`
   - stronger than before, but still centered on stage evolution more than operator-kernel compression

3. `docs/explanation/from-theory-to-production.md`
   - still carries older `12-Factor AgentOps` framing and a more implementation-heavy architecture narrative than the current doctrine now warrants

These are the right next targets because they are explanatory surfaces, not the primary factor surface.

## Recommended Enhancement Wave

### Primary target 1: Factor VII

Enhance `factors/07-extract-learnings.md` so it explicitly covers:

- learnings as durable traces, not just notes
- provenance as a trust surface
- the distinction between raw observations, validated learnings, and reusable patterns

### Primary target 2: Factor IX

Enhance `factors/09-measure-what-matters.md` so it explicitly covers:

- the **fitness gradient**
- how measurement and validation shape selection pressure
- governance as the layer that decides which outcomes matter

### Primary target 3: Secondary explanation/principles docs

Update:

- `docs/principles/comparison-table.md`
- `docs/principles/evolution-of-12-factor.md`
- `docs/explanation/from-theory-to-production.md`

Purpose:

- show the operator model as the compression layer beneath the factor surface
- clarify the relation between `12factor` doctrine and the `AgentOps` product contract
- bring provenance, planning loops, and fitness gradient into the explanation layer

## What Not To Do Next

- do not start another broad repo-wide wording sweep
- do not rewrite the README again
- do not turn `12factor` into a restatement of AgentOps' three-gap contract
- do not overfit the doctrine to software-factory language at the expense of broader applicability
- do not treat every mined artifact as equally authoritative; the healthy kernel is smaller than the corpus

## Test Levels For Downstream Work

For the next refinement wave, the applicable validation levels are:

- **L0**: mechanical doc checks
  - `git diff --check`
  - heading/link/path sanity

- **L1**: targeted lexical doctrine checks
  - operator-model terms present in the intended docs
  - no accidental flattening into AgentOps product-language in primary doctrine surfaces

- **L2**: cross-surface consistency review
  - factor docs, comparison/evolution docs, and explanation docs tell the same relationship between doctrine, operator model, and AgentOps

- **L3**: not required
  - this is doctrine/documentation work, not subsystem/runtime behavior

## Bottom Line

The fresh pass moved `12factor` into alignment at the core doctrine layer.

The next leverage point is not more core-factor churn. It is a focused phase-2 refinement wave:

1. add **fitness gradient** to the doctrine where it naturally belongs
2. make **provenance** more explicit as a trust surface
3. update the secondary explanation/principles docs so they reflect the same operator-kernel compression as the newly updated core surfaces

That is the smallest next wave that would make the repo feel truly aligned with both the current `AgentOps` repo and the strongest five-month knowledge kernel.
