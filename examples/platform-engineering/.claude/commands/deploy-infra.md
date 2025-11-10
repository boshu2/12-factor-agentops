---
command: deploy-infra
category: platform-engineering
description: Deploy infrastructure to target environment with validation, preview, and rollback capability
version: 1.0.0
---

# /deploy-infra - Infrastructure Deployment Command

**Purpose:** Deploy infrastructure changes to target cluster with validation gates, preview, and automatic rollback on failure.

**Usage:**
```bash
/deploy-infra                           # Interactive mode (prompts for app/env)
/deploy-infra --app prometheus --env dev   # Deploy specific app to specific env
/deploy-infra --all --env dev              # Deploy all apps to specific env
/deploy-infra --auto-approve               # Skip confirmation (CI/CD use)
```

---

## What This Command Does

**Deployment workflow:**

1. **Validate** - Run `/validate-infra` checks
2. **Preview** - Show what will change (kubectl diff or ArgoCD diff)
3. **Confirm** - Require approval (unless `--auto-approve`)
4. **Deploy** - Apply changes (kubectl apply or ArgoCD sync)
5. **Monitor** - Watch pod rollout status
6. **Verify** - Check health endpoints, ready status
7. **Rollback** - Auto-rollback if deployment fails

**Exit codes:**
- `0` - Deployment successful
- `1` - Validation failed (blocked deployment)
- `2` - Deployment failed (rollback attempted)
- `3` - Rollback failed (manual intervention required)

---

## Command Implementation

```bash
#!/bin/bash
# /deploy-infra implementation

set -e

# Parse arguments
APP=""
ENV=""
DEPLOY_ALL=false
AUTO_APPROVE=false
DEPLOYMENT_METHOD="argocd"  # or "kubectl"

while [[ $# -gt 0 ]]; do
  case $1 in
    --app)
      APP="$2"
      shift 2
      ;;
    --env)
      ENV="$2"
      shift 2
      ;;
    --all)
      DEPLOY_ALL=true
      shift
      ;;
    --auto-approve)
      AUTO_APPROVE=true
      shift
      ;;
    --method)
      DEPLOYMENT_METHOD="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: /deploy-infra [--app <name>] [--env <name>] [--all] [--auto-approve] [--method argocd|kubectl]"
      exit 1
      ;;
  esac
done

# Interactive mode if app/env not provided
if [ -z "${APP}" ] && [ "${DEPLOY_ALL}" == "false" ]; then
  echo "Select application to deploy:"
  select APP in $(find apps/ -maxdepth 1 -mindepth 1 -type d -exec basename {} \;); do
    break
  done
fi

if [ -z "${ENV}" ]; then
  echo "Select environment:"
  select ENV in $(find apps/*/overlays/ -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort -u); do
    break
  done
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Infrastructure Deployment"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Application: ${APP}"
echo "Environment: ${ENV}"
echo "Method: ${DEPLOYMENT_METHOD}"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Step 1: Validation
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 1: Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

/validate-infra --app ${APP} --env ${ENV}

if [ $? -ne 0 ]; then
  echo ""
  echo "❌ Validation failed. Deployment blocked."
  exit 1
fi

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Step 2: Preview Changes
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 2: Preview Changes"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "${DEPLOYMENT_METHOD}" == "argocd" ]; then
  # ArgoCD diff
  ARGOCD_APP="${APP}-${ENV}"

  echo "ArgoCD application: ${ARGOCD_APP}"
  echo ""

  argocd app diff ${ARGOCD_APP} || true

  # Get sync status
  SYNC_STATUS=$(argocd app get ${ARGOCD_APP} -o json | jq -r '.status.sync.status')
  HEALTH_STATUS=$(argocd app get ${ARGOCD_APP} -o json | jq -r '.status.health.status')

  echo ""
  echo "Current status:"
  echo "  Sync: ${SYNC_STATUS}"
  echo "  Health: ${HEALTH_STATUS}"
  echo ""

else
  # kubectl diff
  OVERLAY_DIR="apps/${APP}/overlays/${ENV}"

  kustomize build ${OVERLAY_DIR} > /tmp/${APP}-${ENV}.yaml

  echo "kubectl diff preview:"
  echo ""

  kubectl --context ${ENV} diff -f /tmp/${APP}-${ENV}.yaml || true
  echo ""
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Step 3: Confirm Deployment
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [ "${AUTO_APPROVE}" == "false" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Step 3: Confirm Deployment"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "Proceed with deployment? [y/N]"
  read CONFIRM

  if [ "${CONFIRM}" != "y" ] && [ "${CONFIRM}" != "Y" ]; then
    echo "Deployment cancelled."
    exit 0
  fi
  echo ""
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Step 4: Deploy
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 4: Deploy"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Save current state for rollback
if [ "${DEPLOYMENT_METHOD}" == "argocd" ]; then
  PREVIOUS_REVISION=$(argocd app get ${ARGOCD_APP} -o json | jq -r '.status.sync.revision')
  echo "Current revision: ${PREVIOUS_REVISION}"
  echo ""
fi

# Execute deployment
DEPLOYMENT_START=$(date +%s)

if [ "${DEPLOYMENT_METHOD}" == "argocd" ]; then
  echo "Syncing ArgoCD application..."
  argocd app sync ${ARGOCD_APP} --prune --timeout 600

  if [ $? -ne 0 ]; then
    echo "❌ ArgoCD sync failed"
    trigger_rollback
    exit 2
  fi

else
  echo "Applying with kubectl..."
  kubectl --context ${ENV} apply -f /tmp/${APP}-${ENV}.yaml

  if [ $? -ne 0 ]; then
    echo "❌ kubectl apply failed"
    trigger_rollback
    exit 2
  fi
fi

DEPLOYMENT_END=$(date +%s)
DEPLOYMENT_DURATION=$((DEPLOYMENT_END - DEPLOYMENT_START))

echo "✓ Deployment completed in ${DEPLOYMENT_DURATION} seconds"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Step 5: Monitor Rollout
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 5: Monitor Rollout"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get namespace
NAMESPACE=$(kustomize build apps/${APP}/overlays/${ENV} | yq eval 'select(.kind == "Namespace") | .metadata.name' - | head -1)
if [ -z "${NAMESPACE}" ]; then
  NAMESPACE=$(grep "namespace:" apps/${APP}/overlays/${ENV}/kustomization.yaml | awk '{print $2}')
fi

echo "Watching deployments in namespace: ${NAMESPACE}"
echo ""

# Wait for rollout to complete
DEPLOYMENTS=$(kubectl --context ${ENV} -n ${NAMESPACE} get deployments -l app.kubernetes.io/name=${APP} -o name)

for DEPLOYMENT in ${DEPLOYMENTS}; do
  echo "Waiting for ${DEPLOYMENT}..."
  kubectl --context ${ENV} -n ${NAMESPACE} rollout status ${DEPLOYMENT} --timeout=5m

  if [ $? -ne 0 ]; then
    echo "❌ Rollout failed: ${DEPLOYMENT}"
    trigger_rollback
    exit 2
  fi

  echo "✓ ${DEPLOYMENT} rolled out successfully"
done

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Step 6: Health Checks
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Step 6: Health Checks"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Wait for all pods to be ready
echo "Checking pod status..."
PODS=$(kubectl --context ${ENV} -n ${NAMESPACE} get pods -l app.kubernetes.io/name=${APP} -o name)

for POD in ${PODS}; do
  echo -n "  ${POD}... "

  # Wait up to 2 minutes for pod to be ready
  kubectl --context ${ENV} -n ${NAMESPACE} wait ${POD} --for=condition=Ready --timeout=2m > /dev/null 2>&1

  if [ $? -ne 0 ]; then
    echo "❌ NOT READY"

    # Show pod events for debugging
    kubectl --context ${ENV} -n ${NAMESPACE} describe ${POD} | tail -20

    trigger_rollback
    exit 2
  fi

  echo "✓ READY"
done

echo ""

# Check health endpoints (if defined)
if [ "${DEPLOYMENT_METHOD}" == "argocd" ]; then
  HEALTH_STATUS=$(argocd app get ${ARGOCD_APP} -o json | jq -r '.status.health.status')

  if [ "${HEALTH_STATUS}" != "Healthy" ]; then
    echo "⚠️  ArgoCD health status: ${HEALTH_STATUS}"
    echo "Application deployed but not healthy. Review manually."
  else
    echo "✓ ArgoCD health status: Healthy"
  fi
fi

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Success Summary
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Deployment Successful!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Application: ${APP}"
echo "Environment: ${ENV}"
echo "Duration: ${DEPLOYMENT_DURATION} seconds"
echo ""
echo "Next steps:"
echo "  1. Monitor application: kubectl -n ${NAMESPACE} get pods -w"
echo "  2. Check logs: kubectl -n ${NAMESPACE} logs -l app.kubernetes.io/name=${APP}"
echo "  3. Verify metrics: (check Grafana/Prometheus)"
echo ""

exit 0

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Rollback Function
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

trigger_rollback() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Deployment Failed - Triggering Rollback"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  if [ "${DEPLOYMENT_METHOD}" == "argocd" ]; then
    # Rollback ArgoCD app to previous revision
    if [ -n "${PREVIOUS_REVISION}" ]; then
      echo "Rolling back to revision: ${PREVIOUS_REVISION}"
      argocd app rollback ${ARGOCD_APP} ${PREVIOUS_REVISION}

      if [ $? -ne 0 ]; then
        echo "❌ Rollback failed! Manual intervention required."
        exit 3
      fi

      echo "✓ Rollback successful"
    else
      echo "❌ No previous revision found. Manual rollback required."
      exit 3
    fi

  else
    # kubectl rollback
    for DEPLOYMENT in ${DEPLOYMENTS}; do
      echo "Rolling back ${DEPLOYMENT}..."
      kubectl --context ${ENV} -n ${NAMESPACE} rollout undo ${DEPLOYMENT}

      if [ $? -ne 0 ]; then
        echo "❌ Rollback failed: ${DEPLOYMENT}"
        exit 3
      fi

      echo "✓ ${DEPLOYMENT} rolled back"
    done
  fi

  echo ""
  echo "✓ Rollback completed successfully"
  echo "Application reverted to previous working state"
  echo ""
}
```

---

## Deployment Strategies

### Blue/Green Deployment

```bash
# Deploy to "green" environment first
/deploy-infra --app myapp --env staging-green

# Verify green environment
# ... run tests, check metrics ...

# Switch traffic to green (update Service selector)
kubectl patch service myapp -n staging -p '{"spec":{"selector":{"version":"green"}}}'

# Keep blue environment running for quick rollback
```

### Canary Deployment

```bash
# Deploy canary (10% traffic)
/deploy-infra --app myapp --env prod --canary

# Monitor for 1 hour
# ... check error rates, latency ...

# If successful, deploy to 100%
/deploy-infra --app myapp --env prod --promote-canary
```

### Rolling Deployment (Default)

```bash
# Standard rolling deployment
/deploy-infra --app myapp --env prod

# Kubernetes gradually replaces pods
# Old version → New version
# Zero downtime (if readiness probes configured)
```

---

## Integration with CI/CD

**GitLab CI:**

```yaml
deploy-dev:
  stage: deploy
  script:
    - /deploy-infra --app ${APP_NAME} --env dev --auto-approve
  only:
    - main
  environment:
    name: dev

deploy-staging:
  stage: deploy
  script:
    - /deploy-infra --app ${APP_NAME} --env staging --auto-approve
  only:
    - main
  environment:
    name: staging
  when: manual

deploy-prod:
  stage: deploy
  script:
    - /deploy-infra --app ${APP_NAME} --env prod --auto-approve
  only:
    - main
  environment:
    name: prod
  when: manual
  allow_failure: false
```

**GitHub Actions:**

```yaml
name: Deploy to Production
on:
  workflow_dispatch:
    inputs:
      app:
        description: 'Application to deploy'
        required: true
      environment:
        description: 'Environment (dev/staging/prod)'
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy
        run: /deploy-infra --app ${{ github.event.inputs.app }} --env ${{ github.event.inputs.environment }} --auto-approve
```

---

## Monitoring & Observability

**Deployment metrics to track:**

```promql
# Deployment duration
deployment_duration_seconds{app="${APP}",environment="${ENV}"}

# Deployment success rate
rate(deployment_success_total{app="${APP}"}[1h])

# Rollback rate
rate(deployment_rollback_total{app="${APP}"}[1h])

# Time to deploy (commit to production)
deployment_lead_time_seconds{app="${APP}"}
```

**Export metrics:**

```bash
# At end of deployment, export to Prometheus
cat >> /var/lib/prometheus/deployment_metrics.prom << EOF
deployment_duration_seconds{app="${APP}",environment="${ENV}"} ${DEPLOYMENT_DURATION}
deployment_success_total{app="${APP}",environment="${ENV}"} 1
deployment_timestamp{app="${APP}",environment="${ENV}"} $(date +%s)
EOF
```

---

## Common Deployment Failures & Solutions

### Issue 1: ImagePullBackOff

**Symptom:** Pods stuck in ImagePullBackOff

**Cause:** Image doesn't exist or registry authentication failed

**Solution:**
```bash
# Verify image exists
docker pull ${IMAGE_NAME}:${IMAGE_TAG}

# Check imagePullSecrets
kubectl get secret -n ${NAMESPACE} registry-credentials

# If missing, create secret
kubectl create secret docker-registry registry-credentials \
  --docker-server=registry.example.com \
  --docker-username=${USERNAME} \
  --docker-password=${PASSWORD} \
  -n ${NAMESPACE}
```

### Issue 2: CrashLoopBackOff

**Symptom:** Pods continuously restarting

**Cause:** Application failing to start (config error, missing dependency, etc.)

**Solution:**
```bash
# Check pod logs
kubectl logs -n ${NAMESPACE} ${POD_NAME}

# Check events
kubectl describe pod -n ${NAMESPACE} ${POD_NAME}

# Common fixes:
# - Missing ConfigMap/Secret
# - Wrong environment variables
# - Database connection failed
# - Port already in use
```

### Issue 3: Readiness Probe Failing

**Symptom:** Pods running but not marked Ready

**Cause:** Readiness probe endpoint failing

**Solution:**
```bash
# Check readiness probe endpoint manually
kubectl exec -n ${NAMESPACE} ${POD_NAME} -- curl localhost:8080/ready

# Increase initialDelaySeconds if app needs more startup time
# Edit deployment:
spec:
  template:
    spec:
      containers:
      - name: app
        readinessProbe:
          initialDelaySeconds: 60  # Increased from 30
```

### Issue 4: Insufficient Resources

**Symptom:** Pods stuck in Pending state

**Cause:** Cluster doesn't have enough CPU/memory

**Solution:**
```bash
# Check node resources
kubectl top nodes

# Check pod resource requests
kubectl get pod -n ${NAMESPACE} ${POD_NAME} -o yaml | grep -A 5 "resources:"

# Options:
# 1. Reduce resource requests
# 2. Scale cluster (add nodes)
# 3. Remove unused workloads
```

---

## Best Practices

### 1. Always Deploy to Dev First

```bash
# Deploy to dev
/deploy-infra --app myapp --env dev

# Test in dev for 24 hours

# Deploy to staging
/deploy-infra --app myapp --env staging

# Run load tests

# Deploy to prod
/deploy-infra --app myapp --env prod
```

### 2. Use Deployment Windows

```bash
# Prod deployments during maintenance windows only
# Example: Tuesdays/Thursdays 2-4pm PST
if [ "$(date +%u)" != "2" ] && [ "$(date +%u)" != "4" ]; then
  echo "❌ Prod deployments only on Tue/Thu"
  exit 1
fi

HOUR=$(date +%H)
if [ ${HOUR} -lt 14 ] || [ ${HOUR} -ge 16 ]; then
  echo "❌ Prod deployments only during 2-4pm PST"
  exit 1
fi
```

### 3. Monitor After Deployment

```bash
# Deploy
/deploy-infra --app myapp --env prod

# Monitor for 1 hour
watch -n 60 'kubectl top pods -n ${NAMESPACE} -l app=${APP}'

# Check error rates
curl -s "http://prometheus:9090/api/v1/query?query=rate(http_requests_total{app=\"${APP}\",status=~\"5..\"}[5m])"
```

---

## Related Commands

- **/validate-infra** - Validation (run before deploy)
- **/infrastructure-drift** - Detect drift post-deployment
- **/infrastructure-rollback** - Manual rollback if needed

---

## References

- [12-Factor AgentOps: Factor IV (Validation Gates)](../../../factors/04-validation-gates.md)
- [12-Factor AgentOps: Factor VIII (Autonomous Error Recovery)](../../../factors/08-autonomous-error-recovery.md)
- [Kubernetes Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [ArgoCD Sync Strategies](https://argo-cd.readthedocs.io/en/stable/user-guide/sync-options/)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15

**Deploy with confidence. Validate, preview, monitor, and rollback automatically.**
