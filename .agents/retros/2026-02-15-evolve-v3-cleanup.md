# Retro: /evolve v3 Cleanup Session

**Date:** 2026-02-15
**Scope:** 3 evolve cycles, 13 files, -584 lines net
**Duration:** ~45 minutes

## What Went Well

- **Evolve loop worked as designed.** Measure → select → fix → verify → loop. Zero manual intervention needed.
- **Parallel agents are efficient for file edits.** 3 agents per cycle, no conflicts, correct results.
- **GOALS.yaml regression gate caught nothing** — meaning all changes were clean. The gate's value is insurance.
- **Stagnation detection worked.** 3 idle cycles → clean stop. No manufactured work.

## What Was Hard

- **Context recovery from prior session.** The /evolve run started from a compacted context — had to reconstruct what the prior /rpi session had already done vs what remained.
- **Distinguishing repo-relevant from cross-repo items** in next-work.jsonl. 4 of 10 items were agentops process improvements filed into this repo's harvest.

## Do Differently Next Time

- **Tag next-work items with target repo.** Add a `target_repo` field to next-work.jsonl schema so evolve can filter to repo-relevant items automatically.
- **Include SVG content in stale-name GOALS.yaml checks.** The `no-stale-framing` goal only checks `factors/ docs/ README.md CONTRIBUTING.md` — SVGs in docs/assets/ were missed until manual sweep.
- **Run a final comprehensive sweep as cycle 0.** Before consuming harvested work, do a full-repo scan to discover items the harvest missed (like SVG old names).

## Patterns to Reuse

- **Evolve for post-pivot cleanup.** After any major rewrite/pivot, run `/evolve` to systematically consume the tech debt tail. It's more thorough than manual cleanup.
- **3-agent parallel for independent file edits.** Each agent gets a clear file list and instructions. No coordination needed. Write to files, signal done.
- **GOALS.yaml as living acceptance criteria.** The 13 goals served as both the fitness function and the definition of "v3-aligned."

## Anti-Patterns to Avoid

- **Don't mix repo work and cross-repo process items in the same harvest.** It creates noise in the evolve loop selection step.
- **Don't trust that prior sessions consumed all work.** The prior /rpi session's crank phase exploded — its post-mortem harvested items but the evolve loop had to verify and consume them.
