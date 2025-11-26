# 12-Factor AgentOps

**Operational principles for reliable AI agents.**

---

> ### How do we take AI agents from 80% reliable to production-grade?

I've watched too many teams follow the same pattern: build exciting AI features, ship to production, watch it break, add manual review, bottleneck, abandon. The framework isn't the problem—the operational model is.

[Gene Kim](https://www.youtube.com/watch?v=vibe-coding) and [Steve Yegge](https://www.youtube.com/watch?v=Lf9xt0hMb_U) call this moment "vibe coding"—they're documenting the DevOps movement for AI, complete with FAAFO metrics (the DORA of this era). [Dex Horthy's 12-Factor Agents](https://github.com/humanlayer/12-factor-agents) shows how to *build* these systems right.

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

---

## Getting Started

Pick a factor that matches your pain point:
- **Context problems?** Start with [Factor II: Context Loading](./factors/02-context-loading.md)
- **Reliability issues?** Start with [Factor IV: Continuous Validation](./factors/04-continuous-validation.md)
- **No visibility?** Start with [Factor V: Measure Everything](./factors/05-measure-everything.md)

Or see the [Workflow Guide](./docs/tutorials/workflow-guide.md) for the full picture.

---

## Credit

- [12-Factor App](https://12factor.net) (Adam Wiggins) - the original methodology
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (Dex Horthy) - engineering patterns for building AI apps
- [Vibe Coding](https://www.youtube.com/watch?v=vibe-coding) (Gene Kim & Steve Yegge) - the DevOps movement for AI

---

**License:** CC BY-SA 4.0 (content) / Apache 2.0 (code)
