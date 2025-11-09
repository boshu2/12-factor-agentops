# Glossary of Terms

**Quick reference for key concepts in 12-Factor AgentOps**

---

## Core Concepts

### AgentOps
The operational discipline and practices for using AI agents safely and reliably. Combines proven methodologies (DevOps, GitOps, Zero-Trust) with AI-specific patterns.

### AI Agent
An autonomous or semi-autonomous system powered by large language models (LLMs) that performs tasks on behalf of humans. Examples: Claude Code, ChatGPT, Cursor, GitHub Copilot.

### Knowledge OS
Using Git as an operating system for institutional memory. Every commit becomes a memory write, branches provide isolation, and history creates an audit trail that compounds value over time.

---

## The Framework Hierarchy

### Four Pillars
The philosophical foundations underlying all 12 factors:
1. **DevOps + SRE** - Infrastructure operations practices
2. **Learning Science** - How humans and systems learn
3. **Context Engineering** - Cognitive load management
4. **Knowledge OS** - Git as institutional memory

**See:** [foundations/four-pillars.md](./foundations/four-pillars.md)

### Five Laws
Non-negotiable operational principles that govern all agent work:
1. ALWAYS Extract Learnings
2. ALWAYS Improve Self or System
3. ALWAYS Document Context for Future
4. ALWAYS Validate Before Execute
5. ALWAYS Share Patterns Publicly

**See:** [foundations/five-laws.md](./foundations/five-laws.md)

### Twelve Factors
Operational principles derived from the Four Pillars and enforcing the Five Laws. Each factor addresses a specific aspect of safe AI agent usage.

**See:** [factors/README.md](./factors/README.md)

---

## Context Management

### Context Window
The maximum amount of information an AI agent can "see" at once. For Claude: ~200,000 tokens (~150,000 words). Managing this window is critical to prevent context collapse.

### Context Collapse
Performance degradation when an AI agent's context window becomes too full. Symptoms: forgetting earlier information, making inconsistent decisions, decreased output quality.

### Context Engineering
The practice of managing cognitive load (human or AI) to maintain peak performance. Based on the observation that both humans and AI perform best under ~40% capacity utilization.

**See:** [foundations/context-engineering.md](./foundations/context-engineering.md)

### 40% Rule
**Observation:** Performance collapse happens around 40% capacity utilization for both humans (ADHD research) and AI (context window studies).

**Application:** Stay under 40% context utilization in any phase to maintain peak performance.

**Strategy:** Just-In-Time loading, progressive disclosure, periodic compression via context bundles.

### JIT Context Loading
**Just-In-Time Context Loading** - Load information only when needed, not all at once. Primary implementation: Delegate work to sub-agents with isolated context windows; main agent orchestrates but doesn't accumulate context.

**See:** [factors/02-jit-context-loading.md](./factors/02-jit-context-loading.md)

### Context Bundle
Compressed markdown documentation that captures essential information for multi-day work. Typically achieves 5:1 to 10:1 compression ratio while preserving critical details.

**Example:** 50k tokens of research → 5k token bundle

**See:** [factors/06-session-continuity-via-bundles.md](./factors/06-session-continuity-via-bundles.md) and [patterns/context-bundles.md](./patterns/context-bundles.md)

---

## Patterns & Practices

### Single-Responsibility Agents
Each agent/workflow should do ONE thing well. Compose complex work from multiple focused agents rather than creating monolithic prompts.

**Analogy:** Unix philosophy ("do one thing well") applied to AI agents.

**See:** [factors/03-single-responsibility-agents.md](./factors/03-single-responsibility-agents.md)

### Validation Gates
Formal checkpoints (tests, linting, human review) before applying changes. Never trust AI or human output without validation.

**Key insight:** Quality gates don't care about the source (AI or human)—they care about the outcome.

**See:** [factors/04-validation-gates-before-execution.md](./factors/04-validation-gates-before-execution.md)

### Phase-Based Workflow
Progression through distinct phases: Research → Plan → Implement → Validate → Learn. Each phase has specific goals and stays within context budget.

**Based on:** Learning science principles of progressive complexity.

**See:** [patterns/phase-based-workflow.md](./patterns/phase-based-workflow.md)

### Intelligent Routing
Automatically selecting the best workflow/agent for a given task based on measured accuracy and historical performance.

**See:** [factors/07-intelligent-task-routing.md](./factors/07-intelligent-task-routing.md) and [patterns/intelligent-routing.md](./patterns/intelligent-routing.md)

### Constitutional Guardrails
Non-negotiable operational rules that cannot be overridden. Enforced through automation (pre-commit hooks, CI/CD gates) rather than supervision.

**Example:** Five Laws enforcement, commit message templates, validation requirements.

**See:** [factors/11-constitutional-guardrails.md](./factors/11-constitutional-guardrails.md)

---

## Validation & Evidence

### Validation Tiers
Three levels of evidence strength used in this framework:

- 🟢 **Strong Evidence:** n≥30, statistical analysis, confidence intervals, documented methodology
- 🟡 **Qualitative Evidence:** Multiple observations, documented patterns, no statistical analysis
- 🔴 **Insufficient Evidence:** Anecdotal only, needs further validation

**See:** [validation/DISCLAIMER.md](./validation/DISCLAIMER.md)

### Domain Portability
The ability to package domain knowledge (patterns, templates, configs) into reusable profiles that work across teams and contexts.

**Goal:** Patterns discovered in one domain (e.g., DevOps) should work in others (e.g., product development).

**See:** [factors/12-domain-portability.md](./factors/12-domain-portability.md)

---

## Methodological Foundations

### Zero-Trust Cognitive Infrastructure
Applying zero-trust security principles (never trust, always verify) to AI agent outputs. Treat all intelligence (human or AI) as untrusted I/O requiring validation.

**Key shift:** Stop asking "was this made by AI or human?" Start asking "does this pass validation?"

### DevOps
**Development + Operations** - A set of practices that combines software development and IT operations. Emphasizes automation, continuous integration/deployment, and rapid feedback loops.

**Applied to AgentOps:** Version control for memory, validation gates for quality, observability for behavior.

### GitOps
An operational framework using Git as the single source of truth for declarative infrastructure and applications. All changes go through Git, enabling audit trails and rollback.

**Applied to AgentOps:** Git Memory as Knowledge OS (Factor I).

### SRE (Site Reliability Engineering)
Google's approach to operations that applies software engineering principles to infrastructure and operations problems. Focus: reliability, observability, error budgets.

**Applied to AgentOps:** Operational telemetry (Factor V), continuous improvement (Factor X).

---

## Research Terminology

### Cognitive Load Theory
Research showing that humans have limited working memory capacity (~7±2 items). Excessive cognitive load impairs learning and performance.

**Applied to AgentOps:** Context Engineering and the 40% rule.

**Key researcher:** John Sweller (1988)

### Spaced Repetition
Learning technique where information is reviewed at increasing intervals. Improves long-term retention.

**Applied to AgentOps:** Context bundles for session continuity (Factor VI).

### Pattern Recognition
The ability to identify recurring structures or approaches. Critical for both human learning and AI agent effectiveness.

**Applied to AgentOps:** Pattern extraction (Factor IX), reusable templates.

---

## Git Terminology

### Commit
A snapshot of changes to a repository. In AgentOps, commits serve as memory writes—capturing intent, context, and learnings.

**Template:**
```
<type>(<scope>): <subject>

Context: Why was this needed?
Solution: What was done?
Learning: What patterns emerged?
Impact: What value was created?
```

### Branch
An isolated line of development. In AgentOps, branches provide process isolation—parallel work without interference.

### Merge
Combining changes from different branches. In AgentOps, merges represent integration points where isolated work comes together.

### Hook
Scripts that run automatically at specific points in Git workflow (e.g., pre-commit, post-commit). Used to enforce guardrails and validation gates.

---

## Metrics & Measurement

### Success Rate
Percentage of agent sessions that complete successfully (pass all validation gates).

**Example:** "95% success rate when following all factors" means 95 out of 100 workflows completed without errors.

### Speedup
Ratio of time saved by using a practice versus baseline.

**Example:** "40x speedup" means a task that took 40 hours now takes 1 hour.

**Note:** Framework documentation reports observed speedups as "early results" requiring community validation.

### Context Collapse Rate
Percentage of sessions where agent performance degrades due to context window overflow.

**Example:** "0% context collapse with Factor II enforcement" means no degradation when using JIT Context Loading.

### Pattern Reuse
How many times a single pattern/agent is used across different workflows.

**Example:** "Agent reused 8.3 times on average" means patterns are not one-off but genuinely reusable.

---

## Diátaxis Framework

A documentation methodology organizing content into four types:

### Tutorials (Learning-Oriented)
Step-by-step lessons that teach through doing. Goal: Get beginners started successfully.

**Status in this repo:** Coming soon

### How-To Guides (Problem-Oriented)
Recipes for solving specific problems. Goal: Help practitioners achieve specific tasks.

**Status in this repo:** Coming soon

### Reference (Information-Oriented)
Technical descriptions providing complete, accurate information. Goal: Look up facts.

**Location:** [factors/](./factors/), [patterns/](./patterns/)

### Explanation (Understanding-Oriented)
Discussions that clarify and deepen understanding of concepts. Goal: Explain why things work.

**Location:** [foundations/](./foundations/), [docs/research/](./docs/research/)

**See:** https://diataxis.fr/

---

## Comparison Terminology

### 12-Factor App (Original)
Heroku's 2011 methodology for building cloud-native SaaS applications. Established 12 principles for portable, scalable apps.

**Relationship to AgentOps:** We extend these proven principles for AI agent operations.

**See:** https://12factor.net and [docs/foundations/evolution-of-12-factor.md](./docs/foundations/evolution-of-12-factor.md)

### 12-Factor Agents
Dex Horthy's 2025 framework for building reliable LLM applications. Focus: How to build AI apps that exceed 70-80% quality.

**Relationship to AgentOps:** Complementary. They help you **build** AI apps; we help you **use** AI safely.

**See:** https://github.com/humanlayer/12-factor-agents

---

## Quick Lookups

**Where do I start?**
→ [README.md](./README.md) - Framework overview (5 minutes)

**What's the philosophy?**
→ [foundations/four-pillars.md](./foundations/four-pillars.md) (15 minutes)

**What are the operational principles?**
→ [factors/README.md](./factors/README.md) - All 12 factors (10 minutes)

**What patterns exist?**
→ [patterns/README.md](./patterns/README.md) - Pattern catalog

**What's validated vs. in progress?**
→ [validation/DISCLAIMER.md](./validation/DISCLAIMER.md) - Transparent status

**How do I contribute?**
→ [CONTRIBUTING.md](./CONTRIBUTING.md) - Contribution guide

---

## Acronyms

- **AI** - Artificial Intelligence
- **LLM** - Large Language Model
- **SRE** - Site Reliability Engineering
- **CI/CD** - Continuous Integration / Continuous Deployment
- **JIT** - Just-In-Time
- **ROI** - Return on Investment
- **TL;DR** - Too Long; Didn't Read (summary)
- **ADHD** - Attention Deficit Hyperactivity Disorder (relevant to context engineering research)

---

**Don't see a term?** Open an issue or submit a PR to add it: [CONTRIBUTING.md](./CONTRIBUTING.md)
