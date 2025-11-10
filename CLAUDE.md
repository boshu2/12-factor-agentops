# 12-Factor AgentOps - Framework Repository

**A methodology for using AI agents safely and reliably**

This repository documents the **operational framework** for safe AI agent adoption—the 12 factors that enable anyone to use AI agents/LLMs with confidence.

---

## What Is This Repository?

**12-factor-agentops** is a **methodology repository** (like the original 12-Factor App):

- **What it IS:**
  - The 12 operational factors for safe AI usage
  - Practical workflow guidance (Research → Plan → Implement)
  - Application of proven methodologies (DevOps, GitOps, Zero-Trust, SRE)
  - Research grounding and community validation

- **What it is NOT:**
  - Implementation code or working tools
  - A specific product or platform

**Think of it like:** The original [12-Factor App](https://12factor.net)—methodology, not code.

---

## Repository Structure (SIMPLIFIED)

**Core methodology (start here):**
```
12-factor-agentops/
├── README.md          # What this is, why it matters, the 12 factors (10 min)
├── FACTORS.md         # Detailed factor explanations (30 min)
├── WORKFLOW.md        # How to apply the methodology (20 min)
├── CONTRIBUTING.md    # How to contribute
├── GLOSSARY.md        # Key terms defined
│
├── factors/           # Individual factor documentation
│   ├── 01-git-memory-as-knowledge-os.md
│   ├── 02-jit-context-loading.md
│   └── ... (all 12 factors)
│
├── examples/          # Practical implementations
│   └── STARTER-PACK/  # Complete reference implementation
│
└── marketplace/       # Optional deep dives
    ├── README.md      # Marketplace navigation
    ├── principles/    # Four Pillars, Five Laws, philosophy
    ├── domain-guides/ # DevOps, SRE, solo dev, etc.
    ├── research/      # Citations, validation, empirical data
    ├── advanced/      # Multi-agent orchestration, context bundles
    └── case-studies/  # Production examples and metrics
```

**Navigation:**
- **"I'm new"** → README.md (10 min)
- **"I want details"** → FACTORS.md (30 min)
- **"I want to use this"** → WORKFLOW.md (20 min)
- **"I want examples"** → examples/STARTER-PACK
- **"I want depth"** → marketplace/

---

## Agent Interaction Standards (REQUIRED)

**ALL agents must follow consistent interaction patterns defined in:**
`../../.claude/AGENT_INTERACTION_STANDARDS.md`

**Key principles:**
- **Use `AskUserQuestion` for:** Structured choices, configuration, multi-step setup
- **Use freeform input for:** Creative requests, open-ended exploration, complex descriptions
- **Be consistent:** Same situation = same approach across all agents
- **Signal clearly:** Tell user what format you expect before gathering input

**Full standard:** `../../.claude/AGENT_INTERACTION_STANDARDS.md` (2 min read)

---

## Common Tasks

### Working on Documentation

**Read the core first:**
```bash
cat README.md         # Framework overview (10 min)
cat FACTORS.md        # The 12 factors (30 min)
cat WORKFLOW.md       # How to apply (20 min)
```

**Explore deep content:**
```bash
ls -la marketplace/principles/    # Philosophy
ls -la marketplace/domain-guides/ # Practical guides
ls -la marketplace/research/      # Research backing
```

**Before making changes:**
- Understand the Five Laws (marketplace/principles/five-laws.md)
- Read the section you're modifying
- Check cross-references
- Maintain consistent voice

### Understanding the Framework

**Quick start (1 hour):**
1. [README.md](README.md) - Framework overview (10 min)
2. [FACTORS.md](FACTORS.md) - The 12 factors (30 min)
3. [WORKFLOW.md](WORKFLOW.md) - How to apply (20 min)

**Deep understanding (optional):**
4. [marketplace/principles/four-pillars.md](marketplace/principles/four-pillars.md) - Philosophy (15 min)
5. [marketplace/principles/five-laws.md](marketplace/principles/five-laws.md) - Operational principles (20 min)
6. [marketplace/research/](marketplace/research/) - Research backing

---

## What Makes This Framework Different

**From other AI/LLM frameworks:**
- Universal (works for anyone using AI)
- Built on proven foundations (20+ years of DevOps, GitOps, Zero-Trust)
- Principle-driven (understand WHY, not just HOW)
- Community-validated (seeking diverse domain validation)

**From 12-Factor Agents (Dex Horthy):**
- Different layer: Dex = build AI apps, we = use AI safely
- Different audience: Dex = AI engineers, we = anyone using AI
- Complementary value: Both needed for AI success

**From original 12-Factor App:**
- AI-specific: Addresses probabilistic outputs, autonomous decisions
- Governance-focused: Validation gates, guardrails, pattern learning
- Broader scope: Not just apps, any AI agent usage

---

## Contributing

**We welcome:**
- Production-validated patterns
- Empirical research and case studies
- Documentation improvements
- Domain-specific adaptations

**Process:**
1. Read [CONTRIBUTING.md](CONTRIBUTING.md)
2. Open issue to discuss
3. Get feedback
4. Submit PR
5. Community review

---

## Quick Commands

```bash
# Read the framework
cat README.md          # Start here
cat FACTORS.md         # Detailed factors
cat WORKFLOW.md        # Practical application

# Browse content
ls -la marketplace/principles/    # Philosophy
ls -la marketplace/domain-guides/ # Domain guides
ls -la marketplace/research/      # Research
ls -la marketplace/advanced/      # Advanced patterns
ls -la marketplace/case-studies/  # Production examples

# Try examples
cd examples/STARTER-PACK
cat README.md
```

---

## Version & Status

**Version:** v1.0.4 Beta (Community Validation)
**Last Updated:** 2025-11-09
**Status:** Public launch ready - seeking community validation

**Foundational base:**
- Built on decades of proven DevOps, GitOps, Zero-Trust practices
- Initial applications in production environments
- Community validation now in progress

---

**Start with the factors. The marketplace is for depth.**

**[Read the 12 factors →](FACTORS.md)**
