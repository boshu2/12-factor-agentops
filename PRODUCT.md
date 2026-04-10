---
last_reviewed: 2026-02-15
---

# PRODUCT.md

## Mission

The doctrine behind the operational layer for coding agents — principles that
turn ad-hoc agent usage into bookkeeping, validation, primitives, and flows
that compound.

## Target Personas

### Persona 1: Solo Developer Using AI Agents
- **Goal:** Get consistently better results from their agent (Claude Code, Cursor, Codex) without starting from scratch every session
- **Pain point:** Inconsistent output quality, context window problems, no bookkeeping across sessions — every session feels like training a new junior developer

### Persona 2: Tech Lead Scaling Agent Flows
- **Goal:** Coordinate agent-assisted development across a team with shared bookkeeping, validation gates, and multi-agent patterns
- **Pain point:** Parallel agent work creates cascading conflicts, learnings from one developer's sessions don't benefit others, no consistent quality bar

### Persona 3: Tool Builder / Agent Framework Author
- **Goal:** Design agent tooling grounded in proven operational principles rather than inventing patterns from scratch
- **Pain point:** No shared vocabulary or reference architecture for agent operations — every framework reinvents the wheel on context management, validation, and bookkeeping persistence

## Core Value Propositions

- **Bookkeeping compounds across sessions** — Every session makes the next one smarter. Not a wiki nobody reads — extracted learnings become reusable context.
- **Validation becomes an operating rule** — The doctrine makes separate review, ratcheting, and evidence-backed closeout part of the normal flow.
- **Primitives and flows scale from one developer to many** — Start with one dev + one agent. The same principles extend to multi-agent orchestration.
- **Vendor-neutral doctrine** — Works with Claude Code, Cursor, Codex, Copilot, or custom setups. Not locked to any toolchain.

## Competitive Landscape

| Alternative | Strength | Our Differentiation |
|-------------|----------|---------------------|
| [GSD (Get Shit Done)](https://github.com/glittercowboy/get-shit-done) | Spec-driven development with fresh subagent contexts. Fights context rot through task decomposition and phase planning. | GSD is a build methodology (spec → plan → implement). We are the doctrine behind the operational layer: bookkeeping, validation, compounding flows, failure harvesting. GSD solves "how to structure one project." We solve "how to operate with agents as a practice." |
| [Superpowers](https://github.com/obra/superpowers) | Composable skills framework enforcing TDD, brainstorming, code review, and systematic debugging. Accepted into Claude plugins marketplace. | Superpowers is a development methodology (brainstorm → plan → TDD → review). We define the doctrine underneath: context budgets, validation patterns, bookkeeping flywheel, and multi-agent scale patterns. Complementary, not competing. |
| [Agent OS](https://buildermethods.com/agent-os) | Captures and deploys coding standards across agentic development. Free and open source. | Agent OS focuses on coding standards (the rules). We focus on the operational doctrine (the practice). Standards are one input to Factor I; we cover the full lifecycle from research through bookkeeping compounding. |
| [Spec Kitty](https://github.com/Priivacy-ai/spec-kitty) | Spec-driven development with kanban dashboard, git worktrees, auto-merge, acceptance checks. Works across 10+ AI coding agents. | Spec Kitty is a project management layer (specs → tasks → kanban → merge). We define how agents should operate while building it — context discipline, validation patterns, bookkeeping extraction, and failure harvesting. |

## Usage

This file enables product-aware council reviews:

- **`/pre-mortem`** — Automatically includes `product` perspectives (user-value, adoption-barriers, competitive-position) alongside plan-review judges when this file exists.
- **`/vibe`** — Automatically includes `developer-experience` perspectives (api-clarity, error-experience, discoverability) alongside code-review judges when this file exists.
- **`/council --preset=product`** — Run product review on demand.
- **`/council --preset=developer-experience`** — Run DX review on demand.

Explicit `--preset` overrides from the user skip auto-include (user intent takes precedence).
