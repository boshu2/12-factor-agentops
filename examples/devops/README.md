# DevOps Domain - 12-Factor AgentOps Implementation

**Target Audience:** DevOps Engineers, CI/CD Specialists, Release Engineers

This example demonstrates how to apply 12-Factor AgentOps principles to DevOps workflows—CI/CD pipeline management, security scanning, progressive deployments, and infrastructure automation.

---

## What's Included

### Agents (.claude/agents/)

1. **pipeline-guide.md** - CI/CD pipeline creation and modification
   - GitLab CI and GitHub Actions patterns
   - Test-driven pipeline development
   - Performance optimization
   - Maps to: Factor III (Single-Responsibility), Factor IV (Validation Gates)

2. **security-scan.md** - Security scanning integration
   - SAST, DAST, dependency scanning
   - Container image scanning
   - Secrets detection
   - Maps to: Factor IV (Validation Gates), Factor VII (Zero-Trust)

3. **progressive-deploy.md** - Progressive delivery strategies
   - Canary deployments
   - Blue-green deployments
   - Feature flags integration
   - Maps to: Factor IV (Validation Gates), Factor X (Telemetry)

### Commands (.claude/commands/)

1. **/run-security-scans** - Quick security validation across pipelines
2. **/analyze-pipeline** - Pipeline performance analysis and optimization

---

## Quick Start

### 1. Copy to Your Repository

```bash
# Copy the entire .claude/ directory
cp -r examples/devops/.claude/ /path/to/your/repo/.claude/

# Or copy individual agents
cp examples/devops/.claude/agents/pipeline-guide.md \
   /path/to/your/repo/.claude/agents/
```

### 2. Customize for Your Stack

**Edit agents to match your tooling:**
- Replace GitLab CI examples with your CI system
- Update security scanning tools to match your stack
- Adjust deployment strategies for your environment
- Configure validation gates for your standards

### 3. Use in Claude Code

```bash
# Invoke agents directly
/agent pipeline-guide
/agent security-scan
/agent progressive-deploy

# Use slash commands
/run-security-scans
/analyze-pipeline
```

---

## How This Maps to 12-Factor AgentOps

### Foundation Tier (I-III)

**Factor I: Git Memory as Knowledge OS**
- Pipeline configurations tracked in git
- Security scan results archived with commits
- Deployment history captured in git tags
- Pattern: All infrastructure as code, all decisions documented

**Factor II: JIT Context Loading**
- Load pipeline context only when modifying CI/CD
- Load security context only during scan reviews
- Load deployment context only during releases
- Pattern: Minimize cognitive load, maximize focus

**Factor III: Single-Responsibility Agents**
- Pipeline agent handles ONLY CI/CD modifications
- Security agent handles ONLY security scanning
- Deployment agent handles ONLY progressive delivery
- Pattern: Clear boundaries, no overlap

### Validation Tier (IV-VI)

**Factor IV: Validation Gates**
- Pipeline changes tested before merge
- Security scans block on critical findings
- Deployment strategies validated in staging first
- Pattern: Fail fast, fail safe

**Factor V: Disposable Sessions**
- Each pipeline run is stateless
- Security scans run in isolated containers
- Deployments use immutable infrastructure
- Pattern: Reproducibility guaranteed

**Factor VI: Session Continuity**
- Pipeline modifications preserve previous configuration
- Security findings tracked across scans
- Deployment rollbacks preserve previous state
- Pattern: Safe iteration without data loss

### Governance Tier (VII-IX)

**Factor VII: Zero-Trust by Default**
- All secrets managed via vault systems
- Container images scanned before deployment
- Network policies enforce least privilege
- Pattern: Never trust, always verify

**Factor VIII: Compliance Validation**
- Pipeline configurations audited against policies
- Security scans enforce compliance standards
- Deployment approvals tracked for audits
- Pattern: Automated compliance, human-verified

**Factor IX: Pattern Extraction**
- Successful pipelines become templates
- Security patterns shared across teams
- Deployment strategies codified as runbooks
- Pattern: Learn once, apply everywhere

### Intelligence Tier (X-XII)

**Factor X: Telemetry and Observability**
- Pipeline metrics tracked (duration, success rate)
- Security findings aggregated (trends, vulnerabilities)
- Deployment health monitored (rollback triggers)
- Pattern: Data-driven decision making

**Factor XI: Adaptive Learning**
- Pipeline performance improves over time
- Security scans learn from false positives
- Deployment strategies adjust to traffic patterns
- Pattern: Continuous improvement

**Factor XII: Multi-Agent Orchestration**
- Pipeline + Security + Deployment work together
- Parallel scans during pipeline execution
- Coordinated deployments across environments
- Pattern: Orchestrated complexity, simple interface

---

## Common DevOps Workflows

### Daily: CI/CD Pipeline Maintenance

```bash
# Morning: Review failed pipelines
/analyze-pipeline

# Create fix using agent
/agent pipeline-guide
# Prompt: "Fix failing integration tests in gitlab-ci.yml"

# Validate changes
git diff .gitlab-ci.yml
/run-security-scans

# Commit with context
git add .gitlab-ci.yml
git commit -m "fix(ci): resolve integration test flakiness

- Updated test timeout from 5m to 10m
- Added retry logic for network calls
- Isolated database state between tests

Factor IV: Validated in test environment first
"
```

### Weekly: Security Posture Review

```bash
# Run comprehensive security scans
/run-security-scans

# Review findings with agent
/agent security-scan
# Prompt: "Analyze dependency vulnerabilities from latest scan"

# Integrate fixes
/agent pipeline-guide
# Prompt: "Add automated dependency update job to CI pipeline"

# Validate security improvements
/run-security-scans
```

### Monthly: Deployment Strategy Optimization

```bash
# Analyze deployment patterns
/agent progressive-deploy
# Prompt: "Review last month's deployments, recommend improvements"

# Implement canary deployment
/agent progressive-deploy
# Prompt: "Create canary deployment configuration for production"

# Validate rollback procedures
/agent progressive-deploy
# Prompt: "Test rollback mechanism for canary deployment"
```

### Incident: Production Deployment Failure

```bash
# 1. Immediate rollback
/agent progressive-deploy
# Prompt: "Execute blue-green rollback for production"

# 2. Analyze pipeline logs
/analyze-pipeline
# Prompt: "Find root cause of deployment failure"

# 3. Fix and validate
/agent pipeline-guide
# Prompt: "Add validation gate to prevent similar failures"

# 4. Document learning
git commit -m "postmortem(deploy): add health check validation gate

Incident: Production deployment failed due to missing health check
Root cause: Deployment succeeded but service wasn't ready
Fix: Added mandatory health check validation before traffic switch

Factor IV: New validation gate prevents premature traffic routing
Factor IX: Pattern extracted for all future deployments
"
```

---

## Real-World Examples

### Example 1: GitLab CI Pipeline with Security Scanning

```yaml
# .gitlab-ci.yml
stages:
  - validate
  - security
  - test
  - deploy

# Factor IV: Validation Gates
validate:
  stage: validate
  script:
    - yamllint .gitlab-ci.yml
    - shellcheck scripts/*.sh
  tags:
    - docker

# Factor VII: Zero-Trust Security
security:sast:
  stage: security
  script:
    - semgrep --config=auto .
  artifacts:
    reports:
      sast: gl-sast-report.json
  allow_failure: false  # Block on findings

security:dependency:
  stage: security
  script:
    - safety check --json > dependency-scan.json
  artifacts:
    reports:
      dependency_scanning: dependency-scan.json
  allow_failure: false

security:container:
  stage: security
  script:
    - trivy image --severity HIGH,CRITICAL $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  allow_failure: false

# Factor V: Disposable Sessions
test:
  stage: test
  services:
    - postgres:14
  variables:
    POSTGRES_DB: test_db
    POSTGRES_USER: test_user
    POSTGRES_PASSWORD: test_pass
  script:
    - pytest tests/ --cov --cov-report=xml
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml

# Factor XII: Multi-Agent Orchestration
deploy:staging:
  stage: deploy
  script:
    - kubectl apply -f k8s/staging/
    - kubectl rollout status deployment/app -n staging
    - ./scripts/health-check.sh staging
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

deploy:production:canary:
  stage: deploy
  script:
    # Factor X: Telemetry-driven deployment
    - kubectl apply -f k8s/production/canary.yaml
    - ./scripts/canary-analysis.sh  # Monitors metrics for 10 minutes
    - kubectl apply -f k8s/production/full.yaml
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
```

### Example 2: GitHub Actions with Progressive Deployment

```yaml
# .github/workflows/deploy.yml
name: Deploy with Canary

on:
  push:
    branches: [main]

jobs:
  # Factor IV: Validation Gates
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate Kubernetes manifests
        run: |
          kubectl --dry-run=client apply -f k8s/
      - name: Validate Helm charts
        run: |
          helm lint charts/

  # Factor VII: Zero-Trust Security
  security:
    runs-on: ubuntu-latest
    needs: validate
    steps:
      - uses: actions/checkout@v3

      - name: SAST Scan
        uses: returntocorp/semgrep-action@v1
        with:
          config: auto

      - name: Container Scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: 'ghcr.io/${{ github.repository }}:${{ github.sha }}'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  # Factor XII: Orchestrated Deployment
  deploy-canary:
    runs-on: ubuntu-latest
    needs: [validate, security]
    environment: production
    steps:
      - uses: actions/checkout@v3

      # Deploy 10% traffic to canary
      - name: Deploy Canary
        run: |
          kubectl apply -f k8s/canary.yaml
          kubectl set image deployment/app-canary \
            app=ghcr.io/${{ github.repository }}:${{ github.sha }}

      # Factor X: Telemetry-driven validation
      - name: Monitor Canary Metrics
        run: |
          ./scripts/monitor-canary.sh --duration=10m \
            --error-threshold=1% \
            --latency-threshold=500ms

      # Promote to full deployment
      - name: Promote to Production
        run: |
          kubectl apply -f k8s/production.yaml
          kubectl set image deployment/app \
            app=ghcr.io/${{ github.repository }}:${{ github.sha }}
          kubectl rollout status deployment/app

      # Factor VI: Session Continuity (rollback capability)
      - name: Save Rollback Point
        run: |
          kubectl rollout history deployment/app > rollback-${{ github.sha }}.txt
          git tag -a "deploy-${{ github.sha }}" -m "Production deployment"
          git push --tags
```

### Example 3: Security Scanning Integration

```bash
#!/bin/bash
# scripts/security-scan.sh - Factor IV + VII implementation

set -euo pipefail

echo "=== Security Scanning Suite ==="

# Factor VII: Zero-Trust - Never trust dependencies
echo "1. Dependency Scanning..."
safety check --json > reports/dependency-scan.json
if [[ $(jq '.vulnerabilities | length' reports/dependency-scan.json) -gt 0 ]]; then
  echo "❌ Vulnerable dependencies found!"
  jq '.vulnerabilities' reports/dependency-scan.json
  exit 1
fi

# Factor VII: Zero-Trust - Never trust code
echo "2. SAST Scanning..."
semgrep --config=auto --json --output=reports/sast-scan.json .
if [[ $(jq '.results | length' reports/sast-scan.json) -gt 0 ]]; then
  echo "⚠️  Security issues found in code:"
  jq '.results[] | {severity, message, path}' reports/sast-scan.json
  # Block on high/critical only
  CRITICAL=$(jq '[.results[] | select(.extra.severity == "ERROR")] | length' reports/sast-scan.json)
  if [[ $CRITICAL -gt 0 ]]; then
    echo "❌ Critical issues must be resolved!"
    exit 1
  fi
fi

# Factor VII: Zero-Trust - Never trust container images
echo "3. Container Scanning..."
trivy image --severity HIGH,CRITICAL --format json \
  --output reports/container-scan.json \
  "$IMAGE_NAME"
if [[ $(jq '.Results[].Vulnerabilities | length' reports/container-scan.json) -gt 0 ]]; then
  echo "❌ Container vulnerabilities found!"
  jq '.Results[].Vulnerabilities[] | {VulnerabilityID, Severity, PkgName}' \
    reports/container-scan.json
  exit 1
fi

# Factor VII: Zero-Trust - Never trust secrets
echo "4. Secrets Detection..."
gitleaks detect --report-path=reports/secrets-scan.json --no-git
if [[ -f reports/secrets-scan.json ]] && [[ $(jq '. | length' reports/secrets-scan.json) -gt 0 ]]; then
  echo "❌ Secrets detected in code!"
  jq '.[] | {Description, File, Match}' reports/secrets-scan.json
  exit 1
fi

# Factor IX: Pattern Extraction
echo "5. Generating Security Report..."
cat > reports/security-summary.md <<EOF
# Security Scan Summary

**Date:** $(date -u +"%Y-%m-%d %H:%M:%S UTC")
**Commit:** $(git rev-parse --short HEAD)

## Results

- ✅ Dependency Scan: No vulnerabilities
- ✅ SAST Scan: No critical issues
- ✅ Container Scan: No high/critical vulnerabilities
- ✅ Secrets Detection: No secrets found

## Factor Compliance

- Factor IV: All validation gates passed
- Factor VII: Zero-trust verification complete
- Factor IX: Security patterns validated

## Next Actions

- Monitor for new CVEs daily
- Update dependencies weekly
- Re-scan on every deployment

EOF

echo "✅ All security scans passed!"
echo "📊 Report: reports/security-summary.md"
```

---

## Customization Guide

### Adapting for Your CI System

**GitLab CI → Jenkins:**
```yaml
# GitLab CI
script:
  - pytest tests/

# Jenkins (Jenkinsfile)
steps {
  sh 'pytest tests/'
}
```

**GitLab CI → CircleCI:**
```yaml
# GitLab CI
script:
  - npm test

# CircleCI
- run:
    name: Run Tests
    command: npm test
```

**GitLab CI → GitHub Actions:**
```yaml
# GitLab CI
script:
  - cargo test

# GitHub Actions
- name: Run Tests
  run: cargo test
```

### Adapting Security Tools

**Replace Trivy with Grype:**
```bash
# Trivy
trivy image --severity HIGH,CRITICAL myimage:latest

# Grype
grype myimage:latest --fail-on high
```

**Replace Semgrep with SonarQube:**
```bash
# Semgrep
semgrep --config=auto .

# SonarQube
sonar-scanner \
  -Dsonar.projectKey=myproject \
  -Dsonar.sources=.
```

### Adapting Deployment Strategies

**Kubernetes → Docker Swarm:**
```bash
# Kubernetes canary
kubectl apply -f canary.yaml

# Docker Swarm canary
docker service update --image myapp:new \
  --update-parallelism 1 \
  --update-delay 10s \
  myapp
```

**Kubernetes → Nomad:**
```bash
# Kubernetes blue-green
kubectl apply -f blue.yaml
# Switch traffic
kubectl patch svc myapp -p '{"spec":{"selector":{"version":"blue"}}}'

# Nomad blue-green
nomad job run blue.nomad
# Update service discovery
consul kv put service/myapp/version blue
```

---

## Validation Checklist

Before using these agents in production, validate:

- [ ] **Factor I:** Pipeline configs tracked in git with meaningful commit messages
- [ ] **Factor II:** Agents load only relevant context (not entire codebase)
- [ ] **Factor III:** Each agent has single responsibility (no pipeline+security combo)
- [ ] **Factor IV:** Validation gates prevent bad deployments (tested in staging)
- [ ] **Factor V:** Pipeline runs are reproducible (same inputs = same outputs)
- [ ] **Factor VI:** Can resume deployments after interruption
- [ ] **Factor VII:** All secrets managed externally (vault, not env vars)
- [ ] **Factor VIII:** Compliance requirements automated (not manual checks)
- [ ] **Factor IX:** Successful patterns documented as templates
- [ ] **Factor X:** Metrics tracked for all deployments (success rate, duration)
- [ ] **Factor XI:** Pipeline improvements based on historical data
- [ ] **Factor XII:** Agents coordinate without human intervention

---

## Common Pitfalls and Solutions

### Pitfall 1: Pipeline Configuration Drift

**Problem:** Multiple teams edit `.gitlab-ci.yml` without coordination
**Solution (Factor I):** Git-based review process + validation gates

```bash
# Require approval for CI changes
git-branch-protection .gitlab-ci.yml --approvers=2

# Validate before merge
/agent pipeline-guide
# Prompt: "Review this pipeline change for best practices"
```

### Pitfall 2: Security Scan Fatigue

**Problem:** Too many false positives, teams ignore security findings
**Solution (Factor XI):** Adaptive learning + tuned severity thresholds

```bash
# Start strict, tune over time
/agent security-scan
# Prompt: "Analyze last 30 days of scans, recommend threshold adjustments"

# Document exceptions
git commit -m "security: tune SAST rules to reduce false positives

- Disabled rule XYZ (100% false positive rate over 90 days)
- Raised threshold for rule ABC (only block on HIGH severity)

Factor XI: Learning from historical data
"
```

### Pitfall 3: Deployment Rollback Chaos

**Problem:** Rollback procedures untested, panic during incidents
**Solution (Factor IV):** Regular rollback drills + automated procedures

```bash
# Monthly rollback drill
/agent progressive-deploy
# Prompt: "Execute test rollback in staging environment"

# Automate rollback triggers
# k8s/rollback-policy.yaml
apiVersion: flagger.app/v1beta1
kind: Canary
spec:
  analysis:
    threshold: 5
    maxWeight: 50
    stepWeight: 10
    metrics:
    - name: request-success-rate
      thresholdRange:
        min: 99
      interval: 1m
```

### Pitfall 4: Pipeline Performance Degradation

**Problem:** CI/CD pipelines get slower over time
**Solution (Factor X):** Continuous monitoring + optimization

```bash
# Weekly performance review
/analyze-pipeline

# Optimize based on data
/agent pipeline-guide
# Prompt: "Review pipeline metrics, suggest optimizations to reduce runtime"

# Track improvements
git commit -m "perf(ci): reduce pipeline runtime from 45m to 15m

- Parallelized security scans (10m → 3m)
- Cached dependencies (15m → 2m)
- Optimized test suite (20m → 10m)

Factor X: Data-driven optimization (67% improvement)
"
```

---

## Success Metrics

Track these metrics to validate 12-Factor AgentOps adoption:

**Pipeline Reliability:**
- Success rate (target: >95%)
- Mean time to recovery (target: <15 minutes)
- False failure rate (target: <5%)

**Security Posture:**
- Time to patch CVEs (target: <24 hours)
- Security scan coverage (target: 100%)
- False positive rate (target: <10%)

**Deployment Safety:**
- Rollback rate (target: <2%)
- Deployment frequency (target: 10+ per day)
- Lead time for changes (target: <1 hour)

**Developer Experience:**
- Pipeline feedback time (target: <10 minutes)
- Manual intervention rate (target: <5%)
- Context switch overhead (target: <2 minutes per task)

---

## Next Steps

1. **Start small:** Copy one agent (pipeline-guide.md)
2. **Validate locally:** Test on a non-critical repository
3. **Iterate rapidly:** Adjust prompts based on results
4. **Document patterns:** Share what works with your team
5. **Scale gradually:** Add more agents as confidence grows

**Questions or issues?** See main [12-Factor AgentOps documentation](../../README.md)

---

**Version:** v1.0.0
**Last Updated:** 2025-11-09
**Validated:** Alpha (production use, community validation in progress)
