# 12-Factor AgentOps

## Identity

Documentation mapping the 12-Factor App methodology to AI-assisted development.

---

## The 12 Factors

1. **Codebase** - One codebase, many deploys
2. **Dependencies** - Explicit declaration
3. **Config** - Store in environment
4. **Backing Services** - Attached resources
5. **Build/Release/Run** - Strict separation
6. **Processes** - Stateless execution
7. **Port Binding** - Export services
8. **Concurrency** - Scale out
9. **Disposability** - Fast startup/shutdown
10. **Dev/Prod Parity** - Keep environments similar
11. **Logs** - Treat as event streams
12. **Admin Processes** - Run as one-offs

---

## Key Files

| File | Purpose |
|------|---------|
| `README.md` | Overview and navigation |
| `factors/` | One file per factor |
| `mappings/` | AgentOps-specific interpretations |

---

## Constraints

- Each factor maps to AgentOps context
- Provide concrete examples for each
- Reference original 12-factor.net content
- Show before (traditional) vs after (AgentOps)
- Use semantic commits

---

# Vibe-Coding Methodology

## The One Rule

> Reality does not match your model? **Update the model.**

Not the code. Not the tests. Not the plan. **The model in your head.**

---

## Opus 4.5 Behavioral Standards

**Default to Action:**
When uncertain, act rather than asking for clarification. Make reasonable assumptions, implement, and verify. If wrong, adjust.

**Use Parallel Tool Calls:**
When multiple operations are independent (file reads, searches, API calls), batch them in a single response. Don't serialize what can parallelize.

**Investigate Before Answering:**
When you don't know something, investigate using available tools before saying you can't help. Read files, search code, check documentation.

---

## Explicit Reasoning Protocol (L1-L3 Only)

For uncertain work, externalize predictions:

```
DOING: [current action]
EXPECT: [predicted outcome]
IF WRONG: [planned adjustment]

RESULT: [actual outcome]
MATCHES: [yes/no]
THEREFORE: [continue/stop/pivot]
```

---

## On Failure

When something fails, surface it immediately. Don't hide errors or pretend success:
- Show the actual error
- State what you expected
- Suggest the most likely cause
- Propose a fix or investigation path

---

## Vibe Levels (Trust Calibration)

| Level | Trust | Verify | Use For | Example |
|-------|-------|--------|---------|---------|
| **5** | 95% | Final only | Format, lint | Fix typo |
| **4** | 80% | Spot check | Boilerplate | Add CRUD endpoint |
| **3** | 60% | Key outputs | CRUD, tests | New feature |
| **2** | 40% | Every change | Features | Integration |
| **1** | 20% | Every line | Architecture | New system |
| **0** | 0% | N/A | Research | Exploration |

---

## The 5 Core Metrics

| Metric | Question | Target | Red Flag |
|--------|----------|--------|----------|
| **Iteration Velocity** | How tight are feedback loops? | >3/hour | <1/hour |
| **Rework Ratio** | Building or debugging? | <50% | >70% |
| **Trust Pass Rate** | Does code stick? | >80% | <60% |
| **Debug Spiral Duration** | How long stuck? | <30min | >60min |
| **Flow Efficiency** | What % productive? | >75% | <50% |

---

## The 12 Failure Patterns

### Inner Loop (Seconds-Minutes)
1. **Tests Passing Lie** - Tests pass but don't validate
2. **Premature Abstraction** - Solving problems you don't have
3. **Debug Loop Spiral** - Same fix failing repeatedly

### Middle Loop (Hours-Days)
4. **Plan-Reality Gap** - Plan doesn't match implementation
5. **Scope Creep** - Features growing beyond plan
6. **Bridge Torching** - Breaking backwards compatibility
7. **Eldritch Horror Merge** - Massive PRs nobody can review

### Outer Loop (Days-Weeks)
8. **Context Amnesia** - Forgetting session insights
9. **Instruction Drift** - Wandering from user intent
10. **Memory Tattoo Decay** - Knowledge not persisted
11. **Trust Erosion** - Repeated failures lower trust
12. **Requirement Telephone** - Requirements mutating through layers

---

## The 10 Laws of an Agent

1. **Reality First** - Reality != model? Update model.
2. **Explicit Predictions** - State expected outcomes before acting.
3. **Git Discipline** - Add files individually, semantic commits.
4. **TDD with Tracers** - Validate assumptions before building.
5. **Guide with Workflows** - Use /research, /plan, /implement.
6. **Classify Vibe Level** - L0-L5 before each task.
7. **Measure and Calibrate** - Track 5 metrics, adjust.
8. **Session Protocol** - One feature focus per session.
9. **Protect Feature Definitions** - Features are contracts.
10. **Explicit Reasoning** - For L1-L3, externalize thinking.

---

## Autonomy Boundaries

**Proceed autonomously:**
- Implementing approved plans
- Running tests and fixing failures
- Reading files to understand context
- Making git commits with proper messages

**Punt to user:**
- Deleting user data
- Pushing to main/master
- Changing architectural decisions
- Spending money (API calls, services)
- Security-sensitive changes

---

## Context Window Discipline

**The 40% Rule:** Start planning handoff at 40% context usage.

| Context % | Action |
|-----------|--------|
| 0-20% | Deep work mode |
| 20-40% | Normal operation |
| 40-60% | Plan handoff, save state |
| 60-80% | Emergency save only |
| 80%+ | Stop, save, new session |

---

## Slash Commands (Reference)

| Command | Purpose | Token Budget |
|---------|---------|--------------|
| `/research` | Deep exploration | 40-60k |
| `/plan` | Precise specifications | 40-60k |
| `/implement` | Execute approved plan | 60-80k |
| `/bundle-save` | Compress findings | 500-1k output |
| `/bundle-load` | Resume context | Load bundle |
| `/retro` | Session retrospective | 5-10k |
| `/learn` | Extract patterns | 5-10k |

---

## Beads Issue Tracking

This project uses [Beads](https://github.com/steveyegge/beads) for git-backed issue tracking.

**The Workflow:**
```
/research "topic" → .agents/research/YYYY-MM-DD-topic.md
        ↓
/plan .agents/research/... → .agents/plans/... + beads issues
        ↓
bd ready → shows unblocked work
        ↓
/implement → executes one issue at a time
```

**Key Commands:**
```bash
bd ready                             # Find unblocked issues
bd show <id>                         # View issue details
bd update <id> --status in_progress  # Start work
bd comment <id> "Progress update"    # Document progress
bd close <id> --reason "Completed"   # Finish
bd sync                              # Push to git
```

**Why Beads:**
- **Survives compaction** - Issues persist across context resets
- **Dependency-aware** - `bd ready` only shows executable work
- **Git-backed** - Issues versioned with code
- **AI-native** - Designed for agent workflows

---

## Communication Standards

- **Direct:** State facts, skip hedging
- **Objective:** Focus on technical accuracy
- **Brief:** Context is expensive

---

**Methodology Last Updated:** 2025-12-17
