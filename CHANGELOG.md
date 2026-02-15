# Changelog

All notable changes to 12-Factor AgentOps will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2026-02-15

### Changed - Operational Discipline Pivot

**Complete rewrite of all 12 factors** for the v3 operational discipline framing:

- All 12 factors rewritten with new titles reflecting operational principles
- Adoption model inverted: results-first (start with learnings.md), not manifesto-first
- Knowledge compounding (Factor VIII) elevated as hero differentiator
- Scale factors (X-XII) marked optional/advanced
- Every factor includes "Without Tooling" or practical zero-infrastructure entry points
- Removed old framing ("Shift-Left Validation", "DevOps for Vibe-Coding", "Five Pillars", "Nine Laws")

**New factor names:**

| # | Factor |
|---|--------|
| I | Context Is Everything |
| II | Track Everything in Git |
| III | One Agent, One Job |
| IV | Research Before You Build |
| V | Validate Externally |
| VI | Lock Progress Forward |
| VII | Extract Learnings |
| VIII | Compound Knowledge |
| IX | Measure What Matters |
| X | Isolate Workers |
| XI | Supervise Hierarchically |
| XII | Harvest Failures as Wisdom |

**Documentation:**
- README rewritten for new framing
- PRODUCT.md and GOALS.yaml added
- Old factors archived in `_archived/factors-v1/` with mapping table

---

## [2.0.0] - 2025-12-27

### Added - Production Implementation Patterns

**From Theory to Production:**
- Every factor now includes "Implementation Patterns" sections derived from production systems
- Patterns extracted from Houston (local-first control plane, 2024), Fractal (Kubernetes-native, 2024-2025), and ai-platform (IC deployment)
- +4,200 lines of production-tested implementation guidance

**New Factor Patterns:**

| Factor | Patterns Added |
|--------|----------------|
| **III** | Composable/Blackboard Architecture |
| **VI** | Mission Lifecycle State Machines, Neo4j State Persistence |
| **VII** | SharedInformer Caching, Classification-Aware Routing, Multi-Tier Model Routing |
| **VIII** | BudgetQuota CRD, Three-Phase Pipeline, ToolCall Audit Trail, SSE Human Gates |
| **XI** | Reconciliation Loops, Fail-Closed Defaults, Circuit Breaker, Spiral Detection |
| **XII** | Three-Tier IC Deployment, Air-Gap Playbook, Classification Boundaries, Multi-Tenancy, Helm 86-template |

**New Documentation:**
- `docs/explanation/from-theory-to-production.md` - Bridge document linking theory to practice
- `docs/explanation/pattern-heritage.md` - Houston/Fractal pattern lineage and factor mapping

**Production Validation:**
- All patterns production-tested in DoD environments (IL4/IL5/IL6)
- Edge-to-datacenter deployments validated
- Air-gap deployment playbook verified

### Migration Guide

**No migration required.** This is an additive release.

Existing implementations continue to work. The new Implementation Patterns sections provide optional deep-dive guidance for advanced deployments.

---

## [1.1.0] - 2025-11-29

### Added - Vibe Coding Integration

**Vibe Coding as Complementary Framework:**
- Vibe Coding (Gene Kim & Steve Yegge) integrated as complementary vision layer
- Positioning: Vibe Coding = vision; 12-Factor AgentOps = operational discipline
- NOT a new pillar - Five Pillars remain unchanged

**New Documentation:**
- `docs/explanation/vibe-coding-integration.md` - Complete integration guide
- `docs/explanation/three-developer-loops.md` - Loop framework deep dive (Inner/Middle/Outer)
- `docs/reference/failure-patterns.md` - Failure pattern catalog (15+ patterns)
- `docs/explanation/phoenix-project-lineage.md` - Origin story (2013-2025)

**Updated Documentation:**
- `README.md` - Added Vibe Coding section
- `docs/explanation/faafo-north-star.md` - Gene Kim attribution
- `docs/explanation/standing-on-giants.md` - Vibe Coding as complementary framework

### Unchanged

- **Five Pillars** - Constraint-Based Engineering, DevOps/SRE, Learning Science, Context Engineering, Knowledge OS
- **Nine Laws** - No changes
- **12 Factors** - No changes

### Production Validation

**Maintained:**
- ✅ 2 years production validation
- ✅ 1,175+ commits
- ✅ 95% success rate (up from 35%)
- ✅ 2.7-40x speedup across workflows

**Added:**
- ✅ AI Engineer Summit 2025 industry convergence
- ✅ Gene Kim's research validates patterns

### Migration Guide

**No migration required.** This is an additive release.

Existing 12-Factor AgentOps implementations continue to work unchanged. Vibe Coding integration is complementary documentation.

---

## [1.0.0] - 2024-10-XX

### Added - Initial Release

**Core Framework:**
- 12 Factors for reliable AI operations
- Five Pillars (Constraint-Based Engineering, DevOps/SRE, Learning Science, Context Engineering, Knowledge OS)
- Nine Laws of an Agent
- FAAFO philosophy as north star

**Documentation:**
- Complete factor documentation (12 files)
- Principles and foundations
- Production metrics and case studies
- Getting started guides

**Production Validation:**
- 2 years production validation
- 1,175+ commits documenting journey
- 95% success rate
- 2.7-40x speedup

---

## Version History Summary

| Version | Date | Major Changes |
|---------|------|---------------|
| 3.0.0 | 2026-02-15 | Operational discipline pivot — all factors rewritten, knowledge compounding as hero |
| 2.0.0 | 2025-12-27 | Production Implementation Patterns from Houston/Fractal/ai-platform |
| 1.1.0 | 2025-11-29 | Vibe Coding integration as complementary framework |
| 1.0.0 | 2025-01-27 | Initial public release |
