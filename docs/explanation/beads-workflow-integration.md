# Beads Workflow Integration

The unified development workflow combines three powerful systems:

| Layer | System | Contribution |
|-------|--------|--------------|
| **Tracking** | [Beads](https://github.com/steveyegge/beads) | Git-backed dependency graph, compaction-aware notes |
| **Decomposition** | Atomic patterns | Research-first, structured spec → feature breakdown |
| **Methodology** | Vibe Coding | Trust calibration, explicit reasoning, autonomy boundaries |

## The Unified Workflow

```
┌─────────────────────────────────────────────────────┐
│  /research "topic"                                  │
│    └── Deep codebase exploration                    │
│    └── Output to .agents/research/                  │
│    └── Evidence-based findings                      │
└─────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────┐
│  /plan .agents/research/...                         │
│    └── Load research findings                       │
│    └── Decompose into features                      │
│    └── bd create + bd dep add (beads issues)        │
│    └── bd comment (context for future sessions)     │
│    └── Output to .agents/plans/                     │
└─────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────┐
│  bd ready                                           │
│    └── Shows unblocked issues (dependency-aware)    │
└─────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────┐
│  /implement                                         │
│    └── bd update --status in_progress               │
│    └── Implement one feature                        │
│    └── bd comment (progress, compaction-aware)      │
│    └── Validate (tests, lint)                       │
│    └── bd close + semantic commit                   │
│    └── bd sync && git push                          │
└─────────────────────────────────────────────────────┘
                          ↓
                    (repeat /implement)
```

## Why Beads?

Beads solves the persistent memory problem for AI agents:

| Problem | Beads Solution |
|---------|----------------|
| Context compaction loses task state | Issues persist in `.beads/` git-backed storage |
| Flat task lists miss dependencies | Dependency graph with `bd dep add` |
| No way to know what's unblocked | `bd ready` shows only executable tasks |
| Multi-session context loss | `bd comment` preserves decisions and progress |

### Compaction Survival

When Claude's context gets compacted (summarized), beads issues survive:

```bash
# Session 1: Create issue with notes
bd create "Add OAuth2 support" --priority P1
bd comment oauth-123 "Using existing auth middleware pattern"
bd comment oauth-123 "Files: services/gateway/auth.py"

# Session 2 (after compaction): Context preserved
bd show oauth-123
# Shows all comments from Session 1!
```

## Key Commands

```bash
# Planning phase
bd create "Feature description" --type feature --priority P1
bd dep add child-issue parent-issue  # child depends on parent
bd comment <id> "Implementation notes for future sessions"

# Implementation phase
bd ready                             # Find unblocked issues
bd update <id> --status in_progress  # Start work
bd comment <id> "Progress update"    # Document as you go
bd close <id> --reason "Completed"   # Finish
bd sync                              # Push to git
```

## Dependency Semantics

**CRITICAL:** `bd dep add A B` means "A depends on B" (B must complete first)

```bash
# Example: JWT validation needs auth middleware first
bd create "Setup auth middleware" --priority P1
# Created: issue-101

bd create "Add JWT validation" --priority P2
# Created: issue-102

bd dep add issue-102 issue-101
# issue-102 depends on issue-101
# issue-102 is BLOCKED until issue-101 closes

bd ready
# Shows: issue-101 (unblocked)
# Hides: issue-102 (blocked)

bd close issue-101 --reason "Completed"
bd ready
# Shows: issue-102 (NOW unblocked)
```

## Persistent Artifacts

The workflow creates persistent memory across sessions:

| Artifact | Location | Purpose |
|----------|----------|---------|
| Research findings | `.agents/research/YYYY-MM-DD-topic.md` | Evidence-based exploration |
| Implementation plan | `.agents/plans/YYYY-MM-DD-topic-plan.md` | Structured decomposition |
| Issue database | `.beads/issues.jsonl` | Git-backed task state |
| Issue notes | Via `bd comment` | Compaction-surviving context |

## Integration with Vibe Coding

| Vibe Coding Principle | Beads Implementation |
|-----------------------|---------------------|
| **Three Developer Loops** | Issues track work across all loops |
| **Context preservation** | `bd comment` survives compaction |
| **Dependency awareness** | `bd dep add` creates execution order |
| **Continuous validation** | `bd ready` ensures prerequisites complete |
| **Explicit reasoning** | Notes document decisions |

## Integration with 12-Factor AgentOps

| Factor | Beads Support |
|--------|---------------|
| **I. Automated Tracking** | Git-backed `.beads/issues.jsonl` |
| **II. Context Loading** | JIT loading via `bd show` |
| **III. Focused Agents** | One issue per `/implement` |
| **IV. Continuous Validation** | Status tracking (`open` → `in_progress` → `closed`) |
| **V. Measure Everything** | Issue lifecycle metrics |
| **VI. Resume Work** | `bd ready` picks up where you left off |

## Attribution

**Beads** was created by [Steve Yegge](https://github.com/steveyegge/beads), co-author of [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) with Gene Kim. It represents the practical implementation layer for AI-native issue tracking.

The unified workflow emerged from combining:
- **Beads** (Steve Yegge) - Git-backed issue tracking
- **Atomic patterns** - Research → Plan → Implement decomposition
- **Vibe Coding** (Gene Kim & Steve Yegge) - Trust calibration and methodology

---

**Related:**
- [Vibe Coding Integration](vibe-coding-integration.md)
- [Standing on Giants](standing-on-giants.md)
- [Factor I: Automated Tracking](../../factors/01-automated-tracking.md)
