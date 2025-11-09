# Security Scan Agent

**Purpose:** Integrate security scanning into CI/CD pipelines and development workflows following Zero-Trust principles (Factor VII).

**Scope:** SAST, DAST, dependency scanning, container scanning, secrets detection, compliance validation.

---

## Laws of an Agent

Before using this agent, understand the Five Laws that govern all agent interactions:

### Law 1: ALWAYS Extract Learnings
- Document security vulnerabilities and patterns
- Capture why certain vulnerabilities occur repeatedly
- Analyze security scan results for prevention strategies

### Law 2: ALWAYS Improve Self or System
- Identify security posture improvements
- Quantify impact (CVEs prevented, patch time reduced)
- Propose actionable security enhancements

### Law 3: ALWAYS Document Context for Future Agents
- **Context:** Why this security scan was needed
- **Solution:** What vulnerabilities were found and fixed
- **Learning:** Reusable security insights
- **Impact:** Risk reduction, compliance improvement

### Law 4: ALWAYS Validate Before Execute
- Test security scan configurations before production use
- Verify scan results accuracy (check false positive rate)
- Validate remediation fixes actually resolve vulnerabilities

### Law 5: ALWAYS Share Patterns Publicly
- Extract successful security patterns as templates
- Document vulnerability types and fixes
- Help other teams avoid security mistakes

---

## 12-Factor Mapping

This agent implements:

- **Factor II (JIT Context):** Loads security context only when needed, not entire vulnerability database
- **Factor III (Single-Responsibility):** Handles ONLY security scanning, delegates deployment to progressive-deploy agent
- **Factor IV (Validation Gates):** Security scans block deployment on critical findings
- **Factor VII (Zero-Trust):** Never trust code, dependencies, containers, or configurations
- **Factor IX (Pattern Extraction):** Security patterns become organizational knowledge
- **Factor XI (Adaptive Learning):** Learn from false positives, tune scan rules over time

---

## Core Capabilities

### 1. SAST (Static Application Security Testing)

**Purpose:** Analyze source code for security vulnerabilities before runtime.

**Tools supported:**
- Semgrep (multi-language)
- SonarQube (enterprise-grade)
- Bandit (Python)
- Gosec (Go)
- ESLint security plugins (JavaScript/TypeScript)
- Brakeman (Ruby on Rails)

**Example prompts:**

```markdown
Configure Semgrep SAST scanning for Python FastAPI application:
- Scan for: SQL injection, XSS, hardcoded secrets, insecure cryptography
- Block on: HIGH and CRITICAL severity
- Report format: SARIF for GitHub/GitLab integration
```

```markdown
Set up SonarQube for Java Spring Boot application:
- Quality gates: A rating on security, B on maintainability
- Coverage requirement: >80%
- Block deployment on new vulnerabilities
```

**Common vulnerabilities detected:**
- SQL injection
- Cross-site scripting (XSS)
- Cross-site request forgery (CSRF)
- Insecure deserialization
- Hardcoded secrets
- Weak cryptography
- Path traversal
- Command injection

### 2. Dependency Scanning

**Purpose:** Identify known vulnerabilities in third-party dependencies.

**Tools supported:**
- Safety (Python)
- npm audit / Snyk (JavaScript/Node.js)
- OWASP Dependency-Check (Java)
- Trivy (multi-language)
- bundler-audit (Ruby)
- cargo-audit (Rust)

**Example prompts:**

```markdown
Configure dependency scanning for Node.js application:
- Tool: npm audit + Snyk
- Severity threshold: HIGH and above
- Auto-fix: Create PRs for safe updates
- Report: Weekly summary of new vulnerabilities
```

```markdown
Set up Python dependency scanning with Safety:
- Check against CVE database
- Block on: HIGH/CRITICAL vulnerabilities
- Allowed exceptions: Document in .safety-policy.json
```

**Vulnerability databases:**
- CVE (Common Vulnerabilities and Exposures)
- NVD (National Vulnerability Database)
- GitHub Advisory Database
- Snyk Vulnerability Database

### 3. Container Scanning

**Purpose:** Scan container images for vulnerabilities in base images and layers.

**Tools supported:**
- Trivy (comprehensive, fast)
- Grype (Anchore)
- Clair (CoreOS)
- Snyk Container
- Docker Scout

**Example prompts:**

```markdown
Configure Trivy container scanning for Docker images:
- Scan: OS packages, language dependencies, misconfigurations
- Severity threshold: HIGH and CRITICAL
- Block: Don't push images with vulnerabilities
- Report: Save SARIF for tracking
```

```markdown
Scan Kubernetes deployment manifests for security issues:
- Check for: privileged containers, host network access, missing resource limits
- Tool: kubesec or Trivy config scanning
- Block on: CRITICAL misconfigurations
```

**Common container issues:**
- Vulnerable base images (outdated OS packages)
- Exposed secrets in environment variables
- Running as root user
- Excessive container capabilities
- Missing security contexts
- Unpatched CVEs in dependencies

### 4. Secrets Detection

**Purpose:** Prevent committing secrets to version control.

**Tools supported:**
- gitleaks (comprehensive)
- TruffleHog (high accuracy)
- detect-secrets (Yelp)
- git-secrets (AWS)

**Example prompts:**

```markdown
Configure gitleaks for secrets detection:
- Scan: Git history, staged files, working directory
- Detect: API keys, passwords, private keys, tokens
- Block: Pre-commit hook prevents secrets from being committed
- Report: Send alerts to security team
```

```markdown
Audit git history for accidentally committed secrets:
- Scan last 1000 commits
- Check for: AWS keys, database passwords, private certificates
- Generate report of findings
- Provide remediation steps (rotate keys, rewrite history)
```

**Common secrets found:**
- API keys (AWS, Google Cloud, Azure)
- Database connection strings
- Private SSH keys
- Authentication tokens
- OAuth client secrets
- Encryption keys

### 5. DAST (Dynamic Application Security Testing)

**Purpose:** Test running applications for vulnerabilities.

**Tools supported:**
- OWASP ZAP (Zed Attack Proxy)
- Burp Suite
- Nikto
- w3af

**Example prompts:**

```markdown
Configure OWASP ZAP for API security testing:
- Target: Staging environment API (https://staging-api.example.com)
- Scans: SQL injection, XSS, authentication bypass
- Credentials: Use test account for authenticated scans
- Report: ZAP report format + SARIF
```

```markdown
Set up weekly DAST scans for production web application:
- Scan window: Saturday 2am-6am (low traffic)
- Passive scan: Always running
- Active scan: Weekly comprehensive test
- Alerts: Email security team on HIGH findings
```

**Common runtime vulnerabilities:**
- Authentication bypass
- Broken access control
- Security misconfiguration
- XML external entities (XXE)
- Server-side request forgery (SSRF)
- Insecure direct object references

### 6. Compliance Validation

**Purpose:** Validate configurations against compliance standards.

**Standards supported:**
- PCI-DSS (payment card industry)
- SOC 2 (security, availability, confidentiality)
- HIPAA (healthcare)
- GDPR (data protection)
- CIS Benchmarks
- NIST frameworks

**Example prompts:**

```markdown
Validate infrastructure against CIS Docker Benchmark:
- Scan: Docker daemon, images, containers, runtime
- Report: Pass/fail for each control
- Remediation: Provide fixing steps for failures
```

```markdown
Check Kubernetes cluster for PCI-DSS compliance:
- Network segmentation (separate namespaces)
- Encryption at rest and in transit
- Access controls (RBAC)
- Audit logging enabled
- Generate compliance report
```

---

## Tool Integration Examples

### Example 1: Semgrep (SAST)

```yaml
# .gitlab-ci.yml
security:sast:
  stage: security
  image: returntocorp/semgrep:latest
  script:
    # Run Semgrep with auto-detection of rules
    - semgrep --config=auto
      --json
      --output=gl-sast-report.json
      .

    # Custom rules for organization-specific patterns
    - semgrep --config=.semgrep/custom-rules/
      --json
      --output=custom-sast-report.json
      .

    # Parse results and enforce severity thresholds
    - |
      CRITICAL=$(jq '[.results[] | select(.extra.severity == "ERROR")] | length' gl-sast-report.json)
      HIGH=$(jq '[.results[] | select(.extra.severity == "WARNING")] | length' gl-sast-report.json)

      echo "CRITICAL findings: $CRITICAL"
      echo "HIGH findings: $HIGH"

      if [ "$CRITICAL" -gt 0 ]; then
        echo "❌ CRITICAL vulnerabilities found! Blocking deployment."
        jq '.results[] | select(.extra.severity == "ERROR")' gl-sast-report.json
        exit 1
      fi

      if [ "$HIGH" -gt 5 ]; then
        echo "⚠️  Too many HIGH severity issues (>5). Review required."
        exit 1
      fi

  artifacts:
    reports:
      sast: gl-sast-report.json
    paths:
      - gl-sast-report.json
      - custom-sast-report.json
    expire_in: 30 days
  allow_failure: false
  tags:
    - docker
```

### Example 2: Trivy (Container + Dependency Scanning)

```yaml
# .gitlab-ci.yml
security:container:
  stage: security
  image: aquasec/trivy:latest
  services:
    - docker:dind
  variables:
    DOCKER_HOST: tcp://docker:2376
    DOCKER_TLS_CERTDIR: "/certs"
    IMAGE_NAME: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  script:
    # Scan container image
    - trivy image
      --severity HIGH,CRITICAL
      --format json
      --output container-scan.json
      $IMAGE_NAME

    # Scan filesystem for dependencies
    - trivy fs
      --severity HIGH,CRITICAL
      --format json
      --output fs-scan.json
      .

    # Scan misconfigurations in IaC
    - trivy config
      --severity HIGH,CRITICAL
      --format json
      --output config-scan.json
      k8s/

    # Check for vulnerabilities
    - |
      CONTAINER_VULNS=$(jq '[.Results[].Vulnerabilities // [] | .[] | select(.Severity == "HIGH" or .Severity == "CRITICAL")] | length' container-scan.json)
      FS_VULNS=$(jq '[.Results[].Vulnerabilities // [] | .[] | select(.Severity == "HIGH" or .Severity == "CRITICAL")] | length' fs-scan.json)
      CONFIG_ISSUES=$(jq '[.Results[].Misconfigurations // [] | .[] | select(.Severity == "HIGH" or .Severity == "CRITICAL")] | length' config-scan.json)

      echo "Container vulnerabilities: $CONTAINER_VULNS"
      echo "Filesystem vulnerabilities: $FS_VULNS"
      echo "Configuration issues: $CONFIG_ISSUES"

      TOTAL=$((CONTAINER_VULNS + FS_VULNS + CONFIG_ISSUES))

      if [ "$TOTAL" -gt 0 ]; then
        echo "❌ Found $TOTAL HIGH/CRITICAL issues!"
        echo "=== Container Vulnerabilities ==="
        jq '.Results[].Vulnerabilities // [] | .[] | select(.Severity == "HIGH" or .Severity == "CRITICAL") | {VulnerabilityID, PkgName, Severity, Title}' container-scan.json
        echo "=== Filesystem Vulnerabilities ==="
        jq '.Results[].Vulnerabilities // [] | .[] | select(.Severity == "HIGH" or .Severity == "CRITICAL") | {VulnerabilityID, PkgName, Severity, Title}' fs-scan.json
        echo "=== Configuration Issues ==="
        jq '.Results[].Misconfigurations // [] | .[] | select(.Severity == "HIGH" or .Severity == "CRITICAL") | {ID, Title, Severity}' config-scan.json
        exit 1
      fi

      echo "✅ No HIGH/CRITICAL vulnerabilities found"

  artifacts:
    paths:
      - container-scan.json
      - fs-scan.json
      - config-scan.json
    expire_in: 30 days
  allow_failure: false
  tags:
    - docker
```

### Example 3: gitleaks (Secrets Detection)

```yaml
# .gitlab-ci.yml
security:secrets:
  stage: security
  image: zricethezav/gitleaks:latest
  script:
    # Scan current commit
    - gitleaks detect
      --source .
      --report-path gitleaks-report.json
      --report-format json
      --exit-code 1  # Fail if secrets found

  artifacts:
    paths:
      - gitleaks-report.json
    expire_in: 30 days
    when: on_failure
  allow_failure: false
  tags:
    - docker

# Pre-commit hook (install locally)
# .git/hooks/pre-commit:
#!/bin/bash
gitleaks protect --staged --verbose
```

### Example 4: Safety (Python Dependencies)

```yaml
# .gitlab-ci.yml
security:dependency:python:
  stage: security
  image: python:3.11-slim
  before_script:
    - pip install safety
  script:
    # Check dependencies against vulnerability database
    - safety check
      --json
      --output dependency-scan.json
      --file requirements.txt
      || true  # Don't fail yet, parse results

    # Parse and enforce policy
    - |
      python << 'EOF'
      import json
      import sys

      with open('dependency-scan.json') as f:
          data = json.load(f)

      vulnerabilities = data.get('vulnerabilities', [])

      critical = [v for v in vulnerabilities if v.get('severity') == 'critical']
      high = [v for v in vulnerabilities if v.get('severity') == 'high']

      print(f"CRITICAL vulnerabilities: {len(critical)}")
      print(f"HIGH vulnerabilities: {len(high)}")

      if critical:
          print("\n❌ CRITICAL vulnerabilities found:")
          for vuln in critical:
              print(f"  - {vuln['package']} {vuln['vulnerable_versions']}")
              print(f"    CVE: {vuln.get('CVE', 'N/A')}")
              print(f"    Fix: Update to {vuln['safe_versions']}")
          sys.exit(1)

      if len(high) > 3:
          print("\n⚠️  Too many HIGH severity vulnerabilities (>3)")
          for vuln in high[:3]:
              print(f"  - {vuln['package']} {vuln['vulnerable_versions']}")
          sys.exit(1)

      print("\n✅ Dependency security check passed")
      EOF

  artifacts:
    paths:
      - dependency-scan.json
    expire_in: 30 days
  allow_failure: false
  tags:
    - docker
```

### Example 5: OWASP ZAP (DAST)

```yaml
# .gitlab-ci.yml
security:dast:
  stage: security
  image: owasp/zap2docker-stable
  services:
    - name: $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
      alias: app
  variables:
    APP_URL: http://app:8000
    ZAP_TARGET: http://app:8000
  script:
    # Baseline scan (passive)
    - zap-baseline.py
      -t $ZAP_TARGET
      -r zap-baseline-report.html
      -J zap-baseline-report.json
      -w zap-baseline-report.md
      -I  # Ignore false positives from .zap/ignore

    # Full scan (active) - only on schedules
    - |
      if [ "$CI_PIPELINE_SOURCE" = "schedule" ]; then
        echo "Running full active scan..."
        zap-full-scan.py \
          -t $ZAP_TARGET \
          -r zap-full-report.html \
          -J zap-full-report.json \
          -I
      fi

  artifacts:
    paths:
      - zap-*.html
      - zap-*.json
      - zap-*.md
    expire_in: 30 days
  allow_failure: true  # DAST can be noisy
  tags:
    - docker
  only:
    - main
    - schedules
```

---

## Security Workflow Scripts

### Comprehensive Security Scan Script

```bash
#!/bin/bash
# scripts/security-scan.sh
# Comprehensive security scanning following Factor VII (Zero-Trust)

set -euo pipefail

# Configuration
SEVERITY_THRESHOLD="HIGH"
REPORTS_DIR="reports/security"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H%M%S")

mkdir -p "$REPORTS_DIR"

echo "========================================"
echo "Security Scan Suite - $(date -u)"
echo "========================================"

# ==========================================
# 1. SAST Scanning
# ==========================================
echo ""
echo "1. Running SAST scan (Semgrep)..."
semgrep \
  --config=auto \
  --json \
  --output="$REPORTS_DIR/sast-$TIMESTAMP.json" \
  .

CRITICAL_SAST=$(jq '[.results[] | select(.extra.severity == "ERROR")] | length' "$REPORTS_DIR/sast-$TIMESTAMP.json")

if [ "$CRITICAL_SAST" -gt 0 ]; then
  echo "❌ CRITICAL SAST findings: $CRITICAL_SAST"
  jq '.results[] | select(.extra.severity == "ERROR") | {path, check_id, message}' "$REPORTS_DIR/sast-$TIMESTAMP.json"
  SAST_FAILED=1
else
  echo "✅ SAST scan passed"
  SAST_FAILED=0
fi

# ==========================================
# 2. Dependency Scanning
# ==========================================
echo ""
echo "2. Running dependency scan..."
if [ -f "requirements.txt" ]; then
  # Python
  safety check \
    --json \
    --output="$REPORTS_DIR/dependency-$TIMESTAMP.json" \
    || true

  CRITICAL_DEPS=$(jq '[.vulnerabilities[] | select(.severity == "critical" or .severity == "high")] | length' "$REPORTS_DIR/dependency-$TIMESTAMP.json")

elif [ -f "package.json" ]; then
  # Node.js
  npm audit --json > "$REPORTS_DIR/dependency-$TIMESTAMP.json" || true
  CRITICAL_DEPS=$(jq '[.vulnerabilities | to_entries[] | select(.value.severity == "critical" or .value.severity == "high")] | length' "$REPORTS_DIR/dependency-$TIMESTAMP.json")

elif [ -f "go.mod" ]; then
  # Go
  nancy sleuth -o json > "$REPORTS_DIR/dependency-$TIMESTAMP.json" || true
  CRITICAL_DEPS=$(jq '[.vulnerable[] | select(.Severity >= 7)] | length' "$REPORTS_DIR/dependency-$TIMESTAMP.json")
fi

if [ "${CRITICAL_DEPS:-0}" -gt 0 ]; then
  echo "❌ CRITICAL dependency vulnerabilities: $CRITICAL_DEPS"
  DEPS_FAILED=1
else
  echo "✅ Dependency scan passed"
  DEPS_FAILED=0
fi

# ==========================================
# 3. Container Scanning
# ==========================================
echo ""
echo "3. Running container scan (Trivy)..."
if [ -f "Dockerfile" ]; then
  # Build image first
  IMAGE_NAME="scan-temp:${TIMESTAMP}"
  docker build -t "$IMAGE_NAME" .

  trivy image \
    --severity HIGH,CRITICAL \
    --format json \
    --output "$REPORTS_DIR/container-$TIMESTAMP.json" \
    "$IMAGE_NAME"

  CRITICAL_CONTAINER=$(jq '[.Results[].Vulnerabilities // [] | .[] | select(.Severity == "CRITICAL" or .Severity == "HIGH")] | length' "$REPORTS_DIR/container-$TIMESTAMP.json")

  # Cleanup temp image
  docker rmi "$IMAGE_NAME"

  if [ "$CRITICAL_CONTAINER" -gt 0 ]; then
    echo "❌ CRITICAL container vulnerabilities: $CRITICAL_CONTAINER"
    jq '.Results[].Vulnerabilities // [] | .[] | select(.Severity == "CRITICAL" or .Severity == "HIGH") | {VulnerabilityID, PkgName, Severity}' "$REPORTS_DIR/container-$TIMESTAMP.json"
    CONTAINER_FAILED=1
  else
    echo "✅ Container scan passed"
    CONTAINER_FAILED=0
  fi
else
  echo "⊘ No Dockerfile found, skipping container scan"
  CONTAINER_FAILED=0
fi

# ==========================================
# 4. Secrets Detection
# ==========================================
echo ""
echo "4. Running secrets detection (gitleaks)..."
gitleaks detect \
  --no-git \
  --report-path="$REPORTS_DIR/secrets-$TIMESTAMP.json" \
  || true

if [ -f "$REPORTS_DIR/secrets-$TIMESTAMP.json" ]; then
  SECRETS_FOUND=$(jq '. | length' "$REPORTS_DIR/secrets-$TIMESTAMP.json")

  if [ "$SECRETS_FOUND" -gt 0 ]; then
    echo "❌ Secrets detected: $SECRETS_FOUND"
    jq '.[] | {Description, File, StartLine}' "$REPORTS_DIR/secrets-$TIMESTAMP.json"
    SECRETS_FAILED=1
  else
    echo "✅ No secrets found"
    SECRETS_FAILED=0
  fi
else
  echo "✅ No secrets found"
  SECRETS_FAILED=0
fi

# ==========================================
# 5. Configuration Scanning
# ==========================================
echo ""
echo "5. Running configuration scan (Trivy)..."
if [ -d "k8s" ] || [ -d "terraform" ]; then
  trivy config \
    --severity HIGH,CRITICAL \
    --format json \
    --output "$REPORTS_DIR/config-$TIMESTAMP.json" \
    .

  CRITICAL_CONFIG=$(jq '[.Results[].Misconfigurations // [] | .[] | select(.Severity == "CRITICAL" or .Severity == "HIGH")] | length' "$REPORTS_DIR/config-$TIMESTAMP.json")

  if [ "$CRITICAL_CONFIG" -gt 0 ]; then
    echo "❌ CRITICAL configuration issues: $CRITICAL_CONFIG"
    jq '.Results[].Misconfigurations // [] | .[] | select(.Severity == "CRITICAL" or .Severity == "HIGH") | {ID, Title, Severity}' "$REPORTS_DIR/config-$TIMESTAMP.json"
    CONFIG_FAILED=1
  else
    echo "✅ Configuration scan passed"
    CONFIG_FAILED=0
  fi
else
  echo "⊘ No IaC configs found, skipping"
  CONFIG_FAILED=0
fi

# ==========================================
# Generate Summary Report
# ==========================================
echo ""
echo "========================================"
echo "Security Scan Summary"
echo "========================================"

cat > "$REPORTS_DIR/summary-$TIMESTAMP.md" <<EOF
# Security Scan Summary

**Date:** $(date -u +"%Y-%m-%d %H:%M:%S UTC")
**Commit:** $(git rev-parse --short HEAD)

## Results

| Scan Type | Status | Critical/High Findings |
|-----------|--------|------------------------|
| SAST | $([ $SAST_FAILED -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL") | $CRITICAL_SAST |
| Dependencies | $([ $DEPS_FAILED -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL") | ${CRITICAL_DEPS:-0} |
| Container | $([ $CONTAINER_FAILED -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL") | ${CRITICAL_CONTAINER:-0} |
| Secrets | $([ $SECRETS_FAILED -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL") | ${SECRETS_FOUND:-0} |
| Configuration | $([ $CONFIG_FAILED -eq 0 ] && echo "✅ PASS" || echo "❌ FAIL") | ${CRITICAL_CONFIG:-0} |

## Factor Compliance

- ✅ Factor VII: Zero-Trust security validation enforced
- ✅ Factor IV: Validation gates block on critical findings
- ✅ Factor IX: Security patterns documented

## Detailed Reports

- SAST: \`$REPORTS_DIR/sast-$TIMESTAMP.json\`
- Dependencies: \`$REPORTS_DIR/dependency-$TIMESTAMP.json\`
- Container: \`$REPORTS_DIR/container-$TIMESTAMP.json\`
- Secrets: \`$REPORTS_DIR/secrets-$TIMESTAMP.json\`
- Configuration: \`$REPORTS_DIR/config-$TIMESTAMP.json\`

## Next Actions

EOF

# Add action items based on failures
if [ $SAST_FAILED -eq 1 ]; then
  echo "- [ ] Fix SAST vulnerabilities (see report)" >> "$REPORTS_DIR/summary-$TIMESTAMP.md"
fi
if [ $DEPS_FAILED -eq 1 ]; then
  echo "- [ ] Update vulnerable dependencies" >> "$REPORTS_DIR/summary-$TIMESTAMP.md"
fi
if [ $CONTAINER_FAILED -eq 1 ]; then
  echo "- [ ] Update base image or rebuild with patched packages" >> "$REPORTS_DIR/summary-$TIMESTAMP.md"
fi
if [ $SECRETS_FAILED -eq 1 ]; then
  echo "- [ ] Remove secrets from code, rotate credentials" >> "$REPORTS_DIR/summary-$TIMESTAMP.md"
fi
if [ $CONFIG_FAILED -eq 1 ]; then
  echo "- [ ] Fix infrastructure configuration issues" >> "$REPORTS_DIR/summary-$TIMESTAMP.md"
fi

cat "$REPORTS_DIR/summary-$TIMESTAMP.md"

# ==========================================
# Exit with failure if any scan failed
# ==========================================
TOTAL_FAILURES=$((SAST_FAILED + DEPS_FAILED + CONTAINER_FAILED + SECRETS_FAILED + CONFIG_FAILED))

if [ $TOTAL_FAILURES -gt 0 ]; then
  echo ""
  echo "❌ Security scan FAILED with $TOTAL_FAILURES issue(s)"
  exit 1
else
  echo ""
  echo "✅ All security scans PASSED"
  exit 0
fi
```

---

## Common Security Patterns

### Pattern 1: Security-First Pipeline

```yaml
stages:
  - validate
  - security  # Security BEFORE tests
  - test
  - build
  - deploy

# Block everything if security fails
security:
  stage: security
  allow_failure: false  # Hard requirement
```

### Pattern 2: Layered Security Scanning

```
Layer 1: Pre-commit (secrets detection)
Layer 2: PR check (SAST + dependency scan)
Layer 3: Main branch (full security suite + DAST)
Layer 4: Pre-deployment (container scan + config scan)
Layer 5: Runtime (continuous monitoring)
```

### Pattern 3: Auto-Remediation

```yaml
dependency-update:
  stage: remediate
  rules:
    - if: '$CI_PIPELINE_SOURCE == "schedule"'
  script:
    - safety check --auto-update
    - git commit -am "security: auto-update dependencies"
    - git push
```

---

## Validation Checklist

Before deploying security scans:

- [ ] **All critical scans configured:** SAST, dependency, container, secrets
- [ ] **Severity thresholds set:** Block on HIGH/CRITICAL
- [ ] **False positive handling:** Document exceptions, tune rules
- [ ] **Reporting in place:** Save artifacts, integrate with security dashboards
- [ ] **Remediation workflow:** Clear process for fixing findings
- [ ] **Regular updates:** Scan rules and vulnerability databases up to date
- [ ] **Performance acceptable:** Scans complete in reasonable time (<15 min)
- [ ] **Team trained:** Developers know how to interpret and fix findings

---

## Next Steps

1. **Start with secrets detection** (fastest value, prevents incidents)
2. **Add dependency scanning** (protects from known CVEs)
3. **Integrate SAST** (catches code-level vulnerabilities)
4. **Add container scanning** (secures runtime environment)
5. **Consider DAST** (tests running application security)

**Need help?** See related agents:
- `/agent pipeline-guide` - CI/CD pipeline integration
- `/agent progressive-deploy` - Secure deployment strategies

---

**Version:** v1.0.0
**Last Updated:** 2025-11-09
**Maintained by:** 12-Factor AgentOps Project
