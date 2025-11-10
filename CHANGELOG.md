# Changelog

All notable changes to 12-Factor AgentOps will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- CITATION.bib for academic citations
- Professional README polish for open source quality

### Changed
- Fixed broken documentation links in README
- Renamed .github/README.md to CONFIGURATION.md to fix homepage display
- Updated author attribution and maintainer information
- **Factor II renamed:** "Fresh Context Windows (40% Rule)" → "JIT Context Loading"
  - Updated focus: From "stay under 40%" to "delegate to sub-agents with isolated context"
  - Main agent stays lean (10-20%), sub-agents handle deep work with JIT loading
  - 40% threshold preserved as safety limit for main agent context
  - All documentation updated to reflect sub-agent architecture pattern

## [1.0.0] - 2025-11-08

### Added
- Complete documentation for all 12 Factors
  - Factor I: Git Memory as Knowledge OS
  - Factor II: JIT Context Loading
  - Factor III: Single-Responsibility Agents
  - Factor IV: Validation Gates Before Execution
  - Factor V: Operational Telemetry
  - Factor VI: Session Continuity via Bundles
  - Factor VII: Intelligent Task Routing
  - Factor VIII: Human Gate Reviews
  - Factor IX: Documented Pattern Extraction
  - Factor X: Continuous Improvement Backlog
  - Factor XI: Constitutional Guardrails
  - Factor XII: Domain Portability
- ARCHITECTURE.md showing derivation from Four Pillars to Five Laws to Twelve Factors
- Comprehensive validation infrastructure and honest disclaimer
- Open source standards enforcement
  - CODE_OF_CONDUCT.md
  - SECURITY.md
  - OPENSOURCE_STANDARDS.md
- VERSION file for version alignment
- Enhanced Makefile with validation targets

### Changed
- Repository focus: standalone philosophy and patterns framework
- Updated README to reflect open source quality standards
- Enhanced documentation structure and validation
- Clarified relationship to implementation repositories (in preparation for public release)

### Documentation
- Four Pillars framework complete
- Five Laws operational principles complete
- Pattern catalog with validated examples
- Validation studies and methodology
- Research foundation documentation


## [0.9.0] - 2025-09-15

### Added
- Initial project structure
- Basic documentation framework
- Foundation concepts draft
- Pattern documentation structure
- Profile directory structure

### Documentation
- Initial README.md
- Basic CONTRIBUTING.md
- LICENSE file (MIT)
- Initial pattern documentation

---

## Version History Summary

| Version | Date | Highlights |
|---------|------|------------|
| Unreleased | - | Documentation polish, citation file |
| 1.0.0 | 2025-11-08 | Complete 12 Factors, Four Pillars, Five Laws, validation framework |
| 0.9.0 | 2025-09-15 | Initial release, documentation framework |

---

## Notes

### Versioning Strategy

- **Major (X.0.0):** Breaking changes, architectural shifts
- **Minor (0.X.0):** New patterns, significant content additions
- **Patch (0.0.X):** Bug fixes, minor improvements, documentation updates

### Release Process

1. Update CHANGELOG.md with changes
2. Update VERSION file
3. Validate Trinity alignment: `make trinity-validate`
4. Validate structure: `make validate-all`
5. Create git tag: `git tag v2.X.0`
6. Push tag: `git push origin v2.X.0`
7. Create GitHub release with changelog excerpt
8. Sync with Engine (agentops) and Voice (agentops-showcase)

### Trinity Coordination

This repository (Philosophy Layer) defines the **WHY** behind patterns.

Coordinate releases with:
- **agentops** (Engine - HOW): Implementation and tooling
- **agentops-showcase** (Voice - WHAT): User-facing examples

All three repositories should maintain version alignment for major releases.

### Links

- [Repository](https://github.com/boshu2/12-factor-agentops)
- [Documentation](docs/)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)
- Trinity Siblings:
  - agentops - Engine Layer (production implementation)
  - agentops-showcase - Presentation Layer (public examples and tutorials)

---

[Unreleased]: https://github.com/boshu2/12-factor-agentops/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/boshu2/12-factor-agentops/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/boshu2/12-factor-agentops/compare/v0.9.0...v1.0.0
[0.9.0]: https://github.com/boshu2/12-factor-agentops/releases/tag/v0.9.0
