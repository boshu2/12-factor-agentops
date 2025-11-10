# 12-Factor AgentOps

*In the spirit of [12 Factor Apps](https://12factor.net/)*.

---

I've been using AI agents in production since Claude 2.0. I've built workflows spanning GitOps automation to infrastructure operations, running them in production environments from solo projects to DoD systems.

**I've watched AI agents fail spectacularly** - breaking production, generating plausible-but-wrong code, and creating more work than they save.

**I've also watched them succeed beyond expectations** - 589 commits in 60 days (85% AI-authored), 52 production agents deployed, 53 apps running live with 95% success rates.

So I set out to answer:

> ### **How do you use AI agents reliably enough to trust them with production work?**

Welcome to 12-Factor AgentOps.

---

## The Twelve Factors

- [Factor 1: Git Memory as Knowledge OS](./factors/01-git-memory-as-knowledge-os.md)
- [Factor 2: JIT Context Loading](./factors/02-jit-context-loading.md)
- [Factor 3: Single-Responsibility Agents](./factors/03-single-responsibility-agents.md)
- [Factor 4: Validation Gates Before Execution](./factors/04-validation-gates-before-execution.md)
- [Factor 5: Operational Telemetry](./factors/05-operational-telemetry.md)
- [Factor 6: Session Continuity via Bundles](./factors/06-session-continuity-via-bundles.md)
- [Factor 7: Intelligent Task Routing](./factors/07-intelligent-task-routing.md)
- [Factor 8: Human Gate Reviews](./factors/08-human-gate-reviews.md)
- [Factor 9: Documented Pattern Extraction](./factors/09-documented-pattern-extraction.md)
- [Factor 10: Continuous Improvement Backlog](./factors/10-continuous-improvement-backlog.md)
- [Factor 11: Constitutional Guardrails](./factors/11-constitutional-guardrails.md)
- [Factor 12: Domain Portability](./factors/12-domain-portability.md)

---

## How to Use This

**Start here:** Read the factors. Each one addresses a specific failure mode I've seen in production.

**Then:** Check out the [workflow guide](./WORKFLOW.md) for practical application.

**Go deeper:** Browse [examples/STARTER-PACK](./examples/STARTER-PACK/) to see all 12 factors in action.

**Optional:** Explore [marketplace/](./marketplace/) for philosophy, research, and advanced patterns.

---

## Why This Approach?

Unlike agent *frameworks* (which help you build AI applications), this is about agent *operations* - making AI usage reliable regardless of tool or framework.

**Key insight:** AI agents need the same operational discipline we apply to infrastructure - validation gates, observability, version control, and continuous improvement.

**Built on:** 20+ years of proven DevOps, GitOps, and Zero-Trust practices adapted for AI agents.

---

## Related Work

- **[12-Factor App](https://12factor.net)** (Adam Wiggins, Heroku) - Building cloud-native apps
- **[12-Factor Agents](https://github.com/humanlayer/12-factor-agents)** (Dex Horthy, HumanLayer) - Building reliable AI applications

This framework focuses on *using* AI agents safely. Dex's framework focuses on *building* AI applications. Both are complementary.

---

## Status & Contributing

**Version:** v1.0.4 Beta

**Status:** Community validation in progress. Early production results are promising. Help validate across domains.

**Contributing:** See [CONTRIBUTING.md](./CONTRIBUTING.md)

---

## License

[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

Code samples: Apache 2.0
Content: CC BY-SA 4.0

See [CITATION.bib](./CITATION.bib) for academic citation.
