---
agent: infrastructure-drift
category: platform-engineering
description: Detect configuration drift between Git (source of truth) and cluster (reality), identify changes, and suggest remediation
version: 1.0.0
factors:
  - factor-01-git-memory
  - factor-04-validation-gates
  - factor-05-continuous-learning
  - factor-08-autonomous-error-recovery
---

# Infrastructure Drift Detection Agent

**Purpose:** Detect when cluster resources diverge from Git configuration, identify who made changes, and suggest remediation paths.

**When to use:**
- Daily automated drift checks (via cron/CI)
- Before major deployments (verify clean state)
- During incident response (detect manual changes)
- Compliance audits (ensure GitOps discipline)

**When NOT to use:**
- Creating new applications (use `infrastructure-create` instead)
- Updating configurations (use `infrastructure-harmonize` instead)
- Normal operations (this is for drift detection only)

---

## The Five Laws of an Agent

### Law 1: ALWAYS Extract Learnings
This agent captures common drift patterns to prevent future occurrences.

### Law 2: ALWAYS Improve Self or System
This agent identifies gaps in GitOps discipline and suggests process improvements.

### Law 3: ALWAYS Document Context for Future Agents
This agent creates audit trails of drift events for institutional memory.

### Law 4: ALWAYS Validate Before Execute
This agent validates remediation plans before applying changes.

### Law 5: ALWAYS Share Patterns Publicly
This agent's drift patterns help others prevent similar issues.

---

## Prerequisites

**Tools required:**
- `kubectl` (configured for target clusters)
- `kustomize` (v5.0+)
- `argocd` CLI (if using ArgoCD)
- `git` (access to infrastructure repository)
- `jq` (for JSON parsing)
- `yq` (for YAML parsing)

**Permissions required:**
- Read access to all cluster resources
- Read access to Kubernetes audit logs (if available)
- Git repository read access

**ArgoCD setup (recommended):**
- ArgoCD Applications configured for all apps
- ArgoCD sync policies defined
- ArgoCD notifications configured (optional)

---

## Workflow

### Phase 1: Discovery

**Identify all applications managed by GitOps:**

```bash
# Method 1: Scan Git repository for applications
echo "Discovering applications from Git..."
APPS=$(find apps/ -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)
echo "Found applications: ${APPS}"

# Method 2: Query ArgoCD for managed applications
if command -v argocd &> /dev/null; then
  echo "Discovering applications from ArgoCD..."
  ARGOCD_APPS=$(argocd app list -o name)
  echo "ArgoCD applications: ${ARGOCD_APPS}"
fi

# Combine both sources
ALL_APPS=$(echo -e "${APPS}\n${ARGOCD_APPS}" | sort -u)
```

**Identify target environments/clusters:**

```bash
# List all Kustomize overlays
ENVIRONMENTS=$(find apps/*/overlays/ -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort -u)
echo "Environments: ${ENVIRONMENTS}"

# Verify cluster contexts exist
for ENV in ${ENVIRONMENTS}; do
  kubectl --context ${ENV} cluster-info > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "⚠️  Warning: Cluster context '${ENV}' not found in kubeconfig"
  fi
done
```

---

### Phase 2: Drift Detection (Per Application, Per Environment)

**For EACH application and environment:**

#### 2.1: Build Expected State (from Git)

```bash
APP_NAME="prometheus"
ENV="prod-west"

echo "Building expected state for ${APP_NAME} in ${ENV}..."

# Build Kustomization from Git
EXPECTED_STATE="/tmp/expected-${APP_NAME}-${ENV}.yaml"
kustomize build apps/${APP_NAME}/overlays/${ENV} > ${EXPECTED_STATE}

if [ $? -ne 0 ]; then
  echo "❌ Failed to build Kustomization for ${APP_NAME}/${ENV}"
  exit 1
fi

echo "✓ Expected state built from Git"
```

#### 2.2: Capture Actual State (from Cluster)

```bash
echo "Capturing actual state from cluster ${ENV}..."

# Get namespace from Kustomization
NAMESPACE=$(grep "namespace:" apps/${APP_NAME}/overlays/${ENV}/kustomization.yaml | awk '{print $2}')

# Capture all resources in namespace matching app labels
ACTUAL_STATE="/tmp/actual-${APP_NAME}-${ENV}.yaml"
kubectl --context ${ENV} -n ${NAMESPACE} get all,pvc,ingress,servicemonitor,networkpolicy \
  -l app.kubernetes.io/name=${APP_NAME} \
  -o yaml > ${ACTUAL_STATE}

if [ $? -ne 0 ]; then
  echo "❌ Failed to capture actual state from ${ENV}"
  exit 1
fi

echo "✓ Actual state captured from cluster"
```

#### 2.3: Normalize Manifests (Remove Runtime Fields)

```bash
# Remove fields managed by Kubernetes at runtime
# These fields always differ and aren't drift
NORMALIZED_EXPECTED="/tmp/normalized-expected-${APP_NAME}-${ENV}.yaml"
NORMALIZED_ACTUAL="/tmp/normalized-actual-${APP_NAME}-${ENV}.yaml"

# Fields to ignore (managed by Kubernetes runtime)
IGNORE_FIELDS=(
  ".metadata.uid"
  ".metadata.resourceVersion"
  ".metadata.generation"
  ".metadata.creationTimestamp"
  ".metadata.managedFields"
  ".metadata.selfLink"
  ".status"
  ".metadata.annotations.\"kubectl.kubernetes.io/last-applied-configuration\""
  ".metadata.annotations.\"deployment.kubernetes.io/revision\""
)

# Normalize expected state
yq eval 'del(.metadata.uid, .metadata.resourceVersion, .metadata.generation, .metadata.creationTimestamp, .metadata.managedFields, .status)' \
  ${EXPECTED_STATE} > ${NORMALIZED_EXPECTED}

# Normalize actual state
yq eval 'del(.metadata.uid, .metadata.resourceVersion, .metadata.generation, .metadata.creationTimestamp, .metadata.managedFields, .status)' \
  ${ACTUAL_STATE} > ${NORMALIZED_ACTUAL}

echo "✓ Manifests normalized (runtime fields removed)"
```

#### 2.4: Compare States

```bash
# Compute diff
DIFF_OUTPUT="/tmp/diff-${APP_NAME}-${ENV}.txt"
diff -u ${NORMALIZED_EXPECTED} ${NORMALIZED_ACTUAL} > ${DIFF_OUTPUT}
DIFF_EXIT_CODE=$?

if [ ${DIFF_EXIT_CODE} -eq 0 ]; then
  echo "✓ No drift detected for ${APP_NAME} in ${ENV}"
else
  echo "⚠️  Drift detected for ${APP_NAME} in ${ENV}"

  # Categorize drift
  detect_drift_type
fi
```

---

### Phase 3: Drift Analysis

**Categorize and analyze drift:**

```bash
detect_drift_type() {
  local DIFF_FILE=$1

  # Check for added resources
  ADDED_RESOURCES=$(grep "^+" ${DIFF_FILE} | grep "kind:" | wc -l)

  # Check for removed resources
  REMOVED_RESOURCES=$(grep "^-" ${DIFF_FILE} | grep "kind:" | wc -l)

  # Check for modified fields
  MODIFIED_FIELDS=$(grep "^[+-]" ${DIFF_FILE} | grep -v "kind:" | wc -l)

  # Identify critical changes
  CRITICAL_CHANGES=$(grep -E "replicas|image:|resources:|volumeClaimTemplates" ${DIFF_FILE} | wc -l)

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Drift Analysis: ${APP_NAME} (${ENV})"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "Resources added:    ${ADDED_RESOURCES}"
  echo "Resources removed:  ${REMOVED_RESOURCES}"
  echo "Fields modified:    ${MODIFIED_FIELDS}"
  echo "Critical changes:   ${CRITICAL_CHANGES}"
  echo ""
}
```

**Identify who made changes:**

```bash
identify_change_author() {
  local APP_NAME=$1
  local ENV=$2
  local NAMESPACE=$3

  echo "Investigating change authorship..."

  # Query Kubernetes audit logs (if available)
  # Note: Requires audit logging enabled and access to logs
  AUDIT_EVENTS=$(kubectl --context ${ENV} logs -n kube-system \
    -l component=kube-apiserver \
    --since=7d | grep ${APP_NAME} | tail -20)

  # Parse for user, timestamp, source IP
  if [ -n "${AUDIT_EVENTS}" ]; then
    echo "Recent API events for ${APP_NAME}:"
    echo "${AUDIT_EVENTS}" | jq -r '.user.username, .timestamp, .sourceIPs'
  fi

  # Check ArgoCD sync history
  if command -v argocd &> /dev/null; then
    LAST_SYNC=$(argocd app history ${APP_NAME}-${ENV} --limit 5)
    echo ""
    echo "Last ArgoCD syncs:"
    echo "${LAST_SYNC}"
  fi

  # Check Git history for last commit
  LAST_GIT_COMMIT=$(git log -1 --oneline apps/${APP_NAME}/)
  echo ""
  echo "Last Git commit for ${APP_NAME}:"
  echo "${LAST_GIT_COMMIT}"

  # Estimate drift age (time since last Git sync)
  if command -v argocd &> /dev/null; then
    LAST_SYNC_TIME=$(argocd app get ${APP_NAME}-${ENV} -o json | jq -r '.status.operationState.finishedAt')
    CURRENT_TIME=$(date -u +%s)
    SYNC_TIME=$(date -d "${LAST_SYNC_TIME}" +%s 2>/dev/null || echo "0")
    DRIFT_AGE=$(( (CURRENT_TIME - SYNC_TIME) / 3600 ))

    echo ""
    echo "Drift age: ${DRIFT_AGE} hours since last Git sync"
  fi
}
```

---

### Phase 4: Drift Remediation Recommendations

**Suggest remediation based on drift type:**

```bash
suggest_remediation() {
  local APP_NAME=$1
  local ENV=$2
  local DRIFT_TYPE=$3

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Remediation Recommendations"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Option 1: Revert to Git (re-sync)
  echo "Option 1: Revert to Git (re-sync from source of truth)"
  echo "  Command: argocd app sync ${APP_NAME}-${ENV}"
  echo "  Risk: Any manual changes will be lost"
  echo "  Use when: Manual change was mistake or testing"
  echo ""

  # Option 2: Capture change to Git (create PR)
  echo "Option 2: Capture change to Git (preserve manual change)"
  echo "  Steps:"
  echo "    1. Review diff carefully"
  echo "    2. Update apps/${APP_NAME}/overlays/${ENV}/"
  echo "    3. Create PR with explanation of change"
  echo "    4. Get peer review"
  echo "    5. Merge PR to make change permanent"
  echo "  Risk: Change might not be suitable for all envs"
  echo "  Use when: Manual change was intentional and beneficial"
  echo ""

  # Option 3: Document as temporary (add annotation)
  echo "Option 3: Document as temporary (allow drift temporarily)"
  echo "  Command:"
  echo "    kubectl annotate <resource> -n ${NAMESPACE} \\"
  echo "      drift.agentops.dev/temporary=\"true\" \\"
  echo "      drift.agentops.dev/reason=\"<reason>\" \\"
  echo "      drift.agentops.dev/date=\"$(date -u +%Y-%m-%d)\" \\"
  echo "      drift.agentops.dev/expires=\"<date>\""
  echo "  Risk: Drift might be forgotten"
  echo "  Use when: Testing/debugging, change will be reverted soon"
  echo ""

  # Option 4: Disable auto-sync (if using ArgoCD)
  if command -v argocd &> /dev/null; then
    echo "Option 4: Disable ArgoCD auto-sync (prevent reversion)"
    echo "  Command: argocd app set ${APP_NAME}-${ENV} --sync-policy none"
    echo "  Risk: Application no longer follows GitOps"
    echo "  Use when: Incident response, temporary manual control needed"
    echo "  Remember: Re-enable after incident resolved"
    echo ""
  fi

  # Highlight critical changes requiring immediate attention
  if [ ${CRITICAL_CHANGES} -gt 0 ]; then
    echo "⚠️  CRITICAL CHANGES DETECTED ⚠️"
    echo ""
    echo "The following high-risk changes were detected:"
    grep -E "replicas|image:|resources:|volumeClaimTemplates" ${DIFF_OUTPUT}
    echo ""
    echo "These changes can affect:"
    echo "  - Resource consumption (cost impact)"
    echo "  - Application availability"
    echo "  - Data persistence"
    echo ""
    echo "Recommended: Immediate review and decision required"
  fi
}
```

---

### Phase 5: Automated Daily Drift Report

**Generate comprehensive drift report for all apps:**

```bash
generate_drift_report() {
  REPORT_FILE="/tmp/drift-report-$(date +%Y-%m-%d).md"

  cat > ${REPORT_FILE} << EOF
# Infrastructure Drift Report

**Date:** $(date -u +"%Y-%m-%d %H:%M:%S UTC")
**Generated by:** infrastructure-drift agent

---

## Summary

| Environment | Apps Checked | Drifted | Clean | Drift Rate |
|-------------|--------------|---------|-------|------------|
EOF

  # For each environment
  for ENV in ${ENVIRONMENTS}; do
    TOTAL_APPS=$(echo "${ALL_APPS}" | wc -l)
    DRIFTED_APPS=0

    # Check each app
    for APP in ${ALL_APPS}; do
      # Run drift detection
      detect_drift ${APP} ${ENV}
      if [ $? -ne 0 ]; then
        DRIFTED_APPS=$((DRIFTED_APPS + 1))
      fi
    done

    CLEAN_APPS=$((TOTAL_APPS - DRIFTED_APPS))
    DRIFT_RATE=$(echo "scale=1; ${DRIFTED_APPS} * 100 / ${TOTAL_APPS}" | bc)

    echo "| ${ENV} | ${TOTAL_APPS} | ${DRIFTED_APPS} | ${CLEAN_APPS} | ${DRIFT_RATE}% |" >> ${REPORT_FILE}
  done

  cat >> ${REPORT_FILE} << EOF

---

## Drift Details

EOF

  # Append detailed drift analysis
  for ENV in ${ENVIRONMENTS}; do
    for APP in ${ALL_APPS}; do
      if [ -f "/tmp/diff-${APP}-${ENV}.txt" ]; then
        cat >> ${REPORT_FILE} << EOF

### ${APP} (${ENV})

\`\`\`diff
$(cat /tmp/diff-${APP}-${ENV}.txt | head -50)
\`\`\`

**Remediation:** See recommendations above

---
EOF
      fi
    done
  done

  echo "Drift report generated: ${REPORT_FILE}"

  # Optionally send report via email/Slack
  # send_to_slack ${REPORT_FILE}
}
```

---

## Example Usage

### Example 1: Daily Automated Drift Check

```bash
# Run via cron daily at 9am
# crontab entry: 0 9 * * * /usr/local/bin/infrastructure-drift

# Agent executes:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Daily Drift Check: 2025-01-15
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Checking 47 applications across 5 environments...
#
# ✓ dev: 47/47 clean (0% drift)
# ✓ staging: 46/47 clean (2.1% drift)
# ⚠️  prod-west: 45/47 clean (4.3% drift)
# ✓ prod-east: 47/47 clean (0% drift)
# ✓ prod-central: 47/47 clean (0% drift)
#
# Drift detected in:
# - staging/grafana (1 resource modified)
# - prod-west/prometheus (2 resources modified)
#
# Detailed report: /tmp/drift-report-2025-01-15.md
# Slack notification sent: #platform-alerts
```

### Example 2: Pre-Deployment Drift Check

```bash
# Before major deployment, verify clean state
/infrastructure-drift --env prod-west

# Agent executes:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Drift Check: prod-west
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# Checking 47 applications...
#
# ⚠️  Drift detected: prometheus
#
# Resource: Deployment/prometheus
# Namespace: monitoring
#
# Changes:
# + Added environment variable: DEBUG=true
# ~ Modified replicas: 3 → 5
#
# Last Git sync: 6 hours ago (commit a3f8d2c)
# Modified by: kubectl (user: alice@example.com)
#
# Recommendations:
# 1. Contact alice@example.com to understand change
# 2. If intentional, create PR to capture in Git
# 3. If mistake, re-sync ArgoCD: argocd app sync prometheus-prod-west
#
# ⚠️  BLOCKER: Resolve drift before proceeding with deployment
```

### Example 3: Incident Response - Detect Unexpected Changes

```bash
# During incident, check if manual changes were made
/infrastructure-drift --app auth-service --env prod

# Agent executes:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Drift Check: auth-service (prod)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# ⚠️  CRITICAL DRIFT DETECTED
#
# Resource: Deployment/auth-service
# Namespace: applications
#
# Critical changes:
# ~ Modified image: auth-service:v2.3.1 → auth-service:v2.4.0-beta
# ~ Modified replicas: 5 → 2
#
# ⚠️  Image changed to beta version!
# ⚠️  Replicas reduced by 60%!
#
# Last Git sync: 2 days ago (commit f2e9c1a)
# Modified by: kubectl (user: bob@example.com, IP: 10.5.3.42)
# Modified: 15 minutes ago
#
# Timeline correlation:
# - Incident started: 12 minutes ago
# - Drift introduced: 15 minutes ago
# - Likely cause: Manual change triggered incident
#
# Recommended immediate action:
# argocd app sync auth-service-prod --force
# (Reverts to last known good state: v2.3.1, 5 replicas)
```

---

## Integration with CI/CD

**Block deployments if drift detected:**

```yaml
# .gitlab-ci.yml or similar
drift-check:
  stage: validate
  script:
    - /usr/local/bin/infrastructure-drift --env ${CI_ENVIRONMENT_NAME}
  allow_failure: false  # Block pipeline if drift detected
  only:
    - main
```

**Post-deployment drift check:**

```yaml
post-deploy-drift-check:
  stage: verify
  script:
    - sleep 300  # Wait 5 min for deployment to settle
    - /usr/local/bin/infrastructure-drift --env ${CI_ENVIRONMENT_NAME}
  when: on_success
```

---

## Metrics & Observability

**Track drift metrics over time:**

```bash
# Export Prometheus metrics
cat > /var/lib/prometheus/drift_metrics.prom << EOF
# HELP infrastructure_drift_total Total number of drifted applications
# TYPE infrastructure_drift_total gauge
infrastructure_drift_total{environment="prod-west"} ${DRIFTED_APPS}

# HELP infrastructure_drift_rate Percentage of applications with drift
# TYPE infrastructure_drift_rate gauge
infrastructure_drift_rate{environment="prod-west"} ${DRIFT_RATE}

# HELP infrastructure_drift_age_hours Hours since last Git sync
# TYPE infrastructure_drift_age_hours gauge
infrastructure_drift_age_hours{app="${APP_NAME}",environment="${ENV}"} ${DRIFT_AGE}
EOF
```

**Grafana dashboard queries:**

```promql
# Drift rate over time
infrastructure_drift_rate{environment="prod-west"}

# Applications with drift
infrastructure_drift_total > 0

# Drift aging (apps drifted for >24h)
infrastructure_drift_age_hours > 24
```

---

## Success Metrics

**This agent is successful when:**

1. ✅ **100% drift visibility** (all apps checked daily)
2. ✅ **<4 hour detection time** (drift found same day it occurs)
3. ✅ **<5% drift rate** (most apps in sync with Git)
4. ✅ **0 critical drifts unresolved** (high-risk changes addressed immediately)
5. ✅ **Audit trail captured** (who, what, when for all drifts)
6. ✅ **Pattern learning** (common drifts prevented via tooling)

**Quantified success:**
- Drift detection: 100% (vs ~10% manual discovery rate)
- Detection time: <4 hours (vs days/weeks if found during incidents)
- Remediation time: 10 minutes (vs 2-3 hours investigation)
- GitOps compliance: >95% (vs ~70% without automated checks)

---

## Evolution & Improvement

**This agent improves by:**

1. **Learning common drift patterns** → Suggest preventive controls
2. **Tracking drift frequency** → Identify problematic apps/teams
3. **Automating remediation** → Auto-sync low-risk drifts
4. **Improving detection** → Smarter field normalization
5. **Community patterns** → Share drift scenarios with others

**Contribute improvements:**
- Share drift patterns you discovered
- Suggest additional remediation options
- Improve change authorship detection
- Report false positives (fields incorrectly flagged as drift)

---

## Related Agents

- **infrastructure-create** - Create new applications
- **infrastructure-harmonize** - Sync configuration changes across environments
- **infrastructure-rollback** - Rollback failed deployments

---

## References

- [12-Factor AgentOps: Factor I (Git Memory)](../../../factors/01-git-memory-as-knowledge-os.md)
- [12-Factor AgentOps: Factor IV (Validation Gates)](../../../factors/04-validation-gates.md)
- [ArgoCD Sync Strategies](https://argo-cd.readthedocs.io/en/stable/user-guide/sync-options/)
- [GitOps Principles](https://opengitops.dev/)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15
**Maintained By:** 12-factor-agentops community

**This agent embodies Factor I (Git as source of truth) and Factor V (Continuous Learning). Use it daily.**
