---
date: 2025-12-27
type: Plan
topic: "12-Factor AgentOps v2.0: Integrate ai-platform Learnings"
research: ".agents/research/2025-12-27-agent-evolution-ai-platform-analysis.md"
tags: [plan, 12-factor, evolution, ai-platform, constraint-engineering]
status: READY_FOR_APPROVAL
---

# Plan: 12-Factor AgentOps v2.0 Evolution

**Created:** 2025-12-27
**Research:** .agents/research/2025-12-27-agent-evolution-ai-platform-analysis.md
**Vibe Level:** L2 (Feature work with meaningful architecture decisions)

---

## Overview

Enhance 12-Factor AgentOps directly with learnings from ai-platform, Houston, and Fractal. Rather than creating a separate "Architecture Edition," we integrate production patterns into the existing factors while keeping the showcase website (12factoragentops.com) as the polished presentation layer.

**Approach:** Option A from research - Extend existing factors with implementation patterns, plus a new "From Theory to Production" document.

---

## Approach

**Why direct enhancement (not separate document):**
1. Single source of truth - no document sprawl
2. Showcase site already handles presentation
3. Patterns belong WITH principles, not separate
4. Easier to maintain long-term

**What we'll add:**
1. **Implementation Patterns section** to each factor (from ai-platform)
2. **New document:** `docs/explanation/from-theory-to-production.md` (bridges philosophy → deployment)
3. **Houston/Fractal heritage** documented in each relevant factor
4. **IC deployment profile** in Factor XII (air-gap, tiered deployment)

---

## Features

### Feature 1: Create "From Theory to Production" Document

**Priority:** P1
**Type:** feature
**Depends On:** None

**What:** Create a new document that bridges the philosophy (12 factors) to production implementation (ai-platform patterns).

**Acceptance Criteria:**
- [ ] Creates `docs/explanation/from-theory-to-production.md`
- [ ] Covers: Evolution story (individual → multi-agent → edge-to-datacenter)
- [ ] Covers: The three layers (Philosophy → Architecture → Implementation)
- [ ] Covers: Constraint-first vs capability-first differentiation
- [ ] Covers: "Kelsey Hightower of Agents" positioning
- [ ] Covers: Houston/Fractal pattern heritage
- [ ] Links to each factor with production guidance

**Files Affected:**
- `docs/explanation/from-theory-to-production.md` - NEW
- `docs/explanation/README.md` - Add entry

**Test Strategy:** Document renders correctly, links work, tells coherent story

---

### Feature 2: Add Implementation Patterns to Factor III (Focused Agents)

**Priority:** P1
**Type:** enhancement
**Depends On:** Feature 1

**What:** Add concrete implementation patterns from ai-platform's 12-Factor Agents doc.

**Patterns to add:**
- Event-Driven Activation (webhook/API/chat/cron taxonomy)
- Webhook-First, Orchestrator-Last
- KAgent CRD example (sanitized)
- Decision tree for agent design

**Acceptance Criteria:**
- [ ] New section: "## Implementation Patterns"
- [ ] Pattern 1: Event-Driven Activation with trigger taxonomy
- [ ] Pattern 2: Webhook-First architecture diagram
- [ ] Pattern 3: Agent decision tree (from ai-platform)
- [ ] Anti-patterns section with examples

**Files Affected:**
- `factors/03-focused-agents.md` - Add section

**Test Strategy:** Patterns are concrete and actionable, no proprietary details exposed

---

### Feature 3: Add Implementation Patterns to Factor VI (Resume Work)

**Priority:** P1
**Type:** enhancement
**Depends On:** Feature 1

**What:** Add explicit memory architecture patterns from ai-platform.

**Patterns to add:**
- Explicit Memory Architecture (RAG/Graph/Historical split)
- Stateless Execution + External Memory
- Mission lifecycle state machines (from Houston)
- Neo4j state persistence pattern

**Acceptance Criteria:**
- [ ] New section: "## Implementation Patterns"
- [ ] Pattern 1: Three-layer memory architecture diagram
- [ ] Pattern 2: Stateless execution model
- [ ] Pattern 3: State machine lifecycle (from Houston)
- [ ] Code example showing external memory pattern

**Files Affected:**
- `factors/06-resume-work.md` - Add section

**Test Strategy:** Memory patterns are distinct and clearly explained

---

### Feature 4: Add Implementation Patterns to Factor VII (Smart Routing)

**Priority:** P1
**Type:** enhancement
**Depends On:** Feature 1

**What:** Add composability patterns from ai-platform.

**Patterns to add:**
- Composable, Not Chainable
- Infrastructure-mediated coordination (Blackboard pattern from Fractal)
- Shard/ShardRun model (intent ≠ execution)
- N+1 worker pattern (from Houston)

**Acceptance Criteria:**
- [ ] New section: "## Implementation Patterns"
- [ ] Pattern 1: Composable vs chainable diagram
- [ ] Pattern 2: Blackboard coordination pattern
- [ ] Pattern 3: Intent vs execution separation
- [ ] Anti-pattern: Hard-coded chains

**Files Affected:**
- `factors/07-smart-routing.md` - Add section

**Test Strategy:** Coordination patterns are clear, anti-patterns are explicit

---

### Feature 5: Add Implementation Patterns to Factor VIII (Human Validation)

**Priority:** P1
**Type:** enhancement
**Depends On:** Feature 1

**What:** Add hard limit enforcement patterns from Fractal.

**Patterns to add:**
- BudgetQuota enforcement (fail-closed)
- 3-phase pipeline (PLAN → COMMIT → EXECUTE)
- Human gates between phases
- Audit trail requirements

**Acceptance Criteria:**
- [ ] New section: "## Implementation Patterns"
- [ ] Pattern 1: BudgetQuota CRD example (sanitized)
- [ ] Pattern 2: 3-phase pipeline with human gates
- [ ] Pattern 3: Audit trail requirements
- [ ] Failure modes and escalation paths

**Files Affected:**
- `factors/08-human-validation.md` - Add section

**Test Strategy:** Budget patterns are enforceable, not advisory

---

### Feature 6: Add Implementation Patterns to Factor XI (Fail-Safe Checks)

**Priority:** P1
**Type:** enhancement
**Depends On:** Feature 5

**What:** Add reconciliation and self-healing patterns from Fractal.

**Patterns to add:**
- Reconciliation loops (level-triggered beats edge-triggered)
- Fail-closed defaults
- Self-healing architecture
- ToolCall audit trail (every action is a CRD)

**Acceptance Criteria:**
- [ ] New section: "## Implementation Patterns"
- [ ] Pattern 1: Reconciliation loop diagram
- [ ] Pattern 2: Fail-closed vs fail-open comparison
- [ ] Pattern 3: Self-healing with example
- [ ] Pattern 4: ToolCall audit trail pattern

**Files Affected:**
- `factors/11-fail-safe-checks.md` - Add section

**Test Strategy:** Self-healing patterns are concrete, not aspirational

---

### Feature 7: Add IC Deployment Profile to Factor XII

**Priority:** P1
**Type:** enhancement
**Depends On:** Feature 1

**What:** Add 3-tier IC deployment model and air-gap patterns.

**Patterns to add:**
- 3-Tier deployment model (Edge/Datacenter/Frontier)
- Air-gapped deployment playbook
- Classification boundary enforcement
- Multi-tier model routing

**Acceptance Criteria:**
- [ ] New section: "## Deployment Profiles"
- [ ] Profile 1: Tier 1 - Disconnected Edge (specs, models, constraints)
- [ ] Profile 2: Tier 2 - Internal Datacenter (specs, models, constraints)
- [ ] Profile 3: Tier 3 - Connected (specs, models, constraints)
- [ ] Air-gap deployment checklist
- [ ] Classification boundary patterns

**Files Affected:**
- `factors/12-package-patterns.md` - Add section

**Test Strategy:** Profiles are specific enough to implement, not proprietary

---

### Feature 8: Add Houston/Fractal Heritage Section to Principles

**Priority:** P2
**Type:** enhancement
**Depends On:** Features 2-7

**What:** Document the pattern heritage from Houston and Fractal control planes.

**Acceptance Criteria:**
- [ ] New document: `docs/explanation/pattern-heritage.md`
- [ ] Section: Houston patterns (local-first, 2024)
- [ ] Section: Fractal patterns (K8s-native, 2024-2025)
- [ ] Table mapping patterns to factors
- [ ] Links from relevant factor Implementation Patterns

**Files Affected:**
- `docs/explanation/pattern-heritage.md` - NEW
- `docs/explanation/README.md` - Add entry

**Test Strategy:** Heritage is clear without exposing proprietary implementation

---

### Feature 9: Update Showcase Site with New Content

**Priority:** P2
**Type:** task
**Depends On:** Features 1-8

**What:** Sync enhanced factor content to agentops-showcase for display.

**Acceptance Criteria:**
- [ ] Copy updated factors to `agentops-showcase/docs/factors/`
- [ ] Copy new explanation docs to `agentops-showcase/docs/`
- [ ] Update constants if new sections affect metadata
- [ ] Verify build succeeds
- [ ] Verify rendering of new sections (Callouts, diagrams)

**Files Affected:**
- `agentops-showcase/docs/factors/*.md` - Sync from 12-factor-agentops
- `agentops-showcase/docs/explanation/*.md` - Sync new docs
- `agentops-showcase/src/lib/constants.ts` - Update if needed

**Test Strategy:** `npm run build` succeeds, all pages render, diagrams display

---

### Feature 10: Create v2.0 Release

**Priority:** P3
**Type:** task
**Depends On:** Feature 9

**What:** Tag and release 12-Factor AgentOps v2.0.

**Acceptance Criteria:**
- [ ] Update version in `factors/README.md` version history
- [ ] Update CHANGELOG.md with v2.0 changes
- [ ] Create git tag `v2.0.0`
- [ ] Update README.md with v2.0 highlights
- [ ] Announce changes

**Files Affected:**
- `factors/README.md` - Version history
- `CHANGELOG.md` - Release notes
- `README.md` - Highlights

**Test Strategy:** Tag created, release notes accurate

---

## Implementation Order

| Step | Feature | Depends On | Validation |
|------|---------|------------|------------|
| 1 | Feature 1: From Theory to Production | - | Document links, renders |
| 2 | Feature 2: Factor III patterns | F1 | Patterns actionable |
| 3 | Feature 3: Factor VI patterns | F1 | Memory layers clear |
| 4 | Feature 4: Factor VII patterns | F1 | Coordination patterns clear |
| 5 | Feature 5: Factor VIII patterns | F1 | Budget enforcement concrete |
| 6 | Feature 6: Factor XI patterns | F5 | Self-healing concrete |
| 7 | Feature 7: Factor XII IC profiles | F1 | Profiles implementable |
| 8 | Feature 8: Pattern heritage | F2-7 | Heritage documented |
| 9 | Feature 9: Showcase sync | F1-8 | Site builds and renders |
| 10 | Feature 10: v2.0 release | F9 | Tag created, notes accurate |

---

## Beads Issues to Create

After approval, these issues will be created:

| ID | Title | Type | Priority | Depends On |
|----|-------|------|----------|------------|
| TBD | Epic: 12-Factor AgentOps v2.0 | epic | P1 | - |
| TBD | Create From Theory to Production doc | feature | P1 | Epic |
| TBD | Add patterns to Factor III (Focused Agents) | enhancement | P1 | F1 |
| TBD | Add patterns to Factor VI (Resume Work) | enhancement | P1 | F1 |
| TBD | Add patterns to Factor VII (Smart Routing) | enhancement | P1 | F1 |
| TBD | Add patterns to Factor VIII (Human Validation) | enhancement | P1 | F1 |
| TBD | Add patterns to Factor XI (Fail-Safe Checks) | enhancement | P1 | F5 |
| TBD | Add IC deployment profiles to Factor XII | enhancement | P1 | F1 |
| TBD | Create pattern heritage document | enhancement | P2 | F2-7 |
| TBD | Sync content to showcase site | task | P2 | F1-8 |
| TBD | Create v2.0 release | task | P3 | F9 |

---

## Rollback Procedure

All changes are in documentation (markdown). Rollback via:
```bash
git revert <commit-range>
# Or restore from previous tag
git checkout v1.1.0 -- factors/
```

---

## Constraints & Risks

| Constraint | Impact | Mitigation |
|------------|--------|------------|
| ai-platform is closed source | Can't copy code directly | Abstract patterns, sanitize examples |
| IC specifics are sensitive | Can't expose tier details | Generalize profiles, remove specifics |
| Showcase transforms Vue→MDX | New sections might break | Test build before pushing |
| Factor files are long | Adding sections increases size | Keep patterns concise, link to heritage doc |

---

## Success Criteria

**v2.0 is successful when:**
1. Each enhanced factor has actionable Implementation Patterns
2. "From Theory to Production" tells the evolution story
3. IC deployment profiles are specific enough to implement
4. Pattern heritage is documented without exposing proprietary code
5. Showcase site displays all new content correctly
6. Framework feels like it was written by someone who deployed agents at scale

---

## Next Steps

1. **Approve this plan** to create beads issues
2. `bd ready` to see unblocked issues
3. `/implement` to execute Feature 1 first

---

**Output:** .agents/plans/2025-12-27-12-factor-v2-evolution-plan.md
