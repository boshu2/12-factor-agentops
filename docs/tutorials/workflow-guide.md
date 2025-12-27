# The Workflow

<div align="center">

**A complete Claude Code session from start to finish**

*Day 5 agents inherit everything Day 1 agents discovered.*

</div>

---

<div align="center">

## The Complete Flow

</div>

<table>
<tr>
<td align="center" width="16%">

**🚀**
**Start**

</td>
<td align="center" width="4%">→</td>
<td align="center" width="16%">

**📚**
**Research**

</td>
<td align="center" width="4%">→</td>
<td align="center" width="16%">

**📋**
**Plan**

</td>
<td align="center" width="4%">→</td>
<td align="center" width="16%">

**⚡**
**Implement**

</td>
<td align="center" width="4%">→</td>
<td align="center" width="16%">

**🏁**
**End**

</td>
</tr>
</table>

<div align="center">

↓ *context high?* ↓

**🔄 Resume** → continue → **🔍 Retro** → **🧠 Learn**

</div>

---

<div align="center">

## Before & After

</div>

<table>
<tr>
<th width="40%">Without Session Management</th>
<th width="20%"></th>
<th width="40%">With the Workflow</th>
</tr>
<tr>
<td align="center"><strong>Every day</strong></td>
<td align="center">→</td>
<td align="center"><strong>Day 1 only</strong></td>
</tr>
<tr>
<td align="center">Start from zero</td>
<td align="center">→</td>
<td align="center">Resume where you left off</td>
</tr>
<tr>
<td align="center"><strong>100%</strong></td>
<td align="center">→</td>
<td align="center"><strong>0%</strong></td>
</tr>
<tr>
<td align="center">Re-research same problems</td>
<td align="center">→</td>
<td align="center">Load compressed bundles</td>
</tr>
<tr>
<td align="center"><strong>Lost</strong></td>
<td align="center">→</td>
<td align="center"><strong>Persisted</strong></td>
</tr>
<tr>
<td align="center">Context between sessions</td>
<td align="center">→</td>
<td align="center">State files track everything</td>
</tr>
<tr>
<td align="center"><strong>Linear</strong></td>
<td align="center">→</td>
<td align="center"><strong>Compound</strong></td>
</tr>
<tr>
<td align="center">Same speed forever</td>
<td align="center">→</td>
<td align="center">Day 10 is 10x faster</td>
</tr>
</table>

---

<div align="center">

## vibe-check: The 5 Metrics

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

*Follow along as we implement a feature across two sessions*

</div>

---

<table>
<tr>
<td width="100%" bgcolor="#1a1a2e">

### 🚀 Session Start

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-start

📂 Context: my-webapp
📋 Incomplete: AUTH-001, AUTH-002
📝 Last session: Set up project structure
🎯 Next: AUTH-001 (User login flow)

🎯 What Vibe Level? (0-5)
```

```
> Level 2 - new feature with complexity

📊 Capturing baseline (vibe-check)...
   Trust Pass Rate: 87% (last 7 days)
   Rework Ratio: 12%
   Avg Velocity: 4.2/hr

Ready to proceed.
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Load progress files
✓ Show incomplete work
✓ Set verification level
✓ Capture vibe-check baseline
✓ Ready to work

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#1e3a5f">

### 📚 Research

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /research

🔍 Topic: User authentication
   Loading context JIT...

Stack: Next.js 14 + Prisma + PostgreSQL

┌─────────────┬──────────────────┬─────────────────┐
│ Option      │ Pros             │ Cons            │
├─────────────┼──────────────────┼─────────────────┤
│ NextAuth.js │ Built for Next   │ Abstraction     │
│ Lucia Auth  │ Full control     │ More setup      │
│ Custom JWT  │ Complete control │ Security risk   │
└─────────────┴──────────────────┴─────────────────┘

Recommendation: NextAuth.js

💾 Bundle saved: research-auth-001.md
   12K tokens → 3K compressed
```

```
> Google + GitHub OAuth. Database sessions.

Updated. Ready for /plan
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Explore approaches
✓ Document trade-offs
✓ Get user input
✓ Compress to bundle

<br/>

**Output:**
Research bundle (5:1 compression)

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#1e5f3a">

### 📋 Plan

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /plan

📋 Loading research bundle...

Steps:
1. Install deps      → validate: no conflicts
2. Prisma schema     → validate: db push works
3. Auth config       → validate: endpoints respond
4. Session provider  → validate: hook works
5. Login UI          → validate: can sign in/out
6. Route protection  → validate: redirects work

⚠️ Human checkpoint: Review auth config (step 3)

💾 Bundle saved: plan-auth-001.md
```

```
> Approved. Let's implement.
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Load research
✓ Define steps
✓ Add validation gates
✓ Mark human checkpoints
✓ Compress to bundle

<br/>

**Output:**
Plan with 6 validated steps

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#5f3a1e">

### ⚡ Implement

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
        ✅ Committed

Step 2: Update prisma/schema.prisma
        ✅ Committed

Step 3: ⚠️ Human checkpoint
        Review auth config?
```

```
> Approved
```

```
        ✅ Committed

Step 4: Add SessionProvider
        ✅ Committed

Step 5: Create login components
        ✅ Committed

⚠️ Context: 52% (above 40% threshold)
   Recommend: /session-end now
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Execute each step
✓ Validate after each
✓ Commit with context
✓ Human approval
✓ Monitor context %

<br/>

**Context warning!**
Above 40% threshold.
Time to save and resume.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#3a1e5f">

### 🏁 Session End (Mid-Feature)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-end

🏁 Ending Session

Completed: Steps 1-5
Remaining: Step 6 (route protection)
Context: 52%
Commits: 5

📊 Session vibe-check:
   Trust Pass: 100% (5/5 steps validated)
   Rework: 0%
   Velocity: 6.7/hr
   Spirals: 0

Updating claude-progress.json...
  working_on: "AUTH-001: Step 6 remaining"

💾 State saved

Run /retro? > Not yet, finishing first
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Check git status
✓ Run vibe-check delta
✓ Update progress files
✓ Save current state
✓ Ready for resume

<br/>

**Why stop at 52%?**
Context > 40% degrades quality.
Fresh session = better results.

</td>
</tr>
</table>

---

<div align="center">

### ☀️ Next Day

</div>

---

<table>
<tr>
<td width="100%" bgcolor="#1a1a2e">

### 🔄 Session Resume

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-resume

🔄 Resuming: AUTH-001
   Progress: Steps 1-5 ✓
   Remaining: Step 6

Loading bundles...
   ✓ plan-auth-001.md

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

✓ Load progress state
✓ Load compressed bundles
✓ Show where we left off
✓ Fresh 8% context!

<br/>

**The magic:**
Yesterday's 52% → Today's 8%
All context preserved in bundles

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#5f3a1e">

### ⚡ Implement (Continued)

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
  /dashboard (no auth) → /login ✅
  /dashboard (auth)    → renders ✅

✅ Committed

🎉 AUTH-001 Complete!
```

```
> /session-end
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Finish remaining step
✓ Validate behavior
✓ Commit with context

<br/>

**Result:**
Feature complete in 2 sessions
Full context preserved

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#3a1e5f">

### 🏁 Session End (Feature Complete)

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /session-end

🏁 Session Complete

AUTH-001: passes: true ✅
Commits: 6 total (5 + 1)
Sessions: 2

📊 Feature vibe-check (both sessions):
   Trust Pass: 100% ↑ from 87% baseline
   Rework: 5% ↓ from 12% baseline
   Velocity: 5.8/hr ↑ from 4.2/hr
   Spirals: 0

💾 State saved

Run /retro? > Yes
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Mark feature complete
✓ Update feature-list.json
✓ Compare to baseline
✓ Ready for retrospective

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#1e5f5f">

### 🔍 Retro

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /retro

🔍 AUTH-001 Retrospective

What worked:
✓ Research caught JWT vs DB sessions early
✓ Human checkpoint on auth config
✓ Session split at 40% context

What didn't:
✗ Missed adapter version requirement
✗ Could have used tracer test

Patterns found:
• OAuth config with database adapter
• Middleware route protection
• Session split at 40%

📊 vibe-check summary:
┌────────────────┬──────────┬─────────┬────────┐
│ Metric         │ Baseline │ Actual  │ Delta  │
├────────────────┼──────────┼─────────┼────────┤
│ Trust Pass     │ 87%      │ 100%    │ +13%   │
│ Rework Ratio   │ 12%      │ 5%      │ -7%    │
│ Velocity       │ 4.2/hr   │ 5.8/hr  │ +38%   │
│ Debug Spirals  │ 0.3/day  │ 0       │ ✓      │
│ Flow Efficiency│ 71%      │ 89%     │ +18%   │
└────────────────┴──────────┴─────────┴────────┘

Save learnings? > Yes
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Review what worked
✓ Note what didn't
✓ Identify patterns
✓ Compare vibe metrics

<br/>

**Why retro?**
Patterns extracted here
become shortcuts later.

vibe-check proves it worked.

</td>
</tr>
</table>

---

<table>
<tr>
<td width="100%" bgcolor="#5f5f1e">

### 🧠 Learn

</td>
</tr>
</table>

<table>
<tr>
<td width="70%">

```
> /learn

🧠 Extracting Patterns

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

💾 Saved to patterns/
```

</td>
<td width="30%" valign="top">

<br/>

**What's happening:**

✓ Extract reusable patterns
✓ Document solutions
✓ Note anti-patterns
✓ Save to library

<br/>

**The payoff:**
Next auth feature loads
these patterns automatically

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

*Each feature makes the next one faster.*

</div>

---

<div align="center">

## Quick Reference

</div>

<table>
<tr>
<th>Command</th>
<th>When</th>
<th>What</th>
</tr>
<tr><td><code>/session-start</code></td><td>Beginning</td><td>Load state, capture baseline</td></tr>
<tr><td><code>/research</code></td><td>New problem</td><td>Explore → bundle</td></tr>
<tr><td><code>/plan</code></td><td>After research</td><td>Design → bundle</td></tr>
<tr><td><code>/implement</code></td><td>After approval</td><td>Execute + validate</td></tr>
<tr><td><code>/session-end</code></td><td>Context high / done</td><td>Save state, capture delta</td></tr>
<tr><td><code>/session-resume</code></td><td>Continuing</td><td>Load bundles</td></tr>
<tr><td><code>/retro</code></td><td>Feature done</td><td>Review + vibe-check</td></tr>
<tr><td><code>/learn</code></td><td>After retro</td><td>Extract patterns</td></tr>
</table>

---

<div align="center">

[Factor I: Git Memory](../factors/01-automated-tracking.md) · [Factor VI: Resume Work](../factors/06-resume-work.md) · [Factor IX: Mine Patterns](../factors/09-mine-patterns.md)

</div>

---

<div align="center">

**Start → Research → Plan → Implement → End → Resume → Retro → Learn**

*Every cycle compounds.*

</div>
