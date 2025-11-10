Run comprehensive security scanning suite across all pipelines and repositories.

This command orchestrates multiple security scanning tools following Factor VII (Zero-Trust) principles.

## What This Command Does

1. **SAST Scanning** - Static code analysis for vulnerabilities
2. **Dependency Scanning** - Check for known CVEs in dependencies
3. **Container Scanning** - Scan Docker images for vulnerabilities
4. **Secrets Detection** - Prevent committed secrets
5. **Configuration Scanning** - Validate IaC security

## Usage

```bash
# Run all security scans
/run-security-scans

# Run specific scan type
/run-security-scans --type=sast
/run-security-scans --type=dependency
/run-security-scans --type=container
/run-security-scans --type=secrets

# Run with different severity threshold
/run-security-scans --severity=critical
/run-security-scans --severity=high
```

## Example Output

```
=====================================
Security Scan Suite - 2025-11-09 14:32:15 UTC
=====================================

1. Running SAST scan (Semgrep)...
✅ SAST scan passed (0 CRITICAL findings)

2. Running dependency scan...
❌ CRITICAL dependency vulnerabilities: 2
  - requests 2.28.0 (CVE-2024-12345)
  - pillow 9.5.0 (CVE-2024-54321)

3. Running container scan (Trivy)...
✅ Container scan passed (0 HIGH/CRITICAL vulnerabilities)

4. Running secrets detection (gitleaks)...
✅ No secrets found

5. Running configuration scan (Trivy)...
✅ Configuration scan passed (0 CRITICAL issues)

======================================
Security Scan Summary
======================================

| Scan Type       | Status   | Findings |
|-----------------|----------|----------|
| SAST            | ✅ PASS  | 0        |
| Dependencies    | ❌ FAIL  | 2        |
| Container       | ✅ PASS  | 0        |
| Secrets         | ✅ PASS  | 0        |
| Configuration   | ✅ PASS  | 0        |

Next Actions:
- [ ] Update vulnerable dependencies
  - requests 2.28.0 → 2.31.0
  - pillow 9.5.0 → 10.0.1

Reports saved to: reports/security/
```

## When to Use

- **Daily:** Quick security validation before commits
- **PR checks:** Validate changes don't introduce vulnerabilities
- **Weekly:** Comprehensive security review
- **Pre-deployment:** Final security gate before production
- **Incident response:** Audit after security incidents

## Integration with 12-Factor

- **Factor IV:** Validation gates block on security findings
- **Factor VII:** Zero-trust security scanning
- **Factor IX:** Security patterns documented for reuse
- **Factor XI:** Learn from scan results, tune rules

## Related

- See `/agent security-scan` for detailed configuration
- See `examples/devops/README.md` for security workflow examples
- See `.claude/agents/security-scan.md` for tool setup

## Implementation

This command runs the security scan script located at:
`scripts/security-scan.sh`

The script orchestrates multiple tools:
- Semgrep (SAST)
- Safety/npm audit (dependencies)
- Trivy (containers + config)
- gitleaks (secrets)

Results are saved to `reports/security/` with timestamps for tracking trends over time.
