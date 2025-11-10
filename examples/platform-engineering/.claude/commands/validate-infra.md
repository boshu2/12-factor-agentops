---
command: validate-infra
category: platform-engineering
description: Quick validation of infrastructure manifests - Kustomize builds, YAML syntax, required labels, cluster prerequisites
version: 1.0.0
---

# /validate-infra - Infrastructure Validation Command

**Purpose:** Run comprehensive validation checks on infrastructure manifests before committing changes.

**Usage:**
```bash
/validate-infra                    # Validate all apps in current directory
/validate-infra --app prometheus   # Validate specific app
/validate-infra --env prod         # Validate specific environment
/validate-infra --quick            # Fast validation (skip cluster checks)
```

---

## What This Command Does

**Validation gates (in order):**

1. **Kustomize Build** - Verify all overlays build successfully
2. **YAML Syntax** - Validate Kubernetes resource syntax
3. **Required Labels** - Check all resources have mandatory labels
4. **Resource Limits** - Ensure containers define resource requests/limits
5. **Cluster Prerequisites** - Verify StorageClasses, CRDs exist
6. **ArgoCD Applications** - Validate ArgoCD app manifests reference correct paths

**Exit codes:**
- `0` - All validations passed
- `1` - Validation failed (see output for details)

---

## Command Implementation

```bash
#!/bin/bash
# /validate-infra implementation

set -e

# Parse arguments
APP_FILTER=""
ENV_FILTER=""
QUICK_MODE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --app)
      APP_FILTER="$2"
      shift 2
      ;;
    --env)
      ENV_FILTER="$2"
      shift 2
      ;;
    --quick)
      QUICK_MODE=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: /validate-infra [--app <name>] [--env <name>] [--quick]"
      exit 1
      ;;
  esac
done

# Determine apps to validate
if [ -n "${APP_FILTER}" ]; then
  APPS=("${APP_FILTER}")
else
  APPS=($(find apps/ -maxdepth 1 -mindepth 1 -type d -exec basename {} \;))
fi

# Determine environments to validate
if [ -n "${ENV_FILTER}" ]; then
  ENVIRONMENTS=("${ENV_FILTER}")
else
  ENVIRONMENTS=($(find apps/*/overlays/ -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort -u))
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Infrastructure Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Apps: ${APPS[@]}"
echo "Environments: ${ENVIRONMENTS[@]}"
echo ""

VALIDATION_FAILED=0

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gate 1: Kustomize Build
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Gate 1: Kustomize Build Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    OVERLAY_DIR="apps/${APP}/overlays/${ENV}"

    if [ ! -d "${OVERLAY_DIR}" ]; then
      continue
    fi

    echo -n "Validating ${APP}/${ENV}... "

    kustomize build ${OVERLAY_DIR} > /tmp/${APP}-${ENV}.yaml 2>&1
    if [ $? -ne 0 ]; then
      echo "❌ FAILED"
      cat /tmp/${APP}-${ENV}.yaml
      VALIDATION_FAILED=1
    else
      echo "✓ OK"
    fi
  done
done

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gate 2: YAML Syntax Validation
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Gate 2: YAML Syntax Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    if [ ! -f "/tmp/${APP}-${ENV}.yaml" ]; then
      continue
    fi

    echo -n "Validating ${APP}/${ENV}... "

    kubectl apply --dry-run=client -f /tmp/${APP}-${ENV}.yaml > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "❌ FAILED"
      kubectl apply --dry-run=client -f /tmp/${APP}-${ENV}.yaml
      VALIDATION_FAILED=1
    else
      echo "✓ OK"
    fi
  done
done

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gate 3: Required Labels
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Gate 3: Required Labels Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

REQUIRED_LABELS=(
  "app.kubernetes.io/name"
  "app.kubernetes.io/managed-by"
)

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    if [ ! -f "/tmp/${APP}-${ENV}.yaml" ]; then
      continue
    fi

    echo -n "Validating ${APP}/${ENV}... "

    MISSING_LABELS=()
    for LABEL in "${REQUIRED_LABELS[@]}"; do
      COUNT=$(grep -c "${LABEL}:" /tmp/${APP}-${ENV}.yaml || true)
      if [ ${COUNT} -eq 0 ]; then
        MISSING_LABELS+=("${LABEL}")
      fi
    done

    if [ ${#MISSING_LABELS[@]} -gt 0 ]; then
      echo "❌ MISSING LABELS: ${MISSING_LABELS[@]}"
      VALIDATION_FAILED=1
    else
      echo "✓ OK"
    fi
  done
done

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gate 4: Resource Limits
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Gate 4: Resource Limits Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    if [ ! -f "/tmp/${APP}-${ENV}.yaml" ]; then
      continue
    fi

    echo -n "Validating ${APP}/${ENV}... "

    # Check that all containers define resource requests and limits
    CONTAINERS=$(yq eval '.spec.template.spec.containers[] | .name' /tmp/${APP}-${ENV}.yaml 2>/dev/null || true)

    MISSING_RESOURCES=false
    for CONTAINER in ${CONTAINERS}; do
      HAS_REQUESTS=$(yq eval ".spec.template.spec.containers[] | select(.name == \"${CONTAINER}\") | .resources.requests" /tmp/${APP}-${ENV}.yaml 2>/dev/null || true)
      HAS_LIMITS=$(yq eval ".spec.template.spec.containers[] | select(.name == \"${CONTAINER}\") | .resources.limits" /tmp/${APP}-${ENV}.yaml 2>/dev/null || true)

      if [ -z "${HAS_REQUESTS}" ] || [ "${HAS_REQUESTS}" == "null" ]; then
        MISSING_RESOURCES=true
      fi
      if [ -z "${HAS_LIMITS}" ] || [ "${HAS_LIMITS}" == "null" ]; then
        MISSING_RESOURCES=true
      fi
    done

    if [ "${MISSING_RESOURCES}" == "true" ]; then
      echo "⚠️  MISSING RESOURCE REQUESTS/LIMITS"
      # Warning only, don't fail validation
    else
      echo "✓ OK"
    fi
  done
done

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gate 5: Cluster Prerequisites (skip if --quick)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [ "${QUICK_MODE}" == "false" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Gate 5: Cluster Prerequisites Validation"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  for ENV in "${ENVIRONMENTS[@]}"; do
    echo "Checking cluster: ${ENV}"

    # Verify cluster context exists
    kubectl --context ${ENV} cluster-info > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "  ⚠️  Cluster context '${ENV}' not found in kubeconfig (skipping)"
      continue
    fi

    # Check for StorageClasses referenced in PVCs
    for APP in "${APPS[@]}"; do
      if [ ! -f "/tmp/${APP}-${ENV}.yaml" ]; then
        continue
      fi

      STORAGE_CLASSES=$(yq eval 'select(.kind == "PersistentVolumeClaim") | .spec.storageClassName' /tmp/${APP}-${ENV}.yaml 2>/dev/null | grep -v "null" || true)

      for SC in ${STORAGE_CLASSES}; do
        kubectl --context ${ENV} get storageclass ${SC} > /dev/null 2>&1
        if [ $? -ne 0 ]; then
          echo "  ❌ ${APP}: StorageClass '${SC}' not found in cluster"
          VALIDATION_FAILED=1
        else
          echo "  ✓ ${APP}: StorageClass '${SC}' exists"
        fi
      done
    done

    # Check for CRDs (ServiceMonitor, etc.)
    for APP in "${APPS[@]}"; do
      if [ ! -f "/tmp/${APP}-${ENV}.yaml" ]; then
        continue
      fi

      # Check for ServiceMonitor CRD
      HAS_SERVICE_MONITOR=$(grep "kind: ServiceMonitor" /tmp/${APP}-${ENV}.yaml || true)
      if [ -n "${HAS_SERVICE_MONITOR}" ]; then
        kubectl --context ${ENV} get crd servicemonitors.monitoring.coreos.com > /dev/null 2>&1
        if [ $? -ne 0 ]; then
          echo "  ❌ ${APP}: ServiceMonitor CRD not found (Prometheus Operator not installed?)"
          VALIDATION_FAILED=1
        else
          echo "  ✓ ${APP}: ServiceMonitor CRD exists"
        fi
      fi
    done

    echo ""
  done
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gate 6: ArgoCD Applications
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

if [ -d "argocd/" ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Gate 6: ArgoCD Application Validation"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  ARGOCD_APPS=$(find argocd/ -name "*.yaml" -o -name "*.yml")

  for ARGOCD_APP in ${ARGOCD_APPS}; do
    echo -n "Validating $(basename ${ARGOCD_APP})... "

    # Validate YAML syntax
    kubectl apply --dry-run=client -f ${ARGOCD_APP} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "❌ INVALID YAML"
      kubectl apply --dry-run=client -f ${ARGOCD_APP}
      VALIDATION_FAILED=1
      continue
    fi

    # Validate path exists
    APP_PATH=$(yq eval '.spec.source.path' ${ARGOCD_APP})
    if [ ! -d "${APP_PATH}" ]; then
      echo "❌ PATH NOT FOUND: ${APP_PATH}"
      VALIDATION_FAILED=1
      continue
    fi

    echo "✓ OK"
  done

  echo ""
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Summary
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ ${VALIDATION_FAILED} -eq 0 ]; then
  echo "✓ All validations passed!"
  echo ""
  echo "Ready to commit:"
  echo "  git add apps/ argocd/"
  echo "  git commit"
  echo ""
  exit 0
else
  echo "❌ Validation failed!"
  echo ""
  echo "Fix errors above and re-run validation."
  echo ""
  exit 1
fi
```

---

## Integration with Git Hooks

**Pre-commit hook:**

```bash
# .git/hooks/pre-commit
#!/bin/bash

# Run validation before allowing commit
/validate-infra --quick

if [ $? -ne 0 ]; then
  echo ""
  echo "❌ Pre-commit validation failed"
  echo "Fix errors and try again, or use 'git commit --no-verify' to skip (not recommended)"
  exit 1
fi
```

---

## CI/CD Integration

**GitLab CI:**

```yaml
validate:
  stage: validate
  script:
    - /validate-infra
  only:
    - merge_requests
  allow_failure: false
```

**GitHub Actions:**

```yaml
name: Validate Infrastructure
on: [pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install kustomize
        run: |
          curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
          sudo mv kustomize /usr/local/bin/
      - name: Validate
        run: /validate-infra
```

---

## Related Commands

- **/deploy-infra** - Deploy infrastructure after validation
- **/infrastructure-create** - Create new infrastructure application
- **/infrastructure-drift** - Detect configuration drift

---

## References

- [12-Factor AgentOps: Factor IV (Validation Gates)](../../../factors/04-validation-gates.md)
- [Kustomize Documentation](https://kustomize.io/)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15

**Make validation fast, comprehensive, and impossible to skip. Use this command before every commit.**
