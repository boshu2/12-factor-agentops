# 12-Factor AgentOps

**A methodology for using AI agents safely and reliably.**

<div align="center">

[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![Version](https://img.shields.io/badge/Version-v1.0.4_Beta-blue.svg)]()
[![GitHub Stars](https://img.shields.io/github/stars/boshu2/12-factor-agentops?style=social)](https://github.com/boshu2/12-factor-agentops)

</div>

---

## What Is This?

12-Factor AgentOps is a framework for using AI agents and LLMs reliably in any context—from solo development to enterprise production.

Unlike frameworks that teach you how to *build* AI applications, this framework teaches you how to *operate* them safely. It's inspired by [12-Factor App](https://12factor.net) (cloud applications) and adapted for the unique challenges of AI agents.

## The Problem

Everyone's using AI agents now. Few are using them reliably.

The typical pattern:
- **Week 1:** Ship exciting AI output
- **Week 2:** It broke production
- **Week 3:** Manual review becomes a bottleneck
- **Week 4:** "This is slower than doing it myself" → Abandon AI

This happens because AI is fundamentally different from traditional software:
- **Traditional software:** Same input → same output (deterministic)
- **AI agents:** Same input → different output (probabilistic)

Traditional reliability practices (code review, unit tests) don't work on probabilistic systems.

## The Solution

After years of using AI in production, I discovered that **successful AI agent usage looks a lot like infrastructure operations:**
- **Validation gates** - Check outputs before deploying
- **Observability** - Metrics and logging for everything
- **Zero-trust** - Never trust, always verify
- **Pattern learning** - Extract learnings from each run
- **Continuous improvement** - Make the system better over time

These 20+ year-old DevOps and SRE practices work for AI too. This framework codifies them as 12 operational factors.

## Who This Is For

- **Solo developers** using AI coding assistants
- **Teams** collaborating with AI tools
- **Enterprises** deploying AI agents in production
- **Anyone** who wants AI usage to get better, not worse, over time

## The 12 Factors

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

# Optional: Documentation and validation
/plugin install research-formatter@12-factor-agentops               # Format case studies
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

## Getting Started

**Read the factors above.** Each one addresses a specific failure mode you'll encounter when using AI in production.

**Then explore:**
- [FACTORS.md](./FACTORS.md) - Quick reference of all 12 factors
- [WORKFLOW.md](./WORKFLOW.md) - How to apply the factors to your work
- [docs/](./docs/) - Deep dives on philosophy, research, and domain-specific guides

**Want to see it in action?**
- [examples/STARTER-PACK](./examples/STARTER-PACK/) - Complete example using all 12 factors

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
