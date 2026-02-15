# Complete 12-Factor Comparison: App, Agents, AgentOps

Three frameworks, three layers of the stack. This document maps each original 12-Factor App principle through its AI-age adaptations.

- **12-Factor App** (Heroku, 2011): How to build cloud-native applications
- **12-Factor Agents** (Dex Horthy, 2025): How to build reliable AI applications
- **12-Factor AgentOps** (v3, 2026): The operational discipline for working with AI agents

---

## Quick Reference

| # | 12-Factor App (2011) | 12-Factor Agents (2025) | 12-Factor AgentOps v3 (2026) |
|---|----------------------|-------------------------|------------------------------|
| I | Codebase | Own your prompts | **[Context Is Everything](../../factors/01-context-is-everything.md)** |
| II | Dependencies | Own your context window | **[Track Everything in Git](../../factors/02-track-everything-in-git.md)** |
| III | Config | Tools as structured outputs | **[One Agent, One Job](../../factors/03-one-agent-one-job.md)** |
| IV | Backing Services | Small, focused agents | **[Research Before You Build](../../factors/04-research-before-you-build.md)** |
| V | Build/Release/Run | Launch/Pause/Resume APIs | **[Validate Externally](../../factors/05-validate-externally.md)** |
| VI | Processes | Stateless reducer | **[Lock Progress Forward](../../factors/06-lock-progress-forward.md)** |
| VII | Port Binding | Trigger from anywhere | **[Extract Learnings](../../factors/07-extract-learnings.md)** |
| VIII | Concurrency | Small, focused agents | **[Compound Knowledge](../../factors/08-compound-knowledge.md)** |
| IX | Disposability | Launch/Pause/Resume | **[Measure What Matters](../../factors/09-measure-what-matters.md)** |
| X | Dev/Prod Parity | Implicit | **[Isolate Workers](../../factors/10-isolate-workers.md)** |
| XI | Logs | Compact errors into context | **[Supervise Hierarchically](../../factors/11-supervise-hierarchically.md)** |
| XII | Admin Processes | Contact humans with tools | **[Harvest Failures as Wisdom](../../factors/12-harvest-failures-as-wisdom.md)** |

---

## Detailed Comparison

### Factor I: Codebase / Prompts / Context Is Everything

**Original 12-Factor App (I: Codebase)**
- *Principle*: One codebase tracked in revision control, many deploys
- *Problem Solved*: Version control for application code
- *Key Practice*: Single source of truth for code

**12-Factor Agents (Own Your Prompts)**
- *Adaptation*: Prompts are code and must be version-controlled
- *Why Changed*: LLM behavior is determined by prompts, not traditional code
- *Key Practice*: Don't let frameworks hide your prompts in abstractions

**12-Factor AgentOps (I: Context Is Everything)**
- *Evolution*: Manage what enters the context window like you manage what enters production
- *Why Different*: Agent output quality is determined by input context quality -- garbage in, garbage out
- *Key Practice*: Budget context deliberately; load knowledge just-in-time; stay under the 40% utilization threshold
- *Unique Aspect*: Context is the operational lever -- same model performs dramatically differently based on what it sees

---

### Factor II: Dependencies / Context Window / Track Everything in Git

**Original 12-Factor App (II: Dependencies)**
- *Principle*: Explicitly declare and isolate dependencies
- *Problem Solved*: Reproducible builds and deployments
- *Key Practice*: Never rely on implicit system dependencies

**12-Factor Agents (Own Your Context Window)**
- *Adaptation*: Explicitly control what the LLM sees
- *Why Changed*: Context window is the LLM's "working memory"
- *Key Practice*: Don't let frameworks auto-populate context

**12-Factor AgentOps (II: Track Everything in Git)**
- *Evolution*: If it's not in git, it didn't happen
- *Why Different*: Agent sessions are ephemeral; git is the only durable memory
- *Key Practice*: Learnings, decisions, context, and patterns all live in version-controlled repositories
- *Unique Aspect*: Git becomes institutional memory, not just version control

---

### Factor III: Config / Tools / One Agent, One Job

**Original 12-Factor App (III: Config)**
- *Principle*: Store config in the environment
- *Problem Solved*: Separate configuration from code
- *Key Practice*: Environment-specific settings external to codebase

**12-Factor Agents (Tools as Structured Outputs)**
- *Adaptation*: Tools are just prompts that return structured JSON
- *Why Changed*: LLMs don't "call" tools, they generate structured output
- *Key Practice*: Understand tool calling as output parsing

**12-Factor AgentOps (III: One Agent, One Job)**
- *Evolution*: Each agent gets a scoped task and fresh context
- *Why Different*: Overloaded agents produce degraded output as context saturates
- *Key Practice*: One issue, one agent session; never reuse a saturated context window
- *Unique Aspect*: Grounded in cognitive load theory -- context collapse is a cliff, not a slope

---

### Factor IV: Backing Services / Small Agents / Research Before You Build

**Original 12-Factor App (IV: Backing Services)**
- *Principle*: Treat backing services as attached resources
- *Problem Solved*: Decouple services from application code
- *Key Practice*: Swap databases, queues, etc. without code changes

**12-Factor Agents (Small, Focused Agents)**
- *Adaptation*: Build many small agents, not one monolith
- *Why Changed*: Large agents get stuck at 70-80% quality
- *Key Practice*: One agent, one well-defined responsibility

**12-Factor AgentOps (IV: Research Before You Build)**
- *Evolution*: Understand the problem space before generating code
- *Why Different*: Agents that skip research produce plausible but wrong solutions
- *Key Practice*: Separate research phase from implementation phase; understand before generating
- *Unique Aspect*: Inverts the "code first, fix later" pattern that causes most agent failures

---

### Factor V: Build/Release/Run / Launch-Pause-Resume / Validate Externally

**Original 12-Factor App (V: Build, Release, Run)**
- *Principle*: Strictly separate build and run stages
- *Problem Solved*: Repeatable, auditable deployments
- *Key Practice*: Build once, deploy many times unchanged

**12-Factor Agents (Launch/Pause/Resume APIs)**
- *Adaptation*: Agent lifecycle as discrete state transitions
- *Why Changed*: AI workflows need to pause/resume across sessions
- *Key Practice*: Simple APIs for agent lifecycle management

**12-Factor AgentOps (V: Validate Externally)**
- *Evolution*: No agent grades its own work
- *Why Different*: Agents are confident but not reliable -- they cannot objectively evaluate their own output
- *Key Practice*: External validation via tests, linters, a different agent, or human review
- *Unique Aspect*: Zero-trust principle applied to cognition -- validate the output, not the source

---

### Factor VI: Processes / Stateless Reducer / Lock Progress Forward

**Original 12-Factor App (VI: Processes)**
- *Principle*: Execute app as stateless processes
- *Problem Solved*: Horizontal scaling and crash recovery
- *Key Practice*: Store state in backing services, not in process memory

**12-Factor Agents (Stateless Reducer)**
- *Adaptation*: Agents as pure functions: input leads to output
- *Why Changed*: Makes agents reproducible and testable
- *Key Practice*: Agent takes state, produces new state, no hidden memory

**12-Factor AgentOps (VI: Lock Progress Forward)**
- *Evolution*: Once work passes validation, it ratchets -- it cannot regress
- *Why Different*: Without ratcheting, agents undo validated work during later iterations
- *Key Practice*: Commit validated work to protected branches; checkpoint progress
- *Unique Aspect*: Prevents the "two steps forward, one step back" pattern common in long agent sessions

---

### Factor VII: Port Binding / Trigger Anywhere / Extract Learnings

**Original 12-Factor App (VII: Port Binding)**
- *Principle*: Export services via port binding
- *Problem Solved*: Self-contained services without external servers
- *Key Practice*: App exports HTTP as service

**12-Factor Agents (Trigger from Anywhere)**
- *Adaptation*: Activate agents from any channel (Slack, email, API, etc.)
- *Why Changed*: Users interact through multiple interfaces
- *Key Practice*: Meet users where they are

**12-Factor AgentOps (VII: Extract Learnings)**
- *Evolution*: Every session produces two outputs -- the work product and the lessons learned
- *Why Different*: Without explicit extraction, hard-won knowledge dies with the session
- *Key Practice*: End every session by capturing what worked, what failed, and why
- *Unique Aspect*: Feeds the knowledge flywheel; the raw material for Factor VIII (Compound Knowledge)

---

### Factor VIII: Concurrency / Focused Agents / Compound Knowledge

**Original 12-Factor App (VIII: Concurrency)**
- *Principle*: Scale out via the process model
- *Problem Solved*: Horizontal scaling for performance
- *Key Practice*: Add more processes, not bigger processes

**12-Factor Agents (Small, Focused Agents)**
- *Adaptation*: Same as Factor IV -- compose many small agents
- *Why Changed*: Scaling AI through composition, not monoliths
- *Key Practice*: Parallelize via multiple agents

**12-Factor AgentOps (VIII: Compound Knowledge)**
- *Evolution*: Learnings must flow back into future sessions automatically
- *Why Different*: Extraction without injection is a write-only journal nobody reads
- *Key Practice*: Quality-gate extracted learnings, inject relevant knowledge at session start, measure retrieval effectiveness, let stale knowledge decay
- *Unique Aspect*: The HERO factor -- the knowledge flywheel that makes each session smarter than the last

---

### Factor IX: Disposability / Launch-Pause-Resume / Measure What Matters

**Original 12-Factor App (IX: Disposability)**
- *Principle*: Fast startup, graceful shutdown
- *Problem Solved*: Maximize robustness through disposability
- *Key Practice*: Processes can be stopped/started instantly

**12-Factor Agents (Launch/Pause/Resume)**
- *Adaptation*: Instant agent lifecycle management
- *Why Changed*: AI workflows need rapid start/stop
- *Key Practice*: Same as Factor V -- agent lifecycle APIs

**12-Factor AgentOps (IX: Measure What Matters)**
- *Evolution*: Track fitness toward goals, not activity metrics
- *Why Different*: Without measurement, you cannot know if your operations are improving
- *Key Practice*: Measure outcomes (validation pass rates, rework frequency, knowledge retrieval hit rates) not vanity metrics (tokens consumed, sessions run)
- *Unique Aspect*: Closes the feedback loop on the knowledge flywheel

---

### Factor X: Dev/Prod Parity / Implicit / Isolate Workers

**Original 12-Factor App (X: Dev/Prod Parity)**
- *Principle*: Keep development, staging, and production as similar as possible
- *Problem Solved*: Reduce gaps that cause bugs
- *Key Practice*: Minimize time, personnel, and tools gaps

**12-Factor Agents (Implicit)**
- *Adaptation*: Not explicitly called out, but implied in all factors
- *Note*: Incorporated into other factors

**12-Factor AgentOps (X: Isolate Workers)**
- *Evolution*: Each worker gets its own workspace, its own context, and zero shared mutable state
- *Why Different*: Parallel agents sharing state create cascading conflicts
- *Key Practice*: Git worktrees, separate context windows, independent validation
- *Unique Aspect*: Scale tier -- skip if working solo; essential for multi-agent orchestration

---

### Factor XI: Logs / Compact Errors / Supervise Hierarchically

**Original 12-Factor App (XI: Logs)**
- *Principle*: Treat logs as event streams
- *Problem Solved*: Centralized observability without local storage
- *Key Practice*: Never route or store logs in the app

**12-Factor Agents (Compact Errors into Context)**
- *Adaptation*: Turn errors into compressed learning context
- *Why Changed*: LLMs learn from failures in context window
- *Key Practice*: Error summaries become future context

**12-Factor AgentOps (XI: Supervise Hierarchically)**
- *Evolution*: Escalation flows up, never sideways
- *Why Different*: Multi-agent systems without hierarchy devolve into circular coordination
- *Key Practice*: Coordinator agents delegate and escalate; worker agents execute and report
- *Unique Aspect*: Scale tier -- skip if working solo; prevents coordination chaos in multi-agent setups

---

### Factor XII: Admin Processes / Contact Humans / Harvest Failures as Wisdom

**Original 12-Factor App (XII: Admin Processes)**
- *Principle*: Run admin/management tasks as one-off processes
- *Problem Solved*: Consistent environment for management tasks
- *Key Practice*: Same environment and codebase as long-running processes

**12-Factor Agents (Contact Humans with Tools)**
- *Adaptation*: Humans in the loop via tool calls
- *Why Changed*: AI needs human judgment for critical decisions
- *Key Practice*: Human contact is a first-class operation, not exception

**12-Factor AgentOps (XII: Harvest Failures as Wisdom)**
- *Evolution*: Failed attempts are data -- extract and index them with the same rigor as successes
- *Why Different*: Failures contain the highest-value learnings but are typically discarded
- *Key Practice*: Document what did not work and why; index failure patterns for future avoidance
- *Unique Aspect*: Scale tier -- feeds directly into Factor VII (Extract Learnings) and Factor VIII (Compound Knowledge)

---

## The Three Frameworks Are Complementary

Each addresses a different layer. You need the right framework for your problem:

### Use 12-Factor App for:
- Traditional web applications and SaaS products
- Cloud-native deployments
- Deterministic business logic

### Use 12-Factor Agents for:
- Building AI-powered applications
- Integrating LLMs into products
- Reliable agent workflows in customer-facing features

### Use 12-Factor AgentOps for:
- Using AI agents for any work (coding, writing, research, automation)
- Solo development with AI coding assistants
- Team collaboration with AI tools
- Any environment (cloud, local, air-gapped)
- Making AI usage get better over time through knowledge compounding

---

## The Stack in Practice

**Example: AI-powered customer service system**

- **12-Factor App**: Cloud-native web interface and API hosting
- **12-Factor Agents**: Reliable AI conversation agent
- **12-Factor AgentOps**: Operational discipline -- validate responses before customers see them, extract learnings from interactions, compound knowledge across the team

All three layers, complementary, not competitive.

---

## Further Reading

- [Original 12-Factor App Methodology](https://12factor.net) - Adam Wiggins, Heroku (2011)
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) - Dex Horthy, HumanLayer (2025)
- [Evolution of 12-Factor](./evolution-of-12-factor.md) - Full lineage from App to Agents to AgentOps
