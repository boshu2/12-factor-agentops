```json
{
  "verdict": "WARN",
  "confidence": "HIGH",
  "key_insight": "The pivot from validation-focused to full operational discipline is sound, but the implementation plan has massive hidden scope in content rewrite and unclear boundaries between archive/refactor/new work.",
  "findings": [
    {
      "severity": "critical",
      "category": "scope",
      "description": "All 12 existing factor files must be rewritten but plan says only 'Content that survives (reframed)' without acknowledging the full rewrite scope",
      "recommendation": "Create explicit task breakdown: rewrite Factor I-XII (12 files), not 'reframe existing content'",
      "fix": "Add bead per factor: 'Rewrite Factor [I-XII] for pivot' with acceptance criteria for each",
      "why": "Current factors are deeply tied to validation-first narrative. Factor I is 'Automated Tracking' not 'Context Is Everything'. This isn't light editing—it's complete rewrites.",
      "ref": "/Users/fullerbt/gt/12factor/factors/01-automated-tracking.md vs pivot line 40-44"
    },
    {
      "severity": "critical",
      "category": "scope",
      "description": "README rewrite described as '4 bullet points' but current README has complex structure: badges, animated SVGs, factor table, collapsible sections, links to archived content, 216 lines total",
      "recommendation": "Break README rewrite into phases: 1) Content pivot (tagline, positioning, factor summaries), 2) Asset updates (SVGs), 3) Link/structure cleanup",
      "fix": "Create 3 beads: 'README content pivot', 'README visual assets', 'README structure cleanup'",
      "why": "Treating a 216-line orchestrated README as a simple 'rewrite' hides 10-20 hours of work including asset regeneration, cross-reference updates, and structure decisions.",
      "ref": "/Users/fullerbt/gt/12factor/README.md (216 lines with embedded assets)"
    },
    {
      "severity": "significant",
      "category": "creep",
      "description": "Plan mentions 'Consider new skills for other factors' with no boundary—this could balloon from 5 skills to 12+ skills",
      "recommendation": "Either scope as 'no new skills in pivot phase' or define concrete limits: 'add 3 skills for Factors I, IV, VII only'",
      "fix": "Add decision: 'New skills are out of scope for pivot. Evaluate post-launch based on adoption.'",
      "why": "Marketplace already has 5 validation-focused skills. Without boundaries, 'consider new skills' becomes open-ended feature development.",
      "ref": "Pivot plan line 244-245, marketplace/ has 5 existing skills"
    },
    {
      "severity": "significant",
      "category": "scope",
      "description": "Archive boundary unclear: plan lists 3 categories to archive but doesn't specify which files move and which stay",
      "recommendation": "Create explicit archive manifest: list every file that moves to docs/_archived/ with one-line rationale",
      "fix": "Add bead: 'Create archive manifest' with deliverable: docs/_archived/ARCHIVE-MANIFEST.md listing all moved files",
      "why": "Current _archived/ has case-studies/, domain-guides/, and root README. Without a manifest, archive decisions will be rediscussed multiple times during execution.",
      "ref": "/Users/fullerbt/gt/12factor/docs/_archived/ structure"
    },
    {
      "severity": "significant",
      "category": "complexity",
      "description": "Plan treats 'reframe existing validation skills under Factor V' as minor work but skills have .claude-plugin/plugin.json metadata that may need schema changes",
      "recommendation": "Validate skill metadata compatibility first: do existing skills work under new Factor V framing or do they need plugin.json updates?",
      "fix": "Add validation bead: 'Audit skill plugin.json compatibility with Factor V pivot'",
      "why": "Skills marketplace has .claude-plugin/plugin.json for each skill. If metadata (tags, descriptions, triggers) is tied to old framing, 'reframe' becomes 'rewrite metadata + skill.md + references/'.",
      "ref": "/Users/fullerbt/gt/12factor/marketplace/*/. claude-plugin/plugin.json files"
    },
    {
      "severity": "significant",
      "category": "creep",
      "description": "Factors X-XII described as 'new' but plan doesn't clarify if these are net-new content or refactored from existing docs/ material",
      "recommendation": "Specify source material for X-XII: Are these purely new or do they pull from existing beads-workflow-integration.md, olympus references, etc.?",
      "fix": "Add note: 'Factor X-XII pull from existing Gas Town/Olympus patterns, not greenfield research'",
      "why": "If X-XII are greenfield, that's 30-50 hours of research + writing. If they're refactors of existing material, that's 10-15 hours. Massive difference.",
      "ref": "Pivot plan lines 176-212 (Factor X-XII content)"
    },
    {
      "severity": "minor",
      "category": "scope",
      "description": "Plan lists 'Olympus demonstrates scale factors' but doesn't clarify if Olympus needs docs updates to reference 12-Factor AgentOps back",
      "recommendation": "Decide now: Does Olympus repo get updated to link back to 12-Factor AgentOps or is that out of scope?",
      "fix": "Add decision: 'Olympus cross-reference updates are out of scope for pivot. Add as follow-on work if adoption warrants.'",
      "why": "Cross-repo coordination is always 3x harder than estimated. Either scope it explicitly or rule it out.",
      "ref": "Pivot plan line 30 mentions Olympus relationship"
    },
    {
      "severity": "minor",
      "category": "complexity",
      "description": "PRODUCT.md competitive landscape has 4 detailed entries that may need updates if positioning shifts from 'validation slice' to 'full operational discipline'",
      "recommendation": "Review competitive positioning after factor rewrites, not before—competitors may map differently once factors change",
      "fix": "Add bead: 'Update PRODUCT.md competitive landscape post-pivot' as cleanup work, not pre-work",
      "why": "GSD/Superpowers/Agent OS comparisons are currently framed around 'validation vs methodology'. New framing may need new differentiators.",
      "ref": "/Users/fullerbt/gt/12factor/PRODUCT.md lines 34-39"
    },
    {
      "severity": "minor",
      "category": "scope",
      "description": "Existing docs/explanation/ has 10 files including 'vibe-coding-integration.md', 'ecosystem-position.md'—unclear if these need rewrites or just links updated",
      "recommendation": "Create docs/ audit: which explanation files are still valid, which need rewrites, which get archived?",
      "fix": "Add bead: 'Audit docs/explanation/*.md for pivot compatibility' with deliverable: compatibility matrix",
      "why": "10 explanation files is significant content. If they all need rewrites, that's hidden scope. If they're mostly valid, that's good news that should be called out.",
      "ref": "/Users/fullerbt/gt/12factor/docs/explanation/ (10 files)"
    }
  ],
  "recommendation": "Break implementation into 3 clear phases with explicit scope boundaries: Phase 1 = Core factor rewrites (I-XII, README, archive manifest). Phase 2 = Supporting docs updates (explanation/, skills/, PRODUCT.md). Phase 3 = New content (tutorials, case studies). Ship Phase 1 before scoping Phase 2."
}
```

---

# Scope Analysis: 12-Factor AgentOps Pivot Design

**Reviewer:** Council Member 3 (Scope Judge)
**Date:** 2026-02-15
**Plan Under Review:** `/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md`

---

## Executive Summary

**The pivot thesis is sound.** Moving from "shift-left validation for coding agents" to "the operational discipline for working with agents" is a natural expansion that matches the actual scope of the existing factors. The problem is **the implementation plan radically underestimates the rewrite scope** and has **no boundaries around scope creep vectors**.

### What's Good

- Clear positioning shift: individual-first, scales to teams
- Strong differentiation from adjacent projects (GSD, Superpowers, Agent OS)
- Factor I elevated to context management (matches actual usage patterns)
- Explicit acknowledgment of AgentOps plugin as reference implementation

### What's Missing

1. **No task breakdown for factor rewrites** — "reframe existing content" hides that all 12 factors need complete rewrites
2. **No archive manifest** — unclear which files move to `_archived/` and which stay
3. **No scope boundaries** — "consider new skills" and "Olympus cross-references" are open-ended
4. **No phasing** — everything treated as one atomic pivot when it's clearly 3+ phases of work

---

## Critical Findings

### 1. Factor Rewrites Are Not "Reframes"

**The problem:**

The plan says "Content that survives (reframed)" and lists the 12 factors structure. This implies light editing. **Reality: all 12 factors need complete rewrites.**

**Evidence:**

Current Factor I (line 1 of `/Users/fullerbt/gt/12factor/factors/01-automated-tracking.md`):
```markdown
# Factor I: Automated Tracking
**Persistent memory for agents; every action, decision, and learning is recorded**
```

Pivot Factor I (line 40 of plan):
```markdown
#### Factor I: Context Is Everything
**Rule: Manage what enters the context window like you manage what enters production.**
```

**This isn't a reframe. This is a different factor.**

Same pattern across all 12:
- Factor II currently = "Context Loading" (JIT sub-agents)
- Pivot Factor II = "Track Everything in Git"
- Factor IV currently = "Continuous Validation"
- Pivot Factor IV = "Research Before You Build"

**The fix:**

Create explicit beads:
```
- Rewrite Factor I: Context Is Everything
- Rewrite Factor II: Track Everything in Git
- Rewrite Factor III: One Agent, One Job
- Rewrite Factor IV: Research Before You Build
... (12 total)
```

Each bead should have acceptance criteria:
- [ ] Title matches pivot design
- [ ] Rule statement matches pivot design
- [ ] Examples tie to new positioning (not just validation)
- [ ] Links to new pillar structure
- [ ] Cross-references updated

**Estimated scope:** 12 files × 4-6 hours each = 48-72 hours (not 5 hours for "reframing")

---

### 2. README "Rewrite" Hides 20 Hours of Work

**The problem:**

Plan line 236-240:
```markdown
### README rewrite
- New tagline: "The Operational Discipline for Working With Agents"
- Individual-first framing
- Quick overview of all 12 factors
- Link to AgentOps plugin as reference implementation
- Link to Olympus for scale patterns
```

This reads like "update 5 lines." **Reality: README is 216 lines with complex orchestration.**

**Current README structure:**

```markdown
- Badges (7 lines)
- Animated SVG workflow diagram
- Hook section (30 lines)
- Factor comparison table (60 lines)
- 3-column factor grid (60 lines)
- Collapsible "Quick Load" section
- Landscape SVG
- Plugins collapsible section
- Credit footer
```

**What actually needs to happen:**

1. **Content rewrite:**
   - New tagline (replace "DevOps for Vibe-Coding")
   - Rewrite factor summaries (12 factors × 2 lines each)
   - Rewrite positioning section (validation → operational discipline)
   - Update competitive landscape references

2. **Asset updates:**
   - Regenerate workflow-flow-animated.svg (shows wrong cycle)
   - Regenerate 12-factor-landscape.svg (shows wrong factors)
   - Update carousel slide-*.svg files (11 slides, validation-focused)

3. **Structure decisions:**
   - Keep collapsible sections or flatten for clarity?
   - Archive old badges or keep?
   - How to link to AgentOps plugin repo (inline or footer)?
   - What happens to "DevOps for Vibe-Coding" imagery?

**The fix:**

Break into phases:
```
Bead 1: README content pivot (tagline, factors, positioning)
Bead 2: README visual assets (regenerate SVGs)
Bead 3: README structure cleanup (collapsibles, links, badges)
```

**Estimated scope:** 15-20 hours (not 2 hours for "rewrite")

---

### 3. Marketplace Skills: "Consider" = Infinite Scope

**The problem:**

Plan line 244-245:
```markdown
### Marketplace skills
- Reframe existing validation skills under Factor V
- Consider new skills for other factors (context management, knowledge extraction, etc.)
```

"Consider new skills" is an invitation to scope creep. **Without boundaries, this balloons from 5 skills to 12+ skills.**

**Current state:**

Marketplace has 5 skills, all validation-focused:
- factor-compliance-checker
- nine-laws-auditor
- pattern-extraction-assistant
- research-formatter
- cross-reference-validator

**Creep vector:**

"Consider new skills for other factors" could mean:
- Factor I skill: context-monitor (tracks context utilization)
- Factor II skill: git-memory-injector (loads from beads)
- Factor III skill: agent-spawner (creates sub-agents)
- Factor IV skill: research-validator (checks research quality)
- Factor VI skill: progress-ratchet (locks validated work)
- Factor VII skill: learning-extractor (mines sessions)
- Factor VIII skill: knowledge-injector (loads learnings)
- ... 12 total new skills

**This is 40-80 hours of hidden work.**

**The fix:**

Add explicit boundary:
```markdown
### Marketplace skills (Pivot Scope)
- Reframe existing 5 skills under new factor structure
- NO NEW SKILLS in pivot phase
- Post-launch: evaluate new skills based on adoption metrics
```

**If** new skills are required for pivot credibility, scope exactly:
```markdown
### Marketplace skills (Pivot Scope)
- Reframe existing 5 skills
- Add 3 new skills ONLY:
  - context-monitor (Factor I)
  - research-validator (Factor IV)
  - learning-extractor (Factor VII)
```

---

### 4. Archive Boundary Is Vague

**The problem:**

Plan lists what to archive:
```markdown
### Content to archive
- Coding-agent-only framing (too narrow)
- "DevOps for Vibe-Coding" tagline (replaced)
- Marketplace skills focused purely on validation (reframe as Factor V implementations)
```

**But doesn't specify which files.**

**Current `_archived/` structure:**

```
docs/_archived/
├── README.md
├── case-studies/
│   ├── factor-mapping.md
│   └── metrics.md
└── domain-guides/
    └── platform-engineering-agent.md
```

**Unclear:**

- Does `docs/case-studies/enterprise-validation.md` get archived? (validation-focused)
- Do carousel SVGs get archived? (show old factors)
- Does `docs/explanation/vibe-coding-integration.md` stay? (mentions validation)
- What about `docs/tutorials/validate-before-you-ship.md`? (validation-focused)

**The fix:**

Create explicit archive manifest:
```
Bead: Create archive manifest
Deliverable: docs/_archived/ARCHIVE-MANIFEST.md

Format:
| File | Archive? | Rationale |
|------|----------|-----------|
| docs/case-studies/enterprise-validation.md | YES | Validation-only focus, doesn't generalize |
| docs/explanation/vibe-coding-integration.md | NO | Vibe-Coding is still positioning |
| docs/tutorials/validate-before-you-ship.md | REWRITE | Tutorial stays, title changes |
```

**Benefit:** Archive decisions made once, not re-discussed during every file edit.

---

### 5. Factors X-XII: New or Refactored?

**The problem:**

Plan lists Factors X-XII as "Content that's new":
- Factor X: Isolate Workers
- Factor XI: Supervise Hierarchically
- Factor XII: Harvest Failures as Wisdom

**But unclear: are these greenfield research or refactors of existing content?**

**Potential source material:**

- `/Users/fullerbt/gt/12factor/docs/explanation/beads-workflow-integration.md` (has worker isolation patterns)
- Gas Town Olympus patterns (supervision trees, failure harvesting)
- Existing AgentOps plugin documentation (multi-agent patterns)

**Scope difference:**

- **Greenfield (no source material):** 30-50 hours of research, writing, examples, validation
- **Refactored (pull from existing):** 10-15 hours of synthesis, editing, cross-linking

**The fix:**

Add clarity:
```markdown
### Factors X-XII: Scale (sourced from existing patterns)
- Factor X: Isolate Workers
  Source: Gas Town worktree isolation, Olympus polecat architecture
- Factor XI: Supervise Hierarchically
  Source: Olympus witness/refinery supervision, Erlang OTP patterns
- Factor XII: Harvest Failures as Wisdom
  Source: AgentOps failure analysis, post-mortem patterns

**Scope:** Synthesis and documentation of proven patterns, not greenfield research.
```

---

## Moderate Findings

### 6. Skills Plugin Metadata May Need Updates

**The problem:**

Plan says "Reframe existing validation skills under Factor V" but skills have `.claude-plugin/plugin.json` metadata that may be tightly coupled to old framing.

**Example: factor-compliance-checker plugin.json:**

```json
{
  "name": "factor-compliance-checker",
  "description": "Validate workflow against 12-Factor AgentOps principles",
  "tags": ["validation", "compliance", "12-factor"],
  "trigger": "After implementation"
}
```

**If factors change, this metadata may need updates:**
- Tags still relevant? ("validation" vs "operational-discipline")
- Trigger conditions still match? (Factor IV is now "Research" not "Validation")
- Description still accurate?

**The fix:**

Add validation bead:
```
Bead: Audit skill plugin.json compatibility with Factor V pivot
Deliverable: Compatibility report for 5 skills
- Which skills work as-is?
- Which need metadata updates?
- Which need skill.md rewrites?
```

---

### 7. Olympus Cross-References Unclear

**The problem:**

Plan line 30:
```markdown
| Olympus | Multi-agent orchestration system embodying Factors X–XII at scale. |
```

**Unclear: Does Olympus repo get updated to link back to 12-Factor AgentOps?**

**Cross-repo coordination is always 3x harder than estimated.**

**The fix:**

Add explicit decision:
```markdown
### Olympus Cross-References
- **In scope:** Mention Olympus in 12-Factor AgentOps (Factors X-XII)
- **Out of scope:** Updating Olympus repo to link back
- **Rationale:** Avoid cross-repo dependency blocking pivot launch
- **Follow-on:** Add Olympus cross-references post-launch if adoption warrants
```

---

### 8. PRODUCT.md Competitive Landscape Needs Update

**The problem:**

`PRODUCT.md` has detailed competitive landscape (GSD, Superpowers, Agent OS, Spec Kitty) framed around validation vs methodology.

**When positioning shifts to "operational discipline," these comparisons may need updates.**

**Example:**

Current (line 36):
```markdown
| GSD | ... | GSD solves "how to structure one project." We solve "how to operate with agents as a practice." |
```

**This comparison works for operational discipline framing. But others may need tweaks.**

**The fix:**

Defer until after factor rewrites:
```
Bead: Update PRODUCT.md competitive landscape (post-pivot)
Depends on: All Factor I-XII rewrites complete
Rationale: Competitive positioning clearer after new factors published
```

---

## Minor Findings

### 9. docs/explanation/ Audit Needed

**The problem:**

`docs/explanation/` has 10 files. **Unclear which are still valid after pivot.**

**Files:**
- ai-summit-validation-2025.md (validation-focused?)
- beads-workflow-integration.md (stays?)
- ecosystem-position.md (needs update?)
- faafo-north-star.md (still relevant?)
- from-theory-to-production.md (validation-focused?)
- pattern-heritage.md (still relevant?)
- phoenix-project-lineage.md (stays?)
- standing-on-giants.md (still relevant?)
- three-developer-loops.md (still relevant?)
- vibe-coding-integration.md (needs update?)

**The fix:**

Add audit bead:
```
Bead: Audit docs/explanation/*.md for pivot compatibility
Deliverable: Compatibility matrix
- KEEP (no changes)
- UPDATE (minor edits)
- REWRITE (major changes)
- ARCHIVE (move to _archived/)
```

---

## What's Unnecessary?

### Nothing (But Prioritize Ruthlessly)

**All planned work is justified.** The problem isn't that anything is unnecessary—it's that **everything is treated as equally urgent when it's not.**

**Core pivot (must ship):**
- Factor I-XII rewrites
- README rewrite (content + positioning)
- Archive manifest (decision clarity)

**Supporting work (can defer):**
- Skills marketplace reframing
- docs/explanation/ updates
- Competitive landscape refresh
- Visual asset regeneration

**Nice-to-have (post-launch):**
- New skills for Factors I, IV, VII
- Olympus cross-references
- Case study rewrites

---

## Scope Creep Vectors

### High Risk

1. **"Consider new skills"** — Without boundaries, balloons from 5 to 12+ skills
2. **Asset regeneration** — 11 carousel SVGs + 2 landscape SVGs + workflow diagram = 20+ hours
3. **Factors X-XII source research** — If greenfield instead of refactored, adds 30-50 hours

### Medium Risk

4. **Archive decisions** — Without manifest, re-discussed during every file edit
5. **Olympus coordination** — Cross-repo work always 3x harder than estimated
6. **Skills plugin.json updates** — Metadata changes can cascade to skill.md + references/

### Low Risk

7. **PRODUCT.md updates** — Clear boundaries, small file
8. **docs/explanation/ audit** — Straightforward pass/fail per file

---

## Recommended Phasing

### Phase 1: Core Pivot (Ship This First)

**Scope:** Minimum viable pivot to new positioning

- [ ] Factor I-XII rewrites (12 files)
- [ ] README content pivot (tagline, positioning, factor summaries)
- [ ] Archive manifest (decision clarity for what moves)
- [ ] PRODUCT.md mission statement update

**Estimated:** 60-80 hours
**Deliverable:** Coherent "operational discipline" narrative, factors match positioning

**Ship this before scoping Phase 2.**

---

### Phase 2: Supporting Docs (After Phase 1 Ships)

**Scope:** Align supporting content with new positioning

- [ ] Skills marketplace reframing (5 existing skills)
- [ ] docs/explanation/ audit + updates
- [ ] Competitive landscape refresh
- [ ] Tutorial rewrites (validate-before-you-ship.md, etc.)

**Estimated:** 30-40 hours
**Deliverable:** All docs consistent with new positioning

**Re-scope based on Phase 1 learnings before starting.**

---

### Phase 3: Enhancements (Post-Launch Only)

**Scope:** New content based on adoption feedback

- [ ] New skills (IF user feedback requests them)
- [ ] Visual asset regeneration (carousel SVGs)
- [ ] Olympus cross-references (IF adoption warrants)
- [ ] New case studies (operational discipline examples)

**Estimated:** 40-60 hours
**Deliverable:** Enhanced materials based on real user needs

**Only scope this if Phase 1-2 show adoption traction.**

---

## The Boundary Question

**Where does the pivot end and new product development begin?**

**Pivot ends when:**
- All 12 factors reflect "operational discipline" positioning
- README communicates new value proposition
- Existing content is consistent or archived
- Users can understand the new thesis

**New product development begins when:**
- Creating new skills that didn't exist
- Regenerating all visual assets
- Writing new case studies from scratch
- Coordinating across multiple repos (Olympus, AgentOps plugin)

**The plan conflates these.** Phase the work.

---

## Final Recommendation

**The pivot is viable. The scope is not.**

### Actions Required

1. **Break factor rewrites into 12 explicit beads** (one per factor)
2. **Create archive manifest bead** (list every file that moves, with rationale)
3. **Add scope boundaries to marketplace skills** ("no new skills in pivot" OR "3 specific new skills only")
4. **Phase the work** (ship core pivot before scoping supporting docs)
5. **Clarify Factors X-XII source material** (refactored from existing or greenfield research?)

### Success Criteria for Pivot Completion

- [ ] All 12 factors use new titles and positioning
- [ ] README reflects "operational discipline" thesis
- [ ] No validation-only framing in core docs (unless archived)
- [ ] Archive manifest documents all moved content
- [ ] Competitive landscape reflects new positioning

**Everything else is Phase 2+ work.**

---

## Verdict

**WARN:** The pivot thesis is sound, but the implementation plan radically underestimates rewrite scope and lacks clear boundaries around scope creep. Without explicit phasing and task breakdown, this balloons from 60 hours (realistic core pivot) to 150+ hours (everything treated as atomic).

**Ship the core pivot first. Re-scope supporting work based on learnings.**
