# Plan: 12-Factor AgentOps Pivot v3 Implementation

**Date:** 2026-02-15
**Source:** docs/plans/2026-02-15-pivot-design.md (v3)
**Epic:** 12-3jc

## Overview

Rewrite all 12 factor files, README, and archive old content to pivot from "Shift-Left Validation for Coding Agents" to "The Operational Discipline for Working With Agents."

## Boundaries

**Always:**
- Content budgets: 400-600 lines/factor, 600 max Factor I, 800-1000 README
- Factor depth: 500+ words minimum (GOALS.yaml enforced)
- Foundation factors (I-III) have "Without Tooling" sections
- Scale factors (X-XII) marked OPTIONAL/advanced
- All 14 GOALS.yaml checks pass on completion

**Ask First:**
- None (--auto mode, fully autonomous)

**Never:**
- New marketplace skills
- Tutorial rewrites
- New tooling/plugins
- Olympus references beyond 1 sentence per Scale factor

## Baseline Audit

| Metric | Command | Result |
|--------|---------|--------|
| Old factor files | `ls factors/*.md \| wc -l` | 13 (12 factors + README.md) |
| Old factor total lines | `wc -l factors/*.md` | 10,360 lines |
| Largest factor | `wc -l factors/12-package-patterns.md` | 1,485 lines |
| Smallest factor | `wc -l factors/01-automated-tracking.md` | 317 lines |
| Current README | `wc -lw README.md` | 215 lines, 597 words |
| _archived exists | `ls -d _archived` | Does not exist |
| GOALS.yaml checks | `grep -c 'id:' GOALS.yaml` | 14 checks (v2) |

## Issues

| ID | Title | Wave | Dependencies |
|----|-------|------|-------------|
| 12-3jc.1 | Archive old factors + create MAPPING.md | 1 | None |
| 12-3jc.2 | Rewrite Factor I: Context Is Everything | 2 | 12-3jc.1 |
| 12-3jc.3 | Rewrite Factor II: Track Everything in Git | 2 | 12-3jc.1 |
| 12-3jc.4 | Rewrite Factor III: One Agent One Job | 2 | 12-3jc.1 |
| 12-3jc.5 | Rewrite Factor IV: Research Before You Build | 2 | 12-3jc.1 |
| 12-3jc.6 | Rewrite Factor V: Validate Externally | 2 | 12-3jc.1 |
| 12-3jc.7 | Rewrite Factor VI: Lock Progress Forward | 2 | 12-3jc.1 |
| 12-3jc.8 | Rewrite Factor VII: Extract Learnings | 2 | 12-3jc.1 |
| 12-3jc.9 | Rewrite Factor VIII: Compound Knowledge | 2 | 12-3jc.1 |
| 12-3jc.10 | Rewrite Factor IX: Measure What Matters | 2 | 12-3jc.1 |
| 12-3jc.11 | Rewrite Factor X: Isolate Workers | 2 | 12-3jc.1 |
| 12-3jc.12 | Rewrite Factor XI: Supervise Hierarchically | 2 | 12-3jc.1 |
| 12-3jc.13 | Rewrite Factor XII: Harvest Failures as Wisdom | 2 | 12-3jc.1 |
| 12-3jc.14 | Rewrite README | 3 | 12-3jc.2, .3, .4 |
| 12-3jc.15 | Verify GOALS.yaml checks pass | 4 | All above |

## Execution Order

**Wave 1** (1 task): 12-3jc.1 (Archive + MAPPING.md)
**Wave 2** (12 tasks, parallel): 12-3jc.2 through 12-3jc.13 (all 12 factor rewrites)
**Wave 3** (1 task): 12-3jc.14 (README, needs Foundation factors)
**Wave 4** (1 task): 12-3jc.15 (Verify GOALS.yaml)

## Conformance Checks

| Issue | Check Type | Check |
|-------|-----------|-------|
| 12-3jc.1 | files_exist | `_archived/factors-v1/MAPPING.md` |
| 12-3jc.2-4 | content_check | `Rule:` + `Without Tooling` + 500+ words |
| 12-3jc.5-13 | content_check | `Rule:` + `What good looks like` + 500+ words |
| 12-3jc.11-13 | content_check | `optional\|advanced\|not prerequisite` |
| 12-3jc.9 | content_check | `flywheel\|compounding equation\|retrieval rate` |
| 12-3jc.14 | content_check + command | `Operational Discipline` + `quickstart` + 800+ words |
| 12-3jc.15 | command | All 14 GOALS.yaml checks pass |

## Next Steps

- Run `/crank 12-3jc` for autonomous execution
- Or `/implement <issue-id>` for single issue
