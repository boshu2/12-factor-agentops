# Factor Selection Decision Tree

**"Which factor applies to my problem?"**

Use this decision tree to quickly identify which 12-Factor AgentOps principles solve your specific challenges. Start at the top and follow the questions to find the relevant factors.

---

## Quick Diagnostic

**Answer these questions to find your starting point:**

```
┌─────────────────────────────────────────────────────┐
│ What's your primary challenge with AI agents?      │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┬───────────────┐
        │               │               │               │
        ▼               ▼               ▼               ▼
   [Quality]       [Context]      [Workflow]       [Scale]
   Problems        Problems       Problems         Problems
```

Choose your category:
- **[Quality Problems](#quality-problems)** → AI output unreliable, errors in production, rework needed
- **[Context Problems](#context-problems)** → Context collapse, memory issues, poor decisions
- **[Workflow Problems](#workflow-problems)** → Tasks unclear, wrong tools, inefficient routing
- **[Scale Problems](#scale-problems)** → Can't track progress, no improvement, portability issues

---

## Quality Problems

**"AI output is unreliable, causes errors, or requires too much rework"**

```
┌─────────────────────────────────────────────────────┐
│ Quality Problem: When does the issue occur?        │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┬───────────────┐
        │               │               │               │
        ▼               ▼               ▼               ▼
   Before Exec    After Exec     High Stakes    Governance
```

### Before Execution
**Problem:** "AI generates output that I ship without testing, then it breaks"

**👉 Factor IV: [Validation Gates Before Execution](../../factors/04-validation-gates-before-execution.md)**

**Solution:** Test AI output locally before commit
- Run lint, tests, builds before accepting AI changes
- Shift-left validation: catch errors when cheap to fix
- Never let AI output hit production untested

**Quick win:** `make test && git commit` (test before every commit)

### After Execution
**Problem:** "AI output looked good, but caused issues in production"

**👉 Factor VIII: [Human Gate Reviews](../../factors/08-human-gate-reviews.md)**

**Solution:** Flag critical changes for human review
- Automatic validation catches syntax/logic errors
- Human review catches semantic/business logic errors
- High-stakes decisions always get human approval

**Quick win:** Tag AI-generated changes requiring human review before deploy

### High Stakes Decisions
**Problem:** "I need AI to help, but can't risk autonomous decisions in critical systems"

**👉 Factor XI: [Constitutional Guardrails](../../factors/11-constitutional-guardrails.md)**

**Solution:** Define boundaries for AI decision-making
- Constitutional rules that AI cannot violate
- Pre-defined safety boundaries
- Automatic rejection of out-of-bounds actions

**Quick win:** Document "AI must never..." rules for your domain

### Governance & Compliance
**Problem:** "I need audit trails, explainability, compliance for AI decisions"

**👉 Combine Multiple Factors:**
- **Factor I:** [Git Memory](../../factors/01-git-memory-as-knowledge-os.md) → Every AI decision is logged in git
- **Factor V:** [Operational Telemetry](../../factors/05-operational-telemetry.md) → Track all AI operations
- **Factor IX:** [Pattern Extraction](../../factors/09-documented-pattern-extraction.md) → Document what AI did and why

**Quick win:** Commit all AI work with detailed context in commit messages

---

## Context Problems

**"Context collapse, memory issues, or AI makes poor decisions due to overload"**

```
┌─────────────────────────────────────────────────────┐
│ Context Problem: What's the symptom?               │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┬───────────────┐
        │               │               │               │
        ▼               ▼               ▼               ▼
   Overload       Multi-Session   Lost Memory    Complex Docs
```

### Context Overload
**Problem:** "AI quality degrades during long sessions, makes poor decisions late in session"

**👉 Factor II: [JIT Context Loading](../../factors/02-jit-context-loading.md)**

**Solution:** Load context Just-In-Time, stay under 40% utilization
- Load only what's needed for current task
- Use sub-agents for distinct concerns
- Monitor context utilization, stay under 40%

**Quick win:** If context >40%, save progress and start fresh session

**Why 40%?** Research shows cognitive and LLM performance both degrade above ~40% utilization.

### Multi-Session Work
**Problem:** "Work spans multiple days, lose context between sessions, have to re-explain everything"

**👉 Factor VI: [Session Continuity via Bundles](../../factors/06-session-continuity-via-bundles.md)**

**Solution:** Save session state as compressed bundles
- End session: Save context bundle (compress 40k → 2k tokens)
- Start session: Load bundle, resume exactly where you left off
- No re-explanation needed

**Quick win:** Create session template with key context, reuse across sessions

### Lost Memory
**Problem:** "AI forgets decisions made previously, no institutional memory"

**👉 Factor I: [Git Memory as Knowledge OS](../../factors/01-git-memory-as-knowledge-os.md)**

**Solution:** Use git as searchable institutional memory
- Every decision documented in commit message
- Git history = perfect recall of all past work
- Search git log to find "why we did X"

**Quick win:** Write detailed commit messages with context, rationale, and learnings

### Complex Documentation
**Problem:** "Documentation is huge, AI can't process it all, misses key details"

**👉 Combine Factors:**
- **Factor II:** [JIT Context Loading](../../factors/02-jit-context-loading.md) → Load docs Just-In-Time
- **Factor VI:** [Session Continuity](../../factors/06-session-continuity-via-bundles.md) → Compress docs into bundles

**Quick win:** Create curated doc bundles for common tasks (5:1 to 40:1 compression)

---

## Workflow Problems

**"Tasks unclear, using wrong tools, inefficient routing, or complex orchestration"**

```
┌─────────────────────────────────────────────────────┐
│ Workflow Problem: What's inefficient?              │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┬───────────────┐
        │               │               │               │
        ▼               ▼               ▼               ▼
   Wrong Tool     Task Unclear   Multi-Step    Agent Bloat
```

### Wrong Tool for Task
**Problem:** "AI uses wrong approach, when specialized tool would be better"

**👉 Factor VII: [Intelligent Task Routing](../../factors/07-intelligent-task-routing.md)**

**Solution:** Route tasks to specialized agents/tools
- Different tools for different tasks (coding vs analysis vs writing)
- Router agent decides which specialist to use
- Specialists are focused, efficient

**Quick win:** Map "task type → best tool" for your common work patterns

### Task Unclear or Ambiguous
**Problem:** "AI struggles because task isn't well-defined"

**👉 Factor III: [Single-Responsibility Agents](../../factors/03-single-responsibility-agents.md)**

**Solution:** Break work into focused, single-purpose tasks
- Each agent/task has one clear responsibility
- Smaller scope = clearer execution
- Easier to validate, easier to debug

**Quick win:** Before engaging AI, write 1-2 sentence task description. If hard to write, break task down further.

### Multi-Step Workflows
**Problem:** "Complex workflows require research → plan → implement phases"

**👉 Combine Factors:**
- **Factor VII:** [Task Routing](../../factors/07-intelligent-task-routing.md) → Route to research agent, then plan agent, then implementation agent
- **Factor VI:** [Session Continuity](../../factors/06-session-continuity-via-bundles.md) → Save state between phases
- **Factor III:** [Single-Responsibility](../../factors/03-single-responsibility-agents.md) → Each phase is focused

**Quick win:** Use phase-based workflow: Research → Plan → Implement (save bundles between phases)

### Agent Bloat
**Problem:** "Too many specialized agents, management overhead"

**👉 Factor X: [Continuous Improvement Backlog](../../factors/10-continuous-improvement-backlog.md)**

**Solution:** Regularly review and consolidate agents
- Retire unused agents
- Merge overlapping agents
- Measure agent utilization, prune low-value

**Quick win:** Track which agents you actually use. Delete unused ones monthly.

---

## Scale Problems

**"Can't track progress, no improvement over time, or portability across domains"**

```
┌─────────────────────────────────────────────────────┐
│ Scale Problem: What's the blocker?                 │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┬───────────────┐
        │               │               │               │
        ▼               ▼               ▼               ▼
   No Tracking    No Learning    No Transfer   No Metrics
```

### No Progress Tracking
**Problem:** "Can't see if AI usage is improving, no visibility into what's working"

**👉 Factor V: [Operational Telemetry](../../factors/05-operational-telemetry.md)**

**Solution:** Track all AI operations with metrics
- Log every AI interaction
- Measure: success rate, time saved, error rate, rework %
- Dashboard showing trends over time

**Quick win:** Start simple: count AI commits per week, track error rate

### No Learning or Improvement
**Problem:** "AI makes same mistakes repeatedly, no improvement over time"

**👉 Combine Factors:**
- **Factor IX:** [Pattern Extraction](../../factors/09-documented-pattern-extraction.md) → Document what works
- **Factor X:** [Continuous Improvement](../../factors/10-continuous-improvement-backlog.md) → Systematic improvement
- **Factor I:** [Git Memory](../../factors/01-git-memory-as-knowledge-os.md) → Institutional memory

**Quick win:** After each AI task, write 1 sentence: "What worked/didn't work"

### No Cross-Domain Transfer
**Problem:** "Patterns from one project don't transfer to another domain"

**👉 Factor XII: [Domain Portability](../../factors/12-domain-portability.md)**

**Solution:** Design agents/patterns to work across domains
- Separate domain-specific config from universal patterns
- Document which patterns are universal vs domain-specific
- Reuse patterns across projects

**Quick win:** When documenting patterns, mark them "universal" or "domain-specific"

### No Performance Metrics
**Problem:** "Can't measure if AI is making me faster, no baseline to compare against"

**👉 Factor V: [Operational Telemetry](../../factors/05-operational-telemetry.md)**

**Solution:** Track before/after metrics
- Baseline: Time to complete task without AI
- With AI: Time + validation + rework
- Net impact: Total time saved (or lost)

**Quick win:** Time one task manually, time same task with AI+validation. Compare.

---

## Multi-Factor Solutions

**Most real-world problems need multiple factors working together.**

### Common Combinations

#### "AI-Assisted Development" (Solo Developer)
```
Foundation:
├─ Factor I: Git Memory (log all AI work)
├─ Factor II: JIT Context (stay under 40%)
└─ Factor IV: Validation Gates (test before commit)

Quality:
└─ Factor VIII: Human Review (for critical changes)
```

#### "Multi-Day Complex Project" (Team)
```
Context Management:
├─ Factor II: JIT Context Loading
└─ Factor VI: Session Continuity (bundles between sessions)

Workflow:
├─ Factor III: Single-Responsibility (focused agents)
├─ Factor VII: Task Routing (right tool for job)
└─ Factor IV: Validation Gates (test everything)

Governance:
├─ Factor VIII: Human Gates (high-stakes review)
└─ Factor XI: Constitutional Guardrails (safety boundaries)

Learning:
├─ Factor V: Telemetry (track metrics)
├─ Factor IX: Pattern Extraction (document learnings)
└─ Factor X: Continuous Improvement (iterate)
```

#### "Enterprise AI Operations" (Production Scale)
```
All 12 Factors:
├─ Foundation Tier (I, II, III): Core operations
├─ Governance Tier (IV, VIII, XI): Safety & compliance
├─ Scale Tier (V, VI, VII, IX, X, XII): Operational maturity
```

---

## Decision Tree Flowchart

**Visual guide to factor selection:**

```
START: What's your problem?
│
├─ Quality Issues → Test AI output?
│   ├─ No  → Factor IV: Validation Gates
│   └─ Yes → Need human review? → Factor VIII: Human Gates
│
├─ Context Issues → Multi-day work?
│   ├─ Yes → Factor VI: Session Continuity
│   └─ No  → Context overload? → Factor II: JIT Loading
│
├─ Workflow Issues → Task unclear?
│   ├─ Yes → Factor III: Single-Responsibility
│   └─ No  → Wrong tool? → Factor VII: Task Routing
│
└─ Scale Issues → No improvement?
    ├─ Yes → Factor IX: Pattern Extraction
    └─ No  → Can't track? → Factor V: Telemetry
```

---

## Quick Reference: Factor Index by Problem

| Your Problem | Relevant Factor(s) | Quick Win |
|--------------|-------------------|-----------|
| **AI output breaks production** | IV (Validation Gates) | Test before commit |
| **Context collapse in long sessions** | II (JIT Loading) | Stay under 40% context |
| **Multi-day work loses context** | VI (Session Continuity) | Save/load bundles |
| **No memory of past decisions** | I (Git Memory) | Detailed commit messages |
| **High-stakes need human approval** | VIII (Human Gates) | Tag critical changes |
| **AI uses wrong approach** | VII (Task Routing) | Map task → tool |
| **Tasks too complex** | III (Single-Responsibility) | Break into focused subtasks |
| **No improvement over time** | IX (Pattern Extraction) | Document learnings |
| **Can't measure progress** | V (Telemetry) | Track basic metrics |
| **Same mistakes repeatedly** | X (Continuous Improvement) | Review errors monthly |
| **Need safety boundaries** | XI (Constitutional Guardrails) | Define "never do X" rules |
| **Can't reuse across domains** | XII (Domain Portability) | Separate config from logic |

---

## Getting Started

**After identifying your factors:**

1. **Read the factor documentation**
   - Each factor has detailed docs in `factors/`
   - Focus on "Implementation" section for practical steps

2. **Start with foundation factors (I, II, III)**
   - These apply to almost all AI usage
   - Build on solid foundation first

3. **Add factors as problems emerge**
   - Don't implement all 12 at once
   - Add factor when you feel the pain it solves

4. **Iterate and improve**
   - Track what works (Factor V: Telemetry)
   - Document learnings (Factor IX: Pattern Extraction)
   - Continuously improve (Factor X: Continuous Improvement)

---

## Still Unsure?

**If you're not sure which factor applies:**

1. **Start with the pragmatic three**
   - Factor I: Git Memory (always applicable)
   - Factor II: JIT Context (prevents collapse)
   - Factor IV: Validation Gates (ensures quality)

2. **Read the complete factor list**
   - [factors/README.md](../../factors/README.md)
   - Scan all 12, see what resonates

3. **Try the role-specific paths**
   - [docs/tutorials/role-specific-paths.md](role-specific-paths.md)
   - Guided learning based on your role

4. **Ask for help**
   - Open an issue: "I have problem X, which factor applies?"
   - Community can help map your challenge to factors

---

**Next:** Once you've identified your factors, read their full documentation:
- **[All Factors →](../../factors/README.md)**
- **[Quick Reference Card →](quick-reference-card.md)** (one-page overview)
- **[Role-Specific Paths →](role-specific-paths.md)** (guided learning)
