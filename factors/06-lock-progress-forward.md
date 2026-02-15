# Factor VI: Lock Progress Forward

## Rule

**Once work passes validation, it ratchets — it cannot regress.**

Progress is irreversible. Validated changes lock into the codebase. Failed attempts are discarded. The ratchet only turns forward.

## Rationale

### The Brownian Ratchet Pattern

Imagine a gear that can only turn one direction. Teeth allow forward rotation but prevent backward slippage. Random forces push the gear — sometimes forward, sometimes backward — but the ratchet only captures forward motion. Over time, chaos becomes directed progress.

This is how autonomous agents should work.

Agents are chaotic. They explore dead ends. They misunderstand requirements. They generate code that doesn't compile. If you try to make every agent attempt perfect, you'll move slowly. If you accept their chaos but add a ratchet, you move fast.

The pattern:

1. **Chaos is cheap** — Spawn multiple attempts in parallel
2. **Filtering is the gate** — Validation, tests, review
3. **The ratchet is the lock** — Merge, close, record

Progress accumulates because validated work is permanent. Failed attempts aren't waste — they're the cost of finding what works.

### Why This Matters for Autonomous Agents

Human developers are expensive. We minimize wasted effort. We plan carefully. We avoid redundant work.

Agent cycles are cheap. Wasted attempts cost milliseconds. The bottleneck isn't compute — it's validation throughput and decision quality.

Traditional development assumes scarcity:
- One developer works one task at a time
- Mistakes are expensive to fix
- We gate work behind planning meetings
- We serialize to avoid conflicts

Agent-driven development assumes abundance:
- Spawn five agents on five approaches
- Let them race to a solution
- Kill the losers, merge the winner
- The cost is negligible

But this only works if you have a ratchet. Without it, chaos is just chaos. With it, chaos becomes a search strategy.

### The Three Components

#### 1. Chaos is Cheap (Spawn Multiple Attempts)

Don't assign one agent to one task. Assign multiple agents to the same task with different constraints.

Example: "Add user authentication"
- Agent A: Uses OAuth
- Agent B: Uses JWT
- Agent C: Uses session tokens

They work in parallel. They don't coordinate. They race.

This feels wasteful to humans. We'd pick one approach, implement it, then switch if it fails. But that's because human time is expensive.

Agent time is not. Spawning three agents costs less than one planning meeting.

The trick: make spawning easy, make isolation automatic, make cleanup instant.

Git worktrees give you free isolation. Each agent gets its own working directory from the same repository. No conflicts. No coordination overhead. When an agent fails, delete its worktree. When an agent succeeds, merge its branch.

#### 2. Filtering is the Gate (Validation, Tests, Review)

The ratchet doesn't click on every push. It clicks when work passes validation.

Validation is your filter. It separates signal from noise. It's the asymmetric gate that allows forward motion but blocks regression.

What counts as validation:

**Automated gates:**
- Tests pass (unit, integration, e2e)
- Linters pass (style, type checking, security)
- Build succeeds (compile, bundle, deploy)
- Performance benchmarks hold (no regressions)

**Manual gates:**
- Code review approval (human or senior agent)
- Security review (for sensitive changes)
- Design review (for architectural changes)

**State-based gates:**
- Issue marked as validated (not just "done")
- PR approved and merged (not just opened)
- Deployment successful (not just pushed)

The key: validation is boolean. Work either passes or it doesn't. No partial credit. No "mostly done."

This is why Factor III (Validation First) matters. If your validation is weak, your ratchet is weak. Garbage passes through. Progress becomes regression.

Strong validation means strong ratcheting. When something merges, you know it's correct. When an issue closes, you know it's complete.

#### 3. The Ratchet is the Lock (Merge, Close, Record)

Once work passes validation, lock it in. Make it permanent. Make it irreversible.

**Protected branches:**
```
main branch protection:
- Require PR approval
- Require status checks (CI)
- Require linear history (no merge commits)
- No force pushes
- No deletions
```

This ensures main is always a valid state. You can't push broken code. You can't rewrite history. Progress accumulates monotonically.

**Issue state locks:**

When an issue transitions to `closed`, it should lock. Reopening requires justification. The default assumption: closed means done.

This prevents thrashing. Agent A closes an issue. Agent B reopens it. Agent A closes it again. Without a lock, you get infinite loops.

With a lock:
- Closed issues require a reason to reopen
- Reopening creates a new issue (or child issue)
- Original work is preserved in history

**Ledger of completions:**

Every merge, every close, every validation success gets recorded. This is your capability ledger.

Example ledger entry:
```json
{
  "timestamp": "2026-02-15T10:30:00Z",
  "agent": "polecat-alpha",
  "action": "merge",
  "pr": "#123",
  "issue": "auth-456",
  "tests_passed": true,
  "review_approved": true,
  "files_changed": 12,
  "lines_added": 340,
  "lines_removed": 120
}
```

This isn't just logging. This is evidence. Evidence that the work happened, that it passed validation, that it's now permanent.

Later, when you audit what changed, you have a chain of custody. When you evaluate agent performance, you have a track record. When you prove ROI, you have receipts.

### The Failure Mode: Thrashing Without a Ratchet

Without ratcheting, you get infinite do-overs.

Agent makes a change. CI fails. Agent reverts. Agent tries again. CI fails differently. Agent reverts. Agent tries a third time.

This is fine for a few iterations. But without a ratchet, there's no forcing function toward success. The agent can thrash forever.

With a ratchet:
- Set a failure budget (e.g., 3 attempts)
- After budget exhausted, escalate (don't retry)
- Successful attempts lock in (can't be undone)

This creates pressure toward learning. If an agent burns its budget, a human (or senior agent) steps in. The work doesn't loop — it escalates.

The same applies to reopening issues. Without a lock, agents reopen closed work based on stale context. With a lock, reopening requires fresh justification.

### The Economic Argument

Traditional development: minimize waste.
- One developer per task
- Careful planning
- Sequential execution

Agent development: minimize time to solution.
- Multiple agents per task
- Minimal planning
- Parallel execution

The question: which is more expensive?

**Scenario A: Traditional**
- 1 developer, 8 hours of work
- 2 hours of planning
- 6 hours of implementation
- Total: 8 human-hours

**Scenario B: Agent Ratchet**
- 5 agents, 1 hour each (parallel)
- 4 agents fail (wasted)
- 1 agent succeeds
- Total: 1 wall-clock hour, 5 agent-hours

Agent-hours are cheap. Wall-clock hours are expensive. If your constraint is time (not compute), the ratchet wins.

The ratchet makes this tractable. Failed agents don't pollute main. Successful agents lock in immediately. No cleanup. No coordination. Just selection pressure.

### Let Agents Be Chaotic

The corollary: don't over-constrain agent behavior.

You don't need perfect prompts. You don't need deterministic execution. You don't need agents to coordinate.

You need:
1. Clear success criteria (validation)
2. Isolated workspaces (worktrees, containers)
3. A ratchet (protected branches, state locks)

Let agents be messy. Let them try dumb approaches. Let them conflict with each other (in separate branches). As long as validation is strong, only the good work merges.

This is freeing. You're not trying to make every agent perfect. You're trying to make the filter perfect. The agents can be 80% accurate, as long as validation catches the 20% of garbage.

### The Anti-Pattern: Reversible Progress

The opposite of ratcheting: allowing validated work to regress.

Examples:

**Force-pushing to main:**
```
git push --force origin main
```

This rewrites history. Validated work disappears. The ratchet breaks. Don't do this.

**Reopening closed issues without reason:**

Agent sees old issue, assumes it's still relevant, reopens it. Now you have duplicate work. The ledger shows the issue closed three times. Chaos.

**Deploying unvalidated code:**

"The tests are slow, let's deploy to production and fix it live."

This skips the ratchet. Now production is in an unknown state. You can't roll back (no validated checkpoint). You're in limbo.

**Merging without CI:**

"CI is broken, but the code looks fine, let's merge."

Now broken code is in main. The ratchet clicked on garbage. Future work builds on a broken foundation. Regression spreads.

### The Discipline: Validate Before You Ratchet

The ratchet is only as good as the validation. If validation is weak, the ratchet locks in garbage.

This is why pre-commit hooks exist. Why CI is required. Why protected branches enforce checks.

The rule: **Never merge without validation. Never close without completion.**

If CI is broken, fix CI. Don't bypass it. If tests are flaky, fix the tests. Don't ignore them. If review is slow, hire more reviewers (or train a review agent). Don't skip it.

The moment you bypass validation "just this once," you've broken the ratchet. And once it breaks, agents learn they can bypass it. The discipline collapses.

### The Ledger as Proof

Every ratchet click is recorded. Every merge, every close, every validation success.

Why this matters:

**Audit trail:**
When something breaks in production, you can trace it to a specific merge. That merge passed validation. So either validation missed something (fix validation), or requirements changed (new issue).

**Performance evaluation:**
Which agents are successful? Which burn through attempts and fail? The ledger shows completion rate, first-time success rate, escalation frequency.

**ROI evidence:**
"How much work did agents complete this quarter?" The ledger has receipts. Merged PRs, closed issues, deployed commits. All validated, all permanent.

**Trust building:**
When a skeptical stakeholder asks "how do we know the agents aren't making things worse?" you show them the ledger. Every change passed validation. Every merge was reviewed. The ratchet enforced quality.

### Parallel Attempts: The Search Strategy

The ratchet enables a powerful search strategy: parallel attempts with selection pressure.

Traditional approach:
- Pick one solution
- Implement it
- Test it
- If it fails, try a different solution

Ratchet approach:
- Spawn five agents with five different solutions
- Let them race
- First to pass validation wins
- Kill the others

This is faster. But it requires isolation (so agents don't conflict) and a ratchet (so only the winner merges).

Example: "Optimize database query performance"

Spawn agents with different strategies:
- Agent A: Add an index
- Agent B: Rewrite the query
- Agent C: Cache the results
- Agent D: Denormalize the schema
- Agent E: Switch to a different database

They work in parallel worktrees. They run benchmarks (validation). First agent to hit the performance target passes validation. That agent's PR merges. The others are abandoned.

Total time: however long the fastest agent takes. Not the sum of all attempts.

The ratchet makes this safe. Failed attempts don't pollute main. Successful attempts lock in immediately.

### The Human Role: Set the Ratchet, Then Step Back

Humans configure the ratchet. Agents operate within it.

Your job:
1. Define validation (what does "passing" mean?)
2. Configure protection (branch rules, required checks)
3. Set failure budgets (how many attempts before escalation?)
4. Monitor the ledger (are agents succeeding?)

Once configured, step back. Let agents thrash. Let them try dumb things. Let them race. The ratchet filters out garbage. Only validated work merges.

This is the autonomy flywheel. The stronger the ratchet, the more chaos you can tolerate. The more chaos you tolerate, the faster you explore solution space. The faster you explore, the quicker you find good solutions. The quicker you find good solutions, the more validated work accumulates.

And validated work is permanent. It ratchets.

### Implementation Patterns

#### Protected Main Branch

```yaml
# .github/branch-protection.yml
main:
  required_status_checks:
    - ci/tests
    - ci/lint
    - ci/security-scan
  required_reviews: 1
  dismiss_stale_reviews: true
  require_linear_history: true
  allow_force_pushes: false
  allow_deletions: false
```

This configuration ensures main is append-only. You can't force-push. You can't delete it. You can only add validated commits.

#### Issue State Lock

```bash
# Closing an issue creates a lock
bd close auth-123 -m "Implemented OAuth, tests pass"

# Reopening requires justification (creates audit trail)
bd reopen auth-123 -m "Regression found in edge case"
# This creates a child issue auth-124 (regression fix)
# Original auth-123 stays closed in the ledger
```

#### Failure Budget Enforcement

```bash
# Agent tries to solve an issue
# .agent-config
failure_budget: 3
escalate_on_budget_exceeded: true

# Agent fails three times
# System auto-escalates:
bd escalate auth-123 -m "Budget exceeded, requires human review"
```

#### Parallel Worktree Spawning

```bash
# Spawn three agents on the same issue
gt polecat spawn agentops auth-123  # Creates polecat-1
gt polecat spawn agentops auth-123  # Creates polecat-2
gt polecat spawn agentops auth-123  # Creates polecat-3

# Each gets isolated worktree
# First to pass validation wins
# Others auto-cleanup on success
```

### The Contract: Immutability After Validation

Once work passes validation and merges:
- Don't rewrite its history
- Don't revert it without reason (and a new issue)
- Don't re-litigate the approach

If it's wrong, that's a new issue. The original work is still valid (it passed validation at the time). Requirements may have changed. Context may have shifted. But the work itself is immutable.

This creates stability. Agents can build on merged work with confidence. It won't disappear. It won't change. It's a stable foundation.

### Anti-Fragility Through Ratcheting

The ratchet makes the system anti-fragile. Chaos strengthens it.

More agents → more attempts → more exploration → higher chance of finding optimal solution.

As long as validation is strong, adding chaos (more agents, more parallel attempts) improves outcomes. The ratchet filters out the bad. Only the good accumulates.

This is the opposite of traditional systems, where more chaos (more developers, more PRs, more changes) creates coordination overhead and integration hell.

The difference: the ratchet. It decouples exploration (chaotic, parallel) from integration (validated, sequential).

## What Good Looks Like

### Strong Ratcheting

**Protected main branch:**
- No direct pushes
- Require CI success
- Require review approval
- Linear history enforced
- Force-push disabled

**Issue state locks:**
- Closed issues require justification to reopen
- Reopening creates audit trail
- Original completion preserved in ledger

**Validation gates:**
- Tests required (100% of the time)
- Linting required (no exceptions)
- Security scans required (for deps, secrets)
- Review required (human or agent)

**Failure budgets:**
- Max attempts per agent (e.g., 3)
- Auto-escalate on budget exhaustion
- No infinite retry loops

**Ledger of completions:**
- Every merge recorded (timestamp, agent, files, tests)
- Every close recorded (issue, reason, validator)
- Queryable history (who did what when)

### Chaos as a Feature

**Parallel attempts encouraged:**
- Multiple agents on the same issue
- Isolated worktrees (no conflicts)
- First to validate wins
- Losers auto-cleanup

**Failure is cheap:**
- Failed attempts discarded (no merge)
- No stigma for trying
- Failure budget prevents infinite loops

**Exploration rewarded:**
- Novel approaches get equal chance
- Validation is the judge (not planning committees)
- Speed to validation beats "correctness" of approach

### Immutable Progress

**Merged code stays merged:**
- Revert only for critical bugs
- Reverts are new commits (not history rewrites)
- Revert requires issue and justification

**Closed issues stay closed:**
- Reopening is rare
- Reopening creates child issue
- Original completion preserved

**Ledger is append-only:**
- No deleting history
- No editing past records
- Immutable audit trail

### Observable Ratcheting

**Dashboard shows:**
- Validation success rate (how often first attempt succeeds)
- Merge velocity (time from PR open to merge)
- Failure budget utilization (how many retries before escalation)
- Issue churn (reopen rate, thrashing rate)

**Alerts trigger on:**
- Force-push attempts (blocked, but flagged)
- High reopen rate (suggests weak validation)
- High failure budget exhaustion (suggests bad prompts or hard problems)

**Metrics prove ratcheting works:**
- Main is always green (CI passes)
- Issue reopen rate < 5%
- Time-to-merge decreasing (validation getting faster)
- Agent success rate increasing (learning from ledger)

### The Flywheel Spins

More chaos → more attempts → more learning → better validation → stronger ratchet → tolerate more chaos.

The system gets better over time. Early on, validation is weak, so you constrain chaos (few agents, careful prompting). As validation strengthens, you unleash chaos (many agents, loose prompting). The ratchet handles it.

Eventually, you reach a state where agent quality doesn't matter. Validation is so strong that even bad agents can't pollute main. Only good work merges. The ratchet is absolute.

That's the goal. A system where adding more agents (even mediocre ones) improves outcomes, because the filter is perfect.

---

**Lock progress forward. Let chaos explore. Let validation filter. Let the ratchet click.**

Once work is validated, it's permanent. Build on it. Trust it. Move forward.

The ratchet only turns one way.
