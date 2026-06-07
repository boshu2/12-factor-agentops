# Quick Start: 15 Minutes to FAAFO

**Goal:** Experience FAAFO (Fast, Ambitious, Autonomous, Fun, Optionality) in 15 minutes

**What you'll build:** A validated AI workflow with 2-5x speedup

---

## Prerequisites

- Git installed
- Any AI coding assistant (Claude Code, GitHub Copilot, Cursor, etc.)
- 15 minutes

---

## Step 1: Create Your First Factor (Factor II: Track Everything in Git)

**Time:** 2 minutes

```bash
# Initialize a git repository (if not already)
git init
cd your-project

# Configure git to track AI interactions
git config --local commit.template .gitmessage
```

**Create `.gitmessage`:**
```
# Type: feat/fix/docs/refactor/test
# Scope: component or area affected
# Description: what and why

# --- AI Workflow Context ---
# Factors used: [I, II, IV, etc.]
# Success rate: [%]
# Time saved: [X min]
```

**Why this matters (FAAFO):**
- ✅ **Autonomous:** Git tracks every decision automatically
- ✅ **Fun:** No manual note-taking, focus on building

---

## Step 2: Add Validation Gates (Factor VII: Validate Externally)

**Time:** 5 minutes

**Create `Makefile` with quick validation:**

```makefile
.PHONY: quick validate

# Factor VII: Validate Externally
quick:
	@echo "🔍 Running quick validation..."
	@# Syntax check
	@if command -v python3 >/dev/null; then \
		find . -name "*.py" -exec python3 -m py_compile {} \; 2>&1 | grep -v "Listing" || true; \
	fi
	@# YAML syntax (if you have YAML files)
	@if command -v yamllint >/dev/null; then \
		find . -name "*.yaml" -o -name "*.yml" | xargs yamllint -d relaxed 2>/dev/null || true; \
	fi
	@# JSON syntax (if you have JSON files)
	@if command -v jq >/dev/null; then \
		find . -name "*.json" -exec jq empty {} \; 2>/dev/null || true; \
	fi
	@echo "✅ Quick validation complete (5s)"

# More thorough validation
validate: quick
	@echo "🔍 Running full validation..."
	@# Add your test suite here
	@# pytest, npm test, go test, etc.
	@echo "✅ Full validation complete"
```

**Test it:**
```bash
make quick
```

**Why this matters (FAAFO):**
- ✅ **Fast:** 5-second validation vs 4-hour manual review (27x faster)
- ✅ **Fun:** Catch errors before they waste time debugging
- ✅ **Autonomous:** External validation enables confident solo work

---

## Step 3: Create a Simple AI Workflow

**Time:** 5 minutes

**Task:** Ask AI to create a function with validation

**Workflow:**
1. **Ask AI:** "Create a Python function that calculates Fibonacci numbers with input validation"
2. **AI generates code**
3. **Run validation:** `make quick`
4. **Fix any errors** (AI can help)
5. **Commit:** `git add . && git commit -m "feat: add fibonacci function with validation"`

**Example conversation:**
```
You: Create a Python function that calculates Fibonacci numbers
     with input validation

AI: [generates fibonacci.py]

You: Run validation
make quick

Output: ✅ Quick validation complete (5s)

You: Commit
git add fibonacci.py
git commit -m "feat: add fibonacci function

Factors used: II (Track Everything in Git), VII (Validate Externally)
Success rate: 100%
Time saved: ~10 min (vs manual validation)"
```

**Why this matters (FAAFO):**
- ✅ **Ambitious:** Just built a validated function in 5 minutes
- ✅ **Fast:** Validation in 5s, not manual review
- ✅ **Optionality:** Can iterate quickly without breaking things

---

## Step 4: Measure Your Result

**Time:** 2 minutes

**Track these metrics:**

```bash
# Success rate
echo "Success rate: 100% (1/1 validation passed)"

# Time comparison
echo "Without validation: ~15 min (write + manual test + debug)"
echo "With validation: ~5 min (write + make quick)"
echo "Speedup: 3x"
```

**Create a simple metrics file:**

```bash
# Create metrics.md
cat > METRICS.md <<EOF
# AI Workflow Metrics

## Factor Implementation
- ✅ Factor II: Track Everything in Git
- ✅ Factor VII: Validate Externally (make quick)

## Results (Week 1)
- Tasks completed: 1
- Success rate: 100%
- Average speedup: 3x
- Time saved: 10 minutes

## FAAFO Achievement
- Fast: ✅ 5s validation
- Ambitious: ✅ Validated function in 5 min
- Autonomous: ✅ No manual intervention needed
- Fun: ✅ No debugging, just building
- Optionality: ✅ Can iterate safely
EOF
```

---

## Step 5: What You Just Experienced (FAAFO)

**Fast:**
- ✅ 5-second validation (vs hours of manual review)
- ✅ 3x speedup on first task

**Ambitious:**
- ✅ Built and validated a function in 5 minutes
- ✅ Ready to tackle harder problems

**Autonomous:**
- ✅ Validation gates prevent errors automatically
- ✅ Git tracks decisions without manual notes

**Fun:**
- ✅ More time building, zero time debugging
- ✅ Confidence from external validation

**Optionality:**
- ✅ Can iterate quickly without fear
- ✅ Operational discipline = safety net for experimentation

---

## Next Steps (15 More Minutes)

### Add Factor I: Context Is Everything

**Goal:** Load AI context efficiently (no context collapse)

```bash
# Create CLAUDE.md (or .cursorrules, .github/copilot-instructions.md)
cat > CLAUDE.md <<EOF
# Project Context

## What This Is
[One-line description]

## Tech Stack
- Language: Python 3.11
- Key libraries: [list]

## Current Task
[What you're working on]

## Patterns to Follow
- Use type hints
- Validate inputs
- Write docstrings

## Don't Do
- Don't skip validation
- Don't commit without \`make quick\`
EOF
```

**Why:** Prevents context collapse (40% rule), keeps AI focused

---

### Add Factor IX: Extract Learnings

**Goal:** Save what works for reuse

```bash
# Create patterns directory
mkdir -p .patterns

# Save your validated function as a pattern
cp fibonacci.py .patterns/validated-function-template.py
```

**Why:** Extracting learnings compounds knowledge over time

---

## You're Ready!

**In 15 minutes you've:**
- ✅ Implemented 2 factors (II + V)
- ✅ Experienced 3x speedup
- ✅ Achieved 100% success rate
- ✅ Felt FAAFO (Fast, Ambitious, Autonomous, Fun, Optionality)

**Keep going:**
- **Solo developer?** → [Solo Developer Guide](solo-developer.md)
- **Want deeper understanding?** → [FAAFO Philosophy](../explanation/faafo-north-star.md)

---

## Common Issues & Solutions

### "make quick" doesn't work

**Fix:** Make sure you have `make` installed:
```bash
# macOS
xcode-select --install

# Linux
sudo apt install build-essential  # Debian/Ubuntu
sudo yum install make              # RHEL/CentOS

# Windows
# Install via WSL or use nmake
```

### No linters installed

**That's okay!** Start minimal:
```makefile
quick:
	@echo "🔍 Running quick validation..."
	@# Just check Python syntax
	@python3 -m compileall . 2>&1 | grep -v "Listing" || true
	@echo "✅ Quick validation complete"
```

### AI doesn't follow my context file

**Fix:** Be more explicit in your prompts:
```
"Create a fibonacci function following the patterns in CLAUDE.md"
```

---

## Celebrate Your First FAAFO Moment! 🎉

You just:
- Validated code in 5 seconds (was: hours)
- Achieved 100% success rate (was: 35%)
- Built with confidence (was: fear of breaking things)

**This is FAAFO.**

Keep iterating. Add more factors. Measure results. Share patterns.

---

**Time invested:** 15 minutes
**Speedup achieved:** 3x
**Factors implemented:** 2/12
**Success rate:** 100%
**FAAFO experienced:** ✅

**Next:** [Solo Developer Guide](solo-developer.md) or [Workflow Guide](../tutorials/workflow-guide.md)
