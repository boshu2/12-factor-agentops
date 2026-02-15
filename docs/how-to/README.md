# How-To Guides

**Task-oriented guides for applying operational discipline with AI agents**

Choose the task you want to accomplish:

---

## Context & Focus

- **Context File Setup** - Create a CLAUDE.md, .cursorrules, or equivalent project context file (Factor I: Context Is Everything)
- **Prevent Context Collapse** - Keep context budget under 40% per phase (Factor I)
- **Scope Agent Work** - Give each agent a single, well-defined job (Factor III: One Agent, One Job)

---

## Research & Planning

- **Structured Research** - Use Research-Plan-Implement phasing before writing code (Factor IV: Research Before You Build)
- **Multi-Phase Workflows** - Break complex work into focused phases with clear handoffs

---

## Validation & Quality

- **External Validation** - Set up make quick/test/all pipelines for automated checks (Factor V: Validate Externally)
- **Pre-Commit Hooks** - Automate validation before every commit
- **Security Scans** - Integrate security checks into your workflow

---

## Progress & Session Management

- **Lock Progress Forward** - Commit incrementally so work is never lost (Factor VI: Lock Progress Forward)
- **Session Notes** - Capture context for multi-day project continuity
- **Git Workflow** - Use git as your institutional memory (Factor II: Track Everything in Git)

---

## Knowledge & Learning

- **Extract Learnings** - Turn session outcomes into reusable knowledge (Factor VII: Extract Learnings)
- **Build a Knowledge Base** - Compound knowledge across sessions using HERO pattern (Factor VIII: Compound Knowledge)
- **Track What Matters** - Measure success rates, speedup, and operational health (Factor IX: Measure What Matters)

---

## Scale (Multi-Agent)

- **Isolate Workers** - Give each agent its own worktree and environment (Factor X: Isolate Workers)
- **Hierarchical Supervision** - Set up supervisors to manage agent fleets (Factor XI: Supervise Hierarchically)
- **Harvest Failures** - Turn failures into documented wisdom that prevents recurrence (Factor XII: Harvest Failures as Wisdom)

---

## Debugging & Troubleshooting

- **Debug Context Collapse** - When AI output quality degrades mid-session
- **Fix Low Success Rates** - Below 70% success? Check context, validation, and focus
- **Optimize Slow Workflows** - Reduce cycle time without cutting corners

---

## By Factor

Find how-to guides organized by which factor they support:

| Tier | Factor | Key Tasks |
|------|--------|-----------|
| **Foundation** | **I: Context Is Everything** | Context file setup, prevent collapse |
| | **II: Track Everything in Git** | Git workflow, commit templates |
| | **III: One Agent, One Job** | Scope agent work, single-task sessions |
| **Workflow** | **IV: Research Before You Build** | Structured research, multi-phase workflows |
| | **V: Validate Externally** | Validation gates, pre-commit hooks, security scans |
| | **VI: Lock Progress Forward** | Session notes, incremental commits |
| **Knowledge** | **VII: Extract Learnings** | Post-session extraction, pattern capture |
| | **VIII: Compound Knowledge** | HERO pattern, knowledge base setup |
| | **IX: Measure What Matters** | Success tracking, speedup measurement |
| **Scale** | **X: Isolate Workers** | Worker isolation, dedicated worktrees |
| | **XI: Supervise Hierarchically** | Supervisor setup, fleet management |
| | **XII: Harvest Failures as Wisdom** | Failure documentation, prevention patterns |

---

## Quick Reference

**Start here based on your situation:**

1. **New to 12-Factor AgentOps?** -- Read [Getting Started](../getting-started/) first, then set up a context file
2. **Context collapse issues?** -- Focus on Factor I (context budget) and Factor III (agent focus)
3. **Low success rate?** -- Add external validation (Factor V) and research phasing (Factor IV)
4. **Knowledge keeps getting lost?** -- Extract learnings (Factor VII) and compound them (Factor VIII)
5. **Scaling to multiple agents?** -- Start with isolation (Factor X), then add supervision (Factor XI)

---

**This is task-oriented documentation.** For background and theory, see [Explanation](../explanation/). For quick lookup, see [Reference](../reference/).
