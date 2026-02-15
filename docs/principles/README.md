# Principles

**The philosophical and theoretical foundations of 12-Factor AgentOps: The Operational Discipline for Working With AI Agents.**

This directory contains deep dives into the core concepts that underpin the framework. These documents explore the **WHY** behind the practices. For the operational **WHAT**, see the [12 Factors](../../factors/README.md).

---

## The 12 Factors at a Glance

Twelve vendor-neutral principles organized in four tiers. Each tier builds on the previous one. You can stop at any tier and keep the value.

### Foundation (I-III) -- Non-negotiable basics

| # | Factor | The Rule |
|---|--------|----------|
| **[I](../../factors/01-context-is-everything.md)** | **Context Is Everything** | Manage what enters the context window like you manage what enters production. |
| **[II](../../factors/02-track-everything-in-git.md)** | **Track Everything in Git** | If it's not in git, it didn't happen. |
| **[III](../../factors/03-one-agent-one-job.md)** | **One Agent, One Job** | Each agent gets a scoped task and fresh context. Never reuse a saturated window. |

### Workflow (IV-VI) -- The discipline that separates prompting from operating

| # | Factor | The Rule |
|---|--------|----------|
| **[IV](../../factors/04-research-before-you-build.md)** | **Research Before You Build** | Understand the problem space before generating a single line of code. |
| **[V](../../factors/05-validate-externally.md)** | **Validate Externally** | No agent grades its own work. Ever. |
| **[VI](../../factors/06-lock-progress-forward.md)** | **Lock Progress Forward** | Once work passes validation, it ratchets -- it cannot regress. |

### Knowledge (VII-IX) -- Where compounding kicks in

| # | Factor | The Rule |
|---|--------|----------|
| **[VII](../../factors/07-extract-learnings.md)** | **Extract Learnings** | Every session produces two outputs -- the work product and the lessons learned. |
| **[VIII](../../factors/08-compound-knowledge.md)** | **Compound Knowledge** | Learnings must flow back into future sessions automatically. |
| **[IX](../../factors/09-measure-what-matters.md)** | **Measure What Matters** | Track fitness toward goals, not activity metrics. |

**Factor VIII is the hero.** It is the knowledge flywheel: extract learnings, gate for quality, inject into future sessions, measure retrieval, let stale knowledge decay. This is the differentiator that no amount of model improvement replaces -- better models with amnesia still repeat your mistakes.

### Scale (X-XII) -- Advanced, optional

Multi-agent orchestration patterns. Skip this tier if you work solo.

| # | Factor | The Rule |
|---|--------|----------|
| **[X](../../factors/10-isolate-workers.md)** | **Isolate Workers** | Each worker gets its own workspace, its own context, and zero shared mutable state. |
| **[XI](../../factors/11-supervise-hierarchically.md)** | **Supervise Hierarchically** | Escalation flows up, never sideways. |
| **[XII](../../factors/12-harvest-failures-as-wisdom.md)** | **Harvest Failures as Wisdom** | Failed attempts are data. Extract and index them with the same rigor as successes. |

---

## Foundation Documents

### [Constraint-Based Engineering](./constraint-based-engineering.md)

**Read time:** 25 minutes
**When to read:** Understanding the meta-philosophy that generates the entire framework

The core insight: you cannot eliminate constraints. You can only architect optimally within them. This shift from capability-first to constraint-first thinking is what makes the 12 factors universal rather than situational. Covers the 5-step methodology, how constraints produce factors, and production examples from constrained environments.

---

### [Evolution of 12-Factor](./evolution-of-12-factor.md)

**Read time:** 12 minutes
**When to read:** Understanding how this framework relates to the original 12-Factor App and 12-Factor Agents

Traces the lineage from Heroku's 12-Factor App (2011) through 12-Factor Agents (2025) to 12-Factor AgentOps v3 (2026). Shows why AI operations require an operational discipline layer beyond application architecture.

**See also:** [Comparison Table](./comparison-table.md) for a detailed factor-by-factor mapping across all three frameworks.

---

### [Context Engineering](./context-engineering.md)

**Read time:** 15 minutes
**When to read:** Understanding the 40% rule and cognitive load management

Both human cognition and AI context windows show catastrophic performance degradation around 40% capacity utilization. Covers the derivation, just-in-time loading strategies, and empirical validation. Directly supports Factor I (Context Is Everything) and Factor III (One Agent, One Job).

---

### [Knowledge OS](./knowledge-os.md)

**Read time:** 15 minutes
**When to read:** Understanding git as institutional memory

Git is not just version control -- it is the operating system for institutional knowledge. Commits as memory writes, branches as process isolation, merges as knowledge integration, history as audit trail. Directly supports Factor II (Track Everything in Git) and Factor VIII (Compound Knowledge).

---

## The Knowledge Flywheel

The central mechanism of 12-Factor AgentOps. Every factor contributes to it; Factor VIII (Compound Knowledge) is its beating heart.

```
              Extract (Factor VII)
                    |
                    v
    Session --> Learnings --> Quality Gate
                                  |
                                  v
    Measure (Factor IX) <-- Knowledge Base --> Inject (Factor I)
         |                                         |
         v                                         v
    Decay / Prune                          Next Session (smarter)
```

**The cycle:**
1. **Extract** -- Every session produces learnings alongside work product (Factor VII)
2. **Gate** -- Learnings pass quality checks before entering the knowledge base (Factor V)
3. **Inject** -- Future sessions load relevant knowledge just-in-time (Factor I)
4. **Measure** -- Track whether injected knowledge improves outcomes (Factor IX)
5. **Decay** -- Stale knowledge loses priority; wrong knowledge gets pruned

This is the differentiator that cannot be commoditized. Better models do not replace institutional memory.

---

## Recommended Reading Order

### For newcomers

1. [Five Pillars](./five-pillars.md) -- get the big picture (20 min)
2. [Context Engineering](./context-engineering.md) -- learn the 40% rule (15 min)
3. [Knowledge OS](./knowledge-os.md) -- see how knowledge compounds (15 min)
4. [Evolution of 12-Factor](./evolution-of-12-factor.md) -- understand the lineage (12 min)

**Total time:** ~60 minutes for the complete philosophical foundation.

### For practitioners already using the factors

1. [Context Engineering](./context-engineering.md) -- optimize context budgets
2. [Knowledge OS](./knowledge-os.md) -- maximize knowledge compounding
3. [Constraint-Based Engineering](./constraint-based-engineering.md) -- understand why factors are structured this way

### For contributors

1. All foundation documents (any order)
2. [Comparison Table](./comparison-table.md) -- understand the three-framework landscape
3. [CONTRIBUTING.md](../../CONTRIBUTING.md) -- share your patterns

---

## How Foundations Connect to Practice

```
Principles (this directory)
    | Philosophical basis: WHY
    v
12 Factors (factors/)
    | Operational principles: WHAT
    v
Reference Implementation (AgentOps plugin)
    | Automation: HOW
    v
Your Work
    | Patterns extracted
    v
Knowledge Flywheel
    | Compounds over time
```

**This repository:** Theory and principles
**AgentOps plugin:** Reference implementation (optional -- every factor works manually)
**Your work:** Application and validation

---

## Version and Status

**Version:** 3.0
**Last Updated:** 2026-02-15
**Status:** Stable, open for community refinement

Built on decades of proven DevOps, SRE, GitOps, and zero-trust practices. Validated in production environments ranging from solo development to enterprise infrastructure. Community validation in progress.
