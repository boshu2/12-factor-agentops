# Pre-Mortem: 12-Factor AgentOps Pivot

**Date:** 2026-02-15
**Plan:** docs/plans/2026-02-15-pivot-design.md
**Mode:** --deep --preset=plan-review + product perspectives (PRODUCT.md auto-include)
**Judges:** 7 (4 plan-review + 3 product)

## Council Verdict: FAIL

| Judge | Perspective | Verdict | Confidence | Key Finding |
|-------|------------|---------|------------|-------------|
| 1 | missing-requirements | WARN | HIGH | Vision solid, execution gaps (migration path, content depth, success metrics) |
| 2 | feasibility | WARN | HIGH | 3-5x underestimated effort — ground-up rewrite of ~10K lines, not light editing |
| 3 | scope | WARN | HIGH | All 12 factors need complete rewrites, "consider new skills" = infinite scope |
| 4 | spec-completeness | WARN | HIGH | GOALS.yaml checks structure not substance; archival process undefined |
| 5 | user-value | WARN | HIGH | No zero-infrastructure entry ramp for solo devs; Factors X-XII break individual-first claim |
| 6 | adoption-barriers | **FAIL** | HIGH | No 30-second pitch, no progressive entry path, cognitive load irony |
| 7 | competitive-position | WARN | HIGH | Principles aren't defensible moats; vendor neutrality unproven |

**Consensus rule:** Any FAIL = FAIL.

---

## Shared Findings (5+ judges agree)

1. **Factor rewrites are complete rewrites, not reframes.** Current factors are 300-800 lines each with deep implementation guidance. New factors share almost no content with old ones. Budget 2-3 weeks, not days.

2. **No zero-infrastructure entry ramp.** The plan assumes tooling investment (AgentOps plugin) before users feel value. Every competitor delivers faster time-to-first-value.

3. **Factors X-XII are for multi-agent builders, not solo devs.** The "individual-first, scales up" claim breaks for scale factors. Need explicit tiering.

4. **Scope boundaries missing.** "Consider new skills," archive manifest, Olympus cross-references — all open-ended without explicit limits.

5. **Knowledge compounding is the unique differentiator but it's buried.** Factor VIII (compound knowledge) is the only thing competitors can't trivially absorb, but it's listed 8th with no hero positioning.

---

## Critical Findings (fix before implementation)

### 1. Adoption model is backwards
**Source:** adoption-barriers (FAIL), user-value, competitive-position

The plan asks: Philosophy → Tool → Results.
Successful adoption requires: Tool → Results → Philosophy.

**Fix:** Build diagnostic-driven onboarding. Users install plugin, run a session, get told which factors they violated and what to fix. Factors become explanations of why the plugin works, not prerequisites for using it.

### 2. No progressive entry path
**Source:** adoption-barriers, user-value, scope

All 12 factors presented with equal weight creates analysis paralysis. Factors have hidden dependencies (I-III prerequisite for IV-VI, etc.) unlike 12-Factor App where each was independent.

**Fix:** Make dependency tree explicit. Create "Getting Started Without Tooling" showing how to apply Factors I-III with just a learnings.md file. Let users stop at any tier and still get value.

### 3. Massive hidden scope treated as minor work
**Source:** feasibility, scope, missing-requirements

- 12 factor files: 48-72 hours of writing (not "reframing")
- README rewrite: 15-20 hours (not "update tagline")
- Marketplace skills: unbounded without scope limits

**Fix:** Phase ruthlessly. Phase 1: Core factor rewrites + README content pivot. Phase 2: Supporting docs. Phase 3: New skills/assets. Ship Phase 1 before scoping Phase 2.

### 4. Vendor neutrality claim is unproven
**Source:** competitive-position, user-value

Factors VII-XII require infrastructure that only the AgentOps plugin provides. Claiming "vendor-neutral" while the only implementation path is your own tool reads as disingenuous.

**Fix:** Either prove neutrality (document vanilla implementations for each factor) or own the platform play (AgentOps is the best-in-class implementation, neutrality is a future goal).

---

## Significant Findings

### 5. 40% rule is unactionable for most users
Users can't measure context utilization in Claude Code, Cursor, or Codex. A rule you can't measure is a rule you can't follow.

**Fix:** Reframe Factor I around observable symptoms (agent repeats itself, ignores instructions, confabulates) rather than invisible metrics.

### 6. Conceptual collision between old and new factors
Current Factor II "Context Loading" and new Factor I "Context Is Everything" describe the same concept. Need to resolve before rewriting.

**Fix:** Decide one anchor. Migrate 40% rule content (200+ lines with citations) from old Factor II to new Factor I.

### 7. No migration path for existing users
Renumbering all 12 factors breaks mental models and internal references. ~48+ cross-references need updating.

**Fix:** Version old factors as v1.0, create mapping table, use symbolic names during draft phase.

### 8. GOALS.yaml checks structure, not substance
Files could pass all checks with just headers and no actual content. README checks are negative-only (old content gone) not positive (new content exists).

**Fix:** Add substance checks (Factor I mentions "40%", README links AgentOps plugin, etc.).

---

## Key Disagreements

### Vendor neutrality: prove it vs. drop it
- **competitive-position:** Drop the claim, own the platform play (Path B)
- **user-value:** Provide manual versions of each factor that work without tooling
- **Resolution:** Both paths are viable. User should decide based on strategic intent.

### Factors X-XII: core vs. advanced
- **user-value:** Split into "9 Core + 3 Scale (optional)"
- **scope:** Keep 12 but clarify source material (refactored from Gas Town/Olympus, not greenfield)
- **Resolution:** Keep 12 factors but make Scale tier explicitly optional for solo devs.

---

## Recommendations

### Before Implementation (address the FAIL)

1. **Invert the adoption model** — Tool → Results → Philosophy, not the reverse
2. **Create zero-infrastructure entry ramp** — "Getting Started" guide using only learnings.md + native agent
3. **Make Factor VIII the hero** — Knowledge compounding is the unique differentiator. Lead with it.
4. **Add explicit dependency tree** — Core (I-III) → Workflow (IV-VI) → Knowledge (VII-IX) → Scale (X-XII, optional)
5. **Phase the work** — Ship core factor rewrites before scoping supporting docs, skills, or assets

### During Implementation

6. **Add substance checks to GOALS.yaml** — Verify content, not just file existence
7. **Create archive manifest** — Explicit list of what moves, what stays, what rewrites
8. **Resolve Factor I/II collision** — Decide anchor before writing
9. **Scope marketplace skills** — "No new skills in pivot phase" or exactly N specified skills
10. **Version old factors** — v1.0 archive with mapping guide

### Post-Implementation

11. **Validate with GSD/Superpowers users** — Do they feel the operational gap?
12. **Build measurable individual metrics** — Time-to-productive-start, knowledge reuse rate, first-pass validation rate
13. **Consider /diagnose skill** — Post-session diagnostic that teaches factors through usage

---

## Decision Gate

- [x] **ADDRESS** — Fix adoption barriers before implementing. The principles are sound; the delivery mechanism needs rework.
- [ ] PROCEED — Council passed, ready to implement
- [ ] RETHINK — Fundamental issues, needs redesign
