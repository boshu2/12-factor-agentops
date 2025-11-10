# Day-in-the-Life: Platform Engineering Workflows

**Real-world scenarios showing how 12-Factor AgentOps transforms daily platform engineering work.**

---

## Scenario 1: Monday Morning - Deploy New Monitoring Stack

**Context:** Your team needs Prometheus + Grafana across 5 Kubernetes clusters (dev, staging, 3 prod regions).

### Without 12-Factor AgentOps (Traditional Approach)

**Time:** 4-6 hours
**Error rate:** 30-40% (YAML typos, missing configs, inconsistencies)

```bash
# 1. Copy existing app as template (30 min)
cp -r apps/existing-app apps/prometheus
# Manually edit 20+ YAML files
# Fix indentation errors
# Update image references
# Add environment-specific configs

# 2. Create overlays manually (1 hour)
mkdir -p apps/prometheus/overlays/{dev,staging,prod-west,prod-east,prod-central}
# Copy-paste base configs
# Manually adjust resource limits per env
# Hope you didn't miss any fields

# 3. Create ArgoCD applications (45 min)
# Write 5 ArgoCD app YAML files
# Get repo URL wrong twice
# Fix path references
# Realize you forgot namespace

# 4. Validate (if you remember) (30 min)
kustomize build apps/prometheus/overlays/dev
# Fix 3 YAML syntax errors
# Rebuild, fix 2 more
# Repeat for each overlay

# 5. Deploy and troubleshoot (2 hours)
kubectl apply -f argocd/prometheus-dev.yaml
# App won't sync - path wrong
# Fix path, StorageClass doesn't exist
# Add StorageClass
# ServiceMonitor CRD missing
# Install Prometheus Operator first
# Finally syncs
# Repeat debugging for each cluster
```

**Result:**
- 6 hours elapsed
- 3 YAML syntax errors reached Git
- 2 clusters have wrong resource limits
- Staging missing NetworkPolicy (discovered next week)
- No documentation of decisions
- Exhausted, never want to deploy infra again

### With 12-Factor AgentOps

**Time:** 20 minutes
**Error rate:** <5% (agent validates everything)

```bash
# 1. Use infrastructure-create agent (5 min)
/infrastructure-create

# Agent prompts:
"Application name?" → prometheus
"Namespace?" → monitoring
"Target clusters?" → dev, staging, prod-west, prod-east, prod-central
"Base image?" → prom/prometheus:v2.45.0
"Requires storage?" → yes
"Resource tier?" → medium (agent knows tier definitions)

# Agent generates:
# - apps/prometheus/base/ (Deployment, Service, PVC, ServiceMonitor)
# - apps/prometheus/overlays/ (5 overlays with env-specific configs)
# - argocd/prometheus-*.yaml (5 ArgoCD applications)
# - Validates all YAML syntax
# - Checks StorageClass exists in each cluster
# - Verifies Prometheus Operator installed
# - Shows diff of what will be created

# 2. Review and customize (10 min)
# Agent opened files in editor
# Review generated configs
# Adjust retention period for prod (15d → 30d)
# Add federation config for multi-cluster

# 3. Validate and commit (5 min)
/validate-infra

# Agent runs:
# ✓ Kustomize builds all overlays
# ✓ YAML schema validation
# ✓ Required labels present
# ✓ ArgoCD apps reference valid paths
# ✓ Resource limits defined
# ✓ NetworkPolicies generated

git add apps/prometheus argocd/prometheus-*.yaml
git commit
# Agent suggests semantic commit:
# feat(monitoring): add Prometheus with multi-cluster federation
#
# - Deploy to 5 clusters (dev, staging, 3 prod regions)
# - Retention: 15d (dev/staging), 30d (prod) for compliance
# - Federation enabled for centralized querying
# - Resource tier: medium (4GB RAM, 2 CPU)
#
# Validated:
# - StorageClass exists in all clusters
# - Prometheus Operator pre-installed
# - NetworkPolicies generated automatically
```

**Result:**
- 20 minutes elapsed
- 0 YAML syntax errors
- 100% consistency across clusters
- All security policies enforced
- Full documentation in commit message
- Confident, ready to deploy next app

---

## Scenario 2: Tuesday Afternoon - Configuration Drift Detected

**Context:** Daily drift check finds manual changes in production cluster.

### Without 12-Factor AgentOps

**Time:** 2-3 hours detective work
**Risk:** High (might revert legitimate change)

```bash
# 1. Notice something's wrong (incident-driven)
# User reports: "Grafana dashboard looks different"
# Check Git: no recent commits to grafana/
# Check cluster: deployment has extra sidecar container
# Who added it? When? Why?

# 2. Investigate manually (1 hour)
kubectl get deployment grafana -n monitoring -o yaml > /tmp/current.yaml
kustomize build apps/grafana/overlays/prod > /tmp/expected.yaml
diff /tmp/current.yaml /tmp/expected.yaml
# 200 lines of diff (includes timestamps, resourceVersion, etc.)
# Hard to find actual changes
# See sidecar container, but is it important?

# 3. Track down change (1 hour)
kubectl describe deployment grafana -n monitoring
# No annotation of who changed it
# Check Kubernetes audit logs (if enabled)
# Ask in Slack: "Did anyone modify Grafana?"
# Person on vacation, can't confirm

# 4. Decide what to do (30 min)
# Risk reverting: might break something
# Risk keeping: drift accumulates
# Compromise: document and ignore for now
# Add TODO to team backlog
```

**Result:**
- 2.5 hours wasted
- Change origin unknown
- Drift remains (will cause issues later)
- No learning captured
- Team morale down

### With 12-Factor AgentOps

**Time:** 10 minutes resolution
**Risk:** Low (full visibility + decision support)

```bash
# 1. Daily automated drift check (via cron)
/infrastructure-drift

# Agent reports:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Configuration Drift Detected
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Cluster: prod-west
# Resource: Deployment/grafana (namespace: monitoring)
# Drifted from: apps/grafana/overlays/prod/
#
# Changes:
# + Added container: oauth2-proxy (image: quay.io/oauth2-proxy/oauth2-proxy:v7.4.0)
# + Added volume: oauth2-proxy-config
# + Added volumeMount: /etc/oauth2-proxy
#
# Last Git sync: 2 days ago (commit a3f8d2c)
# Cluster modified: 4 hours ago
# Modified by: kubectl (user: alice@example.com, IP: 10.2.5.100)
#
# Recommendations:
# Option 1: Revert to Git (re-sync ArgoCD)
# Option 2: Capture change to Git (create PR)
# Option 3: Document as temporary (add annotation)

# 2. Contact person who made change (2 min)
# Slack Alice: "Hey, I see you added oauth2-proxy to Grafana prod. Is this temporary?"
# Alice: "Yes! Testing SSO integration, will create PR today."

# 3. Document decision (2 min)
# Agent suggests annotation:
kubectl annotate deployment grafana -n monitoring \
  drift.agentops.dev/temporary="true" \
  drift.agentops.dev/reason="Testing SSO, PR coming" \
  drift.agentops.dev/date="2025-01-15" \
  drift.agentops.dev/expires="2025-01-22"

# 4. Verify PR arrives (later that day)
# Alice creates PR with oauth2-proxy sidecar
# Agent validates, team reviews, merges
# Drift resolved, pattern captured in Git
```

**Result:**
- 10 minutes total time
- Full visibility of change
- Contacted right person immediately
- Temporary drift documented
- Permanent fix via PR
- Learning captured: SSO pattern now in Git

---

## Scenario 3: Wednesday Morning - Harmonize Config Across Clusters

**Context:** Security requires TLS 1.3 minimum across all ingresses. 50+ ingress resources across 10 clusters.

### Without 12-Factor AgentOps

**Time:** Full day (8 hours)
**Error rate:** 25% (some ingresses missed)

```bash
# 1. Identify all ingresses (1 hour)
grep -r "kind: Ingress" apps/
# Copy-paste results to spreadsheet
# Manually list all files
# Realize some apps use Helm charts (different location)
# Find those too
# End up with ~50 ingress files

# 2. Update each file manually (4 hours)
# Open each ingress YAML
# Find `annotations:` section (or add it)
# Add: nginx.ingress.kubernetes.io/ssl-protocols: "TLSv1.3"
# Repeat 50 times
# Make typo in annotation name 3 times
# Forget to add to 5 ingresses (catch later, maybe)

# 3. Validate builds (1 hour)
# Run kustomize build for each app
# Fix YAML indentation errors (added annotation at wrong level)
# Fix annotation name typos
# Re-validate

# 4. Review diffs (1 hour)
git diff apps/
# 500 lines of diff
# Skim quickly (too much to read carefully)
# Hope you didn't break anything

# 5. Test in dev (1 hour)
# Deploy to dev cluster
# Test 3-5 apps manually
# Assume others work the same
# Ship it
```

**Result:**
- 8 hours elapsed
- 5 ingresses missed (discovered in audit next month)
- 3 typos reached production (non-breaking, but sloppy)
- No documentation of why change made
- Risk: incomplete compliance

### With 12-Factor AgentOps

**Time:** 15 minutes
**Error rate:** 0% (agent updates all resources)

```bash
# 1. Run harmonize agent (3 min)
/infrastructure-harmonize

# Agent prompts:
"What configuration to update?" → ingress annotations
"Resource type?" → Ingress
"Clusters?" → all
"Annotation key?" → nginx.ingress.kubernetes.io/ssl-protocols
"Annotation value?" → TLSv1.3
"Reason?" → Security requirement: TLS 1.3 minimum

# Agent executes:
# - Scans all apps/ directories
# - Identifies 52 Ingress resources
# - Loads each Kustomization
# - Adds/updates annotation in all overlays
# - Validates kustomize build for each
# - Shows comprehensive diff

# Agent reports:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Harmonization Complete
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Updated: 52 Ingress resources
# Clusters: dev, staging, prod-west, prod-east, prod-central
# Change: Added nginx.ingress.kubernetes.io/ssl-protocols: "TLSv1.3"
#
# Validated:
# ✓ All Kustomizations build successfully
# ✓ No YAML syntax errors
# ✓ Annotation applied consistently
# ✓ No ingresses missed
#
# Files modified: 52
# Ready to commit: yes

# 2. Review diff (5 min)
git diff apps/
# Agent organized diff by app
# Each change identical (annotation added)
# Spot-check 3-5 apps
# Confirm changes correct

# 3. Commit with context (2 min)
git add apps/
git commit

# Agent suggests:
# feat(security): enforce TLS 1.3 on all ingresses
#
# Updated 52 Ingress resources across all clusters to require
# minimum TLS version 1.3 per security policy SEC-2025-01.
#
# Scope:
# - All applications with Ingress resources
# - All environments (dev, staging, prod)
#
# Validation:
# - Kustomize builds confirmed for all apps
# - Annotation syntax verified
# - 100% coverage (52/52 ingresses updated)
#
# Compliance: SEC-2025-01

# 4. Deploy to dev, validate (5 min)
git push
# ArgoCD auto-syncs dev
# Test 2-3 ingresses: curl -v https://app.dev.example.com
# Verify TLS 1.3 in handshake
# Promote to staging, then prod
```

**Result:**
- 15 minutes total time
- 100% coverage (52/52 ingresses)
- 0 errors
- Full audit trail in Git
- Compliance documented
- Deployable with confidence

---

## Scenario 4: Thursday Emergency - Prod Incident Requires Rollback

**Context:** New deployment broke authentication. Need immediate rollback.

### Without 12-Factor AgentOps

**Time:** 30-45 minutes (during incident)
**Stress:** Extreme (everyone watching)

```bash
# 1. Identify last working commit (5 min)
git log apps/auth-service/
# Scroll through commits
# Which one was working?
# Check timestamps vs incident start
# Hope you guess right

# 2. Revert manually (10 min)
git revert a3f8d2c
# Merge conflict (someone changed same file)
# Resolve conflict under pressure
# Hope you didn't make it worse

# 3. Fast-track to prod (15 min)
git push
# ArgoCD auto-sync? Or manual?
# Can't remember
# Force sync manually to be safe
argocd app sync auth-service-prod --force
# Watch sync status anxiously
# Pods restarting...
# Still failing?
# Check logs
# Oh, need to revert database migration too
# Panic

# 4. Communicate status (ongoing)
# Update incident channel every 2 min
# "Still working on it..."
# Stress level: maximum
```

**Result:**
- 30-45 minutes downtime
- High stress
- Uncertainty throughout
- Might have made it worse
- Post-incident fatigue

### With 12-Factor AgentOps

**Time:** 5 minutes (automated)
**Stress:** Low (agent handles it)

```bash
# 1. Agent detects incident (automatic)
# Monitoring alerts: auth-service error rate spike
# Agent checks recent deployments
# Identifies likely culprit: commit a3f8d2c (deployed 10 min ago)

# 2. Agent suggests rollback (1 min)
/infrastructure-rollback

# Agent prompts:
"Service?" → auth-service
"Environment?" → prod
"Rollback to?" → Previous version (commit f2e9c1a, deployed 2 days ago, 100% success rate)

# Agent shows:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Rollback Plan
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Current:  a3f8d2c (feat: new OAuth provider)
#           Deployed: 10 min ago
#           Status: 87% error rate
#
# Rollback: f2e9c1a (fix: improve token validation)
#           Last deployed: 2 days ago
#           Historical success rate: 100%
#
# Actions:
# 1. Revert Git to f2e9c1a
# 2. Sync ArgoCD application
# 3. Monitor health checks
# 4. Create incident report
#
# Estimated downtime: 2-3 minutes
# Approve rollback? [y/N]

# 3. Execute rollback (2 min)
# Type: y

# Agent executes:
# ✓ Git revert a3f8d2c
# ✓ Push to origin
# ✓ Trigger ArgoCD sync
# ✓ Monitor pod rollout
# ✓ Check health endpoints
# ✓ Verify error rate drops

# Agent reports:
# ✓ Rollback complete (2m 34s)
# ✓ Error rate: 0.1% (normal)
# ✓ All pods healthy
# ✓ Incident auto-resolved

# 4. Agent generates incident report (automatic)
# Creates: docs/incidents/2025-01-18-auth-service.md
# Includes:
# - Timeline of events
# - Root cause analysis prompt
# - Links to commits involved
# - Monitoring graphs
# - Rollback procedure used
```

**Result:**
- 5 minutes total resolution time
- Low stress (agent guided entire process)
- Confidence in rollback target (historical data)
- Automatic incident documentation
- Team can focus on root cause analysis
- Learning captured for future

---

## Scenario 5: Friday Afternoon - Plan Next Week's Infrastructure Migration

**Context:** Migrating from self-hosted Redis to managed Redis (AWS ElastiCache). Affects 15 services across 3 environments.

### Without 12-Factor AgentOps

**Time:** 3-4 hours planning
**Completeness:** 70% (will discover missing pieces during execution)

```bash
# 1. Identify affected services (1 hour)
# Manually grep for Redis references
grep -r "redis" apps/
# Find ConfigMaps with Redis hosts
# Find deployments with Redis env vars
# Check Helm values files
# Make spreadsheet
# Probably miss 2-3 services

# 2. Plan migration steps (1.5 hours)
# Write migration doc manually
# List services (probably incomplete)
# Guess time estimates
# Think through dependencies
# Realize you don't know all dependencies
# Add "TBD" for unknowns

# 3. Create checklist (30 min)
# Write checklist in doc
# Hope you remember to check it during migration
# Forget to include rollback plan
# Forget to include validation steps

# 4. Share with team (30 min)
# Email doc
# Schedule meeting to discuss
# Answer questions
# Update doc
# Re-send email
```

**Result:**
- 4 hours planning
- Plan 70% complete (will iterate during execution)
- No confidence in time estimates
- Rollback plan missing
- Validation steps vague
- Team not fully aligned

### With 12-Factor AgentOps

**Time:** 30 minutes (comprehensive plan)
**Completeness:** 95% (agent finds all dependencies)

```bash
# 1. Use multi-agent orchestration (5 min)
/infrastructure-migrate

# Agent prompts:
"Migration type?" → Redis self-hosted to ElastiCache
"Affected clusters?" → dev, staging, prod
"Timeline?" → Next week (5 days)
"Rollback requirement?" → Yes, must be able to rollback within 10 min

# 2. Agent analyzes codebase (automatic, 2 min)
# Scans all apps/, overlays/, ArgoCD apps
# Identifies:
# - 15 services with Redis dependencies
# - 3 ConfigMaps with Redis connection strings
# - 2 Secrets with Redis passwords
# - 8 NetworkPolicies allowing Redis traffic
# - 1 ServiceMonitor for Redis metrics
# - 4 Grafana dashboards querying Redis
#
# Builds dependency graph:
# auth-service → redis (read/write)
# session-service → redis (read/write)
# cache-service → redis (read-only)
# ...

# 3. Agent generates migration plan (automatic, 3 min)
# Creates: docs/migrations/2025-01-redis-elasticache.md
#
# Phase 1: Preparation (Day 1)
# - Provision ElastiCache clusters (dev, staging, prod)
# - Update ConfigMaps with new endpoints (not applied yet)
# - Update NetworkPolicies to allow ElastiCache CIDRs
# - Test connectivity from one service (canary)
# - Validation: Can connect to ElastiCache from cluster
#
# Phase 2: Dev Migration (Day 2)
# - Apply updated ConfigMaps to dev
# - Restart services in dependency order:
#   1. cache-service (read-only, lowest risk)
#   2. session-service (stateful, medium risk)
#   3. auth-service (critical path, highest risk)
# - Validate each service before proceeding
# - Monitor error rates for 2 hours
# - Validation: All services healthy, no errors
#
# Phase 3: Staging Migration (Day 3)
# - Repeat Phase 2 for staging
# - Run load tests
# - Validate performance matches or exceeds current
# - Validation: Performance ≥ baseline
#
# Phase 4: Prod Migration (Day 4)
# - Repeat Phase 2 for prod during maintenance window
# - Blue/green approach: keep old Redis running
# - Monitor for 24 hours
# - Validation: Error rate < 0.1%, latency < baseline
#
# Phase 5: Cleanup (Day 5)
# - Decommission self-hosted Redis (if validation passed)
# - Remove old ConfigMaps
# - Update documentation
# - Remove Redis Kubernetes manifests
# - Archive incident response plan
#
# Rollback Plan:
# - ConfigMaps include both old and new endpoints
# - Environment variable switch: REDIS_ENDPOINT
# - Rollback time: <5 minutes (change ConfigMap, restart pods)
#
# Risk Mitigation:
# - Canary testing in dev first
# - Dependency-order restarts (low-risk to high-risk)
# - Blue/green keeps old Redis available
# - Monitoring dashboards ready
# - Incident response team on standby
#
# Estimated Time:
# - Phase 1: 2 hours
# - Phase 2: 1 hour
# - Phase 3: 1 hour
# - Phase 4: 2 hours (includes monitoring)
# - Phase 5: 1 hour
# Total: 7 hours active work over 5 days

# 4. Review and customize (10 min)
# Agent opened migration doc in editor
# Review plan
# Adjust maintenance window time
# Add team member assignments
# Confirm rollback plan meets requirements

# 5. Generate checklists (automatic)
# Agent creates checklist for each phase
# Includes validation steps
# Includes rollback triggers
# Includes communication templates

# 6. Share with team (5 min)
# Create PR with migration plan
# Agent auto-notifies affected service owners
# Team reviews, comments in PR
# Plan approved and merged
```

**Result:**
- 30 minutes total planning time
- 95% complete plan (agent found all dependencies)
- Confidence in time estimates (based on similar migrations)
- Rollback plan included
- Validation steps explicit
- Team aligned via PR review
- Ready to execute Monday morning

---

## Key Takeaways

### Time Savings
- **Creating infrastructure:** 4-6 hours → 20 minutes (12-18x faster)
- **Drift detection:** 2-3 hours → 10 minutes (12-18x faster)
- **Harmonizing configs:** 8 hours → 15 minutes (32x faster)
- **Incident rollback:** 30-45 min → 5 minutes (6-9x faster)
- **Migration planning:** 3-4 hours → 30 minutes (6-8x faster)

### Error Reduction
- **YAML syntax errors:** 30-40% → <5%
- **Missed resources:** 25% → 0%
- **Configuration drift:** Unknown → 100% visibility
- **Incomplete plans:** 30% gaps → 5% gaps

### Confidence & Stress
- **Validation coverage:** Ad-hoc → Automatic gates
- **Incident response:** High stress → Low stress (guided)
- **Knowledge preservation:** Lost when people leave → Captured in Git
- **Team alignment:** Email threads → PR reviews

### Institutional Memory
- **Every change documented** in semantic commits
- **Every decision explained** in commit messages
- **Every pattern captured** for reuse
- **Every failure analyzed** and prevented

---

## Next Steps

1. **Copy this example to your repo**
2. **Try one workflow this week** (start with `/validate-infra`)
3. **Track time saved** (before/after)
4. **Share results** with your team
5. **Customize agents** for your stack
6. **Build institutional memory** (commit context)

**Platform engineering is hard. 12-Factor AgentOps makes it manageable.**

Start small. Validate everything. Build confidence. Scale with agents.
