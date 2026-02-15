<div align="center">

# 12-Factor AgentOps

### The Operational Discipline for Working With AI Agents

Principles that turn ad-hoc agent usage into a reliable, compounding practice.

<!-- Build & Status -->
[![CI](https://img.shields.io/github/actions/workflow/status/boshu2/12-factor-agentops/validate-profiles.yml?label=CI)](https://github.com/boshu2/12-factor-agentops/actions)
[![Version](https://img.shields.io/badge/Version-3.0.0-blue.svg)](https://github.com/boshu2/12-factor-agentops/releases)

<!-- Technology -->
[![12 Factors](https://img.shields.io/badge/Factors-12-00CED1.svg)](factors/)
[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![GitHub Stars](https://img.shields.io/github/stars/boshu2/12-factor-agentops?style=social)](https://github.com/boshu2/12-factor-agentops)

</div>

---

## The Problem

Every agent session starts from zero. Same context problems. Same mistakes repeated. Same rework. You get good results sometimes and bad results other times, with no idea why. Your agent forgets everything between sessions — every conversation is like training a new junior developer.

**The model isn't the problem. The operations are.**

Most people blame the model when they get bad results. The real problem is how they operate: overloaded context windows, no session memory, no validation, no learning loops. Fix the operations and the same model performs dramatically better.

## The Solution: Knowledge Compounds

12-Factor AgentOps makes each session smarter than the last. Not through better models — through better operations.

**Session 1:** Your agent knows nothing about your codebase. It makes common mistakes. It ignores your conventions. It writes code that doesn't fit.

**Session 10:** Your agent knows your patterns. It avoids documented pitfalls. It follows your conventions because they're in the context.

**Session 100:** Your agent operates with institutional memory. It knows what's been tried and failed. It knows why architectural decisions were made. It builds on everything that came before.

**The hook:** Knowledge compounding is the one thing no amount of model improvement replaces. Better models with amnesia still repeat your mistakes.

---

## Quickstart: 5 Minutes, Zero Infrastructure

No plugins, no tooling, no setup. Just a text file and discipline.

**Step 1:** Create a `learnings.md` file in your project root.

**Step 2:** After each agent session, append what worked and what didn't:

```markdown
## Auth Middleware (2026-02-15)
- CORS requires explicit OPTIONS preflight handlers. Default config silently drops them.
- Session tokens must be validated server-side; client-side checks are insufficient.
- The auth middleware chain is: rate-limit → CORS → session → route handler.
```

**Step 3:** Point your agent at it on startup. In Claude Code, add to `CLAUDE.md`:

```markdown
Read learnings.md before starting any task.
```

In Cursor, add to `.cursorrules`. In Codex, add to `AGENTS.md`. The mechanism varies; the principle doesn't.

**That's it.** You're now doing Factors I (context management), II (git tracking), and VII (knowledge extraction) at a basic level. Your agent will stop repeating documented mistakes immediately.

**When to level up:** When `learnings.md` exceeds ~50 entries or you stop reading it before sessions, you're ready for more structure.

---

## The 12 Factors

Twelve vendor-neutral principles organized in four tiers. Start at the top. Each tier builds on the previous one. You can stop at any tier and keep the value.

### Foundation (I–III) — Start Here

Non-negotiable basics that work with zero tooling. Get these wrong and nothing else matters.

| # | Factor | The Rule |
|---|--------|----------|
| **[I](./factors/01-context-is-everything.md)** | **Context Is Everything** | Manage what enters the context window like you manage what enters production. |
| **[II](./factors/02-track-everything-in-git.md)** | **Track Everything in Git** | If it's not in git, it didn't happen. |
| **[III](./factors/03-one-agent-one-job.md)** | **One Agent, One Job** | Each agent gets a scoped task and fresh context. Never reuse a saturated window. |

**Without tooling:** Keep sessions short. Start fresh for new tasks. Write handoff summaries. Commit your `learnings.md`. One issue per agent session.

### Workflow (IV–VI) — The Discipline

How work flows through agents. The discipline that separates "prompting and hoping" from a reliable operating model.

| # | Factor | The Rule |
|---|--------|----------|
| **[IV](./factors/04-research-before-you-build.md)** | **Research Before You Build** | Understand the problem space before generating a single line of code. |
| **[V](./factors/05-validate-externally.md)** | **Validate Externally** | No agent grades its own work. Ever. |
| **[VI](./factors/06-lock-progress-forward.md)** | **Lock Progress Forward** | Once work passes validation, it ratchets — it cannot regress. |

**Without tooling:** Research before implementing. Have a different session (or human) review the work. Commit validated work to protected branches.

### Knowledge (VII–IX) — Where Compounding Kicks In

Systematic extraction and injection of knowledge. This is where sessions start getting measurably smarter over time.

| # | Factor | The Rule |
|---|--------|----------|
| **[VII](./factors/07-extract-learnings.md)** | **Extract Learnings** | Every session produces two outputs — the work product and the lessons learned. |
| **[VIII](./factors/08-compound-knowledge.md)** | **Compound Knowledge** | Learnings must flow back into future sessions automatically. |
| **[IX](./factors/09-measure-what-matters.md)** | **Measure What Matters** | Track fitness toward goals, not activity metrics. |

**Factor VIII is the hero.** It's the knowledge flywheel: extract learnings, gate for quality, inject into future sessions, measure retrieval, let stale knowledge decay. This is the differentiator that can't be commoditized — better models don't replace institutional memory.

**Without tooling:** Manually update `learnings.md` after each session. Review it weekly and prune stale entries. It's tedious but it works. The AgentOps plugin automates this — but the principle is portable.

### Scale (X–XII) — Advanced, Optional

Multi-agent orchestration patterns. **Skip this entire tier if you work solo.** You lose nothing. These patterns apply when you're running parallel agents on complex projects.

| # | Factor | The Rule |
|---|--------|----------|
| **[X](./factors/10-isolate-workers.md)** | **Isolate Workers** | Each worker gets its own workspace, its own context, and zero shared mutable state. |
| **[XI](./factors/11-supervise-hierarchically.md)** | **Supervise Hierarchically** | Escalation flows up, never sideways. |
| **[XII](./factors/12-harvest-failures-as-wisdom.md)** | **Harvest Failures as Wisdom** | Failed attempts are data. Extract and index them with the same rigor as successes. |

**Without tooling:** Use git worktrees for parallel work. Designate one person (or agent) as coordinator. Document what doesn't work alongside what does.

---

## Why These Factors?

### For the Solo Developer

You use Claude Code, Cursor, or Codex daily. Some sessions produce great results. Others are frustrating wastes of time. The difference isn't the model — it's the context.

Factors I-III give you immediate improvement: keep context focused, track what you learn, start fresh for each task. Factor VII (extracting learnings) and Factor VIII (compounding knowledge) make each session build on the last.

### For the Tech Lead

Your team runs agents in parallel. Work conflicts. Learnings from one developer's sessions don't help others. There's no consistent quality bar.

Factors IV-VI add workflow discipline: research first, validate externally, lock progress forward. Factor VIII gives you shared institutional memory. Scale factors (X-XII) provide isolation and coordination patterns.

### For the Tool Builder

You're designing agent tooling and need proven operational principles. Every framework reinvents context management, validation, and knowledge persistence from scratch.

These 12 factors are the shared vocabulary. They're vendor-neutral, grounded in 20+ years of DevOps and SRE practice, and tested in production.

---

## Adoption Path

You can start with zero infrastructure and level up when you need to:

```
Quickstart (5 min)     → learnings.md file, zero tooling
Foundation (I-III)     → Context discipline, git tracking, fresh sessions
Workflow (IV-VI)       → Research, validation, ratcheting
Knowledge (VII-IX)     → Extraction, compounding, measurement
Scale (X-XII)          → Multi-agent isolation, supervision, failure harvesting (OPTIONAL)
```

**Key principle:** You can stop at any level and keep the value. Each level justifies the next, but none requires it.

**When to level up:**
- **Quickstart → Foundation:** When your `learnings.md` gets unwieldy or you notice repeated context problems
- **Foundation → Workflow:** When you find yourself re-explaining codebase patterns to new sessions
- **Workflow → Knowledge:** When the same mistakes recur across sessions despite research
- **Knowledge → Scale:** When you're running multiple agents in parallel and conflicts emerge

---

## Where This Comes From

These principles stand on decades of proven methodology:

| Source | Factors |
|--------|---------|
| **DevOps practices** (20+ years) | I, V, VI, IX |
| **Site Reliability Engineering** (Google, 15+ years) | V, VI, IX |
| **Cognitive load theory** (Sweller, 1988) | I, III |
| **Unix philosophy** (1978) | III |
| **GitOps methodology** (10+ years) | II |
| **Microservices patterns** (10+ years) | III, X, XI |
| **Zero-trust architecture** (10+ years) | V |
| **Learning science** (decades) | VII, VIII, XII |

### Related Projects

| Project | Relationship |
|---------|-------------|
| [12-Factor App](https://12factor.net) (Heroku, 2011) | How to build cloud-native apps. We're how to operate with agents. |
| [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (HumanLayer) | How to *build* agent applications. We're how to *operate with* them. |
| [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) (Gene Kim, Steve Yegge) | The methodology of AI-assisted coding. We're the operational discipline underneath. |

---

## Reference Implementation

The [AgentOps plugin](https://github.com/boshu2/agentops) is the reference implementation of these factors for Claude Code. It automates the knowledge flywheel (extraction, quality gating, semantic retrieval, decay management), provides research and planning skills, and implements multi-agent coordination patterns.

**But the plugin is not a prerequisite.** Every factor in this document can be applied manually with zero tooling. The principles are universal; the automation is optional.

---

## Contributing

Try the factors in your context. Document what works and what doesn't. Share via issues or PRs.

The factors evolve through production validation and community feedback.

**License:** CC BY-SA 4.0 (content) / Apache 2.0 (code)

---

## Version History

- **v1.0** (2025-01-27): Initial twelve factors — coding agent validation focus
- **v2.0** (2025-12-27): Production implementation patterns added
- **v3.0** (2026-02-15): Pivot to full operational discipline. Factors rewritten. Adoption model inverted (results-first, not manifesto-first). Knowledge compounding as hero differentiator. Scale factors marked optional.
