# Claude Code Integration Reference

**Purpose:** Document the `.claude/` directory system architecture used in 12-Factor AgentOps implementations

**Status:** ✅ Production (validated across workspace repositories)

**Version:** 1.0.0

---

## Overview

The `.claude/` directory system provides a **3-level hierarchy** for organizing AI agent workflows, slash commands, skills, and configuration across workspaces, containers, and repositories.

**Key Concept:** Commands and agents **cascade down** from workspace → container → repository, enabling both shared infrastructure and domain-specific specialization.

---

## Quick Navigation

| Topic | File | Purpose |
|-------|------|---------|
| **Command System** | [command-hierarchy.md](command-hierarchy.md) | 3-level slash command architecture |
| **Agent System** | [agents.md](agents.md) | Agent architecture and organization |
| **Skills System** | [skills.md](skills.md) | Reusable skill components |
| **Settings** | [settings.md](settings.md) | Configuration and hooks |
| **Archival** | [archival-system.md](archival-system.md) | Repository archival methodology |

---

## The Three Levels

### Level 1: Workspace (Universal)

**Location:** `/Users/fullerbt/workspaces/.claude/`

**Purpose:** Core commands, agents, and skills available to ALL repositories

**Contains:**
- 26+ workspace slash commands
- 34+ workspace agents
- 2+ workspace skills
- Base settings and configuration
- Command hierarchy documentation

**Example:** `/prime`, `/research`, `/bundle-load`

---

### Level 2: Container (Group-Specific)

**Locations:**
- `work/CLAUDE.md` - Team operations context
- `personal/CLAUDE.md` - Personal development context

**Purpose:** Group-level context that repositories inherit

**Contains:**
- Container-specific context kernels
- Pointers to specialized repositories
- Group conventions and patterns

**Example:** Work container points to `gitops/` for AgentOps control plane

---

### Level 3: Repository (Domain-Specific)

**Locations:** Each repository's `.claude/` directory

**Purpose:** Domain-specific extensions and specializations

**Contains:**
- Repository-specific commands
- Domain-specialized agents
- Custom skills
- Settings overrides

**Examples:**
- `gitops/.claude/` - 31 additional GitOps commands
- `life/.claude/` - 7 additional personal development commands
- `agentops-showcase/.claude/` - Container testing skills

---

## Directory Structure

### Workspace Level

```
/Users/fullerbt/workspaces/.claude/
├── README-ARCHIVAL.md              # Archival system documentation
├── COMMAND_HIERARCHY.md            # Command system reference
├── settings.json                   # Base settings (symlinked to gitops)
├── settings.local.json             # Personal overrides (not committed)
├── agents/
│   ├── _TEAM_AGENTS.md             # Index of 34+ workspace agents
│   ├── archive-researcher.md       # Example workspace agent
│   └── [...]                       # Other workspace agents
├── commands/
│   ├── _TEAM_COMMANDS.md           # Index of workspace commands
│   ├── prime.md                    # Core workflow router
│   ├── research.md                 # Research phase command
│   ├── bundle-load.md              # Context bundle loading
│   ├── archive-repository.md       # Repository archival
│   └── [...]                       # 22+ other commands
├── skills/
│   ├── _TEAM_SKILLS.md             # Skills index
│   └── [...]                       # Workspace skills
├── workflows/
│   └── [...]                       # Workflow definitions
└── templates/
    ├── ARCHIVE_NOTICE.md.template  # Archival documentation template
    └── [...]                       # Other templates
```

### Repository Level

```
[repository]/.claude/
├── README.md                       # Repository-specific documentation
├── settings.json                   # Repository settings (extends workspace)
├── settings.local.json             # Developer overrides (not committed)
├── agents/
│   └── [domain-specific-agents]    # Repository-specific agents
├── commands/
│   └── [domain-specific-commands]  # Repository slash commands
└── skills/
    └── [domain-specific-skills]    # Repository skills
```

---

## Core Patterns

### Pattern 1: Cascade Inheritance

**Commands and agents cascade down:**

```
Workspace: /prime (basic routing)
    ↓ inherited
Container: /prime (same, with work/personal context)
    ↓ inherited
Repository: /prime (same, with domain context)
            /prime-agentops (extends with specialized routing)
```

**Result:** Both `/prime` and `/prime-agentops` available in repository

---

### Pattern 2: Extension, Not Override

**Good approach:**
```
Workspace: /prime
Repository: /prime-agentops  ✅ Different name, extends capability
```

**Bad approach:**
```
Workspace: /prime
Repository: /prime  ❌ Override creates conflicts
```

---

### Pattern 3: Precedence Rules

**Resolution order for same-named commands:**

1. Check repository `.claude/commands/` FIRST
2. Check container `CLAUDE.md` context
3. Check workspace `.claude/commands/` LAST

**Result:** Repository-specific customization takes precedence

---

### Pattern 4: JIT Context Loading

**Load context only when needed:**

- Workspace kernel: Universal patterns
- Container kernel: Group-specific patterns
- Repository kernel: Domain-specific patterns

**Benefits:**
- Stays under 40% context utilization
- Faster priming (30s vs 10min)
- Clearer mental models

---

## Integration with 12-Factor AgentOps

This `.claude/` system implements several factors:

### Factor II: JIT Context Loading

**Implementation:** 3-level hierarchy loads context just-in-time

**Benefit:** Stay under 40% context threshold

**Evidence:** See [context-engineering.md](../../explanation/foundations/context-engineering.md)

---

### Factor III: Single-Responsibility Agents

**Implementation:** Agents organized by domain in `.claude/agents/`

**Benefit:** Each agent has one clear purpose

**Evidence:** See [agents.md](agents.md)

---

### Factor VI: Session Continuity via Bundles

**Implementation:** Bundle system in workspace `.agents/bundles/`

**Benefit:** Multi-day work without context collapse

**Evidence:** See [../../patterns/context-bundles.md](../../patterns/context-bundles.md)

---

### Factor IX: Documented Pattern Extraction

**Implementation:** Archival system extracts learnings

**Benefit:** Patterns captured and reused

**Evidence:** See [archival-system.md](archival-system.md)

---

## Quick Start Examples

### Using Workspace Commands

```bash
# From any repository in workspace
/prime                    # Interactive workflow router
/research                 # Single-agent research phase
/bundle-load agentops     # Load saved context bundle
```

### Using Repository-Specific Commands

```bash
# Navigate to repository first
cd /Users/fullerbt/workspaces/work/gitops
/prime-agentops           # GitOps-specific routing
/12factor-audit           # Compliance checking

cd /Users/fullerbt/workspaces/personal/life
/construct-cycle          # Quarterly planning
/update-mci              # Master Capability Inventory
```

### Creating New Commands

```bash
# Create in repository .claude/commands/
vim .claude/commands/my-command.md

# Test it
/my-command

# Promote to workspace if universally useful
# (After 10+ uses, well-documented, domain-agnostic)
```

---

## Validation

### Command Discovery

```bash
# List workspace commands
ls /Users/fullerbt/workspaces/.claude/commands/

# List repository commands
cd [repository]
ls .claude/commands/
```

### Settings Validation

```bash
# Check settings inheritance
cat .claude/settings.json              # Repository settings
cat ../.claude/settings.json           # Workspace settings
cat .claude/settings.local.json        # Personal overrides
```

### Agent Availability

```bash
# List workspace agents
ls /Users/fullerbt/workspaces/.claude/agents/

# List repository agents
cd [repository]
ls .claude/agents/
```

---

## Related Documentation

### 12-Factor AgentOps Foundations

- [Context Engineering](../../explanation/foundations/context-engineering.md) - The 40% rule
- [JIT Context Loading](../../factors/02-jit-context-loading.md) - Factor II
- [Single-Responsibility Agents](../../factors/03-single-responsibility-agents.md) - Factor III

### Patterns

- [Context Bundles](../../patterns/context-bundles.md) - Session continuity
- [Phase-Based Workflow](../../patterns/phase-based-workflow.md) - Research → Plan → Implement

### Reference

- [Command Hierarchy](command-hierarchy.md) - Complete command system
- [Agents](agents.md) - Agent architecture
- [Skills](skills.md) - Reusable components
- [Settings](settings.md) - Configuration reference
- [Archival System](archival-system.md) - Repository lifecycle

---

## Best Practices

### For Command Authors

1. **Start repository-specific** - Test in one domain first
2. **Document thoroughly** - Purpose, when to use, examples
3. **Consider promotion** - After 10+ uses and validation
4. **Follow naming** - Verb-noun pattern (`/create-app`, `/validate-bundle`)

### For Repository Maintainers

1. **Inherit wisely** - Don't override workspace commands
2. **Extend clearly** - Use different names (`/prime-agentops`)
3. **Document locally** - Create `.claude/README.md`
4. **Test integration** - Verify workspace + repository commands work together

### For Workspace Administrators

1. **Keep core minimal** - Only promote universally useful commands
2. **Document hierarchy** - Maintain COMMAND_HIERARCHY.md
3. **Version carefully** - Breaking changes affect all repositories
4. **Enable discovery** - Clear indexing in `_TEAM_*.md` files

---

## Troubleshooting

### "Command not found"

**Cause:** Command only available in specific repository

**Solution:**
```bash
# Check current location
pwd

# Navigate to correct repository
cd /Users/fullerbt/workspaces/work/gitops  # For /prime-agentops
cd /Users/fullerbt/workspaces/personal/life  # For /construct-cycle
```

### "Which command to use?"

**Answer:** Depends on context

- **Workspace command** (`/prime`) - Generic, works everywhere
- **Repository command** (`/prime-agentops`) - Specialized, domain-specific

**Rule:** Use specialized when available, generic as fallback

### "Settings not applying"

**Check precedence:**
```bash
# Repository settings override workspace
cat .claude/settings.json              # Check repository
cat ../.claude/settings.json           # Check workspace
cat .claude/settings.local.json        # Check personal overrides
```

**Resolution:** Repository > Workspace > Defaults

---

## Status & Metrics

**Validation Status:** ✅ Production

**Usage:**
- 26+ workspace commands across all repositories
- 60+ total commands (workspace + repository extensions)
- 34+ workspace agents
- 3-level hierarchy validated in 14+ repositories

**Performance:**
- Command discovery: <30s with `/prime`
- JIT context loading: <40% context utilization
- Session continuity: Multi-day work via bundles

---

## Version History

**v1.0.0** (2025-11-09)
- Initial documentation
- Command hierarchy system documented
- Agent and skills architecture defined
- Archival system methodology captured
- Integration with 12-Factor AgentOps explained

---

**See individual reference documents for detailed information on each component.**
