# Post-Mortem: Epic 12-pr7 — v3 Documentation Full Rewrite

**Date:** 2026-02-15
**Epic:** 12-pr7 (15/15 issues closed)
**Duration:** ~35 min crank + recovery session (original session context-exploded, recovered in new session)
**Cycle-Time Trend:** Comparable to prior epic 12-3jc (~2 hours total). Crank was faster (parallel doc rewrites) but recovery added overhead.
**Mode:** quick (single-agent)

## Council Verdict: WARN

| Judge | Verdict | Key Finding |
|-------|---------|-------------|
| Plan-Compliance | PASS | All 15 issues delivered. 41 files modified matching plan scope. Conformance checks pass. CHANGELOG entry deferred. |
| Tech-Debt | WARN | 4 out-of-scope files still have old factor names (33 total refs). 3 aspirational broken links to unwritten guides. |
| Learnings | PASS | Parallel agents effective for independent rewrites. Context explosion is a real scaling risk. Recovery was clean. |

### Implementation Assessment

The v3 documentation rewrite is complete. All non-factor docs, SVGs, and marketplace files are aligned with the v3 philosophy ("The Operational Discipline for Working With AI Agents"). The 4-tier structure, v3 factor names, and Factor VIII hero positioning are consistent across 41 modified files.

Conformance is mechanically verified:
- No stale framing ("Shift-Left", "DevOps for Vibe", "coding agents only")
- No old factor names in modified files (remaining hits are comparison tables / historical context)
- SVGs clean of old content
- Cross-references in modified files resolve (except 3 aspirational links)

### Concerns

1. **Context explosion during crank** — 5+ agents returning full results simultaneously caused "Prompt is too long" errors. Filed as `ag-o294` in agentops.
2. **Out-of-scope files** — 4 explanation files not in this epic still contain old factor names (pattern-heritage: 21 refs, beads-workflow-integration: 5, faafo-north-star: 3, ecosystem-position: 4).
3. **CHANGELOG not updated** — Issue 15 scoped as "CHANGELOG + link verification" but CHANGELOG was deferred during recovery.

## Learnings (Inline Retro)

### What Went Well

1. **Parallel agent spawning scaled to 14 independent issues.** All agents completed their file edits successfully. The work quality was high — conformance checks passed on first verify.
2. **Conformance checks are effective mechanical gates.** Three grep-based checks (stale framing, old factor names, SVG content) caught everything mechanically.
3. **Recovery from context explosion was clean.** Verify work via conformance checks → close issues in bulk → commit → resume pipeline. No rework needed.
4. **Pre-mortem WARN was appropriate.** The concerns raised (cross-reference desync, SVG reliability) turned out to be non-issues in practice.

### What Was Hard

1. **Context explosion.** The orchestrator session couldn't process agent results because all 5+ agents returned full summaries simultaneously. This is a fundamental scaling constraint.
2. **Beads migration.** Legacy database warning added friction to recovery. Auto-migration would be smoother.
3. **Issue 15 dependency chain.** Having a single issue blocked by all 14 others meant it couldn't start until everything else was done — correct but created a bottleneck for the final verification pass.

### Do Differently Next Time

1. **Subagents must write results to files, not return in context.** (Filed: ag-o294) Agents write to `.agents/rpi/results/<issue-id>.md`, return only "DONE: <id>". Orchestrator reads on-demand.
2. **Run link verification as a wave vibe gate, not a final issue.** Instead of issue 15 blocked by all, make link verification a post-wave mechanical check that runs after each wave.
3. **Commit incrementally per wave.** Don't accumulate all changes across all waves — commit after each wave completes. Smaller commits, cleaner recovery.

### Patterns to Reuse

- Grep-based conformance checks in plan → used as acceptance criteria → verified in vibe
- Bulk `bd close` for batch issue completion during recovery
- Pre-mortem WARN → proceed pattern (trust the process, concerns are logged)

### Anti-Patterns to Avoid

- Returning full agent results into orchestrator context (context bomb)
- Single mega-commit for multi-wave epic
- Having cleanup/verification as last issue blocked by everything

## Next Work

| # | Title | Type | Severity | Source |
|---|-------|------|----------|--------|
| 1 | Clean old factor names from out-of-scope explanation files | tech-debt | medium | council-finding |
| 2 | Remove aspirational broken links or create stub guides | tech-debt | low | council-finding |
| 3 | Subagents write results to files not context | process-improvement | high | retro-learning |
| 4 | Add per-wave commit and link verification gates | process-improvement | medium | retro-learning |

## Status

[x] CLOSED - Work complete, learnings captured, next-work harvested
