# The Three Developer Loops

**Gene Kim's framework for understanding AI-assisted development across timescales.**

---

## Overview

In [Vibe Coding](https://www.youtube.com/watch?v=vibe-coding), Gene Kim introduces the **Three Developer Loops** framework—a way to think about AI-assisted development across different timescales, each with distinct concerns, strategies, and failure modes.

**The Loops:**
1. **Inner Loop** (seconds to minutes) - Direct AI collaboration, immediate coding
2. **Middle Loop** (hours to days) - Multi-agent coordination, extended sessions
3. **Outer Loop** (weeks to months) - Architecture, processes, organizational change

Each loop has its own Prevention, Detection, and Correction strategies.

**Why this matters:** Different loops require different operational patterns. What works for quick coding (Inner) doesn't work for multi-agent orchestration (Middle) or organizational transformation (Outer).

---

## Inner Loop: Seconds to Minutes

### Definition

**Direct AI collaboration in immediate coding flow.**

This is the tight feedback loop of:
- Writing a function
- Running a test
- Fixing a bug
- Refactoring a class
- Verifying a change

**Timescale:** Seconds to minutes per iteration

**Key characteristic:** Human and AI in tight collaboration, rapid iteration

---

### Vibe Coding Strategies

#### Prevention

**Checkpoint frequently**
- Git commit every few minutes
- Small, reversible changes
- Easy to rollback if AI goes wrong

**AI-written specs and tests**
- Don't just ask for code, ask for tests
- Spec first, implementation second
- Verifiable artifacts

**Git mastery**
- Know how to revert, reset, cherry-pick
- Use branches liberally
- Never fear undoing AI changes

#### Detection

**TDD (Test-Driven Development)**
- Write test first (make it fail)
- Let AI implement (make it pass)
- Verify manually

**Verify AI claims yourself**
- AI says "tests pass" → Run them yourself
- AI says "refactored" → Diff the changes
- Never trust, always verify

**Always on watch**
- Review every line AI writes
- Question plausibility
- Spot check critical paths

#### Correction

**Fix-forward or rollback**
- If AI breaks something: git revert immediately
- Don't try to fix broken AI code by asking AI to fix it
- Start over from known-good state

**AI as rubber duck debugger**
- Explain the problem to AI
- Get ideas for root cause
- But you use the debugger, not AI

---

### AgentOps Implementation

#### Factor II: Track Everything in Git

**Maps to Inner Loop Prevention:**
- Every change tracked, every decision persisted
- Pre-commit hooks prevent broken code from entering repo
- Easy rollback when AI goes wrong

**Example:**
```bash
# Every change is tracked:
git commit -m "Add validation logic"
# AI can't silently break things
```

#### Factor V: Validate Externally

**Maps to Inner Loop Detection:**
- Independent verification of AI output
- Write test before implementation
- Forces AI to produce verifiable code

**Example:**
```python
# You write:
def test_calculate_total():
    assert calculate_total([1, 2, 3]) == 6

# AI implements:
def calculate_total(items):
    return sum(items)

# You verify: Test actually passes
```

#### Factor VI: Lock Progress Forward

**Maps to Inner Loop Correction:**
- Checkpoint frequently so you can roll back
- Independent verification (don't trust AI)
- Rollback immediately on failure, resume from last good state

**Example:**
```bash
# AI claims "tests pass"
# You run:
pytest tests/
# Sees failures → git revert to checkpoint
```

---

### Common Inner Loop Failures

#### Failure 1: "Tests Are Passing" Lie

**Symptom:** AI claims all tests green, but code doesn't compile

**Root cause:** AI hallucinates test results without running them

**Violated factor:** Factor V (Validate Externally)

**Remedy:**
- Always run tests independently
- Never trust AI test claims without verification
- Use Factor II (Track Everything in Git) to log actual test runs

#### Failure 2: Context Amnesia

**Symptom:** AI forgets instructions from 5 minutes ago

**Root cause:** Context window exceeds 40% threshold, performance degrades

**Violated factor:** Factor I (Context Is Everything)

**Remedy:**
- Monitor context utilization actively
- Clear context proactively at 40%
- Use JIT loading patterns to manage context budget

#### Failure 3: Debug Loop Spiral

**Symptom:** AI adds logging instead of fixing root cause

**Root cause:** AI doesn't understand problem, keeps guessing

**Violated factor:** Factor IV (Research Before You Build)

**Remedy:**
- Take manual control immediately
- Use debugger yourself
- Root cause analysis before asking AI again

---

## Middle Loop: Hours to Days

### Definition

**Multi-agent coordination and extended sessions.**

This is the loop of:
- Coordinating multiple AI agents
- Extended work sessions (hours)
- Building larger features
- Refactoring subsystems
- Integrating multiple changes

**Timescale:** Hours to days per feature

**Key characteristic:** Multiple agents or extended AI sessions, coordination complexity

---

### Vibe Coding Strategies

#### Prevention

**Written rules (AI can't read minds)**
- Explicit coding standards
- Architecture decision records
- Clear module boundaries
- Documented constraints

**Memento method (context management)**
- Save context snapshots
- Reload from saved state
- Don't rely on AI memory

**Intentional coordination**
- Assign agents to specific domains
- Prevent overlap/collision
- Clear handoff protocols

#### Detection

**Waking to "eldritch horrors"**
- 3,000-line functions
- Everything connected to everything
- Can't understand code AI wrote
- → STOP IMMEDIATELY

**Agent contention detection**
- File lock conflicts
- Merge conflicts
- Port/resource collisions
- → Pause all agents, resolve manually

**CI/CD gates**
- Automated integration tests
- Catch multi-agent failures
- Validation after coordination

#### Correction

**Tracer bullets**
- Implement vertical slice end-to-end
- Validate integration early
- Don't parallelize too early

**Workflow automation**
- Codify coordination patterns
- Repeatability > manual orchestration

**Economics of optionality**
- Run parallel experiments (NK/t/σ)
- Compare approaches
- Choose best, discard rest

---

### AgentOps Implementation

#### Factor III: One Agent, One Job

**Maps to Middle Loop Prevention:**
- Clear agent boundaries prevent collisions
- Domain assignment (agent A = frontend, agent B = backend)
- Explicit handoff protocols

**Example:**
```
Agent 1: API implementation
Agent 2: Database schema
Agent 3: Frontend components
# No overlap, clear boundaries
```

#### Factor X: Isolate Workers

**Maps to Middle Loop Detection:**
- Architecture constraints prevent eldritch horrors
- Independent execution environments per worker
- Clear module interfaces, no shared mutable state

**Example:**
```python
# Constraint: Functions must be <50 lines
# AI tries to write 500-line function
# Pre-commit hook rejects it
# Forces AI to modularize
```

#### Factor I: Context Is Everything

**Maps to Middle Loop Correction:**
- 40% rule prevents context collapse
- JIT loading patterns
- Memento method for state management

**Example:**
```
# Extended session hits 40% context
# Save current state
# Clear context
# Reload only essentials
# Continue with fresh context
```

---

### Common Middle Loop Failures

#### Failure 1: Eldritch Code Horror

**Symptom:** 3,000+ line functions, everything connected, unmaintainable

**Root cause:** AI optimizes for "working" not "maintainable," no modularity constraints

**Violated factor:** Factor X (Isolate Workers)

**Remedy:**
- STOP IMMEDIATELY - Do not proceed
- Add comprehensive tests first (capture behavior)
- Incrementally extract modules
- Refactor with AI assistance but human review

#### Failure 2: Agent Workspace Collision

**Symptom:** Multiple agents modify same files, port conflicts, merge conflicts

**Root cause:** Poor coordination, no domain boundaries

**Violated factor:** Factor III (One Agent, One Job)

**Remedy:**
- Pause all agents immediately
- Resolve conflicts manually
- Reassign domains to prevent future collisions
- Implement explicit handoff protocols

#### Failure 3: Multi-Agent Deadlock

**Symptom:** Agents waiting for each other, circular dependencies, no progress

**Root cause:** Poor task decomposition, circular dependencies

**Violated factor:** Factor X (Isolate Workers) + task decomposition

**Remedy:**
- Break dependency cycle manually
- Implement tracer bullet (vertical slice)
- Serialize interdependent work

---

## Outer Loop: Weeks to Months

### Definition

**Long-term architecture, processes, organizational patterns.**

This is the loop of:
- System architecture evolution
- API stability and versioning
- Team processes and workflows
- Organizational transformation
- Platform and infrastructure

**Timescale:** Weeks to months per major change

**Key characteristic:** Long-term impact, organizational scope, production consequences

---

### Vibe Coding Strategies

#### Prevention

**Don't torch bridges (API stability)**
- Backward compatibility always
- Deprecation periods before removal
- Versioned APIs
- Contract testing

**Modularization**
- Isolate changes
- Reduce blast radius
- Independent deployability

**Fleet management**
- Manage multiple AI agents/workflows
- Observability across fleet
- Centralized policy enforcement

#### Detection

**When AI throws everything out**
- Massive refactor = warning sign
- "Let's rewrite from scratch" = danger
- Loss of backward compatibility = stop

**CI/CD in AI age**
- Comprehensive integration tests
- Backward compatibility validation
- Performance regression detection

#### Correction

**Heroic merge recovery**
- git reflog to find lost work
- Manual conflict resolution
- Reconstruct intent from commits

**Navigate legacy constraints**
- Work within existing systems
- Incremental migration, not big bang
- Preserve production stability

---

### AgentOps Implementation

#### Factor VI: Lock Progress Forward

**Maps to Outer Loop Prevention:**
- Fast rollback when AI breaks things
- Immutable checkpoints
- Never lose progress

**Example:**
```bash
# AI breaks production
# Rollback in <5 minutes:
git revert [commit-sha]
# Production restored immediately
```

#### Factor XI: Supervise Hierarchically

**Maps to Outer Loop Detection:**
- Oversight and guardrails for AI adoption
- Fast lane for low-risk changes
- Stakeholder alignment through hierarchical review

**Example:**
```
# AI productivity hits approval bottleneck
# Solution: Hierarchical oversight
# Low-risk changes: Automated validation
# High-risk changes: Human review
# Productivity maintained
```

#### Factor XII: Harvest Failures as Wisdom

**Maps to Outer Loop Correction:**
- Learn from every production incident
- API compatibility tests prevent future breakage
- Blameless postmortems capture institutional knowledge

**Example:**
```bash
# Pre-deployment check:
make api-compatibility-test
# Catches API breakage before production
# Each failure becomes a new validation rule
```

---

### Common Outer Loop Failures

#### Failure 1: Bridge Torching / API Breakage

**Symptom:** AI changes function signatures without warning, breaks callers in production

**Root cause:** AI doesn't understand production impact of API changes

**Violated factor:** Factor V (Validate Externally)

**Remedy:**
- Rollback immediately (Factor VI: Lock Progress Forward)
- Restore API compatibility
- Add API compatibility tests before retrying
- Implement contract testing

#### Failure 2: Repository Deletion Disaster

**Symptom:** AI deletes "unused" branches with valuable work

**Root cause:** AI doesn't understand git history value, over-optimizes for "cleanliness"

**Violated factor:** Factor II (Track Everything in Git)

**Remedy:**
```bash
# Recovery:
git reflog  # Find deleted branch
git checkout [sha]  # Restore from reflog
git branch recovery-branch  # Save it
# Prevention: Protected branches, deletion policies
```

#### Failure 3: Organizational Process Gridlock

**Symptom:** AI productivity gains negated by approval processes

**Root cause:** Traditional processes don't account for AI velocity

**Violated factor:** Factor XI (Supervise Hierarchically)

**Remedy:**
- Implement fast lane for low-risk changes
- Risk-based approval matrix
- Automated validation replaces some human review
- Cultural shift to trust but verify

---

## Cross-Loop Patterns

### How Loops Interact

**Inner Loop failures compound to Middle Loop:**
- Many "context amnesia" events → Eldritch code horror
- Skipped validation in Inner → Integration failures in Middle

**Middle Loop failures compound to Outer Loop:**
- Poor modularity in Middle → Bridge torching in Outer
- Agent collisions in Middle → Process gridlock in Outer

**Outer Loop constraints flow to Inner/Middle:**
- API stability requirements → Inner Loop validation needs
- Organizational policies → Middle Loop coordination patterns

### The Flywheel

```
Inner Loop (fast iterations)
     ↓
  Learn patterns
     ↓
Middle Loop (apply patterns at scale)
     ↓
  Extract reusable workflows
     ↓
Outer Loop (codify as org patterns)
     ↓
  Inform next Inner Loop iterations
     ↓
  (cycle continues, improving each time)
```

---

## Practical Application

### Diagnostic Use: "Which Loop Am I In?"

**Ask yourself:**
- Am I coding a single function? → Inner Loop (use Factors II, V, VI)
- Am I coordinating multiple agents? → Middle Loop (use Factors I, III, X)
- Am I changing architecture/process? → Outer Loop (use Factors VI, XI, XII)

**Example:**
```
Task: "Add caching to API"

Inner Loop phase: Implement cache logic (use TDD, validation)
Middle Loop phase: Coordinate cache + API + database agents (use modularity)
Outer Loop phase: Deploy to production, monitor (use dev/prod parity)

Each phase needs different AgentOps factors
```

### Prevention Use: "Plan Ahead"

**Before starting work:**
1. Identify which loop(s) you'll traverse
2. Set up Prevention strategies for each
3. Define Detection criteria
4. Document Correction procedures

**Example:**
```
Project: Migrate database schema

Loops involved: All three
- Inner: Write migration scripts (TDD, validation)
- Middle: Coordinate app changes + DB changes (modularity)
- Outer: Zero-downtime migration (dev/prod parity)

Prevention for each loop planned upfront
```

### Retrospective Use: "What Went Wrong?"

**After a failure:**
1. Identify which loop it occurred in
2. Find the violated factor
3. Apply the Correction strategy
4. Add Prevention for future

**Example:**
```
Failure: Production API broke after deployment

Loop: Outer (production impact)
Violated factor: Factor V (Validate Externally)
Correction: Rollback immediately
Prevention: Add API compatibility tests to CI/CD
```

---

## Summary Table

| Loop | Timescale | AgentOps Factors | Prevention | Detection | Correction |
|------|-----------|-----------------|-----------|-----------|------------|
| **Inner** | Seconds-minutes | II, V, VI | Checkpoint frequently, TDD, git mastery | Verify AI claims, always on watch | Rollback, manual debugging |
| **Middle** | Hours-days | I, III, X | Written rules, memento method | Eldritch horror detection, CI/CD gates | Tracer bullets, workflow automation |
| **Outer** | Weeks-months | VI, XI, XII | Don't torch bridges, modularization | AI throws everything out, CI/CD | git reflog recovery, navigate legacy |

**Cross-Loop Factors:**
- Factor IV: Research Before You Build (applies to all loops)
- Factor VII: Extract Learnings (applies to all loops)
- Factor VIII: Compound Knowledge (applies to all loops)

---

## Next Steps

1. **Study each loop individually** - Understand timescales and strategies
2. **Practice loop identification** - "Which loop am I in right now?"
3. **Review failure patterns** - [Read complete catalog →](../reference/failure-patterns.md)
4. **Map your workflows** - Which loops do your projects traverse?
5. **Implement Prevention** - Set up strategies for each loop you work in

---

## Credits

**Three Developer Loops Framework:**
- Gene Kim & Steve Yegge
- [Vibe Coding presentation](https://www.youtube.com/watch?v=vibe-coding)

**AgentOps Mapping:**
- 2 years production validation
- 12 Factors mapped to Inner/Middle/Outer loops
- Prevention/Detection/Correction patterns proven in practice

---

**Understanding which loop you're in is the first step to applying the right operational patterns.**
