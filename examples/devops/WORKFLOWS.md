# DevOps Workflows - Day in the Life

**How DevOps Engineers use 12-Factor AgentOps daily**

This document walks through realistic day-to-day scenarios showing how the agents and commands work together in practice.

---

## Morning: Pipeline Triage (8:00 AM - 9:00 AM)

### Scenario: Review overnight pipeline failures

**Context:** You arrive to find 3 failed pipelines from overnight deployments.

**Workflow:**

```bash
# 1. Quick analysis of all failures
/analyze-pipeline

# Output shows:
# - Pipeline A: Flaky integration test (3rd failure this week)
# - Pipeline B: Security scan blocked (new CVE in dependency)
# - Pipeline C: Deployment timeout (staging environment issue)

# 2. Prioritize by impact (B is blocking production, handle first)
/agent security-scan
# Prompt: "Analyze CVE-2024-12345 found in requests library v2.28.0"

# Agent responds with:
# - Severity: HIGH
# - Impact: Potential request smuggling
# - Fix: Update to requests v2.31.0
# - Validation: SAST scan passes after update

# 3. Quick fix for dependency CVE
echo "requests==2.31.0" > requirements.txt
uv pip compile requirements.txt > requirements.lock

# 4. Validate fix
/run-security-scans

# 5. Commit with context (Factor I: Knowledge OS)
git add requirements.txt requirements.lock
git commit -m "security: update requests library to v2.31.0

CVE-2024-12345: Request smuggling vulnerability
Severity: HIGH
Impact: Production deployment blocked

Fix: Updated requests 2.28.0 → 2.31.0
Validation: All security scans passing

Factor IV: Security validation gate enforced
Factor VII: Zero-trust dependency management
"

# 6. Trigger pipeline
git push origin main
# ✅ Pipeline B now passes (10 minutes to resolution)

# 7. Address flaky test (Pipeline A)
/agent pipeline-guide
# Prompt: "Fix flaky integration test in test_api_endpoints.py"

# Agent suggests:
# - Add retry logic for network calls
# - Increase timeout from 5s to 10s
# - Isolate database state between tests

# Apply fix, commit, verify
# ✅ Pipeline A now stable

# 8. Investigate staging timeout (Pipeline C)
/agent pipeline-guide
# Prompt: "Deployment timeout in staging - check resource limits"

# Agent identifies: Pod memory limit too low (512Mi)
# Quick fix: Increase to 1Gi
kubectl patch deployment app -n staging -p '{"spec":{"template":{"spec":{"containers":[{"name":"app","resources":{"limits":{"memory":"1Gi"}}}]}}}}'

# ✅ All three pipelines resolved in under 1 hour
```

**Factor Applications:**
- **Factor IV:** Security validation gates caught CVE before production
- **Factor I:** All decisions documented in git for future reference
- **Factor III:** Separate agents for security vs pipeline vs deployment
- **Factor X:** Pipeline metrics identified flaky test pattern

**Time saved:** Manual triage would take 3-4 hours. Agent-assisted: 45 minutes.

---

## Mid-Morning: Feature Pipeline Creation (9:30 AM - 11:00 AM)

### Scenario: New microservice needs CI/CD pipeline

**Context:** Development team built a new authentication service, needs pipeline.

**Workflow:**

```bash
# 1. Understand requirements
/agent pipeline-guide
# Prompt: "Create GitLab CI pipeline for Python FastAPI service with:
# - Unit tests (pytest)
# - Integration tests (Docker Compose)
# - Security scanning (SAST, dependency, container)
# - Deployment to Kubernetes (staging, production)
# - Progressive delivery (canary to production)
# "

# 2. Agent generates complete .gitlab-ci.yml
# Review output for:
# - Factor IV: Validation gates at each stage
# - Factor VII: Security scans block on findings
# - Factor V: Disposable test environments
# - Factor XII: Orchestrated deployment stages

# 3. Customize for team standards
/agent pipeline-guide
# Prompt: "Add company-specific requirements:
# - Use internal artifact registry (registry.company.com)
# - Tag with Jira ticket numbers
# - Notify Slack on deployment
# - Require manual approval for production
# "

# 4. Validate pipeline locally
# Use GitLab CI linter
curl --header "Content-Type: application/json" \
  --data '{"content":"$(cat .gitlab-ci.yml)"}' \
  "https://gitlab.company.com/api/v4/ci/lint" | jq .valid

# 5. Test in feature branch
git checkout -b feature/auth-service-pipeline
git add .gitlab-ci.yml
git commit -m "feat(ci): add pipeline for auth service

Pipeline includes:
- Unit tests with coverage reporting (pytest)
- Integration tests (Docker Compose + PostgreSQL)
- Security scanning (Semgrep, Safety, Trivy)
- Kubernetes deployment (staging → production)
- Canary deployment with automatic rollback

Factor III: Separate stages for test, security, deploy
Factor IV: Security gates block on HIGH/CRITICAL
Factor VII: All secrets from HashiCorp Vault
Factor XII: Orchestrated multi-stage deployment

Jira: AUTH-123
"

git push origin feature/auth-service-pipeline

# 6. Monitor first pipeline run
# (Pipeline runs in ~8 minutes)
# ✅ All stages pass

# 7. Get team review
# Create merge request
# Team reviews, suggests improvement:
# "Add performance tests before production deploy"

# 8. Iterate with agent
/agent pipeline-guide
# Prompt: "Add performance test stage using locust:
# - 100 concurrent users
# - 5 minute duration
# - <500ms p95 latency requirement
# - Block deploy if requirement not met
# "

# Apply changes, push update
# ✅ Pipeline complete with performance validation

# 9. Merge to main
git checkout main
git merge feature/auth-service-pipeline
git push origin main

# 10. Document pattern for future services
/agent pipeline-guide
# Prompt: "Extract reusable template from auth-service pipeline"

# Agent creates: templates/fastapi-service-pipeline.yml
# ✅ Future services can reuse this pattern (Factor IX)
```

**Factor Applications:**
- **Factor III:** Pipeline agent focused solely on CI/CD logic
- **Factor IV:** Multiple validation gates (tests, security, performance)
- **Factor VII:** Zero-trust security scanning at every stage
- **Factor IX:** Pattern extracted for institutional knowledge
- **Factor XII:** Multi-stage orchestration automated

**Time saved:** Manual pipeline creation: 4-6 hours. Agent-assisted: 90 minutes.

---

## Lunch Break: Async Security Review (12:00 PM - 1:00 PM)

### Scenario: Weekly security scan review

**Context:** Automated security scans run nightly, review results over lunch.

**Workflow:**

```bash
# 1. Generate security report
/run-security-scans

# Output:
# =====================================
# Security Scan Summary (2025-11-09)
# =====================================
#
# SAST Scan (Semgrep):
#   ✅ 0 critical issues
#   ⚠️  3 medium issues (same as last week)
#
# Dependency Scan (Safety):
#   ❌ 2 new vulnerabilities
#   - CVE-2024-67890 in urllib3 (MEDIUM)
#   - CVE-2024-54321 in pillow (HIGH)
#
# Container Scan (Trivy):
#   ✅ 0 high/critical vulnerabilities
#   ⚠️  12 medium (up from 10 last week)
#
# Secrets Detection (gitleaks):
#   ✅ No secrets found

# 2. Prioritize HIGH severity dependency issue
/agent security-scan
# Prompt: "Analyze CVE-2024-54321 in pillow library"

# Agent provides:
# - CVE Details: Arbitrary code execution via crafted image
# - Affected versions: pillow <10.0.1
# - Fix: Update to pillow 10.0.1
# - Impact: Image processing service vulnerable
# - Urgency: HIGH (internet-facing service)

# 3. Create fix branch
git checkout -b security/pillow-cve-2024-54321

# 4. Update dependency
echo "pillow==10.0.1" >> requirements.txt
uv pip compile requirements.txt > requirements.lock

# 5. Test for breaking changes
/agent pipeline-guide
# Prompt: "Run integration tests for image processing service"

# Tests pass ✅

# 6. Fast-track security fix
git add requirements.txt requirements.lock
git commit -m "security: update pillow to v10.0.1 (CVE-2024-54321)

CRITICAL: Arbitrary code execution via crafted image
CVE: CVE-2024-54321
Severity: HIGH
CVSS: 8.8

Affected: pillow <10.0.1
Fixed: pillow 10.0.1

Impact: image-processing-service (internet-facing)
Validation: Integration tests passing
Urgency: Deploy within 24 hours

Factor VII: Zero-trust dependency management
Factor IV: Security validation gate enforced
"

git push origin security/pillow-cve-2024-54321

# 7. Create urgent merge request
# Tag: security, urgent
# Assign: team lead for fast approval
# ✅ Approved and merged within 30 minutes

# 8. Verify production deployment
# Canary deploys automatically
# Monitor for 15 minutes
# ✅ Full rollout complete

# 9. Update security dashboard
/agent security-scan
# Prompt: "Generate weekly security summary for team meeting"

# Agent creates: reports/security-summary-2025-11-09.md
# Share in #security Slack channel

# 10. Address medium-severity findings for next week
# Create tickets for MEDIUM issues
# Schedule for next sprint
```

**Factor Applications:**
- **Factor IV:** Automated security validation gates
- **Factor VII:** Zero-trust approach to all dependencies
- **Factor X:** Metrics tracked (vulnerability trends over time)
- **Factor XI:** Learn from CVE patterns (update scan policies)

**Time saved:** Manual security review: 2-3 hours. Agent-assisted: 45 minutes.

---

## Afternoon: Production Deployment (2:00 PM - 4:00 PM)

### Scenario: Deploy payment service update to production

**Context:** Critical feature needed for Black Friday (canary deployment required).

**Workflow:**

```bash
# 1. Verify staging deployment
kubectl get pods -n staging
# All pods healthy ✅

# 2. Plan production deployment strategy
/agent progressive-deploy
# Prompt: "Plan canary deployment for payment-service:
# - Production has 20 replicas
# - Handle 10,000 req/s
# - Zero downtime requirement
# - Automatic rollback on errors >1%
# "

# Agent suggests:
# Phase 1: 10% canary (2 replicas) for 15 minutes
# Phase 2: 50% canary (10 replicas) for 15 minutes
# Phase 3: 100% rollout (20 replicas)
# Rollback triggers:
#   - Error rate >1%
#   - Latency p95 >500ms
#   - CPU usage >80%

# 3. Create canary configuration
/agent progressive-deploy
# Prompt: "Generate Flagger canary configuration with above parameters"

# Agent creates: k8s/payment-service-canary.yaml

# 4. Validate canary config
kubectl apply --dry-run=client -f k8s/payment-service-canary.yaml
# ✅ Valid

# 5. Apply to production (manual approval required)
# Create deployment checklist:
# - [ ] Staging tests passing (100% over 24 hours)
# - [ ] Security scans clean
# - [ ] Database migrations applied
# - [ ] Rollback plan documented
# - [ ] On-call engineer notified
# - [ ] Monitoring dashboards ready

# 6. Execute deployment
kubectl apply -f k8s/payment-service-canary.yaml

# 7. Monitor Phase 1 (10% canary)
# Watch Grafana dashboard: payment-service-deployment
# Metrics:
#   - Request rate: 1,000 req/s (10% of total) ✅
#   - Error rate: 0.1% (well below 1% threshold) ✅
#   - Latency p95: 245ms (well below 500ms threshold) ✅
#   - CPU usage: 45% (well below 80% threshold) ✅

# Phase 1 completes after 15 minutes ✅

# 8. Monitor Phase 2 (50% canary)
# Metrics:
#   - Request rate: 5,000 req/s (50% of total) ✅
#   - Error rate: 0.2% (within threshold) ✅
#   - Latency p95: 280ms (within threshold) ✅
#   - CPU usage: 52% (within threshold) ✅

# Phase 2 completes after 15 minutes ✅

# 9. Full rollout (Phase 3)
# Flagger automatically promotes to 100%
# All 20 replicas running new version ✅

# 10. Post-deployment validation
/run-security-scans
# Security posture unchanged ✅

# 11. Document deployment
git tag -a "deploy/payment-service-v2.5.0" -m "Production deployment

Date: 2025-11-09 14:30 UTC
Service: payment-service
Version: v2.4.3 → v2.5.0

Deployment strategy: Canary (10% → 50% → 100%)
Duration: 45 minutes
Rollbacks: 0
Incidents: 0

Metrics:
- Error rate: 0.1% avg (threshold: <1%)
- Latency p95: 280ms avg (threshold: <500ms)
- CPU usage: 52% avg (threshold: <80%)

Factor IV: All validation gates passed
Factor XII: Automated orchestration via Flagger
Factor X: Telemetry-driven promotion decisions

Approved-by: @tech-lead
On-call: @sre-team
"

git push --tags

# 12. Update runbook with learnings
/agent progressive-deploy
# Prompt: "Update production deployment runbook based on this successful deployment"

# Agent adds:
# - Canary parameters validated for payment-service
# - Monitoring dashboard layout effective
# - Phase durations appropriate for traffic volume
# ✅ Pattern documented (Factor IX)

# 13. Notify stakeholders
# Slack message to #deployments:
# "✅ payment-service v2.5.0 deployed successfully
#  - Deployment: Canary (45 minutes)
#  - Health: All metrics within thresholds
#  - Issues: None
#  - Rollbacks: None
# "
```

**Factor Applications:**
- **Factor IV:** Multi-stage validation (staging → 10% → 50% → 100%)
- **Factor VI:** Session continuity (rollback capability at every stage)
- **Factor X:** Telemetry-driven decisions (auto-promote on metrics)
- **Factor XII:** Multi-agent orchestration (Flagger + monitoring + alerts)

**Time saved:** Manual deployment coordination: 3-4 hours. Agent-assisted: 45 minutes.

---

## Late Afternoon: Incident Response (4:30 PM - 5:30 PM)

### Scenario: Production alert - API gateway latency spike

**Context:** PagerDuty alert: API gateway p95 latency jumped from 200ms to 2000ms.

**Workflow:**

```bash
# 1. Acknowledge incident
# PagerDuty: "API Gateway Latency HIGH - p95: 2000ms (threshold: 500ms)"

# 2. Quick triage
/agent pipeline-guide
# Prompt: "Recent deployments in last 2 hours?"

# Agent shows:
# - payment-service: deployed 90 minutes ago (currently 100% rollout)
# - No other deployments

# 3. Check canary metrics
/agent progressive-deploy
# Prompt: "Show payment-service canary metrics for last 2 hours"

# Agent identifies:
# - Canary metrics were clean during rollout
# - Latency spike started 15 minutes AFTER full rollout
# - Correlation: Database connection pool exhausted

# 4. Immediate rollback decision
/agent progressive-deploy
# Prompt: "Execute immediate rollback of payment-service to v2.4.3"

# Agent provides rollback command:
kubectl rollout undo deployment/payment-service -n production

# Execute rollback
kubectl rollout undo deployment/payment-service -n production
kubectl rollout status deployment/payment-service -n production

# 5. Verify rollback success
# Monitor Grafana:
# - Latency p95: 2000ms → 1200ms → 600ms → 250ms ✅
# - Error rate: 2% → 0.5% → 0.1% ✅
# - System recovering

# Incident resolved in 8 minutes ✅

# 6. Root cause analysis
/agent pipeline-guide
# Prompt: "Analyze payment-service v2.5.0 database connection configuration"

# Agent identifies:
# - Connection pool size: 20 (unchanged)
# - New feature: background job added
# - Background job consumes 15 connections
# - Effective pool for API requests: only 5 connections
# - Under high load: connection exhaustion

# 7. Create fix
git checkout -b hotfix/payment-service-connection-pool

# Increase connection pool
# config/production.yaml:
database:
  pool_size: 50  # Was 20, now 50 (25 for API + 25 for background jobs)
  pool_overflow: 20
  pool_timeout: 30

# 8. Validate fix in staging
/agent pipeline-guide
# Prompt: "Deploy hotfix to staging, run load test"

# Load test results:
# - Connection pool usage: 40/50 peak (healthy headroom) ✅
# - Latency p95: 245ms (within threshold) ✅
# - Error rate: 0% ✅

# 9. Fast-track to production
git add config/production.yaml
git commit -m "hotfix: increase database connection pool (incident #INC-4567)

Incident: API gateway latency spike (200ms → 2000ms)
Root cause: Connection pool exhaustion
  - payment-service v2.5.0 added background job
  - Background job consumed 15 of 20 connections
  - API requests starved for connections

Fix: Increase pool from 20 → 50
  - 25 connections for API requests
  - 25 connections for background jobs

Validation:
  - Staging load test: p95 latency 245ms ✅
  - Connection usage: 40/50 peak (healthy) ✅

Factor IV: Load testing validated fix
Factor VI: Rollback prevented user impact
Factor IX: Pattern extracted for connection pool sizing

Incident: INC-4567
Duration: 8 minutes (detection to rollback)
Impact: 0.02% error rate spike, no data loss
"

git push origin hotfix/payment-service-connection-pool

# 10. Merge and deploy with extra caution
# Merge request: URGENT - Incident hotfix
# Approved by: SRE lead + Tech lead
# Merge to main

# 11. Re-deploy with same canary strategy
/agent progressive-deploy
# Prompt: "Deploy payment-service v2.5.1 with hotfix using previous canary config"

kubectl apply -f k8s/payment-service-canary.yaml

# Monitor deployment closely:
# Phase 1 (10%): All metrics healthy ✅
# Phase 2 (50%): All metrics healthy ✅
# Phase 3 (100%): All metrics healthy ✅

# 12. Post-incident review
/agent progressive-deploy
# Prompt: "Generate post-incident report for INC-4567"

# Agent creates comprehensive report:
# - Timeline of events
# - Root cause analysis
# - Fix validation
# - Action items:
#   1. Add connection pool monitoring
#   2. Update load test to include background jobs
#   3. Document connection pool sizing formula
#   4. Add pre-deployment checklist item: "Review connection pool capacity"

# Share report in #incidents channel

# 13. Update runbooks
/agent progressive-deploy
# Prompt: "Update incident response runbook with learnings from INC-4567"

# Runbook updated with:
# - New rollback trigger: database connection pool exhaustion
# - Monitoring: connection pool metrics added to dashboard
# - Prevention: connection pool sizing checklist
# ✅ Institutional knowledge improved (Factor IX)
```

**Factor Applications:**
- **Factor VI:** Session continuity enabled instant rollback
- **Factor I:** All decisions documented in git for learning
- **Factor IV:** Validation gates caught issue in staging (second deployment)
- **Factor IX:** Pattern extraction prevents similar incidents
- **Factor X:** Telemetry identified root cause quickly

**Time saved:** Manual incident response: 2-3 hours. Agent-assisted: 60 minutes.
**User impact:** Minimized to 8 minutes due to fast rollback capability.

---

## End of Day: Knowledge Sharing (5:30 PM - 6:00 PM)

### Scenario: Document today's learnings for team

**Workflow:**

```bash
# 1. Extract patterns from today's work
/agent pipeline-guide
# Prompt: "Review today's git commits, extract reusable patterns"

# Agent identifies:
# Pattern 1: CVE response workflow (security fix)
# Pattern 2: FastAPI service pipeline template (feature work)
# Pattern 3: Connection pool sizing formula (incident fix)

# 2. Create team documentation
mkdir -p docs/patterns/
mkdir -p docs/runbooks/
mkdir -p docs/templates/

# 3. Document CVE response pattern
cat > docs/patterns/cve-response-workflow.md <<EOF
# CVE Response Workflow

## When to Use
New CVE discovered in production dependency

## Steps
1. Analyze CVE with /agent security-scan
2. Determine severity and impact
3. Test fix in staging
4. Fast-track merge if HIGH/CRITICAL
5. Deploy via normal pipeline
6. Verify with /run-security-scans

## SLA
- CRITICAL: 4 hours
- HIGH: 24 hours
- MEDIUM: 1 week
- LOW: Next sprint

## Example
See: git log --grep="CVE-2024"
EOF

# 4. Document FastAPI pipeline template
cp .gitlab-ci.yml docs/templates/fastapi-service-pipeline.yml
cat > docs/templates/README.md <<EOF
# Pipeline Templates

## FastAPI Service Pipeline
File: fastapi-service-pipeline.yml

Includes:
- Unit tests (pytest)
- Integration tests (Docker Compose)
- Security scanning (Semgrep, Safety, Trivy)
- Kubernetes deployment (staging → production)
- Canary deployment with metrics

Usage:
Copy to new service, customize variables.
EOF

# 5. Document connection pool sizing
cat > docs/runbooks/database-connection-pool-sizing.md <<EOF
# Database Connection Pool Sizing

## Formula
pool_size = (api_workers * connections_per_worker) + (background_jobs * connections_per_job) + 20% headroom

## Example (payment-service)
- API workers: 10
- Connections per worker: 2
- Background jobs: 5
- Connections per job: 3

pool_size = (10 * 2) + (5 * 3) + 0.2 * 35 = 20 + 15 + 7 = 42

Rounded up: 50

## Validation
Load test should show:
- Peak usage <80% of pool size
- No connection timeout errors
- No connection wait time >100ms

## Monitoring
Add to Grafana dashboard:
- database_connection_pool_size
- database_connection_pool_active
- database_connection_pool_idle
- database_connection_pool_wait_time
EOF

# 6. Commit documentation
git add docs/
git commit -m "docs: add patterns from 2025-11-09 work

Patterns documented:
1. CVE response workflow (security)
2. FastAPI pipeline template (devops)
3. Connection pool sizing formula (incident)

Factor IX: Extract learnings for institutional knowledge
Factor I: Document context for future engineers

Incidents referenced: INC-4567
Tickets referenced: AUTH-123
"

# 7. Share with team
# Create Slack post in #engineering:
# "📚 New documentation from today's work:
#  - CVE response workflow (docs/patterns/cve-response-workflow.md)
#  - FastAPI pipeline template (docs/templates/fastapi-service-pipeline.yml)
#  - Connection pool sizing guide (docs/runbooks/database-connection-pool-sizing.md)
#
#  All patterns extracted from real production work today.
#  Factor IX in action! 🚀
# "

# 8. Update team wiki
# Add links to company wiki:
# - Security > CVE Response
# - CI/CD > Pipeline Templates
# - Runbooks > Database Tuning

# 9. Schedule knowledge sharing session
# Calendar invite: "DevOps Patterns Review" (Friday 3pm, 30 min)
# Agenda:
# - Walkthrough CVE response workflow
# - Demo FastAPI pipeline template
# - Discuss connection pool incident and prevention
# - Q&A
```

**Factor Applications:**
- **Factor I:** All knowledge captured in git
- **Factor IX:** Patterns extracted from real work
- **Factor III:** Clear separation of concerns in documentation
- **Factor XI:** Continuous improvement through shared learning

**Time saved:** This documentation prevents future teams from rediscovering same solutions.
**Impact:** Each pattern reused 10+ times = 30-40 hours saved per pattern.

---

## Weekly: Pipeline Performance Review (Friday 10:00 AM)

### Scenario: Optimize CI/CD performance across all services

**Workflow:**

```bash
# 1. Gather pipeline metrics (Factor X)
/analyze-pipeline

# Output:
# =====================================
# Pipeline Performance Summary (Week 45, 2025)
# =====================================
#
# Total Pipelines: 247
# Success Rate: 94% (target: >95%) ⚠️
# Mean Duration: 18m 34s
# P95 Duration: 35m 12s (target: <30m) ⚠️
#
# Top Issues:
# 1. Flaky tests: 8 pipelines (3.2% failure rate)
# 2. Slow security scans: 15 pipelines (>10m for SAST)
# 3. Cache misses: 32 pipelines (rebuilding dependencies)
#
# Improvement Opportunities:
# 1. Parallelize security scans → Save ~7m per pipeline
# 2. Fix top 3 flaky tests → Improve success rate to 97%
# 3. Optimize dependency caching → Save ~5m per pipeline

# 2. Address flaky tests
/agent pipeline-guide
# Prompt: "Identify top 3 flaky tests across all pipelines"

# Agent analyzes last 30 days:
# 1. test_api_rate_limiting (failure rate: 12%)
# 2. test_websocket_reconnect (failure rate: 8%)
# 3. test_async_batch_processing (failure rate: 6%)

# Create tickets for each
# Assign to teams
# Track in sprint

# 3. Optimize security scans
/agent security-scan
# Prompt: "Analyze security scan performance, suggest optimizations"

# Agent recommends:
# - Run SAST, dependency scan, container scan in parallel
# - Cache security scan results for unchanged files
# - Use faster SAST rules (reduce false positives)

# Implement optimization:
git checkout -b optimize/parallel-security-scans

# Update .gitlab-ci.yml template:
# Before:
# security:sast:
#   stage: security
#   script: semgrep --config=auto .
#
# security:dependency:
#   stage: security
#   script: safety check
#
# security:container:
#   stage: security
#   script: trivy image $IMAGE

# After:
security:
  stage: security
  parallel:
    matrix:
      - SCAN: [sast, dependency, container]
  script:
    - |
      case $SCAN in
        sast)
          semgrep --config=auto . --json > sast-report.json
          ;;
        dependency)
          safety check --json > dependency-report.json
          ;;
        container)
          trivy image --format json $IMAGE > container-report.json
          ;;
      esac
  artifacts:
    reports:
      sast: sast-report.json
      dependency_scanning: dependency-report.json
      container_scanning: container-report.json

# Validate improvement:
# Before: 15 minutes (serial scans)
# After: 5 minutes (parallel scans)
# ✅ 67% improvement

# 4. Fix dependency caching
/agent pipeline-guide
# Prompt: "Optimize dependency caching for Python projects"

# Agent suggests:
# - Cache pip packages based on requirements.txt hash
# - Use cache:paths with fallback keys
# - Compress cached artifacts

# Update .gitlab-ci.yml:
cache:
  key:
    files:
      - requirements.txt
    prefix: pip-
  paths:
    - .cache/pip
  policy: pull-push

# Validate improvement:
# Before: 8 minutes (download dependencies every time)
# After: 2 minutes (cache hit rate: 85%)
# ✅ 75% improvement

# 5. Commit optimizations
git add .gitlab-ci.yml
git commit -m "perf(ci): optimize pipeline performance (18m → 10m)

Optimizations:
1. Parallel security scans (15m → 5m) -67%
2. Dependency caching (8m → 2m) -75%
3. Total pipeline time: 18m → 10m -44%

Impact:
- 247 pipelines/week * 8m saved = 33 hours/week saved
- Annual savings: 1,716 hours (71 days)

Factor X: Data-driven optimization
Factor XI: Continuous improvement from metrics
Factor XII: Parallel execution for faster feedback

Metrics:
- Success rate: 94% → 97% (goal: >95%) ✅
- P95 duration: 35m → 22m (goal: <30m) ✅
"

git push origin optimize/parallel-security-scans

# 6. Validate impact over next week
# Monitor pipeline metrics
# Track improvement in dashboard
# ✅ Optimization validated by real usage

# 7. Share results with team
# Slack #engineering:
# "🚀 Pipeline Performance Improvement
#  - Average duration: 18m → 10m (-44%)
#  - Success rate: 94% → 97%
#  - Annual time savings: 1,716 hours
#
#  Changes:
#  - Parallel security scans
#  - Improved dependency caching
#  - Flaky test fixes (in progress)
# "
```

**Factor Applications:**
- **Factor X:** Telemetry identified optimization opportunities
- **Factor XI:** Continuous improvement through data analysis
- **Factor XII:** Parallel execution for performance
- **Factor IX:** Optimizations become new standard template

**Time saved:** 1,716 hours annually across all teams.

---

## Monthly: Security Posture Review (First Friday)

### Scenario: Comprehensive security audit and improvement planning

**Workflow:**

```bash
# 1. Generate comprehensive security report
/run-security-scans --comprehensive

# Output spans all repositories and services
# Aggregated findings saved to: reports/security-monthly-2025-11.json

# 2. Analyze trends
/agent security-scan
# Prompt: "Analyze security trends over last 90 days, identify patterns"

# Agent generates:
# - CVE discovery rate: 2.3 per week (stable)
# - Mean time to patch: 18 hours (improving, was 36 hours)
# - False positive rate: 8% (target: <10%) ✅
# - Coverage: 98% of repositories (target: 100%) ⚠️
#
# Patterns identified:
# 1. JavaScript dependencies have highest CVE rate
# 2. Container base images lag behind security patches
# 3. 2% of repositories lack security scanning (newly created)

# 3. Create improvement roadmap
mkdir -p docs/security/roadmap/

cat > docs/security/roadmap/2025-q4.md <<EOF
# Security Roadmap Q4 2025

## Goals
1. 100% repository coverage (currently 98%)
2. Mean time to patch <12 hours (currently 18h)
3. Automate container base image updates

## Initiatives

### Initiative 1: Automated Dependency Updates
Tool: Dependabot / Renovate
Scope: All JavaScript/Python projects
Timeline: 2 weeks
Impact: Reduce CVE window from 18h → 6h

### Initiative 2: Container Base Image Policy
Policy: Auto-update base images weekly
Automation: Scheduled pipeline job
Timeline: 1 week
Impact: Reduce container CVE exposure by 60%

### Initiative 3: New Repository Security Template
Template: Include security scans by default
Enforcement: CI/CD template with validation
Timeline: 1 week
Impact: 100% coverage for new repositories

## Metrics to Track
- CVE discovery rate
- Mean time to patch
- Coverage percentage
- False positive rate
EOF

# 4. Implement Initiative 1 (Automated Dependency Updates)
/agent security-scan
# Prompt: "Configure Dependabot for automatic dependency updates"

# Agent generates .github/dependabot.yml:
version: 2
updates:
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "daily"
    reviewers:
      - "security-team"
    labels:
      - "dependencies"
      - "security"
    commit-message:
      prefix: "security"

  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "daily"
    reviewers:
      - "security-team"

# Deploy across repositories
# ✅ 45 repositories now have automated updates

# 5. Implement Initiative 2 (Container Base Image Updates)
/agent pipeline-guide
# Prompt: "Create scheduled job to update container base images weekly"

# Agent generates .gitlab-ci.yml scheduled job:
update-base-images:
  stage: maintenance
  rules:
    - if: '$CI_PIPELINE_SOURCE == "schedule"'
  script:
    - python scripts/update-base-images.py
    - git add Dockerfile*
    - git commit -m "chore: update container base images"
    - git push origin main
  only:
    - schedules

# Configure schedule in GitLab: Every Monday 6am UTC
# ✅ Automated base image updates active

# 6. Implement Initiative 3 (New Repository Template)
/agent security-scan
# Prompt: "Create security-enabled CI/CD template for new repositories"

# Agent creates template with:
# - SAST scanning
# - Dependency scanning
# - Container scanning
# - Secrets detection
# - Validation gates

# Add to organization templates
# ✅ New repositories inherit security by default

# 7. Document security improvements
git add docs/security/
git commit -m "docs: Q4 2025 security roadmap and implementations

Initiatives completed:
1. ✅ Automated dependency updates (Dependabot)
2. ✅ Weekly container base image updates
3. ✅ Security-enabled repository template

Impact:
- Coverage: 98% → 100%
- Mean time to patch: 18h → 6h (projected)
- Container CVE exposure: -60% (projected)

Factor VII: Zero-trust dependency management
Factor IX: Security patterns codified as templates
Factor XI: Continuous security improvement

Next review: 2025-12-06
"

# 8. Share with leadership
# Create presentation for security review meeting
# Highlight: 67% improvement in patch response time
# Demonstrate: Automated security workflows
# ✅ Leadership approval for continued investment
```

**Factor Applications:**
- **Factor VII:** Zero-trust extended to all dependencies
- **Factor IX:** Security patterns become organizational standard
- **Factor XI:** Data-driven security improvements
- **Factor I:** All security decisions documented in git

**Impact:** Security posture improved by 67% through automation.

---

## Summary: Daily Workflow Patterns

### Time Distribution (Typical Week)

| Activity | Time/Week | Factor Focus |
|----------|-----------|--------------|
| Pipeline triage | 3 hours | IV, X |
| Feature pipelines | 6 hours | III, XII |
| Security reviews | 2 hours | VII, XI |
| Deployments | 4 hours | VI, XII |
| Incidents | 2 hours | VI, I |
| Documentation | 2 hours | I, IX |
| Optimization | 1 hour | X, XI |
| **Total** | **20 hours** | **All factors** |

### Efficiency Gains

**Without 12-Factor AgentOps:**
- Pipeline triage: 6-8 hours/week
- Feature pipelines: 12-16 hours/week
- Security reviews: 4-6 hours/week
- Deployments: 8-10 hours/week
- Incidents: 4-6 hours/week
- Documentation: 4-6 hours/week
- **Total: 38-52 hours/week**

**With 12-Factor AgentOps:**
- **Total: 20 hours/week**
- **Time saved: 18-32 hours/week (47-62% improvement)**

### Key Success Patterns

1. **Start with validation** (Factor IV) - Catch issues early
2. **Document decisions** (Factor I) - Build institutional knowledge
3. **Extract patterns** (Factor IX) - Don't solve twice
4. **Monitor metrics** (Factor X) - Data-driven improvements
5. **Automate everything** (Factor XII) - Reduce manual toil

---

## Next Steps

1. **Copy relevant workflows** to your team documentation
2. **Customize for your tools** (GitLab, Jenkins, CircleCI, etc.)
3. **Track your own metrics** to validate improvements
4. **Share learnings** with your team
5. **Iterate rapidly** based on feedback

**Questions?** See main [DevOps README](README.md) for agent details.

---

**Version:** v1.0.0
**Last Updated:** 2025-11-09
**Target Audience:** DevOps Engineers, SREs, Release Engineers
