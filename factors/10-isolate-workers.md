# X. Isolate Workers

**This factor is part of the Scale tier (X-XII) — advanced patterns for multi-agent workflows. Not a prerequisite for getting value from Factors I-IX.**

## Rule

**Each worker gets its own workspace, its own context, and zero shared mutable state.**

When you run multiple agents in parallel, isolation is everything. Two agents sharing a context window corrupt each other. Two agents sharing a working directory create race conditions. Two agents sharing mutable state create cascading failures that are impossible to debug.

True isolation means:
- **Separate git worktrees** for each worker (not just branches)
- **Fresh context per worker** (no shared conversation history)
- **No bleed-through** (one worker's changes invisible to others until merged)
- **Independent failure domains** (one worker crashes, others continue)

The cost of isolation is disk space and tokens. Both are cheap. The cost of contamination is cascading failures, corrupted state, and hours of debugging. That cost is expensive.

Parallel work only scales when workers can't step on each other.

## Rationale

### The Contamination Problem

You spin up two agents to work on separate features. They both start in the same directory. Agent A modifies `config.yaml`. Agent B reads `config.yaml` 30 seconds later and assumes the change is from a previous commit. Agent B makes decisions based on Agent A's uncommitted work. Agent B commits. Agent A rebases. The repository is now in an inconsistent state that neither agent intended and neither can explain.

This is not a hypothetical. This is what happens when you share working directories.

The same problem occurs with context windows. Agent A is debugging authentication. Agent B is refactoring the database layer. You run them in the same conversation thread because "it's easier to monitor." Agent A's context about auth tokens bleeds into Agent B's reasoning about database connections. Agent B starts making authentication-aware database decisions that don't make sense. The failure is silent. The code compiles. The tests pass. Six weeks later, someone tries to swap the auth provider and discovers the database layer has hardcoded assumptions.

Shared mutable state creates invisible coupling. Invisible coupling creates failures that only surface under production load.

### Why Isolation Scales

Isolation means independence. Independence means parallelism. Parallelism means throughput.

When workers are isolated:
- **No coordination overhead.** Workers don't wait for each other to commit, rebase, or finish.
- **Failures are local.** One worker crashes, the others keep running.
- **Work can be retried.** Failed worker? Delete its worktree, spawn a new one, reassign the issue.
- **Progress is measurable.** Each worker has its own branch. You can see what each worker accomplished.
- **Debugging is tractable.** Each worker's history is linear. No interleaved commits from other agents.

The classic objection: "But what if two agents need to work on the same file?"

The answer: **They don't.** If two issues genuinely require editing the same file, they have a dependency relationship. Model that dependency explicitly in your issue tracker. Resolve the upstream issue first. Then unblock the downstream issue. Sequential dependencies are fine. Hidden dependencies created by shared state are not.

If two issues are truly independent but happen to touch the same file, the merge conflict is a feature, not a bug. It surfaces the coupling. A human (or a merge-queue processor) resolves the conflict once, in a controlled environment. This is vastly better than two agents silently corrupting each other's assumptions during development.

### The Disk Space Objection

"Git worktrees waste disk space."

A typical repository is 50-500 MB. A modern development machine has 500 GB - 2 TB of disk. Running 10 isolated workers costs 500 MB - 5 GB. That's 0.1% - 1% of available disk.

If you're running 100+ workers, you have bigger problems than disk space. You need a distributed work queue, not a laptop.

The disk space objection is a proxy for "it feels wasteful." It's not wasteful. It's cheap insurance against expensive failures.

### The Token Cost Objection

"Fresh context per worker wastes tokens. Shared context lets workers learn from each other."

Shared context is contamination, not learning. If Worker A solves a problem and Worker B needs that solution, the answer is not "share the context window." The answer is:
1. Worker A commits the solution
2. Worker B pulls the changes
3. Worker B sees the solution in code, where it belongs

Learning happens through code, not through context window bleed-through.

Fresh context per worker costs more tokens upfront. But contaminated context costs far more in debugging, rework, and cascading failures. You're optimizing for the wrong variable.

### The Monitoring Objection

"Separate contexts make it hard to monitor what all the workers are doing."

Monitoring is an operations problem, not an isolation problem. The solution is structured logging, not shared context.

Each worker logs:
- What issue it's working on
- What branch it's on
- What stage of work it's in (research, planning, implementing, validating)
- What blockers it's encountered

Aggregate these logs in a dashboard. Now you can see all workers at a glance without contaminating their contexts.

If you're monitoring by reading conversation threads, you're doing it wrong. Conversation threads are for reasoning, not monitoring.

## What Good Looks Like

### Isolation at the Filesystem Level

Each worker gets its own git worktree:

```bash
# Worker A
git worktree add ../polecats/worker-a -b feature/auth-refactor

# Worker B
git worktree add ../polecats/worker-b -b feature/db-migration

# Worker C
git worktree add ../polecats/worker-c -b feature/api-versioning
```

Workers never see each other's uncommitted changes. Each worker has a clean view of the repository at the branch point. Work proceeds in parallel without interference.

When a worker finishes, it pushes its branch. A merge queue (automated or human) handles integration. Conflicts are resolved once, in a controlled environment, not N times across N workers.

### Isolation at the Context Level

Each worker runs in its own conversation thread. No shared history. No bleed-through.

If workers need to communicate, they do it through structured channels:
- **Commits and PRs** for code changes
- **Issue comments** for status updates
- **Logs** for debugging information
- **Handoff notes** for passing work between workers

Conversation threads are ephemeral reasoning artifacts. They're not communication channels.

### Isolation at the State Level

Workers do not share:
- **Environment variables** (each worker sources its own env)
- **Configuration files** (each worktree has its own config)
- **Temporary files** (each worker uses its own `/tmp` namespace)
- **Lock files** (no shared mutexes, no shared semaphores)

If you need coordination, use the issue tracker. If Issue B depends on Issue A, mark it as blocked. The worker on Issue B waits. The worker on Issue A proceeds. When Issue A closes, Issue B unblocks automatically.

This is not inefficiency. This is correctness.

### Example: Gas Town Polecats

Gas Town uses isolated workers (polecats) for all parallel work:

```
rig/
├── polecats/
│   ├── worker-auth/      ← Worktree for auth issue
│   ├── worker-db/        ← Worktree for db issue
│   └── worker-api/       ← Worktree for api issue
└── mayor/
    └── rig/              ← Canonical clone (read-only reference)
```

Each polecat:
- Has its own worktree (separate filesystem state)
- Runs in its own tmux session (separate process state)
- Has its own conversation thread (separate context state)
- Works on a dedicated branch (separate git state)

The mayor never works in `mayor/rig/`. That's a read-only reference. All actual work happens in isolated polecat worktrees.

Result: 3+ agents can work in parallel on the same repository without ever stepping on each other. Olympus runs dozens of isolated agents across multiple repositories using this exact pattern, demonstrating that the approach scales well beyond small teams.

### Failure Handling in Isolated Environments

When workers are isolated, failure handling is straightforward:

**Worker crashes mid-task:**
```bash
# Delete the corrupted worktree
rm -rf polecats/worker-failed

# Spawn a new worker for the same issue
git worktree add polecats/worker-retry -b feature/retry

# Worker starts fresh, no contamination from the crash
```

**Worker produces bad code:**
```bash
# Delete the branch
git branch -D feature/bad-implementation

# Delete the worktree
git worktree remove polecats/worker-bad

# Issue returns to ready state, another worker can pick it up
```

You can't do this with shared state. If two workers are in the same directory and one corrupts the state, you can't cleanly recover without affecting the other worker.

Isolation makes failure recovery a local operation. Shared state makes failure recovery a global operation.

### When Isolation Matters Most

Isolation is optional for single-agent workflows. If you're running one agent at a time, it works in the main worktree. No problem.

Isolation becomes critical when:
- **You run agents in parallel.** 2+ agents working simultaneously need isolation.
- **You retry failed work.** Old worker failed, new worker needs a clean slate.
- **You run untrusted code.** Agent-generated code runs in an isolated environment for safety.
- **You debug across multiple attempts.** Each attempt's worktree is preserved for inspection.

If you never run multiple agents in parallel, you can skip this factor. But if you're reading the Scale tier factors, you're probably already running parallel workflows. That means isolation is not optional. It's foundational.

### Isolation Is Not Containerization

You don't need Docker. You don't need VMs. You don't need Kubernetes.

Git worktrees provide filesystem isolation. Separate conversation threads provide context isolation. Separate processes (tmux sessions, terminals, whatever) provide runtime isolation.

That's sufficient for 95% of multi-agent workflows.

Containers add:
- **Dependency isolation** (useful if workers need conflicting package versions)
- **Resource limits** (useful if workers might consume unbounded CPU/memory)
- **Network isolation** (useful if workers call external APIs you want to control)

These are valuable in production systems. They're overkill for local development workflows.

Start with git worktrees. Add containers if you need them. Don't add containers because they "feel more isolated." Isolation is about state, not packaging.

### The Merge Problem

"If every worker has its own worktree, merging becomes a nightmare."

No. Merging becomes explicit.

Without isolation, merging is implicit and continuous. Workers silently overwrite each other's changes. Conflicts are detected late (or never). Debugging is impossible because you can't tell which worker made which change.

With isolation, merging is explicit and batched. Each worker produces a branch. Branches merge one at a time through a controlled process. Conflicts are detected immediately. Each merge is atomic — it either succeeds or fails, no in-between state.

Explicit is better than implicit. Always.

### Merge Strategies

When workers are isolated, you merge through a queue:

**Manual merge queue:**
1. Worker A finishes, pushes branch
2. Human reviews PR, merges to main
3. Worker B rebases on new main, pushes branch
4. Human reviews PR, merges to main
5. Repeat

**Automated merge queue (refinery pattern):**
1. Worker A finishes, pushes branch, marks issue done
2. Refinery picks up branch, tests it, merges if green
3. Refinery updates main
4. Worker B (already running) rebases when it pushes
5. Refinery processes Worker B's branch
6. Repeat

The refinery pattern scales to dozens of workers. Olympus uses this pattern to process PRs from multiple agent teams without human intervention on every merge.

Either way, isolation makes merging a well-defined operation with clear success/failure states. Shared state makes merging a continuous process with ambiguous outcomes.

### Observability in Isolated Systems

Each worker is a black box from the outside. That's the point. But black boxes need monitoring.

Good observability for isolated workers:

**Structured status:**
```bash
# Each worker reports:
# - Current issue ID
# - Current phase (research, plan, implement, validate)
# - Branch name
# - Time in current phase
# - Blockers (if any)

$ gt polecat list
worker-auth    | issue: auth-123 | phase: implement | branch: feature/auth | 15m
worker-db      | issue: db-456   | phase: validate  | branch: feature/db   | 5m
worker-api     | issue: api-789  | phase: research  | branch: feature/api  | 45m
```

**Logs per worker:**
```bash
# Each worker writes to its own log
polecats/worker-auth/session.log
polecats/worker-db/session.log
polecats/worker-api/session.log

# Aggregate with standard tools
tail -f polecats/*/session.log
```

**Health checks:**
```bash
# Each worker responds to status ping
$ gt polecat status worker-auth
alive | last activity: 2m ago | issue: auth-123 | phase: implement
```

This gives you full visibility without contaminating worker contexts.

### When to Break Isolation

Almost never.

The one valid exception: **Shared read-only resources.**

If all workers need to read the same reference documentation, put it in a shared location. Symlink it into each worktree if needed. Read-only data doesn't create coupling.

Everything else — code, config, dependencies, state — should be isolated per worker.

If you're tempted to share writable state, the correct solution is almost always:
1. Make the state immutable (write once, read many)
2. Coordinate through the issue tracker (explicit dependencies)
3. Merge early and often (reduce divergence)

Shared writable state is a design smell. Fix the design, don't break isolation.

### Cost-Benefit Analysis

**Costs of isolation:**
- Disk space: ~500 MB per worker
- Token overhead: ~1000 tokens per worker for fresh context
- Setup time: ~5 seconds to create a worktree

**Benefits of isolation:**
- Zero cross-contamination
- Parallelism without coordination overhead
- Clean failure recovery
- Tractable debugging
- Linear scaling up to dozens of workers

The costs are fixed and small. The benefits scale with the number of workers.

One instance of cross-contamination (2 hours of debugging) costs more than running isolated workers for a month.

### Migration Path

If you're currently running agents with shared state:

**Phase 1: Isolate filesystems**
- Switch to git worktrees
- One worktree per agent
- Keep everything else the same

**Phase 2: Isolate contexts**
- One conversation thread per agent
- No shared history
- Communication through commits and issue comments

**Phase 3: Isolate state**
- Separate env vars per worker
- Separate temp directories
- No shared lock files

You don't have to do all three phases at once. Each phase independently reduces contamination risk.

### Rules of Thumb

- **1 agent:** Main worktree is fine
- **2-5 agents in parallel:** Worktree isolation required
- **5-20 agents in parallel:** Worktree + context isolation required
- **20+ agents in parallel:** Worktree + context + state isolation required + automated merge queue

If you're not sure whether you need isolation, you probably don't yet. You'll know when you need it because you'll spend an afternoon debugging cross-contamination and decide "never again."

That's when you implement Factor X.

### Summary

Isolation is the foundation of scalable parallel work. It's not about paranoia or over-engineering. It's about making failures local, making debugging tractable, and making parallelism actually parallel.

The rule is simple: **Each worker gets its own workspace, its own context, and zero shared mutable state.**

Disk is cheap. Tokens are cheap. Your time debugging contaminated state is expensive.

Isolate your workers.
