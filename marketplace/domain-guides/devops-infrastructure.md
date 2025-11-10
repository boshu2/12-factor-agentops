# DevOps & Infrastructure Domain Guide

**Apply 12-Factor AgentOps to infrastructure automation, Kubernetes, and cloud operations**

---

## Domain Context

### Typical AI Usage in DevOps

- Infrastructure as Code (Terraform, Kubernetes manifests)
- Automation scripts (Bash, Python, Ansible)
- Monitoring and alerting configuration
- CI/CD pipeline definition
- Incident response and debugging
- Documentation and runbooks

### Common Pain Points

```
Week 1: ✨ "AI generated perfect Kubernetes manifests!" → Deploy
Week 2: 😬 "Pods crashing, missing resource limits" → Manual fixes
Week 3: 🔥 "Production outage from untested config" → Rollback
Week 4: 🚫 "Reviewing AI configs takes longer than writing" → Abandon
```

### Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Config validation pass rate** | >95% | Dry-run results |
| **Change failure rate** | <5% | Deployment tracking |
| **MTTR (AI-assisted)** | <Manual | Incident tracking |
| **Automation coverage** | >80% | Runbook audit |

---

## Factor Prioritization for DevOps

### Essential Foundation

**Factor I: Git Memory** - All infrastructure changes tracked with context
**Factor II: JIT Context** - Load manifests JIT, not entire clusters
**Factor IV: Validation Gates** - Dry-run, kubeval, terraform plan before apply

### High-Value Add-Ons

**Factor V: Telemetry** - Track all automation metrics
**Factor XI: Constitutional Guardrails** - Safety boundaries (never delete prod without backup)
**Factor VIII: Human Gates** - Production changes require approval

---

## Practical Examples

### Example 1: Kubernetes Manifest Generation

**With Framework:**

```bash
# Factor IV: Validate before applying
kubectl apply --dry-run=client -f deployment.yaml
kustomize build . | kubeval
yamllint deployment.yaml

# Factor I: Commit with context
git commit -m "feat(k8s): add resource limits to api deployment

Context: API pods consuming excessive memory
Solution: Added requests/limits based on observability data
AI-Assisted: Claude Code generated YAML
Validation: dry-run passed, kubeval passed
Testing: Deployed to staging, monitoring for 24h

Resource limits:
- requests: cpu 100m, memory 128Mi
- limits: cpu 500m, memory 512Mi"

# Factor IV: Test in staging first
kubectl apply -f deployment.yaml --namespace=staging
# Monitor for 24h before production
```

### Example 2: Terraform Infrastructure

**With Framework:**

```bash
# Research phase
/research "AWS EKS best practices for production"

# Plan phase
/plan eks-research

# Implement with validation
terraform fmt        # Format check
terraform validate   # Syntax check
terraform plan       # Preview changes

# Factor XI: Constitutional check
# Never: Delete resources without backup
# Always: Tag all resources with owner/env
# Always: Use remote state

# Factor I: Commit
git commit -m "feat(infra): add EKS cluster with security groups

Context: Need production Kubernetes cluster
Solution: EKS with private subnets, security groups
AI-Assisted: Claude Code generated TF configs
Validation: terraform plan shows expected changes
Cost: Estimated $500/month

Security:
- Private subnets only
- Security groups locked to VPN
- IAM roles with least privilege"

# Factor VIII: Request approval for production apply
# Human reviews plan before terraform apply
```

### Example 3: Incident Response Automation

**With Framework:**

```bash
# Factor V: Track incident metrics
incident_start=$(date +%s)

# Factor VII: Route to right tool
# Logs analysis → AI log parser
# Config debugging → AI config validator
# Rollback decision → Human + AI recommendation

# Factor I: Document incident resolution
git commit -m "fix(incident): restore API service after OOM crash

Context: API pods OOM killed, service down 15min
Solution: Increased memory limits, added HPA
AI-Assisted: Claude Code analyzed logs, suggested limits
Resolution Time: 15 minutes (MTTR target: <30min)

Root Cause: Memory leak in v2.3.1
Fix: Rolled back to v2.3.0, increased limits temporarily
Next: Fix memory leak in v2.3.2

Incident #456"

incident_end=$(date +%s)
mttr=$((incident_end - incident_start))
echo "MTTR: ${mttr}s" # Track for metrics
```

---

## Tool Integration

### Kubernetes Validation

```bash
# Pre-commit hook for Kubernetes
#!/bin/bash
yamllint *.yaml || exit 1
kubeval *.yaml || exit 1
kustomize build . > /dev/null || exit 1
```

### Terraform Validation

```bash
# Pre-commit hook for Terraform
#!/bin/bash
terraform fmt -check || exit 1
terraform validate || exit 1
tflint || exit 1
```

### CI/CD Pipeline

```yaml
# GitLab CI for infrastructure
validate:
  script:
    - kubectl apply --dry-run=client -f manifests/
    - kustomize build . | kubeval
    - yamllint manifests/

deploy-staging:
  script:
    - kubectl apply -f manifests/ --namespace=staging
  environment: staging
  when: manual

deploy-production:
  script:
    - kubectl apply -f manifests/ --namespace=production
  environment: production
  when: manual
  only:
    - main
```

---

## Success Patterns

### Pattern 1: Immutable Infrastructure

```
Never: Modify running infrastructure directly
Always: Change code → Validate → Apply → Test

With AI:
1. AI generates infrastructure code
2. Validate with dry-run/plan
3. Apply to staging
4. Monitor metrics
5. If successful, apply to production
6. Document pattern for reuse
```

### Pattern 2: GitOps Workflow

```
Git is source of truth (Factor I)
├─ All changes via pull requests
├─ AI generates manifests
├─ Validation in CI (Factor IV)
├─ Human approval for production (Factor VIII)
└─ Auto-sync applies changes

Result: Auditable, reversible, validated
```

---

## Anti-Patterns

### ❌ "AI, Deploy to Production"

**Wrong:**
```bash
# Ask AI: "Generate Kubernetes deployment"
# Copy/paste
# kubectl apply -f deployment.yaml
# ❌ Production outage
```

**Right:**
```bash
# Ask AI: "Generate Kubernetes deployment"
# Validate: kubectl apply --dry-run
# Test in staging
# Human review
# Then production
```

### ❌ "Skip Dry-Run"

Violates Factor IV. Always validate before applying.

### ❌ "No Resource Limits"

AI often forgets resource limits. Always review and add.

---

## Getting Started Checklist

**Day 1:**
- [ ] Set up validation pipeline
- [ ] Configure dry-run checks
- [ ] Create commit templates

**Week 1: Foundation**
- [ ] Factor I: Commit all infra changes with context
- [ ] Factor II: Load configs JIT
- [ ] Factor IV: Dry-run before every apply

**Week 2: Advanced**
- [ ] Factor V: Set up metrics tracking
- [ ] Factor XI: Document safety boundaries
- [ ] Factor VIII: Require approval for prod changes

---

## Resources

- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/)
- [Quick Reference Card](../../tutorials/quick-reference-card.md)

**Related Guides:**
- [Software Development Guide](software-development.md) - If you also write code
- [Solo Developer Guide](solo-developer.md) - If wearing all hats
