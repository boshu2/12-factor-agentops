---
name: pattern-extraction-assistant
description: Extract reusable patterns from production implementations and format them for the 12-Factor AgentOps framework. Use when converting operational workflows into documented patterns, extracting learnings from gitops/agentops, or formalizing discovered practices.
---

# Pattern Extraction Assistant

Convert production implementations and operational learnings into properly documented patterns for the 12-Factor AgentOps framework.

## Purpose

This skill guides the systematic extraction of patterns from production work (gitops, agentops, real workflows) and transforms them into framework documentation that others can learn from and apply. It ensures extracted patterns are properly grounded in the Four Pillars, enforce the Five Laws, and follow framework standards.

## When to Use This Skill

Use this skill when:
- **Extracting patterns from production** (gitops/.claude/agents/ → 12-factor-agentops/patterns/)
- **Converting operational workflows** into reusable patterns
- **Formalizing discovered practices** after successful implementations
- **Documenting learnings** from multi-session work
- **Creating new pattern documentation** for the framework
- **Preparing case studies** from real production experience

## Pattern Extraction Workflow

### Step 1: Identify Pattern Candidates

Examine production work to find pattern candidates:

**Good pattern candidates have:**
- ✅ Been applied successfully 3+ times
- ✅ Solved a recurring operational problem
- ✅ Measurable impact (time saved, errors prevented, quality improved)
- ✅ Potential generalizability beyond specific domain
- ✅ Clear relationship to Four Pillars and Five Laws

**Poor pattern candidates:**
- ❌ One-time solutions (not reusable)
- ❌ Domain-specific hacks (not generalizable)
- ❌ Theoretical ideas (not validated in production)
- ❌ Obvious practices (already well-known)

**Where to look:**
- Git history: `git log --grep="Learning:"` (Factor I)
- Agent workflows: `.claude/agents/*.md` in gitops
- Session logs: Repeated successful patterns
- Improvement backlog: Practices that compound

### Step 2: Extract Core Pattern Elements

Use the pattern template from `assets/pattern-template.md` to structure the extraction.

**Required elements:**
1. **Pattern Name**: Descriptive, actionable (e.g., "Phase-Based Workflow")
2. **One-Sentence Summary**: The core principle
3. **Problem**: What operational challenge does this solve?
4. **Solution**: How does the pattern address the problem?
5. **Why It Works**: Theoretical grounding (which Pillar?)
6. **Implementation**: Practical guidance with examples
7. **Validation**: How to measure success
8. **Real-World Evidence**: Production metrics and outcomes
9. **Anti-Patterns**: Common mistakes when applying this
10. **Relationships**: How it connects to other patterns/factors

### Step 3: Ground in Framework Foundations

Every pattern must explicitly connect to framework foundations:

**Pillar Grounding** (choose 1+ of Four Pillars):
- DevOps + SRE: Infrastructure patterns, reliability, observability
- Learning Science: How agents learn, cognitive patterns
- Context Engineering: Managing cognitive load, JIT loading
- Knowledge OS: Git patterns, institutional memory

**Laws Enforcement** (identify which of Five Laws):
- Law 1: Does it extract learnings?
- Law 2: Does it improve systems?
- Law 3: Does it document context?
- Law 4: Does it validate before execution?
- Law 5: Does it enable sharing?

**Use `references/pillar-mapping-guide.md` for detailed guidance on grounding patterns.**

### Step 4: Assess Generalizability

Distinguish what generalizes from what's context-specific:

**Generalizability Assessment Framework:**

```markdown
## Generalizability

**Universal aspects:**
- [What transfers to any domain?]
- [What's inherent to the pattern?]

**Context-specific aspects:**
- [What's specific to our domain/tools?]
- [What needs adaptation for other contexts?]

**Validation in other domains:**
- [Where else has this been tried?]
- [What adaptations were needed?]
```

**Questions to ask:**
- Would this work for product development? Infrastructure ops? Research?
- What assumptions does this make about tools/environment?
- Which parts are principles vs. implementation details?

### Step 5: Document Evidence and Metrics

Patterns require real-world validation:

**Evidence to include:**
- **Quantified impact**: Time saved, errors reduced, efficiency gains
- **Session count**: How many times successfully applied
- **Success rate**: What percentage of applications succeeded
- **Team adoption**: How many people/teams use this
- **Longevity**: How long has this been in production

**Example from phase-based workflow pattern:**
```markdown
## Real-World Evidence

**204 sessions tracked across 6 months:**
- ✅ 95% success rate when phases separated vs. 60% when mixed
- ✅ 40x speedup on complex workflows (Research → Plan → Implement)
- ✅ 70% reduction in rework from planning phase
- ✅ Adopted by 3 independent teams after framework publication
```

### Step 6: Identify Anti-Patterns

Document what doesn't work (critical for practitioners):

**Anti-pattern structure:**
```markdown
### ❌ [Anti-Pattern Name]
**Wrong:** [What people commonly do wrong]
**Right:** [The correct pattern application]
**Why this fails:** [Explanation of failure mode]
```

**Aim for 3+ anti-patterns per pattern.**

Common anti-pattern categories:
- Over-application (using pattern where it doesn't fit)
- Under-application (not using pattern where it would help)
- Misunderstanding (incorrect implementation)
- Context mismatch (wrong context for pattern)

### Step 7: Cross-Reference to Ecosystem

Connect pattern to broader framework:

**Factor relationships:**
- Which factors does this pattern implement?
- Which factors enable this pattern?
- Which factors are complementary?

**Pattern relationships:**
- What other patterns work well with this?
- What patterns does this replace/supersede?
- What patterns are prerequisites?

**Use `references/cross-reference-map.md` for relationship mapping.**

### Step 8: Validate and Iterate

Before finalizing pattern documentation:

1. **Self-review using factor-compliance-checker skill**
2. **Test clarity**: Could someone implement this from the docs?
3. **Verify evidence**: Are metrics accurate and complete?
4. **Check grounding**: Is pillar connection strong?
5. **Validate generalizability**: Is assessment honest?

## Example Extraction: Multi-Agent Orchestration

### Discovery (Step 1)
Found in gitops: `.claude/agents/research-parallel-*.md` (3 agents)
Applied successfully in 15+ sessions, 3x faster than serial research

### Core Elements (Step 2)
**Pattern Name**: Multi-Agent Orchestration
**Problem**: Serial execution wastes time when tasks are independent
**Solution**: Launch multiple agents in parallel for independent sub-tasks

### Grounding (Step 3)
**Pillar**: DevOps + SRE (parallel execution patterns)
**Laws**: Law 2 (improves efficiency), Law 5 (shares optimization)

### Generalizability (Step 4)
**Universal**: Parallelizing independent work
**Context-specific**: Claude Code's Task tool syntax

### Evidence (Step 5)
15 sessions, 3x speedup, 100% success when tasks truly independent

### Anti-Patterns (Step 6)
❌ Parallelizing dependent tasks (causes conflicts)
❌ Over-parallelization (diminishing returns >5 agents)
❌ Parallel without coordination (lost context)

### Cross-References (Step 7)
Factor III (single-responsibility enables parallelization)
Pattern: Phase-based workflow (use in research phase)

### Output (Step 8)
File: `patterns/multi-agent-orchestration.md`
Validated with factor-compliance-checker: 90% compliant

## Common Extraction Pitfalls

### Extracting Too Early
**Problem**: Pattern hasn't been validated enough times
**Solution**: Wait for 3+ successful applications before extracting

### Over-Generalizing
**Problem**: Claiming universality without cross-domain validation
**Solution**: Be honest about what's been tested where

### Missing Evidence
**Problem**: Theoretical patterns without production metrics
**Solution**: Extract only from real implementations with data

### Weak Pillar Grounding
**Problem**: Superficial connection to Four Pillars
**Solution**: Explain WHY the pillar supports this pattern

### Incomplete Anti-Patterns
**Problem**: Only showing what works, not what fails
**Solution**: Document 3+ anti-patterns from real mistakes

## Resources

### assets/pattern-template.md
Complete markdown template for pattern documentation. Copy this when creating new patterns to ensure all required sections are present.

### references/pillar-mapping-guide.md
Detailed guide for grounding patterns in the Four Pillars. Includes decision trees and examples of strong vs. weak grounding.

### references/cross-reference-map.md
Map of relationships between patterns, factors, and framework components. Use this to identify where new patterns fit in the ecosystem.

### references/extraction-guide.md
Extended step-by-step guide for pattern extraction with detailed examples from production extractions (phase-based workflow, multi-agent orchestration, etc.).

---

**Remember**: Patterns are how the framework compounds. Extract rigorously, document honestly, and ground deeply.
