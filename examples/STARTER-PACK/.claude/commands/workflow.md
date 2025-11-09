# /workflow - Complete Research → Plan → Implement → Learn Cycle

**Purpose:** Orchestrate complete 12-Factor AgentOps workflow

**When to use:** Starting complex work from scratch

**What it does:** Guides you through all 4 phases with phase transitions

---

## Usage

```bash
/workflow [topic]
```

**Process:**

### Phase 1: Research
1. Invokes `/research`
2. Gathers context, understands problem
3. Creates research bundle
4. → Transition to Plan

### Phase 2: Plan
1. Invokes `/plan [research-bundle]`
2. Designs solution, breaks down tasks
3. Creates implementation spec
4. Gets approval
5. → Transition to Implement

### Phase 3: Implement
1. Invokes `/implement [plan]`
2. Executes tasks with validation
3. Tracks metrics
4. Commits with learnings
5. → Transition to Learn

### Phase 4: Learn
1. Invokes `/learn`
2. Extracts patterns
3. Identifies improvements
4. Documents for future
5. → Complete

---

## Example

```
You: /workflow add-refresh-tokens

Phase 1: Research
[Research agent gathers context about current auth]
Research complete → Bundle saved

Phase 2: Plan
[Plan agent designs refresh token solution]
Plan complete → Spec created
Approve plan? yes

Phase 3: Implement
[Implement agent executes plan with validation]
Implementation complete → All tests pass

Phase 4: Learn
[Learn agent extracts patterns]
Learnings documented → Pattern library updated

Workflow complete! ✅
```

---

**Time:** 4-12 hours total (varies by complexity)
**Phases:** Research (20%), Plan (30%), Implement (40%), Learn (10%)

**Demonstrates:** ALL 12 Factors working together through complete lifecycle
