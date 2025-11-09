# 12-Factor AgentOps - Framework Repository

**A methodology for using AI agents safely and reliably**

This repository documents the **philosophical framework** for safe AI agent adoption—patterns, principles, and research that enable anyone to use AI agents/LLMs with confidence.

---

## What Is This Repository?

**12-factor-agentops** is a **framework and methodology repository**, not an implementation:

- **What it IS:**
  - Philosophical foundations (Four Pillars, Five Laws)
  - The 12 operational factors for safe AI usage
  - Application of decades-proven methodologies to AI agents
  - Research grounding and empirical evidence
  - Evolution and positioning relative to 12-Factor App

- **What it is NOT:**
  - Implementation code or working tools
  - Step-by-step tutorials or how-to guides
  - A specific product or platform

**Think of it like:** The original [12-Factor App](https://12factor.net) for cloud-native applications—methodology, not code.

---

## Repository Purpose & Mission

**Mission:** Enable **anyone** to use AI agents safely and reliably—from solo developers to enterprise teams.

**Problem:** AI agents are powerful but unpredictable. How do we trust them?

**Solution:** Validation gates, governance patterns, and continuous learning systems that make AI usage reliable and improve over time.

**Target Audience:** Anyone using AI agents/LLMs—developers, researchers, writers, analysts, teams of any size.

---

## How This Relates to Other Work

This framework extends the proven [12-Factor App](https://12factor.net) methodology for the AI age:

**Three Complementary Frameworks:**
```
12-Factor App (2011)     → How to build cloud-native applications
12-Factor Agents (2025)  → How to build reliable AI applications (Dex Horthy)
12-Factor AgentOps (2025) → How to use AI agents safely (This Framework)
```

**Positioning:**
- Dex's [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) helps you **build** reliable AI applications
- Our 12-Factor AgentOps helps you **use AI safely** in any context
- Both are complementary, not competitive

**See:** [docs/foundations/evolution-of-12-factor.md](docs/foundations/evolution-of-12-factor.md) for complete evolution story

---

## Agent Interaction Standards (REQUIRED)

**ALL agents must follow consistent interaction patterns defined in:**
`../../.claude/AGENT_INTERACTION_STANDARDS.md`

**Key principles:**
- **Use `AskUserQuestion` for:** Structured choices, configuration, multi-step setup
- **Use freeform input for:** Creative requests, open-ended exploration, complex descriptions
- **Be consistent:** Same situation = same approach across all agents
- **Signal clearly:** Tell user what format you expect before gathering input

**Why this matters:** Inconsistent prompting creates confusion. Users should know what to expect based on the situation, not which agent is running.

**Enforcement:** Automatic through context loading - all agents inherit this standard.

**Full standard:** `../../.claude/AGENT_INTERACTION_STANDARDS.md` (2 min read)

---

## Repository Structure (Diátaxis Framework)

This repository follows the [Diátaxis framework](https://diataxis.fr/) for documentation organization:

```
12-factor-agentops/
├── README.md                          # Framework overview & getting started
├── CLAUDE.md                          # This file - Claude Code context
├── CONTRIBUTING.md                    # How to contribute patterns/research
├── GLOSSARY.md                        # 50+ key terms defined (Week 1) ✅
│
├── docs/                              # Documentation (Diátaxis structure)
│   ├── README.md                      # Documentation guide
│   ├── tutorials/                     # Learning-oriented ✅ COMPLETE (Week 2)
│   │   ├── first-30-minutes.md        # 30-minute quick-start (Week 1) ✅
│   │   ├── role-specific-paths.md     # 4 learning paths (Week 2) ✅
│   │   ├── decision-tree.md           # Factor selection guide (Week 2) ✅
│   │   ├── quick-reference-card.md    # One-page overview (Week 2) ✅
│   │   └── before-after-examples.md   # Visual impact demos (Week 3) ✅
│   ├── how-to/                        # Problem-oriented ✅ COMPLETE (Week 3)
│   │   ├── domain-guides/             # 4 domain guides (Week 3) ✅
│   │   │   ├── software-development.md
│   │   │   ├── devops-infrastructure.md
│   │   │   ├── data-science-analytics.md
│   │   │   └── solo-developer.md
│   │   └── implementation-guides/     # Step-by-step guides (Week 3) ✅
│   ├── reference/                     # Information-oriented
│   │   ├── factors/ → ../../factors   # Symlink to factors/
│   │   ├── patterns/ → ../../patterns # Symlink to patterns/
│   │   └── claude-code/               # Claude Code integration ✅ NEW
│   │       ├── README.md              # Overview & quick navigation
│   │       ├── command-hierarchy.md   # 3-level slash command architecture
│   │       ├── agents.md              # Agent system & organization
│   │       ├── skills.md              # Reusable skill components
│   │       ├── settings.md            # Configuration & hooks
│   │       └── archival-system.md     # Repository lifecycle management
│   ├── explanation/                   # Understanding-oriented
│   │   └── foundations/ → ../foundations  # Symlink to foundations/
│   ├── research/                      # Research and validation studies
│   │   └── CITATIONS.md               # Complete research index (Week 2) ✅
│   └── architecture/                  # System design documentation
│
├── foundations/                       # Philosophical foundations (WHY)
│   ├── README.md                      # Foundations overview
│   ├── four-pillars.md                # DevOps+SRE, Learning Science, Context Engineering, Knowledge OS
│   ├── five-laws.md                   # Mandatory operational principles
│   ├── context-engineering.md         # The 40% rule and cognitive load management
│   └── knowledge-os.md                # Git as institutional memory
│
├── factors/                           # The 12 Factors (WHAT)
│   ├── README.md                      # Complete factor list
│   ├── 01-git-memory-as-knowledge-os.md
│   ├── 02-jit-context-loading.md
│   ├── 03-single-responsibility-agents.md
│   └── ... (all 12 factors documented)
│
├── patterns/                          # Operational patterns (HOW)
│   ├── README.md                      # Pattern catalog
│   ├── phase-based-workflow.md        # Research → Plan → Implement
│   ├── multi-agent-orchestration.md   # Parallel execution patterns
│   ├── context-bundles.md             # Session continuity
│   └── intelligent-routing.md         # Task-to-agent matching
│
├── validation/                        # Validation status and evidence
│   ├── DISCLAIMER.md                  # What's validated vs in-progress
│   ├── README.md                      # Validation methodology
│   ├── SYNTHESIS.md                   # Aggregated findings (Week 3) ✅
│   ├── DATA_SCHEMA.md                 # Data collection format (Week 1) ✅
│   └── templates/                     # Validation templates (Week 1) ✅
│       ├── community-validation.md
│       └── quantitative-study.md
│
└── .agents/                           # AgentOps metadata
    └── bundles/
        └── week1-critical-infrastructure-2025-11-09.md
```

**Key Diátaxis locations:**
- **Tutorials** (learning): `docs/tutorials/` - ✅ COMPLETE (5 files, Week 1-3)
- **How-To** (goals): `docs/how-to/` - ✅ COMPLETE (6 files, Week 3)
- **Reference** (information): `docs/reference/` - Factors, patterns, citations
- **Explanation** (understanding): `docs/explanation/` - Foundations, theory

---

## The Five Laws (Follow These)

**ALL work in this repository follows these laws:**

### Law 1: ALWAYS Extract Learnings
Document patterns discovered, capture decision rationale, analyze failures for prevention.

**Why:** Patterns are valuable. One-time solutions are not.

### Law 2: ALWAYS Improve Self or System
Identify at least 1 improvement opportunity with impact and implementation path.

**Why:** Stagnation is regression. Continuous improvement is mandatory.

### Law 3: ALWAYS Document Context for Future
Include: Context (why needed), Solution (what was done), Learning (insights), Impact (value).

**Why:** Future contributors (or future you) will thank you.

### Law 4: ALWAYS Validate Before Execute
Preview changes, test in safe environments, validate before applying.

**Why:** Prevention is cheaper than recovery.

### Law 5: ALWAYS Share Patterns Publicly
Extract generalizable insights, document failures, help others avoid mistakes.

**Why:** Rising tide lifts all boats. Build collective knowledge.

**Full documentation:** [foundations/five-laws.md](foundations/five-laws.md)

---

## Common Tasks

### Working on Documentation

**Read existing docs first:**
```bash
# Understand the framework
cat README.md                           # Overview
cat docs/README.md                      # Diátaxis documentation guide
cat docs/explanation/foundations/README.md  # Philosophical foundation
cat docs/reference/factors/README.md    # The 12 factors

# Understand positioning
cat docs/explanation/foundations/evolution-of-12-factor.md
cat docs/explanation/foundations/comparison-table.md
```

**Before making changes:**
- Ensure you understand the Five Laws
- Read the section you're modifying in context
- Check cross-references (many docs link to each other)
- Maintain consistent voice (professional, evidence-based, not hype)

**Style guidelines:**
- Use markdown formatting (headers, lists, code blocks)
- Link to related content generously
- Include evidence/validation where claims are made
- Avoid emojis unless already established in the document
- Keep target audience broad (anyone using AI agents)

### Adding New Content

**To add a new pattern:**
1. Read [CONTRIBUTING.md](CONTRIBUTING.md) for process
2. Study existing patterns in `patterns/` for format
3. Ensure pattern follows the Five Laws
4. Include empirical evidence if available
5. Open issue for discussion before PR

**To add research/validation:**
1. Document hypothesis, method, results, implications
2. Link to relevant patterns/foundations
3. Include quantified results where possible
4. Be transparent about limitations

**To update foundations:**
- Foundations are stable but can evolve with evidence
- Major changes require strong empirical backing
- Open issue for discussion first
- Expect rigorous review

### Understanding the Framework

**Quick start (for newcomers):**

1. **Start:** [README.md](README.md) - Framework overview (5 min)
2. **Evolution:** [docs/explanation/foundations/evolution-of-12-factor.md](docs/explanation/foundations/evolution-of-12-factor.md) - How we got here (12 min)
3. **Philosophy:** [foundations/four-pillars.md](foundations/four-pillars.md) - Philosophical basis (15 min)
4. **Laws:** [foundations/five-laws.md](foundations/five-laws.md) - Operational principles (20 min)
5. **Factors:** [factors/README.md](factors/README.md) - The complete methodology (10 min)

**Total:** ~60 minutes to understand the complete framework

**For deeper understanding (Explanation docs):**
- [foundations/context-engineering.md](foundations/context-engineering.md) - The 40% rule (15 min)
- [foundations/knowledge-os.md](foundations/knowledge-os.md) - Git as memory (15 min)
- [docs/research/](docs/research/) - Academic foundations

**For practical reference:**
- [factors/](factors/) - All 12 factors
- [patterns/](patterns/) - Operational patterns

**For complete navigation:**
- [docs/README.md](docs/README.md) - Diátaxis documentation guide

---

## What Makes This Framework Different

**From other AI/LLM frameworks:**
- Universal (works for anyone using AI, not just engineers)
- Built on proven foundations (20+ years of DevOps, GitOps, Zero-Trust practices)
- Principle-driven (understand WHY, not just HOW)
- Continuously improving (patterns evolve with community validation)
- Early results are promising, community validation ongoing

**From 12-Factor Agents (Dex Horthy):**
- Different layer: Dex = build AI apps, we = use AI safely
- Different audience: Dex = AI engineers, we = anyone using AI
- Complementary value: Both needed for successful AI adoption

**From original 12-Factor App:**
- AI-specific: Addresses probabilistic outputs, autonomous decisions
- Governance-focused: Validation gates, guardrails, pattern learning
- Broader scope: Not just apps, but any AI agent usage

---

## Contributing

**We welcome contributions of:**
- ✅ Production-validated patterns
- ✅ Empirical research and case studies
- ✅ Documentation improvements
- ✅ Failure analyses (what didn't work)
- ✅ Domain-specific adaptations

**We don't accept:**
- ❌ Theoretical patterns without validation
- ❌ Marketing/promotional content
- ❌ Implementation code (this is a methodology repo)
- ❌ Opinions without evidence

**Process:**
1. Read [CONTRIBUTING.md](CONTRIBUTING.md) fully
2. Open an issue to discuss your contribution
3. Get feedback on approach/scope
4. Submit PR following established patterns
5. Address review feedback
6. Pattern merges when validated

**Community standards:**
- Be respectful and collaborative
- Share failures as openly as successes
- Focus on production learnings, validated patterns
- Follow the Five Laws in all contributions
- Help make operational patterns accessible to all

---

## Validation Status

**Current status:** Alpha validation in progress

**Initial applications showing promising results:**
- ✅ Factors I-III (Foundation tier) - Applied in production environments
- ✅ Context Engineering (40% rule) - 8x efficiency improvement, 0% collapse rate observed
- ✅ Knowledge OS patterns - Production use since Claude 2.0
- ✅ Five Laws compliance - 95% success rate observed

**Community validation in progress:**
- ⏳ Factors IV-XII validation across diverse domains
- ⏳ Cross-domain generalization testing
- ⏳ Community testing and refinement to discover universal patterns

**See:** [validation/DISCLAIMER.md](validation/DISCLAIMER.md) for complete status

---

## References & Links

**Foundation work this builds on:**
- [12-Factor App](https://12factor.net) - Adam Wiggins, Heroku (2011)
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) - Dex Horthy, HumanLayer (2025)
- [DevOps Handbook](https://itrevolution.com/product/the-devops-handbook-second-edition/) - Gene Kim et al.
- [Site Reliability Engineering](https://sre.google/books/) - Google SRE

**Research backing:**
- Miller (1956) - "The Magical Number Seven, Plus or Minus Two"
- Cowan (2001) - "Working Memory Capacity"
- Sweller (1988) - "Cognitive Load Theory"
- Liu et al. (2023) - "Lost in the Middle: How Language Models Use Long Contexts"

**Related projects:**
- [Anthropic: Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents)
- [agent-os](https://github.com/agent-os) - Spec-driven agentic development

---

## Claude Code Integration

**NEW:** This framework includes comprehensive documentation of the `.claude/` directory system used in production implementations.

### What is `.claude/`?

The `.claude/` directory provides a **3-level hierarchy** for organizing AI agent workflows, slash commands, skills, and configuration:

```
Level 1: Workspace (universal)
    ↓ inherited
Level 2: Container (work/, personal/)
    ↓ inherited
Level 3: Repository (domain-specific)
```

### Documentation Structure

**Location:** [docs/reference/claude-code/](docs/reference/claude-code/)

| Topic | File | Purpose |
|-------|------|---------|
| **Overview** | [README.md](docs/reference/claude-code/README.md) | Quick navigation & integration with factors |
| **Commands** | [command-hierarchy.md](docs/reference/claude-code/command-hierarchy.md) | 3-level slash command architecture (60+ commands) |
| **Agents** | [agents.md](docs/reference/claude-code/agents.md) | Agent system & organization (34+ workspace agents) |
| **Skills** | [skills.md](docs/reference/claude-code/skills.md) | Reusable skill components |
| **Settings** | [settings.md](docs/reference/claude-code/settings.md) | Configuration, hooks, permissions |
| **Archival** | [archival-system.md](docs/reference/claude-code/archival-system.md) | Repository lifecycle management |

### Key Features

**Command Hierarchy:**
- 26+ workspace commands (universal)
- Domain-specific extensions per repository
- Clear precedence rules (Repository > Container > Workspace)
- Extension pattern (not override)

**Agent System:**
- 34+ workspace agents
- Script-based (deterministic) and AI-powered (adaptive)
- Single-responsibility principle (Factor III)
- JIT loading to stay under 40% context (Factor II)

**Integration with Factors:**
- **Factor II:** JIT Context Loading via 3-level hierarchy
- **Factor III:** Single-Responsibility Agents
- **Factor IV:** Validation Gates via hooks
- **Factor VI:** Session Continuity via bundles
- **Factor IX:** Pattern Extraction via archival system

### Quick Start

```bash
# Explore command system
cat docs/reference/claude-code/command-hierarchy.md

# Understand agents
cat docs/reference/claude-code/agents.md

# Learn about hooks
cat docs/reference/claude-code/settings.md
```

**See:** [docs/reference/claude-code/README.md](docs/reference/claude-code/README.md) for complete documentation

---

## Quick Commands

```bash
# Read the framework
cat README.md                           # Start here
cat docs/README.md                      # Diátaxis guide
cat docs/explanation/foundations/evolution-of-12-factor.md

# Browse content (Diátaxis structure)
ls -la docs/explanation/foundations/    # Philosophy (WHY)
ls -la docs/reference/factors/          # Factors reference (WHAT)
ls -la docs/reference/patterns/         # Patterns reference (HOW)
ls -la docs/tutorials/                  # Tutorials (coming soon)
ls -la docs/how-to/                     # How-to guides (coming soon)

# Browse legacy structure (still available)
ls -la foundations/                     # Direct access
ls -la factors/                         # Direct access
ls -la patterns/                        # Direct access

# Validate changes (if makefile exists)
make validate-all                       # Run all validations
make validate-docs                      # Check documentation links
```

---

## Questions or Issues?

- **Have a pattern to share?** Open an issue with the pattern template
- **Found documentation bugs?** Submit a PR or open an issue
- **Want to validate a pattern?** Comment on existing patterns
- **Challenge an assumption?** Open an issue with your reasoning and evidence

**All feedback welcome.** Framework improves through community validation.

---

## Version & Status

**Version:** v1.0.4 Beta (Community Validation)
**Last Updated:** 2025-11-09
**Status:** Public launch ready - seeking community validation across diverse domains

**Foundational base:**
- Built on decades of proven DevOps, GitOps, and Zero-Trust practices
- Initial applications in production environments (solo dev to DoD infrastructure)
- Production use since Claude 2.0 informing pattern development
- Community validation across diverse domains now in progress

**Completion Status:**
- ✅ Week 1 (Critical Infrastructure): Templates, schema, glossary, quick-start, version alignment
- ✅ Week 2 (High-Priority Enhancements): Role paths, decision tree, quick reference, citations
- ✅ Week 3 (Usability Improvements): Domain guides, implementation guides, validation synthesis, examples
- ⏳ Week 4 (Public Launch Prep): Final polish, beta testing, launch content

**Adoption Potential:**
- Week 1: 20% → 60% (3x improvement)
- Week 2-3: 60% → 90% (1.5x improvement)
- Target: 100% at public launch

**Next milestones:**
- Week 4 completion (15-20 hours): Link validation, beta testing, launch announcement
- Public launch (Q1 2025)
- Community validation across 5+ domains

---

**Welcome to 12-Factor AgentOps.**

This framework represents a philosophy: AI agents should be as reliable as the infrastructure they run on. Not through magic, but through rigorous operational discipline.

**Read. Validate. Contribute. Improve.**

Let's make AI agents safe and trustworthy for everyone.
