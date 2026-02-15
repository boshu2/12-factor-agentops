# The Workflow

<div align="center">

**The complete operational discipline session from start to finish**

*Day 5 agents inherit everything Day 1 agents discovered.*

</div>

---

<div align="center">

## The Complete Operational Discipline Flow

</div>

<table>
<tr>
<td align="center" width="14%">

**Start**

Load Context

</td>
<td align="center" width="3%">-></td>
<td align="center" width="14%">

**Research**

Understand

</td>
<td align="center" width="3%">-></td>
<td align="center" width="14%">

**Plan**

Anticipate

</td>
<td align="center" width="3%">-></td>
<td align="center" width="14%">

**Implement**

Build + Validate

</td>
<td align="center" width="3%">-></td>
<td align="center" width="14%">

**Extract**

Learn

</td>
<td align="center" width="3%">-></td>
<td align="center" width="14%">

**End**

Lock Progress

</td>
</tr>
</table>

<div align="center">

*Context high? End session, resume fresh. Knowledge persists.*

</div>

---

<div align="center">

## Before and After

</div>

<table>
<tr>
<th width="40%">Without Operational Discipline</th>
<th width="20%"></th>
<th width="40%">With the Workflow</th>
</tr>
<tr>
<td align="center"><strong>Every session</strong></td>
<td align="center">-></td>
<td align="center"><strong>Day 1 only</strong></td>
</tr>
<tr>
<td align="center">Start from zero</td>
<td align="center">-></td>
<td align="center">Resume where you left off</td>
</tr>
<tr>
<td align="center"><strong>100%</strong></td>
<td align="center">-></td>
<td align="center"><strong>0%</strong></td>
</tr>
<tr>
<td align="center">Re-research same problems</td>
<td align="center">-></td>
<td align="center">Load compressed bundles</td>
</tr>
<tr>
<td align="center"><strong>Lost</strong></td>
<td align="center">-></td>
<td align="center"><strong>Persisted</strong></td>
</tr>
<tr>
<td align="center">Context between sessions</td>
<td align="center">-></td>
<td align="center">State files track everything in git</td>
</tr>
<tr>
<td align="center"><strong>Linear</strong></td>
<td align="center">-></td>
<td align="center"><strong>Compound</strong></td>
</tr>
<tr>
<td align="center">Same speed forever</td>
<td align="center">-></td>
<td align="center">Day 10 is 10x faster</td>
</tr>
</table>

---

<div align="center">

## The 5 Metrics (Factor IX: Measure What Matters)

</div>

<table>
<tr>
<td align="center" width="20%">

**Trust Pass**
% steps that validate
on first try

</td>
<td align="center" width="20%">

**Rework Ratio**
% time fixing
vs building

</td>
<td align="center" width="20%">

**Velocity**
Validated steps
per hour

</td>
<td align="center" width="20%">

**Debug Spirals**
Fix chains
>3 commits

</td>
<td align="center" width="20%">

**Flow Efficiency**
% time in
productive work

</td>
</tr>
</table>

<div align="center">

*Captured at session-start (baseline) and session-end (delta)*

</div>

---

<div align="center">

## Example: Adding Auth to a Web App

*Follow along as we implement a feature across two sessions using the full operational discipline*

</div>

---

<table>
<tr>
<td width="100%">

### Session Start (Factor I: Context Is Everything)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-start

Context: my-webapp
Incomplete: AUTH-001, AUTH-002
Last session: Set up project structure
Next: AUTH-001 (User login flow)

What Vibe Level? (0-5)
```

```
> Level 2 - new feature with complexity

Capturing baseline (vibe-check)...
   Trust Pass Rate: 87% (last 7 days)
   Rework Ratio: 12%
   Avg Velocity: 4.2/hr

Ready to proceed.
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Load progress files
- Show incomplete work
- Set verification level
- Capture baseline metrics
- Ready to work

<br/>

**Factor I:** Context loaded from git-tracked state files. No starting from zero.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Research (Factor IV: Research Before You Build)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /research

Topic: User authentication
   Loading context JIT...

Stack: Next.js 14 + Prisma + PostgreSQL

+-------------+------------------+-----------------+
| Option      | Pros             | Cons            |
+-------------+------------------+-----------------+
| NextAuth.js | Built for Next   | Abstraction     |
| Lucia Auth  | Full control     | More setup      |
| Custom JWT  | Complete control | Security risk   |
+-------------+------------------+-----------------+

Recommendation: NextAuth.js

Bundle saved: research-auth-001.md
   12K tokens -> 3K compressed
```

```
> Google + GitHub OAuth. Database sessions.

Updated. Ready for /plan
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Explore approaches
- Document trade-offs
- Get user input
- Compress to bundle

<br/>

**Output:**
Research bundle (5:1 compression ratio). Future sessions load this instead of re-exploring.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Plan (Factor IV continued + Factor V: Validate Externally)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /plan

Loading research bundle...

Steps:
1. Install deps      -> validate: no conflicts
2. Prisma schema     -> validate: db push works
3. Auth config       -> validate: endpoints respond
4. Session provider  -> validate: hook works
5. Login UI          -> validate: can sign in/out
6. Route protection  -> validate: redirects work

Human checkpoint: Review auth config (step 3)

Bundle saved: plan-auth-001.md
```

```
> Approved. Let's implement.
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Load research
- Define steps with validation gates
- Each step has external validation criteria
- Mark human checkpoints
- Compress to bundle

<br/>

**Output:**
Plan with 6 validated steps. Every step has a concrete way to verify it worked -- not just "looks right."

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Implement (Factor V: Validate Externally + Factor VI: Lock Progress Forward)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /implement

Loading plan...

Step 1: npm install next-auth @auth/prisma-adapter
        Validated. Committed.

Step 2: Update prisma/schema.prisma
        Validated. Committed.

Step 3: Human checkpoint
        Review auth config?
```

```
> Approved
```

```
        Validated. Committed.

Step 4: Add SessionProvider
        Validated. Committed.

Step 5: Create login components
        Validated. Committed.

Context: 52% (above 40% threshold)
   Recommend: /session-end now
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Execute each step
- Validate externally after each (Factor V)
- Commit immediately on pass (Factor VI)
- Human approval at checkpoints
- Monitor context usage

<br/>

**Context warning!**
Above 40% threshold.
Time to save and resume fresh. Quality degrades as context fills.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Session End -- Mid-Feature (Factor II: Track Everything in Git)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-end

Ending Session

Completed: Steps 1-5
Remaining: Step 6 (route protection)
Context: 52%
Commits: 5

Session vibe-check:
   Trust Pass: 100% (5/5 steps validated)
   Rework: 0%
   Velocity: 6.7/hr
   Spirals: 0

Updating progress state...
  working_on: "AUTH-001: Step 6 remaining"

State saved to git.

Run /retro? > Not yet, finishing first
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Check git status
- Run vibe-check delta
- Update progress files
- Save state to git
- Ready for resume

<br/>

**Why stop at 52%?**
Context above 40% degrades quality. A fresh session produces better results than pushing through a stale one.

</td>
</tr>
</table>

---

<div align="center">

### Next Day

</div>

---

<table>
<tr>
<td width="100%">

### Session Resume (Factor I: Context Is Everything)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-resume

Resuming: AUTH-001
   Progress: Steps 1-5 done
   Remaining: Step 6

Loading bundles...
   plan-auth-001.md loaded

Context: 8% (fresh!)

Last commit: "feat(auth): add login components"

Pick up at Step 6?
```

```
> Yes
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Load progress state from git
- Load compressed bundles
- Show where we left off
- Fresh 8% context

<br/>

**The magic:**
Yesterday's 52% becomes today's 8%. All context preserved in bundles. This is Factor I in action.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Implement Continued (Factor V + Factor VI)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
Step 6: Create middleware.ts
        Route protection for /dashboard/*

Testing...
  /dashboard (no auth) -> /login PASS
  /dashboard (auth)    -> renders PASS

Validated. Committed.

AUTH-001 Complete!
```

```
> /session-end
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Finish remaining step
- Validate behavior externally
- Commit with context (Factor VI)

<br/>

**Result:**
Feature complete in 2 sessions.
Full context preserved across the boundary.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Session End -- Feature Complete (Factor IX: Measure What Matters)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-end

Session Complete

AUTH-001: PASSED
Commits: 6 total (5 + 1)
Sessions: 2

Feature vibe-check (both sessions):
   Trust Pass: 100%  (up from 87% baseline)
   Rework: 5%        (down from 12% baseline)
   Velocity: 5.8/hr  (up from 4.2/hr)
   Spirals: 0

State saved.

Run /retro? > Yes
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Mark feature complete
- Compare to baseline
- Quantify improvement
- Ready for retrospective

<br/>

**Factor IX:** Concrete metrics prove the discipline works. Not vibes about vibes -- numbers.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Retro (Factor VII: Extract Learnings)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /retro

AUTH-001 Retrospective

What worked:
+ Research caught JWT vs DB sessions early
+ Human checkpoint on auth config
+ Session split at 40% context

What didn't:
- Missed adapter version requirement
- Could have used tracer test

Patterns found:
  OAuth config with database adapter
  Middleware route protection
  Session split at 40%

vibe-check summary:
+----------------+----------+---------+--------+
| Metric         | Baseline | Actual  | Delta  |
+----------------+----------+---------+--------+
| Trust Pass     | 87%      | 100%    | +13%   |
| Rework Ratio   | 12%      | 5%      | -7%    |
| Velocity       | 4.2/hr   | 5.8/hr  | +38%   |
| Debug Spirals  | 0.3/day  | 0       | clean  |
| Flow Efficiency| 71%      | 89%     | +18%   |
+----------------+----------+---------+--------+

Save learnings? > Yes
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Review what worked
- Note what didn't
- Identify patterns
- Compare vibe metrics

<br/>

**Why retro?**
Patterns extracted here become shortcuts later. The vibe-check proves the discipline worked with real numbers.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%">

### Compound Knowledge (Factor VIII: Compound Knowledge -- HERO)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /flywheel status

Extracting Patterns (HERO cycle)

Harvest: 3 candidates from retro
Extract: Filtering noise...

Pattern 1: NextAuth Database Sessions
  Problem: Secure auth for Next.js
  Solution: PrismaAdapter + database strategy
  Evidence: AUTH-001, 100% success

Pattern 2: Middleware Route Protection
  Problem: Protect routes without per-page checks
  Solution: matcher config in middleware.ts
  Evidence: Cleaner than alternatives

Anti-pattern: Version Assumption
  Problem: Assumed adapter worked with v4
  Prevention: Check compatibility in research

Refine: 2 patterns promoted, 1 anti-pattern logged
Operationalize: Injected into knowledge base

Saved to learnings pool.
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

- Harvest candidates from retro
- Extract reusable patterns
- Refine by filtering noise
- Operationalize into knowledge base

<br/>

**The payoff:**
Next auth feature loads these patterns automatically. The HERO cycle (Harvest, Extract, Refine, Operationalize) turns one-time work into permanent knowledge.

</td>
</tr>
</table>

---

<div align="center">

## The Compounding Effect

</div>

<table>
<tr>
<th>Feature</th>
<th>Research</th>
<th>Plan</th>
<th>Implement</th>
<th>Total</th>
</tr>
<tr>
<td><strong>1</strong></td>
<td>Full</td>
<td>Full</td>
<td>Full</td>
<td>~2 hours</td>
</tr>
<tr>
<td><strong>2</strong></td>
<td>Load patterns</td>
<td>Adapt</td>
<td>Full</td>
<td>~1 hour</td>
</tr>
<tr>
<td><strong>5</strong></td>
<td>Skip</td>
<td>Quick</td>
<td>Full</td>
<td>~30 min</td>
</tr>
<tr>
<td><strong>10</strong></td>
<td>Skip</td>
<td>Skip</td>
<td>Pattern</td>
<td>~10 min</td>
</tr>
</table>

<div align="center">

*Each feature makes the next one faster. This is the operational discipline working.*

</div>

---

<div align="center">

## Quick Reference

</div>

<table>
<tr>
<th>Command</th>
<th>When</th>
<th>Factor</th>
<th>What</th>
</tr>
<tr><td><code>/session-start</code></td><td>Beginning</td><td>I. Context Is Everything</td><td>Load state, capture baseline</td></tr>
<tr><td><code>/research</code></td><td>New problem</td><td>IV. Research Before You Build</td><td>Explore, compress to bundle</td></tr>
<tr><td><code>/plan</code></td><td>After research</td><td>IV. Research Before You Build</td><td>Design steps with validation gates</td></tr>
<tr><td><code>/pre-mortem</code></td><td>Before implementing</td><td>IV. Research Before You Build</td><td>Simulate failures, define checkpoints</td></tr>
<tr><td><code>/implement</code></td><td>After approval</td><td>V. Validate Externally</td><td>Execute + validate each step</td></tr>
<tr><td><code>/vibe</code></td><td>Before every commit</td><td>V. Validate Externally</td><td>Semantic validation of changes</td></tr>
<tr><td><code>/session-end</code></td><td>Context high or done</td><td>VI. Lock Progress Forward</td><td>Save state, capture delta</td></tr>
<tr><td><code>/session-resume</code></td><td>Continuing work</td><td>I. Context Is Everything</td><td>Load bundles, resume fresh</td></tr>
<tr><td><code>/retro</code></td><td>Feature done</td><td>VII. Extract Learnings</td><td>Review + extract patterns</td></tr>
<tr><td><code>/post-mortem</code></td><td>After failures</td><td>XII. Harvest Failures as Wisdom</td><td>Turn failures into prevention</td></tr>
<tr><td><code>/flywheel</code></td><td>After retro</td><td>VIII. Compound Knowledge</td><td>HERO cycle: promote learnings</td></tr>
</table>

---

## Related Resources

- [Validate Before You Ship](validate-before-you-ship.md) - Deep dive on the validation workflow
- [Failure Patterns](../reference/failure-patterns.md) - What validation catches
- [Quick Start](../getting-started/quick-start.md) - Get started in 15 minutes

---

<div align="center">

**Start -> Research -> Plan -> Implement -> Validate -> Extract -> Compound**

*Every cycle validates. Every session compounds. This is the operational discipline.*

</div>
