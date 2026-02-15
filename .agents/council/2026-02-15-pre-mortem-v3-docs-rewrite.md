# Pre-Mortem: v3 Documentation Full Rewrite

**Date:** 2026-02-15
**Plan/Spec:** .agents/plans/2026-02-15-v3-docs-rewrite.md
**Epic:** 12-pr7 (15 issues, 2 waves)

## Council Verdict: WARN

| Judge | Verdict | Key Finding |
|-------|---------|-------------|
| Missing-Requirements | WARN | No content depth validation per persona, no GOALS.yaml for this epic, SVG approach vague, no rollback gate, "preserve valuable content" undefined, markdown↔SVG coordination missing |
| Feasibility | WARN | Cross-reference desync risk with 14 parallel writers, SVG text editing reliability concerns, animated SVG complexity, Issue 8 scope explosion risk, alignment pass ambiguity |
| Scope | WARN | Carousel regeneration may be unnecessary (not referenced in docs), Issue 8 needs scope clarification, alignment passes are NOT cosmetic — 10-20+ old refs each |
| Spec-Completeness | PASS | Boundaries well-defined, conformance checks mechanically specific, all verifiable. Minor: SVG check missing from GOALS.yaml, per-issue acceptance criteria not inline |
| User-Value | WARN | Plan conflates internal consistency with user value. Only 8-10 files block adoption. Recommends 2-phase: critical path first, then supporting content |
| Adoption-Barriers | WARN | Terminology drift between README (v3) and tutorials (v2) creates confusion, missing knowledge compounding bridge doc, tier system opacity in quick-start |
| Competitive-Position | WARN | Comparison docs don't emphasize layering beneath competitors, external validation invisible in "operational discipline" framing, knowledge compounding moat under-emphasized |

## Shared Findings

- SVG text replacement approach needs more specificity (which text elements, how to handle animated variants)
- Cross-reference integrity is the biggest risk with 14 parallel writers
- Issue 8 (4 files: enterprise-validation.md, marketplace/README.md, 2 skill.md files) is broader than other issues
- Alignment passes are substantive work, not cosmetic — each file has 10-20+ old references
- Critical-path prioritization (tutorials, getting-started, CONTRIBUTING) would deliver faster user value

## Concerns Raised

1. **No GOALS.yaml for this epic** — previous epic used mechanically-verifiable exit criteria; this one relies on grep-based conformance checks only
2. **SVG animated variants** — text replacement in animated SVGs may break animations
3. **"Preserve valuable content"** — subjective without definition; workers may interpret differently
4. **Carousel slides may be unused** — scope judge found no references to carousel SVGs in docs
5. **Cross-reference desync** — 14 parallel writers updating links simultaneously

## Recommendation

Proceed with WARN. The plan is sound and the conformance checks (grep for old framing strings and old factor names) provide mechanical verification. Key mitigations:
- Wave vibe gate after Wave 1 will catch cross-reference issues
- SVG text replacement is lower-risk than full regeneration
- Issue 8's 4 files are all small (<600 words each)

## Decision Gate

[x] PROCEED - Council warned but no blockers. Accept risk and proceed.
[ ] ADDRESS - Fix concerns before implementing
[ ] RETHINK - Fundamental issues, needs redesign
