# 12-Factor AgentOps: Pivot Design

**Date:** 2026-02-15
**Status:** Approved (brainstorm complete)

## The Pivot

**From:** "Shift-Left Validation for Coding Agents" (QA slice)
**To:** "The Operational Discipline for Working With Agents" (full operating model)

12-Factor AgentOps becomes the manifesto for agent-native operations — what DevOps is to infrastructure automation. It defines vendor-neutral principles for how to work with AI agents reliably, with compounding returns.

The AgentOps plugin is the reference implementation. Olympus demonstrates the scale factors in a multi-agent orchestration system. The 12 factors stand alone — they apply to Claude Code, Cursor, Codex, Copilot, or custom setups.

## Core Insight

Agent output quality is determined by context input quality. Most people blame the model when they get bad results. The real problem is how they operate — overloaded context windows, no session memory, no validation, no learning loops. Fix the operations and the same model performs dramatically better.

## Audience

Individual-first, scales up. The entry point is one developer working with one agent. Team and multi-agent patterns are advanced factors, not prerequisites. This mirrors how DevOps spread: one engineer automating deploys → team practice → organizational discipline.

## Adjacent Projects

| Project | Relationship |
|---------|-------------|
| 12-Factor Agents (HumanLayer) | How to *build* agent applications. We're how to *operate with* them. |
| Vibe Coding (Gene Kim, Steve Yegge) | The methodology of AI-assisted coding. We're the operational layer underneath. |
| AgentOps plugin | Reference implementation of these principles. |
| Olympus | Multi-agent orchestration system embodying Factors X–XII at scale. |

---

## The 12 Factors

### Foundation (I–III)

Non-negotiable. Get these wrong and nothing else matters.

#### Factor I: Context Is Everything

**Rule: Manage what enters the context window like you manage what enters production.**

The 40% rule: agent performance peaks when context utilization stays below 40%. Past that, instruction-following degrades, retrieval fails ("lost in the middle"), and the agent starts confabulating. This isn't a guess — it's supported by 40 years of cognitive load research and confirmed in LLM benchmarks.

Practically this means: load context just-in-time, not just-in-case. Scope what each agent sees to its task. Compress between phases. Use handoff summaries instead of carrying full history. The agent that knows less but knows the *right things* outperforms the one drowning in context.

**What good looks like:**
- Context stays below 40% utilization during active work
- Each agent receives only task-relevant information
- Phase transitions produce compressed summaries, not full transcripts
- Handoffs carry structured context, not "read the whole thread"

#### Factor II: Track Everything in Git

**Rule: If it's not in git, it didn't happen.**

Not just code — issues, learnings, patterns, session artifacts, decisions. Git gives you history, diffability, collaboration, and auditability for free. When your agent's knowledge base, issue tracker, and work artifacts all live in the repo, any agent can pick up where any other left off. No external databases, no cloud state, no vendor lock-in.

**What good looks like:**
- Issues tracked in-repo (beads, GitHub issues, or similar)
- Learnings and patterns stored as versioned artifacts
- Session state can be reconstructed from git history
- Any agent can resume any other agent's work from the repo alone

#### Factor III: One Agent, One Job

**Rule: Each agent gets a scoped task and fresh context. Never reuse a saturated window.**

An agent that just finished researching your auth system is the worst agent to then implement the fix — its window is full of research context, not implementation context. Spawn fresh. Scope tight. The cost of a new agent is tokens; the cost of a confused agent is rework.

**What good looks like:**
- Research agents produce findings; implementation agents consume them
- Phase transitions spawn new agents with scoped context
- No agent carries context from a previous unrelated task
- Worker agents get a single issue, not a list of issues

---

### Workflow (IV–VI)

How work flows through agents — the discipline that separates "prompting and hoping" from a reliable operating model.

#### Factor IV: Research Before You Build

**Rule: Understand the problem space before generating a single line of code.**

The cheapest agent session is the one that doesn't get thrown away. Agents that dive straight into implementation without understanding existing patterns, constraints, and conventions produce plausible-looking code that doesn't fit. Research is a distinct phase — it produces findings, not code. Those findings become the scoped context for the agents that implement.

This is the "measure twice, cut once" of agent operations. A 10-minute research phase routinely saves hours of rework.

**What good looks like:**
- Research is a named phase with its own output artifacts
- Implementation agents receive research findings, not raw questions
- Existing codebase patterns are understood before new code is written
- Research findings are stored and reusable across sessions

#### Factor V: Validate Externally

**Rule: No agent grades its own work. Ever.**

When you ask an agent "does this look right?" after it just wrote the code, it will say yes. This isn't malice — it's the same context bias that makes humans bad at proofreading their own writing. Validation must come from outside: a different agent, a different model, a test suite, a human review. Multi-model councils (asking 3+ models to independently assess) catch what any single model misses.

Self-validation isn't validation. It's confirmation bias with extra steps.

**What good looks like:**
- Code is validated by an agent that didn't write it
- Critical decisions get multi-model review (2+ independent assessments)
- Test suites run as automated validation gates
- Humans review architectural decisions and security-sensitive changes

#### Factor VI: Lock Progress Forward

**Rule: Once work passes validation, it ratchets — it cannot regress.**

This is the Brownian Ratchet pattern. Chaos is cheap (spawn multiple attempts). Filtering is the gate (validation, tests, review). The ratchet is the lock (merge, close, record). Progress accumulates because validated work is permanent. Failed attempts aren't waste — they're the cost of finding what works. The key insight: let agents be chaotic, but never let unvalidated chaos reach main.

**What good looks like:**
- Validated work merges to a protected branch (permanent)
- Issues close only after external validation (state locks)
- Multiple parallel attempts are encouraged (chaos is cheap)
- Unvalidated work never reaches shared branches

---

### Knowledge (VII–IX)

Where agent operations diverges most sharply from ad-hoc agent usage. Without these, every session starts from zero. With them, every session is smarter than the last.

#### Factor VII: Extract Learnings From Every Session

**Rule: Every session produces two outputs — the work product and the lessons learned.**

Most people close the tab and move on. The patterns discovered, the dead ends hit, the decisions made — all evaporate. Extraction is a deliberate act: at the end of each session, mine it for what worked, what failed, and what was decided. These become structured artifacts — not vague notes, but specific, actionable learnings tied to context.

A session you didn't extract from is a session the organization forgot.

**What good looks like:**
- Every session ends with explicit learning extraction
- Learnings are structured: what, why, context, confidence level
- Decisions are recorded with rationale, not just outcomes
- Dead ends are documented (what was tried and why it failed)

#### Factor VIII: Compound Knowledge Across Sessions

**Rule: Learnings must flow back into future sessions automatically.**

Extraction without injection is a write-only database. The flywheel pattern: extract learnings, gate them for quality (not everything is worth keeping), decay stale ones (knowledge rots — what was true six months ago may not be now), and inject relevant ones into future sessions at startup. The compounding equation is simple: if retrieval rate times citation rate exceeds decay rate, knowledge grows. If not, it decays to zero no matter how much you extract.

This is institutional memory that actually works — not a wiki nobody reads.

**What good looks like:**
- Session startup automatically loads relevant prior learnings
- Learnings pass quality gates before entering the knowledge base
- Stale knowledge decays over time (freshness weighting)
- Knowledge reuse rate is tracked and growing

#### Factor IX: Measure What Matters

**Rule: Track fitness toward goals, not activity metrics.**

Token count, session count, lines of code — these are vanity metrics. What matters: Are goals being met? Are the same mistakes recurring? Is knowledge actually being reused? Fitness-based measurement asks "is the system getting better at what it's supposed to do?" not "is the system busy?" Dormancy is success — when all goals pass, the system should stop, not manufacture work.

**What good looks like:**
- Goals are defined and measurable (not "be productive")
- Recurring failures trigger pattern extraction, not just retries
- Knowledge reuse rate is tracked (are learnings actually applied?)
- The system stops when goals are met (dormancy, not busywork)

---

### Scale (X–XII)

These kick in when you move beyond one agent. Not prerequisites — you can get enormous value from Factors I–IX alone. But when you're ready to scale, these keep multi-agent work from becoming multi-agent chaos.

#### Factor X: Isolate Workers

**Rule: Each worker gets its own workspace, its own context, and zero shared mutable state.**

When two agents share a context window or a working directory, they corrupt each other. One agent's research pollutes the other's implementation context. Merge conflicts pile up. Isolation means separate git worktrees, fresh context per worker, no bleed-through between execution waves. The cost of isolation is disk space and tokens — both cheap. The cost of contamination is cascading failures and confused agents — both expensive.

Parallel work only scales when workers can't step on each other.

**What good looks like:**
- Each worker agent operates in its own git worktree
- No shared mutable state between concurrent agents
- Context is scoped per-worker, not shared across workers
- Parallel execution waves get fresh context (no bleed-through)

#### Factor XI: Supervise Hierarchically

**Rule: Escalation flows up, never sideways. Each level handles what it can and passes up what it can't.**

A worker agent that can't solve a problem after three attempts shouldn't message another worker — it should escalate to its supervisor. The supervisor has broader context and authority to reassign, reframe, or involve a human. This mirrors Erlang supervision trees: let workers fail, let supervisors decide what failure means. Flat agent topologies where everyone talks to everyone produce deadlocks and circular dependencies. Hierarchy isn't bureaucracy — it's error handling.

**What good looks like:**
- Clear supervision hierarchy (worker → supervisor → coordinator)
- Workers escalate after bounded retries (e.g., 3 attempts)
- Supervisors can reassign, reframe, or escalate further
- Humans sit at the top of the tree, not in the middle of every loop

#### Factor XII: Harvest Failures as Wisdom

**Rule: Failed attempts are data. Extract and index them with the same rigor as successes.**

A worker that tried three approaches before the fourth worked just generated three learnings about what doesn't work in this context. Most systems discard failed attempts. An agent-native operating model harvests them — what went wrong, why, and what the context was. Over time, the system accumulates negative knowledge ("don't try X when Y is true") that's as valuable as positive knowledge. Failures are the tuition. Learnings are the degree.

**What good looks like:**
- Failed attempts are logged with context, not silently discarded
- Post-mortems run on failures with the same rigor as successes
- Negative knowledge ("X doesn't work when Y") is indexed and retrievable
- Failure rate decreases over time as harvested wisdom prevents repeats

---

## Implementation: What Changes

### Content that survives (reframed)
- The 12 factors structure (renumbered/rewritten per above)
- Validation patterns (now Factor V, not the whole thesis)
- Knowledge flywheel concepts (now Factors VII–VIII)
- Context management (now Factor I, elevated to top)

### Content that's new
- Factors IV (Research), VI (Ratchet), X–XII (Scale)
- Positioning as full operational discipline
- Explicit relationship to AgentOps plugin as reference implementation
- Scale section acknowledging Olympus patterns

### Content to archive
- Coding-agent-only framing (too narrow)
- "DevOps for Vibe-Coding" tagline (replaced)
- Marketplace skills focused purely on validation (reframe as Factor V implementations)

### README rewrite
- New tagline: "The Operational Discipline for Working With Agents"
- Individual-first framing
- Quick overview of all 12 factors
- Link to AgentOps plugin as reference implementation
- Link to Olympus for scale patterns

### Marketplace skills
- Reframe existing validation skills under Factor V
- Consider new skills for other factors (context management, knowledge extraction, etc.)
