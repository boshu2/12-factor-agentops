# Agent System Architecture

**Purpose:** Document the agent organization and architecture used in 12-Factor AgentOps implementations

**Version:** 1.0.0

**Status:** ✅ Production (34+ workspace agents, 50+ total across repositories)

---

## Overview

Agents are **specialized autonomous workflows** that execute specific tasks following the Single-Responsibility Principle (Factor III).

**Key Concept:** Each agent has **one clear purpose** and can be composed with others to handle complex workflows.

---

## Agent Architecture

### Two Agent Types

#### 1. Script-Based Agents (Deterministic)

**Purpose:** Reliable, repeatable execution of well-defined tasks

**Characteristics:**
- Pure bash/python/node scripts
- Deterministic output
- Fast execution (seconds)
- No LLM calls
- 100% reproducible

**Examples:**
- `test-container` - Docker container validation
- `validate-yaml` - YAML syntax checking
- `render-app` - Kustomize rendering

**When to use:**
- Validation and testing
- File operations
- Template rendering
- Metric collection

---

#### 2. AI-Powered Agents (Adaptive)

**Purpose:** Handle ambiguous, research-heavy, or creative tasks

**Characteristics:**
- Uses Claude Code/LLM
- Adaptive to context
- Slower execution (minutes)
- Non-deterministic output
- Pattern learning over time

**Examples:**
- `archive-researcher` - Repository archival analysis
- `documentation-router` - Diátaxis organization
- `pattern-extractor` - Learning extraction

**When to use:**
- Research and analysis
- Documentation generation
- Pattern discovery
- Complex decision-making

---

## Directory Structure

### Workspace Agents

**Location:** `/Users/fullerbt/workspaces/.claude/agents/`

**Purpose:** Universal agents available to all repositories

**Organization:**
```
.claude/agents/
├── _TEAM_AGENTS.md                 # Index of all workspace agents
├── archive-researcher.md           # Repository archival analysis
├── bundle-consolidator.md          # Bundle management
├── compliance-auditor.md           # 12-factor compliance
├── context-optimizer.md            # Context engineering
├── documentation-router.md         # Diátaxis organization
├── pattern-extractor.md            # Learning extraction
├── [...]                           # 28+ more workspace agents
```

**Count:** 34+ agents

---

### Repository Agents

**Location:** `[repository]/.claude/agents/`

**Purpose:** Domain-specific agents for specialized workflows

**Examples:**

**work/gitops/.claude/agents/**
- GitOps application management
- Kubernetes resource validation
- Site configuration harmonization
- Release engineering workflows

**personal/life/.claude/agents/**
- Personal development tracking
- Capability inventory management
- Career strategy optimization

**personal/agentops-showcase/.claude/agents/**
- Container testing
- Documentation validation
- Website deployment

---

## Agent Frontmatter Format

**Every agent file uses YAML frontmatter:**

```markdown
---
name: archive-researcher
type: ai-powered
purpose: Analyze repositories for archival candidacy
status: production
version: 1.0.0
model: opus
estimated_time: 30min
dependencies:
  - workspace context
  - grep access
  - file read permissions
outputs:
  - research bundle (markdown)
  - recommendation (ARCHIVE | KEEP | CONSOLIDATE)
  - step-by-step procedure
integration:
  - slash_command: /archive-repository
  - bundle_format: v1.0.0
  - next_phase: manual execution
---

# Archive Researcher Agent

[Agent implementation...]
```

**Required Fields:**
- `name` - Unique identifier
- `type` - script-based | ai-powered
- `purpose` - One-sentence description
- `status` - experimental | stable | production | deprecated
- `version` - Semantic versioning

**Recommended Fields:**
- `model` - For AI agents (opus, sonnet, haiku)
- `estimated_time` - How long it takes
- `dependencies` - What it needs
- `outputs` - What it produces
- `integration` - How it connects to other components

---

## Agent Organization Patterns

### Pattern 1: Single-Responsibility Agents

**Good:**
```
archive-researcher.md       ✅ One purpose: Research archival candidacy
pattern-extractor.md        ✅ One purpose: Extract learnings
```

**Bad:**
```
archive-and-validate.md     ❌ Two purposes: archive + validate
general-helper.md           ❌ No clear purpose
```

**Why:** Composability. Combine small agents for complex workflows.

---

### Pattern 2: Workflow Composition

**Example:** Repository Archival

```
/archive-repository
    ↓ launches
archive-researcher (AI agent)
    ↓ returns research bundle
User reviews recommendation
    ↓ if ARCHIVE
Manual Phase 2: Update references
    ↓ then
Manual Phase 3: Archive repository
    ↓ then
Manual Phase 4: Verify
```

**Why:** Human-in-loop for decisions, agents for execution

---

### Pattern 3: JIT Agent Loading

**Don't load all agents at once:**

```
❌ Bad: Load all 34 workspace agents (context overload)
✅ Good: Load agent when needed via command

Example:
/archive-repository
  → Loads only archive-researcher agent
  → Returns research, exits
  → No lingering context
```

**Why:** Stays under 40% context threshold

---

### Pattern 4: Agent Promotion

**Lifecycle:**

1. **Experimental** - Repository `.claude/agents/` (testing)
2. **Stable** - Repository `.claude/agents/` (proven 10+ uses)
3. **Universal** - Workspace `.claude/agents/` (useful to all repos)

**Promotion Criteria:**
- ✅ Used 10+ times successfully
- ✅ Useful to multiple repositories
- ✅ Well-documented
- ✅ No domain-specific dependencies

**Example:** `archive-researcher` promoted from gitops to workspace

---

## Agent Discovery

### Via Index Files

**Workspace agents:**
```bash
cat /Users/fullerbt/workspaces/.claude/agents/_TEAM_AGENTS.md
```

**Repository agents:**
```bash
cd [repository]
cat .claude/agents/README.md
```

---

### Via Slash Commands

**Many commands launch agents:**

```bash
/archive-repository          → archive-researcher agent
/12factor-audit             → compliance-auditor agent
/documentation-router       → documentation-router agent
```

---

### Via Direct Launch

**For testing or manual use:**

Ask Claude to "Launch the [agent-name] agent to [task description]"

Example: "Launch the archive-researcher agent to analyze personal/old-docs for archival candidacy"

---

## Integration with 12-Factor AgentOps

### Factor III: Single-Responsibility Agents

**Implementation:** Each agent does one thing well

**Evidence:**
- `archive-researcher` - Only researches, doesn't execute
- `pattern-extractor` - Only extracts, doesn't apply
- `test-container` - Only tests, doesn't build

**Benefit:** Compose workflows from focused agents

---

### Factor VI: Session Continuity via Bundles

**Implementation:** Agents create bundles for multi-phase work

**Example:** `archive-researcher` creates research bundle
- Phase 1: Agent generates bundle (30min)
- User reviews (async)
- Phases 2-4: Use bundle for execution (1 hour)

**Benefit:** Multi-day work without re-research

---

### Factor VII: Intelligent Task Routing

**Implementation:** Commands route tasks to appropriate agents

**Example:** `/archive-repository` routes to `archive-researcher`

**Benefit:** Users don't need to know which agent - command handles routing

---

### Factor IX: Documented Pattern Extraction

**Implementation:** Agents extract and document patterns

**Example:** `pattern-extractor` agent
- Analyzes completed work
- Identifies reusable patterns
- Documents in markdown
- Adds to institutional memory

**Benefit:** Patterns compound over time

---

## Agent Best Practices

### For Agent Authors

1. **Single responsibility** - One clear purpose
2. **Clear frontmatter** - Complete metadata
3. **Deterministic when possible** - Prefer scripts over AI
4. **Document outputs** - What it produces
5. **Version carefully** - Breaking changes affect all users

---

### For Agent Users

1. **Use via commands** - Don't launch directly unless testing
2. **Trust the output** - Agents are validated
3. **Review bundles** - For AI agents, check reasoning
4. **Report failures** - Help improve agents

---

### For Workspace Administrators

1. **Promote carefully** - Only universally useful agents
2. **Index clearly** - Maintain _TEAM_AGENTS.md
3. **Validate thoroughly** - Test before promotion
4. **Document integration** - How commands use agents

---

## Agent Metrics

### Workspace Agents

**Total:** 34+ agents

**By Type:**
- Script-based: ~40% (deterministic)
- AI-powered: ~60% (adaptive)

**By Status:**
- Production: ~85%
- Stable: ~10%
- Experimental: ~5%

---

### Performance

**Script-based agents:**
- Execution time: 5-60 seconds
- Success rate: 99%+
- Cost: Near-zero (no LLM calls)

**AI-powered agents:**
- Execution time: 5-30 minutes
- Success rate: 90-95%
- Cost: $0.10-$1.00 per run

---

## Example Agents

### 1. archive-researcher (AI-Powered)

**Purpose:** Analyze repository for archival candidacy

**Process:**
1. Scan repository structure (files, size, purpose)
2. Detect duplication across workspace
3. Find cross-repository references
4. Check alternative coverage
5. Assess risk (what would be lost)
6. Generate recommendation

**Output:** Research bundle with ARCHIVE | KEEP | CONSOLIDATE

**Integration:** `/archive-repository` command

**Time:** ~30 minutes

---

### 2. test-container (Script-Based)

**Purpose:** Validate Docker container builds and runs correctly

**Process:**
1. Check Docker daemon running
2. Build image from Dockerfile
3. Start container on test port
4. Verify health endpoint responds
5. Check homepage loads
6. Verify non-root user
7. Clean shutdown

**Output:** Pass/fail with detailed logs

**Integration:** Git pre-push hook, `/test` command

**Time:** ~60 seconds

---

### 3. pattern-extractor (AI-Powered)

**Purpose:** Extract reusable patterns from completed work

**Process:**
1. Review session history
2. Identify decision points
3. Analyze successful approaches
4. Extract generalizable patterns
5. Document in markdown
6. Suggest improvements

**Output:** Pattern document

**Integration:** `/learn` command

**Time:** ~15 minutes

---

## Troubleshooting

### "Agent not found"

**Cause:** Agent only in specific repository

**Solution:**
```bash
# Check workspace agents
ls /Users/fullerbt/workspaces/.claude/agents/

# Check repository agents
cd [repository]
ls .claude/agents/
```

---

### "Agent taking too long"

**For AI-powered agents:**
- Expected: 5-30 minutes
- Check: Model specified (opus slower than sonnet)
- Optimize: Break into smaller agents

**For script-based agents:**
- Expected: 5-60 seconds
- Check: External dependencies (Docker, network)
- Debug: Run script directly to see errors

---

### "Agent output inconsistent"

**For AI-powered agents:**
- Normal: Non-deterministic by nature
- Improve: Better frontmatter (clearer purpose)
- Alternative: Use script-based if possible

**For script-based agents:**
- Unexpected: Should be deterministic
- Debug: Check inputs, dependencies
- Fix: Update script logic

---

## Future Development

### Planned Agents

**Workspace:**
- `dependency-analyzer` - Cross-repo dependency mapping
- `security-auditor` - Vulnerability scanning
- `performance-profiler` - Agent performance analysis

**Repository-Specific:**
- `kubernetes-validator` - K8s resource validation (gitops)
- `capability-tracker` - MCI growth analysis (life)
- `framework-auditor` - 12-factor compliance (12-factor-agentops)

---

### Automation Opportunities

1. **Auto-indexing** - Generate _TEAM_AGENTS.md from frontmatter
2. **Agent testing** - Automated validation of agent outputs
3. **Performance tracking** - Dashboard of agent metrics
4. **Smart routing** - Auto-select best agent for task

---

## Related Documentation

- [Command Hierarchy](command-hierarchy.md) - How commands launch agents
- [Skills](skills.md) - Reusable components for agents
- [Context Bundles](../../patterns/context-bundles.md) - Multi-phase workflows
- [Single-Responsibility Agents](../../factors/03-single-responsibility-agents.md) - Factor III

---

## Version History

**v1.0.0** (2025-11-09)
- Initial documentation
- 34+ workspace agents documented
- Agent architecture defined
- Integration with 12-Factor AgentOps
- Best practices established

---

**See [README.md](README.md) for complete Claude Code reference.**
