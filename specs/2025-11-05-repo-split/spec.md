# Specification: Repository Split (12-factor-agentops ↔ agentops)

**Spec ID:** 2025-11-05-repo-split
**Status:** Draft
**Created:** 2025-11-05
**Author:** spec-writer
**Requirements:** See `planning/requirements.md`

---

## Table of Contents

1. [Overview](#overview)
2. [Goals & Non-Goals](#goals--non-goals)
3. [Architecture](#architecture)
4. [Detailed Design](#detailed-design)
5. [Implementation Plan](#implementation-plan)
6. [Testing & Validation](#testing--validation)
7. [Rollback Strategy](#rollback-strategy)
8. [Open Questions](#open-questions)
9. [Appendices](#appendices)

---

## Overview

### Problem Statement

The current `12-factor-agentops` repository serves two distinct audiences with conflicting needs:

**Researchers/Framework Users:**
- Want deep philosophical understanding
- Need pattern documentation and theory
- Seek academic validation and case studies
- Don't need operational tooling

**Practitioners/Implementation Users:**
- Want working tools immediately
- Need how-to guides and quick-starts
- Seek operational enforcement
- Don't need extensive theory

**Current State:** Single repo tries to serve both, resulting in:
- Unclear value proposition
- Mixed content (theory + implementation)
- Difficult navigation
- Confused contribution targets

### Proposed Solution

Split into two complementary repositories following the 12-factor-apps precedent:

```
12-factor-agentops/          agentops/
(Philosophy)                 (Implementation)
       ↓                            ↓
   Theory                       Practice
   Patterns                     Tools
   Research                     How-To
   Why/What              ←→     How
```

### Success Criteria

1. **Clear boundaries:** Zero overlap in content purpose
2. **Self-contained:** Either repo works standalone
3. **Bidirectional:** Cross-references connect related content
4. **User clarity:** <10% confusion about which repo to use
5. **Migration success:** 100% agents migrated, zero broken links

---

## Goals & Non-Goals

### Goals ✅

**Primary:**
- Separate philosophy (12-factor-agentops) from implementation (agentops)
- Maintain Five Laws consistency across both repos
- Enable independent entry points (research-first OR practice-first)
- Provide clear contribution paths

**Secondary:**
- Establish bidirectional cross-references
- Document patterns theoretically (12-factor-agentops)
- Implement patterns practically (agentops)
- Create migration path for existing users

### Non-Goals ❌

**Explicitly out of scope:**
- ❌ Rebranding or renaming repositories
- ❌ New feature development (focus is reorganization)
- ❌ Code refactoring within agents
- ❌ Backwards compatibility (breaking change accepted)
- ❌ Multi-language implementations
- ❌ Hosting/deployment changes

**Deferred to future:**
- ⏸️ Agent orchestration framework
- ⏸️ Performance optimization
- ⏸️ Advanced pattern library expansion
- ⏸️ Additional case studies

---

## Architecture

### Repository Relationship

```
┌─────────────────────────────────┐
│   12-factor-agentops            │
│   (Philosophy/Framework)        │
│                                 │
│   • Four Pillars               │
│   • Five Laws (defined)        │
│   • Patterns (theory)          │
│   • Case studies               │
│   • Research                   │
│                                 │
│   References: agentops →       │
│   "See reference implementation"│
└───────────────┬─────────────────┘
                │
         Bidirectional
         Cross-Reference
                │
┌───────────────▼─────────────────┐
│   agentops                      │
│   (Implementation/Tools)        │
│                                 │
│   • Working agents             │
│   • Slash commands             │
│   • Five Laws (enforced)       │
│   • How-to guides              │
│   • Operational tools          │
│                                 │
│   References: 12-factor-agentops│
│   "Built on philosophical       │
│    foundation"                  │
└─────────────────────────────────┘
```

### Content Ownership Matrix

| Content Type | 12-factor-agentops | agentops |
|--------------|-------------------|----------|
| **Four Pillars** | ✅ Theory & philosophy | ❌ Reference via link |
| **Five Laws** | ✅ Philosophical definition | ✅ Operational enforcement |
| **Patterns** | ✅ Conceptual documentation | ✅ Working implementations |
| **Agents** | ❌ Not applicable | ✅ All working agents |
| **Slash Commands** | ❌ Not applicable | ✅ All commands |
| **How-To Guides** | ❌ Redirect to agentops | ✅ Task-specific guides |
| **Tutorials** | ⚠️ Framework intro only | ✅ Tool usage tutorials |
| **Case Studies** | ✅ Academic validation | ⚠️ Link to framework |
| **CONSTITUTION** | ❌ Not applicable | ✅ Operational enforcement |

**Legend:**
- ✅ Primary owner
- ⚠️ Minimal/references other repo
- ❌ Not present

### Information Flow

**Research → Implementation:**
```
User studies framework → Understands patterns → Uses agentops tools
```

**Implementation → Research:**
```
User uses tools → Needs deeper understanding → Reads framework
```

**Pattern → Practice:**
```
12-factor-agentops documents pattern → agentops implements it
```

**Practice → Pattern:**
```
agentops discovers working pattern → 12-factor-agentops generalizes it
```

---

## Detailed Design

### 1. Repository Structures

#### 1.1 12-factor-agentops Structure

```
12-factor-agentops/
├── README.md                      # Framework overview, links to agentops
├── CLAUDE.md                      # AgentOps principles for contributors
├── CONTRIBUTING.md                # How to contribute patterns/research
├── LICENSE                        # Apache 2.0 (code) + CC BY-SA 4.0 (docs)
│
├── foundations/                   # Core concepts (EXPLANATION)
│   ├── README.md                  # Foundations overview
│   ├── four-pillars.md            # DevOps+SRE, Learning Science, etc.
│   ├── five-laws.md               # Philosophical rationale
│   ├── context-engineering.md     # 40% rule, JIT loading theory
│   └── knowledge-os.md            # Git as institutional memory
│
├── patterns/                      # Pattern library (REFERENCE)
│   ├── README.md                  # Pattern catalog
│   ├── phase-based-workflow.md    # Research→Plan→Implement
│   ├── multi-agent-orchestration.md  # Parallel execution theory
│   ├── intelligent-routing.md     # Workflow selection patterns
│   └── context-bundles.md         # Session-spanning work
│
├── case-studies/                  # Validation examples (EXPLANATION)
│   ├── README.md                  # Case study index
│   ├── 40x-speedup.md             # Git metrics validation
│   ├── gitops-automation.md       # 52 agents, 95% success rate
│   └── knowledge-os-emergence.md  # Session 46 self-awareness
│
├── research/                      # Academic depth (EXPLANATION)
│   ├── README.md                  # Research index
│   ├── context-capacity.md        # 40% rule derivation
│   ├── learning-transfer.md       # Pattern recognition science
│   └── adhd-optimization.md       # Neurotype-optimized workflows
│
└── product/                       # Product planning (this repo)
    ├── mission.md
    ├── roadmap.md
    └── tech-stack.md
```

**Diátaxis Balance:**
- 60% Explanation (why things work)
- 30% Reference (pattern catalog)
- 10% Tutorial (framework introduction)
- 0% How-To (redirect to agentops)

**Key Characteristics:**
- Zero executable code
- Theory-focused
- Academic rigor
- Generalizable patterns
- Deep philosophical grounding

---

#### 1.2 agentops Structure

```
agentops/
├── README.md                      # Quick-start guide, links to 12-factor
├── CONSTITUTION.md                # Operational enforcement of Five Laws
├── CONTRIBUTING.md                # How to contribute agents/tools
├── LICENSE                        # Apache 2.0 (code) + CC BY-SA 4.0 (docs)
│
├── profiles/                      # Agent profiles
│   ├── default/                   # Default profile (reference impl)
│   │   ├── agents/                # Working agents
│   │   │   ├── product-planner/
│   │   │   ├── spec-shaper/
│   │   │   ├── spec-writer/
│   │   │   ├── task-creator/
│   │   │   ├── implementer/
│   │   │   └── verifier/
│   │   ├── commands/              # Slash commands
│   │   │   ├── plan-product/
│   │   │   ├── shape-spec/
│   │   │   ├── write-spec/
│   │   │   ├── create-tasks/
│   │   │   ├── implement-tasks/
│   │   │   └── orchestrate-tasks/
│   │   └── skills/                # Reusable capabilities (future)
│   │
│   └── devops/                    # DevOps-specific profile (template)
│       └── ...
│
├── docs/                          # Documentation (Diátaxis)
│   ├── tutorials/                 # Learning paths (TUTORIAL)
│   │   ├── 01-first-workflow.md
│   │   ├── 02-multi-agent.md
│   │   └── 03-custom-agent.md
│   ├── how-to/                    # Task-specific guides (HOW-TO)
│   │   ├── run-plan-product.md
│   │   ├── create-custom-agent.md
│   │   ├── debug-workflow.md
│   │   └── contribute-pattern.md
│   ├── reference/                 # Command/agent reference (REFERENCE)
│   │   ├── agents/
│   │   ├── commands/
│   │   └── constitution.md
│   └── explanation/               # Why (minimal, links to 12-factor)
│       └── philosophy.md          # Brief overview, links to framework
│
└── examples/                      # Real usage examples
    ├── product-planning/
    ├── spec-shaping/
    └── task-implementation/
```

**Diátaxis Balance:**
- 40% How-To (task-focused guides)
- 30% Tutorials (learning paths)
- 20% Reference (command docs)
- 10% Explanation (brief, links to 12-factor)

**Key Characteristics:**
- All working agents
- Production-ready tools
- Operational focus
- Immediately usable
- Quick-start optimized

---

### 2. Five Laws Implementation

#### 2.1 In 12-factor-agentops (Definition)

**File:** `foundations/five-laws.md`

**Structure:**
```markdown
# The Five Laws of AgentOps

## Introduction

[Why these laws exist, philosophical foundation]

---

## Law 1: ALWAYS Extract Learnings

### Philosophical Foundation

Knowledge work without knowledge capture is waste. Every problem
solved, every pattern discovered, every failure encountered
contains transferable insights. Without extraction, institutional
memory cannot form, and every problem remains novel.

### Theoretical Grounding

**Learning Science:** Pattern recognition requires documented patterns.
Meta-cognition improves when learnings are externalized.

**DevOps Parallel:** Post-mortems, retrospectives, knowledge bases.

### Historical Context

This law emerged from 200+ agent sessions where undocumented
learnings led to:
- Repeated mistakes (same error patterns)
- Lost optimizations (speed improvements forgotten)
- Diminished compound returns (patterns not reused)

### Why This Matters

[Impact on operations, evidence from case studies]

### See It In Practice

→ [agentops/CONSTITUTION.md](link) - Operational enforcement
→ [agentops/docs/how-to/extract-learnings.md](link) - How-to guide

---

[Laws 2-5 follow same structure]
```

**Tone:** Academic, persuasive, evidence-based

**Cross-Reference Pattern:**
Every law links to agentops enforcement with:
```markdown
→ **Operational Enforcement:** [agentops/CONSTITUTION.md#law-N](link)
```

---

#### 2.2 In agentops (Enforcement)

**File:** `CONSTITUTION.md`

**Structure:**
```markdown
# AgentOps Constitution

**Status:** Operational Mandate
**Authority:** Five Laws (defined in [12-factor-agentops](link))

This document enforces the Five Laws operationally for all agents
running within the agentops framework.

---

## Law 1: ALWAYS Extract Learnings

### Operational Mandate

Every agent session MUST produce extractable learnings before
completion. Sessions without documented learnings are considered
incomplete.

### Enforcement Mechanisms

1. **Pre-commit hook:** Validates learning documentation exists
2. **Session template:** Includes learning capture section
3. **CI validation:** Checks learning format compliance
4. **Completion criteria:** Learning extraction required before done

### Compliance Checklist

Before completing any agent session, confirm:
- [ ] Patterns identified and documented
- [ ] Decision rationale captured
- [ ] Failure analysis completed (if applicable)
- [ ] Reusable insights extracted

### Practical Examples

**Good Learning:**
```markdown
## Learning: Context Collapse Prevention

**Pattern:** Staying under 40% context capacity prevents collapse
**Evidence:** 0 collapses in 100 sessions under 40%, 8/10 over 60%
**Application:** Load context JIT, not all upfront
```

**Insufficient Learning:**
```markdown
## Learning

We learned some stuff.
```

### Failure Remediation

**If learning extraction incomplete:**
1. Review session transcript
2. Identify decisions made
3. Extract patterns used
4. Document rationale
5. Resubmit with complete learning

### Why This Law Exists

→ **Philosophical Foundation:** [12-factor-agentops/foundations/five-laws.md#law-1](link)

---

[Laws 2-5 follow same structure]
```

**Tone:** Prescriptive, operational, checklist-driven

**Cross-Reference Pattern:**
Every law links to framework philosophy with:
```markdown
→ **Philosophical Foundation:** [12-factor-agentops/foundations/five-laws.md#law-N](link)
```

---

### 3. Cross-Reference System

#### 3.1 Bidirectional Linking Strategy

**From 12-factor-agentops → agentops:**

**Use Case:** Pattern documentation
```markdown
## Phase-Based Workflow Pattern

**Theory:** Separating Research→Plan→Implement phases prevents
premature optimization and ensures thorough understanding before
coding.

### Pattern Description

[Theoretical explanation]

### See It In Action

- **Implementation:** [agentops plan-product workflow](https://github.com/boshu2/agentops/tree/main/profiles/default/commands/plan-product)
- **How-To Guide:** [How to use plan-product](https://github.com/boshu2/agentops/blob/main/docs/how-to/run-plan-product.md)
- **Tutorial:** [Product planning tutorial](https://github.com/boshu2/agentops/blob/main/docs/tutorials/01-first-workflow.md)
```

**From agentops → 12-factor-agentops:**

**Use Case:** Agent documentation
```markdown
## plan-product Agent

**Purpose:** Multi-phase product planning workflow

**Usage:**
```bash
/plan-product
```

[Practical usage instructions]

### Pattern Background

This agent implements the **Phase-Based Workflow** pattern:
- **Theory:** [12-factor-agentops/patterns/phase-based-workflow.md](link)
- **Philosophy:** [12-factor-agentops/foundations/context-engineering.md](link)

### Why This Works

→ [12-factor-agentops case study](link) - 40x speedup validation
```

---

#### 3.2 Cross-Reference Checklist

**Every 12-factor-agentops pattern must include:**
- [ ] "See It In Action" section
- [ ] Link to agentops implementation
- [ ] Link to how-to guide (if available)

**Every agentops agent/command must include:**
- [ ] "Pattern Background" section
- [ ] Link to framework pattern
- [ ] Brief rationale (or link to philosophy)

**README cross-references:**
- [ ] 12-factor-agentops README → "Reference Implementation: agentops"
- [ ] agentops README → "Built on: 12-factor-agentops framework"

---

### 4. User Experience Design

#### 4.1 Researcher Journey

**Entry Point:** 12-factor-agentops README

**Journey Map:**
```
1. Land on 12-factor-agentops README
   ↓
2. Read "What is AgentOps?" (philosophy)
   ↓
3. Explore Four Pillars (foundations/)
   ↓
4. Study Five Laws (philosophical rationale)
   ↓
5. Review patterns (patterns/)
   ↓
6. Read case studies (validation)
   ↓
7. DECISION POINT:
   - Want to implement? → Follow "Reference Implementation" link to agentops
   - Continue research? → Dive into research/, contribute patterns
```

**Key Navigation Elements:**

**12-factor-agentops README:**
```markdown
## Reference Implementation

Want to use AgentOps in practice? See [agentops](https://github.com/boshu2/agentops)
for production-ready tools, working agents, and how-to guides.

**Start here if you want to:**
- Use AgentOps tools immediately
- Follow practical tutorials
- Implement workflows in your operations
```

---

#### 4.2 Practitioner Journey

**Entry Point:** agentops README

**Journey Map:**
```
1. Land on agentops README
   ↓
2. Read quick-start (5 min to first workflow)
   ↓
3. Run tutorial (tutorials/01-first-workflow.md)
   ↓
4. Execute first agent workflow
   ↓
5. Explore other agents/commands
   ↓
6. DECISION POINT:
   - Need deeper understanding? → Follow "Framework" link to 12-factor-agentops
   - Keep building? → Continue with how-to guides, contribute agents
```

**Key Navigation Elements:**

**agentops README:**
```markdown
## Philosophical Foundation

Want to understand why AgentOps works? See [12-factor-agentops](https://github.com/boshu2/12-factor-agentops)
for the framework, patterns, and research.

**Start there if you want to:**
- Understand AgentOps deeply
- Contribute new patterns
- Validate framework with research
```

---

#### 4.3 Navigation Consistency

**Both READMEs include:**

1. **Clear purpose statement** (first paragraph)
2. **Companion repo link** (prominent, early)
3. **When to use each** (decision guidance)
4. **Contributing guide** (where to contribute what)

**Terminology consistency:**
- Same pattern names (phase-based, multi-agent, etc.)
- Same law names (Law 1, Law 2, etc.)
- Same pillar names (DevOps+SRE, Learning Science, etc.)

---

### 5. Content Migration Strategy

#### 5.1 Migration Phases

**Phase 1: Repository Creation (Week 1)**

```
Day 1-2: Create agentops repo
├── Initialize with README
├── Add LICENSE (Apache 2.0 + CC BY-SA 4.0)
├── Create profiles/default/ skeleton
└── Set up CI/CD basics

Day 3-4: Constitutional framework
├── Create CONSTITUTION.md skeleton
├── Document Five Laws operationally
├── Set up enforcement hooks (git)
└── Validate build pipeline

Day 5-7: Cross-references & validation
├── Add links in both READMEs
├── Validate repo builds
└── Test basic structure
```

**Deliverables:**
- [ ] agentops repo exists and builds
- [ ] Basic structure in place
- [ ] Cross-references bidirectional
- [ ] CI/CD functional

---

**Phase 2: Content Migration (Weeks 2-3)**

```
Week 2: Agent/Command Migration
├── Move all agents to agentops/profiles/default/agents/
├── Move all commands to agentops/profiles/default/commands/
├── Test each agent works post-migration
├── Update internal references
└── Create how-to guides for each workflow

Week 3: Framework Refactoring
├── Create 12-factor-agentops/foundations/
├── Document Four Pillars in foundations/
├── Document Five Laws philosophically
├── Create patterns/ directory
├── Document existing patterns (phase-based, etc.)
├── Remove implementation content from 12-factor-agentops
└── Add "See agentops" cross-references
```

**Deliverables:**
- [ ] All agents migrated & functional
- [ ] All commands migrated & functional
- [ ] CONSTITUTION.md complete
- [ ] How-to guides created
- [ ] 12-factor-agentops refactored (theory-only)
- [ ] Patterns documented
- [ ] Cross-references added

---

**Phase 3: Polish & Announcement (Week 4)**

```
Day 1-3: User Testing
├── Recruit 2 researcher testers
├── Recruit 2 practitioner testers
├── Observe onboarding (both repos)
├── Collect feedback
└── Iterate based on findings

Day 4-5: Documentation Polish
├── Finalize CONTRIBUTING.md (both repos)
├── Polish all cross-references
├── Validate no broken links
├── SEO optimization (topics, descriptions)
└── Create migration guide for existing users

Day 6-7: Announcement Prep
├── Draft announcement
├── Prepare social media posts
├── Update workspace documentation
└── Schedule launch
```

**Deliverables:**
- [ ] User testing complete (4+ users)
- [ ] Documentation polished
- [ ] Zero broken links
- [ ] CONTRIBUTING.md complete (both)
- [ ] Announcement ready
- [ ] Migration guide published

---

#### 5.2 Content Classification Rules

**Decision Tree for Content:**

```
Is it executable code (agents, commands)?
├─ YES → agentops
└─ NO → Continue...
    │
    Is it philosophical/theoretical?
    ├─ YES → 12-factor-agentops
    └─ NO → Continue...
        │
        Is it a how-to guide?
        ├─ YES → agentops
        └─ NO → Continue...
            │
            Is it a pattern?
            ├─ Conceptual/theoretical? → 12-factor-agentops
            └─ Implementation/practical? → agentops
```

**Classification Examples:**

| Content | Classification | Destination | Rationale |
|---------|---------------|-------------|-----------|
| Four Pillars theory | Philosophy | 12-factor-agentops | Framework foundation |
| Five Laws definition | Philosophy | 12-factor-agentops | Conceptual grounding |
| Five Laws enforcement | Operational | agentops | Practical enforcement |
| Phase-based pattern theory | Philosophy | 12-factor-agentops | Conceptual pattern |
| plan-product agent | Implementation | agentops | Working tool |
| How to run plan-product | How-To | agentops | Task guide |
| Case study: 40x speedup | Philosophy | 12-factor-agentops | Framework validation |
| Tutorial: First workflow | Tutorial | agentops | Practical learning |

---

### 6. Documentation Standards

#### 6.1 README Requirements

**Both repos must have:**

1. **Title & Tagline**
   ```markdown
   # 12-factor-agentops
   > Operational framework for AI agents
   ```

2. **Clear Purpose Statement** (first paragraph)
   ```markdown
   12-factor-agentops defines the philosophical foundation, patterns,
   and principles for operating AI agents with DevOps/SRE rigor.
   ```

3. **Quick Links Section**
   ```markdown
   ## Quick Links
   - [Reference Implementation](https://github.com/boshu2/agentops)
   - [Documentation](./foundations/)
   - [Contributing](./CONTRIBUTING.md)
   ```

4. **When to Use This Repo**
   ```markdown
   ## Start Here If You Want To:
   - [X] Understand AgentOps framework deeply
   - [X] Contribute patterns and research
   - [X] Validate framework with case studies
   ```

5. **Companion Repo Link** (prominent)

---

#### 6.2 Diátaxis Compliance

**12-factor-agentops (Explanation-heavy):**

```
docs/
├── explanation/          # 60% of content
│   ├── foundations/
│   ├── research/
│   └── case-studies/
├── reference/            # 30% of content
│   └── patterns/
├── tutorials/            # 10% of content
│   └── framework-intro/
└── how-to/               # 0% (redirect to agentops)
```

**agentops (How-To-heavy):**

```
docs/
├── how-to/               # 40% of content
│   ├── run-workflows/
│   ├── create-agents/
│   └── debug-issues/
├── tutorials/            # 30% of content
│   ├── first-workflow/
│   ├── multi-agent/
│   └── custom-agent/
├── reference/            # 20% of content
│   ├── agents/
│   └── commands/
└── explanation/          # 10% of content (links to 12-factor)
    └── philosophy.md
```

---

## Implementation Plan

### Tasks by Phase

#### Phase 1 Tasks (Week 1)

1. **Create agentops Repository**
   - [ ] Create GitHub repo: `agentops`
   - [ ] Initialize with README.md
   - [ ] Add LICENSE file
   - [ ] Create `.github/` with issue templates
   - [ ] Set up branch protection

2. **Basic Structure**
   - [ ] Create `profiles/default/` directory
   - [ ] Create `profiles/default/agents/` (empty)
   - [ ] Create `profiles/default/commands/` (empty)
   - [ ] Create `docs/` with Diátaxis structure
   - [ ] Create `examples/` directory

3. **Constitutional Framework**
   - [ ] Write CONSTITUTION.md skeleton
   - [ ] Document Law 1 operationally (template)
   - [ ] Document Laws 2-5 operationally
   - [ ] Add cross-references to 12-factor-agentops
   - [ ] Set up pre-commit hook (validate learnings)

4. **CI/CD Setup**
   - [ ] Create `.github/workflows/validate.yml`
   - [ ] Add markdown linting
   - [ ] Add link checking
   - [ ] Test build pipeline

5. **Cross-References**
   - [ ] Update 12-factor-agentops README (link to agentops)
   - [ ] Update agentops README (link to 12-factor-agentops)
   - [ ] Add "See Reference Implementation" sections
   - [ ] Add "Built on Framework" sections

**Phase 1 Acceptance:**
- [ ] agentops repo builds successfully
- [ ] CONSTITUTION.md complete
- [ ] Cross-references bidirectional
- [ ] CI/CD passes

---

#### Phase 2 Tasks (Weeks 2-3)

**Week 2: Migration**

6. **Agent Migration**
   - [ ] Identify all agents in current structure
   - [ ] Move to `agentops/profiles/default/agents/`
   - [ ] Test each agent post-migration
   - [ ] Update internal file references
   - [ ] Document each agent in reference/

7. **Command Migration**
   - [ ] Identify all slash commands
   - [ ] Move to `agentops/profiles/default/commands/`
   - [ ] Test each command post-migration
   - [ ] Update command cross-references
   - [ ] Document each command in reference/

8. **How-To Guide Creation**
   - [ ] Write `how-to/run-plan-product.md`
   - [ ] Write `how-to/run-shape-spec.md`
   - [ ] Write `how-to/run-write-spec.md`
   - [ ] Write `how-to/create-custom-agent.md`
   - [ ] Write `how-to/debug-workflow.md`

**Week 3: Framework Refactoring**

9. **Create Foundations**
   - [ ] Create `12-factor-agentops/foundations/` directory
   - [ ] Write `foundations/four-pillars.md`
   - [ ] Write `foundations/five-laws.md` (philosophical)
   - [ ] Write `foundations/context-engineering.md`
   - [ ] Write `foundations/knowledge-os.md`

10. **Document Patterns**
    - [ ] Create `12-factor-agentops/patterns/` directory
    - [ ] Write `patterns/phase-based-workflow.md`
    - [ ] Write `patterns/multi-agent-orchestration.md`
    - [ ] Write `patterns/intelligent-routing.md`
    - [ ] Write `patterns/context-bundles.md`
    - [ ] Add "See It In Action" links to agentops

11. **Refactor 12-factor-agentops**
    - [ ] Remove implementation content
    - [ ] Update README (framework focus)
    - [ ] Move case studies to case-studies/
    - [ ] Update CLAUDE.md (contributor guidance)
    - [ ] Remove any executable code

**Phase 2 Acceptance:**
- [ ] All agents migrated & functional
- [ ] All commands migrated & functional
- [ ] How-to guides complete
- [ ] Foundations documented
- [ ] Patterns documented
- [ ] 12-factor-agentops is theory-only

---

#### Phase 3 Tasks (Week 4)

12. **User Testing**
    - [ ] Recruit 2 researcher participants
    - [ ] Recruit 2 practitioner participants
    - [ ] Observe researcher onboarding (12-factor-agentops)
    - [ ] Observe practitioner onboarding (agentops)
    - [ ] Collect structured feedback
    - [ ] Identify confusion points
    - [ ] Iterate based on findings

13. **Documentation Polish**
    - [ ] Proofread all documentation
    - [ ] Validate tone consistency
    - [ ] Check terminology alignment
    - [ ] Fix any broken links
    - [ ] Optimize for SEO (descriptions, topics)

14. **Contributing Guides**
    - [ ] Write `12-factor-agentops/CONTRIBUTING.md` (patterns)
    - [ ] Write `agentops/CONTRIBUTING.md` (tools)
    - [ ] Create issue templates (both repos)
    - [ ] Document contribution routing

15. **Migration Guide**
    - [ ] Write migration guide for existing users
    - [ ] Document breaking changes
    - [ ] Provide repo mapping (old → new)
    - [ ] Create FAQ section

16. **Announcement Preparation**
    - [ ] Draft announcement post
    - [ ] Prepare social media content
    - [ ] Update workspace documentation
    - [ ] Schedule launch

**Phase 3 Acceptance:**
- [ ] 4+ users tested successfully
- [ ] Documentation polished
- [ ] CONTRIBUTING.md complete (both)
- [ ] Migration guide published
- [ ] Announcement ready

---

## Testing & Validation

### 1. Automated Validation

**CI/CD Checks (both repos):**

```yaml
# .github/workflows/validate.yml

name: Validate
on: [push, pull_request]

jobs:
  markdown-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Lint Markdown
        uses: avto-dev/markdown-lint@v1
        with:
          config: '.markdownlint.json'
          args: '**/*.md'

  link-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Check Links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          config-file: '.markdown-link-check.json'

  structure-validation:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Validate Structure
        run: |
          # Check required files exist
          test -f README.md
          test -f CONTRIBUTING.md
          test -f LICENSE
```

---

### 2. Manual Validation

**Content Audit Checklist:**

- [ ] Every file in correct repository (use classification tree)
- [ ] No duplicate content (same concept in both repos)
- [ ] All cross-references valid (links work)
- [ ] Terminology consistent (same names everywhere)
- [ ] Diátaxis balance correct (60/30/10 vs. 40/30/20)

**Cross-Reference Validation:**

```bash
# Script: validate-cross-references.sh

# Check 12-factor-agentops → agentops links
grep -r "github.com/boshu2/agentops" 12-factor-agentops/

# Check agentops → 12-factor-agentops links
grep -r "github.com/boshu2/12-factor-agentops" agentops/

# Verify no broken links (run link checker)
```

---

### 3. User Testing

**Researcher Test (12-factor-agentops):**

**Scenario:**
"You're researching operational frameworks for AI. You've found 12-factor-agentops. Can you understand what AgentOps is and why it matters?"

**Success Criteria:**
- [ ] Finds Four Pillars explanation
- [ ] Understands Five Laws rationale
- [ ] Can describe 2+ patterns
- [ ] Knows where to find reference implementation (if needed)
- [ ] No confusion about repo purpose

**Observation:**
- Time to understand core concepts: ____ min (target: <30 min)
- Confusion points: _______
- Missing information: _______

---

**Practitioner Test (agentops):**

**Scenario:**
"You want to automate product planning with AI agents. You've found agentops. Can you run your first workflow?"

**Success Criteria:**
- [ ] Completes quick-start in <10 min
- [ ] Runs first workflow (plan-product)
- [ ] Understands how to use other agents
- [ ] Knows where to find deeper theory (if needed)
- [ ] No confusion about repo purpose

**Observation:**
- Time to first workflow: ____ min (target: <10 min)
- Blockers encountered: _______
- Missing documentation: _______

---

### 4. Success Metrics

**Quantitative:**

| Metric | Target | Validation Method |
|--------|--------|-------------------|
| Agents migrated | 100% | Count agents in agentops vs. original |
| Broken links | 0 | Automated link checker |
| User confusion rate | <10% | User testing (4+ users) |
| Time to first workflow | <10 min | Practitioner testing |
| Content classification | 100% | Manual audit against classification tree |

**Qualitative:**

| Metric | Target | Validation Method |
|--------|--------|-------------------|
| Purpose clarity | "Very clear" | User survey (5-point scale) |
| Navigation ease | "Easy" | User observation |
| Contribution clarity | 100% correct routing | Contributor survey |

---

## Rollback Strategy

### Rollback Triggers

**Abort migration if:**

1. **Critical functionality breaks**
   - Any agent completely non-functional after migration
   - Commands fail to execute
   - CI/CD pipeline fails irreparably

2. **User confusion exceeds threshold**
   - >20% of test users confused about repo purpose
   - >50% users can't complete primary task
   - Negative feedback dominates

3. **Cross-references unmanageable**
   - >10 broken links after Phase 2
   - Circular dependency issues
   - Users get lost between repos repeatedly

---

### Rollback Plans

**Phase 1 Rollback:**
- Delete agentops repository
- Remove cross-references from 12-factor-agentops
- Restore 12-factor-agentops README to pre-Phase-1 state
- **Time to rollback:** <1 hour

**Phase 2 Rollback:**
- Restore 12-factor-agentops from git tag (pre-Phase-2)
- Archive agentops repository (mark as deprecated)
- Restore all content to original locations
- **Time to rollback:** <4 hours

**Phase 3 Rollback:**
- Mark both repos as "Work in Progress"
- Publish rollback announcement
- Provide temporary guidance (use original structure)
- **Time to rollback:** <2 hours

---

### Mitigation Strategy

**To reduce rollback likelihood:**

1. **Git Tags Before Each Phase**
   ```bash
   git tag pre-phase-1
   git tag pre-phase-2
   git tag pre-phase-3
   ```

2. **Backup 12-factor-agentops**
   - Clone before starting Phase 2
   - Archive locally and remotely

3. **Parallel Testing**
   - During Phase 2, test both repos simultaneously
   - Don't delete original until Phase 3 complete

4. **Incremental Validation**
   - Test after each major migration step
   - Fix issues before proceeding

---

## Open Questions

### Answered During Specification

1. ~~Should repos be split?~~ → **YES** (answered)
2. ~~What belongs in each repo?~~ → **Philosophy vs. Implementation** (answered)
3. ~~How to handle Five Laws?~~ → **In both: defined vs. enforced** (answered)
4. ~~Rename repos?~~ → **NO, keep current names** (answered)
5. ~~User entry points?~~ → **Either works, signpost to other** (answered)

### Remaining Open Questions

1. **Internal-Only Content**
   - Current state: agentops README mentions "Internal Only (GitOps)" with 52+ agents
   - Question: Does the split affect internal/public boundary?
   - Decision needed: Should internal agents stay in private fork?

2. **Profile System Details**
   - Current: `profiles/default/` and `profiles/devops/` exist
   - Question: How many profiles in initial agentops release?
   - Decision needed: Ship only `default`, or include `devops` template?

3. **Case Study Placement**
   - Decision: Case studies in 12-factor-agentops (academic validation)
   - Question: Should agentops link to them, or just reference?
   - Decision needed: How prominent should case study links be in agentops?

4. **Version Synchronization**
   - Decision: Both repos should align versioning
   - Question: Strict sync (both always 1.0, 1.1) or loose (1.0 framework, 1.2 impl)?
   - Decision needed: Versioning policy

### Questions for Future Specs

1. Agent orchestration framework (multi-agent DAGs)
2. Performance optimization strategy
3. Additional profiles (beyond default/devops)
4. Community contribution workflow (PR templates, review process)

---

## Appendices

### Appendix A: File Migration Mapping

**From 12-factor-agentops → agentops:**

| Current Location | New Location | Notes |
|------------------|--------------|-------|
| `profiles/default/agents/*` | `agentops/profiles/default/agents/*` | All working agents |
| `profiles/default/commands/*` | `agentops/profiles/default/commands/*` | All slash commands |
| `specs/` (if exists) | `agentops/examples/` | Real usage examples |
| CONSTITUTION.md (if exists) | `agentops/CONSTITUTION.md` | Operational enforcement |

**Stay in 12-factor-agentops (refactor):**

| Current Location | New Location | Notes |
|------------------|--------------|-------|
| README.md | `12-factor-agentops/README.md` | Rewrite for framework audience |
| CLAUDE.md | `12-factor-agentops/CLAUDE.md` | Contributor guide (patterns) |
| POSITIONING.md | `12-factor-agentops/foundations/philosophy.md` | Rename, expand |
| content/ | `12-factor-agentops/patterns/` | Theoretical patterns |

**New Content to Create:**

| File | Repository | Purpose |
|------|------------|---------|
| `foundations/four-pillars.md` | 12-factor-agentops | Deep dive on pillars |
| `foundations/five-laws.md` | 12-factor-agentops | Philosophical rationale |
| `patterns/phase-based-workflow.md` | 12-factor-agentops | Pattern documentation |
| `docs/how-to/run-plan-product.md` | agentops | Task guide |
| `docs/tutorials/01-first-workflow.md` | agentops | Learning path |

---

### Appendix B: Cross-Reference Templates

**Template: Pattern → Implementation**

```markdown
## [Pattern Name]

**Category:** [Workflow/Architecture/Operational]

### Pattern Description

[Theoretical explanation of the pattern]

### Why This Pattern Works

[Philosophical/scientific grounding]

### When to Use This Pattern

[Conditions and contexts]

### Related Patterns

- [Pattern A](link)
- [Pattern B](link)

### See It In Action

**Reference Implementation:**
- [agentops implementation](https://github.com/boshu2/agentops/path/to/implementation)

**How-To Guide:**
- [How to use this pattern](https://github.com/boshu2/agentops/blob/main/docs/how-to/use-pattern.md)

**Tutorial:**
- [Learn this pattern](https://github.com/boshu2/agentops/blob/main/docs/tutorials/pattern-tutorial.md)
```

---

**Template: Implementation → Pattern**

```markdown
## [Agent/Command Name]

**Pattern:** [Pattern Name](link to 12-factor-agentops pattern)

### Quick Start

```bash
/command-name [args]
```

### Usage

[Practical usage instructions]

### Examples

[Real usage examples]

### Pattern Background

This agent implements the **[Pattern Name]** pattern:

- **Theory:** [12-factor-agentops/patterns/pattern-name.md](link)
- **Philosophy:** [12-factor-agentops/foundations/concept.md](link)
- **Why it works:** [Link to rationale]

### Troubleshooting

[Common issues and solutions]

### See Also

- [Related agent](link)
- [Related command](link)
```

---

### Appendix C: Contributing Guide Comparison

**12-factor-agentops/CONTRIBUTING.md Focus:**

```markdown
# Contributing to 12-factor-agentops

## What to Contribute

We welcome contributions in:

✅ **Patterns**
- New operational patterns
- Pattern refinements
- Pattern validation

✅ **Research**
- Academic studies on AgentOps
- Validation of framework claims
- Theoretical grounding

✅ **Case Studies**
- Real-world AgentOps applications
- Metrics and evidence
- Success/failure analysis

✅ **Philosophy**
- Framework improvements
- Theoretical extensions
- Conceptual clarifications

## What NOT to Contribute Here

❌ **Agents or Commands**
→ Contribute to [agentops](link) instead

❌ **How-To Guides**
→ Contribute to [agentops/docs/how-to/](link)

❌ **Tutorials**
→ Contribute to [agentops/docs/tutorials/](link)

## Contribution Process

1. [Process for pattern contribution]
2. [Process for case study contribution]
3. [Process for research contribution]
```

---

**agentops/CONTRIBUTING.md Focus:**

```markdown
# Contributing to agentops

## What to Contribute

We welcome contributions in:

✅ **Agents**
- New agent implementations
- Agent improvements
- Bug fixes

✅ **Commands**
- New slash commands
- Command enhancements
- Workflow optimizations

✅ **How-To Guides**
- Task-specific guides
- Troubleshooting docs
- Best practices

✅ **Tutorials**
- Learning paths
- Example workflows
- Step-by-step guides

## What NOT to Contribute Here

❌ **Pattern Theory**
→ Contribute to [12-factor-agentops/patterns/](link)

❌ **Research or Case Studies**
→ Contribute to [12-factor-agentops/case-studies/](link)

❌ **Framework Philosophy**
→ Contribute to [12-factor-agentops/foundations/](link)

## Contribution Process

1. [Process for agent contribution]
2. [Process for command contribution]
3. [Process for documentation contribution]
```

---

### Appendix D: README Templates

**12-factor-agentops README Structure:**

```markdown
# 12-factor-agentops

> Operational framework for AI agents

[Badge: Alpha] [Badge: License]

## What is AgentOps?

[1-2 paragraph philosophical overview]

## The Four Pillars

1. DevOps + SRE
2. Learning Science
3. Context Engineering
4. Knowledge OS

[Brief description of each]

## The Five Laws

1. ALWAYS Extract Learnings
2. ALWAYS Improve Self or System
3. ALWAYS Document Context
4. ALWAYS Validate Before Execute
5. ALWAYS Share Patterns Publicly

[See foundations/five-laws.md](link)

## Patterns

- [Phase-Based Workflow](link)
- [Multi-Agent Orchestration](link)
- [Intelligent Routing](link)
- [Context Bundles](link)

[See full pattern library](link)

## Reference Implementation

Want to use AgentOps in practice?

→ **[agentops](https://github.com/boshu2/agentops)** - Production-ready tools and working agents

## Start Here If You Want To:

- ✅ Understand AgentOps framework deeply
- ✅ Contribute patterns and research
- ✅ Validate framework with case studies

**For practical usage →** See [agentops](link)

## Documentation

- [Foundations](./foundations/) - Core concepts
- [Patterns](./patterns/) - Pattern library
- [Case Studies](./case-studies/) - Real-world validation
- [Research](./research/) - Academic depth

## Contributing

See [CONTRIBUTING.md](link) for how to contribute patterns, research, and case studies.

**To contribute agents/tools →** See [agentops/CONTRIBUTING.md](link)

## License

- Code: Apache 2.0
- Documentation: CC BY-SA 4.0
```

---

**agentops README Structure:**

```markdown
# agentops

> Production-ready operational tools for AI agents

[Badge: Alpha] [Badge: License]

## What is agentops?

[1-2 paragraph practical overview]

## Quick Start

```bash
# Install agentops
[installation command]

# Run your first workflow
/plan-product
```

[See full quick-start guide](link)

## Philosophical Foundation

Built on **[12-factor-agentops](https://github.com/boshu2/12-factor-agentops)** framework.

→ **Want deeper understanding?** See [framework documentation](link)

## Start Here If You Want To:

- ✅ Use AgentOps tools immediately
- ✅ Follow practical tutorials
- ✅ Implement workflows in your operations

**For theory and patterns →** See [12-factor-agentops](link)

## Available Workflows

- `/plan-product` - Product planning
- `/shape-spec` - Spec shaping
- `/write-spec` - Spec writing
- `/create-tasks` - Task breakdown
- `/implement-tasks` - Task implementation

[See full command reference](link)

## Documentation

- [Tutorials](./docs/tutorials/) - Learning paths
- [How-To Guides](./docs/how-to/) - Task-specific guides
- [Reference](./docs/reference/) - Command/agent docs
- [Constitution](./CONSTITUTION.md) - Operational laws

## Contributing

See [CONTRIBUTING.md](link) for how to contribute agents, commands, and documentation.

**To contribute patterns/theory →** See [12-factor-agentops/CONTRIBUTING.md](link)

## License

- Code: Apache 2.0
- Documentation: CC BY-SA 4.0
```

---

## Conclusion

This specification provides a comprehensive plan for splitting the 12-factor-agentops repository into complementary philosophy and implementation repositories.

**Key Outcomes:**
- Clear separation: philosophy vs. implementation
- Bidirectional references: seamless navigation
- Self-contained repos: either entry point works
- User-focused: researchers vs. practitioners

**Next Steps:**
1. Review and approve this specification
2. Proceed with Phase 1 (repository creation)
3. Execute phased migration (4 weeks)
4. Validate with user testing
5. Launch with announcement

**Success Criteria Recap:**
- ✅ 100% agents migrated successfully
- ✅ <10% user confusion rate
- ✅ Zero broken cross-references
- ✅ Both repos feel complete for their audience
- ✅ Clear contribution paths established

---

**Document Status:** Ready for Implementation
**Last Updated:** 2025-11-05
**Version:** 1.0
