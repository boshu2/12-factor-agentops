# Judge: scope

## Verdict: WARN
## Confidence: HIGH

## Key Insight
Phase 1 scope is better bounded than v1 but still contains 3-6 weeks of work masquerading as "core content pivot" — the README structure and GOALS.yaml substance checks create implicit expansion beyond the stated 12-factor rewrites.

## Findings

### Finding 1: README "6-section structure" is actually a complete product redesign
- **Severity:** significant
- **Category:** scope
- **Description:** Phase 1 includes "Rewrite README" with a 6-part structure (Hero, 30-second pitch, 5-minute quickstart, Factor overview, Go deeper, Reference implementation). This isn't updating a tagline — it's designing and writing new marketing copy, onboarding flows, quickstart tutorials, and reference architecture docs. The v1 pre-mortem estimated README rewrite at 15-20 hours; v2 doesn't acknowledge this cost at all.
- **Recommendation:** Either move README to Phase 2 (ship factors first, wrap them in marketing later) OR acknowledge it as 15-20 hours of product writing separate from factor content. Current plan treats it as trivial work bundled with "core content."
- **Why:** Treating product design as a side effect of content writing systematically underestimates scope and causes deadline slips.

### Finding 2: GOALS.yaml substance checks create unbounded verification work
- **Severity:** significant
- **Category:** scope
- **Description:** v2 adds GOALS.yaml substance checks (Factor I mentions observable symptoms, Factor VIII has compounding equation, README contains quickstart, etc.). These are quality gates, not deliverables — each check requires writing content, then verifying it meets the check, then iterating. The plan treats "add substance checks" as a single task but it's actually a quality framework for all 12 factors + README.
- **Recommendation:** Scope checks to 1-2 per factor (not comprehensive coverage). Example: Factor I has symptoms check, Factor VIII has flywheel check, README has quickstart check. That's 3 checks total, not 15+.
- **Why:** Quality gates multiply the scope of the work they gate. Unbounded checks turn a content project into a QA project.

### Finding 3: "Without Tooling" sections for Factors I-III are a whole new deliverable
- **Severity:** significant
- **Category:** scope
- **Description:** v2 correctly adds "Without Tooling" sections to prove vendor neutrality for Factors I-III. But these aren't editing existing content — they're net-new writing demonstrating manual workflows. Each factor needs examples of how to practice it with zero infrastructure. This is good design (addresses v1 adoption barrier) but it's additive scope not acknowledged in the estimate.
- **Recommendation:** Budget 2-3 hours per "Without Tooling" section (6-9 hours total for Factors I-III). Or defer to Phase 2 as part of "Getting Started Without Tooling" standalone guide.
- **Why:** Demonstrating vendor neutrality through examples is content design work, not editing work.

### Finding 4: Archive resolution is still undefined
- **Severity:** minor
- **Category:** scope
- **Description:** Phase 1 includes "Archive old factors" with "mapping table" but doesn't define what the mapping table contains or how collisions (Factor I/II) get resolved. The plan says "Explicit anchor decision: Factor I owns all context management content" but doesn't budget time for the 200+ lines of migration from old Factor II to new Factor I.
- **Recommendation:** Either treat Factor I/II migration as part of Factor I rewrite (already scoped) OR call it out as a separate 2-4 hour task for content consolidation + citation verification.
- **Why:** Content migration without explicit scope becomes invisible work that causes deadline slips.

### Finding 5: Phase 2/3 boundaries are clean (rare victory)
- **Severity:** N/A (positive finding)
- **Category:** scope
- **Description:** Unlike v1 ("consider new skills" = infinite scope), v2 explicitly excludes marketplace skills, Olympus cross-references, and tutorial rewrites from Phase 1. Phase 3 even scopes the new skills to "exactly context-audit and extract-learnings" instead of open-ended exploration. This is textbook scope discipline.
- **Recommendation:** No change needed. This is the model for how to phase work.
- **Why:** Explicit exclusions prevent feature creep during implementation.

### Finding 6: 12 complete factor rewrites is the correctly scoped hard part
- **Severity:** N/A (positive finding)
- **Category:** scope
- **Description:** v2 acknowledges that factors need "complete rewrites (not reframes)" and structures each as Rule + Rationale + What Good Looks Like. This matches the v1 pre-mortem finding that current factors are 300-800 lines with deep implementation guidance. The plan doesn't pretend this is light editing.
- **Recommendation:** No change. This is the honest scope.
- **Why:** Calling rewrites "rewrites" instead of "updates" prevents underestimation.

## Recommendation

**Move README to Phase 1.5 or Phase 2.** Ship the 12 factors first as standalone files with basic headers. Then wrap them in the 6-section README structure once the content is stable. This decouples content creation (factors) from product design (onboarding flow), making Phase 1 achievable in 3-4 weeks instead of stretching to 5-6 weeks.

Alternatively, if README must ship with Phase 1, acknowledge it as 15-20 hours of product writing (separate from factor writing) and extend the Phase 1 timeline accordingly.

The GOALS.yaml substance checks and "Without Tooling" sections are good additions but they're additive scope. Either budget time for them (9-12 hours total) or defer some to Phase 2.

**Core issue:** v2 correctly fixed the unbounded scope from v1 ("consider new skills") but added bounded-but-unacknowledged scope (README structure, substance checks, Without Tooling sections) that wasn't in the original estimate. The total scope is *smaller* than v1, but it's still larger than the plan admits.
