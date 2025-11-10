# Using 12-Factor AgentOps

**How to apply the methodology in practice.**

---

## The Core Workflow

All AI agent work follows the same three-phase pattern:

```
Research → Plan → Implement
```

Each phase has validation gates. **Never skip ahead.**

---

## Phase 1: Research

**Goal:** Understand the problem thoroughly before solving it.

### What You Do

1. **Explore** the codebase, documentation, and context
2. **Ask questions** to understand requirements
3. **Identify** relevant files, dependencies, and constraints
4. **Document** findings for the next phase

### Validation Gate

**Before moving to Plan:**
- ✅ Do you understand what needs to change?
- ✅ Do you know where the relevant code is?
- ✅ Do you understand the constraints and dependencies?
- ✅ Can you explain the problem to someone else?

If any answer is "no," continue research.

### Factor Application

- **Factor I (Git Memory):** Review git history for context
- **Factor II (JIT Loading):** Use sub-agents for targeted exploration
- **Factor III (Single Responsibility):** Each research task gets its own focused agent

---

## Phase 2: Plan

**Goal:** Specify EXACTLY what will change before touching code.

### What You Do

1. **List** every file that needs modification (create/edit/delete)
2. **Specify** exact changes with file:line precision
3. **Design** test strategy (how will you know it works?)
4. **Order** changes by dependencies (what must happen first?)
5. **Identify** risks and rollback procedures

### Validation Gate

**Before moving to Implement:**
- ✅ Is every change specified with file:line precision?
- ✅ Do you have before/after examples for each change?
- ✅ Is the test strategy clear and executable?
- ✅ Do you know the implementation order?
- ✅ Can someone else execute this plan?

If any answer is "no," improve the plan.

### Factor Application

- **Factor IV (Validation Gates):** Plan review checkpoint
- **Factor VIII (Human Gate Reviews):** Get approval before implementing
- **Factor XI (Constitutional Guardrails):** Check plan against safety constraints

**Good plan example:**
```markdown
Change 1: Add JWT validation
File: auth/middleware.go:45
Before: if token != nil {
After:  if token != nil && validateJWT(token) {
Test: go test ./auth/... should pass
Risk: Medium (auth is critical)
Rollback: git checkout -- auth/middleware.go
```

---

## Phase 3: Implement

**Goal:** Execute the plan mechanically with continuous validation.

### What You Do

1. **Follow** the plan exactly (don't redesign during implementation)
2. **Make** one change at a time
3. **Validate** after each change
4. **Document** as you go
5. **Commit** with meaningful messages

### Validation Gate

**Before committing:**
- ✅ Do all tests pass?
- ✅ Does the build succeed?
- ✅ Did you test manually (if applicable)?
- ✅ Is the commit message clear and complete?
- ✅ Are you ready to push this to production?

If any answer is "no," fix issues before committing.

### Factor Application

- **Factor I (Git Memory):** Semantic commits with context
- **Factor IV (Validation Gates):** Test after every change
- **Factor V (Operational Telemetry):** Log what happened
- **Factor IX (Pattern Extraction):** Document learnings

**Good commit example:**
```
feat(auth): Add JWT signature validation

## Context
Users were bypassing auth with forged tokens because we
weren't validating JWT signatures.

## Solution
- Added validateJWT() check in middleware
- Imported golang-jwt/jwt library
- Added JWT_SECRET configuration

## Testing
- Unit tests pass (go test ./auth/...)
- Integration tests pass (go test ./...)
- Manual test with curl confirmed

## Impact
- Security: Forged tokens now rejected
- Performance: <1ms validation overhead
```

---

## Validation Patterns

### Local Validation (Before Commit)

**Always validate locally first:**

```bash
# Syntax check
make lint

# Unit tests
make test

# Build
make build

# Integration tests (if applicable)
make integration-test
```

**Never commit without local validation passing.**

### Continuous Validation (After Commit)

**Let automation validate further:**

```bash
# Push to remote
git push

# CI/CD runs:
# - All tests again
# - Security scans
# - Deployment to staging
# - Smoke tests
```

**Monitor CI/CD results. Rollback if failures occur.**

### Pre-Production Validation

**Before production deployment:**

- Manual smoke tests in staging
- Load testing (if performance-critical)
- Security review (if auth/data handling)
- Stakeholder approval (if customer-facing)

---

## Pattern Extraction

**After every session, extract learnings:**

### What Went Well?

- Which patterns were effective?
- Which tools/agents worked best?
- What can be reused next time?

### What Could Improve?

- Which steps were inefficient?
- What caused delays or errors?
- What would you do differently?

### Generalizable Patterns

- Can this approach work for other problems?
- What's the core insight?
- How can others apply this?

**Document and share:** [CONTRIBUTING.md](./CONTRIBUTING.md)

---

## Factor Compliance Checklist

Use this checklist for every agent session:

### Foundation Factors (Required)

- [ ] **Factor I:** Git commits capture intent and context
- [ ] **Factor II:** Complex tasks delegated to sub-agents
- [ ] **Factor III:** Each agent has single, clear responsibility
- [ ] **Factor IV:** Validation gates at every phase

### Operational Factors (As Needed)

- [ ] **Factor V:** Metrics captured for this session
- [ ] **Factor VI:** Context preserved via bundles (if multi-session)
- [ ] **Factor VII:** Task routed to appropriate agent/workflow
- [ ] **Factor VIII:** Human review at critical gates

### Improvement Factors (Always)

- [ ] **Factor IX:** Learnings extracted and documented
- [ ] **Factor X:** At least one improvement identified
- [ ] **Factor XI:** Constitutional constraints respected
- [ ] **Factor XII:** Domain knowledge captured for reuse

---

## Common Mistakes

### ❌ Skipping Research

**Problem:** "I know what to do" → Start coding immediately

**Result:** Wrong solution, wasted time, rework

**Fix:** Always research first, even for "simple" tasks

### ❌ Vague Plans

**Problem:** "Fix the authentication bug"

**Result:** Unclear what to change, implementation wanders

**Fix:** Specify file:line changes with before/after

### ❌ No Validation

**Problem:** "It looks right" → Commit without testing

**Result:** Broken code in production

**Fix:** Test locally, always

### ❌ Skipping Pattern Extraction

**Problem:** Solve problem, move on immediately

**Result:** Same problem takes same time next occurrence

**Fix:** Spend 5 minutes documenting the pattern

---

## When to Use What

### Simple Tasks

**Example:** Fix typo, update version number

**Workflow:**
- Quick research (read file)
- Minimal plan (one-line change)
- Immediate implementation
- Fast validation
- Commit

**Time:** 5-10 minutes

### Medium Tasks

**Example:** Add new feature, refactor module

**Workflow:**
- Research phase (30 min)
- Planning phase (15 min)
- Implementation phase (1-2 hours)
- Validation (15 min)
- Commit + pattern extraction (15 min)

**Time:** 2-3 hours

### Complex Tasks

**Example:** Architectural change, multi-system integration

**Workflow:**
- Research phase (2-4 hours, possibly across sessions)
- Planning phase (1-2 hours with team review)
- Implementation phase (4-8 hours across multiple commits)
- Validation (1-2 hours including staging deployment)
- Pattern extraction (30 min comprehensive writeup)

**Time:** 1-3 days

---

## Advanced: Multi-Agent Orchestration

**For complex tasks, use multiple agents in parallel:**

### Pattern

```
Main Agent (Orchestrator)
    ├─→ Research Agent 1: Explore codebase structure
    ├─→ Research Agent 2: Review dependencies
    ├─→ Research Agent 3: Check security implications
    └─→ Synthesize findings → Move to Plan phase
```

**Benefits:**
- 3x faster research
- Isolated contexts (no interference)
- Parallel execution

**See:** [marketplace/advanced/multi-agent-orchestration.md](./marketplace/advanced/multi-agent-orchestration.md)

---

## Next Steps

**You now know the workflow. Start applying it:**

1. **Try the starter pack:** [examples/STARTER-PACK](./examples/STARTER-PACK/)
2. **Read the factors:** [FACTORS.md](./FACTORS.md)
3. **Explore your domain:** [marketplace/domain-guides](./marketplace/domain-guides/)
4. **Contribute:** [CONTRIBUTING.md](./CONTRIBUTING.md)

**Remember:**
- Research before planning
- Plan before implementing
- Validate at every gate
- Extract patterns after every session

**Trust the process. It works.**
