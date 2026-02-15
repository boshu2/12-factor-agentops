# Pre-Mortem: Pivot Design — Missing Requirements Analysis

**Judge:** Council Member 1 — THE MISSING-REQUIREMENTS
**Date:** 2026-02-15
**Reviewed:** `/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md`

```json
{
  "verdict": "WARN",
  "confidence": "HIGH",
  "key_insight": "The pivot vision is solid but the implementation plan leaves critical execution gaps around migration paths, content transition, validation of new factors, and success metrics.",
  "findings": [
    {
      "severity": "critical",
      "category": "requirements",
      "description": "No migration path for existing users: Current factors (I-XII) map to new factors (I-XII) with completely different meanings. Users who learned 'Factor I: Automated Tracking' will now see 'Factor I: Context Is Everything'. No plan for how existing content references (tutorials, skills, documentation) get updated.",
      "recommendation": "Define explicit migration strategy: version the old factors (v1.0), create mapping guide (old Factor I → new Factor II), update all internal references, or provide redirect/deprecation notices.",
      "fix": "Add 'Migration Strategy' section to plan covering: (1) versioning approach, (2) old→new factor mapping table, (3) content update checklist, (4) user communication plan",
      "why": "Without migration plan, you'll break existing users' mental models and create dead links throughout the ecosystem.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:216-245"
    },
    {
      "severity": "critical",
      "category": "completeness",
      "description": "New factors IV, VI, X, XI, XII are defined at principle level only. No implementation guidance, validation criteria, anti-patterns, or real-world evidence sections like existing factors have. Plan says 'Content that's new' but doesn't specify WHAT needs to be written.",
      "recommendation": "For each new factor, specify required sections: Summary, Why This Exists, The Problem, The Principle, Why This Works, Implementation, Validation, Real-World Evidence, Anti-Patterns, Relationship to Other Factors.",
      "fix": "Create content specification template for new factors matching existing factor depth (see /Users/fullerbt/gt/12factor/factors/01-automated-tracking.md for reference structure).",
      "why": "Shallow factor definitions undermine the 'full operational discipline' positioning. Current factors are 500-800 lines with deep implementation guidance. New factors need same depth or they're just aphorisms.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:224-229"
    },
    {
      "severity": "significant",
      "category": "requirements",
      "description": "No validation plan for the pivot claims. Plan states '40% rule' is 'supported by 40 years of cognitive load research' and 'confirmed in LLM benchmarks' but provides no validation methodology for how YOU will prove these claims apply to YOUR new factor definitions.",
      "recommendation": "Define validation experiments: (1) Measure context utilization vs. success rate across N sessions, (2) A/B test single-agent vs. multi-agent workflows, (3) Track knowledge reuse metrics post-extraction.",
      "fix": "Add 'Validation Plan' section: Define 3-5 key hypotheses from the new factors, specify measurable outcomes, define sample size and timeline.",
      "why": "Pivoting from 'validation for coding agents' to 'operational discipline for all agents' is a huge scope expansion. Without empirical validation, this becomes opinion masquerading as methodology.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:40-50"
    },
    {
      "severity": "significant",
      "category": "scope",
      "description": "Audience expansion from 'coding agents' to 'all agents' (Claude Code, Cursor, Codex, Copilot, or custom setups) introduces massive scope but no requirements analysis for non-coding domains. Customer service agents, research agents mentioned in existing factors—do the 12 factors apply uniformly? What domain-specific variations exist?",
      "recommendation": "Conduct domain analysis: Survey 3-5 non-coding agent domains (customer service, research, data analysis), identify which factors apply universally vs. require adaptation, document domain-specific implementation patterns.",
      "fix": "Add 'Domain Applicability Matrix' showing which factors are universal vs. domain-specific, with examples from at least 3 domains beyond coding.",
      "why": "Claiming 'vendor-neutral principles' for all agent work without domain validation risks the framework being coding-centric in practice despite universal branding.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:19-21"
    },
    {
      "severity": "significant",
      "category": "requirements",
      "description": "No success metrics defined for the pivot. What does success look like? Adoption metrics? Quality metrics? The plan pivots positioning but doesn't define how to measure whether the new positioning achieves its goals.",
      "recommendation": "Define lagging and leading indicators: Lagging (GitHub stars growth rate, marketplace skill adoption, external citations), Leading (tutorial completion rate, factor implementation depth, community contributions).",
      "fix": "Add 'Success Metrics' section with 3 lagging indicators (outcome), 3 leading indicators (process), and targets for 3/6/12 months post-pivot.",
      "why": "Without defined success criteria, you won't know if the pivot worked or if you need to course-correct. Factor IX (Measure What Matters) should apply to the project itself.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md (entire document)"
    },
    {
      "severity": "significant",
      "category": "architecture",
      "description": "AgentOps plugin described as 'reference implementation' but no specification of which factors it currently implements vs. which need new tooling. Factor X (Isolate Workers) mentions git worktrees—does AgentOps support this? Factor XII (Harvest Failures)—where's the failure harvesting implementation?",
      "recommendation": "Audit current AgentOps plugin capabilities against new factor requirements. Create implementation gap analysis.",
      "fix": "Add 'Reference Implementation Gap Analysis' table: List all 12 factors, mark which are fully/partially/not implemented in AgentOps, specify development effort for gaps.",
      "why": "Claiming AgentOps is the reference implementation without ensuring it actually implements all factors creates credibility gap. Either build the missing pieces or acknowledge limitations.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:29"
    },
    {
      "severity": "minor",
      "category": "requirements",
      "description": "Olympus mentioned as demonstrating 'scale factors in multi-agent orchestration' (Factors X-XII) but no specification of what evidence from Olympus validates these factors. Is this aspirational or proven?",
      "recommendation": "Either provide concrete Olympus evidence (session logs, metrics, failure analysis) that validates Factors X-XII, or reframe Olympus as 'experimental validation in progress' rather than proof.",
      "fix": "Add footnote or appendix: 'Olympus Validation Evidence' with 2-3 concrete examples of Factors X-XII in action, or update plan to say 'Olympus will demonstrate' (future tense).",
      "why": "Using Olympus as evidence without providing the actual evidence weakens the technical authority of the factors.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:30"
    },
    {
      "severity": "minor",
      "category": "completeness",
      "description": "README rewrite specified as 'new tagline, individual-first framing, link to AgentOps/Olympus' but doesn't specify whether the visual assets (workflow-flow-animated.svg, 12-factor-landscape.svg) need updates to reflect new factor definitions.",
      "recommendation": "Audit visual assets for accuracy post-pivot. If they reference old factor names/concepts, add to content update checklist.",
      "fix": "Add 'Visual Assets Audit' to implementation checklist: Review all SVGs/diagrams, update or regenerate as needed.",
      "why": "Inconsistent visuals create confusion and make the pivot look incomplete.",
      "ref": "/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md:236-240"
    }
  ],
  "recommendation": "PROCEED with pivot BUT add the missing execution specifications before implementation begins: (1) Migration strategy, (2) New factor content templates, (3) Validation plan, (4) Domain applicability analysis, (5) Success metrics, (6) Reference implementation gap analysis."
}
```

---

## Analysis

The pivot design is **strategically sound** but **tactically incomplete**. The vision (shifting from narrow "validation for coding agents" to broad "operational discipline for working with agents") is compelling and well-reasoned. The 12 factors themselves are coherent and well-structured. However, the implementation plan reads like a product vision deck, not an execution blueprint. Critical questions remain unanswered.

---

## What's Missing: The Gaps

### 1. Migration Path for Existing Users (CRITICAL)

**The Problem:**

You're renumbering and redefining all 12 factors. Current Factor I (Automated Tracking) becomes... what? New Factor II (Track Everything in Git)? But that's not the same thing—old Factor I was about persistent memory with Context/Solution/Learning/Impact structure; new Factor II is about git as single source of truth.

**What Happens Without Migration Plan:**

- User reads old tutorial referencing "Factor I: Automated Tracking"
- Opens current docs, sees "Factor I: Context Is Everything"
- Confusion. Dead links. Lost trust.

**What's Missing:**

- Versioning strategy (v1.0 vs. v2.0 factors?)
- Old→new factor mapping table
- Content update checklist (which tutorials, which marketplace skills, which docs)
- User communication plan (blog post? Migration guide? Deprecation notices?)

**Why This Matters:**

You already have users (GitHub stars, marketplace adoption implied by product context). Breaking their mental models without a migration path is a self-inflicted wound.

---

### 2. Content Specification for New Factors (CRITICAL)

**The Problem:**

Plan says "Content that's new: Factors IV (Research), VI (Ratchet), X–XII (Scale)" but doesn't specify WHAT content. Compare to existing factors:

- **Existing Factor I (Automated Tracking):** 318 lines covering Summary, Why This Exists, The Problem, The Principle, Why This Works, What This Factor Enforces, Implementation (with code examples), Validation, Real-World Evidence, Anti-Patterns, Relationship to Other Factors, Next Steps, Further Reading.

- **New Factor IV (Research Before You Build) in plan:** ~15 lines of principle-level description.

**The Gap:**

New factors are defined at the "what" level but missing the "how" level. Without implementation guidance, validation criteria, anti-patterns, and real-world evidence, these aren't operational factors—they're aspirational principles.

**What's Missing:**

- Content template matching existing factor depth
- Implementation patterns for each new factor
- Validation criteria ("you're doing this right if...")
- Anti-patterns ("you're doing this wrong if...")
- Real-world evidence (sessions tracked, metrics validated)
- Code examples (like existing factors provide)

**Why This Matters:**

You're pivoting to "full operational discipline" but the new factors lack operational depth. Shallow content undermines the positioning.

---

### 3. Validation Plan for Pivot Claims (SIGNIFICANT)

**The Problem:**

Plan makes strong empirical claims:

- "40% rule: agent performance peaks when context utilization stays below 40%" (line 43)
- "Supported by 40 years of cognitive load research and confirmed in LLM benchmarks" (line 44)
- "Research is a distinct phase—it produces findings, not code" (line 88)

But provides no validation methodology for proving these claims apply to YOUR framework's factor definitions.

**What's Missing:**

- Validation experiments designed to test factor hypotheses
- Measurable outcomes (success rate, time to completion, knowledge reuse rate)
- Sample size and timeline for validation
- Methodology for distinguishing factor effects from confounding variables

**Why This Matters:**

Old positioning: "Shift-Left Validation for Coding Agents" (narrow, testable)
New positioning: "The Operational Discipline for Working With Agents" (broad, ambitious)

The broader the claim, the stronger the evidence burden. Without validation plan, this risks being vaporware—impressive-sounding principles without operational proof.

---

### 4. Domain Applicability Analysis (SIGNIFICANT)

**The Problem:**

Plan expands audience from "coding agents" to "Claude Code, Cursor, Codex, Copilot, or custom setups" (line 13) and mentions customer service agents, research agents in examples. But no analysis of whether all 12 factors apply uniformly across domains.

**Questions Not Answered:**

- Does Factor IV (Research Before You Build) apply to customer service agents? What does "research" mean in that context?
- Does Factor X (Isolate Workers) apply to single-agent setups, or only multi-agent?
- Does Factor XII (Harvest Failures) require infrastructure (logging, analysis) that most individual users lack?

**What's Missing:**

- Domain applicability matrix (which factors are universal vs. domain-specific)
- Non-coding domain examples with same depth as coding examples
- Adaptation patterns for different agent types

**Why This Matters:**

Claiming "vendor-neutral principles for all agent work" without domain validation risks the framework being coding-centric in disguise. That undermines the positioning and limits adoption.

---

### 5. Success Metrics (SIGNIFICANT)

**The Problem:**

Plan defines the pivot vision but not the success criteria. How will you know if this pivot worked? What metrics indicate the new positioning is resonating?

**What's Missing:**

- **Lagging indicators** (outcomes): GitHub stars growth rate, marketplace skill adoption, external citations, tutorial completion rate
- **Leading indicators** (process): Factor implementation depth, community contributions, issue/PR activity
- **Targets**: 3-month, 6-month, 12-month milestones

**Why This Matters:**

Factor IX (Measure What Matters) says "Track fitness toward goals, not activity metrics." That should apply to the project itself. Without defined success criteria, you're flying blind—won't know if pivot succeeded or needs course correction.

---

### 6. Reference Implementation Gap Analysis (SIGNIFICANT)

**The Problem:**

AgentOps plugin described as "reference implementation of these principles" (line 29), but no specification of which factors it currently implements vs. which need new development.

**Examples:**

- **Factor X (Isolate Workers):** "Each worker gets its own git worktree" (line 185). Does AgentOps support git worktree creation/management?
- **Factor XII (Harvest Failures):** "Failed attempts are logged with context, not silently discarded" (line 209). Where's the failure harvesting implementation?

**What's Missing:**

- Factor-by-factor implementation audit of current AgentOps capabilities
- Gap analysis: which factors are fully/partially/not implemented
- Development roadmap for closing gaps

**Why This Matters:**

Calling AgentOps the "reference implementation" when it doesn't implement all factors creates credibility gap. Either build the missing pieces or acknowledge limitations explicitly.

---

### 7. Olympus Validation Evidence (MINOR)

**The Problem:**

Plan says "Olympus demonstrates the scale factors in a multi-agent orchestration system" (line 30) but provides no actual evidence. Is this proven or aspirational?

**What's Missing:**

- Concrete examples from Olympus validating Factors X-XII
- Session logs, metrics, failure analysis showing these patterns in action
- Or, explicit acknowledgment that Olympus validation is in progress (future tense, not past)

**Why This Matters:**

Using Olympus as proof without providing the proof weakens technical authority. Either show the receipts or reframe as experimental validation.

---

### 8. Visual Asset Audit (MINOR)

**The Problem:**

Plan specifies README rewrite but doesn't address whether visual assets (workflow-flow-animated.svg, 12-factor-landscape.svg visible in current README) need updates to reflect new factor definitions.

**What's Missing:**

- Audit of all diagrams/visuals for accuracy post-pivot
- Update checklist for visual assets

**Why This Matters:**

Outdated visuals create confusion and make the pivot look incomplete. Small detail, but affects polish.

---

## The Root Issue: Vision Without Execution Blueprint

This plan is a **product vision document** masquerading as an **implementation plan**. It answers:

- ✅ **Why pivot?** (QA slice too narrow, operational discipline broader/better)
- ✅ **What's the new positioning?** (12-Factor AgentOps as the operational layer)
- ✅ **What are the 12 factors?** (Well-defined principles)

But doesn't answer:

- ❌ **How do we migrate existing users?**
- ❌ **What content needs to be written for new factors?**
- ❌ **How do we validate the pivot claims?**
- ❌ **What domains do these factors apply to?**
- ❌ **How do we measure success?**
- ❌ **Does the reference implementation actually implement all factors?**

---

## Questions the Plan Doesn't Ask (But Should)

### On Migration:
1. What happens to users who bookmarked "Factor I: Automated Tracking"?
2. Do we version the old factors (v1.0) and clearly mark the transition?
3. Which marketplace skills reference old factor numbers and need updates?
4. Do we maintain a deprecated-but-accessible archive of v1.0 factors?

### On Content:
5. What's the minimum viable content for a new factor to be "complete"?
6. Do new factors need the same Real-World Evidence sections as old factors?
7. Who writes the 500-800 lines of implementation guidance for Factors IV, VI, X-XII?
8. What's the content quality bar? (Code examples required? Anti-patterns required?)

### On Validation:
9. What experiments validate the 40% context rule applies across agent types?
10. How many sessions constitute "real-world evidence"? (Current factors cite 200+)
11. What's the difference between "supported by research" and "validated in our framework"?
12. Can we A/B test single-factor vs. multi-factor adoption to measure impact?

### On Scope:
13. Do all 12 factors apply equally to single-agent vs. multi-agent setups?
14. Which factors are prerequisites vs. advanced? (Plan says X-XII are advanced, but is that enforced?)
15. Does a customer service agent implementation look fundamentally different from a coding agent?
16. What's the smallest viable subset of factors? (For "individual-first" adoption)

### On Success:
17. How many external citations/references constitute "ecosystem adoption"?
18. What tutorial completion rate indicates good developer experience?
19. At what point do we consider the pivot successful vs. needing iteration?
20. What leading indicators (weekly/monthly) tell us we're on the right track?

---

## The WARN Verdict: Why Not FAIL?

**Why WARN instead of FAIL:**

1. **Vision is solid.** The pivot from narrow QA focus to broad operational discipline is strategically correct. The 12 factors themselves are well-reasoned and coherent.

2. **Foundation exists.** Current factors (I-IV in existing repo) demonstrate the content quality bar and provide a template for new factor development.

3. **Gap is execution, not conception.** The missing pieces (migration plan, content specs, validation methodology) are definable—they're just not defined yet.

**Why not PASS:**

The gaps are too significant to rubber-stamp. Proceeding without migration strategy risks breaking existing users. Proceeding without content specs risks shallow new factors. Proceeding without validation plan risks the pivot being aspirational rather than operational.

---

## Recommended Next Actions (Before Implementation)

### 1. Define Migration Strategy (2-4 hours)
- Version old factors as v1.0, archive at `/docs/v1.0/factors/`
- Create old→new mapping table
- Audit all internal references (tutorials, skills, docs) for factor number citations
- Write migration guide explaining changes

### 2. Create New Factor Content Template (1-2 hours)
- Use existing Factor I as template (318 lines, 11 sections)
- Specify required sections for Factors IV, VI, X-XII
- Define content quality bar (code examples? real-world evidence requirements?)

### 3. Design Validation Experiments (2-4 hours)
- For Factor I (Context Is Everything): Track context utilization vs. success rate over 50 sessions
- For Factor IV (Research Before You Build): A/B test research-first vs. implementation-first workflows
- For Factor VIII (Compound Knowledge): Measure knowledge reuse rate post-extraction
- Define sample sizes and timelines

### 4. Conduct Domain Applicability Analysis (4-6 hours)
- Survey 3-5 non-coding domains (customer service, research, data analysis, sales, HR)
- For each domain, map which factors apply universally vs. need adaptation
- Provide 1-2 examples per domain showing factor application

### 5. Define Success Metrics (1 hour)
- 3 lagging indicators with 3/6/12-month targets
- 3 leading indicators tracked weekly/monthly
- Dashboard or tracking mechanism

### 6. Audit Reference Implementation (2-3 hours)
- Review current AgentOps plugin capabilities
- Map to 12 new factors (fully implemented / partially / not implemented)
- Create development roadmap for gaps or acknowledge limitations

**Total effort: ~12-19 hours of planning work before implementation begins.**

---

## Final Assessment

This pivot has **high strategic value** but **incomplete execution planning**. The vision is compelling, the factors are well-structured, but the "how we get there" is underspecified.

The plan reads like a brainstorm output (which it says it is: "Status: Approved (brainstorm complete)") rather than an implementation blueprint. That's appropriate for a brainstorm, but insufficient for execution.

**Recommendation: PROCEED with pivot, BUT add the missing specifications before cutting code.**

The gaps are fixable. The vision is sound. The risk is proceeding with insufficient planning and discovering these gaps mid-implementation when the cost of fixing them is 10x higher.

Add the execution blueprint. Then proceed with confidence.
