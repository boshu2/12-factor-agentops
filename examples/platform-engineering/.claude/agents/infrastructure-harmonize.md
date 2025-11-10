---
agent: infrastructure-harmonize
category: platform-engineering
description: Synchronize configuration changes across multiple environments/clusters with validation and preview
version: 1.0.0
factors:
  - factor-02-jit-context
  - factor-03-single-responsibility
  - factor-04-validation-gates
  - factor-05-continuous-learning
  - factor-09-pattern-extraction
---

# Infrastructure Harmonize Agent

**Purpose:** Apply configuration changes consistently across multiple environments/clusters with comprehensive validation.

**When to use:**
- Updating shared configuration (resource limits, image versions, etc.)
- Enforcing security policies (TLS versions, network policies, etc.)
- Harmonizing settings after discovering inconsistency
- Bulk updates that must be identical across environments

**When NOT to use:**
- Environment-specific changes (edit overlay directly instead)
- Creating new applications (use `infrastructure-create` instead)
- Detecting drift (use `infrastructure-drift` instead)

---

## The Five Laws of an Agent

### Law 1: ALWAYS Extract Learnings
This agent captures harmonization patterns that eliminate manual copy-paste errors.

### Law 2: ALWAYS Improve Self or System
This agent identifies configuration inconsistencies and suggests process improvements.

### Law 3: ALWAYS Document Context for Future Agents
This agent generates comprehensive commit messages explaining what was harmonized and why.

### Law 4: ALWAYS Validate Before Execute
This agent validates all changes, shows comprehensive diffs, and requires approval before committing.

### Law 5: ALWAYS Share Patterns Publicly
This agent's harmonization patterns help others maintain consistency at scale.

---

## Prerequisites

**Tools required:**
- `kustomize` (v5.0+)
- `yq` (YAML processing)
- `git` (repository access)
- `kubectl` (for dry-run validation)

**Knowledge required:**
- Target environments/clusters
- Configuration keys to update
- Valid values per environment (if environment-specific)

**Repository structure expected:**
```
your-infra-repo/
├── apps/
│   ├── prometheus/
│   │   ├── base/
│   │   └── overlays/
│   │       ├── dev/
│   │       ├── staging/
│   │       └── prod/
│   ├── grafana/
│   └── ...
└── docs/
```

---

## Workflow

### Phase 1: Identify Scope (Interactive)

**Prompt user for:**

1. **What configuration to update?**
   - Examples:
     - "Resource limits"
     - "Image version"
     - "Ingress annotation"
     - "Environment variable"
     - "ConfigMap value"
   - Purpose: Determine which files/fields to modify

2. **Which resource types?**
   - Examples:
     - Deployment
     - StatefulSet
     - Ingress
     - ConfigMap
     - All (scan all resources)
   - Purpose: Narrow scope to relevant resources

3. **Which applications?**
   - Examples:
     - "All" (every app in apps/)
     - "prometheus, grafana" (specific apps)
     - "Monitoring apps" (by label/tag)
   - Purpose: Determine which apps/ directories to modify

4. **Which environments?**
   - Examples:
     - "All" (dev, staging, all prod clusters)
     - "Prod only" (prod-west, prod-east, prod-central)
     - "dev, staging" (non-prod environments)
   - Purpose: Determine which overlays/ to modify

5. **What is the change?**
   - Specific examples:
     - Key: `resources.limits.memory`, Value: `4Gi`
     - Key: `nginx.ingress.kubernetes.io/ssl-protocols`, Value: `TLSv1.3`
     - Key: `image`, Value: `prom/prometheus:v2.45.0`
   - Purpose: Define exact YAML path and new value

6. **Why is this change needed?** (for commit message)
   - Examples:
     - "Security requirement: TLS 1.3 minimum"
     - "Cost optimization: reduce memory limits"
     - "Bug fix: update to patched version"
   - Purpose: Institutional memory and audit trail

---

### Phase 2: Scan and Identify Targets

**Build list of files to modify:**

```bash
APPS=("prometheus" "grafana" "nginx-ingress")  # From user input
ENVIRONMENTS=("dev" "staging" "prod-west" "prod-east")  # From user input
RESOURCE_TYPE="Deployment"  # From user input
CHANGE_KEY="spec.template.spec.containers[0].resources.limits.memory"  # From user input
CHANGE_VALUE="4Gi"  # From user input

TARGET_FILES=()

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    OVERLAY_DIR="apps/${APP}/overlays/${ENV}"

    if [ ! -d "${OVERLAY_DIR}" ]; then
      echo "⚠️  Warning: ${OVERLAY_DIR} does not exist, skipping"
      continue
    fi

    # Find all YAML files that define the target resource type
    FILES=$(grep -rl "kind: ${RESOURCE_TYPE}" ${OVERLAY_DIR})

    for FILE in ${FILES}; do
      # Check if file contains the key we're modifying
      HAS_KEY=$(yq eval "${CHANGE_KEY}" ${FILE} 2>/dev/null)
      if [ "${HAS_KEY}" != "null" ] && [ -n "${HAS_KEY}" ]; then
        TARGET_FILES+=("${FILE}")
        echo "✓ Target: ${FILE}"
      fi
    done
  done
done

echo ""
echo "Total files to modify: ${#TARGET_FILES[@]}"
```

---

### Phase 3: Apply Changes

**For EACH target file:**

```bash
for FILE in "${TARGET_FILES[@]}"; do
  echo "Updating ${FILE}..."

  # Backup original
  cp ${FILE} ${FILE}.backup

  # Apply change using yq
  yq eval "${CHANGE_KEY} = \"${CHANGE_VALUE}\"" -i ${FILE}

  # Verify change applied
  NEW_VALUE=$(yq eval "${CHANGE_KEY}" ${FILE})
  if [ "${NEW_VALUE}" == "${CHANGE_VALUE}" ]; then
    echo "  ✓ Updated ${CHANGE_KEY} = ${CHANGE_VALUE}"
  else
    echo "  ❌ Failed to update ${FILE}"
    # Restore backup
    mv ${FILE}.backup ${FILE}
    exit 1
  fi

  # Remove backup if successful
  rm ${FILE}.backup
done
```

**Handle environment-specific variations:**

```bash
# Example: Different resource limits per environment
# Dev: 2Gi, Staging: 4Gi, Prod: 8Gi

case ${ENV} in
  dev)
    CHANGE_VALUE="2Gi"
    ;;
  staging)
    CHANGE_VALUE="4Gi"
    ;;
  prod-*)
    CHANGE_VALUE="8Gi"
    ;;
esac
```

---

### Phase 4: Validation Gates

#### 4.1: Validate Kustomize Builds

```bash
echo ""
echo "Validating Kustomize builds..."
VALIDATION_FAILED=0

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    OVERLAY_DIR="apps/${APP}/overlays/${ENV}"

    if [ ! -d "${OVERLAY_DIR}" ]; then
      continue
    fi

    # Build overlay
    kustomize build ${OVERLAY_DIR} > /tmp/${APP}-${ENV}.yaml 2>&1
    if [ $? -ne 0 ]; then
      echo "❌ ${APP}/${ENV}: Kustomize build failed"
      cat /tmp/${APP}-${ENV}.yaml
      VALIDATION_FAILED=1
    else
      echo "✓ ${APP}/${ENV}: Kustomization builds successfully"
    fi
  done
done

if [ ${VALIDATION_FAILED} -eq 1 ]; then
  echo ""
  echo "❌ Validation failed. Fix errors before committing."
  exit 1
fi
```

#### 4.2: Validate YAML Syntax

```bash
echo ""
echo "Validating YAML syntax..."

for APP in "${APPS[@]}"; do
  for ENV in "${ENVIRONMENTS[@]}"; do
    kubectl apply --dry-run=client -f /tmp/${APP}-${ENV}.yaml > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "❌ ${APP}/${ENV}: YAML syntax invalid"
      kubectl apply --dry-run=client -f /tmp/${APP}-${ENV}.yaml
      exit 1
    else
      echo "✓ ${APP}/${ENV}: YAML syntax valid"
    fi
  done
done
```

#### 4.3: Validate Consistency

```bash
echo ""
echo "Validating consistency across environments..."

# For changes that should be identical across all environments
# Verify the value is the same in all overlays

INCONSISTENCY=0

for APP in "${APPS[@]}"; do
  EXPECTED_VALUE="${CHANGE_VALUE}"
  for ENV in "${ENVIRONMENTS[@]}"; do
    ACTUAL_VALUE=$(kustomize build apps/${APP}/overlays/${ENV} | \
                   yq eval "select(.kind == \"${RESOURCE_TYPE}\") | ${CHANGE_KEY}" -)

    if [ "${ACTUAL_VALUE}" != "${EXPECTED_VALUE}" ]; then
      echo "⚠️  ${APP}/${ENV}: Value mismatch (expected: ${EXPECTED_VALUE}, actual: ${ACTUAL_VALUE})"
      INCONSISTENCY=1
    fi
  done
done

if [ ${INCONSISTENCY} -eq 1 ]; then
  echo ""
  echo "⚠️  Inconsistencies detected. Review carefully."
  # Don't fail (might be intentional environment-specific values)
fi
```

---

### Phase 5: Preview Changes

**Generate comprehensive diff preview:**

```bash
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Change Preview"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Stage changes
git add apps/

# Show summary
echo "Files modified: $(git diff --cached --name-only | wc -l)"
echo ""
git diff --cached --stat

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Detailed Diff"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Show detailed diff
git diff --cached

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
```

**Confirm before proceeding:**

```bash
echo ""
echo "Review complete. Proceed with commit? [Y/n]"
read CONFIRM

if [ "${CONFIRM}" == "n" ] || [ "${CONFIRM}" == "N" ]; then
  echo "Aborting. Changes staged but not committed."
  echo "To discard: git reset --hard"
  echo "To continue later: git commit"
  exit 0
fi
```

---

### Phase 6: Commit with Context

**Generate semantic commit message:**

```bash
COMMIT_MSG="/tmp/harmonize-commit-msg.txt"

cat > ${COMMIT_MSG} << EOF
feat(harmonize): ${CHANGE_DESCRIPTION}

Harmonized configuration across ${#APPS[@]} applications and ${#ENVIRONMENTS[@]} environments.

Change:
- Key: ${CHANGE_KEY}
- Value: ${CHANGE_VALUE}
- Resource type: ${RESOURCE_TYPE}

Scope:
- Applications: ${APPS[@]}
- Environments: ${ENVIRONMENTS[@]}
- Files modified: $(git diff --cached --name-only | wc -l)

Reason:
${CHANGE_REASON}

Validation:
- Kustomize builds: ✓ All overlays build successfully
- YAML syntax: ✓ kubectl dry-run passed
- Consistency: ✓ Value applied across all targets

Generated by: infrastructure-harmonize agent
12-Factor AgentOps: Factors II, III, IV, V, IX
EOF

git commit -F ${COMMIT_MSG}

echo ""
echo "✓ Changes committed successfully"
echo ""
echo "Next steps:"
echo "1. Review commit: git show HEAD"
echo "2. Push to remote: git push origin main"
echo "3. Monitor deployments (if auto-sync enabled)"
echo "4. Validate in dev first, then promote to prod"
```

---

## Example Usage

### Example 1: Enforce TLS 1.3 on All Ingresses

```bash
# Agent prompts:
What configuration to update? → Ingress annotations
Which resource types? → Ingress
Which applications? → All
Which environments? → All
What is the change? →
  Key: metadata.annotations["nginx.ingress.kubernetes.io/ssl-protocols"]
  Value: TLSv1.3
Why is this change needed? → Security requirement SEC-2025-01: TLS 1.3 minimum

# Agent executes:
# Scanning for Ingress resources across all apps/overlays...
# Found 52 Ingress resources in 30 applications
#
# Updating apps/prometheus/overlays/dev/ingress-patch.yaml...
#   ✓ Updated nginx.ingress.kubernetes.io/ssl-protocols = TLSv1.3
# Updating apps/prometheus/overlays/staging/ingress-patch.yaml...
#   ✓ Updated nginx.ingress.kubernetes.io/ssl-protocols = TLSv1.3
# ...
# (52 files updated)
#
# Validating Kustomize builds...
# ✓ All 52 overlays build successfully
#
# Validating YAML syntax...
# ✓ All 52 YAML files valid
#
# Files modified: 52
# Change preview:
# (shows diff of all 52 files)
#
# Proceed with commit? [Y/n] y
#
# ✓ Committed: feat(harmonize): enforce TLS 1.3 on all ingresses
```

### Example 2: Update Prometheus Memory Limits

```bash
# Agent prompts:
What configuration to update? → Resource limits
Which resource types? → Deployment
Which applications? → prometheus
Which environments? → All
What is the change? →
  Key: spec.template.spec.containers[0].resources.limits.memory
  Values (environment-specific):
    - dev: 2Gi
    - staging: 4Gi
    - prod-*: 8Gi
Why is this change needed? → Increase memory limits after OOM incidents

# Agent executes:
# Scanning for Deployment resources in prometheus/overlays...
# Found 5 Deployment resources (dev, staging, 3 prod clusters)
#
# Updating apps/prometheus/overlays/dev/deployment-patch.yaml...
#   ✓ Updated resources.limits.memory = 2Gi
# Updating apps/prometheus/overlays/staging/deployment-patch.yaml...
#   ✓ Updated resources.limits.memory = 4Gi
# Updating apps/prometheus/overlays/prod-west/deployment-patch.yaml...
#   ✓ Updated resources.limits.memory = 8Gi
# ...
#
# Validating Kustomize builds...
# ✓ All 5 overlays build successfully
#
# Validating consistency...
# ⚠️  Values differ across environments (expected: environment-specific)
#   dev: 2Gi
#   staging: 4Gi
#   prod-west: 8Gi
#   prod-east: 8Gi
#   prod-central: 8Gi
#
# Proceed with commit? [Y/n] y
#
# ✓ Committed: feat(prometheus): increase memory limits after OOM incidents
```

### Example 3: Roll Out New Image Version

```bash
# Agent prompts:
What configuration to update? → Container image
Which resource types? → Deployment
Which applications? → grafana
Which environments? → dev (test first, then staging, then prod)
What is the change? →
  Key: spec.template.spec.containers[0].image
  Value: grafana/grafana:10.2.0
Why is this change needed? → Update to latest stable version with security fixes

# Agent executes:
# Updating apps/grafana/overlays/dev/deployment-patch.yaml...
#   ✓ Updated image = grafana/grafana:10.2.0
#
# Validating Kustomize build...
# ✓ dev overlay builds successfully
#
# Proceed with commit? [Y/n] y
#
# ✓ Committed: feat(grafana): update to v10.2.0 in dev
#
# Next steps:
# 1. Deploy to dev: argocd app sync grafana-dev
# 2. Monitor for 24 hours
# 3. If stable, run agent again for staging
# 4. If stable, run agent again for prod
```

---

## Advanced Patterns

### Pattern 1: Conditional Updates (Environment-Specific Logic)

```bash
# Different values per environment tier
get_value_for_environment() {
  local ENV=$1
  local KEY=$2

  case ${KEY} in
    replicas)
      case ${ENV} in
        dev) echo "1" ;;
        staging) echo "2" ;;
        prod-*) echo "3" ;;
      esac
      ;;
    memory_limit)
      case ${ENV} in
        dev) echo "2Gi" ;;
        staging) echo "4Gi" ;;
        prod-*) echo "8Gi" ;;
      esac
      ;;
  esac
}
```

### Pattern 2: Bulk ConfigMap Updates

```bash
# Update multiple ConfigMap values at once
CONFIGMAP_UPDATES=(
  "LOG_LEVEL=info"
  "CACHE_TTL=3600"
  "MAX_CONNECTIONS=100"
)

for UPDATE in "${CONFIGMAP_UPDATES[@]}"; do
  KEY=$(echo ${UPDATE} | cut -d= -f1)
  VALUE=$(echo ${UPDATE} | cut -d= -f2)

  # Update ConfigMap literal
  yq eval ".configMapGenerator[0].literals += [\"${UPDATE}\"]" -i \
    apps/${APP}/overlays/${ENV}/kustomization.yaml
done
```

### Pattern 3: Label Harmonization

```bash
# Ensure all resources have required labels
REQUIRED_LABELS=(
  "app.kubernetes.io/version=1.0.0"
  "app.kubernetes.io/component=backend"
  "app.kubernetes.io/managed-by=kustomize"
)

for LABEL in "${REQUIRED_LABELS[@]}"; do
  KEY=$(echo ${LABEL} | cut -d= -f1)
  VALUE=$(echo ${LABEL} | cut -d= -f2)

  yq eval ".commonLabels.\"${KEY}\" = \"${VALUE}\"" -i \
    apps/${APP}/overlays/${ENV}/kustomization.yaml
done
```

---

## Integration with CI/CD

**Validate harmonization in CI pipeline:**

```yaml
# .gitlab-ci.yml
validate-harmonization:
  stage: validate
  script:
    # Verify consistency across environments
    - ./scripts/check-harmonization.sh
  only:
    - merge_requests
  allow_failure: false
```

**check-harmonization.sh example:**

```bash
#!/bin/bash
# Check that critical configs are harmonized

APPS=$(find apps/ -maxdepth 1 -type d)

for APP in ${APPS}; do
  # Check that TLS version is TLSv1.3 everywhere
  for ENV in dev staging prod-*; do
    TLS_VERSION=$(kustomize build ${APP}/overlays/${ENV} | \
                  yq eval 'select(.kind == "Ingress") | .metadata.annotations["nginx.ingress.kubernetes.io/ssl-protocols"]' -)

    if [ "${TLS_VERSION}" != "TLSv1.3" ]; then
      echo "❌ ${APP}/${ENV}: TLS version not harmonized (found: ${TLS_VERSION})"
      exit 1
    fi
  done
done

echo "✓ All apps harmonized"
```

---

## Common Issues & Solutions

### Issue 1: yq Syntax Errors

**Symptom:** yq command fails with parse error

**Solution:**
```bash
# Check yq version (v4+ required)
yq --version

# Test YAML path on sample file first
yq eval "${CHANGE_KEY}" apps/prometheus/overlays/dev/deployment-patch.yaml

# Escape special characters in key
# Wrong: resources.limits.memory
# Right: "resources.limits.memory" (quotes)
```

### Issue 2: Inconsistent File Structures

**Symptom:** Some overlays have patch files, others inline in kustomization.yaml

**Solution:**
```bash
# Standardize on one approach
# Option 1: Always use patch files
#   - deployment-patch.yaml
#   - service-patch.yaml

# Option 2: Always inline in kustomization.yaml
#   patchesStrategicMerge:
#     - |
#       apiVersion: apps/v1
#       kind: Deployment
#       ...

# Document standard in STYLE-GUIDE.md
```

### Issue 3: Merge Conflicts During Harmonization

**Symptom:** git commit fails due to merge conflicts

**Solution:**
```bash
# Pull latest changes first
git pull origin main

# Re-run harmonization agent
# Agent will apply changes on top of latest

# If conflicts persist, resolve manually
git status
# Edit conflicting files
git add .
git commit
```

---

## Success Metrics

**This agent is successful when:**

1. ✅ **100% coverage** (all target resources updated)
2. ✅ **0 YAML syntax errors** after harmonization
3. ✅ **Consistent values** across environments (or documented differences)
4. ✅ **Full audit trail** (commit explains what, why, who)
5. ✅ **Fast execution** (<15 min for 50+ apps)
6. ✅ **Validated before commit** (all gates passed)

**Quantified success:**
- Time: 15 minutes (vs 8 hours manual harmonization)
- Error rate: <5% (vs 25% manual copy-paste errors)
- Coverage: 100% (vs 85% manual, some apps missed)
- Consistency: 100% (vs 70% manual, inconsistencies introduced)

---

## Evolution & Improvement

**This agent improves by:**

1. **Learning common harmonization patterns** → Create templates
2. **Tracking harmonization frequency** → Identify volatile configs
3. **Automating environment-specific logic** → Smart value selection
4. **Detecting harmonization drift** → Alert when values diverge again
5. **Community patterns** → Share harmonization recipes

**Contribute improvements:**
- Share harmonization patterns (TLS configs, resource limits, etc.)
- Suggest additional validation checks
- Report edge cases not handled
- Improve environment-specific logic

---

## Related Agents

- **infrastructure-create** - Create new applications
- **infrastructure-drift** - Detect configuration drift
- **infrastructure-rollback** - Rollback failed changes

---

## References

- [12-Factor AgentOps: Factor IV (Validation Gates)](../../../factors/04-validation-gates.md)
- [12-Factor AgentOps: Factor V (Continuous Learning)](../../../factors/05-continuous-learning.md)
- [12-Factor AgentOps: Factor IX (Pattern Extraction)](../../../factors/09-pattern-extraction.md)
- [Kustomize Patching](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patches/)
- [yq Documentation](https://mikefarah.gitbook.io/yq/)

---

**Version:** 1.0.0
**Last Updated:** 2025-01-15
**Maintained By:** 12-factor-agentops community

**This agent embodies Factor III (Single-Responsibility) and Factor IV (Validation Gates). Use it for consistent multi-environment updates.**
