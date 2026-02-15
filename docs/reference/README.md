# Reference Documentation

**Information-oriented quick lookup**

---

## The 12 Factors

### Foundation (I-III)

| # | Factor | Purpose |
|---|--------|---------|
| **I** | [Context Is Everything](../../factors/01-context-is-everything.md) | Manage context budget; load the right information at the right time |
| **II** | [Track Everything in Git](../../factors/02-track-everything-in-git.md) | Git as institutional memory for decisions, patterns, and history |
| **III** | [One Agent, One Job](../../factors/03-one-agent-one-job.md) | Each agent gets a single, well-scoped task |

### Workflow (IV-VI)

| # | Factor | Purpose |
|---|--------|---------|
| **IV** | [Research Before You Build](../../factors/04-research-before-you-build.md) | Understand the problem space before writing code |
| **V** | [Validate Externally](../../factors/05-validate-externally.md) | Automated checks that catch errors the agent cannot see |
| **VI** | [Lock Progress Forward](../../factors/06-lock-progress-forward.md) | Commit incrementally so work is never lost |

### Knowledge (VII-IX)

| # | Factor | Purpose |
|---|--------|---------|
| **VII** | [Extract Learnings](../../factors/07-extract-learnings.md) | Turn session outcomes into reusable knowledge |
| **VIII** | [Compound Knowledge](../../factors/08-compound-knowledge.md) | HERO pattern: knowledge grows across sessions |
| **IX** | [Measure What Matters](../../factors/09-measure-what-matters.md) | Track the metrics that drive improvement |

### Scale (X-XII, optional)

| # | Factor | Purpose |
|---|--------|---------|
| **X** | [Isolate Workers](../../factors/10-isolate-workers.md) | Each agent gets its own worktree and environment |
| **XI** | [Supervise Hierarchically](../../factors/11-supervise-hierarchically.md) | Supervisors manage agent fleets, not humans directly |
| **XII** | [Harvest Failures as Wisdom](../../factors/12-harvest-failures-as-wisdom.md) | Failures become documented prevention patterns |

---

## Four Tiers

The 12 factors are organized into four tiers of increasing sophistication:

**Foundation (I-III)** -- Get these right first. Context management, git discipline, and focused agents form the base that everything else builds on.

**Workflow (IV-VI)** -- The operational loop. Research before building, validate with external tools, and lock progress forward through incremental commits.

**Knowledge (VII-IX)** -- The compounding engine. Extract learnings, compound them across sessions, and measure the metrics that actually matter.

**Scale (X-XII)** -- Optional. For teams running multiple agents. Worker isolation, hierarchical supervision, and systematic failure harvesting.

---

## Key Metrics

### Success Rate
```
Success Rate = Tasks Successful / Tasks Attempted x 100%

Target: >90%
Baseline: 30-35% (without operational discipline)
Achievable: 95% (with consistent practice)
```

### Speedup
```
Speedup = Time Before / Time After

Target: >2x
Range: 2.7-40x (task dependent)
Example: Database deployment 4 hours -> 90 seconds = 27x
```

---

## Common Commands

### Validation (Factor V)
```bash
make quick       # 5s syntax check
make test        # 30s unit tests
make lint        # 30s code quality
make security    # 60s security scan
make all         # Full validation (2-3 min)
```

### Git Workflow (Factor II)
```bash
git add .
git commit       # Commit template captures decisions
git log          # Review history for patterns
```

### Session Management (Factor VI)
```bash
ls .sessions/              # List sessions
cat .sessions/[date].md    # Load session context
```

---

## File Structure

```
project/
├── CLAUDE.md              # Context file (Factor I)
├── Makefile               # Validation gates (Factor V)
├── learnings.md           # Extracted knowledge (Factor VII)
├── .gitmessage            # Commit template (Factor II)
├── .sessions/             # Session notes (Factor VI)
│   └── YYYY-MM-DD-[task].md
└── src/                   # Your code
```

---

## Quick Troubleshooting

| Problem | Likely Cause | Factor to Review |
|---------|--------------|------------------|
| Low success rate (<70%) | Context overload or missing validation | I: Context Is Everything, V: Validate Externally |
| Agent generates wrong code | Unclear scope or missing research | III: One Agent One Job, IV: Research Before You Build |
| Same mistakes repeated | No learning extraction | VII: Extract Learnings, XII: Harvest Failures as Wisdom |
| Can't resume work | Missing session notes | VI: Lock Progress Forward |
| Validation takes too long | Over-scoped checks | Start with `make quick` only |

---

## Glossary

**Compound Knowledge** -- Knowledge that grows across sessions through extraction, storage, and re-injection (HERO pattern)

**Context Collapse** -- Performance degradation when context window exceeds 40% utilization

**Context Window** -- Token limit for AI input (typically 200k tokens)

**Factor** -- One of 12 operational patterns (I-XII) organized in four tiers

**HERO** -- Harvest, Extract, Reinject, Optimize -- the knowledge compounding loop

**Knowledge OS** -- Git-based institutional memory system

**Operational Discipline** -- The practice of applying consistent, repeatable processes to AI agent work

**Session Notes** -- Context documentation for multi-day work continuity

**Validation Gate** -- Automated external check that catches errors the agent cannot see

**40% Rule** -- Never exceed 40% of context window per phase

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
- **Principles:** [../principles/](../principles/)

---

**This is reference documentation -- quick lookup, not tutorials.**

For step-by-step guides, see [Getting Started](../getting-started/) or [How-To Guides](../how-to/).
