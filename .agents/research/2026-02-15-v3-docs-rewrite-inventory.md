# Research: v3 Documentation Full Rewrite

**Date:** 2026-02-15
**Backend:** claude-native-teams (2 Explore agents)
**Scope:** Complete inventory of all non-factor documents needing v3 alignment, plus SVG assets

## Summary

The v3 pivot rewrote all 12 factors, README, and GOALS.yaml but left 30+ supporting documents, 5 SVGs, and 12 carousel slides untouched. Most still reference v2 framing ("Shift-Left Validation for Coding Agents", old factor names I-XII, "DevOps for Vibe-Coding"). This RPI will bring all docs into v3 alignment: "The Operational Discipline for Working With AI Agents."

## v3 Philosophy (Reference for Rewriters)

- **Tagline:** "The Operational Discipline for Working With AI Agents"
- **Core insight:** "The model isn't the problem. The operations are."
- **4 Tiers:** Foundation (I-III), Workflow (IV-VI), Knowledge (VII-IX), Scale (X-XII, optional)
- **Hero:** Factor VIII Compound Knowledge — the flywheel that can't be commoditized
- **Adoption:** Inverted — 5-min quickstart with learnings.md, then principles
- **Without Tooling:** Every factor can be applied manually
- **Personas:** Solo dev, tech lead, tool builder
- **Position:** Foundation that amplifies existing tools (GSD, Superpowers, etc.)

## v3 Factor Names (New)

| # | New Name | Old Name |
|---|----------|----------|
| I | Context Is Everything | Automated Tracking / Context Loading |
| II | Track Everything in Git | (was I) Automated Tracking |
| III | One Agent, One Job | Focused Agents |
| IV | Research Before You Build | (NEW) |
| V | Validate Externally | Continuous Validation |
| VI | Lock Progress Forward | Resume Work |
| VII | Extract Learnings | Mine Patterns |
| VIII | Compound Knowledge | (NEW - hero) |
| IX | Measure What Matters | Measure Everything |
| X | Isolate Workers | Small Iterations (Scale, optional) |
| XI | Supervise Hierarchically | (NEW - Scale, optional) |
| XII | Harvest Failures as Wisdom | Fail-Safe Checks (Scale, optional) |

## Documents Inventory

### STALE — Full Rewrite Required (15 files)

| # | File | Words | Key Issues |
|---|------|-------|-----------|
| 1 | `CONTRIBUTING.md` | 1,118 | "Philosophy: Validation First", "Shift-Left", old DevOps table, validation-only contribution model |
| 2 | `docs/00-SUMMARY.md` | 1,368 | Old factor names (I-XII all wrong), "Shift-left validation for vibe-coding", old ecosystem table, old failure pattern mapping |
| 3 | `factors/README.md` | 1,543 | v1 factor index with all old names. Should be removed or replaced. |
| 4 | `docs/tutorials/validate-before-you-ship.md` | 1,877 | Title is v2. "Shift-Left Workflow" header. References old factor IV name. |
| 5 | `docs/tutorials/workflow-guide.md` | 1,606 | Validation-centric workflow framing |
| 6 | `docs/explanation/vibe-coding-integration.md` | 2,412 | "DevOps for Vibe-Coding" throughout |
| 7 | `docs/principles/README.md` | 2,180 | Old factor names in index, old constraint mapping |
| 8 | `docs/principles/comparison-table.md` | 1,824 | Maps to old factor names |
| 9 | `docs/principles/evolution-of-12-factor.md` | 2,072 | Old factor evolution mapping |
| 10 | `docs/how-to/README.md` | 573 | Validation-centric headers |
| 11 | `docs/reference/README.md` | 1,110 | Reference index with old names |
| 12 | `docs/case-studies/enterprise-validation.md` | 1,478 | "Validation" in title, old factor refs |
| 13 | `marketplace/README.md` | 352 | "Validation skills" framing |
| 14 | `marketplace/factor-compliance-checker/skill.md` | 413 | Old factor names |
| 15 | `marketplace/cross-reference-validator/skill.md` | 538 | Old factor references |

### PATCHED — Needs Alignment Pass (13 files)

| # | File | Words | Issues |
|---|------|-------|--------|
| 16 | `docs/README.md` | 942 | Mostly v3, some old "SRE to their DevOps" language |
| 17 | `docs/ecosystem.md` | 1,332 | Good v3, minor old language |
| 18 | `docs/getting-started/quick-start.md` | 1,134 | Some validation language |
| 19 | `docs/getting-started/solo-developer.md` | 2,194 | Heavy validation framing |
| 20 | `docs/principles/five-pillars.md` | 2,965 | Mixed old/new |
| 21 | `docs/principles/nine-laws.md` | 1,338 | Laws include knowledge compounding but also validation |
| 22 | `docs/principles/context-engineering.md` | 2,651 | 40% rule (keep), validation framing |
| 23 | `docs/principles/constraint-based-engineering.md` | 2,817 | Good foundation, some validation |
| 24 | `docs/explanation/from-theory-to-production.md` | 2,347 | Production patterns, some validation |
| 25 | `docs/explanation/standing-on-giants.md` | 2,699 | Heritage doc, DevOps/SRE framing |
| 26 | `docs/explanation/three-developer-loops.md` | 2,325 | Loops framework, validation in context |
| 27 | `docs/explanation/ai-summit-validation-2025.md` | 2,129 | Summit validation, industry convergence |
| 28 | `docs/explanation/phoenix-project-lineage.md` | 2,085 | Origin story, DevOps lineage |

### SVGs — Need Regeneration (17 files)

| # | File | Old Content Confirmed |
|---|------|-----------------------|
| 29 | `docs/assets/12-factor-landscape.svg` | Yes — old factor names |
| 30 | `docs/assets/12-factor-landscape-animated.svg` | Yes — old factor names |
| 31 | `docs/assets/12-factor-animated.svg` | Yes — old factor names |
| 32 | `docs/assets/workflow-flow.svg` | Unknown — workflow diagram |
| 33 | `docs/assets/workflow-flow-animated.svg` | Unknown — workflow diagram |
| 34-45 | `docs/assets/carousel/slide-01-*.svg` through `slide-12-*.svg` | slide-04 (framework) and slide-07 (improvement) confirmed old names |
| 46 | `docs/assets/README.md` | Asset catalog — update after SVGs |

### CURRENT — No Changes Needed (8 files)

| File | Notes |
|------|-------|
| `README.md` | v3 complete |
| `PRODUCT.md` | v3 complete |
| `GOALS.yaml` | v3 complete |
| `CODE_OF_CONDUCT.md` | Standard CoC |
| `docs/getting-started/README.md` | Clean hub |
| `docs/principles/knowledge-os.md` | v3 aligned |
| `docs/explanation/faafo-north-star.md` | v3 aligned |
| `docs/explanation/beads-workflow-integration.md` | Neutral |

### ARCHIVED — Skip (historical)

| Path | Notes |
|------|-------|
| `_archived/factors-v1/*` | v1 archive — preserve |
| `docs/_archived/*` | Old case studies — preserve |

### UNKNOWN — Need Review

| File | Notes |
|------|-------|
| `docs/explanation/ecosystem-position.md` | Probably current |
| `docs/reference/anthropic-long-running-agents.md` | External reference |
| `docs/reference/failure-patterns.md` | Patched but useful |
| `docs/reference/scientific-foundation.md` | Research grounding |
| `marketplace/nine-laws-auditor/skill.md` | Partially updated |
| `marketplace/pattern-extraction-assistant/skill.md` | Likely current |
| `marketplace/research-formatter/skill.md` | Likely current |
| `.github/*` | Templates — likely current |
| `CHANGELOG.md` | Needs v3.0 entry |

## Scope Estimate

- **Full rewrites:** 15 markdown files (~24k words total)
- **Alignment passes:** 13 markdown files (~28k words total)
- **SVG regeneration:** 17 SVG files (5 main + 12 carousel slides)
- **Asset catalog update:** 1 file
- **Changelog update:** 1 file
- **Total files to touch:** ~47 files

## Recommendations

1. **Wave 1 (parallel):** Rewrite 15 stale files — all independent, no cross-deps
2. **Wave 2 (parallel):** Alignment pass on 13 patched files
3. **Wave 3 (parallel):** Regenerate SVGs with v3 factor names/tiers
4. **Wave 4:** Update asset README, CHANGELOG, final link check
