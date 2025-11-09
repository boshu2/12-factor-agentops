# Quick Start: Copy-Paste Your Domain

**5-minute setup for any domain**

## Step 1: Pick Your Domain

- **Platform Engineering** → Managing infrastructure (Kubernetes, IaC, GitOps)
- **DevOps** → CI/CD pipelines, security, deployments
- **SRE** → Monitoring, incidents, reliability
- **Web Development** → Frontend, APIs, full-stack

## Step 2: Copy .claude/ to Your Project

```bash
# From 12-factor-agentops repository root:

# Platform Engineering
cp -r examples/platform-engineering/.claude/ /path/to/your-project/

# DevOps
cp -r examples/devops/.claude/ /path/to/your-project/

# SRE  
cp -r examples/sre/.claude/ /path/to/your-project/

# Web Development
cp -r examples/web-development/.claude/ /path/to/your-project/
```

## Step 3: Test an Agent

Open your project in Claude Code:

```bash
cd /path/to/your-project/

# Platform Engineering
/agent infrastructure-create

# DevOps
/agent pipeline-guide

# SRE
/agent slo-dashboard

# Web Development
/agent component-create
```

## Step 4: Customize for Your Stack

Edit agents to match your tools:
- **Platform:** Terraform instead of Kustomize? Update commands
- **DevOps:** GitHub Actions instead of GitLab CI? Swap examples
- **SRE:** Datadog instead of Prometheus? Change queries
- **Web:** Vue instead of React? Adapt component patterns

**Keep the structure, adapt the tools.**

## What You Get

Each domain includes:
- ✅ 3 specialized agents
- ✅ 2 quick-access slash commands  
- ✅ Complete workflow documentation
- ✅ 12-Factor AgentOps compliance
- ✅ Validation gates built-in

## Time Savings

Based on production use:
- **Platform Engineering:** 12-32x faster (4-6h → 15-20min)
- **DevOps:** 8-16x faster (2-4h → 15-20min)
- **SRE:** 6-12x faster (3-6h → 30-45min)
- **Web Development:** 2-3x faster (8-12h → 4-6h)

## Need Help?

- Read: `examples/{domain}/README.md` for domain overview
- Read: `examples/{domain}/WORKFLOWS.md` for detailed scenarios
- Reference: Main repo docs for 12-Factor principles

---

**Ready in 5 minutes. Productive immediately.**
