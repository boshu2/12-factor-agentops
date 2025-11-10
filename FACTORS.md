# The 12 Factors

**Detailed explanations of each factor.**

---

## Introduction

The 12 factors are operational principles for safe AI agent usage. Each factor addresses a specific challenge in making AI agents reliable and trustworthy.

**Read them in order** - early factors are foundational, later factors build on them.

---

## Factor I: Git Memory as Knowledge OS

**One canonical history for agent work; commits capture intent, context, and learnings.**

### What

Use git as the single source of truth for all agent work. Every change goes through git with meaningful commits that capture not just *what* changed, but *why* and *what was learned*.

### Why

Without institutional memory, every agent session starts from zero. With git as memory:
- Context accumulates over time
- Patterns emerge from history
- Failures teach future sessions
- Knowledge compounds

### How

**Semantic commits:**
```
feat(auth): Add JWT validation

## Context
Users bypassing auth with forged tokens

## Solution
Added validateJWT() in middleware

## Learning
Always validate signatures, not just presence

## Impact
Security: Forged tokens now rejected
```

**[Full documentation →](./factors/01-git-memory-as-knowledge-os.md)**

---

## Factor II: JIT Context Loading

**Keep main context clean; delegate work to sub-agents with isolated context windows.**

### What

Don't load everything into one context. Instead, keep the main agent lean and delegate specific tasks to sub-agents with isolated, focused contexts.

### Why

Context windows have cognitive load limits (~40% utilization before degradation). JIT loading prevents collapse and keeps agents effective.

### How

**Bad (monolith):**
```
Main agent: Research entire codebase + Plan changes + Implement + Test
Context: 180k tokens (90% - degraded performance)
```

**Good (JIT):**
```
Main agent: Orchestrate (5k tokens, 2.5%)
  ├─→ Research agent: Explore codebase (60k tokens, returns 2k summary)
  ├─→ Planning agent: Specify changes (40k tokens, returns 1k plan)
  └─→ Implementation agent: Execute plan (50k tokens, validates)
Main agent context: 5k + 2k + 1k = 8k tokens (4%)
```

**[Full documentation →](./factors/02-jit-context-loading.md)**

---

## Factor III: Single-Responsibility Agents

**Compose workflows from focused agents; avoid monolith prompts.**

### What

Each agent has one clear job. Compose complex workflows from simple, focused agents rather than building monolith prompts that do everything.

### Why

Single-responsibility agents are:
- Easier to understand
- Easier to test
- Easier to improve
- Easier to reuse

### How

**One agent per phase:**
- Research agent: Explore and understand
- Planning agent: Specify changes
- Implementation agent: Execute mechanically
- Validation agent: Test and verify

**[Full documentation →](./factors/03-single-responsibility-agents.md)**

---

## Factor IV: Validation Gates Before Execution

**Formal checkpoints (plan review, tests, hooks) before applying changes.**

### What

Never apply changes without validation. Gates between every phase ensure quality and catch errors early.

### Why

Prevention is cheaper than recovery. Validation gates:
- Catch errors before they reach production
- Provide clear approval points
- Enable rollback at any stage
- Build confidence in agent output

### How

**Validation at every phase:**
- Research → Plan: Understanding validated
- Plan → Implement: Specification reviewed
- Implement → Commit: Tests pass
- Commit → Deploy: CI/CD validates

**[Full documentation →](./factors/04-validation-gates-before-execution.md)**

---

## Factor V: Operational Telemetry

**Metrics, logs, and observability for every agent run.**

**[Full documentation →](./factors/05-operational-telemetry.md)**

---

## Factor VI: Session Continuity via Bundles

**Persist and restore context using compressed artifacts for multi-day work.**

**[Full documentation →](./factors/06-session-continuity-via-bundles.md)**

---

## Factor VII: Intelligent Task Routing

**Route work to best-fit workflows/agents with measured accuracy.**

**[Full documentation →](./factors/07-intelligent-task-routing.md)**

---

## Factor VIII: Human Gate Reviews

**Embed human approvals between research → plan → implement phases.**

**[Full documentation →](./factors/08-human-gate-reviews.md)**

---

## Factor IX: Documented Pattern Extraction

**Capture learnings after every session; publish reusable patterns.**

**[Full documentation →](./factors/09-documented-pattern-extraction.md)**

---

## Factor X: Continuous Improvement Backlog

**Each session identifies improvements; prioritize and action them.**

**[Full documentation →](./factors/10-continuous-improvement-backlog.md)**

---

## Factor XI: Constitutional Guardrails

**Enforce operational laws and prevent risky behaviors.**

**[Full documentation →](./factors/11-constitutional-guardrails.md)**

---

## Factor XII: Domain Portability

**Package domain knowledge into reusable profiles and bundles.**

**[Full documentation →](./factors/12-domain-portability.md)**

---

## How to Apply the Factors

**Start with the foundation (I-IV):**
1. Use git for all work (Factor I)
2. Delegate to sub-agents (Factor II)
3. One agent, one job (Factor III)
4. Validate before applying (Factor IV)

**Add operations (V-VIII):**
5. Capture metrics (Factor V)
6. Use bundles for continuity (Factor VI)
7. Route intelligently (Factor VII)
8. Add human gates (Factor VIII)

**Enable improvement (IX-XII):**
9. Extract patterns (Factor IX)
10. Maintain backlog (Factor X)
11. Enforce guardrails (Factor XI)
12. Package for reuse (Factor XII)

**See:** [WORKFLOW.md](./WORKFLOW.md) for practical application guide

---

## Next Steps

- **Apply the workflow:** [WORKFLOW.md](./WORKFLOW.md)
- **Try the starter pack:** [examples/STARTER-PACK](./examples/STARTER-PACK/)
- **Explore your domain:** [marketplace/domain-guides](./marketplace/domain-guides/)
- **Go deeper:** [marketplace/](./marketplace/)

**The factors work. Start applying them.**
