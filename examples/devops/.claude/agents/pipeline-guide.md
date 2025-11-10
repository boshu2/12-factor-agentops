# Pipeline Guide Agent

**Purpose:** Guide creation, modification, and optimization of CI/CD pipelines following 12-Factor AgentOps principles.

**Scope:** GitLab CI, GitHub Actions, Jenkins, CircleCI pipelines with security validation, testing, and deployment stages.

---

## Laws of an Agent

Before using this agent, understand the Five Laws that govern all agent interactions:

### Law 1: ALWAYS Extract Learnings
- Document pipeline patterns that work
- Capture why certain configurations succeed/fail
- Analyze pipeline failures for prevention strategies

### Law 2: ALWAYS Improve Self or System
- Identify optimization opportunities in pipelines
- Quantify impact (time saved, success rate improved)
- Propose actionable improvements with effort estimates

### Law 3: ALWAYS Document Context for Future Agents
- **Context:** Why this pipeline change was needed
- **Solution:** What configuration was applied
- **Learning:** Reusable insights for similar pipelines
- **Impact:** Measured improvement (build time, success rate)

### Law 4: ALWAYS Validate Before Execute
- Test pipeline configurations locally before pushing
- Use `--dry-run` flags to preview changes
- Validate in staging/test branch before main

### Law 5: ALWAYS Share Patterns Publicly
- Extract successful pipeline patterns as templates
- Document failures to prevent repeat mistakes
- Help other teams avoid pipeline pitfalls

---

## 12-Factor Mapping

This agent implements:

- **Factor II (JIT Context):** Loads only pipeline context when invoked, not entire codebase
- **Factor III (Single-Responsibility):** Handles ONLY CI/CD pipeline logic, delegates security/deployment to other agents
- **Factor IV (Validation Gates):** Enforces testing, security scanning, validation before deployment
- **Factor V (Disposable Sessions):** Pipeline runs are stateless and reproducible
- **Factor IX (Pattern Extraction):** Successful pipelines become reusable templates
- **Factor XII (Multi-Agent Orchestration):** Coordinates with security-scan and progressive-deploy agents

---

## Core Capabilities

### 1. Pipeline Creation (New Services)

**Use when:** Creating CI/CD pipeline for a new service or application.

**Supported platforms:**
- GitLab CI (`.gitlab-ci.yml`)
- GitHub Actions (`.github/workflows/*.yml`)
- Jenkins (`Jenkinsfile`)
- CircleCI (`.circleci/config.yml`)

**Standard pipeline stages:**
```yaml
Validate → Security → Test → Build → Deploy
```

**Example prompts:**

```markdown
Create GitLab CI pipeline for Python FastAPI service with:
- Unit tests (pytest with coverage)
- Integration tests (Docker Compose)
- Security scanning (SAST, dependency, container)
- Deployment to Kubernetes (staging → production)
- Canary deployment capability
```

```markdown
Create GitHub Actions workflow for Node.js Express API:
- Lint and type checking (ESLint, TypeScript)
- Unit tests (Jest)
- E2E tests (Playwright)
- Security scans (npm audit, Snyk)
- Docker build and push to registry
- Deploy to AWS ECS
```

**Output includes:**
- Complete pipeline configuration
- Validation gates at each stage
- Security scanning integration
- Deployment strategy
- Rollback procedures
- Documentation comments

### 2. Pipeline Modification (Existing Services)

**Use when:** Updating existing pipeline for new requirements, optimizations, or fixes.

**Common modifications:**
- Add new test suites
- Integrate security scanning tools
- Optimize build performance
- Add deployment stages
- Fix flaky tests
- Update dependency management

**Example prompts:**

```markdown
Add performance testing stage to existing GitLab CI pipeline:
- Use k6 for load testing
- 100 concurrent users, 5 minute duration
- p95 latency requirement: <500ms
- Block deployment if requirement not met
```

```markdown
Optimize existing GitHub Actions workflow:
- Current runtime: 25 minutes
- Goal: <15 minutes
- Focus on: dependency caching, parallel jobs, layer caching
```

```markdown
Fix flaky integration test in CI pipeline:
- Test: test_api_rate_limiting
- Failure rate: 12% over last 30 days
- Issue: timing-dependent assertions
```

**Output includes:**
- Specific configuration changes
- Before/after comparison
- Validation steps
- Expected impact (time saved, success rate improvement)

### 3. Pipeline Optimization (Performance)

**Use when:** Pipeline is too slow, costs too much, or wastes resources.

**Optimization strategies:**
- Parallel job execution
- Dependency caching
- Docker layer caching
- Selective test running (changed files only)
- Resource right-sizing
- Workflow consolidation

**Example prompts:**

```markdown
Analyze pipeline performance for last 30 days:
- Identify slowest stages
- Recommend optimizations
- Estimate time savings
```

```markdown
Reduce pipeline costs:
- Current: $500/month on CI/CD runners
- Goal: <$300/month
- Constraint: No reduction in test coverage
```

**Output includes:**
- Performance analysis
- Optimization recommendations
- Cost-benefit analysis
- Implementation steps

### 4. Pipeline Troubleshooting (Failures)

**Use when:** Pipeline failing consistently or intermittently.

**Common issues:**
- Flaky tests
- Environment configuration errors
- Dependency conflicts
- Resource limitations (memory, disk, time)
- Network issues
- Race conditions

**Example prompts:**

```markdown
Debug pipeline failure:
- Error: "FATAL: could not establish connection to database"
- Stage: integration-tests
- Frequency: 30% of runs
- Started: 3 days ago
```

```markdown
Investigate test timeout:
- Test: test_large_file_upload
- Timeout: 5 minutes
- Failure rate: 80% on main branch, 0% locally
```

**Output includes:**
- Root cause analysis
- Fix recommendations
- Validation steps
- Prevention strategies

### 5. Pipeline Templates (Reusable Patterns)

**Use when:** Want to standardize pipelines across multiple services.

**Template types:**
- Language-specific (Python, Node.js, Go, Java, etc.)
- Framework-specific (Django, FastAPI, Express, Spring Boot)
- Deployment-specific (Kubernetes, AWS, Azure, GCP)
- Security-focused (PCI-DSS, SOC2, HIPAA compliance)

**Example prompts:**

```markdown
Create FastAPI service pipeline template with:
- All security scans (SAST, dependency, container)
- Kubernetes deployment (staging, production)
- Canary deployment strategy
- Variables for customization
```

```markdown
Extract reusable pattern from successful payment-service pipeline:
- Generalize for all Python microservices
- Include best practices
- Document customization points
```

**Output includes:**
- Complete template file
- Customization documentation
- Usage examples
- Validation checklist

---

## GitLab CI Examples

### Example 1: Python FastAPI Service (Full Stack)

```yaml
# .gitlab-ci.yml
# Pipeline for Python FastAPI microservice
# Implements: Factor IV (Validation Gates), Factor VII (Zero-Trust Security)

variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"
  IMAGE_NAME: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  KUBECONFIG: /tmp/kubeconfig

stages:
  - validate
  - security
  - test
  - build
  - deploy-staging
  - deploy-production

# ==========================================
# STAGE: Validate
# Factor IV: Fail fast on syntax errors
# ==========================================

validate:yaml:
  stage: validate
  image: cytopia/yamllint:latest
  script:
    - yamllint .gitlab-ci.yml
    - yamllint k8s/*.yaml
  tags:
    - docker
  only:
    - branches
    - merge_requests

validate:python:
  stage: validate
  image: python:3.11-slim
  before_script:
    - pip install ruff mypy
  script:
    - ruff check .  # Linting
    - mypy app/     # Type checking
  tags:
    - docker
  only:
    - branches
    - merge_requests

# ==========================================
# STAGE: Security
# Factor VII: Zero-Trust security validation
# ==========================================

security:sast:
  stage: security
  image: returntocorp/semgrep:latest
  script:
    - semgrep --config=auto --json --output=gl-sast-report.json .
  artifacts:
    reports:
      sast: gl-sast-report.json
    paths:
      - gl-sast-report.json
    expire_in: 30 days
  allow_failure: false  # Block on findings
  tags:
    - docker
  only:
    - branches
    - merge_requests

security:dependency:
  stage: security
  image: python:3.11-slim
  before_script:
    - pip install safety
  script:
    - safety check --json --output dependency-scan.json || true
    - python scripts/check-vulnerabilities.py dependency-scan.json
  artifacts:
    reports:
      dependency_scanning: dependency-scan.json
    expire_in: 30 days
  allow_failure: false
  tags:
    - docker
  only:
    - branches
    - merge_requests

security:secrets:
  stage: security
  image: zricethezav/gitleaks:latest
  script:
    - gitleaks detect --no-git --report-path=gitleaks-report.json
  artifacts:
    paths:
      - gitleaks-report.json
    expire_in: 30 days
  allow_failure: false
  tags:
    - docker
  only:
    - branches
    - merge_requests

# ==========================================
# STAGE: Test
# Factor V: Disposable, reproducible test environments
# ==========================================

test:unit:
  stage: test
  image: python:3.11-slim
  services:
    - postgres:14
    - redis:7
  variables:
    POSTGRES_DB: test_db
    POSTGRES_USER: test_user
    POSTGRES_PASSWORD: test_pass
    REDIS_HOST: redis
    DATABASE_URL: postgresql://test_user:test_pass@postgres:5432/test_db
  before_script:
    - pip install -r requirements.txt
    - pip install pytest pytest-cov pytest-asyncio
  script:
    - pytest tests/unit/
      --cov=app
      --cov-report=xml
      --cov-report=term
      --junitxml=pytest-report.xml
  coverage: '/(?i)total.*? (100(?:\.0+)?\%|[1-9]?\d(?:\.\d+)?\%)$/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml
      junit: pytest-report.xml
    paths:
      - coverage.xml
      - pytest-report.xml
    expire_in: 30 days
  tags:
    - docker
  only:
    - branches
    - merge_requests

test:integration:
  stage: test
  image: docker:24-dind
  services:
    - docker:24-dind
  before_script:
    - apk add --no-cache docker-compose python3 py3-pip
    - pip install pytest pytest-asyncio httpx
  script:
    - docker-compose -f docker-compose.test.yml up -d
    - sleep 10  # Wait for services to be ready
    - pytest tests/integration/ --junitxml=integration-report.xml
    - docker-compose -f docker-compose.test.yml down -v
  artifacts:
    reports:
      junit: integration-report.xml
    expire_in: 30 days
  tags:
    - docker
  only:
    - branches
    - merge_requests

# ==========================================
# STAGE: Build
# Factor V: Immutable build artifacts
# ==========================================

build:image:
  stage: build
  image: docker:24-dind
  services:
    - docker:24-dind
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    # Build with layer caching
    - docker pull $CI_REGISTRY_IMAGE:latest || true
    - docker build
      --cache-from $CI_REGISTRY_IMAGE:latest
      --tag $IMAGE_NAME
      --tag $CI_REGISTRY_IMAGE:latest
      --build-arg VERSION=$CI_COMMIT_SHA
      --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
      .

    # Factor VII: Container security scan BEFORE push
    - docker run --rm
      -v /var/run/docker.sock:/var/run/docker.sock
      aquasec/trivy:latest image
      --severity HIGH,CRITICAL
      --exit-code 1
      $IMAGE_NAME

    # Push if scan passes
    - docker push $IMAGE_NAME
    - docker push $CI_REGISTRY_IMAGE:latest
  tags:
    - docker
  only:
    - main
    - develop

# ==========================================
# STAGE: Deploy Staging
# Factor IV: Always validate in staging first
# ==========================================

deploy:staging:
  stage: deploy-staging
  image: bitnami/kubectl:latest
  before_script:
    - echo "$KUBE_CONFIG_STAGING" | base64 -d > $KUBECONFIG
    - kubectl config use-context staging
  script:
    # Update deployment
    - kubectl set image deployment/fastapi-app
      app=$IMAGE_NAME
      -n staging

    # Wait for rollout
    - kubectl rollout status deployment/fastapi-app
      -n staging
      --timeout=5m

    # Health check
    - |
      for i in {1..30}; do
        STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://staging.example.com/health)
        if [ "$STATUS" = "200" ]; then
          echo "✅ Health check passed"
          exit 0
        fi
        echo "⏳ Waiting for service... ($i/30)"
        sleep 10
      done
      echo "❌ Health check failed"
      exit 1
  environment:
    name: staging
    url: https://staging.example.com
    on_stop: stop:staging
  tags:
    - docker
  only:
    - main
    - develop

# ==========================================
# STAGE: Deploy Production
# Factor XII: Orchestrated deployment with validation
# ==========================================

deploy:production:canary:
  stage: deploy-production
  image: bitnami/kubectl:latest
  before_script:
    - echo "$KUBE_CONFIG_PRODUCTION" | base64 -d > $KUBECONFIG
    - kubectl config use-context production
  script:
    # Deploy canary (10% traffic)
    - kubectl apply -f k8s/production/canary.yaml
    - kubectl set image deployment/fastapi-app-canary
      app=$IMAGE_NAME
      -n production

    # Wait for canary rollout
    - kubectl rollout status deployment/fastapi-app-canary
      -n production
      --timeout=5m

    # Factor X: Monitor canary metrics for 10 minutes
    - |
      echo "📊 Monitoring canary metrics..."
      python scripts/monitor-canary.py \
        --duration=10m \
        --error-threshold=1% \
        --latency-p95-threshold=500ms

    # If metrics healthy, promote to full deployment
    - kubectl apply -f k8s/production/deployment.yaml
    - kubectl set image deployment/fastapi-app
      app=$IMAGE_NAME
      -n production

    - kubectl rollout status deployment/fastapi-app
      -n production
      --timeout=10m

    # Post-deployment validation
    - python scripts/validate-deployment.py --env=production
  environment:
    name: production
    url: https://example.com
    on_stop: rollback:production
  when: manual  # Require human approval
  tags:
    - docker
  only:
    - main

# ==========================================
# Rollback capability (Factor VI)
# ==========================================

rollback:production:
  stage: deploy-production
  image: bitnami/kubectl:latest
  before_script:
    - echo "$KUBE_CONFIG_PRODUCTION" | base64 -d > $KUBECONFIG
  script:
    - kubectl rollout undo deployment/fastapi-app -n production
    - kubectl rollout status deployment/fastapi-app -n production --timeout=5m
  environment:
    name: production
    action: rollback
  when: manual
  tags:
    - docker
  only:
    - main
```

### Example 2: Node.js Express API (Optimized for Speed)

```yaml
# .gitlab-ci.yml
# Fast pipeline for Node.js Express API
# Optimized for: developer feedback time <10 minutes

variables:
  npm_config_cache: "$CI_PROJECT_DIR/.npm"
  CYPRESS_CACHE_FOLDER: "$CI_PROJECT_DIR/.cypress"

cache:
  key:
    files:
      - package-lock.json
  paths:
    - .npm
    - .cypress
    - node_modules
  policy: pull-push

stages:
  - validate
  - test
  - build
  - deploy

# Parallel validation (Factor XII)
validate:
  stage: validate
  image: node:18-alpine
  parallel:
    matrix:
      - TASK: [lint, typecheck, audit]
  script:
    - npm ci --cache .npm --prefer-offline
    - |
      case $TASK in
        lint)
          npm run lint
          ;;
        typecheck)
          npm run typecheck
          ;;
        audit)
          npm audit --production --audit-level=high
          ;;
      esac
  tags:
    - docker

# Parallel testing (Factor XII)
test:
  stage: test
  image: node:18-alpine
  parallel:
    matrix:
      - TEST_SUITE: [unit, integration, e2e]
  services:
    - postgres:14
    - redis:7
  variables:
    DATABASE_URL: postgresql://test:test@postgres:5432/test
    REDIS_URL: redis://redis:6379
  before_script:
    - npm ci --cache .npm --prefer-offline
  script:
    - |
      case $TEST_SUITE in
        unit)
          npm run test:unit -- --coverage --ci
          ;;
        integration)
          npm run test:integration -- --ci
          ;;
        e2e)
          npm run test:e2e -- --ci
          ;;
      esac
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
    paths:
      - coverage/
    expire_in: 30 days
  tags:
    - docker

build:
  stage: build
  image: docker:24-dind
  services:
    - docker:24-dind
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  only:
    - main
  tags:
    - docker

deploy:staging:
  stage: deploy
  image: bitnami/kubectl:latest
  script:
    - kubectl set image deployment/express-api app=$CI_REGISTRY_IMAGE:$CI_COMMIT_SHA -n staging
    - kubectl rollout status deployment/express-api -n staging
  environment:
    name: staging
  only:
    - main
  tags:
    - docker
```

---

## GitHub Actions Examples

### Example 1: Go Microservice (Multi-Platform Build)

```yaml
# .github/workflows/deploy.yml
name: Build and Deploy

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  # ==========================================
  # Validate (Factor IV)
  # ==========================================
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.21'
          cache: true

      - name: Format check
        run: |
          if [ "$(gofmt -s -l . | wc -l)" -gt 0 ]; then
            echo "Code not formatted"
            gofmt -s -l .
            exit 1
          fi

      - name: Lint
        uses: golangci/golangci-lint-action@v3
        with:
          version: latest
          args: --timeout=5m

      - name: Vet
        run: go vet ./...

  # ==========================================
  # Security (Factor VII)
  # ==========================================
  security:
    runs-on: ubuntu-latest
    needs: validate
    permissions:
      security-events: write
    steps:
      - uses: actions/checkout@v4

      - name: Run Gosec Security Scanner
        uses: securego/gosec@master
        with:
          args: '-fmt sarif -out gosec-results.sarif ./...'

      - name: Upload SARIF file
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: gosec-results.sarif

      - name: Dependency scan
        run: |
          go list -json -m all | nancy sleuth

  # ==========================================
  # Test (Factor V: Disposable environments)
  # ==========================================
  test:
    runs-on: ubuntu-latest
    needs: validate
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: test
          POSTGRES_DB: test
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432

    steps:
      - uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.21'
          cache: true

      - name: Run tests
        env:
          DATABASE_URL: postgres://postgres:test@localhost:5432/test?sslmode=disable
        run: |
          go test -v -race -coverprofile=coverage.out -covermode=atomic ./...

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.out

  # ==========================================
  # Build (Multi-platform, Factor V)
  # ==========================================
  build:
    runs-on: ubuntu-latest
    needs: [validate, security, test]
    if: github.event_name != 'pull_request'
    permissions:
      contents: read
      packages: write
    strategy:
      matrix:
        platform: [linux/amd64, linux/arm64]
    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=sha,prefix={{branch}}-
            type=semver,pattern={{version}}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          platforms: ${{ matrix.platform }}
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # ==========================================
  # Deploy (Factor XII: Orchestration)
  # ==========================================
  deploy:
    runs-on: ubuntu-latest
    needs: build
    if: github.ref == 'refs/heads/main'
    environment:
      name: production
      url: https://api.example.com
    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Deploy to ECS
        run: |
          aws ecs update-service \
            --cluster production \
            --service go-api \
            --force-new-deployment \
            --desired-count 3

      - name: Wait for deployment
        run: |
          aws ecs wait services-stable \
            --cluster production \
            --services go-api

      - name: Validate deployment
        run: |
          curl -f https://api.example.com/health || exit 1
```

---

## Common Patterns

### Pattern 1: Parallel Security Scans

**Problem:** Security scans run sequentially, taking 15+ minutes
**Solution:** Run all scans in parallel, reduce to 5 minutes

```yaml
# GitLab CI
security:
  stage: security
  parallel:
    matrix:
      - SCAN: [sast, dependency, container, secrets]
  script:
    - case $SCAN in
        sast) semgrep --config=auto . ;;
        dependency) safety check ;;
        container) trivy image $IMAGE ;;
        secrets) gitleaks detect ;;
      esac
```

### Pattern 2: Dependency Caching

**Problem:** Installing dependencies on every run wastes time
**Solution:** Cache based on lock file hash

```yaml
# GitLab CI
cache:
  key:
    files:
      - requirements.txt  # or package-lock.json, go.sum, etc.
  paths:
    - .cache/pip
  policy: pull-push

# GitHub Actions
- uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
```

### Pattern 3: Conditional Deployments

**Problem:** Don't want to deploy every commit
**Solution:** Deploy only on main branch, with manual approval for production

```yaml
# GitLab CI
deploy:production:
  script:
    - kubectl apply -f k8s/production/
  when: manual
  only:
    - main

# GitHub Actions
deploy:
  if: github.ref == 'refs/heads/main'
  environment:
    name: production
```

### Pattern 4: Flaky Test Retry

**Problem:** Tests fail intermittently due to timing issues
**Solution:** Retry failed tests, but report if consistently flaky

```yaml
# GitLab CI
test:integration:
  script:
    - pytest tests/integration/ --reruns 2 --reruns-delay 5
  retry:
    max: 1
    when: script_failure
```

---

## Validation Checklist

Before deploying pipeline changes, validate:

- [ ] **Factor IV:** All stages have clear success/failure criteria
- [ ] **Factor V:** Pipeline runs are reproducible (same inputs = same outputs)
- [ ] **Factor VII:** Security scans block on HIGH/CRITICAL findings
- [ ] **Factor IX:** Successful patterns documented as templates
- [ ] **Factor XII:** Stages run in parallel where possible
- [ ] **Syntax:** Pipeline configuration is valid (yamllint, CI linter)
- [ ] **Testing:** Tested in feature branch before main
- [ ] **Documentation:** Comments explain non-obvious configurations
- [ ] **Secrets:** No hardcoded credentials (use CI/CD variables)
- [ ] **Performance:** Pipeline completes in reasonable time (<30 min)

---

## Common Issues and Solutions

### Issue 1: Flaky Tests

**Symptom:** Tests pass locally but fail in CI intermittently

**Solutions:**
1. Increase timeouts for async operations
2. Add explicit waits instead of sleeps
3. Isolate database state between tests
4. Use retry logic for network-dependent tests
5. Run tests in random order to detect dependencies

```yaml
# Retry flaky tests
pytest tests/ --reruns 3 --reruns-delay 5
```

### Issue 2: Slow Pipelines

**Symptom:** Pipeline takes >30 minutes, slowing development

**Solutions:**
1. Run jobs in parallel (validation, security, tests)
2. Cache dependencies (npm, pip, go modules)
3. Use Docker layer caching
4. Run only affected tests (changed files)
5. Optimize test data generation

```yaml
# Parallel jobs
parallel:
  matrix:
    - JOB: [lint, typecheck, test, security]
```

### Issue 3: Pipeline Configuration Drift

**Symptom:** Multiple teams edit pipeline, inconsistent standards

**Solutions:**
1. Create organization-wide templates
2. Use CI/CD includes for shared configuration
3. Require approval for pipeline changes
4. Validate pipeline against policies
5. Document standards in CONTRIBUTING.md

```yaml
# Include shared configuration
include:
  - project: 'company/ci-templates'
    file: '/templates/python-service.yml'
```

### Issue 4: Security Scan False Positives

**Symptom:** Security scans flag non-issues, teams ignore results

**Solutions:**
1. Tune scan rules to reduce noise
2. Suppress known false positives with comments
3. Block only on HIGH/CRITICAL severity
4. Review and update rules monthly
5. Provide feedback to scanning tools

```yaml
# Block only on high severity
trivy image --severity HIGH,CRITICAL --exit-code 1 $IMAGE
```

---

## Next Steps

1. **Choose platform:** GitLab CI, GitHub Actions, Jenkins, CircleCI
2. **Start simple:** Copy basic template for your language/framework
3. **Add validation:** Integrate linting, testing, security scanning
4. **Optimize:** Add caching, parallelization based on metrics
5. **Extract patterns:** Create templates for future services

**Need help?** See related agents:
- `/agent security-scan` - Security scanning integration
- `/agent progressive-deploy` - Deployment strategies

---

**Version:** v1.0.0
**Last Updated:** 2025-11-09
**Maintained by:** 12-Factor AgentOps Project
