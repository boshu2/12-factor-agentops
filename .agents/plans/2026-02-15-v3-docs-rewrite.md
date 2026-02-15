# Plan: Full v3 Documentation Rewrite

**Date:** 2026-02-15
**Source:** .agents/research/2026-02-15-v3-docs-rewrite-inventory.md

## Overview

Rewrite all non-factor documents, SVGs, and carousel slides to align with the v3 philosophy: "The Operational Discipline for Working With AI Agents." The 12 factors and README were rewritten in epic 12-3jc; this epic covers everything else.

## Boundaries

**Always:**
- Use v3 factor names (I. Context Is Everything through XII. Harvest Failures as Wisdom)
- Use v3 tagline: "The Operational Discipline for Working With AI Agents"
- Reference 4-tier structure: Foundation (I-III), Workflow (IV-VI), Knowledge (VII-IX), Scale (X-XII optional)
- Factor VIII as hero differentiator (knowledge compounding flywheel)
- Inverted adoption model (quickstart → principles, not manifesto → tooling)
- "Without Tooling" principle: every factor works manually
- Preserve useful content — reframe, don't delete valuable substance
- No stale framing: no "Shift-Left Validation", no "DevOps for Vibe-Coding", no "coding agents only"
- All internal markdown links must resolve to existing files
- SVGs must use v3 tier names: Foundation, Workflow, Knowledge, Scale

**Ask First:** (logged only in auto mode)
- Whether to delete factors/README.md entirely or replace with redirect
- Whether to archive or rewrite docs/case-studies/enterprise-validation.md

**Never:**
- Don't touch _archived/ files (historical record)
- Don't touch factor files (already v3 from epic 12-3jc)
- Don't touch README.md, PRODUCT.md, GOALS.yaml (already v3)
- Don't invent new factors or change factor definitions
- Don't add new documents — only rewrite existing ones

## Baseline Audit

| Metric | Command | Result |
|--------|---------|--------|
| Files with old framing strings | `grep -rl 'Shift-Left\|DevOps for Vibe' docs/ CONTRIBUTING.md marketplace/ \| wc -l` | 2 |
| Files with old factor names | `grep -rl 'Automated Tracking\|Context Loading\|...' docs/ factors/README.md marketplace/ \| wc -l` | 32 |
| SVGs with old content | `grep -rl old_names docs/assets/*.svg docs/assets/carousel/*.svg \| wc -l` | 4 main + 2 carousel = 6 |
| Total non-archived MD files in docs/ | `find docs/ -name "*.md" -not -path "*/_archived/*" \| wc -l` | 34 |
| Total SVG files | `ls docs/assets/*.svg docs/assets/carousel/*.svg \| wc -l` | 17 |
| CONTRIBUTING.md words | `wc -w < CONTRIBUTING.md` | 1,118 |
| docs/00-SUMMARY.md words | `wc -w < docs/00-SUMMARY.md` | 1,368 |
| factors/README.md words | `wc -w < factors/README.md` | 1,543 |

## Conformance Checks

| Issue | Check Type | Check |
|-------|-----------|-------|
| All issues | content_check | `! grep -rl 'Shift-Left\|DevOps for Vibe\|coding agents only' docs/ CONTRIBUTING.md marketplace/ \| grep -v _archived \| grep -v docs/plans/` |
| All issues | content_check | `! grep -rl 'Automated Tracking\|Context Loading\|Focused Agents\|Continuous Validation\|Smart Routing\|Human Validation\|Mine Patterns\|Small Iterations\|Fail-Safe Checks\|Package Patterns' docs/ factors/README.md CONTRIBUTING.md marketplace/ \| grep -v _archived \| grep -v docs/plans/` |
| SVG issues | content_check | `! grep -rl 'Automated Tracking\|Shift-Left' docs/assets/*.svg docs/assets/carousel/*.svg` |

## Issues

### Issue 1: Rewrite CONTRIBUTING.md
**Dependencies:** None
**Acceptance:** No old framing strings. Contains v3 philosophy section. References v3 factor names. 800+ words.
**Design Brief:** CONTRIBUTING.md is the contributor gateway. It should explain the v3 philosophy (operational discipline, not just validation), describe what contributions are valued (operational patterns, knowledge compounding patterns, not just "validation skills"), and provide the skill template updated for v3 framing. Keep the contribution process sections (PR workflow, skill template) but reframe around operational discipline.
**Description:** Full rewrite. Replace "Philosophy: Validation First" with operational discipline framing. Update DevOps mapping table. Replace "Add Validation Skills" with broader contribution model. Update skill template. Remove "shift validation left — together" tagline.

### Issue 2: Rewrite docs/00-SUMMARY.md
**Dependencies:** None
**Acceptance:** No old factor names. No stale framing. 800+ words. v3 factor table with 4 tiers.
**Design Brief:** 00-SUMMARY.md is the compressed context document (~10k tokens) that agents load for full-corpus understanding. Rewrite with v3 factor names, 4-tier structure, knowledge flywheel, inverted adoption model, and updated ecosystem positioning. Keep the failure patterns section but map to v3 factor names.
**Description:** Full rewrite. Replace old 12-factor table (I-XII with old names) with v3 names and 4 tiers. Update ecosystem table (BUILD→WORK→RUN). Replace "Shift-left validation for vibe-coding" positioning. Update pain point quick reference. Update knowledge flywheel section.

### Issue 3: Replace factors/README.md
**Dependencies:** None
**Acceptance:** File either removed or replaced with v3 index. No old factor names.
**Design Brief:** The old factors/README.md is a 1,543-word v1 index file with old factor names and constraint mapping. Replace with a lean index that lists the 12 v3 factors organized by tier, linking to each factor file. No need for deep content — the main README.md serves as the authoritative overview.
**Description:** Replace with a clean v3 factor index: 4 tiers, 12 factors with one-line rules, links to each factor file. Remove old constraint mapping table.

### Issue 4: Rewrite docs/tutorials/ (2 files)
**Dependencies:** None
**Acceptance:** No old framing. No old factor names. Both files 800+ words. Updated factor references.
**Design Brief:** Tutorials teach the v3 workflow through examples. validate-before-you-ship.md should be reframed around the full operational discipline (research → plan → implement → validate → extract → compound), not just "shift-left validation." workflow-guide.md should cover the complete session workflow with v3 skill names. Both should reference v3 factor names and link to correct factor files.
**Description:** Rewrite validate-before-you-ship.md: update title focus from "Shift-Left" to operational discipline, update factor references (old Factor IV → new Factor V), update Related Resources links. Rewrite workflow-guide.md: align with v3 session workflow.

### Issue 5: Rewrite docs/principles/ indexes (3 files)
**Dependencies:** None
**Acceptance:** No old factor names in README.md, comparison-table.md, evolution-of-12-factor.md.
**Design Brief:** The principles/ directory is the theoretical foundation. README.md is the index — update factor names and links. comparison-table.md maps 12-Factor App → 12-Factor Agents → 12-Factor AgentOps — update the AgentOps column with v3 names. evolution-of-12-factor.md traces the evolution — add v3 as the latest stage with the operational discipline framing.
**Description:** Rewrite 3 files: principles/README.md (index with v3 names), comparison-table.md (v3 column), evolution-of-12-factor.md (add v3 stage).

### Issue 6: Rewrite docs/how-to/README.md + docs/reference/README.md
**Dependencies:** None
**Acceptance:** No old factor names. Updated links. v3 framing.
**Design Brief:** These are hub/index pages for their respective Diataxis categories. Update factor references, skill references, and framing to v3. Keep the structural role (linking to content pages) but ensure all references use v3 names.
**Description:** Rewrite both index pages with v3 factor names and updated links.

### Issue 7: Rewrite docs/explanation/vibe-coding-integration.md
**Dependencies:** None
**Acceptance:** No "DevOps for Vibe-Coding". No old factor names. v3 positioning.
**Design Brief:** This explains how 12-Factor AgentOps relates to vibe coding. Reframe: vibe coding is a practice; 12-Factor AgentOps is the operational discipline underneath it. Not "DevOps for Vibe-Coding" but "the operational principles that make vibe coding reliable." Update all factor references to v3 names.
**Description:** Full rewrite. Replace "DevOps for Vibe-Coding" framing. Position as operational discipline underneath vibe coding practice. Update factor references.

### Issue 8: Rewrite docs/case-studies/ + marketplace/ docs (4 files)
**Dependencies:** None
**Acceptance:** No old factor names. No stale framing. Updated factor references.
**Design Brief:** enterprise-validation.md should be reframed around operational discipline results (not just "validation" results). marketplace/README.md should describe the marketplace as operational discipline skills (not just validation skills). factor-compliance-checker/skill.md and cross-reference-validator/skill.md need v3 factor names.
**Description:** Rewrite 4 files: enterprise-validation.md, marketplace/README.md, marketplace/factor-compliance-checker/skill.md, marketplace/cross-reference-validator/skill.md.

### Issue 9: Alignment pass — docs/getting-started/ (2 files)
**Dependencies:** None
**Acceptance:** No old factor names. v3 framing. Updated factor references.
**Description:** Alignment pass on quick-start.md and solo-developer.md. Update old factor references to v3 names. Remove "validation-only" framing where present. Keep useful content about adoption path.

### Issue 10: Alignment pass — docs/principles/ content (4 files)
**Dependencies:** None
**Acceptance:** No old factor names in five-pillars.md, nine-laws.md, context-engineering.md, constraint-based-engineering.md.
**Description:** Alignment pass on 4 principles content files. Update old factor name references to v3. Update "Five Pillars" to align with 4-tier structure. Ensure knowledge compounding and operational discipline framing.

### Issue 11: Alignment pass — docs/explanation/ (5 files)
**Dependencies:** None
**Acceptance:** No old factor names in from-theory-to-production.md, standing-on-giants.md, three-developer-loops.md, ai-summit-validation-2025.md, phoenix-project-lineage.md.
**Description:** Alignment pass on 5 explanation files. Update old factor references to v3 names. Keep heritage/lineage content but ensure v3 positioning.

### Issue 12: Alignment pass — docs/README.md + docs/ecosystem.md + remaining reference files
**Dependencies:** None
**Acceptance:** No old factor names in docs/README.md, docs/ecosystem.md, docs/reference/failure-patterns.md, docs/reference/scientific-foundation.md, docs/reference/anthropic-long-running-agents.md.
**Description:** Alignment pass on 5 files. Update factor references to v3 names. Update docs hub links if needed.

### Issue 13: Regenerate SVGs — main diagrams (5 files)
**Dependencies:** None
**Acceptance:** No old factor names in any SVG. SVGs use 4-tier names: Foundation, Workflow, Knowledge, Scale.
**Design Brief:** The 5 main SVGs (12-factor-landscape.svg, 12-factor-landscape-animated.svg, 12-factor-animated.svg, workflow-flow.svg, workflow-flow-animated.svg) visualize the factor framework. Update all factor names to v3. Update tier labels from Foundation/Operations/Improvement to Foundation/Workflow/Knowledge/Scale. Keep the visual structure but swap text content.
**Description:** Edit SVG text elements to replace old factor names with v3 names. Update tier labels. Ensure animated variants match static variants.

### Issue 14: Regenerate SVGs — carousel slides (12 files) + asset README
**Dependencies:** None
**Acceptance:** No old factor names in carousel SVGs. docs/assets/README.md updated.
**Design Brief:** 12 carousel slides for presentations. slide-04 (framework) and slide-07 (improvement) confirmed to have old factor names. Check all 12 slides and update any that reference old names/tiers. Then update docs/assets/README.md asset catalog.
**Description:** Edit carousel SVG text for v3 factor names. Update docs/assets/README.md catalog.

### Issue 15: CHANGELOG v3.1 entry + final link verification
**Dependencies:** Issues 1-14
**Acceptance:** CHANGELOG has v3.1 entry. Zero broken internal markdown links in active docs.
**Description:** Add CHANGELOG entry for v3.1 documentation rewrite. Run broken link check across all active docs. Fix any broken links found.

## Execution Order

**Wave 1** (parallel): Issues 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
**Wave 2** (after Wave 1): Issue 15

## Next Steps
- Run `/pre-mortem` for failure simulation
- Then `/crank` for autonomous execution
