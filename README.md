# 12-Factor AgentOps

<div align="center">

[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![Version](https://img.shields.io/badge/Version-v1.0.4_Beta-blue.svg)]()
[![GitHub Stars](https://img.shields.io/github/stars/boshu2/12-factor-agentops?style=social)](https://github.com/boshu2/12-factor-agentops)

</div>

*In the spirit of [12 Factor Apps](https://12factor.net/)*.

> [!TIP]
> **New to AI agents?** Start with [Factor 4: Validation Gates](./factors/04-validation-gates-before-execution.md) - it's the most critical.
>
> **Want to see what I built?** Check [What I've Built](#what-ive-built) for my production experience.
>
> **Looking for examples?** Jump to [STARTER-PACK](./examples/STARTER-PACK/) to see all 12 factors in action.

---

I've been using AI agents in production since Claude 2.0. I've built workflows spanning GitOps automation to infrastructure operations, running them in production environments from solo projects to DoD systems.

**I've watched teams abandon AI agents after a few weeks** - the pattern is always the same: initial excitement, production incidents, manual review bottlenecks, then abandonment.

**I've also watched my own attempts fail** - "just be careful" broke production, "review everything" became a bottleneck, "only simple tasks" provided minimal value.

**I've been surprised to find** that successful AI agent usage looks a lot like infrastructure operations - validation gates, observability, zero-trust principles, and continuous improvement.

So I set out to answer:

> ### **How do you use AI agents reliably enough to trust them with production work?**

Welcome to 12-Factor AgentOps.

*This is an early-stage framework based on production experience. Community validation and feedback are welcome.*

---

## The Twelve Factors

### Foundation (I-IV)
Build reliability from the ground up

| Factor | What It Does |
|--------|--------------|
| **[I. Git Memory as Knowledge OS](./factors/01-git-memory-as-knowledge-os.md)** | One canonical history - commits capture intent, context, learnings |
| **[II. JIT Context Loading](./factors/02-jit-context-loading.md)** | Keep main context clean - delegate to sub-agents with isolated windows |
| **[III. Single-Responsibility Agents](./factors/03-single-responsibility-agents.md)** | One agent, one job - compose workflows from focused agents |
| **[IV. Validation Gates Before Execution](./factors/04-validation-gates-before-execution.md)** | Never trust, always verify - formal checkpoints before applying changes |

### Operations (V-VIII)
Scale and maintain reliability in production

| Factor | What It Does |
|--------|--------------|
| **[V. Operational Telemetry](./factors/05-operational-telemetry.md)** | Metrics and observability - know what your agents are doing |
| **[VI. Session Continuity via Bundles](./factors/06-session-continuity-via-bundles.md)** | Persist context across sessions - multi-day work without collapse |
| **[VII. Intelligent Task Routing](./factors/07-intelligent-task-routing.md)** | Right agent, right task - route work to best-fit workflows |
| **[VIII. Human Gate Reviews](./factors/08-human-gate-reviews.md)** | Strategic human checkpoints - approval gates between phases |

### Improvement (IX-XII)
Continuous learning and adaptation

| Factor | What It Does |
|--------|--------------|
| **[IX. Documented Pattern Extraction](./factors/09-documented-pattern-extraction.md)** | Capture learnings after every session - patterns compound |
| **[X. Continuous Improvement Backlog](./factors/10-continuous-improvement-backlog.md)** | Each session identifies improvements - prioritize and action |
| **[XI. Constitutional Guardrails](./factors/11-constitutional-guardrails.md)** | Enforce operational laws - prevent risky behaviors |
| **[XII. Domain Portability](./factors/12-domain-portability.md)** | Package domain knowledge - reusable profiles and bundles |

---

## Installation

### Claude Code Plugin Marketplace

This repository provides a **Claude Code plugin marketplace** with validation and pattern extraction skills:

```bash
# Add the 12-factor-agentops marketplace
/plugin marketplace add boshu2/12-factor-agentops

# Install validation skills (pick what you need)
/plugin install factor-compliance-checker@12-factor-agentops       # Validate factor compliance
/plugin install five-laws-auditor@12-factor-agentops                # Audit against Five Laws
/plugin install pattern-extraction-assistant@12-factor-agentops     # Extract patterns from work

# Optional: Documentation organization
/plugin install research-formatter@12-factor-agentops               # Format case studies
/plugin install diataxis-organizer@12-factor-agentops               # Organize docs
/plugin install cross-reference-validator@12-factor-agentops        # Validate links
```

**For production workflows**, install from the [boshu2/agentops](https://github.com/boshu2/agentops) marketplace:
```bash
# Add the agentops marketplace
/plugin marketplace add boshu2/agentops

# Install production workflow plugins
/plugin install core-workflow@agentops           # Research → Plan → Implement → Learn (required base)
/plugin install devops-operations@agentops       # Kubernetes, Helm, ArgoCD, CI/CD
/plugin install software-development@agentops    # Python, JavaScript, Go, testing
```

### Manual Use

Read the methodology without installing plugins:

```bash
git clone https://github.com/boshu2/12-factor-agentops
cd 12-factor-agentops
cat README.md        # Start here
cat FACTORS.md       # Quick reference
cat WORKFLOW.md      # Practical application
```

---

## How to Use This

**Start here:** Read the factors above. Each one addresses a specific failure mode I've seen in production.

**Then:** Check out the [workflow guide](./WORKFLOW.md) for practical application (Research → Plan → Implement).

**Go deeper:** Browse [examples/STARTER-PACK](./examples/STARTER-PACK/) to see all 12 factors in action.

**Optional:** Explore [docs/](./docs/) for philosophy, research, and advanced patterns (Four Pillars, Five Laws, domain guides, case studies).

---

## How We Got Here

### The Problem

Everyone's using AI agents now. Few are using them reliably. The pattern is always the same:

```
Week 1: ✨ "This AI code looks great!" → Ship it
Week 2: 🔥 "Why did this break production?" → Manual rollback
Week 3: 🐌 "I need to review everything" → Bottleneck
Week 4: 🚫 "This is slower than doing it myself" → Abandon AI
```

I watched this cycle repeat across teams, companies, and domains.

### What I Tried

**First attempt:** "Just be careful"
- Result: Still broke production
- Learning: Vigilance doesn't scale

**Second attempt:** "Review everything"
- Result: Bottleneck, agents became slower than manual work
- Learning: Defeats the purpose of automation

**Third attempt:** "Only use for simple tasks"
- Result: Minimal value, couldn't leverage full potential
- Learning: Fear-based constraints limit innovation

**Fourth attempt:** "Copy infrastructure patterns"
- Result: THIS WORKED
- Learning: Treat AI like untrusted infrastructure

### The Breakthrough

AI agents need the same operational discipline we apply to infrastructure:

- **Zero-Trust:** Validate all output (AI or human)
- **Shift-Left:** Test locally before commit
- **Observability:** Metrics and telemetry for every run
- **Pattern Learning:** Extract and reuse successful approaches
- **Blast Radius:** Single-responsibility minimizes damage

This became the 12 factors.

### What I've Built

From my own production GitOps environment (60 days of operations):

- **589 commits** - 85% AI-authored
- **52 agents** - Deployed in production infrastructure
- **53 apps** - 261 YAML manifests, 100+ Kubernetes resources
- **Validation approach** - Every change validated before commit

This represents one practitioner's experience. Your mileage may vary. I'm sharing what worked for me, not claiming universal validation.

---

## Why This Approach?

Unlike agent *frameworks* (which help you build AI applications), this is about agent *operations* - making AI usage reliable regardless of tool or framework.

**The gap:** Everyone knows how to build reliable systems. Few know how to build reliable systems *with AI agents*.

**The solution:** Apply 20+ years of proven operational practices:
- **DevOps** (2000s) - Continuous integration, deployment automation
- **GitOps** (2010s) - Git as source of truth, declarative infrastructure
- **Zero-Trust** (2010s) - Never trust, always verify
- **SRE** (Google, 2003) - Error budgets, observability, reliability engineering

**The innovation:** Adapting these proven practices to the unique challenges of AI agents (probabilistic outputs, autonomous decisions, context management).

### What Makes AI Different

Traditional software is deterministic:
- Same input → Same output
- Code review catches all bugs
- Tests validate all paths

AI agents are probabilistic:
- Same input → Different output
- Review can't catch creativity/judgment
- Tests can't cover infinite possibilities

**This requires new operational patterns:**
- Validation gates (catch bad outputs before they ship)
- Pattern extraction (learn from good outputs)
- Constitutional guardrails (prevent entire classes of bad behavior)
- Session continuity (manage context across long workflows)

---

## Related Work

- **[12-Factor App](https://12factor.net)** (Adam Wiggins, Heroku) - Building cloud-native apps
- **[12-Factor Agents](https://github.com/humanlayer/12-factor-agents)** (Dex Horthy, HumanLayer) - Building reliable AI applications

This framework focuses on *using* AI agents safely. Dex's framework focuses on *building* AI applications. Both are complementary.

**Key difference:**
- 12-Factor Agents: Engineering patterns for developers building AI apps
- 12-Factor AgentOps: Operational patterns for anyone using AI agents

---

## Status & Contributing

**Version:** v1.0.4 Beta

**Status:** Early-stage framework based on production experience. Seeking community validation across domains.

This represents patterns I've found useful. It's not a proven methodology - that requires community validation. If you try these approaches, please share what works (and what doesn't) via GitHub Discussions.

**Contributing:** See [CONTRIBUTING.md](./CONTRIBUTING.md)

**Community:**
- **Discussions:** Share your experience, ask questions
- **Issues:** Report problems, suggest improvements
- **Pull Requests:** Contribute patterns, case studies, domain guides

Help validate whether these patterns work beyond my specific context.

---

## License

[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

Code samples: Apache 2.0
Content: CC BY-SA 4.0

See [CITATION.bib](./CITATION.bib) for academic citation.
