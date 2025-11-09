# Framework Architecture

**How the 4 Pillars, 5 Laws, and 12 Factors work together**

---

## The Hierarchy

```
┌─────────────────────────────────────────────────────────┐
│  FOUR PILLARS (Philosophical Foundation - WHY)          │
│  ├─ DevOps + SRE                                        │
│  ├─ Learning Science                                    │
│  ├─ Context Engineering                                 │
│  └─ Knowledge OS                                        │
└─────────────────────────────────────────────────────────┘
                        ↓ inform
┌─────────────────────────────────────────────────────────┐
│  FIVE LAWS (Mandatory Governance - MUST)                │
│  ├─ ALWAYS Extract Learnings                            │
│  ├─ ALWAYS Improve Self or System                       │
│  ├─ ALWAYS Document Context for Future                  │
│  ├─ ALWAYS Validate Before Execute                      │
│  └─ ALWAYS Share Patterns Publicly                      │
└─────────────────────────────────────────────────────────┘
                        ↓ constrain
┌─────────────────────────────────────────────────────────┐
│  TWELVE FACTORS (Operational Principles - HOW)          │
│  ├─ I.   Git Memory as Knowledge OS                     │
│  ├─ II.  JIT Context Loading                            │
│  ├─ III. Single-Responsibility Agents                   │
│  ├─ IV.  Validation Gates Before Execution              │
│  ├─ V.   Operational Telemetry                          │
│  ├─ VI.  Session Continuity via Bundles                 │
│  ├─ VII. Intelligent Task Routing                       │
│  ├─ VIII. Human Gate Reviews                            │
│  ├─ IX.  Documented Pattern Extraction                  │
│  ├─ X.   Continuous Improvement Backlog                 │
│  ├─ XI.  Constitutional Guardrails                      │
│  └─ XII. Domain Portability                             │
└─────────────────────────────────────────────────────────┘
                        ↓ implement via
┌─────────────────────────────────────────────────────────┐
│  PATTERNS (Tactical Implementation - WHAT)              │
│  ├─ Phase-Based Workflow                                │
│  ├─ Multi-Agent Orchestration                           │
│  ├─ Context Bundles                                     │
│  ├─ Intelligent Routing                                 │
│  └─ Operators Model                                     │
└─────────────────────────────────────────────────────────┘
```

---

## How Each Factor Derives from Pillars

### Factor I: Git Memory as Knowledge OS

**Primary Pillar:** Knowledge OS
**Supporting Pillars:** DevOps + SRE

**Derivation:**
- **Knowledge OS** says: Git is institutional memory, commits are memory writes
- **DevOps + SRE** says: Version control is source of truth, audit trails are mandatory
- **Therefore:** Every agent workflow must use Git as single canonical history

**Enforces Laws:**
- Law 3: Document Context (commits capture context)
- Law 1: Extract Learnings (commits include Learning section)

---

### Factor II: JIT Context Loading

**Primary Pillar:** Context Engineering
**Supporting Pillars:** Learning Science

**Derivation:**
- **Context Engineering** says: Manage cognitive load through JIT loading and isolation
- **Learning Science** says: Progressive complexity through sub-agent delegation
- **Research:** Sub-agent architecture with isolated contexts prevents bloat
- **Therefore:** Main agent orchestrates (10-20% context), sub-agents execute with JIT loading

**Enforces Laws:**
- Law 2: Improve System (sub-agent delegation improves efficiency 3.75x)
- Law 4: Validate Before Execute (clean context = clear decision-making)

---

### Factor III: Single-Responsibility Agents

**Primary Pillar:** Learning Science
**Supporting Pillars:** DevOps + SRE

**Derivation:**
- **Learning Science** says: Progressive disclosure, focused learning
- **DevOps + SRE** says: Microservices pattern, single responsibility principle
- **Therefore:** Each agent does one thing well, compose for complexity

**Enforces Laws:**
- Law 5: Share Patterns (reusable agents = shareable patterns)
- Law 2: Improve System (composable = maintainable)

---

### Factor IV: Validation Gates Before Execution

**Primary Pillar:** DevOps + SRE
**Supporting Pillars:** Learning Science

**Derivation:**
- **DevOps + SRE** says: Test before deploy, validation gates are mandatory
- **Learning Science** says: Research → Plan → Implement (not code-first)
- **Therefore:** Formal checkpoints before applying changes

**Enforces Laws:**
- Law 4: Validate Before Execute (explicitly enforces this law)
- Law 3: Document Context (validation requires documented plans)

---

### Factor V: Operational Telemetry

**Primary Pillar:** DevOps + SRE
**Supporting Pillars:** Knowledge OS

**Derivation:**
- **DevOps + SRE** says: Observability for all systems, metrics-driven decisions
- **Knowledge OS** says: Capture everything for future learning
- **Therefore:** Metrics, logs, and observability for every agent run

**Enforces Laws:**
- Law 2: Improve System (metrics enable improvement)
- Law 1: Extract Learnings (telemetry reveals patterns)

---

### Factor VI: Session Continuity via Bundles

**Primary Pillar:** Context Engineering
**Supporting Pillars:** Knowledge OS

**Derivation:**
- **Context Engineering** says: Context preservation via bundles
- **Knowledge OS** says: Persistent state enables multi-day workflows
- **Research:** 5:1 compression enables continuity without context bloat
- **Therefore:** Persist and restore context using compressed artifacts

**Enforces Laws:**
- Law 3: Document Context (bundles preserve context across sessions)
- Law 2: Improve System (continuity enables complex work)

---

### Factor VII: Intelligent Task Routing

**Primary Pillar:** Learning Science
**Supporting Pillars:** DevOps + SRE

**Derivation:**
- **Learning Science** says: Pattern recognition, match task to capability
- **DevOps + SRE** says: Route requests to appropriate service
- **Validation:** 90.9% routing accuracy in production
- **Therefore:** Route work to best-fit workflows/agents

**Enforces Laws:**
- Law 2: Improve System (better routing = better outcomes)
- Law 1: Extract Learnings (routing accuracy improves from patterns)

---

### Factor VIII: Human Gate Reviews

**Primary Pillar:** Learning Science
**Supporting Pillars:** DevOps + SRE

**Derivation:**
- **Learning Science** says: Research → Plan → Implement (human validates transitions)
- **DevOps + SRE** says: Human approval for critical changes
- **Therefore:** Embed human approvals between workflow phases

**Enforces Laws:**
- Law 4: Validate Before Execute (human is ultimate validator)
- Law 3: Document Context (humans need context to approve)

---

### Factor IX: Documented Pattern Extraction

**Primary Pillar:** Knowledge OS
**Supporting Pillars:** Learning Science

**Derivation:**
- **Knowledge OS** says: Patterns compound over time
- **Learning Science** says: Pattern recognition and reuse
- **Therefore:** Capture learnings after every session, publish patterns

**Enforces Laws:**
- Law 1: Extract Learnings (explicitly enforces this law)
- Law 5: Share Patterns Publicly (explicitly enforces this law)

---

### Factor X: Continuous Improvement Backlog

**Primary Pillar:** DevOps + SRE
**Supporting Pillars:** Learning Science

**Derivation:**
- **DevOps + SRE** says: Continuous improvement is mandatory
- **Learning Science** says: Failure analysis and improvement
- **Therefore:** Each session identifies improvements, prioritize and action

**Enforces Laws:**
- Law 2: Improve Self or System (explicitly enforces this law)
- Law 3: Document Context (improvements require documented rationale)

---

### Factor XI: Constitutional Guardrails

**Primary Pillar:** DevOps + SRE
**Supporting Pillars:** All pillars

**Derivation:**
- **DevOps + SRE** says: Enforce policies automatically
- **All Pillars** contribute requirements
- **Therefore:** Enforce Five Laws, 40% rule, and prevent risky behaviors

**Enforces Laws:**
- ALL FIVE LAWS (this factor IS the enforcement mechanism)

---

### Factor XII: Domain Portability

**Primary Pillar:** Knowledge OS
**Supporting Pillars:** DevOps + SRE

**Derivation:**
- **Knowledge OS** says: Patterns are portable and reusable
- **DevOps + SRE** says: Package and distribute capabilities
- **Therefore:** Package domain knowledge into reusable profiles

**Enforces Laws:**
- Law 5: Share Patterns Publicly (profiles are shared patterns)
- Law 1: Extract Learnings (profiles capture domain learnings)

---

## The Derivation Matrix

| Factor | Primary Pillar | Supporting Pillar(s) | Laws Enforced |
|--------|---------------|---------------------|---------------|
| I. Git Memory | Knowledge OS | DevOps + SRE | Law 1, Law 3 |
| II. JIT Context Loading | Context Engineering | Learning Science | Law 2, Law 4 |
| III. Single-Responsibility | Learning Science | DevOps + SRE | Law 2, Law 5 |
| IV. Validation Gates | DevOps + SRE | Learning Science | Law 3, Law 4 |
| V. Telemetry | DevOps + SRE | Knowledge OS | Law 1, Law 2 |
| VI. Context Bundles | Context Engineering | Knowledge OS | Law 2, Law 3 |
| VII. Intelligent Routing | Learning Science | DevOps + SRE | Law 1, Law 2 |
| VIII. Human Gates | Learning Science | DevOps + SRE | Law 3, Law 4 |
| IX. Pattern Extraction | Knowledge OS | Learning Science | Law 1, Law 5 |
| X. Improvement Backlog | DevOps + SRE | Learning Science | Law 2, Law 3 |
| XI. Constitutional Guardrails | DevOps + SRE | All | ALL LAWS |
| XII. Domain Portability | Knowledge OS | DevOps + SRE | Law 1, Law 5 |

---

## Validation: Coverage Analysis

### Pillar Coverage

**Each pillar informs multiple factors:**
- **DevOps + SRE**: Factors I, IV, V, VII, VIII, X, XI, XII (8 factors)
- **Learning Science**: Factors II, III, VII, VIII, IX, X (6 factors)
- **Context Engineering**: Factors II, VI (2 factors)
- **Knowledge OS**: Factors I, V, VI, IX, XII (5 factors)

**Result:** All pillars represented, DevOps + SRE is dominant (as expected for operations)

### Law Coverage

**Each law is enforced by multiple factors:**
- **Law 1 (Extract Learnings)**: Factors I, V, VII, IX, XII (5 factors)
- **Law 2 (Improve System)**: Factors II, III, V, VI, VII, X, XI (7 factors)
- **Law 3 (Document Context)**: Factors I, IV, VI, VIII, X, XI (6 factors)
- **Law 4 (Validate Before Execute)**: Factors II, IV, VIII, XI (4 factors)
- **Law 5 (Share Patterns)**: Factors III, IX, XII (3 factors)

**Result:** All laws enforced, Law 2 (Improvement) most widespread (as intended)

---

## Why This Matters

### 1. The Factors Aren't Arbitrary

Every factor derives from philosophical foundations (pillars) and operational requirements (laws). This isn't a random list—it's a coherent system.

### 2. Completeness Check

If a pillar isn't represented → we're missing operational principles
If a law isn't enforced → we have governance gaps
**Current status:** Full coverage, no gaps

### 3. Coherence Check

Factors that derive from the same pillar should complement each other:
- Factors I, VI, IX, XII (Knowledge OS) → build institutional memory
- Factors II, VI (Context Engineering) → manage cognitive load
- Factors III, VII, VIII (Learning Science) → structure learning
- Factors IV, V, X, XI (DevOps + SRE) → ensure reliability

**Result:** Factors compose into coherent operational practices

### 4. Traceability

For any operational decision, you can trace:
```
Decision → Factor → Pillar → Research/Theory
```

**Example:**
```
"Why sub-agent delegation?"
  → Factor II (JIT Context Loading)
  → Context Engineering Pillar
  → Isolation prevents context pollution
  → Empirical validation (98% success rate, 3.75x speedup)
```

This gives the framework **intellectual credibility**.

---

## For Practitioners

**When implementing a factor, understand:**
1. **Which pillar** it comes from (the WHY)
2. **Which laws** it enforces (the MUST)
3. **How it connects** to other factors (the SYSTEM)

**Example: Implementing Factor VI (Context Bundles)**
- **Pillar:** Context Engineering (manage load) + Knowledge OS (preserve state)
- **Laws:** Law 2 (enables complex work) + Law 3 (preserves context)
- **Connections:** Works with Factor II (40% rule) and Factor IX (pattern extraction)

**Result:** You're not just following a rule, you're implementing a philosophy.

---

## For Researchers

**To propose a new factor:**
1. Identify which pillar(s) it derives from
2. Show which law(s) it enforces
3. Demonstrate how it complements existing factors
4. Provide empirical validation

**Example template:**
```markdown
## Proposed Factor XIII: [Name]

**Primary Pillar:** [Which pillar provides the WHY?]
**Supporting Pillars:** [Any others?]

**Derivation:**
- Pillar X says: [Philosophical foundation]
- Pillar Y says: [Supporting foundation]
- Therefore: [Operational principle]

**Enforces Laws:** [Which laws, and how?]
**Complements Factors:** [Which factors, and how?]
**Validation:** [Evidence this works]
```

---

## For Framework Builders

**The factors are the WHAT, not the HOW.**

You implement the factors using your platform's capabilities:
- Factor I (Git Memory) → Your VCS + commit hooks
- Factor II (JIT Context Loading) → Your sub-agent orchestration + context isolation
- Factor III (Single-Responsibility) → Your agent composition system

**But the derivation from pillars ensures:**
- You understand WHY each factor exists
- You can adapt the HOW to your platform
- You maintain philosophical coherence

---

## Version History

- **v1.0.0** (2025-11-08): Initial architecture documentation
- Traces all 12 factors to pillars and laws
- Validates full coverage of philosophy and governance

---

**Remember: The factors aren't a checklist. They're the operational expression of a philosophical foundation. Understand the pillars, enforce the laws, and the factors follow naturally.**
