# Reference Documentation

**Information-oriented quick lookup**

---

## The 12 Factors

### Prepare (I-III)

| # | Factor | Purpose |
|---|--------|---------|
| **I** | [Context Is Everything](../../factors/01-context-is-everything.md) | Manage context budget; load the right information at the right time |
| **II** | [Track Everything in Git](../../factors/02-track-everything-in-git.md) | Git as institutional memory for decisions, patterns, and history |
| **III** | [One Agent, One Job](../../factors/03-one-agent-one-job.md) | Each agent gets a single, well-scoped task |

### Bound (IV-VI)

| # | Factor | Purpose |
|---|--------|---------|
| **IV** | [Enforce Least Privilege](../../factors/04-enforce-least-privilege.md) | An agent acts inside a least-privilege envelope it cannot widen -- not even on untrusted input |
| **V** | [Research Before You Build](../../factors/05-research-before-you-build.md) | Understand the problem space before writing code |
| **VI** | [Isolate Workers](../../factors/06-isolate-workers.md) | Each agent gets its own worktree and environment |

### Select (VII-IX)

| # | Factor | Purpose |
|---|--------|---------|
| **VII** | [Validate Externally](../../factors/07-validate-externally.md) | Automated checks that catch errors the agent cannot see |
| **VIII** | [Lock Progress Forward](../../factors/08-lock-progress-forward.md) | Commit incrementally so work is never lost |
| **IX** | [Extract Learnings](../../factors/09-extract-learnings.md) | Turn session outcomes into reusable knowledge |

### Govern (X-XII) — the factory altitude

| # | Factor | Purpose |
|---|--------|---------|
| **X** | [Compound Knowledge](../../factors/10-compound-knowledge.md) | HERO pattern: knowledge grows across sessions; failures become documented prevention patterns |
| **XI** | [Supervise Hierarchically](../../factors/11-supervise-hierarchically.md) | Supervisors manage agent fleets, not humans directly |
| **XII** | [Measure Outcomes](../../factors/12-measure-outcomes.md) | Track the metrics that drive improvement |

---

## Four Tiers

The 12 factors are organized into four tiers of increasing sophistication:

**Prepare (I-III)** -- Get these right first. Context management, git discipline, and focused agents form the base that everything else builds on.

**Bound (IV-VI)** -- Bound the work before agents run. Enforce least privilege, research before building, and isolate workers so they cannot collide.

**Select (VII-IX)** -- Select the work that holds. Validate with external tools, lock progress forward through incremental commits, and extract learnings from every session.

**Govern (X-XII)** -- The factory altitude: the same factors at fleet scale. Solo, you live them in miniature (a worktree is isolation, your judgment is supervision); running multiple agents, they become structural — knowledge compounding, hierarchical supervision, and outcome measurement. You grow into the altitude, you don't skip the factors.

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

### Validation (Factor VII)
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

### Session Management (Factor VIII)
```bash
ls .sessions/              # List sessions
cat .sessions/[date].md    # Load session context
```

---

## File Structure

```
project/
├── CLAUDE.md              # Context file (Factor I)
├── Makefile               # Validation gates (Factor VII)
├── learnings.md           # Extracted knowledge (Factor IX)
├── .gitmessage            # Commit template (Factor II)
├── .sessions/             # Session notes (Factor VIII)
│   └── YYYY-MM-DD-[task].md
└── src/                   # Your code
```

---

## Quick Troubleshooting

| Problem | Likely Cause | Factor to Review |
|---------|--------------|------------------|
| Low success rate (<70%) | Context overload or missing validation | I: Context Is Everything, VII: Validate Externally |
| Agent generates wrong code | Unclear scope or missing research | III: One Agent One Job, V: Research Before You Build |
| Same mistakes repeated | No learning extraction | IX: Extract Learnings, X: Compound Knowledge |
| Can't resume work | Missing session notes | VIII: Lock Progress Forward |
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
| --- | --- |
| [Anthropic's Long-Running Agents](./anthropic-long-running-agents.md) | Anthropic's official pattern for multi-session agent memory |
| [JobSpec v0 RFC](./jobspec-openapi-v0-rfc.md) | Daemon job API contract |
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
