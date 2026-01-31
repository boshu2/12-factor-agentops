<div align="center">

# 12-Factor AgentOps

### DevOps for Vibe-Coding
#### Shift-Left Validation for Coding Agents

<!-- Build & Status -->
[![CI](https://img.shields.io/github/actions/workflow/status/boshu2/12-factor-agentops/validate-profiles.yml?label=CI)](https://github.com/boshu2/12-factor-agentops/actions)
[![Version](https://img.shields.io/badge/Version-2.0.0-blue.svg)](https://github.com/boshu2/12-factor-agentops/releases)

<!-- Technology -->
[![Claude Code](https://img.shields.io/badge/Claude%20Code-2.1-blueviolet.svg)](https://docs.anthropic.com/en/docs/claude-code)
[![12 Factors](https://img.shields.io/badge/Factors-12-00CED1.svg)](factors/)
[![Skills](https://img.shields.io/badge/Skills-5-00CED1.svg)](marketplace/)

<!-- Meta -->
[![License](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![GitHub Stars](https://img.shields.io/github/stars/boshu2/12-factor-agentops?style=social)](https://github.com/boshu2/12-factor-agentops)

<br/>

![The Improvement Cycle](./docs/assets/workflow-flow-animated.svg)

<br/>

---

### How do we shift validation left—before AI-generated code ships?

</div>

<br/>

I've watched too many teams follow the same pattern: build exciting AI features, ship to production, watch it break, add manual review, bottleneck, abandon.

**The framework isn't the problem—the operational model is.**

<table>
<tr>
<td width="50%">

**Deterministic Code**
- Same input → same output
- Predictable, reproducible errors
- Unit tests, edge cases
- Code review, testing

</td>
<td width="50%">

**AI Agents**
- Same input → different output
- Novel, context-dependent errors
- Probabilistic sampling
- Observability, validation, fallbacks

</td>
</tr>
</table>

The answer is 20 years of **DevOps/SRE wisdom**—validation gates, observability, zero-trust, pattern extraction—finally applied to the right problem.

> **The operational layer of the Vibe Ecosystem.** [Gene Kim and Steve Yegge's Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) is the methodology for working with AI. [Dex Horthy's 12-Factor Agents](https://github.com/humanlayer/12-factor-agents) shows how to build autonomous systems. This shows how to **operate** them reliably.

---

<details>
<summary><strong>Quick Load for AI Sessions</strong> — Compressed context (~10k tokens)</summary>

<br/>

| Document | Tokens | Coverage |
|----------|--------|----------|
| **[docs/00-SUMMARY.md](./docs/00-SUMMARY.md)** | ~10k | 99% |

The summary compresses the full corpus into ~10k tokens with zero essential loss. **Start here for AI-assisted work.**

</details>

---

## The 12 Factors

<table>
<tr>
<td valign="top" width="33%">

### Foundation (I-IV)
*Build reliability from the ground up*

**[I. Automated Tracking](./factors/01-automated-tracking.md)**<br/>
Persistent memory. No tribal knowledge.

**[II. Context Loading](./factors/02-context-loading.md)**<br/>
Load only what you need. Stay under 40%.

**[III. Focused Agents](./factors/03-focused-agents.md)**<br/>
One agent, one job. Compose specialists.

**[IV. Continuous Validation](./factors/04-continuous-validation.md)**<br/>
Check at every step. Catch errors early.

</td>
<td valign="top" width="33%">

### Operations (V-VIII)
*Scale and maintain in production*

**[V. Measure Everything](./factors/05-measure-everything.md)**<br/>
If you can't measure it, you can't improve it.

**[VI. Resume Work](./factors/06-resume-work.md)**<br/>
Save state. Pick up where you left off.

**[VII. Smart Routing](./factors/07-smart-routing.md)**<br/>
Send tasks to the right specialist.

**[VIII. Human Validation](./factors/08-human-validation.md)**<br/>
Humans approve critical steps.

</td>
<td valign="top" width="33%">

### Improvement (IX-XII)
*Continuous learning and adaptation*

**[IX. Mine Patterns](./factors/09-mine-patterns.md)**<br/>
Search history. Find what works.

**[X. Small Iterations](./factors/10-small-iterations.md)**<br/>
Improve continuously. Small tweaks compound.

**[XI. Fail-Safe Checks](./factors/11-fail-safe-checks.md)**<br/>
Prevent repeating mistakes. Add guardrails.

**[XII. Package Patterns](./factors/12-package-patterns.md)**<br/>
Bundle what works. Reuse it.

</td>
</tr>
</table>

<div align="center">

<br/>

![12-Factor AgentOps Landscape](./docs/assets/12-factor-landscape.svg)

<br/>

</div>

---

## Getting Started

<table>
<tr>
<td width="50%">

**Start with your pain point:**

| Problem | Solution |
|---------|----------|
| Context problems? | [Factor II: Context Loading](./factors/02-context-loading.md) |
| Reliability issues? | [Factor IV: Continuous Validation](./factors/04-continuous-validation.md) |
| No visibility? | [Factor V: Measure Everything](./factors/05-measure-everything.md) |

</td>
<td width="50%">

**Go deeper:**

- [The 12 Failure Patterns](./docs/reference/failure-patterns.md) — What can go wrong
- [Case Studies](./docs/case-studies/enterprise-validation.md) — Enterprise validation
- [Workflow Guide](./docs/tutorials/workflow-guide.md) — The full picture

</td>
</tr>
</table>

---

<details>
<summary><strong>Plugins</strong> — Claude Code marketplace implementing these factors</summary>

<br/>

**[agentops](https://github.com/boshu2/agentops)** — Production-ready plugins:

| Plugin | What It Does |
|--------|--------------|
| **constitution** | Nine Laws, 40% Rule, Git discipline |
| **core-workflow** | Research → Plan → Implement → Learn cycle |
| **session-management** | Context bundling, progress tracking |
| **vibe-coding** | 5 core metrics, 6 difficulty levels |
| **devops-operations** | Kubernetes, Helm, ArgoCD patterns |
| **software-development** | Python, JavaScript, Go with TDD |

</details>

---

## Credit

<div align="center">

[12-Factor App](https://12factor.net) (Adam Wiggins) • [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (Dex Horthy) • [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) (Gene Kim & Steve Yegge) • [Beads](https://github.com/steveyegge/beads) (Steve Yegge)

<br/>

**License:** CC BY-SA 4.0 (content) / Apache 2.0 (code)

</div>
