# Factor II: Track Everything in Git

## Rule

**If it's not in git, it didn't happen.**

Not just code. Issues, learnings, patterns, session artifacts, decisions, failure analyses, agent handoffs—everything. Git gives you history, diffability, collaboration, and auditability for free. When your agent's knowledge base, issue tracker, and work artifacts all live in the repo, any agent can pick up where any other left off.

## Rationale

### The External Database Trap

You start with good intentions. "We'll track issues in Jira. Store learnings in Notion. Keep session logs in S3. Use a vector database for agent memory."

Six months later:
- Your issue tracker is down. Agents can't find their work.
- The vector DB schema changed. Half your memories are orphaned.
- Notion got reorganized. That critical architectural decision? Gone.
- Your S3 bucket hit a permission issue. A week of session history is inaccessible.
- A new agent joins. They need credentials for five different systems before they can even see what work exists.

You've distributed your state across services you don't control, in formats you can't diff, with access patterns you can't audit.

### Git is Already There

Every agent operation happens in a git repo. You're already cloning, branching, committing, pushing. Git already solves distributed state, conflict resolution, history, and synchronization. You already know how to use it.

So why add external dependencies for things git handles natively?

### What Git Gives You

**History**: Every decision has a commit hash. You can see who created an issue, when, and in what context. You can diff issue state across branches. You can trace why a learning was added or removed.

**Diffability**: Text files in git are diffable. You can review changes to your knowledge base the same way you review code. `git diff` shows you exactly what changed in your issue tracker between yesterday and today.

**Collaboration**: Multiple agents can work on issues concurrently. Git's merge semantics handle conflicts. Pull requests work for knowledge contributions just like code.

**Auditability**: `git log` is your audit trail. Every state change is signed, timestamped, and traceable. No database transaction logs to export. No API rate limits on your own history.

**No Vendor Lock-in**: Your issues are markdown files. Your learnings are markdown files. Your session artifacts are JSON or YAML. All human-readable, all tool-independent. If your tooling dies, you still have the raw data.

**Offline-First**: Git works offline. Clone the repo, work on a plane, push when you land. No API calls, no database connections, no cloud dependencies.

**Free Backup**: Every clone is a backup. Every developer who's pulled the repo has a complete copy of all history. Your issue tracker can't disappear because someone forgot to renew the cloud subscription.

### The Multi-Agent Case

Agent A completes work on issue X, learns pattern Y, and commits both. Agent B wakes up in a fresh environment, clones the repo, and sees:
- The issue history (what was attempted, what worked)
- The learnings (patterns that emerged)
- The code changes (implementation details)
- The session artifacts (debug logs, test results)

Agent B doesn't need credentials. Doesn't need to sync with external services. Doesn't need Agent A to hand off context verbally. The repo IS the handoff.

This is not theoretical. This is how Gas Town operates. The Mayor can spawn a Polecat, sling it work, and the Polecat finds everything it needs in the git worktree. No setup. No configuration. No API keys. Just `git clone`, `git worktree add`, and go.

### The Session Continuity Case

Your coding session ends mid-task. You've debugged a gnarly issue, identified three root causes, tried two solutions, and you're halfway through the third.

Traditional approach: You write a TODO comment, maybe a Slack message, maybe a mental note. Tomorrow, you'll have forgotten half the context.

Git-tracked approach: Your issue tracker has a bead for this work. You've updated it throughout the session:
- Added notes on what you discovered
- Linked to commits where you tried solution A
- Documented why solution A failed
- Added references to the files involved

You commit the issue state. Tomorrow (or another agent, or you after a context window reset), someone opens that issue and sees your entire debugging journey. They don't restart from scratch. They continue from exactly where you left off.

### The Knowledge Flywheel

Learnings extracted from completed work should feed into future work. This only works if learnings are versioned, discoverable, and tied to the work that generated them.

In a traditional setup:
- Learnings go into Confluence or Notion
- They're organized by whoever writes them (inconsistent taxonomy)
- They're searchable only if the platform's search works
- They're not versioned (edits overwrite history)
- They're disconnected from the code that validated them

In a git-tracked setup:
- Learnings are markdown files in the repo
- They're organized by directory structure (consistent, diffable)
- They're searchable with `grep`, `git log -S`, semantic search over committed files
- They're versioned (every edit is a commit, you can see evolution)
- They're linked to code via commit references and file paths

When you extract a learning from a completed task, you commit it. When another agent encounters a similar task, they search committed learnings. When a learning becomes obsolete, you deprecate it with a commit explaining why.

The knowledge base evolves with the codebase. They're the same artifact.

### The Auditability Case

Your agent autonomously closes 47 issues in a week. Management asks: "What actually got done? What quality level was delivered?"

Traditional approach: Query Jira's API, export to CSV, write SQL to aggregate status changes, manually review code commits to correlate with issues.

Git-tracked approach: `git log --grep='bd-xyz' --oneline`. Every issue closure is a commit. Every commit message references the issue. The diff shows exactly what changed. The issue file shows state transitions, who worked on it, and when.

Audit trail is free. Compliance is `git log`. No export, no API, no SQL.

### The Failure Recovery Case

An agent goes rogue. Closes issues incorrectly, introduces bad patterns, corrupts the knowledge base.

Traditional approach: Restore from database backup. Hope the backup is recent. Hope it doesn't include the corrupted state. Manually reconcile what happened between backup time and now.

Git-tracked approach: `git revert <bad-commit>`. Or `git reset --hard <good-commit>`. Or create a fix commit. The corrupted state is in history (auditable), but the current state is clean. No backup to restore. No reconciliation. Just standard git operations.

### The Collaboration Case

Agent A and Agent B both update the same issue simultaneously. Agent A marks it blocked. Agent B adds a workaround and marks it ready.

Traditional approach: Last write wins. Either A's update or B's update disappears, depending on who commits last. Or you've built a complex CRDT/operational transform system. Or you lock the issue while someone's editing it.

Git-tracked approach: Both agents commit to their branches. When they push, git detects the conflict. The conflict is in a text file (the issue's JSON or YAML). A human or automated merge process resolves it. Standard git conflict resolution. No custom logic required.

### The Distributed Work Case

Three agents are working on different features in the same repo. Each has their own git worktree (or clone). Each is tracking issues, extracting learnings, and generating artifacts.

Traditional approach: They share a database. Writes block reads. Schema migrations affect all agents simultaneously. Downtime is coordinated. Backups are centralized.

Git-tracked approach: Each agent works in isolation. Commits locally. Pushes to shared repo when ready. Pulls others' changes when convenient. No coordination required. No downtime. No shared locks.

This is the operational model that scales. Not just to multiple agents—to multiple teams, multiple organizations, multiple timezones.

## What Good Looks Like

### Issues in Git

Your issue tracker is a directory of files in the repo. Each issue is a JSON, YAML, or markdown file with a unique ID. Status, assignee, dependencies, notes—all in the file. State changes are commits. Issue history is `git log -- .beads/bd-xyz.json`.

Example (beads format):
```
.beads/
├── bd-001.json  # First issue
├── bd-002.json  # Second issue
└── graph.json   # Dependency graph
```

Creating an issue: `bd create "Fix auth bug"` → commits `.beads/bd-003.json`

Updating an issue: `bd status bd-003 in-progress` → commits the change

Closing an issue: `bd close bd-003` → commits the change

Querying issues: `bd list --status=open` → reads files, no API call

The entire issue database is 200KB of JSON. You can `git clone` it in milliseconds. You can `git log` it to see every state transition. You can `git bisect` it to find when an issue was introduced.

No database server. No API. No credentials. Just files and git.

### Learnings in Git

Every completed task can generate learnings. These go in versioned markdown files.

Example structure:
```
docs/learnings/
├── patterns/
│   ├── error-handling.md
│   ├── testing-strategies.md
│   └── agent-coordination.md
├── failures/
│   ├── 2025-01-why-polling-failed.md
│   └── 2025-02-race-condition-postmortem.md
└── decisions/
    ├── adr-001-use-git-for-issues.md
    └── adr-002-worktree-per-agent.md
```

When Agent A completes a task and discovers "polling-based coordination introduces race conditions, use message queues instead," they write `failures/2025-02-race-condition-postmortem.md` and commit it.

When Agent B starts work on coordination logic, they search: `git log -S "coordination" -- docs/learnings/` and find the postmortem. They avoid the same mistake.

The learning is versioned. If the pattern changes (e.g., you discover polling works fine with proper locking), you update the doc and commit. The history shows why the recommendation changed.

### Session Artifacts in Git

Agents generate artifacts: test results, debug logs, performance profiles, coverage reports. These can be committed (if small) or referenced (if large).

Example:
```
.agents/
├── boden/
│   ├── session-2025-02-15.log
│   ├── test-results.json
│   └── coverage.html
└── polecat-001/
    ├── session-2025-02-14.log
    └── debug-trace.txt
```

Small artifacts (JSON test results, short logs) commit directly. Large artifacts (video recordings, multi-GB traces) go in git-lfs or external storage with references committed.

The key: the reference is in git. The artifact's existence, location, and metadata are versioned. Even if the artifact itself lives in S3, the fact that "session X generated artifact Y at location Z" is in the repo.

### Handoffs in Git

Agent A runs out of time mid-task. They commit their current state, write a handoff note in the issue, and commit that too.

Example issue update:
```json
{
  "id": "bd-042",
  "status": "in-progress",
  "assigned": "polecat-002",
  "notes": [
    {
      "time": "2025-02-15T14:32:00Z",
      "author": "polecat-001",
      "text": "Debugged auth flow. Root cause: token expiry not handled in middleware. Fix half-complete in commit abc123. Next: add expiry check, write tests."
    }
  ]
}
```

Agent B picks up the issue, reads the note, checks out commit `abc123`, and continues. No Slack handoff. No meeting. No synchronous communication. The repo is the handoff.

### Decisions in Git

Architecture decisions, tool choices, process changes—these are ADRs (Architecture Decision Records) committed as markdown.

Example:
```markdown
# ADR-003: Use Git for Issue Tracking

## Status
Accepted

## Context
We need an issue tracker that works offline, supports multiple agents, and doesn't require external services.

## Decision
Store issues as JSON files in `.beads/`, versioned in git.

## Consequences
- Pros: Offline-first, no vendor lock-in, full audit trail, works with git workflows
- Cons: No rich UI (must build tooling), no built-in notifications, requires discipline to commit changes

## Alternatives Considered
- GitHub Issues: requires network, external dependency
- Jira: complex, expensive, poor offline support
- Linear: modern but still external SaaS
```

Commit the ADR. Now the decision is versioned, discoverable, and linked to the work that implemented it.

### Cross-Rig Coordination in Git

Multiple projects (rigs) each have their own repos. Coordination happens via git references.

Example: Rig A needs a change in Rig B.

1. Create issue in Rig A: `bd create "Wait for Rig B auth API"`
2. Create issue in Rig B: `bd create "Expose auth API for Rig A"`
3. Link them: `bd note bd-xyz "Blocked on rigB:bd-abc"`
4. Commit both issues in their respective repos

When Rig B closes `bd-abc`, they commit. Rig A pulls, sees the closure, unblocks `bd-xyz`.

No shared database. No API integration. Just git commits and references.

### The Complete Workflow

1. **Agent starts work**: `git clone`, `git worktree add`, or `git pull`
2. **Agent finds issue**: `bd list --status=ready`
3. **Agent works**: Edit code, run tests, debug
4. **Agent updates issue**: `bd status bd-xyz in-progress`, `bd note bd-xyz "Found root cause: ..."`
5. **Agent extracts learning**: Write `docs/learnings/patterns/new-pattern.md`
6. **Agent completes work**: `bd close bd-xyz`, `git add`, `git commit -m "Fix bd-xyz: ..."`, `git push`
7. **Next agent pulls**: `git pull`, sees closed issue, sees new learning, sees code changes

Every step is versioned. Every artifact is in git. Any agent can reconstruct the entire history from the repo alone.

## Anti-Patterns

### External Issue Trackers

Using Jira/Linear/etc as source of truth, syncing to git as a backup.

Why this fails:
- The sync is eventual. Agents see stale state.
- The sync can break. Now you have two divergent sources of truth.
- You're still dependent on the external service for reads.

If you must use external trackers (e.g., for non-technical stakeholders), treat them as a read-only view generated FROM git. Git is source of truth. External tracker is a dashboard.

### Binary Artifacts in Git

Committing large binary files (videos, compiled assets, multi-GB datasets) directly.

Why this fails:
- Repo size explodes
- Clones become slow
- Diffs are useless for binaries

Solution: Use git-lfs for binaries, or store in external blob storage with references in git. The reference (path, hash, metadata) is committed. The blob is stored externally but reproducibly fetchable.

### Unstructured Commits

Committing everything with message "wip" or "updates."

Why this fails:
- History is unreadable
- Bisecting breaks
- Reverting is risky (don't know what "wip" changed)

Solution: Atomic commits with descriptive messages. Each commit does one thing. Each message explains why. If you're closing an issue, reference it: "Fix bd-042: handle token expiry in auth middleware."

### Ignoring Learnings

Agents complete work but don't extract patterns or document failures.

Why this fails:
- Knowledge is lost
- Future agents repeat mistakes
- No flywheel effect

Solution: Post-task step extracts learnings. Even negative results are valuable. "We tried X, it failed because Y, use Z instead" is a learning.

### No Issue Discipline

Creating issues but not updating them. Or updating them locally but not committing.

Why this fails:
- Issue state is stale
- Other agents see wrong status
- Audit trail is incomplete

Solution: Treat issue updates like code changes. Edit, commit, push. `bd sync` automates this in beads.

## Without Tooling

You don't need beads. You don't need a custom issue tracker. You don't need specialized tooling.

Start here:

### Commit Your Learnings

Create `docs/learnings.md`:
```markdown
# Learnings

## 2025-02-15: Auth Token Expiry
Discovered middleware doesn't check token expiry. Added check in commit abc123.
Pattern: Always validate token lifetime in auth middleware.

## 2025-02-14: Test Flakiness
Tests were flaky due to race condition in setup. Fixed by adding explicit waits.
Pattern: Prefer deterministic setup over sleep/retry.
```

Every time you complete work, add a section. Commit it. That's it.

Future you (or another agent) can `git log -p docs/learnings.md` to see evolution. Can `grep` to find patterns. Can reference specific learnings by commit hash.

No tooling required. Just a markdown file and git.

### Commit Your TODOs

Create `TODO.md`:
```markdown
# TODO

## In Progress
- [ ] Fix auth bug (started 2025-02-15)
  - Root cause: token expiry not checked
  - Fix half-done in commit abc123
  - Next: add tests

## Blocked
- [ ] Deploy new API (waiting for ops approval)

## Done
- [x] Setup CI pipeline (2025-02-14)
```

Update it as you work. Commit changes. That's your issue tracker.

Not as powerful as beads. But infinitely better than no tracking at all. And it's in git.

### Commit Your Session Notes

At end of session, write `session-notes.md`:
```markdown
# Session 2025-02-15

## What I Did
- Debugged auth flow
- Found token expiry bug
- Started fix (50% complete)

## What I Learned
- Middleware runs before route handlers (obvious in retrospect)
- Token validation was assumed to happen in client, not server

## What's Next
- Complete fix (add expiry check)
- Write tests
- Update auth docs
```

Commit it. Next session, read it. Continuity achieved.

### Commit Your Decisions

When you make an architectural choice, write `decisions.md`:
```markdown
# Decisions

## 2025-02-15: Use JWT for Auth
Decision: Use JWT tokens instead of session cookies.
Rationale: Stateless, works with microservices, simpler to scale.
Tradeoffs: Can't revoke tokens early (accept this risk).
```

Commit it. Now the decision is on record, with context.

### That's It

You're tracking work, learnings, decisions, and continuity—all in git. No external services. No custom tools. Just markdown files and commits.

As you scale, you can add tooling (beads, ADR templates, automated learning extraction). But the foundation is simple: write it down, commit it, push it.

If it's not in git, it didn't happen.

## The Test

Can a fresh agent, with nothing but a repo URL, reconstruct:
- What work exists?
- What work is blocked?
- What patterns have been discovered?
- What decisions were made and why?
- What the current state of each task is?

If yes: you're tracking everything in git.

If no: you have external dependencies. Remove them.

## The Guarantee

When everything is in git:
- Any agent can pick up any work
- No agent is blocked by credentials or access
- History is complete and auditable
- Knowledge accumulates and compounds
- Failure recovery is `git revert`
- Collaboration is `git merge`
- Backup is `git clone`

This is not aspirational. This is operational reality in Gas Town. Every issue, every learning, every decision, every handoff—in git. The result: agents that operate autonomously, recover gracefully, and improve continuously.

If it's not in git, it didn't happen. Make sure it happens.
