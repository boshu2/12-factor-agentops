# Validate Before You Ship

<div align="center">

**The complete operational discipline for working with AI agents**

*Research, plan, implement, validate, extract, compound.*

</div>

---

<div align="center">

## The Operational Discipline Workflow

</div>

<table>
<tr>
<td align="center" width="16%">

**1. Research**

Understand

</td>
<td align="center" width="3%">-></td>
<td align="center" width="16%">

**2. Plan**

Anticipate Failures

</td>
<td align="center" width="3%">-></td>
<td align="center" width="16%">

**3. Implement**

Build

</td>
<td align="center" width="3%">-></td>
<td align="center" width="16%">

**4. Validate**

Verify Externally

</td>
<td align="center" width="3%">-></td>
<td align="center" width="16%">

**5. Extract**

Learn

</td>
<td align="center" width="3%">-></td>
<td align="center" width="12%">

**6. Compound**

Grow

</td>
</tr>
</table>

<div align="center">

*Validation built in, not bolted on.*

</div>

---

## Why This Matters

<table>
<tr>
<th width="45%">Ad-Hoc Agent Usage</th>
<th width="10%"></th>
<th width="45%">Operational Discipline</th>
</tr>
<tr>
<td align="center">Write code -> Ship -> CI catches problems -> Fix -> Repeat</td>
<td align="center">vs</td>
<td align="center">/research -> /pre-mortem -> /implement -> /vibe -> Commit -> /retro -> Compound</td>
</tr>
<tr>
<td align="center">Problems found AFTER shipping</td>
<td align="center">vs</td>
<td align="center">Problems caught BEFORE committing</td>
</tr>
<tr>
<td align="center">Expensive rework</td>
<td align="center">vs</td>
<td align="center">Early course correction</td>
</tr>
<tr>
<td align="center">Isolated sessions, no memory</td>
<td align="center">vs</td>
<td align="center">Knowledge that compounds across sessions</td>
</tr>
</table>

**The 80/20 reality:** AI-generated code is valuable. The 80% that works saves enormous time. The 20% that doesn't can be catastrophic. An operational discipline catches the 20% before it ships and turns every session into fuel for the next one.

---

## Step 1: Research Before You Build (Factor IV)

**Purpose:** Understand the codebase before making changes. This is Factor IV: Research Before You Build.

<table>
<tr>
<td width="70%">

```
> /research auth flow

Loading context...

Stack: Next.js 14 + Prisma + PostgreSQL

Current Implementation:
- NextAuth.js with database sessions
- OAuth: Google, GitHub
- Middleware protection on /dashboard/*

Key Files:
- src/app/api/auth/[...nextauth]/route.ts
- src/middleware.ts
- prisma/schema.prisma (User, Account, Session)

Research bundle saved: .agents/ao/bundles/research-auth-001.md
12K tokens -> 3K compressed
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Explore relevant code
- Document current state
- Identify key files
- Compress to bundle

<br/>

**Factor IV in action:**

Understanding before acting prevents working on the wrong thing entirely.

</td>
</tr>
</table>

### Key Practices

1. **Use /research BEFORE implementing** - Never assume you know the codebase
2. **Let it create bundles** - Compressed context persists across sessions (Factor I: Context Is Everything)
3. **Verify the summary** - Make sure it captured the right things
4. **Ask clarifying questions** - "What patterns does this codebase use for X?"

---

## Step 2: Plan and Simulate Failures (Factor IV continued)

**Purpose:** Simulate failures before you build. Find the problems before they find you. The /pre-mortem skill extends research into risk anticipation.

<table>
<tr>
<td width="70%">

```
> /pre-mortem adding rate limiting to our API

Simulating failures for: API Rate Limiting Implementation

Potential Failure Modes:

1. CACHE INVALIDATION (HIGH RISK)
   - What: Redis connection fails mid-request
   - Impact: Either all requests blocked or none limited
   - Mitigation: Fallback to in-memory with degraded limits

2. CONFIGURATION DRIFT (MEDIUM RISK)
   - What: Different rate limits in dev vs prod
   - Impact: Works in dev, breaks in prod
   - Mitigation: Environment-aware config validation

3. DISTRIBUTED COUNTER RACE (MEDIUM RISK)
   - What: Multiple instances increment independently
   - Impact: Limits bypassed by factor of N instances
   - Mitigation: Redis INCR with EXPIRE atomicity

4. BYPASS VECTORS (HIGH RISK)
   - What: Rate limit applied after auth but before route
   - Impact: Unauthenticated endpoints unprotected
   - Mitigation: Middleware ordering audit

Required Checkpoints:
[ ] Fallback behavior tested
[ ] Config validated across environments
[ ] Atomic operations verified
[ ] Middleware ordering confirmed

Pre-mortem saved: .agents/ao/pre-mortems/rate-limiting-001.md
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Simulate failure modes
- Identify risks BEFORE building
- Create mitigation plan
- Define validation checkpoints

<br/>

**Why it matters:**

The cheapest time to find a bug is before you write the code that contains it.

<br/>

**Pre-mortem vs Post-mortem:**

Post-mortem: "What went wrong?"
Pre-mortem: "What COULD go wrong?"

</td>
</tr>
</table>

### Key Practices

1. **Run BEFORE implementation** - Research first, then anticipate failures
2. **Take the risks seriously** - If it identifies a HIGH risk, address it in your plan
3. **Create checkpoints** - These become your validation gates for Factor V
4. **Review with the team** - Pre-mortems surface assumptions worth discussing

---

## Step 3: Validate Externally Before Every Commit (Factor V)

**Purpose:** Validate that your implementation does what you intended using external checks, not just the agent's self-assessment. This is Factor V: Validate Externally.

<table>
<tr>
<td width="70%">

```
> /vibe

Running vibe check...

Changes since last commit:
- src/middleware/rate-limiter.ts (new)
- src/lib/redis.ts (modified)
- tests/rate-limiter.test.ts (new)

Checking against pre-mortem checkpoints:

[X] Fallback behavior tested
    - Line 45: graceful degradation to in-memory
    - Tests cover Redis failure scenario

[X] Config validated across environments
    - Using RATE_LIMIT_* env vars
    - Default values in config schema

[X] Atomic operations verified
    - Line 28: Using INCR with EXPIRE pipeline
    - No race condition in counter logic

[ ] Middleware ordering confirmed
    - WARNING: Rate limiter runs AFTER auth middleware
    - Unauthenticated routes may be unprotected

Vibe Check Result: NEEDS ATTENTION

Recommendation:
Move rate limiter BEFORE auth middleware, or add explicit
rate limiting to unauthenticated routes (/api/health, /api/public/*).
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Review changes against intent
- Check pre-mortem mitigations
- Verify implementation matches plan
- Flag issues BEFORE commit

<br/>

**This is NOT a linter:**

/vibe checks semantic correctness -- does the code do what you intended? Not just syntax, but meaning.

<br/>

**Vibe check levels:**

- PASSING: Safe to commit
- NEEDS ATTENTION: Fix first
- FAILING: Do not commit

</td>
</tr>
</table>

### Key Practices

1. **Run BEFORE every commit** - Make it a habit, like `git status`
2. **Fix NEEDS ATTENTION items** - Don't commit with warnings
3. **Re-run after fixes** - Verify your fix addressed the issue
4. **Trust but verify** - /vibe catches things, but you're still responsible

### After Fixing

```
> /vibe

Rechecking changes...

[X] Middleware ordering confirmed
    - Line 12: Rate limiter now runs first in middleware chain
    - Unauthenticated routes explicitly rate-limited

Vibe Check Result: PASSING

Safe to commit.
```

---

## Step 4: Lock Progress Forward (Factor VI)

**Purpose:** Once validation passes, commit immediately. Each validated commit becomes a safe checkpoint you can return to. This is Factor VI: Lock Progress Forward.

Every passing /vibe check should result in an immediate commit. Small, validated commits create a trail of known-good states. If something breaks later, you know exactly where to roll back to.

### Key Practices

1. **Commit after every passing /vibe** - Don't batch multiple changes
2. **Use descriptive commit messages** - Future sessions load this context
3. **Everything in git** - Progress files, research bundles, learnings (Factor II: Track Everything in Git)
4. **Never skip the commit** - An uncommitted validation is a lost checkpoint

---

## Step 5: Extract Learnings (Factor VII)

**Purpose:** Close the loop. Extract what worked so future sessions benefit. This is Factor VII: Extract Learnings.

<table>
<tr>
<td width="70%">

```
> /retro

Retrospective: Rate Limiting Implementation

Session Summary:
- Duration: 45 minutes
- Commits: 3
- Pre-mortem risks addressed: 4/4

What Worked Well:
+ Pre-mortem identified middleware ordering issue BEFORE it hit prod
+ Redis pipeline pattern worked first try (no race conditions)
+ Fallback to in-memory tested and working

What Could Improve:
- Should have checked middleware ordering in research phase
- Could have used existing rate limiter package instead of custom

Patterns Extracted:

PATTERN: Redis Atomic Operations
  Problem: Distributed counters with race conditions
  Solution: Use INCR + EXPIRE pipeline, not GET/SET
  Evidence: No race conditions in load testing

ANTI-PATTERN: Middleware Ordering Assumption
  Problem: Assumed auth middleware was first
  Prevention: Always audit middleware chain in /research

Learnings saved: .agents/ao/learnings/rate-limiting-001.md
Flywheel updated: 2 patterns, 1 anti-pattern
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Review what worked
- Note what didn't
- Extract reusable patterns
- Feed the knowledge flywheel

<br/>

**Patterns vs Anti-Patterns:**

Patterns: "Do this again"
Anti-Patterns: "Don't do this again"

Both are valuable learnings.

<br/>

**Why it matters:**

Without /retro, every session starts from zero. With /retro, knowledge compounds.

</td>
</tr>
</table>

### Key Practices

1. **Run at end of every significant session** - Not just at feature completion
2. **Be honest about what didn't work** - Anti-patterns are as valuable as patterns
3. **Keep patterns specific** - "Redis atomic operations" not "good Redis usage"
4. **Review extracted learnings** - Promote good ones, reject noise

---

## Step 6: Compound Knowledge (Factor VIII)

**Purpose:** Make every session build on the last. This is Factor VIII: Compound Knowledge (HERO) -- Harvest, Extract, Refine, Operationalize.

<table>
<tr>
<td width="70%">

```
> /flywheel status

Knowledge Flywheel Status

Pool Statistics:
  Pending: 3 candidates
  Staged: 2 awaiting promotion
  Promoted: 47 active learnings
  Rejected: 12 (filtered noise)

Health Metrics:
  Extraction rate: 1.2 learnings/session
  Decay rate: 0.1 learnings/week
  Velocity: +1.1 (compounding!)

Top Learnings (by citation):
  1. Redis atomic operations (12 citations)
  2. Middleware ordering audit (8 citations)
  3. 40% context rule (7 citations)

Recent Activity:
  Today: +2 patterns from rate-limiting session
  This week: +5 learnings, -1 decay

Flywheel Health: HEALTHY (velocity > decay)
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Track knowledge accumulation
- Monitor extraction vs decay
- Identify most-used learnings
- Ensure healthy compounding

<br/>

**Escape Velocity:**

When extraction rate > decay rate, knowledge compounds exponentially.

This is the moat.

<br/>

**The HERO Cycle:**

Harvest -> Extract -> Refine -> Operationalize
   ^                                   |
   |___________________________________|

</td>
</tr>
</table>

### Managing the Pool

```
> /flywheel pool list --tier=pending

Pending Candidates (3):

1. [L-2024-0147] "Always test fallback paths"
   Source: rate-limiting session
   Confidence: 0.7
   Action: /flywheel promote L-2024-0147

2. [L-2024-0148] "Redis is fast"
   Source: rate-limiting session
   Confidence: 0.4
   Action: /flywheel reject L-2024-0148 --reason "too generic"

3. [L-2024-0149] "Check middleware ordering early"
   Source: rate-limiting session
   Confidence: 0.85
   Action: /flywheel promote L-2024-0149
```

### Key Practices

1. **Check flywheel status weekly** - Ensure it's healthy
2. **Promote good learnings** - They become injection candidates
3. **Reject noise aggressively** - "Redis is fast" doesn't help future sessions
4. **Watch for decay** - If velocity goes negative, you're losing knowledge

---

## Putting It All Together

<div align="center">

### The Complete Operational Discipline

</div>

<table>
<tr>
<th>Step</th>
<th>Command</th>
<th>Factor</th>
<th>What It Catches</th>
<th>When</th>
</tr>
<tr>
<td><strong>1</strong></td>
<td><code>/research</code></td>
<td>IV. Research Before You Build</td>
<td>Working on the wrong thing</td>
<td>Before planning</td>
</tr>
<tr>
<td><strong>2</strong></td>
<td><code>/pre-mortem</code></td>
<td>IV. Research Before You Build</td>
<td>Problems before they exist</td>
<td>Before implementing</td>
</tr>
<tr>
<td><strong>3</strong></td>
<td><code>/vibe</code></td>
<td>V. Validate Externally</td>
<td>Implementation doesn't match intent</td>
<td>Before every commit</td>
</tr>
<tr>
<td><strong>4</strong></td>
<td><code>/retro</code></td>
<td>VII. Extract Learnings</td>
<td>Lost learnings</td>
<td>After significant work</td>
</tr>
<tr>
<td><strong>5</strong></td>
<td><code>/post-mortem</code></td>
<td>XII. Harvest Failures as Wisdom</td>
<td>Repeated mistakes</td>
<td>After failures</td>
</tr>
<tr>
<td><strong>6</strong></td>
<td><code>/flywheel</code></td>
<td>VIII. Compound Knowledge</td>
<td>Knowledge decay</td>
<td>Weekly check-in</td>
</tr>
</table>

---

## Common Questions

### "Isn't this overkill for small changes?"

For a one-line typo fix? Yes. Skip it.

For anything that touches logic, adds features, or changes behavior? No. The cost of /pre-mortem (2 minutes) is always less than the cost of fixing a production bug (2 hours minimum).

### "What if /pre-mortem finds no risks?"

That's fine! It means either:
1. The change is genuinely simple (good)
2. You're missing something (run /research first)

Simple changes with no risks are fast to implement with confidence.

### "How do I know /vibe is working?"

Check your metrics over time (Factor IX: Measure What Matters):
- Trust pass rate should increase
- Rework ratio should decrease
- Fewer "oops" commits fixing previous commits

If these aren't improving, you might be ignoring /vibe warnings.

### "The flywheel seems complex. Is it worth it?"

For a single session? Probably not.
For a codebase you'll work on for months? Absolutely.

The flywheel benefit is compound. Session 1 feels the same. Session 50 feels like magic. This is what separates ad-hoc agent usage from a real operational discipline.

---

## Quick Reference Card

<table>
<tr>
<td width="50%">

### Before You Build
```
/research <topic>     # Understand first (Factor IV)
/pre-mortem <plan>    # Simulate failures (Factor IV)
```

</td>
<td width="50%">

### Before You Commit
```
/vibe                 # Validate externally (Factor V)
# Fix any warnings
/vibe                 # Confirm fix
git commit            # Lock progress (Factor VI)
```

</td>
</tr>
<tr>
<td width="50%">

### After You Ship
```
/retro                # Extract learnings (Factor VII)
/flywheel promote     # Compound knowledge (Factor VIII)
```

</td>
<td width="50%">

### Weekly Maintenance
```
/flywheel status      # Check health
/flywheel pool list   # Clear backlog
# Review metrics      # Factor IX
```

</td>
</tr>
</table>

---

## Related Resources

- [The Workflow Guide](workflow-guide.md) - Complete session workflow
- [Failure Patterns](../reference/failure-patterns.md) - What validation catches
- [Quick Start](../getting-started/quick-start.md) - Get started in 15 minutes
- [12-Factor AgentOps](https://github.com/boshu2/12-factor-agentops) - The operational discipline for working with AI agents

---

<div align="center">

**Catch it before you ship it.**

/research -> /pre-mortem -> /implement -> /vibe -> Commit -> /retro -> Compound

*Every cycle validates. Every session compounds.*

</div>
