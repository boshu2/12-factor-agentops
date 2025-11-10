# 12-Factor AgentOps - Repository Context

**A methodology for using AI agents safely and reliably.**

This repository is a **methodology repository** - like the original [12-Factor App](https://12factor.net), not implementation code.

---

## Repository Structure

This is a **Claude Code plugin marketplace** providing validation and pattern extraction skills.

```
12-factor-agentops/
├── README.md                # Personal intro, driving question, the 12 factors
├── FACTORS.md               # Quick reference (links to detailed docs)
├── WORKFLOW.md              # Practical application guide
│
├── .claude-plugin/          # Plugin marketplace configuration
│   └── marketplace.json     # Marketplace metadata + external links (agentops, aitmpl)
│
├── factors/                 # Detailed factor documentation
│   ├── 01-git-memory-as-knowledge-os.md
│   ├── 02-jit-context-loading.md
│   └── ... (all 12 factors)
│
├── examples/
│   └── STARTER-PACK/        # Complete reference implementation
│
├── docs/                    # Philosophy and theory (NOT Claude-specific)
│   ├── principles/          # Four Pillars, Five Laws, Knowledge OS
│   ├── domain-guides/       # DevOps, SRE, solo dev, team workflows
│   ├── research/            # Citations, validation studies, evidence
│   ├── advanced/            # Multi-agent orchestration, patterns
│   └── case-studies/        # Production examples and demonstrations
│
└── marketplace/             # Installable Claude Code plugins
    ├── factor-compliance-checker/
    │   ├── .claude-plugin/plugin.json
    │   ├── skill.md
    │   └── references/
    ├── five-laws-auditor/
    │   ├── .claude-plugin/plugin.json
    │   └── skill.md
    ├── pattern-extraction-assistant/
    │   ├── .claude-plugin/plugin.json
    │   └── skill.md
    ├── research-formatter/
    │   ├── .claude-plugin/plugin.json
    │   └── skill.md
    ├── diataxis-organizer/
    │   ├── .claude-plugin/plugin.json
    │   └── skill.md
    └── cross-reference-validator/
        ├── .claude-plugin/plugin.json
        └── skill.md
```

### Installation

Users install validation skills via:
```bash
# Add the marketplace
/plugin marketplace add boshu2/12-factor-agentops

# Install specific skills
/plugin install factor-compliance-checker@12-factor-agentops
/plugin install five-laws-auditor@12-factor-agentops
/plugin install pattern-extraction-assistant@12-factor-agentops
```

### External Marketplaces

This marketplace links to:
- **boshu2/agentops** (https://github.com/boshu2/agentops) - Production workflow plugins implementing 12-Factor AgentOps: core-workflow (Research→Plan→Implement→Learn), devops-operations (Kubernetes/Helm/ArgoCD), software-development (Python/JavaScript/Go)
- **aitmpl** - AI Template Marketplace (63+ plugins, 85+ agents, curated collection)

---

## Working on This Repository

### Read First
```bash
cat README.md                         # Start here (personal voice, driving question)
cat factors/01-*.md                   # Read a factor to understand depth
cat docs/principles/five-laws.md      # Understand principles
cat marketplace/factor-compliance-checker/skill.md  # Example plugin
```

### Making Changes
- **README.md**: Keep simple and personal (like 12-factor-agents)
- **factors/**: Detailed factor documentation
- **docs/**: Philosophy, theory, research (NOT Claude-specific)
- **marketplace/**: Claude Code plugins (skills with .claude-plugin/plugin.json)
- **.claude-plugin/marketplace.json**: Marketplace configuration + external links
- Maintain consistent voice throughout

### Voice & Style
- Personal experience ("I've watched agents fail...")
- Driving question at the top
- Just the factors - no meta-framework
- Deep dives optional (marketplace)

---

## Key Files

**README.md** - Entry point. Personal voice, one question, 12 factors, plugin installation.
**factors/*.md** - Detailed factor documentation with examples.
**WORKFLOW.md** - Practical application (Research → Plan → Implement).
**.claude-plugin/marketplace.json** - Plugin marketplace configuration and external links (agentops, aitmpl).
**marketplace/** - Installable Claude Code plugins (6 validation and pattern extraction skills).
**docs/** - Philosophy, theory, research, domain guides, case studies (NOT Claude-specific).

---

## Related Work

This repository follows the model of:
- [12-Factor App](https://12factor.net) - Structure and clarity
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) - Personal voice and approach

---

**Version:** v1.0.4 Beta
**Last Updated:** 2025-11-09
**Status:** Community validation in progress
