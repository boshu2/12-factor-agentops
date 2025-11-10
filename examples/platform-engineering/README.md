# Platform Engineering with 12-Factor AgentOps

**Domain:** Platform/Infrastructure Engineering
**Stack:** Kubernetes + Kustomize + ArgoCD + Terraform
**Team Size:** 1-50 engineers managing multi-cluster infrastructure

---

## Overview

This example demonstrates how platform engineering teams can use 12-Factor AgentOps principles to manage infrastructure-as-code safely and efficiently.

**Platform engineering involves:**
- Managing Kubernetes clusters (dev, staging, prod)
- Deploying infrastructure applications (monitoring, logging, networking)
- Harmonizing configuration across environments
- Detecting and remediating configuration drift
- Automating deployment pipelines

**Key challenges addressed:**
- How do I safely modify infrastructure without breaking prod?
- How do I ensure consistency across 10+ clusters?
- How do I validate changes before committing?
- How do I detect when manual changes have been made?
- How do I track what changed, why, and by whom?

---

## 12-Factor AgentOps in Platform Engineering

### Factor I: Git Memory as Knowledge OS
**Pattern:** Every infrastructure change is committed with context
- **Why:** Institutional memory of what worked, what failed, why decisions were made
- **Implementation:** Semantic commits with ADRs for major decisions
- **Example:** `feat(monitoring): add Prometheus federation for multi-cluster visibility`

### Factor II: JIT Context Loading
**Pattern:** Load cluster-specific context only when needed
- **Why:** Managing 10+ clusters overwhelms context windows
- **Implementation:** Agents load only target cluster configs
- **Example:** Deploy to prod-west → load only prod-west Kustomize overlays

### Factor III: Single-Responsibility Agents
**Pattern:** One agent per infrastructure operation
- **Why:** Creating resources differs from drift detection differs from harmonization
- **Agents:**
  - `infrastructure-create` - Scaffold new applications
  - `infrastructure-drift` - Detect manual changes
  - `infrastructure-harmonize` - Sync configuration updates

### Factor IV: Validation Gates
**Pattern:** Preview, validate, diff before every change
- **Why:** Infrastructure mistakes affect production workloads
- **Gates:**
  1. Kustomize builds successfully
  2. YAML passes schema validation
  3. Diffs reviewed before commit
  4. ArgoCD sync preview checked

### Factor V: Continuous Learning
**Pattern:** Capture failures, successes, edge cases
- **Why:** Platform patterns compound into institutional knowledge
- **Examples:**
  - "StorageClass must exist before PVC" → checklist item
  - "HorizontalPodAutoscaler requires metrics-server" → validation

### Factor VI: Session Continuity
**Pattern:** Multi-day migrations tracked in context bundles
- **Why:** Major infrastructure changes span multiple sessions
- **Example:** Multi-cluster Prometheus migration tracked across 5 days

### Factor VII: Intelligent Routing
**Pattern:** Commands route to appropriate agents automatically
- **Why:** Engineers shouldn't memorize which agent does what
- **Example:** `/validate-infra` detects task and routes accordingly

### Factor VIII: Autonomous Error Recovery
**Pattern:** Agents retry transient failures, escalate persistent issues
- **Why:** Network blips shouldn't require human intervention
- **Example:** ArgoCD sync failure → retry 3x → escalate with logs

### Factor IX: Pattern Extraction
**Pattern:** Successful infrastructure patterns become templates
- **Why:** Proven patterns reduce time from hours to minutes
- **Example:** PostgreSQL StatefulSet pattern reused 12 times

### Factor X: Multi-Agent Orchestration
**Pattern:** Complex infrastructure changes use multiple agents in sequence
- **Why:** Large migrations require coordination
- **Example:** Multi-cluster upgrade: plan → validate → deploy-dev → validate → deploy-prod

### Factor XI: Human-in-the-Loop
**Pattern:** High-risk changes require explicit approval
- **Why:** Production infrastructure deserves extra caution
- **Gates:**
  - StatefulSet changes
  - StorageClass modifications
  - NetworkPolicy updates
  - Resource quota changes

### Factor XII: Compliance as Code
**Pattern:** Policies enforced via automated checks
- **Why:** Security and compliance must be automatic
- **Checks:**
  - All images from approved registries
  - Resource limits defined
  - NetworkPolicies present
  - Labels/annotations required

---

## Quick Start

### 1. Install This Example

```bash
# Copy .claude/ folder to your infrastructure repository
cp -r examples/platform-engineering/.claude your-infra-repo/

# Customize for your environment
cd your-infra-repo/.claude/
# Edit agents/commands to match your cluster names, tools, etc.
```

### 2. Typical Workflows

**Create new infrastructure application:**
```bash
# Use agent
/infrastructure-create

# Provide: app name, namespace, cluster target
# Agent scaffolds: base/, overlays/, ArgoCD application
# Validates: builds successfully, YAML valid
# Result: Ready to commit
```

**Detect configuration drift:**
```bash
# Check if manual changes were made
/infrastructure-drift

# Agent compares: Git (source of truth) vs cluster (reality)
# Reports: Differences, who made changes, when
# Suggests: Sync from Git or capture changes to Git
```

**Harmonize configuration across clusters:**
```bash
# Update config value across all environments
/infrastructure-harmonize

# Example: Update Prometheus retention from 15d → 30d
# Agent: Updates all overlays, validates builds, shows diffs
# Review: Confirm changes before commit
```

**Validate before deployment:**
```bash
# Quick validation
/validate-infra

# Checks:
# - Kustomize builds
# - YAML schema valid
# - Required labels present
# - ArgoCD application references exist
```

### 3. Adapting to Your Stack

**If you use Helm instead of Kustomize:**
- Agents still work, replace `kustomize build` with `helm template`
- Validation logic stays the same
- Directory structure: `charts/` instead of `base/`

**If you use Flux instead of ArgoCD:**
- Replace ArgoCD application manifests with Flux Kustomizations
- Drift detection uses `flux diff` instead of `argocd app diff`
- Core patterns unchanged

**If you use Terraform:**
- Agents scaffold `.tf` files instead of YAML
- Validation uses `terraform validate` and `terraform plan`
- Drift detection via `terraform plan -detailed-exitcode`

---

## Directory Structure

```
your-infra-repo/
├── .claude/
│   ├── agents/
│   │   ├── infrastructure-create.md
│   │   ├── infrastructure-drift.md
│   │   └── infrastructure-harmonize.md
│   └── commands/
│       ├── validate-infra.md
│       └── deploy-infra.md
├── apps/                          # Application manifests
│   ├── prometheus/
│   │   ├── base/                  # Common resources
│   │   │   ├── kustomization.yaml
│   │   │   ├── deployment.yaml
│   │   │   └── service.yaml
│   │   └── overlays/              # Per-environment
│   │       ├── dev/
│   │       ├── staging/
│   │       └── prod/
│   └── grafana/
│       └── ...
├── argocd/                        # ArgoCD applications
│   ├── prometheus-dev.yaml
│   ├── prometheus-staging.yaml
│   └── prometheus-prod.yaml
└── docs/                          # ADRs and runbooks
    └── adr/
```

---

## Real-World Results

**Before 12-Factor AgentOps:**
- Creating new app: 2-4 hours (copy-paste, fix YAML errors, validate manually)
- Configuration drift: Discovered by accident during incidents
- Multi-cluster updates: 1-2 days (manual changes per cluster)
- Validation: Ad-hoc, often skipped under pressure
- Knowledge loss: When engineers leave, patterns lost

**After 12-Factor AgentOps:**
- Creating new app: 15 minutes (agent scaffolds, validates automatically)
- Configuration drift: Detected daily, synced or documented
- Multi-cluster updates: 30 minutes (agent harmonizes, shows diffs)
- Validation: Automatic gates, impossible to skip
- Knowledge preservation: Git commits + agents = institutional memory

**Quantified improvements (example team):**
- 8x faster infrastructure scaffolding
- 90% reduction in YAML syntax errors
- 100% configuration drift visibility
- 95% consistency across clusters
- 0 production incidents from manual drift (previously 2-3/month)

---

## Anti-Patterns to Avoid

### Anti-Pattern 1: Manual kubectl apply
❌ **Problem:** Changes not in Git, drift accumulates
✅ **Solution:** All changes via GitOps (ArgoCD/Flux)

### Anti-Pattern 2: Skipping validation
❌ **Problem:** Broken YAML reaches production
✅ **Solution:** Validation gates block commits

### Anti-Pattern 3: Copy-paste without understanding
❌ **Problem:** Configurations don't match environment
✅ **Solution:** Use agents that understand context

### Anti-Pattern 4: One-size-fits-all configs
❌ **Problem:** Dev gets prod resource limits
✅ **Solution:** Kustomize overlays per environment

### Anti-Pattern 5: No drift detection
❌ **Problem:** Manual changes invisible until incident
✅ **Solution:** Daily drift checks, reconcile immediately

---

## Compliance Patterns

### Security Policies
```yaml
# Enforce via OPA/Gatekeeper or Kyverno
policies:
  - name: require-resource-limits
    rule: All containers must define resources.limits
  - name: approved-registries
    rule: Images only from registry.example.com
  - name: network-policies
    rule: All namespaces require NetworkPolicy
```

### Audit Trail
```bash
# Every infrastructure change tracked
git log --oneline apps/prometheus/

# Example commits:
# feat(prometheus): increase retention to 30d for compliance
# fix(prometheus): correct PVC size calculation
# docs(prometheus): add ADR for federation architecture
```

### Change Approval
```markdown
# High-risk changes require approval workflow
High-Risk Resources:
- StatefulSets (data risk)
- PersistentVolumeClaims (storage cost)
- NetworkPolicies (security boundary)
- ClusterRoles (privilege escalation)

Approval Required:
1. Create PR with changes
2. Agent validates automatically
3. Peer review required
4. ArgoCD sync preview reviewed
5. Merge + auto-deploy to dev
6. Manual approval for staging/prod
```

---

## Getting Help

**Agent isn't working?**
- Check agent has access to your directories
- Verify tools installed (kustomize, kubectl, argocd CLI)
- Review agent markdown for prerequisites

**Validation failing?**
- Read error messages carefully
- Check YAML syntax (indentation)
- Verify referenced resources exist
- Ensure labels/annotations present

**Drift detected unexpectedly?**
- Someone may have kubectl applied manually
- ArgoCD auto-sync may be disabled
- Check Git history: `git log -p apps/`

**Want to customize agents?**
- Agents are markdown files, edit freely
- Follow the Five Laws of an Agent
- Test changes in non-prod first
- Share improvements back to community

---

## Next Steps

1. **Copy this folder to your repo**
2. **Customize agents for your stack** (Helm/Terraform/etc.)
3. **Try `/validate-infra` on existing apps**
4. **Use `/infrastructure-create` for next new app**
5. **Enable daily drift detection** (cron or CI job)
6. **Track results** (time saved, errors prevented)
7. **Share patterns** back to 12-factor-agentops community

---

## References

- [12-Factor AgentOps](../../README.md) - Full framework
- [Factor IV: Validation Gates](../../factors/04-validation-gates.md) - Why validation matters
- [Factor IX: Pattern Extraction](../../factors/09-pattern-extraction.md) - Building templates
- [Kustomize](https://kustomize.io/) - Kubernetes configuration management
- [ArgoCD](https://argo-cd.readthedocs.io/) - GitOps continuous delivery
- [Site Reliability Engineering](https://sre.google/books/) - Google SRE practices

---

**Platform engineering is about reliability at scale. 12-Factor AgentOps makes AI agents as reliable as the infrastructure they manage.**

Start small. Validate relentlessly. Build institutional memory. Scale with confidence.
