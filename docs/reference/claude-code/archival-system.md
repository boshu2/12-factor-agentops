# Repository Archival System

**Purpose:** Systematically archive redundant repositories with zero data loss

**Version:** 1.0.0

**Status:** ✅ Production-ready (validated once: personal/agentops)

---

## Overview

The archival system provides a **proven 4-phase methodology** for safely removing redundant repositories while preserving all data and institutional memory.

**Key Principle:** Archive-first, never delete. Zero data loss guaranteed.

---

## Quick Start

```bash
/archive-repository [repo-name]
```

**Example:**
```bash
/archive-repository personal/old-docs
```

**What happens:**
1. Research agent analyzes repository (~30 min)
2. Shows recommendation (ARCHIVE | KEEP | CONSOLIDATE)
3. Guides through updates, archival, and verification
4. Creates documentation (ARCHIVE_NOTICE.md)

**Total time:** ~1.5 hours

---

## The Four Phases

### Phase 1: Research (30 min) - Autonomous

**Agent:** `archive-researcher` (AI-powered)

**Process:**
1. Scan repository structure (files, size, purpose)
2. Detect duplication across workspace
3. Find cross-repository references
4. Check alternative coverage (where capabilities exist)
5. Assess risk (what would be lost)
6. Generate recommendation

**Output:** Research bundle with ARCHIVE | KEEP | CONSOLIDATE

---

### Phase 2: Update (30 min) - Manual

**Process:**
1. Update all CLAUDE.md files to remove references
2. Update workspace documentation
3. Verify no broken links
4. Commit documentation changes

**Validation:** Grep workspace for repository name

---

### Phase 3: Archive (10 min) - Manual

**Process:**
1. Create git archive branch: `git checkout -b archive/[repo-name]-YYYYMMDD`
2. Push archive branch to preserve history
3. Move directory: `mv [repo] [repo]-archived-YYYYMMDD`
4. Update workspace CLAUDE.md with archive notice

**Result:** Repository archived, instant recovery available

---

### Phase 4: Verify (20 min) - Manual

**Checklist:**
- ✓ Commands work (`/prime`, `/research`, etc.)
- ✓ Agents accessible from other repos
- ✓ Documentation links valid
- ✓ Alternative coverage confirmed
- ✓ No functionality lost

**Output:** Verification complete, archival successful

---

## Components

### Slash Command: `/archive-repository`

**File:** `.claude/commands/archive-repository.md`

**Purpose:** Orchestrate 4-phase workflow

**What it does:**
- Launches archive-researcher agent for Phase 1
- Guides through Phases 2-4 with checklists
- Creates final ARCHIVE_NOTICE.md
- Ensures zero data loss

---

### Agent: archive-researcher

**File:** `.claude/agents/archive-researcher.md`

**Purpose:** Autonomous Phase 1 research

**What it does:**
- Systematic repository analysis
- Duplication detection (file-level MD5 hashing)
- Cross-repository reference audit
- Alternative coverage assessment
- Risk analysis and recommendation

**Output:** Comprehensive research bundle

---

### Template: ARCHIVE_NOTICE.md

**File:** `.claude/templates/ARCHIVE_NOTICE.md.template`

**Purpose:** Standard documentation for archived repositories

**Contains:**
- Why archived (duplication, better alternatives)
- What replaced it (specific repositories)
- Recovery instructions (3 options)
- Verification results

---

## When to Archive

**Archive when:**
- ✅ 100% content duplication (all files exist elsewhere)
- ✅ Ambiguous purpose ("teaching repository" unclear)
- ✅ Better alternatives exist (clearer repos with same capabilities)
- ✅ Maintenance cost > value provided

**Don't archive when:**
- ❌ Unique content exists (no alternatives)
- ❌ Active development in progress
- ❌ Production dependencies (other systems rely on it)

**Indicators:**
- Similar file names across repos
- "For examples, see X or Y or Z" (multiple alternatives)
- Architecture descriptions overlap
- Users confused about which repo to use

---

## Recovery Methods

If archival was a mistake, three recovery options:

### Option 1: Restore from Archive Branch (Fastest)

```bash
git checkout archive/[repo-name]-YYYYMMDD
mv [repo]-archived-YYYYMMDD [repo]
git checkout main
```

**Time:** <5 minutes

---

### Option 2: Clone from Remote

```bash
git clone [remote-url] [repo]
cd [repo]
git checkout archive/[repo-name]-YYYYMMDD
```

**Time:** ~10 minutes

---

### Option 3: Restore from Backup

If you have external backups (Time Machine, etc.)

**Time:** Depends on backup system

---

## Integration with 12-Factor AgentOps

### Factor I: Git Memory as Knowledge OS

**Implementation:** Archive branches preserve full history

**Benefit:** Zero data loss, instant recovery

---

### Factor IX: Documented Pattern Extraction

**Implementation:** Archival extracts learnings

**Patterns documented:**
1. Documentation sprawl detection (MD5 hashing)
2. Archive-first methodology (never delete)
3. Multi-tier consolidation (Trinity model)

**Benefit:** Future archival operations improve

---

### Factor X: Continuous Improvement Backlog

**Improvements identified:**
1. Automated duplication detector (Priority: Medium)
2. Reference link validator (Priority: High)
3. Workspace git integration (Priority: Low)

**Benefit:** System gets faster and more reliable

---

## Example: personal/agentops Archival

**Problem:** Three-tier architecture with redundant middle tier

```
12-factor-agentops (philosophy) ← Tier 1
agentops (teaching/examples)    ← Tier 2 (REDUNDANT)
agentops-showcase (public site) ← Tier 3
gitops (production)             ← Production
```

**Result:** 109 markdown files, 100% duplicated

**Decision:** Archive agentops, consolidate to Trinity model

**Outcome:**
- ✅ Zero data loss (archive branch created)
- ✅ All capabilities covered (showcase + 12-factor + gitops)
- ✅ Clearer architecture (Philosophy → Presentation → Production)
- ✅ Instant recovery available (3 commands)

**Time:** 1.5 hours total

---

## Success Criteria

System works when:

✅ Agent produces comprehensive research bundle
✅ Command guides through updates smoothly
✅ Archive creates git branch + renames directory
✅ Verification catches all issues
✅ Documentation is complete

---

## Best Practices

### For Users

1. **Review research carefully** - Agent recommendation is a suggestion
2. **Don't rush** - Take time in each phase
3. **Verify thoroughly** - Phase 4 is critical
4. **Document learnings** - What patterns emerged?

### For Workspace Administrators

1. **Keep system updated** - Improve after each use
2. **Extract patterns** - Document in bundles
3. **Test methodology** - Dry run with test repos
4. **Maintain templates** - Keep ARCHIVE_NOTICE.md current

---

## Related Documentation

- [Agents](agents.md) - archive-researcher agent details
- [Command Hierarchy](command-hierarchy.md) - /archive-repository command
- [Context Bundles](../../patterns/context-bundles.md) - Research bundle format
- [Git Memory](../../factors/01-git-memory-as-knowledge-os.md) - Factor I

---

## Version History

**v1.0.0** (2025-11-09)
- Initial system creation
- Validated with personal/agentops archival
- 4-phase workflow proven
- Zero data loss methodology confirmed

---

**Use `/archive-repository [repo-name]` to safely archive redundant repositories.**

**The system handles the complexity. You make the decisions.**

**Version:** 1.0.0 | **Status:** ✅ Production-ready
