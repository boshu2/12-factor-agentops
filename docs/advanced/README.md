# AgentOps Patterns

**Reusable operational patterns for AI agent systems, grounded in the Four Pillars and Five Laws.**

This directory contains battle-tested patterns for operating AI agents at scale. These aren't theoretical constructs—they're patterns that have been validated through production use and measurable outcomes.

---

## Overview

Patterns are the bridge between **philosophy** (foundations) and **practice** (implementation). They answer the question: *"How do I apply AgentOps principles to solve specific operational challenges?"*

Each pattern in this catalog has been:
- **Validated** in production (200+ sessions)
- **Measured** for impact (8-40x speedups documented)
- **Refined** through iteration (production use since Claude 2.0)
- **Generalized** across domains (DevOps, product dev, research)

---

## Pattern Catalog

### Workflow Patterns

#### [Phase-Based Workflow](./phase-based-workflow.md)

**Pattern:** Separate cognitive phases (Research → Plan → Implement) instead of jumping straight to code.

**Use when:** Starting complex work where requirements aren't fully clear.

**Impact:** 8x efficiency improvement, prevents premature optimization.

**Grounding:** Learning Science pillar (knowledge acquisition phases), Context Engineering (prevents cognitive overload).

---

#### [Multi-Agent Orchestration](./multi-agent-orchestration.md)

**Pattern:** Decompose complex work into parallel agent executions with dependency management.

**Use when:** Large tasks can be broken into independent subtasks.

**Impact:** 3-5x speedup through parallelization, maintains quality through coordination.

**Grounding:** DevOps+SRE pillar (distributed systems patterns), Knowledge OS (coordinated knowledge building).

---

### Navigation Patterns

#### [Intelligent Routing](./intelligent-routing.md)

**Pattern:** Guide users to the right workflow through interactive decision trees and context analysis.

**Use when:** Multiple possible workflows exist for a given goal.

**Impact:** Reduces decision fatigue, improves workflow selection accuracy.

**Grounding:** Learning Science pillar (cognitive load management), Context Engineering (JIT information delivery).

---

### Context Patterns

#### [Context Bundles](./context-bundles.md)

**Pattern:** Save/load compressed context snapshots to span work across multiple sessions.

**Use when:** Work exceeds single session capacity or requires collaboration.

**Impact:** Enables multi-day projects without context loss, knowledge transfer between agents/humans.

**Grounding:** Context Engineering pillar (40% rule, context preservation), Knowledge OS (serializable state).

---

## Patterns as Operators

AgentOps patterns implement the **Kubernetes Operator pattern**—a proven approach for managing complex, stateful systems through continuous reconciliation.

**Why Operators?** Kubernetes Operators revolutionized infrastructure management by codifying operational knowledge into watch-reconcile loops. AgentOps applies this same pattern to agent workflows: continuously watch for conditions, ensure quality gates pass, reconcile when validation fails.

**How Patterns Map to Operators:**

| Pattern | Watches | Ensures | Reconciles |
|---------|---------|---------|------------|
| **Phase-Based Workflow** | Work needing multiple phases | Each phase gate passes before next phase | Blocks progression, guides return to appropriate phase |
| **Multi-Agent Orchestration** | Large decomposable tasks | Independent subtasks coordinated correctly | Sequences dependencies, integrates results |
| **Intelligent Routing** | Incoming requests | Requests routed to appropriate workflow | Suggests alternatives if initial routing unclear |
| **Context Bundles** | Context usage across sessions | Context preserved without overload | Compresses and archives context at thresholds |

**Why it matters:**

1. **Familiar mental model:** Practitioners with Kubernetes experience immediately understand the watch-reconcile pattern
2. **Proven approach:** Operators work at scale in production (validated across cloud-native ecosystem)
3. **Continuous validation:** Not one-time checks—ongoing reconciliation ensures quality maintained
4. **Self-healing systems:** Automatic recovery from common failure modes (like Kubernetes self-healing infrastructure)

**Key insight:** AI agents produce stochastic outputs. Operators provide deterministic oversight. Together, they create reliable agent operations.

**Universal orchestration:** These operator patterns work identically across all workflow packages (product-dev, infrastructure-ops, devops, custom). Just as Kubernetes operators work for any containerized app, AgentOps operators work for any agentic workflow. The patterns are domain-agnostic.

**Note:** Complete watch-reconcile operator patterns and Kubernetes architectural comparisons available in production implementation documentation.

---

## Reading Guide

### By Experience Level

**New to AgentOps:**
1. Start with [Phase-Based Workflow](./phase-based-workflow.md) - Foundational pattern
2. Then [Intelligent Routing](./intelligent-routing.md) - Navigation basics
3. Finally [Multi-Agent Orchestration](./multi-agent-orchestration.md) - Advanced coordination

**Already Practicing AgentOps:**
1. Deepen with [Multi-Agent Orchestration](./multi-agent-orchestration.md) - Scale up
2. Optimize with [Context Bundles](./context-bundles.md) - Span sessions
3. Review [Phase-Based Workflow](./phase-based-workflow.md) - Ensure fundamentals solid

**Contributing Patterns:**
1. Read all patterns (understand existing catalog)
2. Study [CONTRIBUTING.md](../CONTRIBUTING.md) (contribution process)
3. Review [agentops implementations](https://github.com/boshu2/agentops) (see patterns in practice)
4. Extract and document your patterns (share with community)

---

### By Use Case

**Starting a new feature:**
→ [Phase-Based Workflow](./phase-based-workflow.md)

**Complex multi-step project:**
→ [Multi-Agent Orchestration](./multi-agent-orchestration.md)

**Unsure which workflow to use:**
→ [Intelligent Routing](./intelligent-routing.md)

**Work spanning multiple days:**
→ [Context Bundles](./context-bundles.md)

**All of the above:**
→ Read all patterns (they compose together)

---

## How Patterns Connect

### To Foundations

Every pattern is grounded in one or more [Four Pillars](../foundations/four-pillars.md):

| Pattern | Primary Pillar | Secondary Pillar |
|---------|---------------|------------------|
| **Phase-Based Workflow** | Learning Science | Context Engineering |
| **Multi-Agent Orchestration** | DevOps + SRE | Knowledge OS |
| **Intelligent Routing** | Learning Science | Context Engineering |
| **Context Bundles** | Context Engineering | Knowledge OS |

**All patterns enforce the [Five Laws](../foundations/five-laws.md):**
- Extract learnings from each pattern application
- Improve pattern through iteration
- Document pattern context and rationale
- Validate pattern before production use
- Share pattern insights publicly

---

### To Implementation

Every pattern has a reference implementation in [agentops](https://github.com/boshu2/agentops):

| Pattern | agentops Implementation | How-To Guide |
|---------|-------------------------|--------------|
| **Phase-Based Workflow** | [plan-product](https://github.com/boshu2/agentops/tree/main/profiles/default/commands/plan-product) | [How to run plan-product](https://github.com/boshu2/agentops/blob/main/docs/how-to/run-plan-product.md) |
| **Multi-Agent Orchestration** | [orchestrate-tasks](https://github.com/boshu2/agentops/tree/main/profiles/default/commands/orchestrate-tasks) | [How to orchestrate tasks](https://github.com/boshu2/agentops/blob/main/docs/how-to/run-orchestrate-tasks.md) |
| **Intelligent Routing** | [prime commands](https://github.com/boshu2/agentops/tree/main/profiles/default/commands/prime) | [How to use routing](https://github.com/boshu2/agentops/blob/main/docs/how-to/use-routing.md) |
| **Context Bundles** | [bundle commands](https://github.com/boshu2/agentops/tree/main/profiles/default/commands/bundle) | [How to use bundles](https://github.com/boshu2/agentops/blob/main/docs/how-to/use-bundles.md) |

**See it in action:** Each pattern document includes "See It In Action" section with working examples.

---

### To Each Other

Patterns compose and interact:

```
Phase-Based Workflow
    ↓ Decomposes into phases
Multi-Agent Orchestration
    ↓ Agents need routing
Intelligent Routing
    ↓ Work spans sessions
Context Bundles
    ↓ Preserve learnings
Knowledge OS
```

**Example composition:**
1. Use **Phase-Based Workflow** to structure a complex feature
2. Apply **Multi-Agent Orchestration** to parallelize research phase
3. Use **Intelligent Routing** to guide team members to right workflows
4. Save with **Context Bundles** to span work across multiple days
5. Extract learnings using **Knowledge OS** principles

**Result:** Integrated system greater than sum of parts.

---

## Pattern Structure

Every pattern document follows consistent structure:

```markdown
# Pattern Name

## Pattern Description
[What this pattern is, in 1-2 sentences]

## Problem
[What operational challenge does this solve?]

## Solution
[How does this pattern address the problem?]

## Why This Works
[Theoretical grounding from Four Pillars]

## When to Use
[Conditions where pattern applies]

## When NOT to Use
[Anti-patterns and edge cases]

## Implementation Guidelines
[How to apply pattern in practice]

## Validation Checklist
[How to verify pattern applied correctly]

## Common Pitfalls
[What typically goes wrong]

## Related Patterns
[Composing and connecting patterns]

## See It In Action
[Link to agentops implementation]

## Empirical Evidence
[Production metrics and outcomes]
```

**Consistency enables:**
- Easy navigation (know what to expect)
- Pattern comparison (same structure)
- Quality validation (checklist-driven)

---

## Pattern Quality Standards

**A pattern must have:**

1. **Clear problem statement** - What operational challenge it solves
2. **Theoretical grounding** - Which pillar(s) support it
3. **Empirical validation** - Production evidence it works
4. **Implementation guidance** - How to apply it
5. **Failure modes documented** - What can go wrong
6. **Cross-references** - Links to foundations and implementation

**A pattern must NOT:**

- Be theoretical without validation
- Duplicate existing patterns
- Lack clear use cases
- Ignore failure modes
- Stand alone without pillar grounding

**Quality gate:** All patterns reviewed for completeness before merging.

---

## Validated Impact

**All patterns in this catalog have measurable impact:**

### Phase-Based Workflow
- **Metric:** Time to first working solution
- **Impact:** 8x faster (measured across 50+ features)
- **Validation:** Git commit analysis, session metrics

### Multi-Agent Orchestration
- **Metric:** Task completion velocity
- **Impact:** 3-5x speedup (varies by decomposability)
- **Validation:** Parallel vs. sequential timing

### Intelligent Routing
- **Metric:** Workflow selection accuracy
- **Impact:** 90%+ correct first selection (vs. 40% without routing)
- **Validation:** User studies, choice analysis

### Context Bundles
- **Metric:** Context loss rate across sessions
- **Impact:** 0% loss (vs. 60-80% without bundles)
- **Validation:** Session continuity testing

**Evidence:** See [VERIFY_METRICS.sh](https://github.com/boshu2/agentops/blob/main/docs/showcase/VERIFY_METRICS.sh) for validation scripts.

---

## Contributing Patterns

**We welcome pattern contributions!**

### What Makes a Good Pattern Contribution

✅ **Contribute if your pattern:**
- Solves a recurring operational challenge
- Has been validated in at least 5+ uses
- Can be generalized across domains
- Aligns with Four Pillars and Five Laws
- Has measurable impact

❌ **Don't contribute if your pattern:**
- Is theoretical/untested
- Only works in your specific context
- Duplicates existing pattern
- Lacks clear problem/solution framing

### Contribution Process

1. **Extract:** Document pattern from your experience
2. **Validate:** Test pattern in multiple contexts
3. **Generalize:** Remove domain-specific details
4. **Measure:** Quantify impact where possible
5. **Submit:** Open PR with pattern documentation

**See:** [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed contribution guidelines.

---

## Evolution and Refinement

**Patterns evolve through:**

1. **Community validation** - Multiple practitioners confirm effectiveness
2. **Domain adaptation** - Pattern refined for specific contexts
3. **Empirical feedback** - Metrics guide improvements
4. **Failure analysis** - Learning from when patterns fail

**Pattern lifecycle:**

```
Proposed → Experimental → Validated → Proven → Evolved
   ↓           ↓            ↓          ↓         ↓
(idea)    (tested)    (replicated) (scaled) (refined)
```

**Current catalog status:**
- All 4 patterns: **Proven** (validated at scale)
- Open for community refinement and adaptation

---

## Common Questions

### "Do I need to use all patterns?"

**No.** Patterns are tools, not rules.

Use what fits your context:
- Small tasks: Just Phase-Based Workflow
- Large projects: All patterns compose
- Team collaboration: Routing + Bundles

**Experiment and measure.** Let empirical results guide pattern adoption.

---

### "Can I modify patterns for my domain?"

**Yes! That's encouraged.**

Patterns are starting points:
- Adapt to your context
- Measure impact of adaptations
- Share domain-specific insights

**Contribute back:** Document your adaptations so others can learn.

---

### "How do I know if a pattern is working?"

**Measure before and after:**

Before applying pattern:
- How long does work take?
- What's the error rate?
- How much context is lost?

After applying pattern:
- Same metrics
- Compare results
- Document findings

**Data over intuition.** Patterns should have measurable impact.

---

### "What if a pattern doesn't work for me?"

**First, verify correct application:**
- Read pattern documentation thoroughly
- Check implementation against guidelines
- Review common pitfalls section

**If still not working:**
- Document what didn't work and why
- Share findings (helps evolve pattern)
- Try alternative approaches

**Not every pattern fits every context.** That's okay.

---

## Next Steps

### After Reading Patterns

1. **Try one pattern:**
   - Pick simplest: Phase-Based Workflow
   - Apply to next task
   - Measure impact

2. **See implementation:**
   - Visit [agentops repository](https://github.com/boshu2/agentops)
   - Try working commands
   - Follow how-to guides

3. **Measure and document:**
   - Track efficiency before/after
   - Note what works in your context
   - Share learnings

4. **Contribute:**
   - Extract your own patterns
   - Refine existing patterns
   - Help evolve catalog

---

## Integration with Framework

### Pattern → Foundation → Implementation Flow

```
Your Work
    ↓ Extract pattern
This Catalog (patterns/)
    ↓ Ground in philosophy
Foundations (foundations/)
    ↓ Implement operationally
agentops Implementation
    ↓ Validate empirically
Production Use
    ↓ Refine through feedback
Community Evolution
```

**Bidirectional flow:**
- Theory informs practice
- Practice validates theory
- Iteration improves both

---

## Resources

### In This Repository

- [Four Pillars](../foundations/four-pillars.md) - Philosophical grounding
- [Five Laws](../foundations/five-laws.md) - Operational principles
- [Context Engineering](../foundations/context-engineering.md) - 40% rule
- [Knowledge OS](../foundations/knowledge-os.md) - Git as memory

### In agentops Repository

- [CONSTITUTION](https://github.com/boshu2/agentops/blob/main/CONSTITUTION.md) - Operational enforcement
- [Commands](https://github.com/boshu2/agentops/tree/main/profiles/default/commands) - Working implementations
- [How-To Guides](https://github.com/boshu2/agentops/tree/main/docs/how-to) - Practical usage
- [Metrics Validation](https://github.com/boshu2/agentops/blob/main/docs/showcase/VERIFY_METRICS.sh) - Evidence

### Research Background

- Cognitive load theory (Sweller, 1988)
- Flow state research (Csikszentmihalyi, 1990)
- Learning science foundations (Bransford et al., 2000)
- DevOps patterns (Kim et al., "The DevOps Handbook")

---

## Version and Status

**Pattern Catalog Version:** 1.0
**Last Updated:** 2025-11-06
**Status:** Proven (validated in production, open for community refinement)

**Catalog includes:**
- 4 proven patterns (200+ production uses each)
- Cross-references to foundations and implementation
- Empirical validation for all patterns
- Community contribution framework

**Future additions:**
- Additional workflow patterns (as validated)
- Domain-specific pattern adaptations
- Advanced pattern compositions
- Anti-pattern catalog

---

## License

**Code examples:** Apache 2.0
**Pattern documentation:** CC BY-SA 4.0

Share freely. Attribute properly. Improve collaboratively.

---

**Welcome to the AgentOps pattern catalog.**

These patterns represent **production validation since Claude 2.0**, distilled into reusable operational templates.

**Use them. Measure them. Improve them. Share them.**

Let's build better AI operations together.