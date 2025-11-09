# Domain-Specific Examples

**Copy-paste ready `.claude/` configurations for different domains**

This directory contains complete, working examples showing how to apply 12-Factor AgentOps patterns in different domains. Each example includes agents, slash commands, and workflow documentation you can copy directly into your projects.

---

## Available Domains

| Domain | Use Case | Best For |
|--------|----------|----------|
| [**platform-engineering/**](./platform-engineering/) | Infrastructure as Code, GitOps, Kubernetes | Platform teams managing multi-cluster infrastructure |
| [**devops/**](./devops/) | CI/CD pipelines, security scanning, deployments | DevOps engineers automating software delivery |
| [**sre/**](./sre/) | Monitoring, incidents, SLOs, reliability | SRE teams ensuring service reliability |
| [**web-development/**](./web-development/) | Frontend apps, APIs, full-stack development | Web developers building applications |

---

## How to Use These Examples

### Quick Start (5 minutes)

1. **Browse** the domain that matches your work
2. **Copy** the `.claude/` folder to your project root:
   ```bash
   cp -r examples/platform-engineering/.claude/ /path/to/your-project/
   ```
3. **Customize** the agents/commands for your specific needs
4. **Start using** via Claude Code slash commands

### What You Get

Each domain example includes:
- ✅ **2-3 working agents** - Specialized workflows for that domain
- ✅ **2-3 slash commands** - Quick-access commands for common tasks
- ✅ **README.md** - Domain-specific guidance and patterns
- ✅ **WORKFLOWS.md** - Typical day-in-the-life examples
- ✅ **12-Factor mapping** - Which factors each agent implements

---

## Example Structure

```
examples/platform-engineering/
├── README.md                    # Domain overview
├── WORKFLOWS.md                 # Typical workflow patterns
└── .claude/                     # Copy this to your project!
    ├── agents/
    │   ├── infrastructure-create.md
    │   ├── infrastructure-drift.md
    │   └── infrastructure-harmonize.md
    └── commands/
        ├── validate-infra.md
        └── deploy-infra.md
```

---

## Customization Guide

### Adapting to Your Stack

**Platform Engineering example uses:**
- Kubernetes + Kustomize + ArgoCD
- **Your stack might use:** Terraform, Pulumi, CloudFormation, etc.

**To adapt:**
1. Keep the pattern structure (validation gates, git as source of truth)
2. Replace tool-specific commands (`kubectl` → `terraform`)
3. Update file paths to match your repository structure
4. Maintain 12-Factor principles (especially Factor IV: Validation Gates)

### Adding Your Own Agents

Create new agents following the pattern:
```markdown
---
description: What this agent does
model: sonnet
name: your-agent-name
tools: Read, Write, Edit, Bash
---

## 🔴 Laws of an Agent (MANDATORY)
[Standard header - copy from examples]

## 12-Factor Mapping
[Which factors this implements]

## Role & Constraints
[What it does and doesn't do]

## How to Execute
[Step-by-step instructions]
```

---

## Factor Implementation Across Domains

All examples demonstrate:

| Factor | Implementation | Where to See It |
|--------|---------------|-----------------|
| **I. Git as Knowledge OS** | Every agent commits with structured messages | All agents, commit templates |
| **II. JIT Context Loading** | Agents load minimal context, reference docs | Agent size <500 lines |
| **III. Single Responsibility** | One agent = one task (create vs modify vs debug) | Agent boundaries clear |
| **IV. Validation Gates** | `make validate` or equivalent before commit | Every workflow |
| **V. Operational Telemetry** | Metrics tracked (optional, see SRE examples) | SRE domain |
| **IX. Pattern Extraction** | Reusable patterns documented | Pattern sections in agents |

---

## Testing These Examples

### Validation Checklist

Before using in production:
- [ ] Copied `.claude/` to your project
- [ ] Updated paths to match your repository structure
- [ ] Tested agent commands in safe environment
- [ ] Reviewed validation gates work for your stack
- [ ] Customized for your specific tools/workflows

### Example Projects (Coming Soon)

Each domain will include example project structures showing:
- Configuration files
- Directory layout
- Integration with your existing repos

---

## Contributing Domain Examples

Have a domain not represented here? We'd love your contribution!

**Domains we're interested in:**
- Data Science / ML Engineering
- Security / Compliance
- Database Administration
- Mobile Development
- Embedded Systems
- Research / Academia

**How to contribute:**
1. Use the framework in your domain
2. Extract patterns that worked
3. Sanitize proprietary details
4. Submit PR with `.claude/` folder + README.md

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

---

## Questions?

- **"Which domain should I start with?"** → Pick the one closest to your daily work
- **"Can I mix domains?"** → Yes! Copy agents from multiple domains
- **"Do I need all agents?"** → No, start with 1-2 that solve your biggest pain
- **"What if my stack is different?"** → Adapt the patterns, keep the principles

---

**Ready to get started?** Browse a domain above and copy the `.claude/` folder to your project!

