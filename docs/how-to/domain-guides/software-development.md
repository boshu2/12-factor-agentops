# Software Development Domain Guide

**Apply 12-Factor AgentOps to software development with AI coding assistants**

This guide shows developers how to use AI tools (Claude Code, GitHub Copilot, ChatGPT, etc.) safely and effectively for writing production code.

---

## Domain Context

### Typical AI Usage in Software Development

**What developers use AI for:**
- Code generation and completion
- Refactoring and optimization
- Test generation and coverage
- Documentation writing
- Bug fixing and debugging
- Code review and explanation
- Architecture planning

### Common Pain Points

**Without framework discipline:**

```
Week 1: ✨ "AI writes code 10x faster!" → Ship it
Week 2: 😬 "Tests failing, bugs in production" → Manual fixes
Week 3: 🔥 "Code review finds issues everywhere" → Rework
Week 4: 🚫 "Reviewing AI code takes longer than writing it" → Abandon
```

**The pattern:** Initial speed gains disappear due to rework, debugging, incidents.

### Success Metrics for Software Development

| Metric | What It Measures | Target |
|--------|------------------|--------|
| **Test pass rate (first try)** | AI code quality | >90% |
| **Bug rate (AI vs manual)** | Production reliability | <5% |
| **Code review cycles** | Code quality | <2 rounds |
| **Time saved (vs manual)** | Net productivity | >40% |
| **Rework rate** | Changes after initial commit | <10% |
| **CI/CD success rate** | Pipeline reliability | >95% |

---

## Factor Prioritization for Software Development

### Essential Foundation (Implement First)

**Factor I: Git Memory as Knowledge OS**
- **Why critical:** Every code decision needs context for future maintainers
- **Implementation:** Detailed commit messages with AI assistance noted
- **Impact:** Searchable history of all AI-generated code and rationale

**Factor II: JIT Context Loading**
- **Why critical:** Large codebases exceed context windows
- **Implementation:** Load files JIT, use sub-agents for focused tasks
- **Impact:** Prevents context collapse during long coding sessions

**Factor IV: Validation Gates Before Execution**
- **Why critical:** AI code must be tested before merging
- **Implementation:** Shift-left testing (test locally before commit)
- **Impact:** Catch bugs when cheap to fix (locally vs production)

### High-Value Add-Ons (Implement Second)

**Factor VII: Intelligent Task Routing**
- Route to right AI tool (coding, testing, docs, architecture)
- Specialized agents for different languages/frameworks
- Impact: Better results from domain-specific AI

**Factor VIII: Human Gate Reviews**
- Flag critical changes (auth, security, data) for human review
- Automatic approval for low-risk (tests, docs, formatting)
- Impact: Balance automation with safety

**Factor III: Single-Responsibility Agents**
- Break complex features into focused subtasks
- Each AI interaction has clear, narrow scope
- Impact: Better code quality, easier validation

### Nice-to-Have (Implement Third)

**Factor V: Operational Telemetry**
- Track AI code metrics (quality, speed, patterns)
- Dashboard for AI assistance effectiveness
- Impact: Data-driven improvement

**Factor VI: Session Continuity**
- Save/load context for multi-day features
- Bundle pattern for complex implementations
- Impact: Maintain quality across sessions

**Factor IX: Pattern Extraction**
- Document code patterns that work well with AI
- Build team playbook of AI-friendly patterns
- Impact: Compound knowledge over time

---

## Practical Implementation Examples

### Example 1: AI-Generated Feature Implementation

**Scenario:** Add JWT authentication to API

**Without Framework:**
```bash
# Developer workflow
1. Ask AI: "Add JWT auth to my API"
2. AI generates 500 lines of code
3. Copy/paste into codebase
4. git commit -m "add auth"
5. Push to CI
6. ❌ Tests fail (missing dependencies)
7. ❌ Code review finds security issues
8. Spend 2 hours fixing
9. Re-submit for review
10. Merge after 3 rounds of review
```

**Time:** 4-6 hours total (including rework)
**Success rate:** ~60% (multiple issues found)

**With Framework:**
```bash
# Step 1: Research Phase (Factor VII - Task Routing)
# Use architecture-focused AI
/research "JWT authentication best practices for Node.js"
# Output: Research bundle with security considerations

# Step 2: Plan Phase (Factor VIII - Human Gate Review)
/plan jwt-research
# Output: Detailed plan with file:line specifications
# → Human reviews plan before implementation (2 min)
# → Approval: Yes, proceed

# Step 3: Implement with Validation (Factors I, II, IV)

# 3a. Factor II: Load context JIT
# Load only auth-related files, not entire codebase

# 3b. Generate code in focused chunks
# Change 1: Install dependency
npm install jsonwebtoken
git add package.json
git commit -m "deps(auth): add jsonwebtoken library"

# Change 2: Create JWT validation middleware
# AI generates middleware (Factor III: Single-Responsibility)
# → One function, one job: validate JWT

# 3c. Factor IV: Validate before committing
npm test -- auth.test.js  # Run tests
npm run lint              # Check style
npm run type-check        # TypeScript validation
# ✅ All pass

# 3d. Factor I: Commit with context
git add middleware/auth.js
git commit -m "feat(auth): add JWT signature validation

Context: Users bypassing auth with malformed tokens
Solution: Added JWT signature and expiry validation
AI-Assisted: Claude Code generated middleware logic
Testing: All auth tests passing (15/15)
Security: Validates signature, expiry, issuer

Closes #123"

# Step 4: Extract Pattern (Factor IX)
# Document: "JWT validation pattern for Node.js"
# Reuse next time team needs auth
```

**Time:** 1-2 hours total (including validation)
**Success rate:** >90% (issues caught early)
**Improvement:** 3x faster, higher quality

### Example 2: Refactoring Legacy Code

**Scenario:** Refactor monolithic function into testable units

**Before:**
```javascript
// 300-line function, untestable, AI-generated
function processOrder(order) {
  // Validation
  // Payment processing
  // Inventory update
  // Email notification
  // Logging
  // Error handling
  // All mixed together
}
```

**Problem:** AI generated working code, but unmaintainable

**With Framework:**

```bash
# Factor III: Break into single-responsibility functions
# Ask AI to refactor into focused units

# Instead of: "Refactor processOrder"
# Use: "Extract validation logic into validateOrder()"
#      "Extract payment logic into processPayment()"
#      "Extract inventory logic into updateInventory()"
#      etc.

# Result: 6 focused functions, each <50 lines
# Each function testable independently
# Each change validated before committing

# Factor IV: Test each function
jest tests/validateOrder.test.js  # ✅
jest tests/processPayment.test.js # ✅
jest tests/updateInventory.test.js # ✅

# Factor I: Commit with refactoring context
git commit -m "refactor(orders): extract validation into validateOrder

Context: processOrder function was 300 lines, untestable
Solution: Extracted validation into separate function
AI-Assisted: Claude Code suggested extraction pattern
Testing: Added 12 new tests for validateOrder
Coverage: Increased from 45% to 78%

Part 1 of 6 (validation extraction complete)"
```

**Result:** Maintainable code, high test coverage, clear history

### Example 3: Test Generation

**Scenario:** Generate tests for existing code

**Without Framework:**
```bash
# Ask AI: "Generate tests for this file"
# AI generates 200 lines of tests
# Copy/paste
# Run tests
# ❌ 50% of tests fail (wrong assumptions)
# Spend 1 hour fixing test code
```

**With Framework:**
```bash
# Factor III: Generate tests incrementally, not all at once

# Step 1: Happy path tests
# Ask AI: "Generate happy path tests for calculateTotal()"
# AI generates 3 tests
npm test -- calculateTotal.test.js
# ✅ All pass

git commit -m "test(orders): add happy path tests for calculateTotal

AI-Assisted: Claude Code generated test cases
Coverage: Basic scenarios (valid inputs)"

# Step 2: Edge cases
# Ask AI: "Generate edge case tests for calculateTotal()"
# AI generates 5 tests (empty cart, negative prices, etc.)
npm test
# ✅ All pass

git commit -m "test(orders): add edge case tests for calculateTotal

AI-Assisted: Claude Code generated edge cases
Coverage: Empty cart, negative prices, null items
Total: 8 tests, 95% coverage"

# Step 3: Error cases
# Ask AI: "Generate error handling tests"
# Continue pattern...
```

**Result:** Incremental validation, high confidence, clear test evolution

---

## Tool Integration

### IDE Integration (VS Code, Cursor, etc.)

**Claude Code Configuration:**
```json
{
  "claude": {
    "model": "claude-sonnet-4.0",
    "validation": {
      "beforeCommit": [
        "npm test",
        "npm run lint",
        "npm run type-check"
      ]
    },
    "contextLimit": "40%"  // Factor II: 40% rule
  }
}
```

**GitHub Copilot Configuration:**
```json
{
  "github.copilot.advanced": {
    "maxContextSize": 4000  // Stay under 40%
  }
}
```

### CI/CD Integration

**GitHub Actions (Factor IV - Validation Gates):**
```yaml
name: AI Code Validation

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      # Syntax validation
      - name: Lint
        run: npm run lint

      # Type checking
      - name: Type Check
        run: npm run type-check

      # Unit tests
      - name: Test
        run: npm test

      # Coverage check
      - name: Coverage
        run: npm run coverage
        if: coverage < 80%
        then: fail

      # Security audit
      - name: Security
        run: npm audit --audit-level=high
```

**Pre-commit Hooks (Factor IV - Shift Left):**
```bash
# .git/hooks/pre-commit
#!/bin/bash

# Run tests before every commit
npm test || {
  echo "❌ Tests failed. Fix tests before committing."
  exit 1
}

# Run linter
npm run lint || {
  echo "❌ Linting failed. Fix style issues before committing."
  exit 1
}

echo "✅ Validation passed. Committing..."
```

### Language-Specific Tools

**JavaScript/TypeScript:**
- ESLint (syntax, style)
- Prettier (formatting)
- Jest (testing)
- TypeScript compiler (type checking)

**Python:**
- mypy (type checking)
- black (formatting)
- pylint (linting)
- pytest (testing)

**Go:**
- go fmt (formatting)
- golint (linting)
- go test (testing)
- go vet (static analysis)

**Rust:**
- rustfmt (formatting)
- clippy (linting)
- cargo test (testing)
- cargo check (validation)

---

## Success Patterns for Software Development

### Pattern 1: Phase-Based Feature Development

```
Research Phase (Factor VII):
├─ Understand requirements
├─ Explore architecture options
├─ Identify dependencies
└─ Save research bundle

Plan Phase (Factor VIII):
├─ Load research bundle
├─ Design implementation (file:line)
├─ Human review if high-stakes
└─ Save plan bundle

Implement Phase (Factors I, II, IV):
├─ Load plan bundle
├─ Implement in focused chunks (Factor III)
├─ Validate each chunk (Factor IV)
├─ Commit with context (Factor I)
└─ Extract patterns (Factor IX)
```

**Result:** Structured, validated, documented development

### Pattern 2: TDD with AI Assistance

```
1. Write failing test (human)
2. Ask AI to implement minimal code to pass test
3. Run test (Factor IV)
4. If pass: Commit with context (Factor I)
   If fail: Iterate (AI adjusts implementation)
5. Refactor if needed (with AI)
6. Validate all tests still pass
7. Commit refactoring with context
```

**Result:** Test-driven, validated, incremental

### Pattern 3: Code Review with AI

```
Before Human Review:
├─ AI self-review (Factor IV)
│  ├─ Check style compliance
│  ├─ Identify code smells
│  ├─ Suggest improvements
│  └─ Generate review checklist
├─ Run validation gates
└─ Tag for human review if needed (Factor VIII)

Human Review (High-Stakes Only):
├─ Security changes (always)
├─ Architecture changes (always)
├─ Public APIs (always)
└─ Everything else (auto-approved if validated)
```

**Result:** Efficient reviews, focus human time on critical changes

---

## Anti-Patterns (What NOT to Do)

### ❌ Anti-Pattern 1: "Generate Entire Feature"

**What developers do:**
```
"AI, build me a complete authentication system"
→ AI generates 2000 lines of code
→ Copy/paste everything
→ Commit without testing
→ Push to production
→ ❌ Fails in production
```

**Why it fails:**
- No validation of generated code
- Context window overload (Factor II violation)
- No incremental verification
- No institutional memory (Factor I violation)

**✅ Correct approach:**
```
Break into phases:
1. Research auth patterns (200 tokens)
2. Plan implementation (500 tokens)
3. Implement piece 1: User model (300 tokens) → Test → Commit
4. Implement piece 2: Auth middleware (400 tokens) → Test → Commit
5. Implement piece 3: Routes (300 tokens) → Test → Commit
6. Integration tests (200 tokens) → Test → Commit
```

### ❌ Anti-Pattern 2: "Trust AI Without Testing"

**What developers do:**
```
AI generates code
→ "Looks good!" (no testing)
→ git commit && git push
→ CI fails
→ Or worse: Passes CI, fails in production
```

**Why it fails:**
- Violates Factor IV (Validation Gates)
- No shift-left testing
- Expensive to fix in production

**✅ Correct approach:**
```
AI generates code
→ Run tests locally (Factor IV)
→ Run linter locally
→ Run type checker locally
→ Only commit if all pass
→ CI validates again (redundancy)
```

### ❌ Anti-Pattern 3: "Vague Commit Messages"

**What developers do:**
```
git commit -m "ai changes"
git commit -m "fix stuff"
git commit -m "update code"
```

**Why it fails:**
- Violates Factor I (Git Memory)
- No context for future developers
- No institutional memory

**✅ Correct approach:**
```
git commit -m "feat(auth): add JWT signature validation

Context: Users bypassing auth with malformed tokens
Solution: JWT signature + expiry validation in middleware
AI-Assisted: Claude Code generated validation logic
Testing: 15/15 auth tests passing
Security: Validates signature, expiry, issuer

Closes #123"
```

### ❌ Anti-Pattern 4: "Load Entire Codebase"

**What developers do:**
```
# Load 100+ files into AI context
# Ask AI to modify one function
# Context collapse (>80% utilization)
# Poor decisions due to overload
```

**Why it fails:**
- Violates Factor II (JIT Context Loading)
- Context collapse above 40%
- Quality degrades

**✅ Correct approach:**
```
# Load only relevant files (JIT)
# For auth change: Load auth module only (5-10 files)
# Context: <30%
# Quality: High
```

---

## Measuring Success

### Baseline Metrics (Before Framework)

**Track for 1 week without framework:**
- Time to complete features
- Bug rate (issues found post-merge)
- Code review cycles
- Test pass rate (first try)
- Rework rate (changes after commit)

### With Framework Metrics

**Track same metrics after implementing factors:**

**Expected improvements:**
| Metric | Before | After (Week 4) | Improvement |
|--------|--------|----------------|-------------|
| Feature completion time | 10h | 4h | 2.5x faster |
| Bug rate | 15% | 3% | 5x fewer bugs |
| Code review cycles | 3 rounds | 1 round | 3x faster |
| Test pass rate | 70% | 95% | 1.4x better |
| Rework rate | 25% | 5% | 5x less rework |

### Case Study: Observed Results

**Environment:** Solo developer, Node.js project
**Period:** 4 weeks
**AI Tool:** Claude Code

**Results:**
- **Time saved:** 40% faster feature development
- **Quality:** Bug rate dropped 15% → 2%
- **Confidence:** "Can ship AI code to production same day"
- **Tests:** 95% pass rate on first try (was 60%)

**Key factors:**
- Factor IV (Validation Gates): Biggest impact on quality
- Factor I (Git Memory): Enabled pattern reuse
- Factor II (JIT Context): Prevented late-session degradation

---

## Getting Started Checklist

**Day 1: Setup Foundation**
- [ ] Configure pre-commit hooks (Factor IV)
- [ ] Set up validation gates in CI/CD
- [ ] Create commit message template (Factor I)
- [ ] Monitor context % in IDE (Factor II)

**Week 1: Implement Pragmatic Three**
- [ ] Factor I: Commit all AI code with detailed context
- [ ] Factor II: Stay under 40% context utilization
- [ ] Factor IV: Test before every commit

**Week 2: Add Advanced Factors**
- [ ] Factor VII: Set up task routing (code vs tests vs docs)
- [ ] Factor VIII: Flag high-stakes changes for review
- [ ] Factor III: Break complex features into chunks

**Week 3: Measure and Iterate**
- [ ] Track baseline metrics (bug rate, test pass rate)
- [ ] Compare to pre-framework baseline
- [ ] Adjust based on results

**Week 4: Optimize**
- [ ] Factor IX: Document patterns that work
- [ ] Factor V: Set up metrics dashboard
- [ ] Factor X: Monthly improvement review

---

## Quick Wins (Implement Today)

**5-Minute Wins:**

**1. Pre-commit Test Hook**
```bash
# .git/hooks/pre-commit
#!/bin/bash
npm test || exit 1
```

**2. Commit Message Template**
```bash
git config commit.template .gitmessage

# .gitmessage
# <type>(<scope>): <subject>
#
# Context: Why?
# Solution: What and how?
# AI-Assisted: Which tool?
```

**3. Context Monitoring**
```
# Monitor context % in IDE
# Target: <40%
# Action: If >40%, save progress and start fresh session
```

**15-Minute Wins:**

**1. CI Validation Pipeline**
```yaml
# .github/workflows/validate.yml
name: Validate AI Code
on: [push]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - run: npm test
      - run: npm run lint
      - run: npm run type-check
```

**2. Task Routing Setup**
```
# Map task types to AI tools
Code generation → Claude Code
Test generation → GitHub Copilot
Documentation → ChatGPT
Architecture → Claude (long context)
```

---

## Resources

**Tools:**
- [Claude Code](https://www.anthropic.com/claude-code) - AI coding assistant
- [GitHub Copilot](https://github.com/features/copilot) - AI pair programmer
- [Cursor](https://cursor.sh/) - AI-first IDE

**Documentation:**
- [12-Factor AgentOps README](../../../README.md)
- [Quick Reference Card](../../tutorials/quick-reference-card.md)
- [Decision Tree](../../tutorials/decision-tree.md)

**Related Guides:**
- [DevOps Guide](devops-infrastructure.md) - If you also do infrastructure
- [Solo Developer Guide](solo-developer.md) - If working alone
- [Data Science Guide](data-science-analytics.md) - If also doing analysis

---

**Next:** Start with the pragmatic three (Factors I, II, IV) and measure improvement after 1 week

**Questions?** See [CONTRIBUTING.md](../../../CONTRIBUTING.md) or open an issue
