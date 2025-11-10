# 12-Factor AgentOps - Repository Context

**A methodology for using AI agents safely and reliably.**

This repository is a **methodology repository** - like the original [12-Factor App](https://12factor.net), not implementation code.

---

## Repository Structure

```
12-factor-agentops/
├── README.md          # Personal intro, driving question, the 12 factors
├── FACTORS.md         # Quick reference (links to detailed docs)
├── WORKFLOW.md        # Practical application guide
│
├── factors/           # Detailed factor documentation
│   ├── 01-git-memory-as-knowledge-os.md
│   ├── 02-jit-context-loading.md
│   └── ... (all 12 factors)
│
├── examples/
│   └── STARTER-PACK/  # Complete reference implementation
│
└── marketplace/       # Optional deep dives
    ├── principles/    # Four Pillars, Five Laws
    ├── domain-guides/ # DevOps, SRE, solo dev
    ├── research/      # Citations, validation
    ├── advanced/      # Patterns, orchestration
    └── case-studies/  # Production examples
```

---

## Working on This Repository

### Read First
```bash
cat README.md         # Start here (personal voice, driving question)
cat factors/01-*.md   # Read a factor to understand depth
cat marketplace/principles/five-laws.md  # Understand principles
```

### Making Changes
- Keep README simple and personal (like 12-factor-agents)
- Factor docs go in `factors/` directory
- Deep philosophy goes in `marketplace/`
- Maintain consistent voice throughout

### Voice & Style
- Personal experience ("I've watched agents fail...")
- Driving question at the top
- Just the factors - no meta-framework
- Deep dives optional (marketplace)

---

## Key Files

**README.md** - Entry point. Personal voice, one question, 12 factors.
**factors/*.md** - Detailed factor documentation with examples.
**WORKFLOW.md** - Practical application (Research → Plan → Implement).
**marketplace/** - Optional depth for those who want more.

---

## Related Work

This repository follows the model of:
- [12-Factor App](https://12factor.net) - Structure and clarity
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) - Personal voice and approach

---

**Version:** v1.0.4 Beta
**Last Updated:** 2025-11-09
**Status:** Community validation in progress
