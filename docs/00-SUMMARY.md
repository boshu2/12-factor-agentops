# 12-Factor AgentOps -- Summary

**The Principles Behind the Operational Layer for Coding Agents**

Twelve vendor-neutral principles that turn ad-hoc agent usage into a reliable,
compounding practice. The model is not the problem. The operations are.

---

## The Core Problem

Every agent session starts from zero. Same context problems. Same mistakes
repeated. Same rework. People blame the model when they get bad results.
The real problem is how they operate.

**The solution:** Operational discipline that makes bookkeeping and validation
compound over time.

```
Research --> Plan --> Implement --> Validate --> Extract --> Compound
```

---

## We Are / We Are Not

**We are:** The doctrine behind the operational layer for coding agents -- the
discipline underneath build methodologies like Vibe Coding, GSD, and
Superpowers.

**We are not:** A framework for building autonomous agent applications. For that,
see [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) by Dex Horthy.

---

## The 12 Factors

### Prepare (I--III) -- Start Here

Non-negotiable basics. Zero tooling required. Get these wrong and nothing else matters.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[I](../factors/01-context-is-everything.md)** | **Context Is Everything** | Manage what enters the context window like you manage what enters production. |
| **[II](../factors/02-track-everything-in-git.md)** | **Track Everything in Git** | If it is not in git, it did not happen -- learnings, decisions, and knowledge live alongside code. |
| **[III](../factors/03-one-agent-one-job.md)** | **One Agent, One Job** | Each agent gets a scoped task and fresh context; never reuse a saturated window. |

### Bound (IV--VI) -- The Discipline

How work is bounded before agents run. The discipline that separates "prompting and hoping"
from a reliable operating model.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[IV](../factors/04-enforce-least-privilege.md)** | **Enforce Least Privilege** | An agent acts inside a least-privilege envelope it cannot widen -- not even on untrusted input. |
| **[V](../factors/05-research-before-you-build.md)** | **Research Before You Build** | Understand the problem space before generating a single line of code. |
| **[VI](../factors/06-isolate-workers.md)** | **Isolate Workers** | Each worker gets its own workspace, context, and zero shared mutable state. |

### Select (VII--IX) -- Where Compounding Kicks In

Validate, lock, and extract -- selecting the work that holds. This is where sessions
start getting measurably smarter over time.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[VII](../factors/07-validate-externally.md)** | **Validate Externally** | The worker reports evidence; an independent checker writes the binding verdict. No agent grades its own work. |
| **[VIII](../factors/08-lock-progress-forward.md)** | **Lock Progress Forward** | Once work passes validation, it ratchets forward and cannot regress. |
| **[IX](../factors/09-extract-learnings.md)** | **Extract Learnings** | Every session produces two outputs: the work product and the lessons learned. |

### Govern (X--XII) -- The Factory Altitude

The same factors at fleet scale. Working solo, you live them in miniature -- a
git worktree is isolation, your own judgment is supervision, your `learnings.md`
is failure harvesting -- so you grow into the altitude rather than skipping the
factors.

| # | Factor | One-Line Rule |
|---|--------|---------------|
| **[X](../factors/10-compound-knowledge.md)** | **Compound Knowledge** | Learnings flow back into future sessions automatically -- extract, gate, inject, measure, decay; dead ends become routing hints that prune the next agent's search. |
| **[XI](../factors/11-supervise-hierarchically.md)** | **Supervise Hierarchically** | Escalation flows up, never sideways -- one coordinator dispatches, workers execute. |
| **[XII](../factors/12-measure-outcomes.md)** | **Measure Outcomes** | Track fitness toward goals, not activity metrics. |

> **Factor X is the hero.** It implements the knowledge flywheel -- the
> compounding loop that cannot be commoditized. Better models with amnesia still
> repeat your mistakes. Knowledge compounding is the one capability no amount of
> model improvement replaces.

---

## Adoption Path

Start with results, adopt principles as pain points emerge. You can stop at any
tier and keep the value.

```
Quickstart (5 min)     --> learnings.md file, zero tooling
Prepare (I-III)        --> Context discipline, git tracking, fresh sessions
Bound (IV-VI)          --> Least privilege, research, worker isolation
Select (VII-IX)        --> External validation, ratcheting, extraction
Govern (X-XII)         --> Knowledge compounding, supervision, measurement
```

| Transition | Trigger |
|------------|---------|
| Quickstart to Prepare | learnings.md gets unwieldy or context problems recur |
| Prepare to Bound | You keep re-explaining codebase patterns to new sessions |
| Bound to Select | The same mistakes recur across sessions despite research |
| Select to Govern | Multiple parallel agents cause conflicts |

---

## Quick Reference by Pain Point

| Pain Point | Start With |
|------------|------------|
| Agent claims tests pass but code is broken | Factor VII: Validate Externally |
| Context problems, instruction loss | Factor I: Context Is Everything |
| Scope creep, tangled implementations | Factor III: One Agent, One Job |
| Same mistakes repeated across sessions | Factor X: Compound Knowledge |
| No understanding before implementation | Factor V: Research Before You Build |
| Agent over-reaches its permissions | Factor IV: Enforce Least Privilege |
| Cannot resume work across sessions | Factor VIII: Lock Progress Forward |
| No visibility into what is working | Factor XII: Measure Outcomes |
| Multi-agent workspace conflicts | Factor VI: Isolate Workers |

---

## Further Reading

- [Factors (detailed)](../factors/README.md)
- [Getting Started](getting-started/quick-start.md)
- [Principles](principles/README.md)
- [Reference](reference/README.md)

---

**Version:** 3.0.0 | **Updated:** 2026-02-15
