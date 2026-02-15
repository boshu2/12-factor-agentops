# Factor XII: Package Patterns

**Bundle what works for reuse - capture successful workflows as reusable packages**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Knowledge OS |
| **Supporting Pillar** | DevOps + SRE |
| **Enforces Laws** | Law 1 (Extract Learnings), Law 5 (Share Patterns) |
| **Derived From** | Code reuse + Package systems + Profile systems + Domain-driven design |


---

## Summary

Agent workflows, patterns, and knowledge accumulated in one domain should be packaged and portable to other domains. Domain packages are self-contained bundles (agents, workflows, patterns, configurations) that enable instant productivity in new contexts. Build once, reuse everywhere.

## The Problem

Without domain portability:
- Start from zero in each new domain
- Rediscover patterns already known
- Can't transfer knowledge across contexts
- Waste time rebuilding what exists
- No compounding returns on investment

**Familiar pattern:**
```
Domain 1 (Customer Service): Build 52 workflows over 2 years
Domain 2 (Sales): Start from zero, rebuild workflows
Domain 3 (Research): Start from zero again
Result: 3× the work, no knowledge transfer
```

**Traditional approach:** Build domain-specific solutions, no reuse

**12-Factor AgentOps approach:** Package domain knowledge, instant deployment

---

## Why This Factor Exists

### Grounding in the Five Pillars

**Primary: Knowledge OS**

Domain portability operationalizes Knowledge OS's principle that knowledge should compound, not duplicate. Building 52 workflows for customer service over 2 years represents enormous knowledge capital—but if this knowledge can't transfer to sales or research domains, you start from zero three times. The "Don't Repeat Yourself" principle from software engineering applies to knowledge: package once, reuse everywhere.

Package systems demonstrate this well: templates (reusable workflows) + values (configurable parameters) = install anywhere. Domain packages apply the same pattern to agent workflows: agents (reusable workflows) + config (configurable parameters) = deploy in any domain. The first package takes 2 years to develop, the second takes 2 weeks to adapt, the third takes 1 week. This is knowledge compound interest.

**Supporting: DevOps + SRE**

DevOps provides the domain-driven design pattern: capture domain knowledge in bounded contexts. Customer Service Operations is a bounded context with entities (Customers, Tickets, Refunds), operations (Resolve, Escalate, Follow-up), and language (SLA, CSAT, first-contact resolution). Packaging this context as a domain package makes the knowledge portable and reusable across any customer service environment.

---

## What This Factor Enforces

### Law 1: Extract Learnings

Domain packages enforce learning extraction by requiring generalization from specific implementations. To create a package, you must abstract: "We gave customer #1234 a 20% discount" becomes "Proportional compensation for service failures." This abstraction process IS learning extraction—converting specific solutions into general principles.

**Concrete example:** Building customer service package forces extraction: which patterns are customer-service-specific vs. universally applicable? The research→plan→execute workflow generalizes across all domains. The empathetic-resolution pattern is customer-service-specific. Package creation forces this categorization, extracting reusable learnings from domain context.

### Law 5: Share Patterns Publicly

Domain packages operationalize Law 5 by packaging knowledge for distribution. A package is a shareable artifact: package specification, agent definitions, workflow patterns, documentation. Publishing to a public registry enables community use and contribution.

**Concrete example:** Customer-service package published to public registry → 1000 downloads → 25 issues reported → 15 pull requests with improvements → Your package improves through community contributions → Your team benefits from community enhancements. Public sharing creates network effects where private hoarding creates isolated stagnation. Law 5 enforcement through shareable package format.

---

## The Principle

### What is a Domain Package?

**A portable package containing:**

1. **Agents** - Domain-specific agent definitions
2. **Workflows** - Common workflow patterns for this domain
3. **Patterns** - Documented solutions to domain problems
4. **Configurations** - Domain-specific settings
5. **Documentation** - How to operate in this domain
6. **Validations** - Domain-specific quality gates

**Example: Customer Service Package**
```
packages/customer-service/
├── agents/
│   ├── handle-inquiry.md
│   ├── process-refund.md
│   ├── escalate-complaint.md
│   └── follow-up-satisfaction.md
├── workflows/
│   ├── resolve-ticket.md
│   ├── handle-escalation.md
│   └── proactive-outreach.md
├── patterns/
│   ├── empathetic-resolution.md
│   ├── proactive-compensation.md
│   └── satisfaction-recovery.md
├── config/
│   ├── validation-rules.yaml
│   ├── escalation-thresholds.yaml
│   └── default-settings.yaml
├── docs/
│   ├── getting-started.md
│   ├── best-practices.md
│   └── troubleshooting.md
└── README.md
```

### Package Lifecycle

```
1. DEVELOP in one domain
   - Build agents, workflows, patterns
   - Validate through production use
   - Document what works

2. EXTRACT common knowledge
   - Identify domain-specific patterns
   - Separate domain logic from implementation
   - Create generalized templates

3. PACKAGE as domain bundle
   - Bundle agents, workflows, patterns
   - Version and release
   - Publish to registry

4. INSTALL in new domain
   - Download package
   - Configure for local context
   - Deploy instantly

5. ADAPT for local needs
   - Customize configurations
   - Add domain-specific extensions
   - Contribute improvements back
```

---

## Why This Works

### 1. Code Reuse (Software Engineering)

**DRY principle:**
> "Don't Repeat Yourself"

**For domain knowledge:**
```
Without packages:
  Customer Service domain: 2 years, 52 workflows
  Sales domain: 2 years, 48 workflows
  Total: 4 years, 100 workflows

With packages:
  Customer Service domain: 2 years, 52 workflows
  Customer Service package: Package knowledge
  Sales domain: Install package, adapt (2 weeks)
  Total: 2 years + 2 weeks, 52+ workflows

Savings: 95% time reduction for second domain
```

### 2. Package Systems Pattern

**Package principle:**
> "Bundle applications for reuse"

**For agent workflows:**
```
Package system:
  - Templates (reusable definitions)
  - Values (configurable parameters)
  - Install anywhere

Agent package:
  - Agents (reusable workflows)
  - Config (configurable parameters)
  - Deploy anywhere
```

### 3. Domain-Driven Design (DDD)

**DDD principle:**
> "Capture domain knowledge in bounded contexts"

**For agent packages:**
```
Bounded context: Customer Service Operations
- Entities: Customers, Tickets, Refunds
- Operations: Resolve, Escalate, Follow-up
- Patterns: Empathetic resolution, Proactive compensation
- Language: SLA, CSAT, first-contact resolution

Package captures this knowledge → Reusable in any customer service context
```

### 4. Network Effects of Sharing

**Problem:** Private packages stay private

**Solution:** Public packages benefit everyone
```
Private package:
  Your team: 10 people
  Benefit: 10×

Public package:
  Community: 1000 people
  Benefit: 1000×
  Contributions: Community improves your package
  Result: Compound returns
```

---

## Implementation

### Package Structure Specification

**Standard package format:**
```yaml
# package.yaml
name: customer-service
version: 1.2.0
description: Customer service workflows and patterns
author: Your Team
license: MIT

dependencies:
  - core-workflow@^2.0.0
  - communication-patterns@^1.5.0

agents:
  - agents/handle-inquiry.md
  - agents/process-refund.md
  - agents/escalate-complaint.md

workflows:
  - workflows/resolve-ticket.md
  - workflows/handle-escalation.md

patterns:
  - patterns/empathetic-resolution.md
  - patterns/proactive-compensation.md

config:
  validation_rules: config/validation-rules.yaml
  escalation_thresholds: config/escalation-thresholds.yaml
  defaults: config/default-settings.yaml

documentation:
  getting_started: docs/getting-started.md
  best_practices: docs/best-practices.md
```

### Package Installation

**Command-line tool:**
```bash
# Install package
agentops package install customer-service@1.2.0

# What it does:
# 1. Download package from registry
# 2. Validate package integrity
# 3. Install agents to agents/
# 4. Install workflows to workflows/
# 5. Install patterns to patterns/
# 6. Merge configurations
# 7. Generate documentation

# List installed packages
agentops package list

# Output:
# customer-service@1.2.0 (installed 2025-01-27)
# sales-operations@0.9.0 (installed 2025-02-15)
# research-workflow@1.0.0 (installed 2025-03-01)
```

**Installation implementation:**
```python
class PackageInstaller:
    def install(self, package_name, version):
        # 1. Download from registry
        package = self.download_package(package_name, version)

        # 2. Validate
        if not self.validate_package(package):
            raise InvalidPackageError()

        # 3. Check dependencies
        for dep in package.dependencies:
            if not self.is_installed(dep):
                self.install(dep.name, dep.version)

        # 4. Install components
        self.install_agents(package.agents)
        self.install_workflows(package.workflows)
        self.install_patterns(package.patterns)

        # 5. Merge configurations
        self.merge_config(package.config)

        # 6. Register installation
        self.register_package(package)

        return package
```

### Package Customization

**Local overrides:**
```yaml
# packages/customer-service.local.yaml
# Customizations for this specific deployment

config:
  # Override default escalation threshold
  escalation_threshold: $500

  # Add custom validation rules
  custom_validations:
    - require_satisfaction_check: true
    - enforce_follow_up: true

agents:
  # Add local agent
  custom_agents:
    - local/agents/vip-customer-handler.md

workflows:
  # Disable workflow not needed here
  disabled:
    - workflows/proactive-outreach.md
```

### Package Registry

**Public package registry:**
```
https://packages.12factor-agentops.dev/

Available packages:
- customer-service (1.2.0) - 52 agents, 15 workflows
- sales-operations (0.9.0) - 30 agents, 10 workflows
- research-workflow (1.0.0) - 25 agents, 8 workflows
- support-escalation (0.8.0) - 20 agents, 7 workflows
- data-analysis (1.1.0) - 18 agents, 6 workflows
- content-creation (1.0.0) - 22 agents, 9 workflows
```

**Package publishing:**
```bash
# Package for distribution
agentops package build

# Output: customer-service-1.2.0.tar.gz

# Publish to registry
agentops package publish customer-service-1.2.0.tar.gz

# Validates:
# - Package structure correct
# - All files present
# - Documentation complete
# - Version not already published
# - License specified
```

---

## Validation

### ✅ You're doing this right if:
- Domains packaged as portable bundles
- Packages installable in minutes (not days)
- Packages versioned and released
- Community contributes to public packages
- New domains productive immediately (not months)

### ❌ You're doing this wrong if:
- No packages (everything ad-hoc)
- Packages not portable (hardcoded assumptions)
- Packages not versioned (breaking changes)
- Packages not shared (private only)
- Each domain starts from zero

---

## Real-World Evidence

### Package Development Timeline

**Customer Service Package:**
```
Year 1: Develop in production
- Built 52 agents over 24 months
- Validated 15 workflows
- Extracted 12 patterns
- Investment: 2 years

Year 2: Package as bundle
- Extracted common knowledge
- Created package structure
- Published version 1.0.0
- Investment: 2 weeks
```

**Sales Operations Package (Second Domain):**
```
Using Customer Service package as template:
- Installed customer-service package
- Adapted for sales domain
- Created sales-operations package
- Time: 2 weeks (vs. 2 years from scratch)

Productivity: 52× faster (2 weeks vs. 2 years)
```

**Research Workflow Package (Third Domain):**
```
Using both previous packages as references:
- Installed customer-service + sales-operations
- Identified common patterns
- Created research-workflow package
- Time: 1 week

Productivity: 104× faster (1 week vs. 2 years)
```

**Learning curve:**
```
Domain 1: 2 years
Domain 2: 2 weeks (52× faster)
Domain 3: 1 week (104× faster)
Domain 4+: Estimated <1 week

Marginal cost decreases with each package
```

### Community Impact

**Public package sharing:**
```
Your package: customer-service
Downloads: 1000
Issues reported: 25
Pull requests: 15
Improvements contributed: 8

Result:
- Your package improves through community contributions
- Your team benefits from improvements
- Community benefits from your work
- Network effects compound
```

---

## Anti-Patterns

### ❌ The "Monolithic Package" Trap
**Wrong:** One massive package for everything
**Right:** Focused packages per domain, composable

### ❌ The "Hardcoded Assumptions" Trap
**Wrong:** Package assumes specific environment
**Right:** Configurable, works anywhere with config

### ❌ The "No Versioning" Trap
**Wrong:** Update package, break all users
**Right:** Semantic versioning, backward compatibility

### ❌ The "Private Hoarding" Trap
**Wrong:** Keep all packages private
**Right:** Share publicly (Law 5), benefit from network effects

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Packages versioned in persistent memory
- **Factor III: Focused Agents**: Packages contain single-responsibility agents
- **Factor IX: Mine Patterns**: Packages bundle extracted patterns
- **Factor X: Small Iterations**: Package updates driven by improvement backlog
- **Factor XI: Fail-Safe Checks**: Packages include domain-specific guardrails

---

## Package Categories

### Category 1: Domain Packages

**Examples:**
- customer-service
- sales-operations
- research-workflow
- content-creation
- data-analysis

**Contents:** Domain-specific agents, workflows, patterns

### Category 2: Industry Packages

**Examples:**
- healthcare-compliance
- financial-services
- e-commerce-operations
- education-support

**Contents:** Industry-specific operations, regulations

### Category 3: Process Packages

**Examples:**
- agile-workflow
- kanban-operations
- incident-response
- quality-assurance

**Contents:** Process workflows, templates, checklists

### Category 4: Meta Packages

**Examples:**
- agentops-core (this framework)
- documentation-standards
- quality-gates
- compliance-requirements

**Contents:** Cross-cutting concerns, standards, governance

---

## Package Composition

**Packages can depend on other packages:**

```yaml
# sales-operations package.yaml
name: sales-operations
version: 0.9.0

dependencies:
  - core-workflow@^2.0.0        # Base workflow operations
  - communication-patterns@^1.5.0  # Communication utilities
  - validation-gates@^1.0.0     # Quality gates

# Inherits agents from dependencies
# Adds sales-specific agents
# Composes into complete package
```

**Composition enables:**
- **Reuse:** Don't rebuild common capabilities
- **Focus:** Package only domain-specific knowledge
- **Evolution:** Update dependencies independently
- **Modularity:** Mix and match packages

---

## Migration from Unstructured to Packages

**Step-by-step migration:**

```markdown
# Phase 1: Inventory (Week 1)
- List all agents in current use
- List all workflows
- List all patterns
- Categorize by domain

# Phase 2: Extract (Week 2)
- Group agents by domain
- Identify domain boundaries
- Extract common patterns
- Document domain knowledge

# Phase 3: Package (Week 3)
- Create package structure
- Populate package.yaml
- Organize files
- Write documentation

# Phase 4: Test (Week 4)
- Install package in clean environment
- Verify all agents work
- Test workflows end-to-end
- Fix issues

# Phase 5: Publish (Week 5)
- Version package (1.0.0)
- Publish to registry
- Announce to community
- Gather feedback

Total time: 5 weeks
Result: Portable, reusable domain knowledge
```

---

## Next Steps

1. **Inventory current agents** by domain
2. **Create first package** (start with most mature domain)
3. **Package and version** bundle
4. **Test installation** in clean environment
5. **Publish publicly** (GitHub, registry)
6. **Document lessons learned** for next package

---

## Further Reading

- **Knowledge OS Pillar**: [../docs/principles/knowledge-os.md](../docs/principles/knowledge-os.md)
- **Law 1 (Extract Learnings)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-1)
- **Law 5 (Share Patterns)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-5)
- **Factor IX: Mine Patterns**: [./09-mine-patterns.md](./09-mine-patterns.md)
- **Domain-Driven Design**: [Wikipedia: Domain-driven design](https://en.wikipedia.org/wiki/Domain-driven_design)

---

## Implementation Patterns

These patterns emerge from production deployments in Houston (local-first), Fractal (Kubernetes-native), and ai-platform (IC-hardened). They extend the conceptual packaging principles with battle-tested infrastructure patterns for deploying agents across constrained environments.

### Pattern 1: Three-Tier IC Deployment Model

**The Problem:** Different deployment environments have vastly different constraints (connectivity, compute, classification). A single deployment model doesn't work everywhere.

**The Solution:** Three-tier model designed for maximum constraints first, then relaxed for less constrained environments.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      THREE-TIER IC DEPLOYMENT MODEL                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                        TIER 3: CONNECTED                              │ │
│  │                                                                        │ │
│  │  • Frontier models (Claude, GPT-4)                                    │ │
│  │  • Full internet connectivity                                         │ │
│  │  • Cloud-native deployment                                            │ │
│  │  • Controlled external access for updates                             │ │
│  │                                                                        │ │
│  │  USE: Development, research, complex reasoning                        │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                              ▲                                              │
│                              │ fallback                                     │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                    TIER 2: INTERNAL DATACENTER                        │ │
│  │                                                                        │ │
│  │  • Large models (70B-123B)                                            │ │
│  │  • Shared HPCaaS GPU cluster                                          │ │
│  │  • Internal network only                                              │ │
│  │  • No external connectivity                                           │ │
│  │                                                                        │ │
│  │  USE: Analysis, planning, heavy compute                               │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                              ▲                                              │
│                              │ fallback                                     │
│  ┌───────────────────────────────────────────────────────────────────────┐ │
│  │                     TIER 1: TACTICAL EDGE                             │ │
│  │                                                                        │ │
│  │  • Quantized 7B models (Mistral, Llama)                               │ │
│  │  • 3 GPU nodes, limited compute                                       │ │
│  │  • 0% internet connectivity (air-gapped)                              │ │
│  │  • Latency-critical (<100ms)                                          │ │
│  │                                                                        │ │
│  │  USE: Tactical decisions, edge inference, field ops                   │ │
│  └───────────────────────────────────────────────────────────────────────┘ │
│                                                                             │
│  PRINCIPLE: Design for Tier 1 first. If it works air-gapped, it works     │
│             everywhere.                                                     │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Tier Configuration (Helm values):**

```yaml
# values-tier1-edge.yaml - Tactical Edge (most constrained)
global:
  tier: edge
  connectivity: none
  classification: secret

models:
  primary:
    name: mistral-7b-instruct-q4
    size: 7B
    quantization: q4_K_M
    maxContext: 8192
  fallback: null  # No fallback at edge

resources:
  gpu:
    nodes: 3
    perNode: 1
    type: nvidia-a10g
  memory:
    perPod: 16Gi

networking:
  egress: deny-all
  ingress: internal-only

registry:
  type: local
  url: registry.local:5000

---
# values-tier2-datacenter.yaml - Internal Datacenter
global:
  tier: datacenter
  connectivity: internal
  classification: secret

models:
  primary:
    name: llama-70b-instruct
    size: 70B
    quantization: none
    maxContext: 32768
  fallback:
    name: mistral-7b-instruct
    size: 7B

resources:
  gpu:
    nodes: 8
    perNode: 4
    type: nvidia-h100
  memory:
    perPod: 64Gi

networking:
  egress: internal-only
  ingress: internal-only

registry:
  type: harbor
  url: harbor.internal.mil:443

---
# values-tier3-connected.yaml - Connected (least constrained)
global:
  tier: connected
  connectivity: external
  classification: unclassified

models:
  primary:
    name: claude-sonnet-4
    provider: anthropic
    maxContext: 200000
  fallback:
    name: llama-70b-instruct
    size: 70B

resources:
  gpu:
    nodes: dynamic
    type: cloud
  memory:
    perPod: 32Gi

networking:
  egress: allow-approved
  ingress: load-balanced

registry:
  type: ecr
  url: 123456789.dkr.ecr.us-gov-west-1.amazonaws.com
```

---

### Pattern 2: Air-Gap Deployment Playbook

**The Problem:** Air-gapped environments have zero internet connectivity. Standard deployment tools (helm pull, docker pull) don't work.

**The Solution:** Four-phase air-gap deployment: Collect → Transfer → Load → Deploy.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        AIR-GAP DEPLOYMENT PLAYBOOK                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  CONNECTED ENVIRONMENT                    AIR-GAPPED ENVIRONMENT            │
│  (Internet access)                        (No internet)                     │
│                                                                             │
│  ┌─────────────────────┐                                                   │
│  │  PHASE 1: COLLECT   │                                                   │
│  │                     │                                                   │
│  │  • Pull all images  │                                                   │
│  │  • Download charts  │                                                   │
│  │  • Gather deps      │                                                   │
│  │  • Package docs     │                                                   │
│  └──────────┬──────────┘                                                   │
│             │                                                               │
│             ▼                                                               │
│  ┌─────────────────────┐                                                   │
│  │  PHASE 2: TRANSFER  │                                                   │
│  │                     │                                                   │
│  │  • Create tarball   │                                                   │
│  │  • Burn to media    │ ────────────────────────────────►  ┌───────────┐ │
│  │  • Verify checksum  │         (Sneakernet/DVDX)          │  MEDIA    │ │
│  │  • Sign package     │                                    │  IMPORT   │ │
│  └─────────────────────┘                                    └─────┬─────┘ │
│                                                                   │       │
│                                                                   ▼       │
│                                                   ┌─────────────────────┐ │
│                                                   │  PHASE 3: LOAD      │ │
│                                                   │                     │ │
│                                                   │  • Extract tarball  │ │
│                                                   │  • Push to registry │ │
│                                                   │  • Install charts   │ │
│                                                   │  • Verify integrity │ │
│                                                   └──────────┬──────────┘ │
│                                                              │            │
│                                                              ▼            │
│                                                   ┌─────────────────────┐ │
│                                                   │  PHASE 4: DEPLOY    │ │
│                                                   │                     │ │
│                                                   │  • helm install     │ │
│                                                   │  • kubectl apply    │ │
│                                                   │  • Smoke test       │ │
│                                                   │  • Enable agents    │ │
│                                                   └─────────────────────┘ │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Phase 1: Collect Script**

```bash
#!/bin/bash
# collect-airgap-bundle.sh - Run in connected environment

set -euo pipefail

BUNDLE_DIR="airgap-bundle-$(date +%Y%m%d)"
mkdir -p "$BUNDLE_DIR"/{images,charts,docs,models}

echo "=== Phase 1: Collecting Air-Gap Bundle ==="

# 1. Pull and save container images
echo "Pulling container images..."
IMAGES=(
    "ai-platform/etl-service:v1.2.0"
    "ai-platform/inference:v1.2.0"
    "ai-platform/gateway:v1.2.0"
    "ai-platform/ui:v1.2.0"
    "postgres:15"
    "redis:7"
    "neo4j:5"
)

for img in "${IMAGES[@]}"; do
    echo "  Pulling $img"
    docker pull "$img"
    docker save "$img" | gzip > "$BUNDLE_DIR/images/$(echo $img | tr '/:' '-').tar.gz"
done

# 2. Download Helm charts
echo "Packaging Helm charts..."
helm package ./charts/ai-platform -d "$BUNDLE_DIR/charts"
helm dep update ./charts/ai-platform
cp -r ./charts/ai-platform/charts "$BUNDLE_DIR/charts/dependencies"

# 3. Download model weights
echo "Downloading model weights..."
huggingface-cli download mistralai/Mistral-7B-Instruct-v0.2 \
    --local-dir "$BUNDLE_DIR/models/mistral-7b"

# 4. Bundle documentation
echo "Bundling documentation..."
cp -r ./docs "$BUNDLE_DIR/docs"
cp ./INSTALL-AIRGAP.md "$BUNDLE_DIR/"

# 5. Create manifest
echo "Creating manifest..."
cat > "$BUNDLE_DIR/manifest.yaml" << EOF
version: 1.2.0
created: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
tier: edge
images:
$(for img in "${IMAGES[@]}"; do echo "  - $img"; done)
charts:
  - ai-platform-1.2.0.tgz
models:
  - mistral-7b-instruct-v0.2
checksum: $(sha256sum "$BUNDLE_DIR"/* | sha256sum | cut -d' ' -f1)
EOF

# 6. Create final tarball
echo "Creating final tarball..."
tar -czvf "$BUNDLE_DIR.tar.gz" "$BUNDLE_DIR"
sha256sum "$BUNDLE_DIR.tar.gz" > "$BUNDLE_DIR.tar.gz.sha256"

echo "=== Bundle created: $BUNDLE_DIR.tar.gz ==="
echo "Transfer to air-gapped environment via approved media"
```

**Phase 3-4: Load and Deploy Script**

```bash
#!/bin/bash
# deploy-airgap-bundle.sh - Run in air-gapped environment

set -euo pipefail

BUNDLE="$1"
REGISTRY="registry.local:5000"
NAMESPACE="ai-platform"

echo "=== Phase 3: Loading Air-Gap Bundle ==="

# 1. Extract bundle
echo "Extracting bundle..."
tar -xzvf "$BUNDLE"
BUNDLE_DIR="${BUNDLE%.tar.gz}"

# 2. Verify checksum
echo "Verifying integrity..."
sha256sum -c "$BUNDLE.sha256"

# 3. Load images into local registry
echo "Loading images to registry..."
for img_archive in "$BUNDLE_DIR/images"/*.tar.gz; do
    echo "  Loading $(basename $img_archive)"
    gunzip -c "$img_archive" | docker load

    # Re-tag for local registry
    original_tag=$(docker images --format '{{.Repository}}:{{.Tag}}' | head -1)
    local_tag="$REGISTRY/${original_tag##*/}"
    docker tag "$original_tag" "$local_tag"
    docker push "$local_tag"
done

# 4. Load model weights
echo "Loading model weights..."
kubectl create configmap model-weights \
    --from-file="$BUNDLE_DIR/models/" \
    -n "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

echo "=== Phase 4: Deploying ==="

# 5. Install Helm chart
echo "Installing Helm chart..."
helm upgrade --install ai-platform \
    "$BUNDLE_DIR/charts/ai-platform-1.2.0.tgz" \
    -f values-tier1-edge.yaml \
    -n "$NAMESPACE" \
    --create-namespace \
    --set global.registry="$REGISTRY" \
    --wait --timeout 10m

# 6. Smoke test
echo "Running smoke tests..."
kubectl run smoke-test --rm -it --restart=Never \
    --image="$REGISTRY/ai-platform/inference:v1.2.0" \
    -- /bin/sh -c "curl -s http://ai-platform-gateway/health"

echo "=== Deployment complete ==="
kubectl get pods -n "$NAMESPACE"
```

---

### Pattern 3: Classification Boundary Enforcement

**The Problem:** In multi-level security environments, data cannot cross classification boundaries. Agents must respect these boundaries.

**The Solution:** Namespace-based isolation with NetworkPolicy enforcement.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CLASSIFICATION BOUNDARY ENFORCEMENT                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  KUBERNETES CLUSTER                                                         │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    NAMESPACE: unclassified                          │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐                             │   │
│  │  │ Agent A │  │ Agent B │  │ Gateway │                             │   │
│  │  └─────────┘  └─────────┘  └─────────┘                             │   │
│  │                                                                      │   │
│  │  NetworkPolicy: Allow ingress from unclassified only                │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│         │                                                                   │
│         │ ✗ BLOCKED                                                        │
│         ▼                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    NAMESPACE: secret                                │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐                             │   │
│  │  │ Agent C │  │ Agent D │  │   DB    │                             │   │
│  │  └─────────┘  └─────────┘  └─────────┘                             │   │
│  │                                                                      │   │
│  │  NetworkPolicy: Allow ingress from secret only                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│         │                                                                   │
│         │ ✗ BLOCKED                                                        │
│         ▼                                                                   │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    NAMESPACE: top-secret                            │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐                             │   │
│  │  │ Agent E │  │ Agent F │  │   DB    │                             │   │
│  │  └─────────┘  └─────────┘  └─────────┘                             │   │
│  │                                                                      │   │
│  │  NetworkPolicy: Allow ingress from top-secret only                  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│  ENFORCEMENT: NetworkPolicies + PodSecurityPolicies + RBAC                 │
└─────────────────────────────────────────────────────────────────────────────┘
```

**NetworkPolicy Definition:**

```yaml
# networkpolicy-secret-namespace.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: classification-boundary
  namespace: secret
spec:
  # Apply to all pods in this namespace
  podSelector: {}

  policyTypes:
    - Ingress
    - Egress

  # Only allow traffic from same namespace
  ingress:
    - from:
        - podSelector: {}  # Same namespace only

  # Only allow traffic to same namespace + system services
  egress:
    # Same namespace
    - to:
        - podSelector: {}

    # DNS (kube-system)
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: kube-system
        - podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53

---
# RBAC: Prevent cross-namespace access
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: agent-role
  namespace: secret
rules:
  # Can only access resources in own namespace
  - apiGroups: [""]
    resources: ["pods", "services", "configmaps"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["fractal.ai"]
    resources: ["kagents", "shardruns", "toolcalls"]
    verbs: ["get", "list", "watch", "create", "update"]
  # Cannot access secrets from other namespaces
  # (ClusterRole would be needed for that)
```

**Classification-Aware Agent Configuration:**

```yaml
# kagent-secret.yaml
apiVersion: fractal.ai/v1alpha1
kind: KAgent
metadata:
  name: research-agent
  namespace: secret  # Deployed to secret namespace
  labels:
    classification: secret
spec:
  # Agent configuration
  image: registry.local:5000/ai-platform/agent:v1.2.0
  model: mistral-7b-instruct

  # Classification constraints
  classification:
    level: secret
    allowedDataSources:
      - secret-data-store
      - secret-knowledge-base
    deniedDataSources:
      - unclassified-*
      - top-secret-*

  # Cannot make external calls
  networking:
    egress:
      allowed: false

  # Audit all tool calls
  audit:
    enabled: true
    logLevel: debug
    destination: splunk-secret
```

---

### Pattern 4: Multi-Tenancy via Namespaces

**The Problem:** Multiple teams need isolated agent environments within the same cluster.

**The Solution:** Team-per-namespace isolation with resource quotas and network policies.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       MULTI-TENANCY ARCHITECTURE                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  SHARED CLUSTER                                                             │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    SHARED SERVICES (kube-system, etc.)              │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐               │   │
│  │  │   DNS   │  │ Ingress │  │ Registry│  │Monitoring│               │   │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────┘               │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│         │                   │                   │                           │
│         ▼                   ▼                   ▼                           │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐                    │
│  │  TEAM-ALPHA │    │  TEAM-BETA  │    │  TEAM-GAMMA │                    │
│  │  namespace  │    │  namespace  │    │  namespace  │                    │
│  │             │    │             │    │             │                    │
│  │ ┌─────────┐ │    │ ┌─────────┐ │    │ ┌─────────┐ │                    │
│  │ │ Agents  │ │    │ │ Agents  │ │    │ │ Agents  │ │                    │
│  │ └─────────┘ │    │ └─────────┘ │    │ └─────────┘ │                    │
│  │ ┌─────────┐ │    │ ┌─────────┐ │    │ ┌─────────┐ │                    │
│  │ │   DB    │ │    │ │   DB    │ │    │ │   DB    │ │                    │
│  │ └─────────┘ │    │ └─────────┘ │    │ └─────────┘ │                    │
│  │             │    │             │    │             │                    │
│  │ Quota: 10Gi │    │ Quota: 20Gi │    │ Quota: 15Gi │                    │
│  │ GPU: 2      │    │ GPU: 4      │    │ GPU: 3      │                    │
│  └─────────────┘    └─────────────┘    └─────────────┘                    │
│         │                   │                   │                           │
│         └───────────────────┼───────────────────┘                           │
│                             │                                               │
│                    ┌────────┴────────┐                                     │
│                    │  NetworkPolicy  │                                     │
│                    │  ISOLATES ALL   │                                     │
│                    └─────────────────┘                                     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Namespace Template (Helm):**

```yaml
# templates/tenant-namespace.yaml
{{- range .Values.tenants }}
---
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .name }}
  labels:
    team: {{ .name }}
    tier: {{ $.Values.global.tier }}
---
# Resource quota per tenant
apiVersion: v1
kind: ResourceQuota
metadata:
  name: {{ .name }}-quota
  namespace: {{ .name }}
spec:
  hard:
    requests.cpu: {{ .quota.cpu }}
    requests.memory: {{ .quota.memory }}
    requests.nvidia.com/gpu: {{ .quota.gpu }}
    persistentvolumeclaims: {{ .quota.pvcs }}
    pods: {{ .quota.pods }}
---
# Network isolation
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: tenant-isolation
  namespace: {{ .name }}
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector: {}  # Same namespace only
  egress:
    - to:
        - podSelector: {}  # Same namespace
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: kube-system
      ports:
        - port: 53
          protocol: UDP
---
# BudgetQuota per tenant
apiVersion: fractal.ai/v1alpha1
kind: BudgetQuota
metadata:
  name: {{ .name }}-budget
  namespace: {{ .name }}
spec:
  limits:
    maxTotalTokens: {{ .budget.tokens }}
    maxTotalCost: {{ .budget.cost | quote }}
    maxConcurrentRuns: {{ .budget.concurrency }}
{{- end }}
```

**Tenant Values:**

```yaml
# values-tenants.yaml
tenants:
  - name: team-alpha
    quota:
      cpu: "10"
      memory: "20Gi"
      gpu: "2"
      pvcs: "5"
      pods: "20"
    budget:
      tokens: 1000000
      cost: "$100.00"
      concurrency: 5

  - name: team-beta
    quota:
      cpu: "20"
      memory: "40Gi"
      gpu: "4"
      pvcs: "10"
      pods: "40"
    budget:
      tokens: 2000000
      cost: "$200.00"
      concurrency: 10

  - name: team-gamma
    quota:
      cpu: "15"
      memory: "30Gi"
      gpu: "3"
      pvcs: "7"
      pods: "30"
    budget:
      tokens: 1500000
      cost: "$150.00"
      concurrency: 7
```

---

### Pattern 5: Helm Chart Structure (86 Templates)

**The Problem:** Complex agent deployments require many interdependent resources.

**The Solution:** Comprehensive Helm chart with all components, configurable per tier.

```
ai-platform/
├── Chart.yaml
├── values.yaml                    # Defaults
├── values-tier1-edge.yaml         # Edge overrides
├── values-tier2-datacenter.yaml   # Datacenter overrides
├── values-tier3-connected.yaml    # Connected overrides
│
├── templates/
│   ├── _helpers.tpl               # Template helpers
│   │
│   ├── # CORE INFRASTRUCTURE (20 templates)
│   ├── namespace.yaml
│   ├── configmap-global.yaml
│   ├── secret-credentials.yaml
│   ├── pvc-models.yaml
│   ├── pvc-data.yaml
│   ├── networkpolicy-default.yaml
│   ├── resourcequota.yaml
│   ├── limitrange.yaml
│   ├── podsecuritypolicy.yaml
│   ├── serviceaccount.yaml
│   ├── role.yaml
│   ├── rolebinding.yaml
│   ├── clusterrole.yaml
│   ├── clusterrolebinding.yaml
│   ├── priorityclass.yaml
│   ├── poddisruptionbudget.yaml
│   ├── horizontalpodautoscaler.yaml
│   ├── verticalpodautoscaler.yaml
│   ├── podmonitor.yaml
│   ├── servicemonitor.yaml
│   │
│   ├── # AGENT INFRASTRUCTURE (15 templates)
│   ├── kagent-crd.yaml
│   ├── shardrun-crd.yaml
│   ├── toolcall-crd.yaml
│   ├── budgetquota-crd.yaml
│   ├── blackboard-crd.yaml
│   ├── controller-deployment.yaml
│   ├── controller-service.yaml
│   ├── webhook-deployment.yaml
│   ├── webhook-service.yaml
│   ├── webhook-certificate.yaml
│   ├── validatingwebhook.yaml
│   ├── mutatingwebhook.yaml
│   ├── agent-configmap.yaml
│   ├── agent-secret.yaml
│   ├── default-budgetquota.yaml
│   │
│   ├── # INFERENCE SERVICE (12 templates)
│   ├── inference-deployment.yaml
│   ├── inference-service.yaml
│   ├── inference-configmap.yaml
│   ├── inference-hpa.yaml
│   ├── inference-pdb.yaml
│   ├── inference-networkpolicy.yaml
│   ├── model-loader-job.yaml
│   ├── model-pvc.yaml
│   ├── vllm-deployment.yaml
│   ├── vllm-service.yaml
│   ├── triton-deployment.yaml
│   ├── triton-service.yaml
│   │
│   ├── # ETL SERVICE (10 templates)
│   ├── etl-deployment.yaml
│   ├── etl-service.yaml
│   ├── etl-configmap.yaml
│   ├── etl-cronjob.yaml
│   ├── etl-job-template.yaml
│   ├── etl-pvc.yaml
│   ├── etl-networkpolicy.yaml
│   ├── etl-hpa.yaml
│   ├── etl-secret.yaml
│   ├── etl-serviceaccount.yaml
│   │
│   ├── # GATEWAY/UI (8 templates)
│   ├── gateway-deployment.yaml
│   ├── gateway-service.yaml
│   ├── gateway-ingress.yaml
│   ├── gateway-configmap.yaml
│   ├── ui-deployment.yaml
│   ├── ui-service.yaml
│   ├── ui-configmap.yaml
│   ├── ui-ingress.yaml
│   │
│   ├── # DATA STORES (12 templates)
│   ├── postgres-statefulset.yaml
│   ├── postgres-service.yaml
│   ├── postgres-pvc.yaml
│   ├── postgres-secret.yaml
│   ├── postgres-configmap.yaml
│   ├── neo4j-statefulset.yaml
│   ├── neo4j-service.yaml
│   ├── neo4j-pvc.yaml
│   ├── redis-statefulset.yaml
│   ├── redis-service.yaml
│   ├── qdrant-statefulset.yaml
│   ├── qdrant-service.yaml
│   │
│   ├── # OBSERVABILITY (9 templates)
│   ├── prometheus-rules.yaml
│   ├── grafana-dashboard-agents.yaml
│   ├── grafana-dashboard-inference.yaml
│   ├── grafana-dashboard-budgets.yaml
│   ├── alertmanager-config.yaml
│   ├── langfuse-deployment.yaml
│   ├── langfuse-service.yaml
│   ├── langfuse-configmap.yaml
│   ├── langfuse-secret.yaml
│   │
│   └── # TESTS (varies)
│       ├── test-connection.yaml
│       ├── test-inference.yaml
│       └── test-agent.yaml
│
└── charts/                        # Dependencies
    ├── postgresql/
    ├── redis/
    ├── neo4j/
    └── qdrant/
```

---

### Anti-Patterns for Production Packaging

**❌ Anti-Pattern 1: Single Deployment Model**
```
Wrong: One values.yaml for all environments
       helm install ai-platform -f values.yaml

Right: Tier-specific values
       helm install ai-platform -f values.yaml -f values-tier1-edge.yaml
```

**❌ Anti-Pattern 2: Internet-Dependent Deployment**
```
Wrong: Helm install pulls from internet
       helm install ai-platform oci://registry.io/ai-platform

Right: Air-gap bundle with local registry
       helm install ai-platform ./charts/ai-platform \
           --set global.registry=registry.local:5000
```

**❌ Anti-Pattern 3: Trust-Based Isolation**
```
Wrong: "Teams won't access each other's namespaces"
       # No NetworkPolicies

Right: Infrastructure-enforced isolation
       NetworkPolicy + RBAC + ResourceQuota
```

---

### Production Checklist for Package Deployment

```markdown
## Package Deployment Checklist

### Tier Selection
- [ ] Tier identified (Edge/Datacenter/Connected)
- [ ] Values file selected for tier
- [ ] Connectivity constraints documented
- [ ] Model selection matches tier capabilities

### Air-Gap (if Tier 1/2)
- [ ] All images collected and archived
- [ ] Helm charts packaged
- [ ] Model weights bundled
- [ ] Checksums verified
- [ ] Transfer media approved

### Classification (if IC)
- [ ] Namespace matches classification level
- [ ] NetworkPolicies block cross-namespace traffic
- [ ] RBAC limits access to own namespace
- [ ] Audit logging enabled

### Multi-Tenancy
- [ ] Namespace per team created
- [ ] ResourceQuota applied
- [ ] BudgetQuota applied
- [ ] Network isolation verified

### Helm Deployment
- [ ] Chart version matches manifest
- [ ] Values overrides applied
- [ ] Dependencies resolved
- [ ] helm test passes
- [ ] Smoke tests pass
```

---

**Remember:** Domain knowledge is valuable. Package it, version it, share it. Packages enable instant productivity in new domains. Build once, reuse everywhere. The first package takes years. The second takes weeks. The third takes days. Compound your knowledge investment.
