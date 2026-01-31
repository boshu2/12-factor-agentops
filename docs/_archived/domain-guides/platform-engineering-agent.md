# Platform Engineering Agent Design

**A 12-Factor AgentOps Implementation for Infrastructure Automation**

---

## Overview

This document defines a platform engineering agent designed to automate Kubernetes infrastructure, CI/CD pipelines, and cloud resource management while maintaining reliability, observability, and continuous learning.

**Target Outcomes:**
- 40x speedup for Kubernetes application deployment
- 95%+ success rate through validation gates
- Sub-40% context utilization at all times
- Continuous pattern extraction and reuse

---

## Agent Architecture

### Core Design Principles

```
┌─────────────────────────────────────────────────────────────┐
│                    ORCHESTRATOR AGENT                        │
│  - Routes tasks to appropriate workflows                     │
│  - Manages context budget (stays under 20%)                  │
│  - Coordinates sub-agents                                    │
│  - Enforces validation gates                                 │
└─────────────────┬───────────────────────────────────────────┘
                  │
    ┌─────────────┼─────────────┬─────────────┬─────────────┐
    ▼             ▼             ▼             ▼             ▼
┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐
│Research│  │  Plan  │  │Implement│  │Validate│  │ Learn  │
│ Agent  │  │ Agent  │  │  Agent  │  │ Agent  │  │ Agent  │
└────────┘  └────────┘  └────────┘  └────────┘  └────────┘
```

### Factor Alignment

| Factor | Implementation |
|--------|----------------|
| I. Automated Tracking | Semantic commits with Context/Solution/Learning/Impact |
| II. Context Loading | JIT loading, sub-agent delegation, bundle compression |
| III. Focused Agents | Single-responsibility sub-agents |
| IV. Continuous Validation | Pre-commit, dry-run, human gates |
| V. Measure Everything | Success rate, context utilization, time savings |
| VI. Resume Work | Compressed bundles for multi-day projects |
| VII. Smart Routing | Route by task complexity and type |
| VIII. Human Validation | Gates between research→plan→implement |
| IX. Mine Patterns | Post-session pattern extraction |
| X. Small Iterations | 20% time for system improvement |
| XI. Fail-Safe Checks | Pre-commit/push hooks, command denylists |
| XII. Package Patterns | Reusable infrastructure profiles |

---

## Sub-Agent Definitions

### 1. Research Agent

**Responsibility:** Deep investigation with isolated context

```yaml
name: research-agent
role: Investigate infrastructure patterns and approaches
context_budget: 60%  # Can use more since isolated
outputs:
  - research_bundle (compressed to 5:1)
  - approach_recommendations
  - trade_off_analysis

triggers:
  - New technology evaluation
  - Architecture decisions
  - Problem investigation
  - Pattern discovery

example_tasks:
  - "Research Redis operator deployment options"
  - "Evaluate GitOps tools: ArgoCD vs Flux"
  - "Investigate StatefulSet patterns for databases"
```

### 2. Plan Agent

**Responsibility:** Design solutions with validation criteria

```yaml
name: plan-agent
role: Create implementation plans with success criteria
context_budget: 40%
inputs:
  - research_bundle
  - requirements
outputs:
  - implementation_plan
  - validation_criteria
  - rollback_procedure

structure:
  goals: What we're achieving
  approach: How we'll achieve it
  steps: Ordered implementation steps
  validation: How to verify success
  rollback: How to undo if needed

example_output:
  goals:
    - Deploy Redis Operator to production
    - Configure 5-replica high-availability
  steps:
    - Create Kustomize base structure
    - Download Redis Operator manifests
    - Create production overlay
    - Apply with dry-run validation
    - Deploy to cluster
```

### 3. Implement Agent

**Responsibility:** Execute plans with continuous validation

```yaml
name: implement-agent
role: Execute implementation steps with validation
context_budget: 40%
inputs:
  - implementation_plan
  - validation_criteria
outputs:
  - changes_made
  - validation_results
  - commit_messages

behavior:
  - Execute one step at a time
  - Validate after each step
  - Stop on validation failure
  - Create semantic commits

validation_gates:
  pre_action:
    - Syntax check (YAML, HCL)
    - Dry-run (kubectl --dry-run)
    - Policy check (OPA/Kyverno)
  post_action:
    - Resource exists
    - Health check passes
    - Tests pass
```

### 4. Validate Agent

**Responsibility:** Run comprehensive validation suites

```yaml
name: validate-agent
role: Execute validation pipelines
context_budget: 30%
inputs:
  - validation_criteria
  - target_resources
outputs:
  - validation_report
  - pass/fail status
  - remediation_hints

validation_types:
  syntax:
    - yamllint
    - kubeval
    - kustomize build
  security:
    - trivy (container scanning)
    - kubesec
    - secret detection
  policy:
    - OPA/Gatekeeper
    - Kyverno
  functional:
    - kubectl get/describe
    - readiness probes
    - integration tests
```

### 5. Learn Agent

**Responsibility:** Extract patterns and update knowledge base

```yaml
name: learn-agent
role: Extract learnings and mine patterns
context_budget: 30%
inputs:
  - session_transcript
  - outcomes
  - metrics
outputs:
  - extracted_patterns
  - improvement_backlog
  - updated_documentation

pattern_types:
  solution_patterns:
    - "Kustomize base/overlay for operators"
    - "StatefulSet with PVC templates"
  anti_patterns:
    - "Hardcoded replicas in base"
    - "Secrets in ConfigMaps"
  optimizations:
    - "Use strategic merge patches"
    - "Externalize config to ConfigMaps"
```

---

## Workflow Definitions

### Primary Workflow: Infrastructure Change

```yaml
name: infrastructure-change
description: Standard workflow for infrastructure modifications
phases:
  - prime
  - research
  - plan
  - implement
  - learn

gates:
  research_to_plan:
    type: human
    prompt: "Review research findings. Approve to proceed with planning?"
  plan_to_implement:
    type: human
    prompt: "Review implementation plan. Approve to proceed?"
  implement_to_production:
    type: human
    prompt: "Staging validated. Approve production deployment?"
```

#### Phase Details

**Phase 1: Prime**
```yaml
purpose: Define problem and constraints
outputs:
  - problem_statement
  - success_criteria
  - constraints
  - scope

example:
  problem: "Deploy Redis Operator with HA configuration"
  success_criteria:
    - Redis Operator pod running
    - Redis cluster with 5 replicas
    - Persistent storage configured
  constraints:
    - Use Kustomize (not Helm)
    - Target production namespace
```

**Phase 2: Research**
```yaml
purpose: Investigate approaches and gather context
agent: research-agent
outputs:
  - research_bundle (compressed)
  - recommended_approach
  - trade_offs

activities:
  - Evaluate deployment options
  - Research best practices
  - Identify potential issues
  - Document trade-offs

compression:
  input_tokens: ~5000
  output_tokens: ~1000
  ratio: 5:1
```

**Phase 3: Plan**
```yaml
purpose: Design implementation with validation criteria
agent: plan-agent
inputs:
  - research_bundle
  - success_criteria
outputs:
  - implementation_plan
  - validation_gates
  - rollback_procedure

structure:
  directory_layout: |
    kustomization/
    ├── base/
    │   ├── kustomization.yaml
    │   ├── namespace.yaml
    │   └── redis-operator/
    └── overlays/
        └── production/
            ├── kustomization.yaml
            └── patches/
  steps:
    - step: "Create directory structure"
      validation: "Directory exists"
    - step: "Download operator manifests"
      validation: "Files present, YAML valid"
    - step: "Create Kustomize base"
      validation: "kustomize build succeeds"
```

**Phase 4: Implement**
```yaml
purpose: Execute plan with continuous validation
agent: implement-agent
inputs:
  - implementation_plan
outputs:
  - deployed_resources
  - validation_results
  - git_commits

execution:
  for_each_step:
    - Load step context (JIT)
    - Execute action
    - Run validation gate
    - If pass: commit and continue
    - If fail: stop and report
```

**Phase 5: Learn**
```yaml
purpose: Extract patterns and improve system
agent: learn-agent
inputs:
  - session_transcript
  - outcomes
outputs:
  - patterns_extracted
  - documentation_updates
  - improvement_backlog

activities:
  - What worked well?
  - What patterns to reuse?
  - What to improve next time?
  - Update knowledge base
```

### Quick Workflow: Simple Changes

```yaml
name: quick-change
description: Streamlined workflow for simple, well-understood changes
phases:
  - validate_simplicity
  - implement
  - validate

criteria:
  - Single resource change
  - Known pattern exists
  - Low risk (non-production or reversible)

example_tasks:
  - Update ConfigMap values
  - Scale deployment replicas
  - Add labels/annotations
```

### Emergency Workflow: Incident Response

```yaml
name: incident-response
description: Rapid response with reduced gates
phases:
  - diagnose
  - mitigate
  - implement_fix
  - post_mortem

special_rules:
  - Skip research phase
  - Reduced human gates
  - Immediate rollback available
  - Mandatory post-mortem learning
```

---

## Validation Gates

### Pre-Commit Hooks

```yaml
hooks:
  yaml_syntax:
    command: "yamllint -c .yamllint.yaml"
    description: "Validate YAML syntax"

  kustomize_build:
    command: "kustomize build"
    description: "Validate Kustomize renders"

  secret_detection:
    command: "detect-secrets scan"
    description: "Prevent secrets in commits"

  kubeval:
    command: "kubeval --strict"
    description: "Validate against K8s schemas"
```

### Pre-Push Hooks

```yaml
hooks:
  container_tests:
    command: "make test-containers"
    description: "Run container test suite"

  integration_tests:
    command: "make test-integration"
    description: "Run integration tests"

  policy_check:
    command: "conftest test"
    description: "Validate against policies"
```

### Deployment Gates

```yaml
gates:
  dry_run:
    command: "kubectl apply --dry-run=server"
    description: "Server-side validation"
    required: true

  diff_review:
    command: "kubectl diff"
    description: "Show changes before apply"
    required: true

  human_approval:
    type: "manual"
    description: "Human reviews diff"
    required_for:
      - production
      - stateful resources

  health_check:
    command: "kubectl rollout status"
    description: "Wait for healthy state"
    timeout: "5m"
```

---

## Context Management

### Context Budget Allocation

```yaml
context_limits:
  orchestrator:
    target: 20%
    warning: 30%
    critical: 40%

  sub_agents:
    target: 40%
    warning: 50%
    critical: 60%

strategies:
  under_40:
    action: "Normal operation"
  40_to_60:
    action: "Delegate to sub-agent or compress"
  over_60:
    action: "Stop adding context, compress existing"
```

### Bundle System

```yaml
bundle_types:
  research_bundle:
    purpose: "Compressed research findings"
    compression_ratio: "5:1"
    contents:
      - key_findings
      - recommended_approach
      - trade_offs
      - references

  context_bundle:
    purpose: "Session resumption"
    compression_ratio: "5:1 to 10:1"
    contents:
      - problem_statement
      - decisions_made
      - current_state
      - next_steps

  pattern_bundle:
    purpose: "Reusable solution patterns"
    contents:
      - pattern_name
      - problem_context
      - solution_template
      - validation_criteria
```

### Multi-Day Project Support

```yaml
day_1:
  phase: research
  input_tokens: 5000
  output: research_bundle (1000 tokens)

day_2:
  phase: plan
  input: research_bundle (1000 tokens)
  additional_context: 2000 tokens
  total: 3000 tokens (under 40%)
  output: plan_bundle (800 tokens)

day_3:
  phase: implement
  input:
    - research_bundle (1000)
    - plan_bundle (800)
  additional_context: 1500 tokens
  total: 3300 tokens (under 40%)
```

---

## Observability & Metrics

### Key Metrics

```yaml
success_metrics:
  task_success_rate:
    target: ">95%"
    measurement: "completed_tasks / total_tasks"

  context_utilization:
    target: "<40%"
    measurement: "used_tokens / max_tokens"

  bundle_reuse_rate:
    target: ">30%"
    measurement: "bundle_loads / total_tasks"

efficiency_metrics:
  time_saved:
    measurement: "baseline_time - actual_time"
    baseline: "4 hours for k8s app creation"

  compression_ratio:
    target: "5:1 to 10:1"
    measurement: "original_tokens / bundle_tokens"

quality_metrics:
  validation_pass_rate:
    target: ">90% first attempt"
    measurement: "first_pass / total_validations"

  pattern_extraction_rate:
    target: ">1 per session"
    measurement: "patterns_extracted / sessions"
```

### Logging Structure

```yaml
log_format:
  timestamp: ISO8601
  agent: "orchestrator|research|plan|implement|validate|learn"
  phase: "prime|research|plan|implement|learn"
  action: "action description"
  context_utilization: "percentage"
  outcome: "success|failure|skipped"
  duration_ms: "milliseconds"

example:
  timestamp: "2024-01-15T10:30:00Z"
  agent: "implement-agent"
  phase: "implement"
  action: "Apply Kustomize overlay"
  context_utilization: "35%"
  outcome: "success"
  duration_ms: 1250
```

### Dashboards

```yaml
dashboard_panels:
  - title: "Success Rate (24h)"
    type: gauge
    query: success_rate
    thresholds: [90, 95]

  - title: "Context Utilization"
    type: gauge
    query: avg_context_utilization
    thresholds: [40, 60]

  - title: "Tasks by Phase"
    type: bar
    query: task_count by phase

  - title: "Bundle Compression Ratio"
    type: timeseries
    query: compression_ratio over time

  - title: "Validation Failures"
    type: table
    query: failed_validations
    columns: [timestamp, gate, resource, error]
```

---

## Pattern Library

### Kubernetes Patterns

#### Kustomize Base/Overlay

```yaml
pattern_name: kustomize-base-overlay
problem: "Deploy operator with environment-specific config"
solution:
  structure: |
    kustomization/
    ├── base/
    │   ├── kustomization.yaml
    │   ├── namespace.yaml
    │   └── operator/
    └── overlays/
        ├── staging/
        └── production/
            ├── kustomization.yaml
            └── patches/
  key_points:
    - Base contains environment-agnostic resources
    - Overlays contain only differences
    - Use strategic merge patches
validation:
  - "kustomize build overlays/production"
  - "kubectl apply --dry-run=server"
```

#### StatefulSet for Databases

```yaml
pattern_name: statefulset-database
problem: "Deploy database with persistent storage"
solution:
  template: |
    apiVersion: apps/v1
    kind: StatefulSet
    spec:
      serviceName: "db"
      replicas: 3
      volumeClaimTemplates:
        - metadata:
            name: data
          spec:
            accessModes: ["ReadWriteOnce"]
            resources:
              requests:
                storage: 10Gi
  key_points:
    - Use volumeClaimTemplates for PVCs
    - Set pod anti-affinity for HA
    - Include readiness probes
```

#### GitOps ApplicationSet

```yaml
pattern_name: argocd-applicationset
problem: "Manage multiple similar applications"
solution:
  template: |
    apiVersion: argoproj.io/v1alpha1
    kind: ApplicationSet
    spec:
      generators:
        - git:
            repoURL: https://github.com/org/apps
            directories:
              - path: apps/*
      template:
        spec:
          destination:
            server: https://kubernetes.default.svc
            namespace: '{{path.basename}}'
          source:
            repoURL: https://github.com/org/apps
            path: '{{path}}'
```

### Anti-Patterns

```yaml
anti_patterns:
  - name: "Hardcoded values in base"
    problem: "Makes customization difficult"
    solution: "Use patches in overlays"

  - name: "Secrets in ConfigMaps"
    problem: "Security vulnerability"
    solution: "Use Secrets or external secret management"

  - name: "Missing resource limits"
    problem: "Resource contention"
    solution: "Always set requests and limits"

  - name: "No readiness probes"
    problem: "Traffic to unready pods"
    solution: "Configure appropriate probes"
```

---

## Slash Commands

### Core Commands

```yaml
commands:
  /prime:
    description: "Start a new infrastructure task"
    triggers: prime phase
    outputs:
      - problem_statement
      - success_criteria
      - constraints

  /research:
    description: "Deep dive investigation"
    triggers: research agent
    outputs:
      - research_bundle
      - recommendations

  /plan:
    description: "Create implementation plan"
    triggers: plan agent
    inputs:
      - research_bundle
    outputs:
      - implementation_plan

  /implement:
    description: "Execute implementation"
    triggers: implement agent
    inputs:
      - implementation_plan
    outputs:
      - deployed_resources
      - commits

  /learn:
    description: "Extract patterns and learnings"
    triggers: learn agent
    outputs:
      - patterns
      - improvements
```

### Utility Commands

```yaml
commands:
  /validate:
    description: "Run validation suite"
    args:
      - resource_type
      - resource_name

  /bundle:
    description: "Create context bundle"
    args:
      - bundle_name

  /resume:
    description: "Resume from bundle"
    args:
      - bundle_name

  /metrics:
    description: "Show session metrics"
    outputs:
      - success_rate
      - context_utilization
      - time_saved
```

---

## Implementation Guide

### 1. Setup Project Structure

```bash
# Create agent configuration directory
mkdir -p .claude/agents
mkdir -p .claude/workflows
mkdir -p .claude/patterns
mkdir -p .claude/bundles
mkdir -p .claude/hooks
```

### 2. Configure Pre-Commit Hooks

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/adrienverge/yamllint
    rev: v1.32.0
    hooks:
      - id: yamllint
        args: [-c=.yamllint.yaml]

  - repo: local
    hooks:
      - id: kustomize-build
        name: Kustomize Build
        entry: bash -c 'find . -name kustomization.yaml -execdir kustomize build . \;'
        language: system
        types: [yaml]

      - id: kubeval
        name: Kubeval
        entry: kubeval --strict
        language: system
        types: [yaml]
```

### 3. Define Agent Configurations

```yaml
# .claude/agents/research-agent.yaml
name: research-agent
system_prompt: |
  You are a research agent for platform engineering tasks.
  Your role is to investigate infrastructure patterns and approaches.

  Guidelines:
  - Explore multiple options before recommending
  - Document trade-offs clearly
  - Compress findings to 5:1 ratio
  - Return structured research bundle

context_budget: 60%
output_format: research_bundle
```

### 4. Configure Workflows

```yaml
# .claude/workflows/infrastructure-change.yaml
name: infrastructure-change
phases:
  - name: prime
    agent: orchestrator
  - name: research
    agent: research-agent
    gate:
      type: human
      prompt: "Approve research findings?"
  - name: plan
    agent: plan-agent
    gate:
      type: human
      prompt: "Approve implementation plan?"
  - name: implement
    agent: implement-agent
  - name: learn
    agent: learn-agent
```

### 5. Initialize Pattern Library

```bash
# Create initial patterns
cat > .claude/patterns/kustomize-operator.yaml << 'EOF'
name: kustomize-operator
description: Deploy Kubernetes operator using Kustomize
template:
  base:
    - namespace.yaml
    - operator-deployment.yaml
    - operator-rbac.yaml
  overlay:
    - replica-patch.yaml
    - resource-patch.yaml
validation:
  - kustomize build
  - kubectl apply --dry-run=server
EOF
```

---

## Example Session

### Task: Deploy Redis Operator with HA Configuration

**User:** Deploy Redis Operator to production with 5 replicas and persistent storage

**Phase 1: Prime**
```
Problem: Deploy Redis Operator with HA configuration
Success Criteria:
  - Redis Operator pod running in redis-system namespace
  - Redis cluster with 5 replicas
  - 10Gi persistent storage per replica
Constraints:
  - Use Kustomize (company standard)
  - Target production cluster
  - Must pass security scanning
```

**Phase 2: Research** (Research Agent)
```
Research Bundle:
  Approaches Evaluated:
    1. Helm chart - rejected (company uses Kustomize)
    2. Raw YAML - rejected (hard to maintain)
    3. Kustomize + Operator - selected

  Key Findings:
    - Redis Operator supports HA with sentinel
    - Requires PVC for persistence
    - Needs RBAC for cluster-scoped operations

  Recommended Approach:
    - Use Kustomize base/overlay pattern
    - Deploy operator first, then Redis instance
    - Use strategic merge patches for prod config
```

**Human Gate:** "Research approved. Proceed with planning."

**Phase 3: Plan** (Plan Agent)
```
Implementation Plan:

Directory Structure:
  redis-operator/
  ├── base/
  │   ├── kustomization.yaml
  │   ├── namespace.yaml
  │   ├── operator/
  │   │   ├── deployment.yaml
  │   │   ├── rbac.yaml
  │   │   └── service.yaml
  │   └── redis-instance.yaml
  └── overlays/
      └── production/
          ├── kustomization.yaml
          └── patches/
              ├── replicas.yaml
              └── storage.yaml

Steps:
  1. Create directory structure
     Validation: directories exist
  2. Download Redis Operator manifests
     Validation: YAML valid
  3. Create Kustomize base
     Validation: kustomize build succeeds
  4. Create production overlay
     Validation: kustomize build overlays/production
  5. Dry-run against cluster
     Validation: kubectl apply --dry-run=server
  6. Apply to production
     Validation: pods running, replicas ready
  7. Commit with semantic message
     Validation: commit created
```

**Human Gate:** "Plan approved. Proceed with implementation."

**Phase 4: Implement** (Implement Agent)
```
Step 1: Create directory structure ✓
Step 2: Download operator manifests ✓
Step 3: Create Kustomize base ✓
  - Validated: kustomize build succeeded
Step 4: Create production overlay ✓
  - Configured: 5 replicas, 10Gi storage
  - Validated: kustomize build succeeded
Step 5: Dry-run validation ✓
  - kubectl apply --dry-run=server passed
Step 6: Deploy to production ✓
  - Operator pod: Running
  - Redis cluster: 5/5 replicas Ready
Step 7: Commit changes ✓

Commit Message:
  feat(redis): Deploy Redis Operator with HA configuration

  Context: Production requires Redis for session caching with
  high availability to meet 99.9% uptime SLA.

  Solution: Deployed Redis Operator using Kustomize base/overlay
  pattern. Production overlay configures 5 replicas with 10Gi
  persistent storage and pod anti-affinity.

  Learning: Strategic merge patches work well for replica and
  storage customization. Consider extracting operator deployment
  as reusable pattern.

  Impact: Enables session caching for production services.
  Expected to reduce API latency by 40%.
```

**Phase 5: Learn** (Learn Agent)
```
Patterns Extracted:
  1. kustomize-operator-deployment
     - Base/overlay pattern for operators
     - Strategic merge patches for config

  2. redis-ha-configuration
     - 5 replicas with sentinel
     - Pod anti-affinity for HA
     - PVC templates for storage

What Worked:
  - Kustomize build validation caught YAML errors early
  - Dry-run prevented deployment of invalid resources
  - Strategic merge patches clean for overrides

Improvement Backlog:
  - Add Prometheus ServiceMonitor for Redis metrics
  - Create backup CronJob with velero
  - Add network policy for Redis namespace
```

---

## Success Metrics Target

| Metric | Target | Measurement |
|--------|--------|-------------|
| Task Success Rate | >95% | Completed / Total |
| Context Utilization | <40% | Used / Max tokens |
| Bundle Compression | 5:1 | Original / Compressed |
| Time Savings | 40x | Baseline / Actual |
| Pattern Reuse | >30% | Bundle loads / Tasks |
| Validation Pass Rate | >90% | First pass / Total |
| Human Gate Approvals | >95% | Approved / Total |

---

## Conclusion

This platform engineering agent design implements all 12 factors of AgentOps to achieve reliable, observable, and continuously improving infrastructure automation. The key innovations are:

1. **Multi-agent architecture** with focused responsibilities
2. **Validation gates** at every phase transition
3. **Context management** with bundle compression
4. **Pattern extraction** for continuous learning
5. **Metrics-driven** operation with clear targets

By following this design, teams can achieve significant productivity gains while maintaining the reliability standards expected of production infrastructure.

---

**Version:** 1.0.0
**Author:** Platform Engineering Agent Design
**Based on:** 12-Factor AgentOps Methodology
