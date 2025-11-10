# 12-Factor AgentOps

**Stop trusting AI agents. Start validating them.**

A methodology for using AI agents safely and reliably—from solo developers to enterprise teams.

[![Version](https://img.shields.io/badge/Version-v1.0.4-blue.svg)]()
[![Status](https://img.shields.io/badge/Status-Beta--Community_Validation-blue.svg)](./marketplace/research/validation/DISCLAIMER.md)
[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

---

## Why This Matters

**You're using AI agents. They're powerful. But can you trust them?**

Here's what happens without validation:

```
Week 1: "Wow, this AI code looks great!" → Ship it
Week 2: "Why did this break production?" → Manual rollback
Week 3: "I need to review everything" → Bottleneck
Week 4: "This is slower than doing it myself" → Abandon AI
```

**The gap:** We know how to build reliable systems. We don't yet know how to build reliable systems *with* AI agents.

**The solution:** Treat AI output like untrusted network traffic. Validate everything before it ships.

---

## The 12 Factors

**Operational principles for safe AI agent usage.**

| # | Factor | What It Does |
|---|--------|--------------|
| **I** | **[Git Memory as Knowledge OS](./FACTORS.md#factor-i-git-memory-as-knowledge-os)** | One canonical history for agent work; commits capture intent, context, and learnings |
| **II** | **[JIT Context Loading](./FACTORS.md#factor-ii-jit-context-loading)** | Keep main context clean; delegate work to sub-agents with isolated context windows |
| **III** | **[Single-Responsibility Agents](./FACTORS.md#factor-iii-single-responsibility-agents)** | Compose workflows from focused agents; avoid monolith prompts |
| **IV** | **[Validation Gates Before Execution](./FACTORS.md#factor-iv-validation-gates-before-execution)** | Formal checkpoints (plan review, tests, hooks) before applying changes |
| **V** | **[Operational Telemetry](./FACTORS.md#factor-v-operational-telemetry)** | Metrics, logs, and observability for every agent run |
| **VI** | **[Session Continuity via Bundles](./FACTORS.md#factor-vi-session-continuity-via-bundles)** | Persist and restore context using compressed artifacts for multi-day work |
| **VII** | **[Intelligent Task Routing](./FACTORS.md#factor-vii-intelligent-task-routing)** | Route work to best-fit workflows/agents with measured accuracy |
| **VIII** | **[Human Gate Reviews](./FACTORS.md#factor-viii-human-gate-reviews)** | Embed human approvals between research → plan → implement phases |
| **IX** | **[Documented Pattern Extraction](./FACTORS.md#factor-ix-documented-pattern-extraction)** | Capture learnings after every session; publish reusable patterns |
| **X** | **[Continuous Improvement Backlog](./FACTORS.md#factor-x-continuous-improvement-backlog)** | Each session identifies improvements; prioritize and action them |
| **XI** | **[Constitutional Guardrails](./FACTORS.md#factor-xi-constitutional-guardrails)** | Enforce operational laws and prevent risky behaviors |
| **XII** | **[Domain Portability](./FACTORS.md#factor-xii-domain-portability)** | Package domain knowledge into reusable profiles and bundles |

**[See detailed explanations →](./FACTORS.md)**

---

## Quick Start

### 1. Understand the Workflow

AI agent work follows three phases:

```
Research → Plan → Implement
   ↓        ↓         ↓
Explore  Specify  Execute
```

Each phase has validation gates. No phase skips to the next without passing validation.

**[Full workflow guide →](./WORKFLOW.md)**

### 2. Apply the Factors

Start with the foundation factors (I-IV):

- **Factor I:** Use git for all agent work (semantic commits, meaningful history)
- **Factor II:** Break complex tasks into focused sub-agents
- **Factor III:** One agent, one job (no monolith prompts)
- **Factor IV:** Validate before applying (tests, reviews, gates)

Then add operational factors (V-XII) as you scale.

### 3. Use the Starter Pack

We provide a complete reference implementation:

```bash
# Clone the repository
git clone https://github.com/boshu2/12-factor-agentops

# Explore the starter pack
cd examples/STARTER-PACK
cat README.md
```

The starter pack shows all 12 factors in action.

---

## Operating Principles

Five mandatory principles for all agent work:

1. **Extract Learnings** - Patterns are valuable. One-time solutions are not.
2. **Improve Continuously** - Each session identifies at least one improvement.
3. **Document Context** - Future agents (and humans) will thank you.
4. **Validate First** - Prevention is cheaper than recovery.
5. **Share Patterns** - Help others avoid your mistakes.

**[Deep dive on principles →](./marketplace/principles/five-laws.md)**

---

## Is This For You?

**✅ Use this if you:**
- Use AI agents/LLMs for anything (coding, writing, research, automation)
- Want AI to make you faster, not create new problems
- Need to trust AI output before it goes to production
- Are tired of manually reviewing everything
- Want your AI usage to improve over time

**❌ Skip this if you:**
- Don't use AI agents
- Trust AI output without validation
- Prefer learning from production incidents

---

## Built on Proven Foundations

This framework adapts methodologies with **decades of validation** to AI agent operations:

- **DevOps** (20+ years) - Continuous integration, deployment automation, shift-left testing
- **GitOps** (10+ years) - Git as source of truth, declarative infrastructure
- **Zero-Trust** (10+ years) - Never trust, always verify—applied to AI outputs
- **SRE** (15+ years from Google) - Error budgets, observability, incident response

**Early results are promising:**
- 40x speedups on complex workflows
- 95% success rates with full compliance
- 0% context collapse with proper context management
- 8x efficiency gains from cognitive load management

**Now seeking community validation** across diverse domains.

**[Research foundations →](./marketplace/research/)**

---

## Where to Go Next

**Core methodology (required reading - ~1 hour):**
1. [README.md](./README.md) - This page (10 min)
2. [FACTORS.md](./FACTORS.md) - Detailed factor explanations (30 min)
3. [WORKFLOW.md](./WORKFLOW.md) - How to apply this (20 min)

**Practical implementation:**
4. [Starter Pack](./examples/STARTER-PACK/) - Complete reference implementation
5. [Domain Guides](./marketplace/domain-guides/) - DevOps, SRE, solo dev, etc.

**Deep dives (optional):**
6. [Marketplace](./marketplace/) - Philosophy, research, advanced patterns, case studies

**Community:**
7. [CONTRIBUTING.md](./CONTRIBUTING.md) - Share your patterns and validation
8. [GitHub Discussions](https://github.com/boshu2/12-factor-agentops/discussions) - Ask questions, share results

---

## Related Work

This framework complements other 12-factor methodologies:

```
12-Factor App (2011)     → How to build cloud-native apps (Heroku)
12-Factor Agents (2025)  → How to build AI apps (Dex Horthy @ HumanLayer)
12-Factor AgentOps (2025) → How to use AI safely (This Framework)
```

**Dex's [12-Factor Agents](https://github.com/humanlayer/12-factor-agents)** helps you build reliable AI applications.

**Our 12-Factor AgentOps** helps you use AI agents safely in any context.

Both are complementary, not competitive.

---

## Contributing

We welcome:
- Production-validated patterns
- Empirical research and case studies
- Domain-specific implementation guides
- Failure analyses (what didn't work)

See [CONTRIBUTING.md](./CONTRIBUTING.md) for process.

---

## License & Citation

**License:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)

**Citation:** See [CITATION.bib](./CITATION.bib)

---

## Support

- **Documentation:** [marketplace/](./marketplace/)
- **Issues:** [GitHub Issues](https://github.com/boshu2/12-factor-agentops/issues)
- **Discussions:** [GitHub Discussions](https://github.com/boshu2/12-factor-agentops/discussions)

---

**Start with the factors. Everything else is context.**

**[Read the 12 factors →](./FACTORS.md)**
