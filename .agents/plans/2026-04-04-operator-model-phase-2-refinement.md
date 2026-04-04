# Plan: Operator-Model Phase 2 Refinement

## Objective

Bring the next layer of `12factor` into alignment with the current AgentOps product contract and the mined operator-kernel knowledge, without changing the repo's factor-first identity.

## Tracker Mode

- `tasklist`
- No usable beads database was detected in this repo during discovery.

## Proposed Work Items

### 1. Strengthen Factor VII around provenance-backed learning

Update `factors/07-extract-learnings.md` to make explicit:

- raw observation vs validated learning vs reusable pattern
- provenance as part of trust, not as documentation overhead
- extraction as durable trace formation, not just note capture

### 2. Strengthen Factor IX around fitness gradient

Update `factors/09-measure-what-matters.md` to make explicit:

- the fitness gradient
- measurement as the steering surface for selection pressure
- governance deciding which outcomes count as better or worse

### 3. Update `docs/principles/comparison-table.md`

Refine the comparison so it shows:

- the operator model as the compression underneath the factors
- the relationship between `12factor`, `12-Factor Agents`, and AgentOps without collapsing them into one layer

### 4. Update `docs/principles/evolution-of-12-factor.md`

Refine the evolution story so it makes explicit:

- the movement from factor surface to operator compression
- why the doctrine remains factor-first even as the kernel becomes clearer
- where AgentOps fits as a product/reference implementation rather than the doctrine itself

### 5. Update `docs/explanation/from-theory-to-production.md`

Refine the explanation layer so it better expresses:

- stateful environment / replaceable actors
- planning and validation loops as the operational spine
- provenance and governance as trust/constraint surfaces
- clearer separation between doctrine, implementation patterns, and productized tooling

## Out of Scope

- broad repo-wide wording sweeps
- renaming the twelve factors
- changing the README again unless a downstream edit proves strictly necessary
- rewriting the repo into AgentOps three-gap product language

## Acceptance Criteria

1. Factors VII and IX explicitly cover provenance and fitness gradient in `12factor` language.
2. `comparison-table`, `evolution-of-12-factor`, and `from-theory-to-production` reflect the operator-kernel compression and the current relation to AgentOps.
3. The twelve factors remain the public surface.
4. AgentOps appears as a narrower product/reference implementation, not as the doctrine's replacement frame.
5. The change set stays narrow and explanatory rather than sprawling.

## Issue Count

- 5 work items

## Complexity

- `standard`
