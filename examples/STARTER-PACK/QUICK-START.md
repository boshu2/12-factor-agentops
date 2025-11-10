# Quick Start: 12-Factor AgentOps in 5 Minutes

**Goal:** Get the core workflow running in your project

**Time:** 5 minutes

**What you'll get:** 4 phase-based agents (research, plan, implement, learn) + 5 slash commands

---

## The Fastest Path

### 1. Clone & Copy (2 minutes)

```bash
# Clone framework
git clone https://github.com/[your-org]/12-factor-agentops.git /tmp/12f

# Go to your project
cd /path/to/your-project

# Copy core workflow
cp -r /tmp/12f/examples/STARTER-PACK/.claude/ .

# Install git hooks (optional but recommended)
cp /tmp/12f/examples/STARTER-PACK/shared/git-hooks/* .git/hooks/
chmod +x .git/hooks/*
```

---

### 2. Try It (3 minutes)

**Open Claude Code (VSCode or Cursor), then:**

```bash
# Try the complete workflow
/workflow test-authentication

# You'll see:
# Phase 1: Research (understand current auth)
# Phase 2: Plan (design improvements)
# Phase 3: Implement (execute with validation)
# Phase 4: Learn (extract patterns)
```

**That's it!** You just ran a complete 12-factor workflow.

---

## What Just Happened?

### Phase 1: Research (JIT Context Loading - Factor II)

```
Agent: "Researching authentication..."

[Searches codebase for auth patterns]
Found: JWT implementation in auth/jwt.go
Found: 15 test files in tests/auth/
Found: No refresh token support

[Creates compressed bundle: auth-research.md (1.8k tokens)]
Research complete ✅
```

**Key Factor:** Factor II (JIT Context Loading)
- Loaded only relevant files
- Stayed under 40% context threshold
- Compressed findings 37:1 for next phase

---

### Phase 2: Plan (Single-Responsibility - Factor III)

```
Agent: "Planning based on research..."

[Loads research bundle - 1.8k tokens]

Design: Add refresh token rotation
- Task 1: Create refresh_tokens table (30 min)
- Task 2: Update login endpoint (45 min)
- Task 3: Add /refresh endpoint (30 min)
- Task 4: Update tests (45 min)

Validation: pytest tests/, make test
Estimated: 2.5 hours

[Saves plan bundle for implementation]
Plan ready for review ✅
```

**Key Factor:** Factor III (Single-Responsibility Agents)
- Plan agent ONLY plans (doesn't implement)
- Clear task breakdown with estimates
- Validation strategy defined

---

### Phase 3: Implement (Validation Gates - Factor IV)

```
Agent: "Implementing plan..."

[Loads plan bundle]

Task 1: Create refresh_tokens table
  - Modified: db/schema.sql
  - Validated: syntax check ✅
  - Tests: migration test ✅

Task 2: Update login endpoint
  - Modified: auth/login.go
  - Validated: go build ✅
  - Tests: 12 auth tests pass ✅

[... continues for all tasks ...]

All tasks complete ✅
Full test suite: 95% coverage ✅

Committing with learnings...
```

**Key Factor:** Factor IV (Validation Gates)
- Validated after each change
- 4-level validation (syntax → unit → integration → full)
- Caught 3 errors before commit

---

### Phase 4: Learn (Pattern Extraction - Factor IX)

```
Agent: "Extracting learnings..."

[Analyzes session logs, commits, patterns]

Patterns discovered:
1. Refresh token rotation (reusable pattern)
2. Migration testing strategy
3. JWT validation pattern

Improvements identified:
- Add rate limiting (Factor V: Telemetry)
- Extract token service (Factor III: Single-responsibility)

Documented in: patterns/refresh-token-rotation.md
Learning complete ✅
```

**Key Factor:** Factor IX (Pattern Extraction)
- Patterns extracted for future reuse
- Improvements identified (Factor X)
- Knowledge compounds over time

---

## The 4 Phases Explained

```
Research → Plan → Implement → Learn
   ↓        ↓         ↓          ↓
Factor II  Factor III Factor IV  Factor IX
(JIT)      (Single)   (Validate) (Extract)
```

**Why phases?**
- Prevents premature implementation
- Separates cognitive modes (explore vs execute)
- Enables context compression between phases
- Compounds learning over time

---

## Try Each Phase Individually

### Just Research

```bash
/research "How does caching work in this codebase?"

# Agent explores, compresses findings to bundle
# Use findings to plan improvements
```

### Just Plan

```bash
/plan caching-research

# Agent designs solution with tasks, estimates, validation
# Review and approve before implementing
```

### Just Implement

```bash
/implement caching-plan

# Agent executes mechanically, validates continuously
# Commits with Context/Solution/Learning/Impact
```

### Just Learn

```bash
/learn

# Agent extracts patterns from recent work
# Identifies improvements for next time
```

---

## Your First Real Task

**Try this 30-minute workflow:**

### 1. Pick something small to improve

```
Examples:
- Add input validation to an endpoint
- Improve error messages
- Add a simple test
- Document a function
```

### 2. Run the workflow

```bash
/workflow [your-improvement]

# Follow through all 4 phases
# See how Research→Plan→Implement→Learn works
```

### 3. Check the commit

```bash
git log -1

# See the structured commit:
# - Context (why needed)
# - Solution (what was done)
# - Learning (patterns discovered)
# - Impact (value gained)
```

---

## Token Budget (Why It Works)

**Context window:** 200,000 tokens

**Phase budgets:**
- Research: 10-15k tokens (5-7.5%) - JIT loading
- Plan: 15-25k tokens (7.5-12.5%) - Design focus
- Implement: 30-50k tokens (15-25%) - Execution
- Learn: 5-10k tokens (2.5-5%) - Reflection

**Total:** 60-100k tokens (30-50%)

**Result:** Never hit the wall, work stays fluid

**Key insight:** Stay under 40% per phase = 0% context collapse

---

## What You Installed

```
your-project/
├── .claude/
│   ├── agents/
│   │   ├── research-agent.md        # Phase 1
│   │   ├── plan-agent.md            # Phase 2
│   │   ├── implement-agent.md       # Phase 3
│   │   └── learn-agent.md           # Phase 4
│   ├── commands/
│   │   ├── research.md              # /research
│   │   ├── plan.md                  # /plan
│   │   ├── implement.md             # /implement
│   │   ├── learn.md                 # /learn
│   │   └── workflow.md              # /workflow
│   └── settings.json                # Minimal config
│
└── .git/hooks/                      # (optional but recommended)
    ├── prepare-commit-msg           # Template injection
    ├── commit-msg                   # Validation
    └── post-commit                  # Learning extraction
```

**Size:** ~8,000 tokens (4% of context window)

**Composition-safe:** Can combine with domain profiles and stay under 40%

---

## Next Steps

### Option 1: Keep Using STARTER-PACK

The core workflow works for ANY domain:
- ✅ Software development (any language)
- ✅ Infrastructure/DevOps
- ✅ Documentation writing
- ✅ Data analysis
- ✅ Research

**Just use it!** No customization needed.

---

### Option 2: Add Domain Customization

**See:** `examples/profiles/` for domain-specific additions

**Available profiles:**
- `software-dev/` - Coding-specific tools (pytest, npm, go test)
- `platform-ops/` - Infrastructure tools (kubectl, helm, terraform)
- `content-creation/` - Writing tools (markdown linting, VitePress)

**To add customization:**
```bash
# Example: Add platform-ops tools
cp -r /tmp/12f/examples/profiles/platform-ops/.claude/agents/* .claude/agents/
```

**Result:** STARTER-PACK workflow + domain tools

---

### Option 3: Read Complete Documentation

```bash
# Full guide
cat /tmp/12f/examples/STARTER-PACK/README.md

# Example workflows
cat /tmp/12f/examples/STARTER-PACK/WORKFLOWS.md

# The Five Laws
cat /tmp/12f/examples/STARTER-PACK/shared/LAWS.md

# Installation details
cat /tmp/12f/examples/STARTER-PACK/shared/INSTALL.md
```

---

### Option 4: See It in Production

**Validation data from 200+ sessions:**
- Success rate: 95% (validation gates work)
- Efficiency: 8x improvement vs ad-hoc
- Context collapse: 0% when following 40% rule
- Pattern reuse: 3-5x speedup on similar tasks

**See:** `validation/SYNTHESIS.md` for complete metrics

---

## Troubleshooting

### "Command not found" for `/research`, `/plan`, etc.

```bash
# Check .claude/ exists
ls -la .claude/

# Reload Claude Code window
# VSCode: Cmd+Shift+P → "Reload Window"
```

### Commit template not appearing

```bash
# Check hooks installed
ls -la .git/hooks/ | grep prepare-commit-msg

# Make executable
chmod +x .git/hooks/prepare-commit-msg
```

### Want to customize for my language/stack

```bash
# Agents are markdown - edit directly!
nano .claude/agents/research-agent.md

# Add your tools, file patterns, commands
# Examples in: examples/profiles/[domain]/
```

---

## Summary

**You just installed:**
- ✅ 4 phase-based agents (research, plan, implement, learn)
- ✅ 5 slash commands (/research, /plan, /implement, /learn, /workflow)
- ✅ Git hooks for Five Laws enforcement (optional)
- ✅ Complete 12-factor workflow

**Time to value:** 5 minutes (this quick-start)

**Next:** Try `/workflow [your-task]` and experience all 4 phases working together.

---

**The core workflow is installed. Now make it yours.**

**Welcome to 12-Factor AgentOps.**
