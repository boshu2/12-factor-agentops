# 12-Factor AgentOps -- Summary

**The Operational Discipline for Working With AI Agents**

Twelve vendor-neutral principles that turn ad-hoc agent usage into a reliable,
compounding practice. The model is not the problem. The operations are.

---

## The Core Problem

Every agent session starts from zero. Same context problems. Same mistakes
repeated. Same rework. People blame the model when they get bad results.
The real problem is how they operate.

**The solution:** Operational discipline that makes knowledge compound over time.

```
Research --> Plan --> Implement --> Validate --> Extract --> Compound
```

---

## We Are / We Are Not

**We are:** Operational principles for working with AI agents -- the discipline
underneath build methodologies like Vibe Coding, GSD, and Superpowers.

**We are not:** A framework for building autonomous agent applications. For that,
see [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) by Dex Horthy.

---

## The 12 Factors

### Foundation (I--III) -- Start Here

Non-negotiable basics. Zero tooling required. Get these wrong and nothing else matters.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[I](../factors/01-context-is-everything.md)** | **Context Is Everything** | Manage what enters the context window like you manage what enters production. |
| **[II](../factors/02-track-everything-in-git.md)** | **Track Everything in Git** | If it is not in git, it did not happen -- learnings, decisions, and knowledge live alongside code. |
| **[III](../factors/03-one-agent-one-job.md)** | **One Agent, One Job** | Each agent gets a scoped task and fresh context; never reuse a saturated window. |

### Workflow (IV--VI) -- The Discipline

How work flows through agents. The discipline that separates "prompting and hoping"
from a reliable operating model.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[IV](../factors/04-research-before-you-build.md)** | **Research Before You Build** | Understand the problem space before generating a single line of code. |
| **[V](../factors/05-validate-externally.md)** | **Validate Externally** | No agent grades its own work -- tests, linters, separate sessions, or humans validate. |
| **[VI](../factors/06-lock-progress-forward.md)** | **Lock Progress Forward** | Once work passes validation, it ratchets forward and cannot regress. |

### Knowledge (VII--IX) -- Where Compounding Kicks In

Systematic extraction and injection of knowledge. This is where sessions start
getting measurably smarter over time.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[VII](../factors/07-extract-learnings.md)** | **Extract Learnings** | Every session produces two outputs: the work product and the lessons learned. |
| **[VIII](../factors/08-compound-knowledge.md)** | **Compound Knowledge** | Learnings flow back into future sessions automatically -- extract, gate, inject, measure, decay. |
| **[IX](../factors/09-measure-what-matters.md)** | **Measure What Matters** | Track fitness toward goals, not activity metrics. |

> **Factor VIII is the hero.** It implements the knowledge flywheel -- the
> compounding loop that cannot be commoditized. Better models with amnesia still
> repeat your mistakes. Knowledge compounding is the one capability no amount of
> model improvement replaces.

### Scale (X--XII) -- Advanced, Optional

Multi-agent orchestration. Skip this tier entirely if you work solo. These
patterns apply only when running parallel agents on complex projects.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[X](../factors/10-isolate-workers.md)** | **Isolate Workers** | Each worker gets its own workspace, context, and zero shared mutable state. |
| **[XI](../factors/11-supervise-hierarchically.md)** | **Supervise Hierarchically** | Escalation flows up, never sideways -- one coordinator dispatches, workers execute. |
| **[XII](../factors/12-harvest-failures-as-wisdom.md)** | **Harvest Failures as Wisdom** | Failed attempts are data -- extract and index them with the same rigor as successes. |

---

## Adoption Path

Start with results, adopt principles as pain points emerge. You can stop at any
tier and keep the value.

```
Quickstart (5 min)     --> learnings.md file, zero tooling
Foundation (I-III)     --> Context discipline, git tracking, fresh sessions
Workflow (IV-VI)       --> Research, external validation, ratcheting
Knowledge (VII-IX)     --> Extraction, compounding, measurement
Scale (X-XII)          --> Multi-agent isolation, supervision, failure harvesting
```

| Transition | Trigger |
|------------|---------|
| Quickstart to Foundation | learnings.md gets unwieldy or context problems recur |
| Foundation to Workflow | You keep re-explaining codebase patterns to new sessions |
| Workflow to Knowledge | The same mistakes recur across sessions despite research |
| Knowledge to Scale | Multiple parallel agents cause conflicts |

---

## Quick Reference by Pain Point

| Pain Point | Start With |
|------------|------------|
| Agent claims tests pass but code is broken | Factor V: Validate Externally |
| Context problems, instruction loss | Factor I: Context Is Everything |
| Scope creep, tangled implementations | Factor III: One Agent, One Job |
| Same mistakes repeated across sessions | Factor VIII: Compound Knowledge |
| No understanding before implementation | Factor IV: Research Before You Build |
| Cannot resume work across sessions | Factor VI: Lock Progress Forward |
| No visibility into what is working | Factor IX: Measure What Matters |
| Multi-agent workspace conflicts | Factor X: Isolate Workers |

---

## Further Reading

- [Factors (detailed)](../factors/README.md)
- [Getting Started](getting-started/quick-start.md)
- [Principles](principles/README.md)
- [Reference](reference/README.md)

---

**Version:** 3.0.0 | **Updated:** 2026-02-15
