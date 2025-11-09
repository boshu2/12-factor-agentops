# 12-Factor AgentOps Documentation

Welcome to the documentation for **12-Factor AgentOps** — a methodology for using AI agents safely and reliably.

This repository defines the **WHY** behind patterns that make AI/human collaboration with agents productive, observable, and recursive.

## 📚 Documentation Structure (Diátaxis Framework)

This documentation follows the [Diátaxis framework](https://diataxis.fr/), organizing content into four types based on reader needs:

```
          Practical          |          Theoretical
    -------------------------|-------------------------
    TUTORIALS (learning)     | EXPLANATION (understanding)
    Step-by-step lessons     | Clarification & discussion
    -------------------------|-------------------------
    HOW-TO GUIDES (goals)    | REFERENCE (information)
    Problem-solving recipes  | Technical descriptions
```

### 📖 Tutorials (Learning-Oriented)

**Purpose**: Guide beginners through their first experience

**Start here if**: You're new to 12-Factor AgentOps and want hands-on learning

**Location**: `tutorials/`

**Available now:**
- [First 30 Minutes](tutorials/first-30-minutes.md) - Complete framework introduction in 30 minutes
- [Role-Specific Learning Paths](tutorials/role-specific-paths.md) - Choose your path: Researcher, Practitioner, Contributor, or Solo Developer
- [Decision Tree](tutorials/decision-tree.md) - "Which factor applies to my problem?"
- [Quick Reference Card](tutorials/quick-reference-card.md) - One-page overview of all 12 factors

### 🛠️ How-To Guides (Problem-Oriented)

**Purpose**: Solve specific practical problems

**Start here if**: You have a specific goal and need practical steps

**Location**: `how-to/` (coming soon)

**Planned content:**
- How to Extract a Pattern from Production
- How to Validate Factor Compliance
- How to Set Up Validation Gates
- How to Create a Context Bundle

### 📚 Reference (Information-Oriented)

**Purpose**: Provide authoritative, accurate information for lookup

**Start here if**: You need to look up specific information

**Location**: `reference/`

**Available now:**
- [Factors](reference/factors/) - The 12 Factors (complete reference)
  - [Factor I: Git Memory as Knowledge OS](reference/factors/01-git-memory-as-knowledge-os.md)
  - [Factor II: JIT Context Loading](reference/factors/02-jit-context-loading.md)
  - [Factor III: Single-Responsibility Agents](reference/factors/03-single-responsibility-agents.md)
  - [Factor IV: Validation Gates](reference/factors/04-validation-gates-before-execution.md)
  - [Factor V: Operational Telemetry](reference/factors/05-operational-telemetry.md)
  - [Factor VI: Session Continuity](reference/factors/06-session-continuity-via-bundles.md)
  - [Factor VII: Intelligent Task Routing](reference/factors/07-intelligent-task-routing.md)
  - [Factor VIII: Human Gate Reviews](reference/factors/08-human-gate-reviews.md)
  - [Factor IX: Pattern Extraction](reference/factors/09-documented-pattern-extraction.md)
  - [Factor X: Continuous Improvement](reference/factors/10-continuous-improvement-backlog.md)
  - [Factor XI: Constitutional Guardrails](reference/factors/11-constitutional-guardrails.md)
  - [Factor XII: Domain Portability](reference/factors/12-domain-portability.md)
- [Patterns](reference/patterns/) - Operational patterns catalog
  - [Context Bundles](reference/patterns/context-bundles.md)
  - [Multi-Agent Orchestration](reference/patterns/multi-agent-orchestration.md)
  - [Phase-Based Workflow](reference/patterns/phase-based-workflow.md)
  - [Intelligent Routing](reference/patterns/intelligent-routing.md)

### 💡 Explanation (Understanding-Oriented)

**Purpose**: Deepen understanding of concepts and theory

**Start here if**: You want to understand "why" and theoretical foundations

**Location**: `explanation/`

**Available now:**
- [Foundations](explanation/foundations/) - Philosophical foundations
  - [Five Laws](explanation/foundations/five-laws.md) - Mandatory operational principles
  - [Four Pillars](explanation/foundations/four-pillars.md) - Architectural foundations
  - [Evolution of 12-Factor](explanation/foundations/evolution-of-12-factor.md) - How this extends the original
  - [Comparison Table](explanation/foundations/comparison-table.md) - Original → Agents → AgentOps mapping
  - [Knowledge OS](explanation/foundations/knowledge-os.md) - Git as institutional memory
  - [Context Engineering](explanation/foundations/context-engineering.md) - The 40% rule

**Additional explanation docs:**
- [Research](research/) - Academic backing and validation studies
  - [Research Citations](research/CITATIONS.md) - Complete index of research foundations
  - [12-Factors Research](research/12-factors-research.md) - Factor definition research
- [Architecture](architecture/) - System design and architectural decisions

## 🧭 Quick Navigation by Need

### "I'm brand new to 12-Factor AgentOps"

**Start here:**
1. [README.md](../README.md) - Framework overview (5 min)
2. [First 30 Minutes](tutorials/first-30-minutes.md) - Complete introduction (30 min)
3. [Role-Specific Paths](tutorials/role-specific-paths.md) - Choose your learning path
4. [Quick Reference Card](tutorials/quick-reference-card.md) - Keep handy while working

### "I want to understand the philosophy"

**Read explanation docs:**
1. [Four Pillars](explanation/foundations/four-pillars.md) - Philosophical basis
2. [Context Engineering](explanation/foundations/context-engineering.md) - The 40% rule
3. [Knowledge OS](explanation/foundations/knowledge-os.md) - Git as memory
4. [Research](research/) - Academic foundations

### "I need to look something up"

**Use reference docs:**
- [Factors Reference](reference/factors/README.md) - All 12 factors
- [Patterns Catalog](reference/patterns/README.md) - Operational patterns
- Individual factor docs for specific information

### "I have a specific problem to solve"

**Start here:**
1. [Decision Tree](tutorials/decision-tree.md) - "Which factor applies to my problem?"
2. [Quick Reference Card](tutorials/quick-reference-card.md) - Problem → Factor mapping
3. Browse [patterns](reference/patterns/) for implementation details
4. **Coming soon**: How-to guides for specific tasks

## 📖 Reading Paths

### Path 1: Quick Start (30 min)
1. [README.md](../README.md) - Overview
2. [Five Laws](explanation/foundations/five-laws.md) - Principles
3. [Factors README](reference/factors/README.md) - Quick factor list
4. Pick 1-2 factors to read in detail

### Path 2: Deep Dive (2-3 hours)
1. [Evolution of 12-Factor](explanation/foundations/evolution-of-12-factor.md) - Context
2. [Four Pillars](explanation/foundations/four-pillars.md) - Philosophy
3. [Five Laws](explanation/foundations/five-laws.md) - Governance
4. Read all 12 factors in [reference/factors/](reference/factors/)
5. Study [patterns](reference/patterns/)

### Path 3: Academic Research
1. [Research Documentation](research/) - Academic foundations
2. [Validation Studies](../validation/) - Empirical results
3. [Architecture Review](architecture/) - System design
4. [Comparison Table](explanation/foundations/comparison-table.md) - Detailed mapping

## 🤝 Contributing

**Want to help improve this documentation?**

See [CONTRIBUTING.md](../CONTRIBUTING.md) for:
- How to contribute patterns
- Documentation standards
- Validation process
- Community guidelines

## 📦 Additional Resources

### Project Information
- [README.md](../README.md) - Project overview
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guide
- [CODE_OF_CONDUCT.md](../CODE_OF_CONDUCT.md) - Community standards
- [SECURITY.md](../SECURITY.md) - Security policy
- [CHANGELOG.md](../CHANGELOG.md) - Version history

### For AI Assistants
- [CLAUDE.md](../CLAUDE.md) - Claude Code context and guidelines

### Related Repositories

This framework is complemented by:

| Repository | Purpose |
|------------|---------|
| **12-factor-agentops** (this repo) | Framework methodology and theory |
| agentops | Reference implementation (in preparation) |
| agentops-showcase | Examples and case studies (in preparation) |

## 🔗 External Resources

- [Diátaxis Framework](https://diataxis.fr/) - Documentation methodology
- [12-Factor App](https://12factor.net/) - Original inspiration
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) - Complementary framework
- [DevOps Research](https://dora.dev/) - Research foundation

## 📄 Version & License

**Version**: See [VERSION](../VERSION)
**License**: CC BY-SA 4.0
**Status**: Alpha validation in progress

See [validation/DISCLAIMER.md](../validation/DISCLAIMER.md) for validation status.

---

**12-Factor AgentOps** | A methodology for using AI agents safely and reliably
Built on decades of proven DevOps, GitOps, and Zero-Trust practices
