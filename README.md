<div align="center">

# 12-Factor AgentOps

**Operational principles for reliable AI agents.**

[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![Version](https://img.shields.io/badge/Version-v1.1.0-blue.svg)](https://github.com/boshu2/12-factor-agentops/releases)
[![GitHub Stars](https://img.shields.io/github/stars/boshu2/12-factor-agentops?style=social)](https://github.com/boshu2/12-factor-agentops)

![12-Factor AgentOps Landscape](./docs/assets/12-factor-landscape-animated.svg)

</div>

---

> ### How do we take AI agents from 80% reliable to production-grade?

I've watched too many teams follow the same pattern: build exciting AI features, ship to production, watch it break, add manual review, bottleneck, abandon. The framework isn't the problem—the operational model is.

[Gene Kim and Steve Yegge](https://itrevolution.com/product/vibe-coding-book/) call this moment "vibe coding"—they're documenting the DevOps movement for AI, complete with FAAFO metrics (the DORA of this era). [Dex Horthy's 12-Factor Agents](https://github.com/humanlayer/12-factor-agents) shows how to *build* these systems right.

**This is the SRE to their DevOps.** It's not about building—it's about operating.

Traditional software practices don't work on probabilistic systems:

| | Deterministic Code | AI Agents |
|-|-------------------|-----------|
| **Consistency** | Same input → same output | Same input → different output |
| **Errors** | Predictable, reproducible | Novel, context-dependent |
| **Testing** | Unit tests, edge cases | Probabilistic sampling |
| **Reliability** | Code review, testing | Observability, validation, fallbacks |

But infrastructure operations patterns do. The answer is 20 years of DevOps/SRE wisdom—validation gates, observability, zero-trust, pattern extraction—finally applied to the right problem.

---

## Quick Load (AI Sessions)

| Document | Tokens | Coverage | Use For |
|----------|--------|----------|---------|
| **[docs/00-SUMMARY.md](./docs/00-SUMMARY.md)** | ~10k | 99% | Fast context loading, AI sessions, quick reference |

The summary compresses the full corpus into ~10k tokens with zero essential loss. **Start here for AI-assisted work.**

---

## The 12 Factors

### Foundation (I-IV)

| Factor | What It Does |
|--------|--------------|
| **[I. Automated Tracking](./factors/01-automated-tracking.md)** | Track everything in git. No tribal knowledge. |
| **[II. Context Loading](./factors/02-context-loading.md)** | Load only what you need. Stay under 40%. |
| **[III. Focused Agents](./factors/03-focused-agents.md)** | One agent, one job. Compose specialists. |
| **[IV. Continuous Validation](./factors/04-continuous-validation.md)** | Check at every step. Catch errors early. |

### Operations (V-VIII)

| Factor | What It Does |
|--------|--------------|
| **[V. Measure Everything](./factors/05-measure-everything.md)** | If you can't measure it, you can't improve it. |
| **[VI. Resume Work](./factors/06-resume-work.md)** | Save state. Pick up where you left off. |
| **[VII. Smart Routing](./factors/07-smart-routing.md)** | Send tasks to the right specialist. |
| **[VIII. Human Validation](./factors/08-human-validation.md)** | Humans approve critical steps. |

### Improvement (IX-XII)

| Factor | What It Does |
|--------|--------------|
| **[IX. Mine Patterns](./factors/09-mine-patterns.md)** | Search history. Find what works. |
| **[X. Small Iterations](./factors/10-small-iterations.md)** | Improve continuously. Small tweaks compound. |
| **[XI. Fail-Safe Checks](./factors/11-fail-safe-checks.md)** | Prevent repeating mistakes. Add guardrails. |
| **[XII. Package Patterns](./factors/12-package-patterns.md)** | Bundle what works. Reuse it. |

<div align="center">

![How the Factors Work Together](./docs/assets/workflow-flow-animated.svg)

</div>

---

## Getting Started

Pick a factor that matches your pain point:

- **Context problems?** Start with [Factor II: Context Loading](./factors/02-context-loading.md)
- **Reliability issues?** Start with [Factor IV: Continuous Validation](./factors/04-continuous-validation.md)
- **No visibility?** Start with [Factor V: Measure Everything](./factors/05-measure-everything.md)
- **What can go wrong?** See [The 12 Failure Patterns](./docs/reference/failure-patterns.md)
- **Enterprise validation?** See [Case Studies](./docs/case-studies/enterprise-validation.md)

Or see the [Workflow Guide](./docs/tutorials/workflow-guide.md) for the full picture.

---

## Credit

- [12-Factor App](https://12factor.net) (Adam Wiggins) - the original methodology
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (Dex Horthy) - engineering patterns for building AI apps
- [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) (Gene Kim & Steve Yegge) - the DevOps movement for AI

---

<div align="center">

**License:** CC BY-SA 4.0 (content) / Apache 2.0 (code)

</div>
