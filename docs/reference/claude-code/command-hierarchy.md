# Command Hierarchy - 3-Level Architecture

**Purpose:** Document the slash command system architecture across workspace, containers, and repositories

**Version:** 1.0.0

**Status:** ✅ Production (60+ commands across 3 levels)

---

## Overview

The workspace uses a **3-level command hierarchy** that enables both shared and specialized slash commands:

```
Level 1: Workspace (universal)
    ↓ inherited
Level 2: Container (work/, personal/)
    ↓ inherited
Level 3: Repository (gitops/, life/, 12-factor-agentops/, etc.)
```

**Key Principles:**
1. **Commands cascade down** - Workspace commands available to all repos
2. **Repositories can extend** - Add domain-specific variants
3. **Precedence is clear** - Repository > Container > Workspace
4. **No conflicts** - Extensions use different names (e.g., `/prime-agentops`)

---

## The Three Levels

### Level 1: Workspace Commands (Universal)

**Location:** `/Users/fullerbt/workspaces/.claude/commands/`

**Purpose:** Core commands available to ALL repositories

**Commands (26 total):**

#### Workflow & Priming
- `/prime` - Interactive workflow router
- `/prime-simple-task` - Straightforward work routing
- `/prime-complex-task` - Multi-phase Research→Plan→Implement
- `/prime-debug` - Systematic debugging router

#### Research & Planning
- `/research` - Single-agent research phase
- `/research-multi` - Parallel 3-agent research (3x faster)
- `/plan` - Create implementation specification
- `/implement` - Execute approved plan

#### Validation
- `/validate` - Comprehensive validation suite
- `/validate-multi` - Parallel 3-agent validation

#### Bundle System
- `/bundle-load` - Load context bundle (multi-repo search)
- `/bundle-save` - Save session as bundle
- `/bundle-list` - Browse all bundles
- `/bundle-load-multi` - Load multiple bundles (Phase 2)

#### Git & Deployment
- `/create-onboarding-guide` - Generate developer onboarding
- `/containerize-application` - Docker containerization
- `/create-architecture-documentation` - Architecture docs

#### Analysis
- `/architecture-review` - Comprehensive architecture review
- `/code-review` - Code quality review
- `/ultra-think` - Deep problem analysis

#### Learning
- `/learn` - Extract patterns from work

#### Meta
- `/workflow-orchestrator` - Complex workflow automation
- `/workflow-status` - Show current workflow phase (Phase 2)

#### Workspace Tools
- `/workspace-search` - Search code across repos (Phase 2)
- `/archive-repository` - Systematic repository archival

#### Slash Command Development
- `/generate-tests` - Test generation
- `/update-docs` - Documentation updates

---

### Level 2: Container Commands (Group-Specific)

#### Work Container

**Location:** `/Users/fullerbt/workspaces/work/CLAUDE.md`

**Purpose:** Team operations context for work repositories

**Inheritance:**
- ✅ All 26 workspace commands
- ➕ Container-specific context (team workflows, conventions)
- ➕ Points to `/work/gitops/` for AgentOps control plane

**Commands Added:** None (uses workspace commands with work context)

#### Personal Container

**Location:** `/Users/fullerbt/workspaces/personal/CLAUDE.md`

**Purpose:** Personal development and framework context

**Inheritance:**
- ✅ All 26 workspace commands
- ➕ Container-specific context (personal workflows, frameworks)
- ➕ Points to personal repositories (life/, 12-factor-agentops/, etc.)

**Commands Added:** None (uses workspace commands with personal context)

---

### Level 3: Repository Commands (Domain-Specific)

#### work/gitops/ - AgentOps Control Plane

**Location:** `work/gitops/.claude/commands/`

**Inheritance:**
- ✅ All 26 workspace commands
- ✅ Work container context
- ➕ 31 gitops-specific commands

**Commands Added (31 total):**

**AgentOps Workflows:**
- `/prime-agentops` - AgentOps operational practices
- `/create-workflow-agent` - Build new workflow agent
- `/harmonize-guide` - Config harmonization
- `/scaffold-guide` - Site scaffolding

**Application Management:**
- `/create-app` - New application from pattern
- `/modify-app` - Update existing application
- `/validate-app` - Application validation

**Documentation & Audit:**
- `/audit-agents` - Agent compliance audit
- `/12factor-audit` - 12-factor compliance check
- `/documentation-router` - Diátaxis documentation

**Git & Release:**
- `/git-workflow` - Team git conventions
- `/commit-learnings` - Extract and commit learnings

**Infrastructure:**
- `/bundle-consolidation` - Bundle management
- `/agent-metrics` - Performance dashboard

[... +18 more gitops commands ...]

---

#### personal/life/ - Personal Knowledge OS

**Location:** `personal/life/.claude/commands/`

**Inheritance:**
- ✅ All 26 workspace commands
- ✅ Personal container context
- ➕ 7 life-specific commands

**Commands Added (7 total):**

**Personal Development:**
- `/construct-cycle` - Oracle/Morpheus quarterly planning
- `/update-mci` - Master Capability Inventory
- `/career-strategy` - NVIDIA/Anthropic path planning

**Philosophy:**
- `/codex` - Access Codex v2.0 philosophy
- `/adhd-optimization` - Neurotype-specific workflows

**Visibility:**
- `/agentops-promotion` - Visibility campaign management
- `/metrics-tracking` - Personal growth metrics

---

#### personal/12-factor-agentops/ - Framework Repository

**Location:** `personal/12-factor-agentops/.claude/commands/`

**Inheritance:**
- ✅ All 26 workspace commands
- ✅ Personal container context
- ➕ Framework-specific commands (if any)

**Commands Added:** None currently (framework repository, uses workspace commands)

**Future Potential:**
- `/factor-compliance` - Check 12-factor adherence
- `/pattern-extract` - Extract patterns from work
- `/research-format` - Format research contributions

---

## Inheritance Rules

### Rule 1: Commands Cascade Down

**Example:**
```
Workspace: /prime (basic routing)
    ↓ inherited
Work Container: /prime (same, with work context)
    ↓ inherited
work/gitops: /prime (same, with gitops context)
             /prime-agentops (extends with domain knowledge)
```

**Result:** In `work/gitops/`, BOTH `/prime` and `/prime-agentops` are available

---

### Rule 2: Extensions Use Different Names

**Pattern:** Extend, don't override

**Good:**
```
Workspace: /prime
Repository: /prime-agentops  ✅ Different name
```

**Bad:**
```
Workspace: /prime
Repository: /prime  ❌ Override (conflicts)
```

---

### Rule 3: Precedence (Repository > Container > Workspace)

**Scenario:** Same command name at multiple levels

**Resolution Order:**
1. Check repository `.claude/commands/` FIRST
2. Check container `CLAUDE.md` context
3. Check workspace `.claude/commands/` LAST

**Example:**
```
If work/gitops/.claude/commands/validate.md exists:
  → Use repository version

If not found:
  → Use workspace .claude/commands/validate.md
```

**Result:** Repository-specific customization takes precedence

---

### Rule 4: Context Inheritance

**Commands inherit context from their level:**

**Workspace `/prime`:**
- Knows: All repositories, multi-repository structure
- Doesn't know: Specific team conventions, domain patterns

**work/gitops `/prime`:**
- Knows: Team git workflow, AgentOps patterns, gitops domain
- Doesn't know: Personal philosophy, life planning

**personal/life `/prime`:**
- Knows: Personal workflows, construct cycles, philosophy
- Doesn't know: Team infrastructure, gitops patterns

---

## Extension Patterns

### Pattern 1: Domain-Specific Priming

**Base:** `/prime` (workspace - generic routing)

**Extensions:**
- `/prime-agentops` (gitops - AgentOps operations)
- `/prime-construct` (life - Personal quarterly planning)

**Why:** Different workflows need different context and routing

---

### Pattern 2: Enhanced Capabilities

**Base:** `/bundle-load` (workspace - single repository search)

**Enhancement:** Multi-repository search (workspace - v1.1)

**Why:** Feature benefits all repositories, promoted to workspace level

---

### Pattern 3: Specialized Workflows

**Base:** `/create-app` (workspace - generic app creation)

**Extension:** `/create-app-jren` (gitops - JREN-specific patterns)

**Why:** Domain needs specific patterns, don't pollute workspace

---

### Pattern 4: Compliance & Auditing

**Base:** None (domain-specific need)

**Extension:** `/12factor-audit` (gitops - AgentOps compliance)

**Why:** Only gitops needs 12-factor compliance tracking

---

## Command Lifecycle

### Stage 1: Experimental (Repository-Only)

**Location:** Repository `.claude/commands/`

**Status:** Testing in specific domain

**Example:** `/create-app-jren` (gitops-specific)

---

### Stage 2: Proven (Repository-Stable)

**Location:** Repository `.claude/commands/`

**Status:** Used 10+ times, documented, stable

**Example:** `/prime-agentops` (gitops - proven, but domain-specific)

---

### Stage 3: Universal (Promoted to Workspace)

**Location:** Workspace `.claude/commands/`

**Status:** Useful to all, well-documented, domain-agnostic

**Example:** `/bundle-list` (promoted from gitops to workspace)

---

### Stage 4: Deprecated (Marked for Removal)

**Location:** Repository `.claude/commands/DEPRECATED/`

**Status:** Superseded by better command

**Example:** `/old-bundle-load` → `/bundle-load` (with multi-repo search)

---

## Design Principles

### 1. Universal Core, Specialized Extensions

**Core (workspace):** Workflows everyone needs
- Research, planning, implementation
- Bundle system (knowledge reuse)
- Validation, code review

**Extensions (repository):** Domain-specific needs
- AgentOps compliance (gitops)
- Personal planning (life)
- Framework development (12-factor-agentops)

---

### 2. Minimize Cognitive Load

**Good:**
- 26 workspace commands (learn once, use everywhere)
- Clear naming (`/prime` vs `/prime-agentops`)
- Consistent patterns (all priming starts with `/prime`)

**Bad:**
- 60 commands at workspace level (overwhelming)
- Ambiguous names (`/prime1`, `/prime2`)
- Inconsistent patterns

---

### 3. Enable Discoverability

**How users discover commands:**

**Workspace level:**
```bash
ls /Users/fullerbt/workspaces/.claude/commands/
# Shows 26 core commands
```

**Repository level:**
```bash
cd work/gitops
ls .claude/commands/
# Shows 31 gitops-specific commands
```

**Documentation:**
- This file (command-hierarchy.md)
- README in each `.claude/commands/` directory

---

### 4. Promote Useful Patterns

**When to promote repository command to workspace:**

**Criteria:**
1. ✅ Useful to ALL repositories (not domain-specific)
2. ✅ Proven in production (used 10+ times successfully)
3. ✅ Well-documented (clear purpose, examples)
4. ✅ No domain dependencies (doesn't require gitops knowledge)

**Example: `/bundle-list` promoted to workspace**
- ✅ Useful to all repos (everyone has bundles)
- ✅ Proven (used 20+ times in gitops)
- ✅ Documented (comprehensive guide)
- ✅ Domain-agnostic (just lists bundles)

**Result:** All repositories benefit

---

## Command Index

### Complete Command List (60+ total)

**Workspace (26):**
1. /prime
2. /prime-simple-task
3. /prime-complex-task
4. /prime-debug
5. /research
6. /research-multi
7. /plan
8. /implement
9. /validate
10. /validate-multi
11. /bundle-load
12. /bundle-save
13. /bundle-list
14. /bundle-load-multi (Phase 2)
15. /create-onboarding-guide
16. /containerize-application
17. /create-architecture-documentation
18. /architecture-review
19. /code-review
20. /ultra-think
21. /learn
22. /workflow-orchestrator
23. /workflow-status (Phase 2)
24. /workspace-search (Phase 2)
25. /archive-repository
26. /generate-tests
27. /update-docs

**work/gitops (31 additional):**
28. /prime-agentops
29. /create-workflow-agent
30. /harmonize-guide
31. /scaffold-guide
32. /create-app
33. /modify-app
34. /validate-app
35. /audit-agents
36. /12factor-audit
37. /documentation-router
38. /git-workflow
39. /commit-learnings
40. /bundle-consolidation
41. /agent-metrics
[... +20 more gitops commands ...]

**personal/life (7 additional):**
55. /construct-cycle
56. /update-mci
57. /career-strategy
58. /codex
59. /adhd-optimization
60. /agentops-promotion
61. /metrics-tracking

---

## Best Practices

### For Command Authors

1. **Start repository-specific** - Test in one repo first
2. **Document thoroughly** - Purpose, when to use, examples
3. **Consider promotion** - After 10+ uses and validation
4. **Follow naming conventions** - Verb-noun (`/create-app`, `/validate-bundle`)

### For Command Users

1. **Learn progressively** - Start with workspace (26), add as needed
2. **Use primers effectively** - `/prime` for routing
3. **Discover via exploration** - `ls .claude/commands/` to browse
4. **Share learnings** - Document useful patterns

### For Workspace Administrators

1. **Keep core minimal** - Only promote universally useful
2. **Document hierarchy** - Maintain this file
3. **Version carefully** - Breaking changes affect all repos
4. **Enable discovery** - Clear indexing

---

## Integration with 12-Factor AgentOps

This command hierarchy implements:

### Factor II: JIT Context Loading

**Implementation:** 3-level hierarchy loads context just-in-time

**Benefit:** Stay under 40% context threshold

**Example:** Load workspace commands (26), then repository extensions only when needed

---

### Factor III: Single-Responsibility Agents

**Implementation:** Each command has one clear purpose

**Benefit:** Composable workflows from focused commands

**Example:** `/research` does research, `/plan` does planning - combine as needed

---

### Factor IX: Documented Pattern Extraction

**Implementation:** Commands capture and reuse patterns

**Benefit:** Learnings compound over time

**Example:** `/commit-learnings` extracts patterns from completed work

---

## Troubleshooting

### "Command not found"

**Cause:** Command only available in specific repository

**Solution:**
```bash
# Check which repository you're in
pwd

# Navigate to correct repository
cd work/gitops/  # For /prime-agentops
cd personal/life/  # For /construct-cycle
```

---

### "Which command to use?"

**Answer:** Depends on context

**Workspace `/prime`:**
- Generic routing
- Multi-repository awareness
- No domain assumptions

**Repository `/prime-agentops`:**
- AgentOps-specific routing
- Knows team patterns
- Git workflow integration

**Rule:** Use specialized when available, generic as fallback

---

### "Too many commands!"

**Solution:** Focus by level

**Learning workspace?**
- Focus on 26 workspace commands
- Ignore repository-specific initially

**Working in gitops?**
- Learn workspace (26) first
- Then gitops extensions (31)
- Total: 57 commands (learned progressively)

---

## Version History

**v1.0.0** (2025-11-09)
- Initial documentation
- 3-level hierarchy formalized
- 60+ commands documented
- Extension patterns defined
- Integration with 12-Factor AgentOps

---

**See [README.md](README.md) for complete Claude Code reference.**
