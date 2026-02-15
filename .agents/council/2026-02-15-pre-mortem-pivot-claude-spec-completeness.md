# Council Review: Spec-Completeness Analysis

**Judge:** Council Member 4 (Spec-Completeness)
**Date:** 2026-02-15
**Plan:** Pivot Design (From Shift-Left Validation to Full AgentOps Discipline)

```json
{
  "verdict": "WARN",
  "confidence": "HIGH",
  "key_insight": "Plan has clear vision and boundaries, but execution spec is incomplete—GOALS.yaml only verifies factor file existence, not the actual pivot claims or factor content quality",
  "findings": [
    {
      "severity": "critical",
      "category": "verification",
      "description": "GOALS.yaml checks only that 12 factor files exist with 'Rule:' and 'What good looks like' sections, but does NOT verify any of the actual pivot content (tagline changes, framing removal, relationship to adjacent projects, etc.)",
      "recommendation": "Add conformance checks for pivot-specific claims: tagline in README, removal of old framing, presence of adjacent project relationships, and factor content quality beyond file existence",
      "fix": "Add goals: readme-contains-tagline, readme-links-agentops-plugin, readme-links-olympus, factors-contain-examples, factors-contain-rationale-not-just-rules",
      "why": "Current checks verify structure (files exist) but not substance (content matches plan). A pivot could be marked complete with 12 empty files containing only 'Rule:' and 'What good looks like' headers.",
      "ref": "/Users/fullerbt/gt/12factor/GOALS.yaml goals: all-factors-written"
    },
    {
      "severity": "critical",
      "category": "completeness",
      "description": "Implementation section lists 'Content that survives' and 'Content to archive' but provides no mechanical specification for how to archive or what archiving means (move to _archived/? delete? rename?)",
      "recommendation": "Define archival process: where content goes, how it's marked, whether it's linked from new content with 'superseded by' notices",
      "fix": "Add archival spec to plan: 'Move docs/old-validation-focus/ to _archived/2026-02-14-pre-pivot/, add README to archived dir explaining why content was superseded, update any incoming links to point to new factor files'",
      "why": "Without archival spec, different implementers will handle old content inconsistently (delete vs move vs leave in place with warning). This creates ambiguity and potential broken link cascades.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md line 233"
    },
    {
      "severity": "significant",
      "category": "verification",
      "description": "Plan claims 'README rewrite' with specific requirements (new tagline, individual-first framing, links to AgentOps plugin and Olympus) but GOALS.yaml only checks that old taglines are removed, not that new content is present",
      "recommendation": "Add positive verification checks for README rewrite: tagline present, AgentOps plugin linked, Olympus linked, individual-first framing present",
      "fix": "Add goals: readme-links-agentops (grep -q 'AgentOps plugin' README.md), readme-links-olympus (grep -q 'Olympus' README.md), readme-individual-first (grep -q 'individual' README.md)",
      "why": "Negative checks (old content gone) don't prove new content exists. README could pass current checks by deleting old taglines without adding the replacement.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md line 235-240, GOALS.yaml goal: readme-reflects-pivot"
    },
    {
      "severity": "significant",
      "category": "completeness",
      "description": "Plan says 'Marketplace skills: Reframe existing validation skills under Factor V' but does not specify which skills exist, what 'reframe' means mechanically, or acceptance criteria for completion",
      "recommendation": "Enumerate existing marketplace skills, define what 'reframe under Factor V' means (update descriptions? add tags? move directories?), and add conformance check",
      "fix": "Add to plan: 'Existing skills: /validate, /vibe, /retro. Reframe: update skill descriptions to reference Factor V, add tags (factor: V), update READMEs to position as Factor V implementations. Check: grep -q Factor skills/*/README.md'",
      "why": "Vague action verbs like 'reframe' without mechanical specification lead to implementation variance. One person might update READMEs, another might restructure directories, another might do nothing.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md line 242-244"
    },
    {
      "severity": "significant",
      "category": "completeness",
      "description": "Plan positions AgentOps plugin as 'reference implementation' and Olympus as 'scale factors demonstration' but does not specify what this means for this repo's content (link to them? embed examples? document integration?)",
      "recommendation": "Define how external projects are integrated into 12factor repo content: link placement, example usage, integration guides",
      "fix": "Add to plan: 'Link AgentOps plugin from README and Factor V. Link Olympus from README and Factors X-XII. Add examples/ directory with sample AgentOps plugin configurations demonstrating each factor.'",
      "why": "Relationships to adjacent projects are strategic positioning, but without content integration spec, readers won't know how to use those projects to implement the factors.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md line 23-30"
    },
    {
      "severity": "minor",
      "category": "verification",
      "description": "GOALS.yaml checks for 'internal link integrity' but only for markdown links in format '](./)' — does not catch absolute links, links without ./, or broken anchors (#section)",
      "recommendation": "Expand link checker to handle all markdown link formats and verify anchor targets exist",
      "fix": "Update no-broken-links check to use a proper markdown link parser (e.g., markdown-link-check) or expand grep pattern to cover [text](path) regardless of ./ prefix",
      "why": "Incomplete link checking gives false confidence. Broken links in other formats will slip through.",
      "ref": "/Users/fullerbt/gt/12factor/GOALS.yaml goal: no-broken-links line 34-45"
    },
    {
      "severity": "minor",
      "category": "completeness",
      "description": "Plan says 'Content that survives (reframed)' includes 'Validation patterns (now Factor V, not the whole thesis)' but does not specify what happens to existing validation-focused docs—do they get merged into Factor V file, linked, or rewritten?",
      "recommendation": "Specify disposition of existing validation content: merge into factors/05-validate-externally.md, move to examples/, or archive with redirect links",
      "fix": "Add to plan: 'Existing docs/validation.md content → merge core concepts into factors/05-validate-externally.md, move detailed patterns to examples/validation-patterns.md, archive old file with redirect link'",
      "why": "Ambiguity about existing content disposition leads to orphaned docs, redundant content, or accidental deletion of valuable material.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md line 218-222"
    }
  ],
  "recommendation": "Expand GOALS.yaml to verify pivot substance (not just structure), add mechanical archival specification, and define integration points with AgentOps/Olympus. Current plan is clear on vision and boundaries but underspecified on execution details.",
  "schema_version": 2
}
```

---

## Summary

The pivot design is **strategically sound** but **execution-incomplete**. The plan clearly defines boundaries (what's in scope: all 12 factors; what's out: validation-only framing), articulates the vision (full operational discipline, not just QA slice), and identifies adjacent projects. However, the execution specification has critical gaps.

## Critical Issues

### 1. Structure Without Substance

**Problem:** GOALS.yaml checks that 12 factor files exist with required sections, but not that those sections contain the actual pivot content.

**Concrete example:**
```bash
# This would PASS current checks:
# factors/01-context-is-everything.md
---
Rule: [empty]
What good looks like: [empty]
---
```

The file exists, has the required headers, but contains none of the content described in the pivot plan (40% rule, just-in-time context loading, handoff summaries, etc.).

**What's missing:** Content quality checks. For example:
- `factors/01-*.md` must mention "40%" or "context utilization"
- `factors/05-*.md` must mention "multi-model" or "external validation"
- Each factor file must contain at least one concrete example

### 2. Archival Without Process

**Problem:** Plan says "Content to archive" but doesn't specify how.

**Ambiguity cascade:**
- Where do archived files go? (`_archived/`, `docs/old/`, deleted entirely?)
- How are they marked? (README explaining supersession? Git commit message?)
- What happens to incoming links? (Redirect? 404? Warning banner?)

Different implementers will make different choices, leading to inconsistent handling of old content.

**What's missing:** Mechanical archival spec:
```yaml
archival_process:
  destination: "_archived/2026-02-14-pre-pivot/"
  index: "Create _archived/README.md explaining why content was superseded"
  links: "Add redirect notices to archived files pointing to new factor files"
  verification: "grep -r 'Shift-Left Validation' docs/ returns only _archived/"
```

### 3. Positive Checks Missing

**Problem:** GOALS.yaml checks that old framing is gone, but not that new framing is present.

**Current check:**
```yaml
! grep -q 'Shift-Left Validation' README.md
```

This passes if README is completely empty. It doesn't verify the new tagline exists.

**What's missing:**
```yaml
- id: readme-new-tagline
  check: grep -q 'Operational Discipline for Working With Agents' README.md

- id: readme-links-agentops
  check: grep -q 'AgentOps plugin' README.md

- id: readme-links-olympus
  check: grep -q 'Olympus' README.md
```

### 4. Vague Action Verbs

**Problem:** "Reframe existing validation skills under Factor V" — what does this mean mechanically?

Possible interpretations:
- Update skill descriptions to mention Factor V
- Move skill files to `skills/factor-v/`
- Add tags to skill metadata
- Rewrite skill READMEs
- All of the above?

**What's missing:** Specific actions with verification:
```yaml
- id: skills-reference-factor-v
  description: "All validation skills mention Factor V in their README"
  check: |
    for skill in skills/validate skills/vibe skills/retro; do
      grep -q 'Factor V' "$skill/README.md" || exit 1
    done
```

## Strengths

### Boundaries Are Clear

The plan explicitly states:
- **In scope:** All 12 factors with full writeups
- **Out of scope:** Validation-only framing, coding-agent-only positioning
- **Adjacent projects:** Defined relationships (12-Factor Agents: building vs operating, Vibe Coding: methodology vs operations)

This is excellent scoping. No ambiguity about what the pivot includes.

### Vision Is Coherent

The core insight ("agent output quality is determined by context input quality") is testable and drives all 12 factors. The progression (Foundation → Workflow → Knowledge → Scale) makes logical sense.

### Competitive Positioning Is Specific

PRODUCT.md explicitly differentiates from GSD, Superpowers, Agent OS, and Spec Kitty. Each comparison states what the competitor does and where 12-factor fits. This prevents scope creep ("we're not trying to be a project manager").

## What's Missing for Mechanical Verification

### Factor Content Quality

Add checks that verify factor files contain actual concepts, not just headers:

```yaml
- id: factor-01-forty-percent
  description: "Factor I mentions the 40% rule"
  check: grep -qi '40%' factors/01-context-is-everything.md

- id: factor-05-external-validation
  description: "Factor V mentions external validation or multi-model"
  check: grep -Eqi 'external validation|multi-model' factors/05-validate-externally.md
```

### Integration Specifications

Define how AgentOps plugin and Olympus are referenced:

```yaml
- id: agentops-plugin-linked
  description: "README links to AgentOps plugin repo"
  check: grep -q 'github.com/boshu2/agentops' README.md

- id: olympus-in-scale-section
  description: "Factors X-XII mention Olympus as scale demonstration"
  check: |
    grep -qi 'olympus' factors/10-isolate-workers.md && \
    grep -qi 'olympus' factors/11-supervise-hierarchically.md && \
    grep -qi 'olympus' factors/12-harvest-failures-as-wisdom.md
```

### Archival Process

Make archival mechanical:

```yaml
- id: old-content-archived
  description: "Old validation-focus content moved to _archived/ with index"
  check: |
    [ -d "_archived/2026-02-14-pre-pivot" ] && \
    [ -f "_archived/README.md" ] && \
    ! find docs/ -name '*.md' -exec grep -l 'Shift-Left Validation' {} \; | grep -v _archived
```

## Verdict Rationale

**WARN** instead of **FAIL** because:
- The strategic vision is clear and well-bounded
- GOALS.yaml covers structural requirements (files exist, naming is consistent)
- The plan is executable — someone could implement it

**WARN** instead of **PASS** because:
- Conformance checks verify structure, not substance
- Execution details are underspecified (archival, skill reframing, external project integration)
- No verification that factor content actually matches the pivot description

A team could complete all current goals and still have a hollow pivot (12 files with headers but no content, old framing removed but no new framing added, marketplace skills untouched).

## Recommendations

### Immediate (before implementation):

1. **Add substance checks to GOALS.yaml:**
   - Each factor file contains key concepts from the plan
   - README contains new tagline and links
   - Archived content is properly indexed

2. **Define archival process:**
   - Where old content goes
   - How it's marked
   - Link redirect strategy

3. **Specify marketplace skill changes:**
   - Which skills are affected
   - What "reframe" means mechanically
   - Verification check

### Medium-term (during implementation):

4. **Add content quality metrics:**
   - Factor files have examples, not just rules
   - Factor files link to reference implementations
   - Factor files cite evidence (research, benchmarks)

5. **Define integration touchpoints:**
   - How AgentOps plugin is demonstrated
   - How Olympus scale patterns are referenced
   - Whether example configurations are included

## Conclusion

This plan has **high strategic clarity** but **medium execution completeness**. The boundaries are clear, the vision is coherent, and the competitive positioning is specific. However, the conformance checks are structurally sound but substantively hollow.

**To move from WARN to PASS:** Add verification that checks content, not just headers. Define archival process mechanically. Specify what "reframe" means for marketplace skills. Clarify how external projects are integrated.

The plan is good enough to start. It's not yet tight enough to finish without ambiguity.
