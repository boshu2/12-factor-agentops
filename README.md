<div align="center">

# 12-Factor AgentOps

### The Principles Behind the Operational Layer for Coding Agents

Doctrine that turns ad-hoc agent usage into bookkeeping, validation,
primitives, and flows that compound.

<!-- Build & Status -->
[![CI](https://img.shields.io/github/actions/workflow/status/boshu2/12-factor-agentops/validate-factors.yml?label=CI)](https://github.com/boshu2/12-factor-agentops/actions)
[![Version](https://img.shields.io/badge/Version-4.0.0-blue.svg)](https://github.com/boshu2/12-factor-agentops/releases)

<!-- Technology -->
[![12 Factors](https://img.shields.io/badge/Factors-12-00CED1.svg)](factors/)
[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![GitHub Stars](https://img.shields.io/github/stars/boshu2/12-factor-agentops?style=social)](https://github.com/boshu2/12-factor-agentops)

</div>

---

## The Problem

Every agent session starts from zero. Same context problems. Same mistakes
repeated. Same rework. You get good results sometimes and bad results other
times, with no idea why. There is no bookkeeping between sessions, no stable
validation model, and no reliable way to turn completed work into better next
work.

**The model isn't the problem. The operations are.**

Most people blame the model when they get bad results. The real problem is how
they operate: overloaded context windows, no bookkeeping between sessions, no
validation, no learning loops. Fix the operations and the same model performs
dramatically better.

## The Solution: The Operational Layer Compounds

AgentOps is the operational layer for coding agents. 12-Factor AgentOps is the
doctrine behind it: the public rules that make bookkeeping, validation,
primitives, and flows compound instead of resetting every session.

**Session 1:** Your agent knows nothing about your codebase. It makes common mistakes. It ignores your conventions. It writes code that doesn't fit.

**Session 10:** Your agent knows your patterns. It avoids documented pitfalls. It follows your conventions because they're in the context.

**Session 100:** Your agent operates with durable bookkeeping. It knows what's
been tried and failed. It knows why architectural decisions were made. It
builds on everything that came before.

**The hook:** Compounding work is the one thing no amount of model improvement
replaces. Better models with no bookkeeping still repeat your mistakes.

### Single-runtime by default. Cross-vendor where it pays.

The doctrine is vendor-neutral by design — every factor applies whether you run
Claude Code, Codex CLI, Cursor, or OpenCode. The reference implementation
defaults to a single runtime so install-to-first-value stays cheap. Cross-vendor
coordination (mixed-model councils, runtime-asymmetric planning) is kept because
in real runs Codex judges have surfaced load-bearing findings that all-Claude
councils missed. That capability earns its place by changing verdicts, not by
sitting in the install matrix.

**[Read the sovereignty proof →](https://12factoragentops.com/sovereignty-proof)** — three real `/council --mixed` runs with file:line citations, the standing exhibit for the cross-vendor claim.

---

## Quickstart: 5 Minutes, Zero Infrastructure

No plugins, no tooling, no setup. Just a text file and discipline.

That file is the smallest possible bookkeeping layer.

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

**That's it.** You're now doing Factors I (context management), II (git tracking), and IX (knowledge extraction) at a basic level. Your agent will stop repeating documented mistakes immediately.

**When to level up:** When `learnings.md` exceeds ~50 entries or you stop reading it before sessions, you're ready for more structure.

---

## The 12 Factors

Twelve vendor-neutral principles, grouped by a four-phase operational lifecycle — **Prepare → Bound → Select → Govern** — that a unit of work passes through, with Govern feeding back into Prepare. The phases are a **lens for reading the set, not a strict dependency chain**: the order is a sensible reading sequence, not a proof that each factor requires the one before it. And we hold the set at twelve on purpose — it's the recognizable name — rather than pretending exactly twelve fell out of first principles.

### Prepare (I–III) — set up the environment

Get the inputs right before the agent acts. Cheap to do, expensive to skip.

| # | Factor | The Rule |
|---|--------|----------|
| **[I](./factors/01-context-is-everything.md)** | **Context Is Everything** | Manage what enters the context window like you manage what enters production. |
| **[II](./factors/02-track-everything-in-git.md)** | **Track Everything in Git** | If it's not in git, it didn't happen (a committed reference counts). |
| **[III](./factors/03-one-agent-one-job.md)** | **One Agent, One Job** | Each agent gets a scoped task and fresh context. Never reuse a saturated window. |

**Without tooling:** Keep sessions short. Start fresh for new tasks. Write handoff summaries. Commit your `learnings.md`. One issue per agent session.

### Bound (IV–VI) — constrain what may act

Cap what an agent is allowed to do, and what it needs to know, before it touches anything real.

| # | Factor | The Rule |
|---|--------|----------|
| **[IV](./factors/04-enforce-least-privilege.md)** | **Enforce Least Privilege** | An agent acts inside an explicit least-privilege envelope it cannot widen — not even when the input tells it to. |
| **[V](./factors/05-research-before-you-build.md)** | **Research Before You Build** | Understand the integration surface before generating code. |
| **[VI](./factors/06-isolate-workers.md)** | **Isolate Workers** | Concurrent workers share only gated coordination state, never mutable working state. |

**Without tooling:** Run agents with scoped credentials and a sandbox, not production keys. Research before implementing. Use git worktrees so parallel work can't collide.

### Select (VII–IX) — decide what survives

Gate what's been produced: prove it, lock it, and capture what the session taught.

| # | Factor | The Rule |
|---|--------|----------|
| **[VII](./factors/07-validate-externally.md)** | **Validate Externally** | The worker emits claims plus evidence; an independent checker writes the binding verdict. No agent grades its own work. |
| **[VIII](./factors/08-lock-progress-forward.md)** | **Lock Progress Forward** | Once work passes validation, it ratchets — monotonic by default; regression takes an explicit, recorded reversal. |
| **[IX](./factors/09-extract-learnings.md)** | **Extract Learnings** | Every non-trivial session produces two outputs — the work product and the lessons (including failures). |

**Without tooling:** Have a different session (or human) review the work. Commit validated work to protected branches. Append what you learned to `learnings.md` before closing the tab.

### Govern (X–XII) — steer and feed back

Close the loop: compound what's learned, coordinate the fleet, and steer by outcomes — feeding back into the next Prepare.

| # | Factor | The Rule |
|---|--------|----------|
| **[X](./factors/10-compound-knowledge.md)** | **Compound Knowledge** | Learnings — positive *and* negative — flow back into future sessions automatically. |
| **[XI](./factors/11-supervise-hierarchically.md)** | **Supervise Hierarchically** | Escalation flows up with evidence, authority flows down; a stuck worker's job goes to a fresh agent, not a retry loop. |
| **[XII](./factors/12-measure-outcomes.md)** | **Measure Outcomes** | Track fitness toward goals, not activity — the feedback that closes the loop back to Prepare. |

**Factor X is the hero.** It's the knowledge flywheel: extract (IX) feeds it, then
gate for quality, inject into future sessions, cite, and let stale knowledge decay —
positive and negative knowledge both. This is the differentiator that can't be
commoditized; better models don't replace durable bookkeeping.

**Without tooling:** Manually update `learnings.md` after each session and read it before the next. Designate one coordinator for parallel work. Track whether you're hitting goals, not how busy the agents look.

---

## Core and Skin

Every layer of an agent system is a universal **core** plus a removable **skin**, and the two are never conflated. The core is the invariant — these twelve factors, the operator model below them. The skin is house style: your naming, your personas, your rituals, the story you tell yourself about the work. The skin is never imposed. You adopt the constitution without anyone's mythology, and you dress it in your own. That separation is what makes the doctrine portable across teams, tools, and vendors: take the rules, leave the costume.

## Doctrine Stability

The twelve names and numbers are frozen at v3.0.0. Corrections are **expression-only** — sharpen the prose, fix a diagram, re-cut a boundary that reads ambiguously. A factor may be rewritten, and a soft one may be reduced to an emphasis that points at its neighbor, but **no factor is ever deleted and the set is never renumbered.** The number is load-bearing (URLs, the badge, every inbound link, twenty years of "twelve-factor" recognition). When two factors feel redundant, the fix is to make the distinction legible, not to merge the slots.

## The Operator Model Underneath the Factors

The twelve factors are the public operating rules behind bookkeeping,
validation, primitives, and flows. Underneath them is a simple operator model:
the **stateful environment** carries continuity, **replaceable actors** do
bounded work, durable traces coordinate work across sessions, **selection
gates** decide what survives, **promotion loops** turn observations into
reusable knowledge, and **governance** sets the objective, boundaries, and
escalation path.

This does not replace the factors. It explains why they fit together as one system instead of twelve isolated habits. If you want the full crosswalk, read [The Operator Model Behind the 12 Factors](./docs/explanation/operator-model.md).

---

## Why These Factors?

### For the Solo Developer

You use Claude Code, Cursor, or Codex daily. Some sessions produce great results. Others are frustrating wastes of time. The difference isn't the model — it's the context.

The Prepare phase (I–III) gives you immediate improvement: keep context focused, track what you learn, start fresh for each task. Then Extract Learnings (IX) and Compound Knowledge (X) make each session build on the last.

### For the Tech Lead

Your team runs agents in parallel. Work conflicts. Learnings from one developer's sessions don't help others. There's no consistent quality bar.

The Bound phase (IV–VI) caps the blast radius and prevents collisions —
least privilege, research, isolation. The Select phase (VII–IX) is your quality
bar: external validation, a forward ratchet, and captured lessons. Govern
(X–XII) gives you shared compounding knowledge, supervision, and outcome metrics.

### For the Tool Builder

You're designing agent tooling and need proven operational principles. Every framework reinvents context management, validation, and knowledge persistence from scratch.

These 12 factors are the shared vocabulary. They're vendor-neutral, grounded in 20+ years of DevOps and SRE practice, and tested in production.

---

## Adoption Path

You can start with zero infrastructure and level up when you need to:

```
Quickstart (5 min)     → learnings.md file, zero tooling
Prepare (I-III)        → Context discipline, git tracking, fresh sessions
Bound (IV-VI)          → Least privilege, research-first, worker isolation
Select (VII-IX)        → External validation, ratcheting, learning capture
Govern (X-XII)         → Compounding knowledge, supervision, outcome metrics
```

**Key principle:** The phases are a reading order and an adoption on-ramp — you can stop adopting at any phase and keep the value. Stopping means you haven't automated the later factors yet, not that they stopped applying: a solo dev still lives least privilege (a sandbox), isolation (a worktree), and supervision (their own judgment).

**When to level up:**
- **Quickstart → Prepare:** When your `learnings.md` gets unwieldy or you notice repeated context problems
- **Prepare → Bound:** When agents start touching real systems, or you run more than one at a time
- **Bound → Select:** When "looks done" keeps shipping bugs and you need a real gate
- **Select → Govern:** When lessons aren't compounding and parallel work needs coordination

---

## Where This Comes From

These principles stand on decades of proven methodology:

| Source | Factors |
|--------|---------|
| **DevOps practices** (20+ years) | I, VII, VIII, XII |
| **Site Reliability Engineering** (Google, 15+ years) | VII, VIII, XII |
| **Cognitive load theory** (Sweller, 1988) | I, III |
| **Unix philosophy** (1978) | III |
| **GitOps methodology** (10+ years) | II |
| **Microservices patterns** (10+ years) | III, VI, XI |
| **Zero-trust architecture** (10+ years) | IV, VII |
| **Learning science** (decades) | IX, X |

### Related Projects

| Project | Relationship |
|---------|-------------|
| [12-Factor App](https://12factor.net) (Heroku, 2011) | How to build cloud-native apps. We're how to operate with agents. |
| [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (HumanLayer) | How to *build* agent applications. We're how to *operate with* them. |
| [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) (Gene Kim, Steve Yegge) | The methodology of AI-assisted coding. We're the operational discipline underneath. |

---

## Reference Implementation

The [AgentOps plugin](https://github.com/boshu2/agentops) is the reference
implementation of these factors for Claude Code and Codex. It automates the
bookkeeping flywheel (extraction, quality gating, semantic retrieval, decay
management), provides research and planning skills, and implements multi-agent
coordination patterns.

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
- **v3.1** (2026-06-06): Whole-system constitution alignment. The 12 are reframed as one constitution lived at altitudes (one agent → a fleet), not a product partition. Factor V leads with the claims-vs-verdicts / single-writer moat; Factor XII rewritten to routing-hints + fresh-agent-on-failure; VII↔VIII, III↔X, X↔XI boundaries sharpened; Scale tier reframed from "optional" to the factory altitude. No factor renamed, renumbered, or deleted.
- **v4.0** (2026-06-07): Re-derivation by cross-model council (Opus 4.8 · Codex GPT-5.5 · Gemini 3.5 Flash), pressure-tested adversarially. Regrouped into a four-phase operational lifecycle — **Prepare → Bound → Select → Govern** (a reading lens, not a strict dependency chain). **Added Factor IV: Enforce Least Privilege** (the security/permissions gap — ingress + egress). **Merged Harvest Failures into Compound Knowledge** (negative knowledge, same flywheel) and **relocated fresh-agent-on-failure into Supervise Hierarchically** (a recovery primitive). Renamed Measure What Matters → **Measure Outcomes**. All factors renumbered; accuracy fixes carried in. The "12" is held deliberately for recognizability, not claimed as derived.
