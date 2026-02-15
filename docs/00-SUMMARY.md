# 12-Factor AgentOps Summary

**Purpose:** The Operational Discipline for Working With AI Agents — principles that turn ad-hoc agent usage into a reliable, compounding practice
**Compression:** ~10k token summary providing 99% context from full corpus

---

## The Operational Discipline

**The Problem:** Every agent session starts from zero. Same mistakes, same context problems, same rework. Better models don't fix this — better operations do.

**The Solution:** Twelve vendor-neutral principles for managing context, validating work, and compounding knowledge across agent sessions.

**The Workflow:**
```
Research → Plan → Implement → Validate → Extract learnings → Compound knowledge
```

**We Are:** Operational principles for working with AI agents — the discipline underneath build methodologies like Vibe Coding, GSD, and Superpowers.

**We Are NOT:** A framework for general autonomous production agents. For that, see [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) by Dex Horthy.

---

## The Ecosystem: BUILD → WORK → RUN

```
BUILD → WORK → RUN

12-Factor Agents  → Vibe Coding → 12-Factor AgentOps
(HumanLayer)        (Gene & Steve)    (Validation)
```

| Layer | Framework | Focus |
|-------|-----------|-------|
| **BUILD** | 12-Factor Agents (Dex Horthy) | Engineering patterns for building AI apps |
| **WORK** | Vibe Coding (Gene Kim & Steve Yegge) | Methodology for working with AI agents |
| **RUN** | **12-Factor AgentOps** (this) | Shift-left validation for coding agents |

**Vibe Coding is the DevOps movement for AI.**
**12-Factor AgentOps is shift-left validation for vibe-coding.**

---

## The Three Core Skills

The shift-left workflow expressed as skills:

| Skill | Purpose | When |
|-------|---------|------|
| **/pre-mortem** | Simulate failures before implementing | BEFORE you build |
| **/vibe** | Validate before you commit | BEFORE every commit |
| **/retro** | Extract learnings to compound knowledge | AFTER each session |

**Supporting skills:** /research (understand before acting), /plan (think before implementing), /crank (execute with validation gates)

---

## The 12 Factors (Validation Lens)

### Foundation (I-IV) — Build Validation In

| Factor | Validation Purpose | What It Catches |
|--------|-------------------|-----------------|
| **I. Automated Tracking** | Track everything in git. Validate against history. | Drift from working patterns |
| **II. Context Loading** | Load only what you need. Stay under 40%. | Context collapse, instruction loss |
| **III. Focused Agents** | One agent, one job. Validate scope. | Scope creep, cognitive overload |
| **IV. Continuous Validation** | Check at every step. Catch errors early. | Tests Passing Lie, broken claims |

### Operations (V-VIII) — Validate in Production

| Factor | Validation Purpose | What It Catches |
|--------|-------------------|-----------------|
| **V. Measure Everything** | If you can't measure it, you can't validate it. | Silent failures, degradation |
| **VI. Resume Work** | Save state. Validate continuity. | Session amnesia, lost context |
| **VII. Smart Routing** | Send tasks to the right validator. | Debug loop spirals, misrouted work |
| **VIII. Human Validation** | Humans approve critical steps. | Bridge torching, destructive actions |

### Improvement (IX-XII) — Validate and Compound

| Factor | Validation Purpose | What It Catches |
|--------|-------------------|-----------------|
| **IX. Mine Patterns** | Search history. Validate against what worked. | Repeating past failures |
| **X. Small Iterations** | Small changes. Validate incrementally. | Eldritch horror accumulation |
| **XI. Fail-Safe Checks** | Prevent repeating mistakes. Validate guardrails. | Regression to known failures |
| **XII. Package Patterns** | Bundle validations. Reuse what works. | Reinventing validation wheels |

---

## The 40% Rule

**Never exceed 40% of context window in any phase.**

| % Utilization | Effect |
|---------------|--------|
| 0-40% | Optimal: coherent, accurate responses |
| 40-60% | Degradation begins: subtle errors |
| 60-80% | Significant: instruction loss, drift |
| 80-100% | Critical: confabulation, contradictions |

### JIT Loading Strategies

1. **Start minimal:** 30-second overview, load details on-demand
2. **Progressive disclosure:** Layer 1 (5%) → Layer 2 (15%) → Layer 3 (40% only if needed)
3. **Compress periodically:** Summarize decisions, extract patterns, drop ephemeral details
4. **Session splitting:** Long tasks → multiple sessions with handoff summaries

---

## The 12 Failure Patterns (What Validation Catches)

### Inner Loop Failures

| Pattern | Severity | What Went Wrong | Validation Factor |
|---------|----------|-----------------|-------------------|
| **1. Tests Passing Lie** | HIGH | AI claims tests pass, code is broken | IV (Continuous Validation) |
| **2. Context Amnesia** | MEDIUM | AI forgets instructions from 5 min ago | II (Context Loading) |
| **3. Instruction Drift** | MEDIUM | AI gradually deviates from requirements | III (Focused Agents), X |
| **4. Debug Loop Spiral** | HIGH | AI adds logging instead of fixing | VII (Smart Routing) |

### Middle Loop Failures

| Pattern | Severity | What Went Wrong | Validation Factor |
|---------|----------|-----------------|-------------------|
| **5. Eldritch Code Horror** | CRITICAL | 3000+ line functions, everything tangled | X (Small Iterations) |
| **6. Agent Workspace Collision** | HIGH | Multiple agents corrupt each other's work | II, VII (Partitioning) |
| **7. Memory Tattoo Decay** | MEDIUM | Can't resume work across sessions | VI (Resume Work) |
| **8. Multi-Agent Deadlock** | HIGH | Circular dependencies, agents waiting | III, VII |

### Outer Loop Failures

| Pattern | Severity | What Went Wrong | Validation Factor |
|---------|----------|-----------------|-------------------|
| **9. Bridge Torching** | CRITICAL | AI changes APIs, breaks all dependencies | IV (Validation), VIII |
| **10. Repository Deletion** | CRITICAL | AI deletes "unused" critical code | VIII (Human Validation) |
| **11. Process Gridlock** | HIGH | Approval processes negate AI gains | IV (Automation) |
| **12. Stewnami** | HIGH | Changes break unrelated features | X, XII (Modularity) |

### The Meta-Pattern

**AI optimizes for immediate success, not systemic health.**

Shift-left validation catches these BEFORE they ship.

---

## Knowledge Flywheel

The validation loop that compounds:

```
Session → Forge (extract learnings) → Pool (validate) → Inject (apply)
    ↑____________________________________________________________|
```

Every session makes the next one better. This is the moat.

---

## Three Developer Loops

| Loop | Timeframe | Validation Focus | Key Skills |
|------|-----------|------------------|------------|
| **Inner** | Seconds-Minutes | /vibe check claims | Direct validation |
| **Middle** | Hours-Days | /pre-mortem before build | Risk simulation |
| **Outer** | Weeks-Months | /retro to extract patterns | Compound learning |

---

## Production Validation

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Success rate | 35% | 95% | 2.7x |
| Context collapse | 65% | 0% | Eliminated |
| Task completion | 45 min | 12 min | 3.75x |
| Documentation rework | 40% | 2% | 20x |
| Context preservation | 30% | 95% | 3.2x |

**Evidence base:** 200+ sessions, 1,175+ commits, 8+ months production

---

## Quick Reference by Pain Point

| Pain Point | Start With | Skill |
|------------|-----------|-------|
| AI claims tests pass but code is broken | Factor IV: Continuous Validation | /vibe |
| Context problems, instruction loss | Factor II: Context Loading | 40% rule |
| Scope creep, tangled implementations | Factor III: Focused Agents | /pre-mortem |
| Can't resume work across sessions | Factor VI: Resume Work | /handoff |
| Repeated mistakes | Factor XI: Fail-Safe Checks | /retro |
| No visibility into what's happening | Factor V: Measure Everything | /flywheel |

---

## Implementation

**[agentops](https://github.com/boshu2/agentops)** — Claude Code plugin marketplace implementing these factors.

Core plugins:
- **skills** — /pre-mortem, /vibe, /retro, /research, /plan, /crank
- **cli** — `ao` command for knowledge flywheel management
- **hooks** — SessionStart injection of prior learnings

---

## Sources

**Foundations:**
- 12-Factor App (Adam Wiggins, 2011) - Original methodology
- 12-Factor Agents (Dex Horthy, HumanLayer) - Engineering patterns for general autonomous agents
- Vibe Coding (Gene Kim & Steve Yegge, 2025) - DevOps movement for AI

**Research:**
- Cognitive load theory (Sweller, 1988)
- Working memory limits (Miller 1956, Cowan 2001)
- "Lost in the Middle" (Liu et al., 2023)

**Production:**
- 200+ sessions validated
- 1,175+ commits of institutional memory
- 8+ months production operations

---

**Summary Version:** 2.0.0
**Source Corpus:** 15+ documents (~80k tokens)
**Compressed To:** ~8k tokens
**Essential Coverage:** 99%
**Updated:** 2026-01-31
**Focus:** Shift-left validation for coding agents
