# Security Policy

## Supported Versions

Currently supported versions for security updates:

| Version | Supported          |
| ------- | ------------------ |
| 2.0.x   | :white_check_mark: |
| 0.9.x   | :white_check_mark: |
| < 0.9   | :x:                |

## Reporting a Vulnerability

**Please DO NOT report security vulnerabilities through public GitHub issues.**

### How to Report

If you discover a security vulnerability in this documentation or related tooling, please send an email to:

**[INSERT SECURITY EMAIL]**

Include the following information:

- Type of issue (e.g., information disclosure, malicious content injection, etc.)
- Full paths of files related to the manifestation of the issue
- The location of the affected content (tag/branch/commit or direct URL)
- Step-by-step instructions to reproduce the issue
- Proof-of-concept (if applicable)
- Impact of the issue, including how it might be exploited

### What to Expect

- **Acknowledgment:** Within 48 hours
- **Initial Assessment:** Within 5 business days
- **Status Updates:** Every 7 days until resolved
- **Resolution Timeline:** Depends on severity
  - **Critical:** 7 days
  - **High:** 30 days
  - **Medium:** 90 days
  - **Low:** Best effort

### Disclosure Policy

- Security issues are handled privately until a fix is available
- After a fix is released, we will:
  - Publish a security advisory
  - Credit the reporter (if desired)
  - Document the vulnerability in release notes

### Security Update Process

1. **Report received** → Acknowledged within 48 hours
2. **Validation** → Confirm and assess severity
3. **Fix development** → Content updated and reviewed
4. **Release** → Security update published
5. **Disclosure** → Advisory published 7 days after release

## Security Best Practices

### For Contributors

When contributing documentation or scripts:

✅ **DO:**
- Sanitize example code and remove credentials
- Use placeholder values for sensitive data (e.g., `[YOUR_API_KEY]`)
- Review automation scripts for command injection vulnerabilities
- Validate external links for security
- Use environment variables for secrets in examples
- Follow secure coding guidelines in code examples

❌ **DON'T:**
- Include real credentials, API keys, or tokens in documentation
- Reference internal/private systems without obfuscation
- Provide examples that could be used maliciously
- Use deprecated security practices in examples
- Include personally identifiable information (PII)

### For Script Validation

When using validation scripts:

✅ **DO:**
- Review scripts before execution
- Understand what the script does
- Use read-only operations when possible
- Run in test environments first
- Keep scripts updated

❌ **DON'T:**
- Run untrusted scripts without review
- Execute scripts with elevated privileges unnecessarily
- Ignore script warnings or errors
- Modify security checks to pass validation

## Known Security Considerations

### Documentation Repository

This is primarily a documentation repository:

- **Content Security:** All examples should use placeholder credentials
- **Link Integrity:** External links validated to prevent phishing
- **Code Examples:** Reviewed for security anti-patterns

### Validation Scripts

Shell scripts in `scripts/` directory:

- **Input Validation:** All scripts validate inputs
- **Path Safety:** Scripts use safe path resolution
- **Read-Only:** Validation scripts don't modify repository by default
- **Error Handling:** Fail-safe defaults and clear error messages

### External Links

Documentation includes links to:

- Trinity sibling repositories (agentops, agentops-showcase)
- External documentation and resources
- Industry best practices and standards

All links are reviewed for:
- Security (HTTPS preferred)
- Relevance and accuracy
- Phishing/malware risk

## Security Contacts

| Role | Contact |
|------|---------|
| Security Lead | [INSERT NAME/EMAIL] |
| Backup Contact | [INSERT NAME/EMAIL] |
| Project Maintainer | [INSERT NAME/EMAIL] |

## Recognition

We appreciate security researchers who responsibly disclose vulnerabilities. Contributors will be:

- Credited in release notes (if desired)
- Listed in our security acknowledgments
- Eligible for recognition (for significant findings)

## Additional Resources

- [OWASP Documentation Security](https://owasp.org/)
- [Secure Documentation Best Practices](https://documentation.divio.com/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

## Related Repositories

- [agentops](../agentops) - Orchestration engine with implementation-specific security considerations
- [agentops-showcase](../agentops-showcase) - Web application with additional security policies

---

**Last Updated:** 2025-11-08
**Policy Version:** 1.0.0

Thank you for helping keep 12-Factor AgentOps and its users safe!
