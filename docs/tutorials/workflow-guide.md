# 12-Factor AgentOps Workflow

**How to apply the 12 factors in practice using the slash command workflow.**

This guide shows the operational workflow for reliable AI agent work: `/prime` → `/research` → `/plan` → `/implement` → `/learn` → repeat.

---

## The Workflow Loop

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  /prime          /research         /plan          /implement    │
│    ↓                ↓                ↓                ↓          │
│  Setup          Research        Design         Execute         │
│  Context        Problem         Solution       + Validate       │
│                                                      ↓           │
│                                                   /learn        │
│                                                  Extract        │
│                                                  Patterns       │
│                                                      ↓           │
│  └─────────────────────────────────────────────────┘           │
│           (Repeat with learnings)                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

Each phase has **validation gates** before proceeding to the next phase. No proceeding without validation.

---

## Phase 1: `/prime` - Prepare & Scope

**Purpose:** Set up context, scope the problem, prepare for research.

**What happens:**
- Clear your context window (Factor II: JIT Context Loading)
- Define the problem statement
- Identify constraints and success criteria
- Prepare domain knowledge (Factor XII: Domain Portability)

**Output:** Problem statement + success criteria + context bundle

**Validation gate:** Can you clearly articulate the problem in 1-2 sentences?

---

## Phase 2: `/research` - Deep Dive

**Purpose:** Understand the problem domain deeply before designing a solution.

**What happens:**
- Research existing patterns (Factor I: Git Memory as Knowledge OS)
- Explore domain-specific approaches
- Identify decision points and trade-offs
- Document findings and options

**Output:** Research findings + 2-3 viable approaches with pros/cons

**Validation gate:** Do you understand the problem deeply enough to explain it to someone unfamiliar?

---

## Phase 3: `/plan` - Design Solution

**Purpose:** Design a detailed solution that follows the 12 factors.

**What happens:**
- Map solution to applicable factors (especially I-IV for foundation)
- Define implementation steps
- Identify validation points (Factor IV: Validation Gates)
- Plan observability (Factor V: Operational Telemetry)
- Design human checkpoints if needed (Factor VIII: Human Gate Reviews)

**Output:** Implementation plan + validation strategy + observability design

**Validation gate:** Does your plan include validation gates? Are human checkpoints clear?

---

## Phase 4: `/implement` - Execute with Validation

**Purpose:** Build the solution while validating each step.

**This phase includes:**
- Implementation sub-phases with validation between each
- Continuous factor compliance checks (especially IV, V, VIII, IX)
- Pattern extraction as you go (Factor IX: Documented Pattern Extraction)
- Continuous improvement opportunities noted (Factor X: Continuous Improvement Backlog)

**Output:** Working solution + implementation artifacts + observed patterns

**Validation gate:** Does the solution work? Are all validation gates passing? Is observability in place?

---

## Phase 5: `/learn` - Extract Patterns

**Purpose:** Convert implementation experience into reusable knowledge.

**What happens:**
- Review what worked and what didn't
- Document patterns discovered (Factor IX)
- Identify improvements for next time (Factor X)
- Update domain knowledge (Factor XII)
- Contribute to institutional memory (Factor I)

**Output:** Pattern documentation + improvement backlog + updated domain knowledge

**Validation gate:** Can you articulate 1-2 patterns you'll reuse next time?

---

## Repeat with Learnings

The workflow loops. Each iteration:
- Benefits from previous /learn phase insights
- Applies discovered patterns (Factor I: Git Memory)
- Improves efficiency through accumulated knowledge (Factor X: Continuous Improvement)
- Compounds reliability improvements (Factors IX-XII: Improvement cycle)

---

## Complete Example: Redis Operator + CRD + Kustomization

This example shows the full workflow applied to a real task: deploying and configuring a Redis Operator with custom CRD settings via Kustomization.

### Phase 1: `/prime` - Prepare

**Problem Statement:**
Deploy the Redis Operator to a Kubernetes cluster and configure a Redis instance using custom CRD, with cluster-specific overrides via Kustomization.

**Success Criteria:**
- ✅ Redis Operator pods running
- ✅ Custom Redis CRD instantiated
- ✅ Kustomization overlay applies environment-specific configuration
- ✅ All configuration in version control
- ✅ Observable and auditable (git history shows intent)

**Context:**
- Target: Production Kubernetes cluster
- Operator: Redis Operator by OT.IO
- Configuration: Custom Redis instance with 3-replica setup
- Override: Kustomization patch for environment-specific settings

**Validation:** ✅ Problem clear, success criteria defined

---

### Phase 2: `/research` - Understand

**Research findings:**

**Option A: Helm-only approach**
- Pros: Simple, one command
- Cons: Hard to override specific CRD values, less auditable

**Option B: Raw YAML**
- Pros: Complete control, transparent
- Cons: Verbose, hard to maintain, easy to duplicate

**Option C: Kustomization (chosen)**
- Pros: Clear base + overlay structure, auditable, overrides visible
- Cons: Requires understanding Kustomization patterns

**Patterns discovered:**
- Redis Operator publishes manifests in Git
- Kustomization enables environment-specific overrides
- CRD values are best documented in base manifest
- ConfigMap + Secret pattern for runtime config

**Validation:** ✅ Clear understanding of approaches, pattern selected

---

### Phase 3: `/plan` - Design

**Architecture:**

```
kustomization/
├── base/                          # Base Redis Operator setup
│   ├── kustomization.yaml
│   ├── namespace.yaml
│   └── redis-operator/            # Operator manifests (from upstream)
│       ├── operator.yaml
│       ├── crd.yaml
│       └── rbac.yaml
│
└── overlays/
    └── production/                # Production-specific overrides
        ├── kustomization.yaml
        ├── redis-instance-patch.yaml    # CRD field overrides
        └── config/
            ├── redis-config.yaml        # Custom settings
            └── secrets.yaml             # Prod secrets
```

**Implementation Steps (with validation gates):**

1. **Create base structure** (Validate: directory structure correct)
2. **Download operator manifests** (Validate: manifests are valid YAML)
3. **Create Redis CRD instance in base** (Validate: CRD applies without error)
4. **Create production overlay** (Validate: overlay applies, no conflicts)
5. **Test configuration** (Validate: Redis instance healthy, accessible)
6. **Commit to git** (Validate: clean git history, intent visible in commits)

**Validation Strategy (Factor IV: Validation Gates):**
- YAML syntax validation after each step
- kubectl apply --dry-run validation
- Actual cluster apply with health checks
- Observability: metrics endpoint accessible (Factor V)

**Observability Design (Factor V: Operational Telemetry):**
- Monitor Redis Operator pod logs
- Track CRD creation/status
- Monitor Redis instance metrics (if exposed)
- Git audit trail shows all changes + intent

**Human Checkpoints (Factor VIII: Human Gate Reviews):**
- Review final Kustomization structure before apply
- Verify production config doesn't expose secrets

**Validation:** ✅ Plan includes validation gates, observability, human checkpoints

---

### Phase 4: `/implement` - Execute with Validation

#### Step 1: Create Base Structure

```bash
mkdir -p kustomization/base/redis-operator
mkdir -p kustomization/overlays/production/config

cat > kustomization/base/kustomization.yaml << 'EOF'
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: redis

resources:
  - namespace.yaml
  - redis-operator/

images:
  - name: redis-operator
    newName: ot-container-kit/redis-operator
    newTag: v0.15.1
EOF
```

**Validation gate:**
```bash
✅ Directory structure created
✅ kustomization.yaml is valid YAML
```

---

#### Step 2: Download Operator Manifests

```bash
# Get manifests from upstream
curl -s https://raw.githubusercontent.com/OT-CONTAINER-KIT/redis-operator/v0.15.1/config/manager/manager.yaml \
  > kustomization/base/redis-operator/operator.yaml

curl -s https://raw.githubusercontent.com/OT-CONTAINER-KIT/redis-operator/v0.15.1/config/crd/bases/*.yaml \
  > kustomization/base/redis-operator/crd.yaml

# Check they're valid
kubectl apply --dry-run=client -f kustomization/base/redis-operator/
```

**Validation gate:**
```bash
✅ kubectl apply --dry-run passes
✅ No syntax errors in manifests
```

---

#### Step 3: Create Redis Instance in Base

Create `kustomization/base/redis-instance.yaml`:

```yaml
apiVersion: redis.opstreelabs.in/v1beta1
kind: Redis
metadata:
  name: redis-cluster
spec:
  kubernetesConfig:
    image: redis:7-alpine
    imagePullPolicy: IfNotPresent
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 500m
        memory: 512Mi

  redisConfig:
    maxmemory: "256mb"
    maxmemory-policy: "allkeys-lru"

  storage:
    emptyDir: {}

  replicas: 3
```

Add to base `kustomization.yaml`:
```yaml
resources:
  - ...
  - redis-instance.yaml
```

**Validation gate:**
```bash
✅ kubectl apply --dry-run=client -f kustomization/base/ passes
✅ No CRD conflicts or syntax errors
```

---

#### Step 4: Create Production Overlay

Create `kustomization/overlays/production/kustomization.yaml`:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: redis-prod

bases:
  - ../../base

# Patch to increase replica count for production
patchesStrategicMerge:
  - redis-instance-patch.yaml

configMapGenerator:
  - name: redis-config
    files:
      - config/redis-settings.conf

# Production namespace override
namespaceOverride: redis-prod
```

Create `kustomization/overlays/production/redis-instance-patch.yaml`:

```yaml
apiVersion: redis.opstreelabs.in/v1beta1
kind: Redis
metadata:
  name: redis-cluster
spec:
  replicas: 5                    # Increased for prod
  storage:
    size: "10Gi"                 # Persistent storage
  redisConfig:
    maxmemory: "2gb"             # Higher limit for prod
```

**Validation gate:**
```bash
✅ kubectl apply --dry-run=client -k kustomization/overlays/production/ passes
✅ Patch applies correctly, replicas = 5 in output
✅ No conflicts between base and overlay
```

---

#### Step 5: Test in Dry-Run

```bash
# Full dry-run to see final manifests
kubectl apply -k kustomization/overlays/production/ --dry-run=client -o yaml | head -50

# Verify Redis instance spec
kubectl apply -k kustomization/overlays/production/ --dry-run=client -o yaml | grep -A 10 "kind: Redis"
```

**Validation gate:**
```bash
✅ Final manifests are valid YAML
✅ Redis instance has 5 replicas
✅ Namespace is redis-prod
✅ Storage size is set
```

---

#### Step 6: Apply to Cluster

```bash
# Apply with kubectl
kubectl apply -k kustomization/overlays/production/

# Verify operator pod running
kubectl get pods -n redis-prod | grep redis-operator

# Check CRD instance status
kubectl get redis -n redis-prod
kubectl describe redis redis-cluster -n redis-prod
```

**Validation gate:**
```bash
✅ Operator pods: 1/1 Running
✅ Redis instance: status shows "Healthy"
✅ All 5 replicas initialized
```

---

#### Step 7: Observability Check (Factor V)

```bash
# Check logs for errors
kubectl logs -n redis-prod deployment/redis-operator

# Monitor instance creation
kubectl get events -n redis-prod --sort-by='.lastTimestamp'

# Verify Redis is accessible
kubectl port-forward -n redis-prod svc/redis-cluster 6379:6379 &
redis-cli ping
```

**Validation gate:**
```bash
✅ Operator logs show no errors
✅ Events show normal progression
✅ Redis responds to ping
```

---

#### Step 8: Commit to Git (Factor I: Git Memory)

```bash
git add kustomization/
git commit -m "feat(redis-operator): deploy with 5-replica production config

## What
Deploy Redis Operator with custom CRD instance for production.
- Base: Redis Operator manifests + CRD definition
- Overlay: Production-specific overrides (5 replicas, 10Gi storage, 2gb max memory)
- Applied via Kustomization for clarity and auditability

## Why
Centralized Redis instance for production workloads.
Kustomization enables environment-specific config without duplicating manifests.

## How
- Standard Redis Operator from upstream (v0.15.1)
- Custom Redis instance spec in base
- Production patch for replicas, storage, memory limits
- All config in git; deployment auditable

## Validation
- ✅ kubectl apply --dry-run passes
- ✅ Operator deployed, 1/1 running
- ✅ Redis instance healthy, 5/5 replicas
- ✅ Redis responds to connections

## Factors Applied
- Factor I: Git memory - full history in commits
- Factor IV: Validation gates - --dry-run before apply
- Factor V: Observability - logs, events, metrics accessible
- Factor XII: Domain portability - Kustomization base/overlay pattern reusable
"
```

**Validation gate:**
```bash
✅ Clean git history
✅ Commit message explains intent
✅ All config tracked and auditable
```

---

### Phase 5: `/learn` - Extract Patterns

**What worked:**
1. Kustomization base/overlay pattern is clean and maintainable
2. Strategic merge patch for replicas is simpler than full manifest override
3. Dry-run validation caught issues before cluster apply
4. Operator manifests from upstream required minimal customization

**What to improve:**
1. ConfigMap generation for redis-settings.conf (would enable dynamic reload)
2. Add health check hooks to catch issues earlier
3. Document Redis backup strategy for next deployment

**Patterns to reuse:**
- **Base + overlay pattern:** Works for any operator deployment
- **Dry-run validation gates:** Always use before cluster apply
- **Commit-before-deploy:** Forces thinking about intent

**Improvement backlog** (Factor X):
- [ ] Add ConfigMap for redis.conf with dynamic reload
- [ ] Add readiness probe to Redis instance spec
- [ ] Create backup policy CRD for automated backups
- [ ] Add monitoring/alerting rules for Redis operator

**Domain knowledge update** (Factor XII):
- Redis Operator deploys successfully with standard manifests
- Kustomization patch for replicas works as expected
- 5 replicas gives good redundancy for production
- Performance limit: max-memory policy needs monitoring

---

## Key Principles Applied

Each phase demonstrates the 12 factors in action:

| Factor | Applied How |
|--------|------------|
| **I. Git Memory** | Commit messages explain intent; full history auditable |
| **II. JIT Context** | Each phase scopes context; no unnecessary complexity |
| **III. Single-Responsibility** | Operator handles Redis; Kustomization handles config |
| **IV. Validation Gates** | --dry-run before each step; no surprises at deploy |
| **V. Observability** | Logs, events, metrics all accessible; issues visible |
| **VIII. Human Gate Reviews** | Human approval before applying prod config |
| **IX. Pattern Extraction** | Workflow documented; patterns captured for reuse |
| **X. Improvement Backlog** | Identified 4 improvements for next iteration |
| **XII. Domain Portability** | Pattern reusable for any operator deployment |

---

## How to Run This Workflow

### For Your Own Task

1. **/prime:** Define problem, scope, success criteria
2. **/research:** Understand domain, find approaches, pick best
3. **/plan:** Design solution, map to factors, plan validation
4. **/implement:** Build with validation gates after each step
   - After each major step, validate before continuing
   - Commit with clear intent messages
5. **/learn:** Review, document patterns, update domain knowledge
6. **Repeat:** Next task benefits from previous learnings

### Validation Gates Checklist

Before moving to next phase:
- [ ] Can I clearly state the outcome of this phase?
- [ ] Have I validated assumptions?
- [ ] Is my intent documented (commit messages, comments)?
- [ ] Are observability and validation in place?
- [ ] Could someone else understand why I chose this path?

### Apply Across Any Domain

This workflow works for:
- Infrastructure deployment (like the example)
- Application development
- System design
- Debugging and incident response
- Process improvement

The pattern is consistent: prime → research → plan → implement (validate) → learn → repeat.

---

## Why This Matters

Traditional "move fast and break things" fails with AI agents because:
- Errors compound across steps (lack of validation gates)
- Learning gets lost (no extraction phase)
- Patterns aren't reused (no domain knowledge capture)
- Intent disappears (poor commit messages, no documentation)

This workflow systematically addresses all five:
- ✅ Validation gates (Phase 4: /implement with checks)
- ✅ Pattern extraction (Phase 5: /learn)
- ✅ Reusable knowledge (Factor XII: Domain Portability)
- ✅ Documented intent (Factor I: Git Memory)
- ✅ Continuous improvement (Factor X: Backlog)

**Result:** Each iteration compounds on previous ones. Your system gets better, faster, more reliable over time.

---

**Next:** Pick a task, run the workflow, and extract patterns. Repeat. Watch your speed and reliability compound.
