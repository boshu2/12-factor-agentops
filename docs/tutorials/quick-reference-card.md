# 12-Factor AgentOps Quick Reference Card

**One-page overview of all 12 factors for reliable AI agent operations**

Print this page, keep it handy while working with AI agents. Each factor solves a specific problem and enforces operational discipline.

---

## The 12 Factors at a Glance

| # | Factor | One-Line Summary | When to Apply |
|---|--------|------------------|---------------|
| **I** | **Git Memory as Knowledge OS** | Treat git as institutional memory for all AI work | Every AI interaction |
| **II** | **JIT Context Loading** | Load context Just-In-Time, stay under 40% utilization | Long sessions, complex work |
| **III** | **Single-Responsibility Agents** | Each agent does one thing well | Designing workflows |
| **IV** | **Validation Gates Before Execution** | Test AI output locally before shipping | Every commit |
| **V** | **Operational Telemetry** | Track all AI operations with metrics | Measuring improvement |
| **VI** | **Session Continuity via Bundles** | Save/load session state across days | Multi-day projects |
| **VII** | **Intelligent Task Routing** | Route tasks to specialized agents | Complex workflows |
| **VIII** | **Human Gate Reviews** | Flag critical changes for human approval | High-stakes decisions |
| **IX** | **Documented Pattern Extraction** | Document learnings for reuse | After every task |
| **X** | **Continuous Improvement Backlog** | Systematic improvement over time | Monthly reviews |
| **XI** | **Constitutional Guardrails** | Define boundaries AI cannot cross | Safety-critical systems |
| **XII** | **Domain Portability** | Patterns work across domains | Scaling to new areas |

---

## Foundation Tier (Start Here)

**Apply these three factors to every AI interaction:**

### I. Git Memory as Knowledge OS
```bash
# Every AI commit includes context
git commit -m "feat(auth): Add JWT validation

Context: Users bypassing auth with malformed tokens
Solution: Added signature validation in middleware
AI-Assisted: Claude Code generated validation logic
Learning: Always validate JWT signatures, not just decode"
```

**Quick win:** Write detailed commit messages with why/what/how

### II. JIT Context Loading
```
Context Window: 200k tokens
Target: <40% (80k tokens) per phase
Strategy: Load only what's needed right now

❌ Don't: Load all docs at start (→ context collapse)
✅ Do:    Load docs Just-In-Time as needed
```

**Quick win:** Monitor context %, save progress if approaching 40%

### III. Single-Responsibility Agents
```
❌ Monolithic agent: "Build entire authentication system"
   → Too broad, unclear expectations, hard to validate

✅ Focused agents:
   1. "Design JWT validation interface"
   2. "Implement JWT signature verification"
   3. "Add JWT validation tests"
   4. "Integrate JWT validation in middleware"

   → Clear scope, easy to validate, composable
```

**Quick win:** If task description >2 sentences, break it down

---

## Governance Tier (Quality & Safety)

**Apply these factors to ensure quality and manage risk:**

### IV. Validation Gates Before Execution
```bash
# ALWAYS test before commit
make test && make lint && git commit

# Shift-left: catch errors locally, not in production
```

**Quick win:** Never commit AI code without running tests first

### VIII. Human Gate Reviews
```yaml
# Flag high-stakes AI changes
- Auto-approve: tests, docs, minor refactors
- Human review: auth changes, data migrations, public APIs
- Human required: production configs, security, compliance
```

**Quick win:** Tag critical AI changes with `[REVIEW REQUIRED]`

### XI. Constitutional Guardrails
```yaml
# Define AI boundaries
Never:
  - Modify production database without backup
  - Bypass authentication or authorization
  - Commit secrets or credentials
  - Delete data without confirmation

Always:
  - Run tests before commit
  - Validate inputs
  - Log significant operations
  - Require approval for high-risk changes
```

**Quick win:** Document "AI must never..." rules for your domain

---

## Scale Tier (Operational Maturity)

**Apply these factors as complexity increases:**

### V. Operational Telemetry
```yaml
# Track AI operations
Metrics:
  - AI commits per week: 12 (↑ from 8 last week)
  - Success rate: 95% (tests pass on first try)
  - Time saved: 4.5 hours per week
  - Error rate: 5% (errors caught by validation)
  - Rework rate: 2% (needed manual fixes)
```

**Quick win:** Count AI commits weekly, track test pass rate

### VI. Session Continuity via Bundles
```bash
# End of Day 1
/bundle-save redis-caching-plan
# Saves: Plan (40k tokens) → Bundle (2k tokens)

# Start of Day 2
/bundle-load redis-caching-plan
# Loads: Bundle (2k tokens) → Resume exactly where left off
```

**Quick win:** Save session state before ending long work sessions

### VII. Intelligent Task Routing
```yaml
# Route tasks to specialized agents
Task Type          → Agent/Tool
─────────────────────────────────
Code generation    → Claude Code (coding specialist)
Data analysis      → Python + analysis libraries
Documentation      → Writing specialist
Architecture       → Planning agent
Testing            → Test generation agent
```

**Quick win:** Map your common tasks to best tools

### IX. Documented Pattern Extraction
```markdown
# After completing task, document learnings
## Pattern: JWT Validation in Go
**Context:** Adding JWT auth to API
**Solution:** Use golang-jwt/jwt library
**Learning:** Always validate signature + expiry + issuer
**Impact:** 0 auth bypass incidents (was 3/month)
**Reusable:** Yes, apply to all Go APIs
```

**Quick win:** After each AI task, write 2-3 sentence summary of what worked

### X. Continuous Improvement Backlog
```yaml
# Monthly improvement review
Last Month:
  - AI success rate: 92% → 95% (↑3%)
  - Time saved: 3h/week → 4.5h/week (↑50%)

Improvements Made:
  - Added validation gate (Factor IV) → Reduced errors 40%
  - Created test bundle (Factor VI) → Saved 1h/week on context

Next Month Focus:
  - Implement telemetry dashboard (Factor V)
  - Extract reusable patterns (Factor IX)
```

**Quick win:** Review AI metrics monthly, identify 1 improvement

### XII. Domain Portability
```yaml
# Separate universal patterns from domain-specific
Universal (reusable everywhere):
  - Validation gates before commit
  - JIT context loading (40% rule)
  - Detailed commit messages

Domain-Specific (Go web APIs):
  - JWT library choice (golang-jwt)
  - Middleware patterns (Go idioms)
  - Test framework (testing + testify)
```

**Quick win:** Tag patterns as "universal" or "domain-specific"

---

## Common Problem → Factor Mapping

| Problem | Factor | Action |
|---------|--------|--------|
| **AI breaks production** | IV | Test before commit |
| **Context collapse** | II | Stay under 40% |
| **Lost between sessions** | VI | Save/load bundles |
| **No institutional memory** | I | Detailed git commits |
| **High-stakes need approval** | VIII | Human gate review |
| **Wrong tool for job** | VII | Task routing |
| **Task too complex** | III | Single-responsibility |
| **No improvement** | IX, X | Pattern extraction + backlog |
| **Can't measure progress** | V | Telemetry |
| **Safety boundaries needed** | XI | Constitutional guardrails |
| **Can't reuse patterns** | XII | Domain portability |

---

## The Pragmatic Three (Minimum Viable Adoption)

**Start with these three factors for immediate value:**

```
1️⃣ Factor I: Git Memory
   → Commit all AI work with detailed messages

2️⃣ Factor II: JIT Context Loading
   → Stay under 40% context utilization

3️⃣ Factor IV: Validation Gates
   → Test before commit, shift-left validation
```

**Apply in 5 minutes:**
```bash
# 1. Detailed commit messages (Factor I)
git commit -m "feat: add feature

Context: Why this was needed
Solution: What was done
AI-Assisted: Tool used"

# 2. Monitor context (Factor II)
# If context >40% → save progress, start fresh

# 3. Always test first (Factor IV)
make test && git commit
```

---

## The Complete Workflow

**Applying all 12 factors in practice:**

```
┌─ Phase 1: Setup ─────────────────────────────────────┐
│ • Define constitutional guardrails (XI)              │
│ • Set up telemetry (V)                               │
│ • Configure validation gates (IV)                    │
└──────────────────────────────────────────────────────┘

┌─ Phase 2: Execution ─────────────────────────────────┐
│ • Load context JIT (II) - stay under 40%             │
│ • Route task to right agent (VII)                    │
│ • Use single-responsibility agents (III)             │
│ • Flag high-stakes for human review (VIII)           │
└──────────────────────────────────────────────────────┘

┌─ Phase 3: Validation ────────────────────────────────┐
│ • Run validation gates (IV) - test before commit     │
│ • Human review if flagged (VIII)                     │
│ • Commit with context (I) - detailed message         │
└──────────────────────────────────────────────────────┘

┌─ Phase 4: Learning ──────────────────────────────────┐
│ • Extract patterns (IX) - document learnings         │
│ • Update telemetry (V) - track metrics               │
│ • Review improvements (X) - what to improve          │
│ • Tag portability (XII) - universal vs domain        │
└──────────────────────────────────────────────────────┘

┌─ Phase 5: Continuity ────────────────────────────────┐
│ • Save session bundle (VI) if multi-day work         │
│ • Next session: Load bundle, resume                  │
└──────────────────────────────────────────────────────┘
```

---

## Factor Relationships

**How factors work together:**

```
Foundation Layer (Always Active):
├─ I:   Git Memory (logs everything)
├─ II:  JIT Context (prevents overload)
└─ III: Single-Responsibility (focused scope)

Quality Layer (Before Shipping):
├─ IV:  Validation Gates (test first)
├─ VIII: Human Gates (review critical)
└─ XI:  Constitutional Guardrails (safety boundaries)

Operations Layer (Ongoing):
├─ V:   Telemetry (measure everything)
├─ VII: Task Routing (right tool/agent)
└─ XII: Domain Portability (reuse patterns)

Learning Layer (After Completion):
├─ IX:  Pattern Extraction (document learnings)
└─ X:   Continuous Improvement (iterate)

Continuity Layer (Multi-Session):
└─ VI:  Session Bundles (save/load state)
```

---

## Cheat Sheet: Daily Workflow

**Copy this checklist for daily AI work:**

```
☐ Start session:
  ☐ Load bundle if continuing work (VI)
  ☐ Check context % (II) - target <40%
  ☐ Review constitutional rules (XI)

☐ During work:
  ☐ Use focused agents (III) - one job each
  ☐ Route to right tool (VII) - specialized agents
  ☐ Monitor context (II) - stay under 40%
  ☐ Flag critical changes (VIII) - human review

☐ Before commit:
  ☐ Run tests (IV) - validation gates
  ☐ Human review if flagged (VIII)
  ☐ Detailed commit message (I) - context/solution/learning

☐ After commit:
  ☐ Extract patterns (IX) - what worked?
  ☐ Update metrics (V) - track progress
  ☐ Note improvements (X) - what to improve

☐ End session:
  ☐ Save bundle if continuing (VI) - multi-day work
  ☐ Tag patterns (XII) - universal vs domain
```

---

## Five Laws (Enforced by All Factors)

**Every factor enforces one or more of these laws:**

1. **ALWAYS Extract Learnings** → Factors I, IX, X, XII
2. **ALWAYS Improve Self or System** → Factors III, V, VII, X
3. **ALWAYS Document Context** → Factors I, VIII, IX, X
4. **ALWAYS Validate Before Execute** → Factors IV, VIII, XI
5. **ALWAYS Share Patterns Publicly** → Factors IX, XII

---

## Performance Targets

**What good looks like:**

| Metric | Target | Measured By |
|--------|--------|-------------|
| **Success Rate** | >90% | Tests pass on first try (Factor V) |
| **Context Utilization** | <40% | Context % per phase (Factor II) |
| **Error Rate** | <10% | Errors caught by validation (Factor IV) |
| **Rework Rate** | <5% | Changes after commit (Factor V) |
| **Time Saved** | >30% | Baseline vs AI-assisted (Factor V) |
| **Pattern Reuse** | >50% | Patterns reused vs one-off (Factor XII) |
| **Improvement Rate** | >5%/month | Month-over-month efficiency (Factor X) |

---

## Get Help

**Resources:**

- **Full Documentation:** [factors/README.md](../../factors/README.md)
- **Decision Tree:** [docs/tutorials/decision-tree.md](decision-tree.md) - Which factor for which problem?
- **Role-Specific Paths:** [docs/tutorials/role-specific-paths.md](role-specific-paths.md) - Guided learning
- **30-Minute Tutorial:** [docs/tutorials/first-30-minutes.md](first-30-minutes.md) - Quick start

**Questions?**
- Open issue: "How do I apply Factor X to Y?"
- See [CONTRIBUTING.md](../../CONTRIBUTING.md) for community

---

## Print-Friendly Summary

**The Essential Three (Start Here):**
- ✅ **Factor I:** Commit AI work with detailed context
- ✅ **Factor II:** Stay under 40% context utilization
- ✅ **Factor IV:** Test before every commit

**Add When Needed:**
- **Multi-day work?** → Factor VI (Session Continuity)
- **Complex workflow?** → Factor VII (Task Routing)
- **High stakes?** → Factor VIII (Human Gates) + XI (Guardrails)
- **Want improvement?** → Factor V (Telemetry) + IX (Patterns) + X (Backlog)

**Universal Principle:**
> Stop asking "Can I trust this AI?"
> Start asking "Does this pass validation?"

---

**Next Steps:**
1. Apply the pragmatic three (I, II, IV) to your next AI task
2. Read full factor docs for deeper understanding
3. Add factors as your needs grow

**Version:** v1.0.4 • **Last Updated:** 2025-11-09
