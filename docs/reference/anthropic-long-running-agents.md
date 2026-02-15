# Anthropic's Long-Running Agent Pattern

**Source:** [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) - Anthropic Engineering, November 2025

**Relation to 12-Factor AgentOps:** This pattern directly implements [Factor VI: Lock Progress Forward](../../factors/06-resume-work.md) and validates our git-based memory approach.

---

## The Problem

> "The core challenge of long-running agents is that they must work in discrete sessions, and each new session begins with no memory of what came before."

AI agents are like "engineers working in shifts, where each new engineer arrives with no memory of what happened on the previous shift." Context windows are limited, and most complex projects cannot be completed within a single window.

---

## Anthropic's Solution

A two-part system with **git-tracked files as memory**:

```
┌─────────────────────────────────────────────────────┐
│              INITIALIZER AGENT (First Run)           │
├─────────────────────────────────────────────────────┤
│  Creates:                                            │
│  • init.sh - Development server script               │
│  • claude-progress.txt - Action log                  │
│  • feature-list.json - Requirements with pass/fail   │
│  • Initial git commit                                │
└─────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────┐
│              CODING AGENT (Each Session)             │
├─────────────────────────────────────────────────────┤
│  Protocol:                                           │
│  1. Read git logs and progress files                 │
│  2. Check current state with basic tests             │
│  3. Select ONE incomplete feature                    │
│  4. Make incremental changes                         │
│  5. Commit with descriptive messages                 │
│  6. Update progress documentation                    │
└─────────────────────────────────────────────────────┘
```

---

## The Memory Stack

**No external databases. No knowledge graphs. Just git-tracked files.**

| File | Purpose | Update Frequency |
|------|---------|------------------|
| `claude-progress.json` | Session state, what's done, blockers | Every session end |
| `feature-list.json` | Requirements with pass/fail status | When features complete |
| `.agents/bundles/*.md` | Compressed context snapshots | As needed |
| Git commits | History, revert capability | Every meaningful change |

---

## File Specifications

### claude-progress.json

Enables agents to "quickly understand the state of work when starting with a fresh context window."

```json
{
  "project": "project-name",
  "created": "2025-11-28T10:00:00Z",
  "sessions": [
    {
      "session_id": "session-001",
      "started": "2025-11-28T10:00:00Z",
      "ended": "2025-11-28T12:30:00Z",
      "summary": "Implemented validation layer, fixed auth bug",
      "commits": ["abc123", "def456"],
      "features_completed": ["feature-005"],
      "notes": "Next: Add integration tests"
    }
  ],
  "current_state": {
    "last_commit": "def456",
    "working_on": "feature-006",
    "blockers": [],
    "next_steps": ["Add integration tests", "Deploy to staging"]
  }
}
```

### feature-list.json

Structured tracking prevents premature completion claims.

```json
{
  "project": "project-name",
  "features": [
    {
      "id": "feature-001",
      "category": "authentication",
      "description": "User can log in with email",
      "steps": ["Create login form", "Validate credentials", "Issue session"],
      "passes": true,
      "completed_date": "2025-11-27"
    },
    {
      "id": "feature-002",
      "category": "authentication",
      "description": "User can reset password",
      "steps": ["Create reset form", "Send email", "Validate token"],
      "passes": false,
      "completed_date": null
    }
  ]
}
```

**Critical rule from Anthropic:**
> "It is unacceptable to remove or edit tests because this could lead to missing or buggy functionality."

Agents may ONLY modify the `passes` field - never delete or edit feature definitions.

---

## Session Protocol

### Starting a Session

```bash
# 1. Confirm location
pwd

# 2. Load progress state
cat claude-progress.json

# 3. Review recent history
git log --oneline -10

# 4. Check for uncommitted changes
git status

# 5. Identify next work item from feature-list.json
```

### During a Session

- Work on ONE feature at a time
- Commit frequently with descriptive messages
- Don't attempt too much in one session

### Ending a Session

- Record session summary in `claude-progress.json`
- Mark completed features in `feature-list.json`
- Ensure no uncommitted changes (or document them)
- Update `next_steps` for the next session

---

## Why NOT Knowledge Graphs?

Anthropic explicitly avoids external databases:

> "The article does **not recommend knowledge graphs or traditional databases**. Instead, it uses a simpler JSON-based feature list."

**Problems with external memory:**

| Issue | Impact |
|-------|--------|
| Duplication | Content exists in git AND database |
| Sync drift | Database diverges from file state |
| Complexity | Extra system to maintain |
| No revert | Can't `git revert` a database |
| Token cost | Loading from DB still uses context |

**Benefits of git-only:**

| Benefit | Value |
|---------|-------|
| Single source of truth | Files are authoritative |
| Built-in versioning | Git tracks all changes |
| Revert capability | Undo mistakes with `git revert` |
| Team sharing | `git pull` gets latest context |
| Offline capable | No network dependency |

---

## Failure Modes to Avoid

From Anthropic's research:

### 1. Premature Victory
Declaring projects complete without completing all features.

**Prevention:** Feature list with explicit pass/fail prevents this.

### 2. Context Exhaustion
Attempting to implement too much in one session.

**Prevention:** Work on ONE feature per session.

### 3. Insufficient Testing
Marking features complete without end-to-end verification.

**Prevention:** `passes` field requires actual validation.

### 4. Leaving Broken States
Starting new sessions with undocumented bugs.

**Prevention:** Always update progress files at session end.

### 5. Editing Requirements
Removing or modifying feature definitions to make completion easier.

**Prevention:** Agents may ONLY modify `passes` field.

---

## Git as Memory

Git history is the checkpoint system:

```bash
# Understand recent work
git log --oneline -10

# See what changed
git diff HEAD~3

# Revert failed changes
git revert abc123

# Recover working state
git checkout HEAD~1 -- broken-file.js
```

**Commit messages are memory writes:**

```bash
git commit -m "feat(auth): add password reset flow

Context: Users locked out with no recovery option
Solution: Email-based reset with 24h token expiry
Learning: Token expiry should match session length
Impact: Reduces support tickets ~30%"
```

---

## Implementation Commands

| Command | Purpose |
|---------|---------|
| `/session-start` | Load progress state, identify next work |
| `/session-end` | Save progress, record session summary |
| `/progress-update` | Update progress files during session |
| `/bundle-save` | Save context snapshot |
| `/bundle-load` | Load context snapshot |

---

## Key Quotes

> "The core challenge of long-running agents is that they must work in discrete sessions, and each new session begins with no memory of what came before."

> "It is unacceptable to remove or edit tests because this could lead to missing or buggy functionality."

> "Read git logs and progress files to get up to speed on what was recently worked on."

---

## References

- [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) - Anthropic Engineering
- [Claude Code Memory Documentation](https://code.claude.com/docs/en/memory) - Official docs
- [Claude Agent SDK](https://github.com/anthropics/claude-code-sdk) - Implementation reference

---

**Last updated:** 2025-11-28
