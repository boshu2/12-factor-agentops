# Pre-Mortem: 12-Factor AgentOps Pivot (v2)

**Date:** 2026-02-15
**Plan:** docs/plans/2026-02-15-pivot-design.md (v2, revised after v1 FAIL)
**Mode:** --deep --preset=plan-review + product perspectives (PRODUCT.md auto-include)
**Judges:** 7 (4 plan-review + 3 product)

## Council Verdict: WARN (upgraded from v1 FAIL)

| Judge | Perspective | Verdict | Confidence | Key Finding |
|-------|------------|---------|------------|-------------|
| 1 | missing-requirements | WARN | HIGH | Tier transition mechanics and Phase 1 exit criteria need sharpening |
| 2 | feasibility | WARN | HIGH | Factor rewrites 2x larger than estimated (96-144 hrs, not 48-72) |
| 3 | scope | WARN | HIGH | README + substance checks + Without Tooling = unacknowledged additive scope |
| 4 | spec-completeness | WARN | HIGH | Phase 1 only ~60% mechanically verifiable; needs README checks, depth specs |
| 5 | user-value | **PASS** | HIGH | Tier 0 delivers real solo dev value in 5 minutes; all 3 personas served |
| 6 | adoption-barriers | **PASS** | HIGH | All 3 v1 FAIL blockers substantively fixed (not just acknowledged) |
| 7 | competitive-position | WARN | HIGH | Moat is real but time-sensitive; competitors can add basic compounding in weeks |

**Consensus rule:** Any FAIL = FAIL. Mixed PASS/WARN = WARN.

**Critical v1 → v2 improvement:** The adoption-barriers judge that FAILed v1 now PASSes v2. The 3 critical blockers (inverted adoption model, zero-infrastructure entry ramp, Factor VIII as hero) are substantively addressed.

---

## Shared Findings (5+ judges agree)

1. **v2 successfully addresses v1's FAIL.** All 7 judges agree the adoption model is genuinely inverted, the zero-infrastructure ramp is real, and knowledge compounding is correctly positioned as the hero. The v1 FAIL is resolved.

2. **Phase 1 effort is underestimated.** Current factors are 500-870 lines each. Complete rewrites = 96-144 hours (12-18 days), not the 48-72 implied. README structure, substance checks, and "Without Tooling" sections add unacknowledged scope.

3. **Phase 1 exit criteria need mechanical verifiability.** GOALS.yaml checks are improved but insufficient. No README section checks, no factor depth minimums, no archival manifest spec. An implementer could game current checks with stubs.

4. **Tier transition mechanics are missing.** Users can enter at Tier 0 (good), but there's no guidance on when/how to move up tiers. Learnings.md growth path, "when to level up" symptoms, and failure modes that motivate progression are all undefined.

5. **Knowledge compounding moat depends on execution speed.** The concept is defensible today but competitors (GSD, Superpowers) could add basic compounding in 2-4 weeks. The moat is implementation quality (quality gates + decay + semantic retrieval), not the idea itself.

---

## Recommendations (Priority Order)

### Address Before Implementation (3 items)

1. **Add Phase 1 exit criteria to GOALS.yaml** — README section checks, factor depth minimums (500+ words), "Without Tooling" checks for I-III, archival manifest check. Target: 90%+ mechanically verifiable.

2. **Revise Phase 1 time estimate** — Budget 12-18 days, not 6-9. Resequence: Archive+Mapping first (dependency blocker), then Factors I-III, then README, then IV-XII, then GOALS.yaml.

3. **Add content budgets** — 400-600 lines per factor file (prevent bloat, especially Factor I absorbing Factor II). README: 800-1000 lines.

### Address During Implementation (5 items)

4. **Add tier transition guidance** — "When to level up" symptoms for each tier, learnings.md growth handling (e.g., "when learnings.md exceeds ~200 lines, you're ready for Tier 3").

5. **Include concrete learnings.md examples** — Copy-paste examples in Tier 0 quickstart showing what good entries look like.

6. **Use descriptive tier names** — "Quickstart" instead of "Tier 0", "Foundation" instead of "Tier 1". Avoid hierarchy anxiety.

7. **Add proof point for knowledge compounding** — One real before/after example from internal usage. Extraordinary claims require ordinary evidence.

8. **Position as "foundation that amplifies existing tools"** — Not "complementary but separate" from GSD/Superpowers. "Your specs are better when agents have context discipline."

### Address Post-Implementation (2 items)

9. **Ship AgentOps flywheel within 8 weeks of publishing factors** — Moat is execution speed. Manual learnings.md doesn't scale; the automated flywheel is the real differentiator.

10. **Validate Phase 1 with 5+ external users before scoping Phase 2** — Can they complete Tier 0 from README alone in 5 minutes?

---

## Key Disagreements

### README timing: Phase 1 vs. Phase 1.5

- **scope:** Move README to Phase 2. Ship factors first, wrap in marketing later. This makes Phase 1 achievable in 3-4 weeks.
- **adoption-barriers:** README must ship with Phase 1. The 30-second pitch and quickstart ARE the adoption model inversion — without them, factors are just another manifesto.
- **Resolution:** README is core to the v2 value proposition. Ship it in Phase 1 but acknowledge it as 15-20 hours of product writing, not a trivial task.

### Vendor neutrality: Foundation-only vs. all factors

- **missing-requirements:** "Without Tooling" should extend to Factors VII-IX (or acknowledge where tooling becomes necessary).
- **competitive-position:** Foundation (I-VI) should be truly vendor-neutral; Knowledge (VII-IX) should explicitly say "best with tooling." This preserves the 12-Factor App analogy.
- **Resolution:** Both valid. The plan already implies this tiering. Make it explicit: "Foundation and Workflow factors work anywhere. Knowledge factors work best with tooling but principles are portable."

---

## Decision Gate

- [x] **PROCEED** — Council passed (WARN), v1 FAIL is resolved. Address the 3 pre-implementation items, then execute.
- [ ] ADDRESS — Fix concerns before implementing
- [ ] RETHINK — Fundamental issues, needs redesign
