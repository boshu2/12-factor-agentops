# Reference Documentation

**Information-oriented quick lookup**

---

## The 12 Factors

**Quick reference table:**

| # | Factor | Purpose | FAAFO Dimension | Time to Implement |
|---|--------|---------|-----------------|-------------------|
| **I** | [Automated Tracking](../../factors/01-automated-tracking.md) | Git as institutional memory | Autonomous | 5 min |
| **II** | [Context Loading](../../factors/02-context-loading.md) | Manage context budget (<40%) | Fast, Optionality | 15 min |
| **III** | [Focused Agents](../../factors/03-focused-agents.md) | One task per session | Autonomous | 5 min |
| **IV** | [Continuous Validation](../../factors/04-continuous-validation.md) | Catch errors early (5s) | Fast, Fun | 30 min |
| **V** | [Measure Everything](../../factors/05-measure-everything.md) | Track success rate, speedup | All dimensions | 15 min |
| **VI** | [Resume Work](../../factors/06-resume-work.md) | Multi-day session continuity | Optionality | 15 min |
| **VII** | [Smart Routing](../../factors/07-smart-routing.md) | Route tasks to specialists | Autonomous | 1 hour |
| **VIII** | [Human Validation](../../factors/08-human-validation.md) | Approval gates for risk | Autonomous | 30 min |
| **IX** | [Mine Patterns](../../factors/09-mine-patterns.md) | Extract learnings from history | Ambitious | 1 hour |
| **X** | [Small Iterations](../../factors/10-small-iterations.md) | Incremental improvements | All dimensions | 30 min |
| **XI** | [Fail-Safe Checks](../../factors/11-fail-safe-checks.md) | Prevent repeating mistakes | Fun | 1 hour |
| **XII** | [Package Patterns](../../factors/12-package-patterns.md) | Bundle reusable patterns | Ambitious | 30 min |

---

## FAAFO Dimensions

**Fast** - Deliver value quickly without sacrificing quality
- Factors: II (Context), IV (Validation), V (Measure)
- Target: 2-40x speedup
- Measure: Time per task (before vs after)

**Ambitious** - Tackle projects previously considered "impossible"
- Factors: IX (Mine Patterns), XII (Package Patterns)
- Target: 1 person = 5-10 person team
- Measure: Project scope increase

**Autonomous** - Minimal human intervention, high success rate
- Factors: I (Tracking), III (Focused), IV (Validation), VII (Routing), VIII (Human Validation)
- Target: 95% success rate
- Measure: Tasks successful / tasks attempted

**Fun** - Building is enjoyable, not debugging hell
- Factors: IV (Validation), XI (Fail-Safe)
- Target: 90% time building, 10% fixing
- Measure: Building time / total time

**Optionality** - Maintain choice and flexibility
- Factors: II (Context), VI (Resume Work)
- Target: <40% context budget per phase
- Measure: Parallel explorations possible

---

## Four Pillars

**DevOps/SRE** - Production rigor and reliability engineering
- Validation gates, CI/CD, monitoring, postmortems
- Applied in: Factors IV, V, VIII

**Learning Science** - How humans and systems acquire knowledge
- Working memory limits, cognitive load, spaced repetition
- Applied in: Factors II, III, VI, IX, X

**Context Engineering** - Managing information flow
- 40% rule, progressive disclosure, JIT loading
- Applied in: Factors II, VI, VII

**Knowledge OS** - Git as institutional memory
- Version control for knowledge work
- Applied in: Factors I, IX, XII

**[Deep dive →](../principles/five-pillars.md)**

---

## Five Laws

Mandatory principles for all AI workflows:

1. **ALWAYS Extract Learnings** - Transform experience into reusable knowledge
2. **ALWAYS Improve Self or System** - Continuous improvement is mandatory
3. **ALWAYS Document Context** - Preserve decisions and rationale
4. **ALWAYS Validate Before Execute** - Prevention is cheaper than recovery
5. **ALWAYS Share Patterns Publicly** - Build collective knowledge

**[Deep dive →](../principles/five-laws.md)**

---

## Key Metrics

### Success Rate
```
Success Rate = Tasks Successful / Tasks Attempted × 100%

Target: >90%
Baseline: 30-35%
Achieved: 95%
```

### Speedup
```
Speedup = Time Before / Time After

Target: >2x
Range: 2.7-40x (task dependent)
Example: Database deployment 4 hours → 90 seconds = 27x
```

### FAAFO Score
```
FAAFO Score = Average of 5 dimension scores (0-10 each)

Fast: Time reduction (0-10)
Ambitious: Scope increase (0-10)
Autonomous: Success rate (0-10)
Fun: Building vs fixing ratio (0-10)
Optionality: Context budget (0-10)

Target: >8/10
```

---

## Common Commands

### Validation
```bash
make quick       # 5s syntax check
make test        # 30s unit tests
make lint        # 30s code quality
make security    # 60s security scan
make all         # Full validation (2-3 min)
```

### Git Workflow
```bash
git add .
git commit       # Uses template from Factor I
git log          # See patterns (Factor IX)
```

### Pattern Library
```bash
ls .patterns/              # List patterns
cp .patterns/[name].py .  # Use pattern
```

### Session Management
```bash
ls .sessions/              # List sessions
cat .sessions/[date].md    # Load session context
```

---

## File Structure

```
project/
├── CLAUDE.md              # Context file (Factor II)
├── Makefile               # Validation gates (Factor IV)
├── METRICS.md             # Success tracking (Factor V)
├── .gitmessage            # Commit template (Factor I)
├── .patterns/             # Pattern library (Factor XII)
│   ├── README.md
│   └── [pattern-name].py
├── .sessions/             # Session notes (Factor VI)
│   └── YYYY-MM-DD-[task].md
└── src/                   # Your code
```

---

## Tool Recommendations

### Required
- **Git** - Version control (Factor I)
- **Make** - Validation orchestration (Factor IV)
- **AI Assistant** - Claude, Copilot, Cursor, etc.

### Recommended
- **pytest** - Python testing
- **ruff** - Python linting
- **mypy** - Python type checking
- **yamllint** - YAML validation
- **jq** - JSON validation

### Optional
- **uv** - Fast Python package manager
- **bandit** - Security scanning
- **safety** - Dependency security

---

## Quick Troubleshooting

| Problem | Likely Cause | Solution |
|---------|--------------|----------|
| Low success rate (<70%) | Context collapse | [Prevent Context Collapse](../how-to/prevent-context-collapse.md) |
| AI generates wrong code | Unfocused prompts | [Focused Agents](../../factors/03-focused-agents.md) |
| Validation takes too long | Too many checks | Start with `make quick` only |
| Can't resume work | Missing session notes | [Create Session Notes](../how-to/create-session-notes.md) |
| Repeating same mistakes | No fail-safe checks | [Implement Fail-Safe](../how-to/implement-failsafe-checks.md) |

---

## Glossary

**Context Collapse** - Performance degradation when context window exceeds 40% utilization

**Context Window** - Token limit for AI input (typically 200k tokens)

**FAAFO** - Fast, Ambitious, Autonomous, Fun, Optionality (north star philosophy)

**Factor** - One of 12 operational patterns (I-XII)

**JIT Loading** - Just-in-time context loading (load docs when needed, not upfront)

**Knowledge OS** - Git-based institutional memory system

**Pattern Library** - Collection of reusable, validated code patterns

**Session Notes** - Context documentation for multi-day work continuity

**Validation Gate** - Automated check before merge/deploy

**40% Rule** - Never exceed 40% of context window per phase

---

## Reference Documents

| Document | Description |
|----------|-------------|
| [Anthropic's Long-Running Agents](./anthropic-long-running-agents.md) | Anthropic's official pattern for multi-session agent memory |
| [Scientific Foundation](./scientific-foundation.md) | Cognitive science research behind the 40% rule |
| [Failure Patterns](./failure-patterns.md) | Common failure modes and prevention strategies |

---

## Related Resources

- **Main README:** [../../README.md](../../README.md)
- **Getting Started:** [../getting-started/](../getting-started/)
- **How-To Guides:** [../how-to/](../how-to/)
- **Explanation:** [../explanation/](../explanation/)
- **Case Studies:** [../case-studies/](../case-studies/)

---

**This is reference documentation - quick lookup, not tutorials.**

For step-by-step guides, see [Getting Started](../getting-started/) or [How-To Guides](../how-to/).
