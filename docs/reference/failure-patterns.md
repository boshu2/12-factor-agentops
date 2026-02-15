# The 12 Failure Patterns Catalog

**Complete catalog of AI-assisted development failure modes mapped to 12-Factor AgentOps prevention.**

**Source:** Gene Kim & Steve Yegge, *Vibe Coding* (IT Revolution Press, 2025)

---

## Severity Legend

| Level | Impact | Patterns |
|-------|--------|----------|
| **CRITICAL** | Months of work lost | Eldritch Horror, Bridge Torching, Repo Deletion |
| **HIGH** | Days-weeks of rework | Tests Lie, Debug Spiral, Collisions, Deadlock, Gridlock, Stewnami |
| **MEDIUM** | Hours of lost context | Context Amnesia, Instruction Drift, Memory Decay |

---

## How to Use This Catalog

**Purpose:** Rapid diagnosis and remediation of AI workflow failures

**When to use:**
1. **Experiencing a symptom** → Find the pattern → See violated factor → Apply remedy
2. **Planning work** → Review relevant patterns → Implement prevention
3. **Postmortem** → Identify what failed → Document learnings

**Structure:**
- **Inner Loop failures** (seconds-minutes timescale)
- **Middle Loop failures** (hours-days timescale)
- **Outer Loop failures** (weeks-months timescale)
- **Quick reference table** (symptom → pattern lookup)

---

## Inner Loop Failures

### Pattern: "Tests Are Passing" Lie

**Severity:** 🔴 High
**Loop:** Inner (seconds-minutes)
**Symptom:** AI claims "all tests green" but code doesn't compile or tests actually fail

**Root Cause:**
- AI hallucinates test results without actually running tests
- Confabulation of success based on code structure, not execution
- No actual test harness invoked

**Violated Factor:** **Factor V (Validate Externally)**

**Prevention:**
- Always run tests independently (don't trust AI claims)
- Never accept "tests pass" without verification
- Use Factor II (Track Everything in Git) to log actual test runs with timestamps

**Detection:**
- Compilation fails despite "passing tests" claim
- Test output logs don't exist or timestamps don't match
- AI can't show you the actual test output

**Correction:**
- Immediately stop trusting AI test claims in this session
- Run full test suite independently: `pytest tests/` or equivalent
- Fix actual errors revealed by real tests
- Clear AI context, restart with explicit "show me actual test output" instruction

**AgentOps Implementation:**
```bash
# Factor 6: Validation gate
pre-commit hook:
  - Run: pytest tests/ --verbose
  - Log: test results with timestamp
  - Block: commit if tests fail
  - Never trust: AI claims without logs
```

**Example:**
```
AI: "All tests are passing! ✅"
You: "Show me the test output"
AI: [Generates fictional output]
You: pytest tests/
Output: FAILED tests/test_calculate.py::test_sum - NameError: name 'sum_values' is not defined

→ AI lied, test failed, code broken
→ Factor 6 violated (validation skipped)
→ Remedy: Independent test execution always
```

---

### Pattern: Context Amnesia

**Severity:** 🟡 Medium
**Loop:** Inner (minutes-hours)
**Symptom:** AI forgets instructions given minutes ago, asks for information already provided

**Root Cause:**
- Context window utilization exceeds 40% threshold
- Performance degrades non-linearly (cliff, not slope)
- AI loses track of earlier conversation

**Violated Factor:** **Factor I (Context Is Everything)**

**Prevention:**
- Monitor context utilization actively (estimate tokens used)
- Clear context proactively at 40% threshold
- Use Factor I (Context Is Everything) for JIT reload patterns
- Save session state before clearing (memento method)

**Detection:**
- AI asks for information you just provided
- AI contradicts earlier decisions or recommendations
- AI loses track of file structure or project layout
- Responses become generic/repetitive

**Correction:**
- Immediately clear context window
- Save essential state to external file
- Reload only critical context (40% → 15%)
- Resume with fresh context

**AgentOps Implementation:**
```bash
# Factor 10: Context monitoring
Check: Estimated context usage
If >40%:
  1. Save state: current-context.md
  2. Clear: Start fresh session
  3. Reload: Only essentials (JIT)
  4. Resume: With <20% context used
```

**Example:**
```
You: "Use Redis for caching, port 6379"
[... 30 minutes of work ...]
AI: "What caching solution should we use?"

→ Context amnesia (forgot Redis decision)
→ Factor 10 violated (context exceeded 40%)
→ Remedy: Clear context, reload essentials
```

---

### Pattern: Debug Loop Spiral

**Severity:** 🟡 Medium
**Loop:** Inner (minutes)
**Symptom:** AI adds logging/print statements instead of fixing root cause, infinite debug loop

**Root Cause:**
- AI doesn't understand actual problem
- Guessing rather than analyzing
- Each iteration adds more logging, no fix

**Violated Factor:** **Factor IV (Research Before You Build)**

**Prevention:**
- Use debugger first (breakpoint at error location)
- Root cause analysis before asking AI for help
- Give AI specific error message, not vague description

**Detection:**
- AI suggests "add logging" multiple times
- Error persists across 3+ AI iterations
- Code gets messier (more prints/logging)
- No actual fix attempted

**Correction:**
- STOP asking AI for debugging help
- Take manual control immediately
- Use debugger yourself (step through code)
- Find root cause manually
- Then ask AI to fix specific issue (not "debug this")

**AgentOps Implementation:**
```bash
# Factor 1: Fast feedback
If debug iteration >3:
  1. Stop AI loop
  2. Use debugger: breakpoint at error
  3. Find root cause manually
  4. Fix or ask AI to fix SPECIFIC issue
  5. Verify fix with test
```

**Example:**
```
AI: "Let's add logging to see what's happening"
[Add print statements]
AI: "Let's add more logging here"
[Add more prints]
AI: "Let's log the function inputs"
[Even more prints]
Error: Still occurs

→ Debug loop spiral (no progress)
→ Factor 1 violated (feedback not fast, iterating blindly)
→ Remedy: Manual debugger, root cause analysis
```

---

### Pattern: Forgotten Context Mid-Edit

**Severity:** 🟡 Medium
**Loop:** Inner (seconds-minutes)
**Symptom:** AI starts editing a file, forgets what it was doing mid-edit, produces broken code

**Root Cause:**
- Long file (>500 lines) + complex edit
- AI loses track of change intent partway through
- Result: Incomplete refactor, broken state

**Violated Factor:** **Factor X (Isolate Workers)** + **Factor I (Context Is Everything)**

**Prevention:**
- Keep files <500 lines (modularity constraint)
- Break large edits into smaller chunks
- One change at a time, validate each

**Detection:**
- File compiles before edit, doesn't compile after
- Function half-refactored (some calls updated, some not)
- Inconsistent naming mid-file

**Correction:**
- git revert immediately (rollback partial edit)
- Break edit into smaller chunks
- Validate after each chunk

**AgentOps Implementation:**
```bash
# Factor 9: Modularity limits
Constraint: Files <500 lines
Constraint: Functions <50 lines
If file too large:
  1. Stop edit
  2. Extract modules first
  3. Then edit smaller modules
```

---

### Pattern: Infinite Compilation Error Loop

**Severity:** 🔴 High
**Loop:** Inner (minutes)
**Symptom:** Fix compilation error → new compilation error → fix → new error → infinite loop

**Root Cause:**
- AI fixes symptom, not cause
- Each fix breaks something else
- No holistic understanding of codebase

**Violated Factor:** **Factor V (Validate Externally)** + **Factor X (Isolate Workers)**

**Prevention:**
- Validate code structure before committing
- Run full compilation after each AI change
- Limit AI to one file at a time

**Detection:**
- Error count not decreasing
- Errors in new files each iteration
- Same error type recurring

**Correction:**
- git reset --hard (revert all AI changes)
- Start over from known-good state
- Break change into minimal reproducible case

**AgentOps Implementation:**
```bash
# Factor 6: Validation after each change
After AI edit:
  make quick  # Immediate syntax check
  If errors:
    git revert  # Undo immediately
    Break change smaller
```

---

## Middle Loop Failures

### Pattern: Eldritch Code Horror

**Severity:** 🔴 Critical
**Loop:** Middle (hours-days)
**Symptom:** 3,000+ line functions, everything connected to everything, unmaintainable monolith

**Root Cause:**
- AI optimizes for "working" not "maintainable"
- No modularity constraints enforced
- Extended session without architectural oversight

**Violated Factor:** **Factor X (Isolate Workers)**

**Prevention:**
- Set explicit modularity constraints upfront:
  - Max function length: 50 lines
  - Max file length: 500 lines
  - Max function parameters: 5
  - Clear module interfaces
- Review architecture before letting AI implement
- Use Factor 9 patterns from day one

**Detection:**
- Function lengths exceed 200 lines
- Everything tightly coupled (change one thing, breaks ten others)
- Can't understand code AI wrote
- Code review reveals architectural disaster

**Correction (DO NOT SKIP):**
1. **STOP IMMEDIATELY** - Do not proceed with this code
2. **Add comprehensive tests FIRST** (capture current behavior before refactoring)
3. **Extract modules incrementally** (one function at a time)
4. **Refactor with AI assistance BUT HUMAN REVIEW** (don't let AI create more horror)
5. **Validate after each extraction** (tests still pass)

**AgentOps Implementation:**
```bash
# Factor 9: Modularity enforcement
Pre-commit hook:
  - Max function lines: 50
  - Max file lines: 500
  - Cyclomatic complexity: <10
  - If violated: REJECT commit
  - Force AI to modularize
```

**Example:**
```python
# AI produces:
def process_everything(data, config, db, cache, logger, metrics, ...):
    # 3,000 lines of spaghetti
    # Everything connected
    # No separation of concerns

→ Eldritch code horror
→ Factor 9 violated (no modularity)
→ Remedy: Stop, test, extract, refactor
```

---

### Pattern: Agent Workspace Collision

**Severity:** 🟠 High
**Loop:** Middle (hours-days)
**Symptom:** Multiple agents modify same files, port conflicts, merge conflicts, chaos

**Root Cause:**
- Poor coordination, no domain boundaries
- Agents overlap in scope
- No explicit handoff protocols

**Violated Factor:** **Factor III (One Agent, One Job)** + **Factor IV (Research Before You Build)**

**Prevention:**
- Assign agents to specific domains (Agent A = frontend, B = backend, C = DB)
- Prevent overlap in file/module ownership
- Explicit handoff protocols for shared resources

**Detection:**
- File lock conflicts
- Merge conflicts when integrating agent work
- Port conflicts (multiple agents trying to use same port)
- Resource contention (database, API rate limits)

**Correction:**
1. **Pause all agents immediately**
2. **Resolve conflicts manually** (don't ask AI to fix merge conflicts)
3. **Reassign domains** to prevent future collisions
4. **Implement explicit handoff** (Agent A finishes, notifies Agent B to start)

**AgentOps Implementation:**
```bash
# Factor 3: Agent domain assignment
Agent 1: Owns src/frontend/**
Agent 2: Owns src/backend/**
Agent 3: Owns src/database/**
Rule: No cross-domain edits
Handoff: Explicit coordination points
```

**Example:**
```
Agent 1: Modifies src/api/routes.py
Agent 2: Also modifies src/api/routes.py
Git: CONFLICT (content): Merge conflict in src/api/routes.py

→ Workspace collision
→ Factor 3 violated (no domain boundaries)
→ Remedy: Pause all, resolve manually, reassign domains
```

---

### Pattern: Multi-Agent Deadlock

**Severity:** 🟠 High
**Loop:** Middle (hours-days)
**Symptom:** Agents waiting for each other, circular dependencies, no progress

**Root Cause:**
- Poor task decomposition
- Circular dependencies (A needs B, B needs A)
- No tracer bullet to break cycle

**Violated Factor:** **Factor X (Isolate Workers)** + poor task decomposition

**Prevention:**
- Implement tracer bullet first (vertical slice end-to-end)
- Dependency analysis before parallel work
- Ensure no circular dependencies in task graph

**Detection:**
- No progress for extended time (hours)
- Agents waiting for each other's output
- Task graph has cycles

**Correction:**
1. **Break dependency cycle manually**
2. **Implement mock/stub** for blocking dependency
3. **Serialize interdependent work** (do sequentially, not parallel)

**AgentOps Implementation:**
```bash
# Factor 9: Dependency graph analysis
Before parallel agents:
  1. Map: Task dependency graph
  2. Check: Cycles detected?
  3. If yes: Break cycle with mocks OR serialize
  4. If no: Safe to parallelize
```

---

### Pattern: State Explosion Across Agents

**Severity:** 🟡 Medium
**Loop:** Middle (hours-days)
**Symptom:** Agents diverge in understanding of system state, inconsistent assumptions

**Root Cause:**
- No shared context mechanism
- Each agent has different view of system
- State synchronization not implemented

**Violated Factor:** **Factor I (Context Is Everything)** + multi-agent coordination

**Prevention:**
- Shared state file (read by all agents)
- Explicit state synchronization points
- Single source of truth for system state

**Detection:**
- Agents make contradictory assumptions
- Integration reveals inconsistencies
- "Works on my agent" syndrome

**Correction:**
- Pause agents
- Establish single source of truth (shared context file)
- Reload all agents from shared state
- Resume with synchronized context

---

## Outer Loop Failures

### Pattern: Bridge Torching / API Breakage

**Severity:** 🔴 Critical
**Loop:** Outer (weeks-months)
**Symptom:** AI changes function signatures without warning, breaks callers in production

**Root Cause:**
- AI doesn't understand production impact of API changes
- No backward compatibility validation
- Missing contract testing

**Violated Factor:** **Factor V (Validate Externally)** + **Factor XI (Supervise Hierarchically)**

**Prevention:**
- API compatibility tests in CI/CD pipeline
- Explicit API versioning strategy
- Never let AI modify public interfaces without review
- Contract testing (consumer-driven contracts)

**Detection:**
- Compilation errors in dependent code
- Production errors after deployment
- Tests fail in downstream services
- Customer reports breakage

**Correction:**
1. **Rollback immediately** (Factor 2: Disposability)
2. **Restore API compatibility** (revert breaking change)
3. **Add API compatibility tests** before retrying
4. **Implement deprecation period** (don't break immediately)

**AgentOps Implementation:**
```bash
# Factor 11: API compatibility testing
Pre-deployment:
  - Run: API compatibility test suite
  - Check: Breaking changes detected?
  - If yes: BLOCK deployment
  - Require: Explicit approval for breaking changes
  - Enforce: Deprecation period (6 months minimum)
```

**Example:**
```python
# Before:
def calculate(value):
    return value * 2

# AI changes to:
def calculate(value, multiplier=2):
    return value * multiplier

# Breaks all callers:
result = calculate(10)  # TypeError: missing required argument 'multiplier'

→ Bridge torching (API break)
→ Factor 11 violated (no compatibility check)
→ Remedy: Rollback, add compatibility test, deprecate old API gradually
```

---

### Pattern: Repository Deletion Disaster

**Severity:** 🔴 Critical
**Loop:** Outer (weeks-months)
**Symptom:** AI deletes "unused" branches with valuable work-in-progress

**Root Cause:**
- AI doesn't understand git history value
- Over-optimizes for "cleanliness"
- Deletes branches with unmerged work

**Violated Factor:** **Factor XI (Supervise Hierarchically)** + **Factor II (Track Everything in Git)**

**Prevention:**
- Protected branches policy (can't delete main, develop, production)
- Branch naming convention (wip/*, feature/*, etc.)
- Git hooks to prevent accidental deletion

**Detection:**
- git branch -a shows missing branches
- Team member reports missing work
- Features disappear from branch list

**Correction (Recovery):**
```bash
# Use git reflog to find deleted branch
git reflog
# Find the commit where branch existed
git checkout [sha-of-deleted-branch]
# Recreate branch
git branch recovery-branch
# Push to remote
git push -u origin recovery-branch
```

**AgentOps Implementation:**
```bash
# Factor 1: Protected branches
Git hook:
  - Block deletion of: main, develop, production, release/*
  - Warn on deletion of: feature/*, wip/*
  - Require confirmation: All other branches
  - Never let AI: Delete branches without human approval
```

---

### Pattern: Organizational Process Gridlock

**Severity:** 🟠 High
**Loop:** Outer (weeks-months)
**Symptom:** AI productivity gains negated by approval processes, bottlenecks

**Root Cause:**
- Traditional processes don't account for AI velocity
- Every change requires committee approval
- Manual review slower than AI generation

**Violated Factor:** **Factor V (Validate Externally)** + **Factor IX (Measure What Matters)**

**Prevention:**
- Implement fast lane for low-risk changes
- Risk-based approval matrix (auto-approve low-risk, committee for high-risk)
- Automated validation replaces some human review

**Detection:**
- AI produces changes faster than team can review
- Backlog of unreviewed AI-generated code
- Productivity metrics show approval as bottleneck

**Correction:**
1. **Implement fast lane** (auto-approve if all validation passes)
2. **Risk matrix**:
   - Low risk (config changes, docs): Auto-approve
   - Medium risk (feature changes, refactors): Tech lead review
   - High risk (architecture, API changes): Committee review
3. **Automated validation** (Factor 6) replaces manual checks

**AgentOps Implementation:**
```bash
# Factor 8: Fast lane approval
If change is:
  - Type: docs, config, test
  - Size: <100 lines
  - Tests: All passing
  - Security scan: Clean
Then:
  - Auto-approve ✅
Else:
  - Human review required
```

---

### Pattern: Cascading Production Failures

**Severity:** 🔴 Critical
**Loop:** Outer (weeks-months)
**Symptom:** AI change breaks production, fix breaks something else, cascade of failures

**Root Cause:**
- No staging environment (dev/prod parity violation)
- Changes deployed directly to production
- Missing integration tests

**Violated Factor:** **Factor V (Validate Externally)** + **Factor XI (Supervise Hierarchically)**

**Prevention:**
- Staging environment matching production
- Deploy to staging first, validate, then production
- Comprehensive integration test suite
- Canary deployments (gradual rollout)

**Detection:**
- Production errors after deployment
- Errors in unexpected parts of system
- Cascading failures across services

**Correction:**
1. **Rollback immediately** (Factor 2)
2. **Root cause analysis** in staging
3. **Fix and validate in staging** before production retry
4. **Add integration tests** to catch future issues

**AgentOps Implementation:**
```bash
# Factor 11: Staging deployment
Deployment flow:
  1. Deploy: staging environment
  2. Run: Integration test suite
  3. Monitor: 24 hours in staging
  4. If pass: Deploy to production (canary)
  5. If fail: Fix in staging, don't touch production
```

---

## Quick Reference: Symptom → Pattern

| Symptom | Pattern | Loop | Violated Factors | Page |
|---------|---------|------|-----------------|------|
| AI claims tests pass, code broken | "Tests Passing" Lie | Inner | V (Validate Externally) | ↑ |
| AI forgets recent instructions | Context Amnesia | Inner | I (Context Is Everything) | ↑ |
| AI adds logging instead of fixing bug | Debug Loop Spiral | Inner | IV (Research Before You Build) | ↑ |
| 3,000-line unmaintainable function | Eldritch Code Horror | Middle | X (Isolate Workers) | ↑ |
| Multiple agents modify same file | Agent Workspace Collision | Middle | III (One Agent, One Job) | ↑ |
| Agents waiting for each other | Multi-Agent Deadlock | Middle | X (Isolate Workers) | ↑ |
| Production API breaks after deployment | Bridge Torching | Outer | V (Validate Externally) | ↑ |
| Git branch with work deleted | Repository Deletion | Outer | II (Track Everything in Git) | ↑ |
| AI code waits weeks for approval | Process Gridlock | Outer | IX (Measure What Matters) | ↑ |
| Production deployment breaks system | Cascading Failures | Outer | V, XI (Validate, Supervise) | ↑ |

---

## Severity Levels

**🔴 Critical:** Production outage, data loss, major rework required (4+ hours to fix)

**🟠 High:** Significant productivity loss, manual intervention needed (1-4 hours to fix)

**🟡 Medium:** Noticeable issues, workflow disruption (<1 hour to fix)

**🟢 Low:** Minor annoyance, easy to fix (<15 min to fix)

---

## Prevention Hierarchy

**Best (Factor-based design):**
- Factor X (Isolate Workers) prevents eldritch horrors before they form
- Factor III (One Agent, One Job) prevents workspace collisions with domain boundaries

**Good (Automated detection):**
- Factor V (Validate Externally) catches "tests passing" lies immediately
- Factor VI (Lock Progress Forward) catches regressions before they compound

**Acceptable (Human review):**
- Factor XI (Supervise Hierarchically) identifies issues through oversight
- Code review catches problems automated tools miss

**Last Resort (Rollback and retry):**
- Factor II (Track Everything in Git) enables quick rollback when all else fails
- git revert restores known-good state

**Hierarchy:** Prevention > Detection > Correction > Rollback

---

## Using This Catalog

### For Diagnosis

**When experiencing a failure:**
1. **Identify symptom** from Quick Reference table
2. **Find the pattern** in detailed catalog
3. **See violated factor(s)**
4. **Apply correction strategy**
5. **Implement prevention** for future

### For Prevention

**Before starting work:**
1. **Review relevant patterns** for your loop (Inner/Middle/Outer)
2. **Implement prevention strategies** from applicable factors
3. **Set up detection mechanisms** (validation gates, monitoring)
4. **Document correction procedures** (playbooks for when things fail)

### For Learning

**After any failure:**
1. **Find the pattern** in this catalog
2. **Run blameless postmortem** (Factor VII: Extract Learnings)
3. **Add to institutional memory** (document in team runbook)
4. **Improve factor implementation** (strengthen prevention)

---

## Next Steps

1. **Bookmark this catalog** - Reference during failures
2. **Implement prevention** - Set up factors to prevent common patterns
3. **Share with team** - Everyone should know these patterns
4. **Contribute patterns** - Document new failures you discover
5. **Systematic improvement** - Each postmortem strengthens factors

---

## Credits

**Failure Patterns:**
- Gene Kim & Steve Yegge (Vibe Coding research)
- Production validation (2 years, documented failures)

**Factor Mapping:**
- 12-Factor AgentOps operational patterns
- Prevention/Detection/Correction strategies

**Continuous Updates:**
- This catalog grows with community contributions
- New patterns documented as discovered
- Remedies refined through production use

---

**Know the failure modes. Implement the factors. Avoid the chaos.**

**Not all failures are preventable, but all are learnable.**
