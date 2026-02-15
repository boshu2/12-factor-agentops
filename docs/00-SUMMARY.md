# 12-Factor AgentOps Summary

**Purpose:** The Operational Discipline for Working With AI Agents -- principles that turn ad-hoc agent usage into a reliable, compounding practice.
**Compression:** ~10k token summary providing 99% context from full corpus.

---

## The Core Insight

**The model isn't the problem. The operations are.**

Every agent session starts from zero. Same context problems. Same mistakes repeated. Same rework. People blame the model when they get bad results. The real problem is how they operate: overloaded context windows, no session memory, no validation, no learning loops. Fix the operations and the same model performs dramatically better.

**The Solution:** Twelve vendor-neutral principles for managing context, validating work, and compounding knowledge across agent sessions.

**The Workflow:**
```
Research --> Plan --> Implement --> Validate --> Extract learnings --> Compound knowledge
```

**We Are:** Operational principles for working with AI agents -- the discipline underneath build methodologies like Vibe Coding, GSD, and Superpowers.

**We Are NOT:** A framework for building autonomous agent applications. For that, see [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) by Dex Horthy.

---

## The Ecosystem

```
BUILD                    WORK                     OPERATE
12-Factor Agents    -->  Vibe Coding         -->  12-Factor AgentOps
(HumanLayer)             (Gene Kim & Steve Yegge)  (Operational Discipline)
```

| Layer | Framework | Focus |
|-------|-----------|-------|
| **BUILD** | [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (Dex Horthy) | Engineering patterns for building AI agent applications |
| **WORK** | [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) (Gene Kim & Steve Yegge) | Methodology for working with AI agents |
| **OPERATE** | **12-Factor AgentOps** (this) | Operational discipline for agent-assisted work |

**Vibe Coding is the DevOps movement for AI.** 12-Factor AgentOps is the operational discipline underneath it -- the practices that make agent-assisted work reliable, repeatable, and compounding.

---

## The 12 Factors (Four Tiers)

### Foundation (I--III) -- Start Here

Non-negotiable basics that work with zero tooling. Get these wrong and nothing else matters.

| Factor | Name | The Rule | What It Prevents |
|--------|------|----------|------------------|
| **[I](../factors/01-context-is-everything.md)** | **Context Is Everything** | Manage what enters the context window like you manage what enters production. Never exceed 40% utilization. | Context collapse, instruction loss, confabulation |
| **[II](../factors/02-track-everything-in-git.md)** | **Track Everything in Git** | If it's not in git, it didn't happen. Learnings, decisions, and knowledge artifacts are versioned alongside code. | Lost institutional memory, phantom changes |
| **[III](../factors/03-one-agent-one-job.md)** | **One Agent, One Job** | Each agent gets a scoped task and fresh context. Never reuse a saturated window. | Scope creep, cognitive overload, instruction drift |

### Workflow (IV--VI) -- The Discipline

How work flows through agents. The discipline that separates "prompting and hoping" from a reliable operating model.

| Factor | Name | The Rule | What It Prevents |
|--------|------|----------|------------------|
| **[IV](../factors/04-research-before-you-build.md)** | **Research Before You Build** | Understand the problem space before generating a single line of code. | Debug loop spirals, architectural rework |
| **[V](../factors/05-validate-externally.md)** | **Validate Externally** | No agent grades its own work. Ever. Tests, linters, separate sessions, or humans validate. | Tests Passing Lie, bridge torching, broken claims |
| **[VI](../factors/06-lock-progress-forward.md)** | **Lock Progress Forward** | Once work passes validation, it ratchets -- it cannot regress. | Session amnesia, rework loops, eldritch horror accumulation |

### Knowledge (VII--IX) -- Where Compounding Kicks In

Systematic extraction and injection of knowledge. This is where sessions start getting measurably smarter over time.

| Factor | Name | The Rule | What It Prevents |
|--------|------|----------|------------------|
| **[VII](../factors/07-extract-learnings.md)** | **Extract Learnings** | Every session produces two outputs -- the work product and the lessons learned. | Repeating past failures, institutional amnesia |
| **[VIII](../factors/08-compound-knowledge.md)** | **Compound Knowledge** | Learnings must flow back into future sessions automatically. Extract, gate, inject, measure, decay. | Knowledge rot, stale context, manual overhead |
| **[IX](../factors/09-measure-what-matters.md)** | **Measure What Matters** | Track fitness toward goals, not activity metrics. If you can't measure it, you can't validate it. | Silent degradation, vanity metrics, invisible failures |

**Factor VIII is the hero.** It implements the knowledge flywheel: extract learnings from sessions, gate them for quality, inject them into future sessions, measure retrieval effectiveness, and let stale knowledge decay. This is the differentiator that cannot be commoditized -- better models don't replace institutional memory.

### Scale (X--XII) -- Advanced, Optional

Multi-agent orchestration patterns. Skip this entire tier if you work solo. You lose nothing. These patterns apply when you are running parallel agents on complex projects.

| Factor | Name | The Rule | What It Prevents |
|--------|------|----------|------------------|
| **[X](../factors/10-isolate-workers.md)** | **Isolate Workers** | Each worker gets its own workspace, its own context, and zero shared mutable state. | Workspace collisions, cross-agent corruption |
| **[XI](../factors/11-supervise-hierarchically.md)** | **Supervise Hierarchically** | Escalation flows up, never sideways. One coordinator dispatches, workers execute. | Multi-agent deadlock, circular dependencies |
| **[XII](../factors/12-harvest-failures-as-wisdom.md)** | **Harvest Failures as Wisdom** | Failed attempts are data. Extract and index them with the same rigor as successes. | Repeated failure patterns, lost negative knowledge |

---

## The 40% Rule (Factor I)

**Never exceed 40% of context window in any phase.**

| % Utilization | Effect |
|---------------|--------|
| 0-40% | Optimal: coherent, accurate responses |
| 40-60% | Degradation begins: subtle errors |
| 60-80% | Significant: instruction loss, drift |
| 80-100% | Critical: confabulation, contradictions |

### JIT Loading Strategies

1. **Start minimal:** 30-second overview, load details on-demand
2. **Progressive disclosure:** Layer 1 (5%) then Layer 2 (15%) then Layer 3 (40% only if needed)
3. **Compress periodically:** Summarize decisions, extract patterns, drop ephemeral details
4. **Session splitting:** Long tasks become multiple sessions with handoff summaries

---

## The Three Core Skills

The operational workflow expressed as skills:

| Skill | Purpose | When |
|-------|---------|------|
| **/pre-mortem** | Simulate failures before implementing | BEFORE you build |
| **/vibe** | Validate before you commit | BEFORE every commit |
| **/retro** | Extract learnings to compound knowledge | AFTER each session |

**Supporting skills:** /research (Factor IV: understand before acting), /plan (decompose before implementing), /crank (execute with validation gates)

---

## The Knowledge Flywheel (Factor VIII)

The compounding loop that is the core differentiator:

```
Session --> Forge (extract learnings) --> Pool (quality gate) --> Inject (apply to next session)
    ^___________________________________________________________________________|
```

**Session 1:** Agent knows nothing about your codebase. Makes common mistakes. Ignores conventions.
**Session 10:** Agent knows your patterns. Avoids documented pitfalls. Follows conventions from context.
**Session 100:** Agent operates with institutional memory. Knows what has been tried and failed. Builds on everything that came before.

**The HERO cycle:** Extract --> Gate --> Inject --> Measure --> Decay. Knowledge that proves useful gets reinforced. Knowledge that stops being retrieved decays naturally. The system self-regulates toward relevance.

**Why this cannot be commoditized:** Better models with amnesia still repeat your mistakes. Knowledge compounding is the one capability no amount of model improvement replaces.

---

## The 12 Failure Patterns

### Inner Loop Failures (Seconds to Minutes)

| Pattern | Severity | What Went Wrong | Relevant Factor |
|---------|----------|-----------------|-----------------|
| **1. Tests Passing Lie** | HIGH | Agent claims tests pass, code is broken | V. Validate Externally |
| **2. Context Amnesia** | MEDIUM | Agent forgets instructions from 5 min ago | I. Context Is Everything |
| **3. Instruction Drift** | MEDIUM | Agent gradually deviates from requirements | III. One Agent, One Job |
| **4. Debug Loop Spiral** | HIGH | Agent adds logging instead of fixing root cause | IV. Research Before You Build |

### Middle Loop Failures (Hours to Days)

| Pattern | Severity | What Went Wrong | Relevant Factor |
|---------|----------|-----------------|-----------------|
| **5. Eldritch Code Horror** | CRITICAL | 3000+ line functions, everything tangled | VI. Lock Progress Forward |
| **6. Workspace Collision** | HIGH | Multiple agents corrupt each other's work | X. Isolate Workers |
| **7. Memory Tattoo Decay** | MEDIUM | Cannot resume work across sessions | VIII. Compound Knowledge |
| **8. Multi-Agent Deadlock** | HIGH | Circular dependencies, agents waiting on each other | XI. Supervise Hierarchically |

### Outer Loop Failures (Weeks to Months)

| Pattern | Severity | What Went Wrong | Relevant Factor |
|---------|----------|-----------------|-----------------|
| **9. Bridge Torching** | CRITICAL | Agent changes APIs, breaks all dependencies | V. Validate Externally |
| **10. Repository Deletion** | CRITICAL | Agent deletes "unused" critical code | V. Validate Externally |
| **11. Process Gridlock** | HIGH | Approval processes negate AI speed gains | VI. Lock Progress Forward |
| **12. Stewnami** | HIGH | Changes break unrelated features | XII. Harvest Failures as Wisdom |

**The meta-pattern:** AI optimizes for immediate success, not systemic health. Operational discipline catches these before they ship.

---

## Three Developer Loops

| Loop | Timeframe | Operational Focus | Key Skills |
|------|-----------|-------------------|------------|
| **Inner** | Seconds-Minutes | Factor V: Validate agent claims externally | /vibe |
| **Middle** | Hours-Days | Factor IV: Research before building | /pre-mortem |
| **Outer** | Weeks-Months | Factor VIII: Compound knowledge across sessions | /retro |

---

## The Inverted Adoption Model

Traditional frameworks start with a manifesto and end with results. 12-Factor AgentOps inverts this: start with results, adopt principles as pain points emerge.

```
Quickstart (5 min)     --> learnings.md file, zero tooling
Foundation (I-III)     --> Context discipline, git tracking, fresh sessions
Workflow (IV-VI)       --> Research, external validation, ratcheting
Knowledge (VII-IX)     --> Extraction, compounding, measurement
Scale (X-XII)          --> Multi-agent isolation, supervision, failure harvesting (OPTIONAL)
```

**You can stop at any tier and keep the value.** Each tier justifies the next, but none requires it. When to level up:

- **Quickstart to Foundation:** When learnings.md gets unwieldy or you notice repeated context problems
- **Foundation to Workflow:** When you find yourself re-explaining codebase patterns to new sessions
- **Workflow to Knowledge:** When the same mistakes recur across sessions despite research
- **Knowledge to Scale:** When you run multiple agents in parallel and conflicts emerge

---

## Quick Reference by Pain Point

| Pain Point | Start With | Skill |
|------------|-----------|-------|
| Agent claims tests pass but code is broken | Factor V: Validate Externally | /vibe |
| Context problems, instruction loss | Factor I: Context Is Everything | 40% rule |
| Scope creep, tangled implementations | Factor III: One Agent, One Job | /pre-mortem |
| Same mistakes repeated across sessions | Factor VIII: Compound Knowledge | /retro |
| No understanding before implementation | Factor IV: Research Before You Build | /research |
| Cannot resume work across sessions | Factor VI: Lock Progress Forward | /handoff |
| No visibility into what is working | Factor IX: Measure What Matters | /flywheel |
| Multi-agent workspace conflicts | Factor X: Isolate Workers | git worktrees |

---

## Production Evidence

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Success rate | 35% | 95% | 2.7x |
| Context collapse | 65% | 0% | Eliminated |
| Task completion | 45 min | 12 min | 3.75x |
| Documentation rework | 40% | 2% | 20x |
| Context preservation | 30% | 95% | 3.2x |

**Evidence base:** 200+ sessions, 1,175+ commits, 8+ months production.

---

## Reference Implementation

The [AgentOps plugin](https://github.com/boshu2/agentops) is the reference implementation for Claude Code. It automates the knowledge flywheel (extraction, quality gating, semantic retrieval, decay management), provides research and planning skills, and implements multi-agent coordination patterns.

**The plugin is not a prerequisite.** Every factor can be applied manually with zero tooling. The principles are universal; the automation is optional.

---

## Sources

**Foundations:**
- [12-Factor App](https://12factor.net) (Adam Wiggins, 2011) -- Original methodology for cloud-native applications
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (Dex Horthy, HumanLayer) -- Engineering patterns for building agent applications
- [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) (Gene Kim & Steve Yegge, 2025) -- The methodology of AI-assisted coding

**Research:**
- Cognitive load theory (Sweller, 1988)
- Working memory limits (Miller 1956, Cowan 2001)
- "Lost in the Middle" (Liu et al., 2023)

**Production:**
- 200+ sessions validated
- 1,175+ commits of institutional memory
- 8+ months production operations

---

**Summary Version:** 3.0.0
**Source Corpus:** 15+ documents (~80k tokens)
**Compressed To:** ~10k tokens
**Essential Coverage:** 99%
**Updated:** 2026-02-15
**Focus:** Operational discipline for working with AI agents
