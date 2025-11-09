# Solo Developer Domain Guide

**Apply 12-Factor AgentOps as an individual developer or small team**

---

## Domain Context

### Who This Guide Is For

- Individual developers and freelancers
- Small teams (2-5 people)
- Side projects and startups
- Anyone wearing multiple hats (dev + ops + design)
- Developers who want maximum productivity with minimal overhead

### Typical AI Usage

- Full-stack development
- Quick prototyping
- Client projects
- Learning new technologies
- Fixing bugs and adding features
- Writing documentation

### The Solo Developer Challenge

**You need AI to be productive, but:**
- No team to review your work
- No dedicated QA or ops team
- Limited time for process
- Can't afford production incidents

**The framework must be:**
- Lightweight (no enterprise overhead)
- Effective (real quality improvement)
- Fast (minimal ceremony)

---

## The Pragmatic Three (Start Here)

**For solo developers, these three factors deliver 80% of the value:**

### Factor I: Git Memory

**What:** Commit all AI work with detailed context

**Why:** Future you is your only teammate. Help them out.

**How:**
```bash
# Before
git commit -m "fix stuff"

# After
git commit -m "fix(auth): prevent token bypass

Context: Users could bypass auth with null tokens
Solution: Added null check in middleware
AI-Assisted: Claude Code suggested fix
Testing: All 23 auth tests passing"
```

**Time cost:** +30 seconds per commit
**Value:** Search git history instead of re-learning

### Factor II: Stay Under 40% Context

**What:** Monitor AI context utilization, stay under 40%

**Why:** Quality degrades above 40%, you waste time on rework

**How:**
```
# Watch context % in your IDE
# If approaching 40%:
1. Save current work
2. Start fresh session
3. Resume with clean context
```

**Time cost:** 0 (actually saves time)
**Value:** Maintain quality throughout session

### Factor IV: Test Before Commit

**What:** Always test AI code locally before committing

**Why:** Catch errors when cheap (local) vs expensive (production)

**How:**
```bash
# Before every commit
npm test && git commit

# Or for your stack
pytest && git commit
go test ./... && git commit
cargo test && git commit
```

**Time cost:** +2-5 minutes per commit
**Value:** Prevent production incidents

---

## Quick Wins for Solo Developers

### 5-Minute Setup

**1. Pre-commit hook:**
```bash
# .git/hooks/pre-commit
#!/bin/bash
npm test || {
  echo "❌ Tests failed. Fix before committing."
  exit 1
}
```

**2. Commit template:**
```bash
git config commit.template .gitmessage

# .gitmessage
<type>(<scope>): <subject>

Context: Why?
Solution: What?
AI-Assisted: Which tool?
```

**3. Context reminder:**
```
# Add to IDE
# "If context >40%, save & restart"
```

---

## Real Solo Developer Scenarios

### Scenario 1: Building a Feature

**Situation:** Add user authentication to your app

**Old way (no framework):**
```
1. Ask AI: "Add user auth"
2. Copy 500 lines of code
3. Commit without testing
4. Deploy
5. ❌ Breaks in production
6. Spend 2 hours debugging
Total: 4 hours
```

**New way (with pragmatic three):**
```
1. Ask AI: "Add user registration endpoint"
   (Factor III: Single task, not entire system)

2. Review AI code
   Add to routes/auth.js

3. Test locally (Factor IV)
   npm test -- auth.test.js
   ✅ Pass

4. Commit with context (Factor I)
   git commit -m "feat(auth): add user registration

   Context: Need user accounts for paid features
   Solution: POST /auth/register endpoint
   AI-Assisted: Claude Code generated route + validation
   Testing: 8 tests passing"

5. Repeat for login, logout (incremental)

6. Deploy after all tests pass

Total: 2 hours, higher quality
```

**Time saved:** 2 hours
**Quality:** Higher (no production bugs)

### Scenario 2: Fixing a Bug

**Situation:** Users report app crashes on null input

**Old way:**
```
1. Ask AI: "Why is it crashing?"
2. Try random fixes
3. Commit each attempt
4. ❌ Still broken after 5 commits
5. Finally works
6. Git history is mess
Total: 1 hour
```

**New way:**
```
1. Write failing test first
   it('handles null input', () => {
     expect(processData(null)).not.toThrow()
   })

2. Ask AI: "Fix processData to handle null"
   (Shows AI the failing test)

3. AI suggests fix
   if (!data) return null

4. Test (Factor IV)
   npm test
   ✅ Pass

5. Commit (Factor I)
   git commit -m "fix(data): handle null input in processData

   Context: App crashes when users submit empty form
   Solution: Added null check at function entry
   AI-Assisted: Claude Code suggested defensive coding
   Testing: Added test case, all passing"

Total: 15 minutes, clean history
```

**Time saved:** 45 minutes
**Quality:** Better (test prevents regression)

### Scenario 3: Multi-Day Project

**Situation:** Build admin dashboard over weekend

**Friday night:**
```bash
# Research
/research "React admin dashboard best practices"
# Save bundle
/bundle-save admin-dashboard-research

# Start implementation
# Get 30% done
# Context at 38%

# End session
git commit -m "wip: admin dashboard skeleton"
# Don't push WIP commit yet
```

**Saturday:**
```bash
# Resume
/bundle-load admin-dashboard-research

# Continue from where left off
# Fresh context, high quality decisions
# Get to 80% done

git commit -m "feat(admin): add user management UI"
```

**Sunday:**
```bash
# Final push
# 80% → 100%
# All tests passing

git commit -m "feat(admin): complete admin dashboard

Context: Need admin panel for user management
Solution: React dashboard with user CRUD
AI-Assisted: Claude Code generated components
Testing: All 45 tests passing
Coverage: 87%

Features:
- User list with pagination
- Create/edit/delete users
- Role management
- Activity logs"

git push  # Ship it
```

**Key:** Bundle saved context between sessions (Factor VI)

---

## When to Add More Factors

**Start with pragmatic three (I, II, IV)**

**After 2 weeks, add if needed:**

### Add Factor III (Single-Responsibility)

**When:** Tasks getting too complex

**Example:**
```
Before: "Build entire e-commerce checkout"
After:  "Build shopping cart display"
        "Build payment form"
        "Build order confirmation"
Each focused, each validated
```

### Add Factor VII (Task Routing)

**When:** Using multiple AI tools

**Example:**
```
Code generation → Claude Code
Quick fixes → GitHub Copilot
Documentation → ChatGPT
Architecture → Claude (long context)
```

### Add Factor VI (Session Continuity)

**When:** Projects span multiple days

**Already shown in Scenario 3 above**

### Add Factor VIII (Human Gate)

**When:** Working with clients

**Example:**
```
# Flag for client review
git commit -m "feat(ui): new landing page [CLIENT REVIEW]"

# Show to client before merging
# Get approval
# Then merge
```

---

## Anti-Patterns for Solo Developers

### ❌ "Move Fast and Break Things"

**Wrong:**
```
Generate code
→ Skip tests
→ Commit
→ Push
→ ❌ Production breaks
→ You're on-call (it's just you)
```

**Right:**
```
Generate code
→ Test locally (Factor IV)
→ Commit with context (Factor I)
→ Push
→ ✅ Works in production
→ Sleep well
```

### ❌ "I'll Remember Why I Did This"

**Wrong:**
```
git commit -m "update stuff"
# 3 months later: "Why did I do this???"
```

**Right:**
```
git commit -m "refactor(api): extract validation to middleware

Context: Validation logic repeated in 5 routes
Solution: Moved to reusable middleware
Benefits: DRY, easier to test, faster to add routes"

# 3 months later: "Oh right, makes sense"
```

### ❌ "Load Everything into AI Context"

**Wrong:**
```
# Load entire 50-file codebase into AI
# Context: 85%
# AI: Makes poor decisions due to overload
# You: Waste 2 hours on rework
```

**Right:**
```
# Load just the 3 files you're modifying
# Context: 25%
# AI: High-quality suggestions
# You: Ship in 30 minutes
```

---

## Measuring Success

**Track these simple metrics:**

### Week 1 (Baseline)
- Count: Features shipped
- Count: Bugs found after deploy
- Time: Hours spent on AI-generated code (including rework)

### Week 2-4 (With Framework)
- Count: Features shipped (should be higher)
- Count: Bugs found after deploy (should be lower)
- Time: Hours spent (should be lower or same with better quality)

**Example results (observed):**
```
Week 1 (no framework):
- Features: 2
- Bugs: 3
- Time: 20 hours
- Quality: Medium

Week 4 (with framework):
- Features: 5
- Bugs: 0
- Time: 18 hours
- Quality: High

Improvement: 2.5x features, 0 bugs, 10% less time
```

---

## Tool Recommendations for Solo Developers

**AI Coding Assistants:**
- Claude Code (best for thoughtful code)
- GitHub Copilot (best for quick completions)
- Cursor (best integrated IDE experience)

**Testing:**
- Jest (JavaScript/TypeScript)
- Pytest (Python)
- Go test (Go)
- Cargo test (Rust)

**Validation:**
- ESLint (JavaScript)
- Black + mypy (Python)
- go fmt + go vet (Go)
- rustfmt + clippy (Rust)

---

## Daily Workflow

**Morning:**
```bash
# Start coding session
# Load relevant context (Factor II)
# Keep context under 40%
```

**During work:**
```bash
# Generate code with AI
# Test each change (Factor IV)
# Commit frequently with context (Factor I)
```

**End of day:**
```bash
# If multi-day project:
/bundle-save project-name

# Otherwise:
# Make sure all tests passing
# Push to repo
```

**Weekly:**
```bash
# Review: What worked? What didn't?
# Extract patterns (Factor IX)
# Improve workflow (Factor X)
```

---

## Success Story

**Developer:** Solo full-stack developer
**Project:** SaaS app (React + Node.js)
**Period:** 8 weeks

**Before framework:**
- Velocity: 1 feature per week
- Bug rate: 15% of features had production bugs
- Confidence: Low ("afraid to ship")

**After framework (Week 4+):**
- Velocity: 3 features per week
- Bug rate: 0% (no production bugs)
- Confidence: High ("ship daily with confidence")

**Key factors:**
- Factor IV (testing) caught all bugs locally
- Factor I (git memory) enabled faster iteration
- Factor II (40% rule) maintained quality

**Quote:** "I can ship AI code to production same day now. Before, I was scared to deploy anything AI-generated."

---

## Quick Reference

**The Pragmatic Three:**
1. ✅ Detailed commit messages (Factor I)
2. ✅ Stay under 40% context (Factor II)
3. ✅ Test before commit (Factor IV)

**When working:**
```bash
# Generate code with AI
# Test it
npm test

# If passing, commit
git commit -m "<type>: <what>

Context: <why>
Solution: <how>
AI: <which tool>"

# If multi-day, save bundle
/bundle-save project-name
```

**Daily checklist:**
- [ ] All changes tested
- [ ] All commits have context
- [ ] Context stayed under 40%
- [ ] Everything works locally

---

## Getting Started Today

**Right now (5 minutes):**
1. Set up pre-commit hook (test before commit)
2. Create commit template
3. Start monitoring context %

**This week:**
- Use pragmatic three on every AI interaction
- Track baseline metrics

**Next week:**
- Compare metrics to baseline
- Adjust based on results

---

## Resources

- [Quick Reference Card](../../tutorials/quick-reference-card.md) - Print and post
- [Decision Tree](../../tutorials/decision-tree.md) - Which factor for which problem
- [First 30 Minutes](../../tutorials/first-30-minutes.md) - Complete intro

**Related Guides:**
- [Software Development](software-development.md) - More detailed coding guidance
- [DevOps Guide](devops-infrastructure.md) - If wearing ops hat too

---

**Start with the pragmatic three. Measure improvement. Iterate.**

**You've got this. Ship with confidence.**
