# Judge: feasibility

## Verdict: WARN
## Confidence: HIGH

## Key Insight
Phase 1 scope is bounded but still underestimates rewrite effort by 2x; factor files average 500-870 lines of dense, cited content requiring complete reconstruction.

## Findings

### Finding 1: Factor Rewrites Are 2x Larger Than Acknowledged
- **Severity:** significant
- **Category:** feasibility
- **Description:** v2 acknowledges rewrites are complete (48-72 hours), but inspection shows current factors are 500-870 lines each with deep implementation guidance, academic citations, code examples, and cross-references. Factor II alone has 870 lines including cognitive load theory citations, 40% threshold math, aviation analogies, and HumanLayer deep-dive section. Rewriting 12 such factors to the new structure (Rule, Rationale, What Good Looks Like, Without Tooling for I-III) is 96-144 hours minimum, not 48-72.
- **Recommendation:** Double the estimate. 12 factors × 8-12 hours each = 96-144 hours (12-18 days). Phase this: batch 1 (I-III, 24-36h), batch 2 (IV-VI, 24-36h), batch 3 (VII-IX, 24-36h), batch 4 (X-XII, 24-36h).
- **Why:** Current factors are not outline-level content; they are complete reference documents with research backing, real-world evidence sections, anti-pattern catalogs, and relationship maps. The new factors must maintain this depth while reframing the content—that's ground-up reconstruction, not editing.

### Finding 2: Archive Step Has Hidden Complexity
- **Severity:** significant
- **Category:** feasibility
- **Description:** "Archive old factors to _archived/factors-v1/ with mapping table" sounds simple but creates substantial work. Each factor has 48+ cross-references (per v1 pre-mortem finding #7). The mapping table must document: old number → new number, concept migrations (old Factor II content → new Factor I), deprecated concepts, tutorial impact. This is 8-12 hours of mechanical work that blocks everything else.
- **Recommendation:** Do archival FIRST, not fourth. Create the mapping table before touching any factor files. This unblocks parallel work on new factors and provides the reference for "Where did X content go?"
- **Why:** You can't write the new factors without knowing where old content migrates. The archive + mapping is a dependency blocker disguised as cleanup work.

### Finding 3: Factor I/II Collision Resolution Is Non-Trivial
- **Severity:** significant
- **Category:** feasibility
- **Description:** Old Factor II "Context Loading" has 870 lines including the 40% rule, cognitive load citations, and sub-agent architecture. New Factor I "Context Is Everything" claims this territory. The plan says "migrate content" but doesn't specify HOW to compress 870 lines (old II) + whatever was in old Factor I (automated tracking) into new Factor I without creating a bloated 1200-line monster that violates its own "keep context lean" principle.
- **Recommendation:** Explicit content budget: new Factor I gets 600 lines max. Decide NOW what gets cut, what moves to tutorials, what becomes a pattern reference. The 40% rule + observable symptoms stays (core). Sub-agent deep-dive moves to tutorials. HumanLayer attribution section stays (required). This needs a decision, not a handwave.
- **Why:** "Migrate content" without a size budget creates scope creep. Factor I could balloon to 1500 lines, violating the lean principles it teaches.

### Finding 4: GOALS.yaml Substance Checks Are Underspecified
- **Severity:** minor
- **Category:** feasibility
- **Description:** Plan specifies adding checks like "Factor I mentions observable symptoms" and "Factor VIII has 'compounding equation' content." These are grep-able strings, which is good. But "README contains 'quickstart' or 'getting started' section" doesn't verify the quickstart is COMPLETE (tier 0 instructions, learnings.md example, 5-minute claim substantiated). Structural checks are better than nothing but still allow hollow content.
- **Recommendation:** Add assertion-style checks: "README quickstart section has ≥150 words," "Factor I 'Without Tooling' section exists and has ≥100 words," "Factors X-XII marked 'OPTIONAL' in headers." This catches stub sections.
- **Why:** v1 pre-mortem finding #8 was about substance over structure. Current plan improves on v1 but doesn't fully close the gap.

### Finding 5: No Phased Dependencies Documented
- **Severity:** minor
- **Category:** feasibility
- **Description:** Plan says "Phase 1: Core Content Pivot" but doesn't document internal dependencies. Can all 12 factors be written in parallel, or do I-III need to finish before IV-VI? Does README rewrite depend on factor rewrites (needs links to exist) or can it draft in parallel (use placeholder links)? Archive + mapping is clearly a blocker but other dependencies are implicit.
- **Recommendation:** Explicit dependency graph: Archive+Mapping (0-2 days) → Factors I-III (3-6 days, parallel work possible) → README draft (1-2 days, can overlap with IV-VI) → Factors IV-IX (6-9 days) → Factors X-XII (3-4 days) → GOALS.yaml updates (0.5 days) → Final review (1 day). Total: 14.5-24.5 days elapsed assuming serial work.
- **Why:** Without dependencies, you'll discover blockers mid-work and waste time on rework.

### Finding 6: Phase 1 Scope Creep Risk from "Resolve Factor I/II Collision"
- **Severity:** minor
- **Category:** feasibility
- **Description:** Plan includes "Resolve Factor I/II collision — migrate content, explicit anchor decision" in Phase 1. This sounds bounded but could explode into content arbitration across all 12 factors. If Factor I absorbs II's content, does old Factor III content stay in new III or migrate? Every factor renumbering creates potential collisions.
- **Recommendation:** Limit collision resolution to I/II only. Other factors get clean rewrites based on the plan's new structure (Rule, Rationale, What Good Looks Like). No content archaeology for III-XII beyond checking for duplicates. If collision found, defer to Phase 2 cleanup.
- **Why:** Content archaeology across 12 factors is infinite scope. The v1→v2 mapping handles most of this; don't gold-plate.

## Recommendation

**PROCEED with revised estimates and sequencing.**

1. **Revise time estimate to 96-144 hours (12-18 days) for Phase 1.** v2 acknowledges rewrites are complete but still underestimates depth of current content (500-870 lines per factor with citations, examples, evidence).

2. **Resequence Phase 1 work:**
   - **Day 0-2:** Archive old factors + create mapping table (BLOCKER, do first)
   - **Day 3-5:** Factors I-III rewrites (foundation tier, includes I/II collision resolution)
   - **Day 6-7:** README rewrite (can start during Factors I-III if using placeholder links)
   - **Day 8-13:** Factors IV-IX rewrites (workflow + knowledge tiers)
   - **Day 14-16:** Factors X-XII rewrites (scale tier)
   - **Day 17:** GOALS.yaml substance checks
   - **Day 18:** Final review + integration test (all links work, no stubs)

3. **Add content budgets to prevent scope creep:**
   - New factors: 400-600 lines each (maintain depth, not verbosity)
   - README: 800-1000 lines (hero + quickstart + factor overview + links)
   - Factor I specifically: 600 lines max (resist bloat from absorbing Factor II)

4. **Make archive+mapping the first task, not the fourth.** It's a dependency blocker for everything else.

Phase 1 scope is defensible if time estimates are realistic. The plan correctly identifies rewrites as complete (not reframes), but inspection shows current factors are denser than acknowledged. Budget 12-18 days, not 6-9.
