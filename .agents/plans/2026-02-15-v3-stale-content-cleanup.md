# Plan: Clean Up Remaining Stale V1/V2 Content

**Date:** 2026-02-15
**Source:** Audit via Explore agent + manual review

## Overview

Remove remaining v1/v2 framing (Five Pillars, Nine Laws, FAAFO) from active docs and GitHub templates after the v3 operational discipline pivot.

## Boundaries

**Always:** Preserve historical context in explanation docs (faafo-north-star.md, standing-on-giants.md etc.) — those reference old concepts as history, which is appropriate.
**Ask First:** N/A (auto mode)
**Never:** Modify _archived/ or .agents/ content. Don't touch CHANGELOG.md v1/v2 entries.

## Baseline Audit

| Metric | Command | Result |
|--------|---------|--------|
| Five Pillars/Nine Laws in docs/README.md | `grep -n 'Five Pillars\|Nine Laws' docs/README.md` | 4 lines (76, 77, 92, 93) |
| Five Pillars/Nine Laws in pattern-proposal.md | `grep -n 'Five Pillars\|Nine Laws' .github/ISSUE_TEMPLATE/pattern-proposal.md` | 3 lines (37, 102, 104) |
| FAAFO refs in getting-started/README.md | `grep -n 'FAAFO\|Five Pillars' docs/getting-started/README.md` | 6 lines |
| Lines in five-pillars.md | `wc -l docs/principles/five-pillars.md` | 589 |
| Lines in nine-laws.md | `wc -l docs/principles/nine-laws.md` | 308 |
| FEATURE_REQUEST_preview_section.md exists | `ls .github/FEATURE_REQUEST_preview_section.md` | exists (123 lines, completed v1 FR) |

## Conformance Checks

| Issue | Check Type | Check |
|-------|-----------|-------|
| 1 | files_exist | `docs/_archived/principles/five-pillars.md`, `docs/_archived/principles/nine-laws.md` exist |
| 1 | content_check | `! test -f docs/principles/five-pillars.md && ! test -f docs/principles/nine-laws.md` |
| 2 | content_check | `grep -c 'Five Pillars\|Nine Laws' docs/README.md` = 0 |
| 3 | content_check | `grep -c 'Five Pillars\|Nine Laws' .github/ISSUE_TEMPLATE/pattern-proposal.md` = 0 |
| 4 | content_check | `! test -f .github/FEATURE_REQUEST_preview_section.md` |
| 5 | content_check | `grep -c 'FAAFO' docs/getting-started/README.md` = 0 |

## Issues

### Issue 1: Archive five-pillars.md and nine-laws.md
**Dependencies:** None
**Acceptance:** Files moved to docs/_archived/principles/, removed from docs/principles/, principles/README.md updated to remove references
**Description:** Move docs/principles/five-pillars.md and docs/principles/nine-laws.md to docs/_archived/principles/. Update docs/principles/README.md to remove the Foundation Documents entries for these two files.

### Issue 2: Remove Five Pillars/Nine Laws from docs/README.md
**Dependencies:** None
**Acceptance:** Zero references to Five Pillars or Nine Laws in docs/README.md
**Description:** Remove lines 76-77 (reference section listing Five Pillars and Nine Laws) and lines 92-93 (explanation section linking to five-pillars.md and nine-laws.md). Replace with links to the 12 Factors and principles/README.md.

### Issue 3: Update pattern-proposal.md for v3 framing
**Dependencies:** None
**Acceptance:** Zero references to Five Pillars or Nine Laws in pattern-proposal.md
**Description:** Replace "Five Pillars" checklist (lines 37-42) with 12 Factors checklist. Replace "Compliance with Nine Laws" section (lines 102-111) with "Alignment with 12 Factors" section. Update checklist item line 137.

### Issue 4: Remove completed FEATURE_REQUEST_preview_section.md
**Dependencies:** None
**Acceptance:** File deleted
**Description:** Delete .github/FEATURE_REQUEST_preview_section.md — a completed v1 feature request that is no longer relevant.

### Issue 5: Update getting-started/README.md for v3 framing
**Dependencies:** None
**Acceptance:** Zero references to FAAFO or Five Pillars in docs/getting-started/README.md
**Description:** Replace FAAFO references with v3 operational discipline framing. Update journey paths to use v3 language. Remove Five Pillars reference from philosophy path. Keep links to explanation docs (those explain history).

## Execution Order

**Wave 1** (all parallel): Issue 1, Issue 2, Issue 3, Issue 4, Issue 5

Micro-epic: 5 issues, 1 wave, all independent.

## Next Steps
- Fast-path: skip full council for pre-mortem/vibe (--quick)
- All issues are independent → single wave parallel execution
