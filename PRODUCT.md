---
last_reviewed: 2026-02-15
---

# PRODUCT.md

## Mission

The operational discipline for working with AI agents — principles that turn ad-hoc agent usage into a reliable, compounding practice.

## Target Personas

### Persona 1: Solo Developer Using AI Agents
- **Goal:** Get consistently better results from their agent (Claude Code, Cursor, Codex) without starting from scratch every session
- **Pain point:** Inconsistent output quality, context window problems, no memory across sessions — every session feels like training a new junior developer

### Persona 2: Tech Lead Scaling Agent Workflows
- **Goal:** Coordinate agent-assisted development across a team with shared knowledge, validation gates, and multi-agent patterns
- **Pain point:** Parallel agent work creates cascading conflicts, learnings from one developer's sessions don't benefit others, no consistent quality bar

### Persona 3: Tool Builder / Agent Framework Author
- **Goal:** Design agent tooling grounded in proven operational principles rather than inventing patterns from scratch
- **Pain point:** No shared vocabulary or reference architecture for agent operations — every framework reinvents the wheel on context management, validation, and knowledge persistence

## Core Value Propositions

- **Knowledge compounds across sessions** — Every session makes the next one smarter. Not a wiki nobody reads — automatic extraction, quality gating, and injection.
- **Same model, dramatically better results** — Fix operations, not models. Context management alone can 3x output quality without changing anything else.
- **Individual-first, scales to teams** — Start with one dev + one agent. Same principles work when you scale to multi-agent orchestration.
- **Vendor-neutral principles** — Works with Claude Code, Cursor, Codex, Copilot, or custom setups. Not locked to any toolchain.

## Competitive Landscape

| Alternative | Strength | Our Differentiation |
|-------------|----------|---------------------|
| [GSD (Get Shit Done)](https://github.com/glittercowboy/get-shit-done) | Spec-driven development with fresh subagent contexts. Fights context rot through task decomposition and phase planning. | GSD is a build methodology (spec → plan → implement). We're the operational layer: context management, knowledge compounding, external validation, failure harvesting. GSD solves "how to structure one project." We solve "how to operate with agents as a practice." |
| [Superpowers](https://github.com/obra/superpowers) | Composable skills framework enforcing TDD, brainstorming, code review, and systematic debugging. Accepted into Claude plugins marketplace. | Superpowers is a development methodology (brainstorm → plan → TDD → review). We're the operational principles underneath. Superpowers enforces *how* to write code; we define *how to operate* — context budgets, knowledge flywheel, external validation, multi-agent scale patterns. Complementary, not competing. |
| [Agent OS](https://buildermethods.com/agent-os) | Captures and deploys coding standards across agentic development. Free and open source. | Agent OS focuses on coding standards (the rules). We focus on operational discipline (the practice). Standards are one input to Factor I (context loading); we cover the full lifecycle from research through knowledge compounding. |
| [Spec Kitty](https://github.com/Priivacy-ai/spec-kitty) | Spec-driven development with kanban dashboard, git worktrees, auto-merge, acceptance checks. Works across 10+ AI coding agents. | Spec Kitty is a project management layer (specs → tasks → kanban → merge). We're the operational philosophy. Spec Kitty manages *what* gets built; we define *how agents should operate* while building it — context discipline, validation patterns, knowledge extraction, failure harvesting. |

## Usage

This file enables product-aware council reviews:

- **`/pre-mortem`** — Automatically includes `product` perspectives (user-value, adoption-barriers, competitive-position) alongside plan-review judges when this file exists.
- **`/vibe`** — Automatically includes `developer-experience` perspectives (api-clarity, error-experience, discoverability) alongside code-review judges when this file exists.
- **`/council --preset=product`** — Run product review on demand.
- **`/council --preset=developer-experience`** — Run DX review on demand.

Explicit `--preset` overrides from the user skip auto-include (user intent takes precedence).
