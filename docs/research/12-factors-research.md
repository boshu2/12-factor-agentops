# Research: Defining the 12 Factors of AgentOps

**Created:** 2025-01-27
**Researchers:** GPT-5 Codex (assistant)
**Status:** Draft complete (ready for review)

---

## Problem Statement

The 12-Factor AgentOps framework references "The Twelve Factors" as the operational principles for AI agent orchestration, but the definitive list is still missing. Multiple documents (README, roadmap, foundations) mention the factors, yet only six candidates are outlined. We need a synthesized, evidence-backed proposal for all twelve factors that:

- Aligns with the Four Pillars (DevOps+SRE, Learning Science, Context Engineering, Knowledge OS)
- Enforces the Five Laws and JIT Context Loading principles
- Maps cleanly to proven AgentOps patterns (phase workflow, multi-agent orchestration, context bundles, intelligent routing)
- Resonates with the spirit of the original 12-Factor App methodology (portability, repeatability, operational discipline)

**Goal:** Produce a candidate set of twelve factors, with rationale and relationships to existing foundations, so that `content/factors/` can be authored with confidence.

---

## Research Questions

1. Which operational behaviors are already enforced by AgentOps (via patterns, laws, or tooling)?
2. How do current documents describe in-progress or planned factors (e.g., roadmap Factor I–VI)?
3. What analogies can we borrow from 12-Factor App and 12-Factor Agents to ensure conceptual symmetry?
4. Where are the gaps—i.e., important operational practices that are not yet captured by the first six factors?

---

## Sources Reviewed

- `README.md` (current public overview)
- `README.md.backup` (historical context)
- `product/strategy/roadmap.md` (first six factors, milestones)
- `foundations/*` (Four Pillars, Five Laws, Context Engineering, Knowledge OS)
- `patterns/*` (phase-based workflow, multi-agent orchestration, context bundles, intelligent routing)
- `ECOSYSTEM_POSITIONING.md` (layered architecture)
- `agentops` repository (CONSTITUTION, core commands/workflows) for pattern evidence
- External references: 12-factor.net, HumanLayer’s 12-Factor Agents (for analogs)

---

## Key Findings

1. **First six factors are partially defined** in `product/strategy/roadmap.md` but lack published deep-dives. They focus on Git memory, context limits, specialization, validation, observability, and session continuity.
2. **The Four Pillars imply complementary practices** that are currently undocumented as factors (e.g., learning science suggests progressive disclosure and pattern extraction; Knowledge OS demands institutional memory and portability).
3. **Five Laws add mandatory behaviors** (extract learnings, improve system, document context, prevent hook loops, guide with suggestions) that should surface explicitly in the factors list rather than being hidden prerequisites.
4. **AgentOps implementation already enforces more than six behaviors** via commands (`/prime`, `/research`, `/plan`, `/implement`, `/learn`), workflows (phase gates, human review), and tooling (bundles, routing, validation). These can be elevated into factor definitions.
5. **12-Factor App analogies highlight expectations** such as single codebase, config parity, stateless processes, dev/prod parity, logs, admin processes. Translating these to agent operations helps frame new factors around reproducibility, human-in-loop checkpoints, and portability.

---

## Candidate Factor Set (Draft)

| # | Proposed Factor | Focus | Pillar Alignment | Existing Evidence | 12-Factor App Analogy |
|---|-----------------|-------|------------------|-------------------|------------------------|
| I | **Git Memory as Knowledge OS** | Single canonical history for agent work; commits capture intent, context, learnings | Knowledge OS | Law 3, `agentops` CONSTITUTION, bundle metadata | *Codebase*, *Config* (single source of truth) |
| II | **JIT Context Loading** | Main agent orchestrates; sub-agents execute with isolated context windows loaded JIT | Context Engineering | `foundations/context-engineering.md`, sub-agent delegation pattern | *Processes*, *Dev/Prod parity* (stateless runs) |
| III | **Single-Responsibility Agents** | Compose workflows from focused agents and skills; avoid monolith prompts | Learning Science | Multi-agent orchestration pattern, `/research-multi` | *Processes* (stateless process types) |
| IV | **Validation Gates Before Execution** | Formal checkpoints (plan review, tests, git hooks) prior to change application | DevOps + SRE | `/plan`, `/implement`, validation commands, Law 4 | *Build, Release, Run* (build pipeline discipline) |
| V | **Operational Telemetry (Observe Everything)** | Metrics, logs, observability bundles for agent runs | DevOps + SRE | Observability pillar, roadmap Factor V | *Logs*, *Admin processes* |
| VI | **Session Continuity via Bundles** | Persist and restore context using bundle artifacts; enable multi-day work | Context Engineering + Knowledge OS | Context bundles pattern, `/bundle-save` `/bundle-load` | *Disposability*, *Backing services* |
| VII | **Intelligent Task Routing** | Route work to best-fit workflows/agents; maintain routing accuracy benchmarks | Learning Science + DevOps | `/prime`, intelligent routing pattern (90.9% accuracy) | *Config*, *Concurrency* (proper assignment) |
| VIII | **Human Gate Reviews** | Embed human approvals between research → plan → implement; enforce accountability | Learning Science | Phase-based workflow diagram, README gating notes | *Admin processes* (run one-off checks) |
| IX | **Documented Pattern Extraction** | Capture learnings after every session; publish reusable patterns | Knowledge OS + Learning Science | Law 1, `/learn`, pattern library structure | *Logs* (as event stream) |
| X | **Continuous Improvement Backlog** | Each session identifies system/agent improvements; prioritize and action | DevOps + Knowledge OS | Law 2, roadmap quality gates | *Dev/Prod parity* (consistent improvement) |
| XI | **Constitutional Guardrails** | Enforce Five Laws, JIT context loading, hook protections; prevent risky behavior | DevOps + SRE | agentops CONSTITUTION, pre-commit/push hooks | *Config*, *Build* (environment discipline) |
| XII | **Domain Portability via Profiles & Bundles** | Package domain knowledge into profiles/workflow bundles for reuse and distribution | Knowledge OS + DevOps | agentops profiles system, roadmap (workflow packages) | *Backing services*, *Port binding* (treat each profile as attached resource) |

### Notes on the Candidate Set

- Factors I–VI align with the roadmap list (Git memory, context engineering, specialization, validation, observability, session continuity).
- Factors VII–XII elevate behaviors already practiced but undocumented: routing, human gates, pattern extraction, continuous improvement, constitutional guardrails, and domain portability.
- Each factor ties back to a pillar and at least one law/pattern, ensuring doctrinal consistency.
- Analogies to 12-Factor App help communicate intent to practitioners familiar with the original methodology.

---

## Constraints & Risks

- **Naming refinement required:** Some factor names may evolve once deep-dive docs are drafted (e.g., “Human Gate Reviews” vs. “Human-in-the-Loop Checkpoints”).
- **Evidence depth varies:** Factors VII–XII rely more on operational practice than formal documentation; case studies will be needed to strengthen credibility.
- **Audience perception:** Need to clearly differentiate factors from pillars/laws to avoid conceptual overlap.
- **Scope creep:** Keep factors focused on operational behaviors, not implementation details (e.g., avoid referencing a specific tool like MCP directly).

---

## Recommendation

Adopt the draft candidate set as the working definition for the Twelve Factors. Next steps:

1. **Validation:** Review the set with stakeholders (author, beta collaborators) to confirm alignment with lived experience.
2. **Deep-Dive Drafting:** Create `content/factors/<number>-<name>.md` entries using the proposed names and structure.
3. **Cross-References:** Update README, roadmap, and agentops docs to reference the finalized factor names.
4. **Evidence Gathering:** For each factor, collect case studies, metrics, and anti-patterns to strengthen documentation.

Once consensus is reached, publish the factor list in README and begin authoring detailed guides.

---

## Next Steps

1. ✅ Record research (this document)
2. 🔄 Circulate for review (author, collaborators)
3. 🔜 Finalize factor names & ordering
4. 🔜 Create `content/factors/` directory and author Factor I–III as pilot
5. 🔜 Update README and roadmap to reference final list

---

## References

- `product/strategy/roadmap.md` (Factor I–VI draft)
- `foundations/four-pillars.md`, `foundations/context-engineering.md`, `foundations/knowledge-os.md`
- `patterns/context-bundles.md`, `patterns/multi-agent-orchestration.md`, `patterns/intelligent-routing.md`
- agentops repository: `CONSTITUTION.md`, `core/workflows/complete-cycle.md`
- External: [12-Factor App](https://12factor.net), [12-Factor Agents](https://github.com/humanlayer/12-factor-agents)
