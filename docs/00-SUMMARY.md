# 12-Factor AgentOps Summary

**Purpose:** 10k token summary providing 99% context from full 12-factor-agentops corpus
**Compression:** ~10:1 ratio with zero essential loss

---

## The Ecosystem: BUILD → WORK → RUN

```
BUILD → WORK → RUN

12-Factor Agents  → Vibe Coding → 12-Factor AgentOps
(HumanLayer)        (Gene & Steve)    (Operations)
```

| Layer | Framework | Focus |
|-------|-----------|-------|
| **BUILD** | 12-Factor Agents (Dex Horthy) | Engineering patterns for building AI apps |
| **WORK** | Vibe Coding (Gene Kim & Steve Yegge) | Methodology for working with AI agents |
| **RUN** | **12-Factor AgentOps** (this) | Operational principles for reliability |

**Vibe Coding is the DevOps movement for AI.**
**12-Factor AgentOps is the SRE to their DevOps.**

---

## Why Traditional Practices Fail

| | Deterministic Code | AI Agents |
|-|-------------------|-----------|
| **Consistency** | Same input → same output | Same input → different output |
| **Errors** | Predictable, reproducible | Novel, context-dependent |
| **Testing** | Unit tests, edge cases | Probabilistic sampling |
| **Reliability** | Code review, testing | Observability, validation, fallbacks |

**The answer:** 20 years of DevOps/SRE wisdom applied to probabilistic systems.

---

## The 12 Factors

### Foundation (I-IV)

| Factor | What It Does | Constraint Addressed |
|--------|--------------|---------------------|
| **I. Automated Tracking** | Track everything in git. No tribal knowledge. | Human memory limitations |
| **II. Context Loading** | Load only what you need. Stay under 40%. | 200k token context window |
| **III. Focused Agents** | One agent, one job. Compose specialists. | Cognitive load per agent |
| **IV. Continuous Validation** | Check at every step. Catch errors early. | Probabilistic AI outputs |

### Operations (V-VIII)

| Factor | What It Does | Constraint Addressed |
|--------|--------------|---------------------|
| **V. Measure Everything** | If you can't measure it, you can't improve it. | System observability |
| **VI. Resume Work** | Save state. Pick up where you left off. | Multi-day work sessions |
| **VII. Smart Routing** | Send tasks to the right specialist. | Specialized capabilities |
| **VIII. Human Validation** | Humans approve critical steps. | Critical decision risk |

### Improvement (IX-XII)

| Factor | What It Does | Constraint Addressed |
|--------|--------------|---------------------|
| **IX. Mine Patterns** | Search history. Find what works. | Institutional learning |
| **X. Small Iterations** | Improve continuously. Small tweaks compound. | Optimization cycle time |
| **XI. Fail-Safe Checks** | Prevent repeating mistakes. Add guardrails. | Repeated mistakes |
| **XII. Package Patterns** | Bundle what works. Reuse it. | Cross-domain portability |

---

## The Nine Laws

| Law | Principle | Why It Matters |
|-----|-----------|----------------|
| **1. ALWAYS Extract Learnings** | Every session extracts at least one pattern | Linear → exponential progress |
| **2. ALWAYS Improve Self or System** | Identify at least one improvement per session | Entropy increases without effort |
| **3. ALWAYS Document Context** | Context/Solution/Learning/Impact for every decision | Future you is a stranger |
| **4. ALWAYS Validate Before Execute** | Preview, diff, dry-run before irreversible actions | Prevention cheaper than recovery |
| **5. ALWAYS Share Patterns Publicly** | Extract generalizable insights and share them | Knowledge shared is multiplied |

### Law Enforcement Pattern

```
Execute work with validation (Law 4)
    ↓
Extract patterns from the work (Law 1)
    ↓
Identify improvement opportunities (Law 2)
    ↓
Document context for future (Law 3)
    ↓
Share generalizable insights (Law 5)
```

---

## The Five Pillars

| Pillar | Source | What It Provides |
|--------|--------|------------------|
| **DevOps + SRE** | 20+ years production ops | Validation, observability, reliability |
| **Learning Science** | Cognitive psychology | How humans and systems learn |
| **Context Engineering** | LLM research + ADHD patterns | 40% rule, JIT loading |
| **Knowledge OS** | Git as memory | Institutional memory that compounds |

---

## The 40% Rule

**Never exceed 40% of context window in any phase.**

### Why 40%?

| % Utilization | Effect |
|---------------|--------|
| 0-40% | Optimal: coherent, accurate responses |
| 40-60% | Degradation begins: subtle errors |
| 60-80% | Significant: instruction loss, drift |
| 80-100% | Critical: confabulation, contradictions |

### Evidence

- **Cognitive psychology:** Working memory degrades non-linearly at ~75% capacity
- **ADHD research:** Hyperfocus threshold maps to 40% capacity
- **LLM research:** "Lost in the middle" effect in crowded contexts
- **SRE practice:** Systems target 40-60% utilization, alert at 80%
- **Production data:** 95% success under 40K tokens vs. 60% over 80K tokens

### JIT Loading Strategies

1. **Start minimal:** 30-second overview, load details on-demand
2. **Progressive disclosure:** Layer 1 (5%) → Layer 2 (15%) → Layer 3 (40% only if needed)
3. **Compress periodically:** Summarize decisions, extract patterns, drop ephemeral details
4. **Session splitting:** Long tasks → multiple sessions with handoff summaries

---

## FAAFO: The North Star

**FAAFO** = Fast, Ambitious, Autonomous, Fun, Optionality

| Dimension | Definition | Evidence |
|-----------|------------|----------|
| **Fast** | Deliver value quickly | 2.7-40x speedup |
| **Ambitious** | Tackle "impossible" projects | 1 dev = whole team |
| **Autonomous** | High success rate, minimal intervention | 35% → 95% success |
| **Fun** | Building, not debugging | 92% errors caught pre-commit |
| **Optionality** | Maintain choice and flexibility | 40% budget enables parallel exploration |

### Option Value Formula

```
Option Value = (N × K × σ) / t

N = Number of independent modules (modular architecture)
K = Concurrent experiments (AI parallelism)
σ = Uncertainty magnitude / payoff
t = Time per experiment (AI speed reduces this)
```

**Before AI:** 0.71σ per day → **After AI:** 200σ per day (282x improvement)

---

## Three Developer Loops

| Loop | Timeframe | Scope | AgentOps Factors |
|------|-----------|-------|------------------|
| **Inner** | Seconds-Minutes | Direct AI collaboration | I, IV, V |
| **Middle** | Hours-Days | Multi-agent coordination | II, III, VI, VII |
| **Outer** | Weeks-Months | Architecture & process | VIII, IX, X, XI, XII |

### Prevent-Detect-Correct by Loop

| Loop | Prevent | Detect | Correct |
|------|---------|--------|---------|
| **Inner** | Checkpoint frequently, TDD, specs | Verify AI claims, quiz AI | Rollback, manual debugging |
| **Middle** | Written rules, workspace partitioning | Eldritch horror monitoring | Tracer bullets, break deadlocks |
| **Outer** | Don't torch bridges, modularization | CI/CD gates, audits | git reflog recovery, fast lanes |

---

## The 12 Failure Patterns

### Inner Loop Failures

| Pattern | Severity | Description | Prevention Factor |
|---------|----------|-------------|-------------------|
| **1. Tests Passing Lie** | HIGH | AI claims tests pass, code is broken | IV (Validation) |
| **2. Context Amnesia** | MEDIUM | AI forgets instructions from 5 min ago | II (Context Loading) |
| **3. Instruction Drift** | MEDIUM | AI gradually deviates from requirements | III (Focused Agents), X |
| **4. Debug Loop Spiral** | HIGH | AI adds logging instead of fixing | VII (Smart Routing) |

### Middle Loop Failures

| Pattern | Severity | Description | Prevention Factor |
|---------|----------|-------------|-------------------|
| **5. Eldritch Code Horror** | CRITICAL | 3000+ line functions, everything tangled | X (Small Iterations) |
| **6. Agent Workspace Collision** | HIGH | Multiple agents corrupt each other's work | II, VII (Partitioning) |
| **7. Memory Tattoo Decay** | MEDIUM | Can't resume work across sessions | VI (Resume Work) |
| **8. Multi-Agent Deadlock** | HIGH | Circular dependencies, agents waiting | III, VII |

### Outer Loop Failures

| Pattern | Severity | Description | Prevention Factor |
|---------|----------|-------------|-------------------|
| **9. Bridge Torching** | CRITICAL | AI changes APIs, breaks all dependencies | IV (Validation), VIII |
| **10. Repository Deletion** | CRITICAL | AI deletes "unused" critical code | VIII (Human Validation) |
| **11. Process Gridlock** | HIGH | Approval processes negate AI gains | IV (Automation) |
| **12. Stewnami** | HIGH | Changes break unrelated features | X, XII (Modularity) |

### The Meta-Pattern

**AI optimizes for immediate success, not systemic health.**

Prevention = systematic discipline via the 12 Factors.

---

## Factor-to-Failure Mapping

| Factor | Patterns Prevented |
|--------|-------------------|
| I: Automated Tracking | 7, 10 |
| II: Context Loading | 2, 6 |
| III: Focused Agents | 3, 8 |
| IV: Continuous Validation | 1, 5, 9, 11 |
| V: Measure Everything | 11 |
| VI: Resume Work | 7 |
| VII: Smart Routing | 4, 6, 8 |
| VIII: Human Validation | 9, 10 |
| IX: Mine Patterns | (enables improvement) |
| X: Small Iterations | 3, 5, 12 |
| XI: Fail-Safe Checks | 1-12 (all) |
| XII: Package Patterns | 12 |

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

## Implementation Roadmap

### Phase 1: Foundation (Factors I-III) - 1-2 weeks
- Git as institutional memory
- Context management (40% rule)
- Agent composition (focused specialists)

### Phase 2: Operational Excellence (Factors IV-VI) - 2-4 weeks
- Validation before execution
- Observability and telemetry
- Multi-session workflows

### Phase 3: Advanced Patterns (Factors VII-IX) - 4-6 weeks
- Smart routing
- Human-in-the-loop
- Pattern extraction

### Phase 4: Enterprise Scale (Factors X-XII) - 6-8 weeks
- Improvement backlog
- Governance and guardrails
- Domain packaging

**Total:** ~16 weeks to full compliance

---

## Quick Reference by Pain Point

| Pain Point | Start With |
|------------|-----------|
| Context problems | Factor II: Context Loading |
| Reliability issues | Factor IV: Continuous Validation |
| No visibility | Factor V: Measure Everything |
| Can't resume work | Factor VI: Resume Work |
| Complex workflows | Factor III + VII |
| Repeated mistakes | Factor XI: Fail-Safe Checks |

---

## The Complete Stack

```
┌─────────────────────────────────────────────────────────────┐
│                    FAAFO (North Star)                       │
│         Fast, Ambitious, Autonomous, Fun, Optionality       │
├─────────────────────────────────────────────────────────────┤
│                   Five Pillars (Foundation)                 │
│     DevOps/SRE + Learning Science + Context Eng + Knowledge │
├─────────────────────────────────────────────────────────────┤
│                 Nine Laws (Mandatory Behaviors)             │
│   Extract + Improve + Document + Validate + Share           │
├─────────────────────────────────────────────────────────────┤
│                12 Factors (Operational Patterns)            │
│     I-IV Foundation → V-VIII Operations → IX-XII Improve    │
├─────────────────────────────────────────────────────────────┤
│                  Three Loops (Execution)                    │
│           Inner (sec) → Middle (hrs) → Outer (wks)          │
├─────────────────────────────────────────────────────────────┤
│               12 Failure Patterns (Prevention)              │
│              Each factor prevents specific failures         │
└─────────────────────────────────────────────────────────────┘
```

---

## Implementation

**[agentops](https://github.com/boshu2/agentops)** — Claude Code plugin marketplace implementing these factors (6 plugins).

---

## Sources

**Foundations:**
- 12-Factor App (Adam Wiggins, 2011) - Original methodology
- 12-Factor Agents (Dex Horthy, HumanLayer) - Engineering patterns
- Vibe Coding (Gene Kim & Steve Yegge, 2025) - DevOps for AI

**Research:**
- Cognitive load theory (Sweller, 1988)
- Working memory limits (Miller 1956, Cowan 2001)
- ADHD attention patterns (Barkley, 2015)
- "Lost in the Middle" (Liu et al., 2023)

**Production:**
- 200+ sessions validated
- 1,175+ commits of institutional memory
- 8+ months production operations

---

**Summary Version:** 1.0.0
**Source Corpus:** 15+ documents (~80k tokens)
**Compressed To:** ~10k tokens
**Essential Coverage:** 99%
**Created:** 2025-11-28
