# XI. Supervise Hierarchically

**Escalation flows up, never sideways. Each level handles what it can and passes up what it can't.**

---

## Tier

This factor is part of the **Scale tier (X-XII)** — advanced patterns for multi-agent workflows. Not a prerequisite for getting value from Factors I-IX. You can run effective single-agent operations without supervision hierarchies. This becomes critical when you scale to multiple agents working concurrently, where failures compound and coordination overhead explodes without clear escalation paths.

---

## The Rule

**Build supervision trees, not peer networks.**

Every agent has exactly one supervisor. Supervisors may have their own supervisors, forming a tree. Workers solve problems at their level. When stuck, they escalate up one level. Supervisors decide: reassign, reframe, or escalate further.

**Never:**
- Let agents escalate sideways to peers
- Create circular supervision relationships
- Put humans in the middle of every retry loop
- Let workers decide what "failure" means globally

**Always:**
- Define clear escalation triggers (time, retry count, error type)
- Give supervisors more context than workers
- Let workers fail fast and cleanly
- Keep humans at the top, not embedded in every level

Hierarchy isn't bureaucracy. It's error handling architecture.

---

## Rationale

### The Flat Topology Trap

When agents coordinate as peers, you get:

**Deadlock by negotiation.** Agent A waits for Agent B to finish. Agent B needs input from Agent A. No one has authority to break the tie. Work stalls until a human notices.

**Circular dependencies.** "I'll merge after the tests pass." "I'll run tests after the merge." Both agents think they're blocked on the other. Without a supervisor to reorder operations, the cycle persists.

**Unbounded retry loops.** Agent hits an error, retries three times, gives up. Was three the right number? Should it have tried a different approach? Who decides? In a peer network, no one. The failure just propagates sideways until every agent is stuck.

**No global view.** Each agent sees its own context. None see the full dependency graph. A supervisor one level up can see that Agent A's blocker is caused by Agent B's incomplete work, and reassign or resequence.

Flat topologies optimize for "everyone is equal." But equality doesn't resolve conflicts. Hierarchy resolves conflicts.

---

### Supervision Trees: The Erlang Model

Erlang's OTP supervision trees are the gold standard for fault-tolerant systems. The pattern:

1. **Workers do work.** They don't manage failures beyond local retries.
2. **Supervisors manage workers.** They decide restart strategies, timeouts, and escalation.
3. **Supervisors supervise supervisors.** Failures at one level trigger decisions at the next.
4. **The top is always stable.** The root supervisor never crashes. It's the ultimate fallback.

In multi-agent systems:

- **Workers** = individual agents executing tasks (polecats, crew members)
- **Supervisors** = coordination agents (witnesses, refineries, mayor)
- **Root** = the human operator

When a worker fails, the supervisor decides:
- **Restart** (same task, fresh context)
- **Reassign** (different worker, same task)
- **Reframe** (same worker, different approach)
- **Escalate** (pass to next level with diagnosis)

The supervisor has visibility the worker doesn't: task history, other workers' state, priority queue, global constraints.

---

### Let It Fail

**Workers should fail fast and loudly.**

Don't let agents limp along with partial failures. Don't let them guess at recovery strategies. When stuck, they should:

1. **Capture state.** What were you doing? What broke? What did you try?
2. **Signal supervisor.** Send a structured failure report, not a vague "help."
3. **Stop cleanly.** Don't leave dirty state or half-finished work.

The supervisor receives the failure, evaluates context, and makes a decision. The worker doesn't retry indefinitely. It doesn't decide whether the failure is catastrophic or transient. It reports and waits.

This is counterintuitive for humans used to "try harder." But agents aren't good at meta-reasoning about their own failures. They lack the global view. Let them fail. Let supervisors decide what failure means.

---

### Bounded Retries, Unbounded Escalation

**Workers retry locally (bounded). Supervisors escalate globally (unbounded).**

A worker hits a test failure. It retries three times with minor variations. Still fails. Instead of:
- Retrying ten more times (wasting resources)
- Giving up silently (losing work)
- Asking a peer for help (creating lateral dependency)

It escalates to its supervisor with:
- What failed (specific test)
- What was tried (three retry attempts, with diffs)
- What's needed (diagnosis: flaky test vs. real regression)

The supervisor checks:
- Are other workers seeing the same test fail? (systemic issue)
- Is this test known-flaky? (ignore and proceed)
- Is this a blocker for downstream work? (escalate with urgency)

The supervisor's decision is informed by context the worker can't see. The worker gets a bounded retry budget. The supervisor has unbounded escalation paths.

---

### Humans at the Top, Not in the Middle

**The worst place for a human is embedded in a retry loop.**

Anti-pattern:
1. Agent tries task
2. Agent fails
3. Agent asks human for help
4. Human fixes it
5. Agent continues
6. Agent hits next failure
7. Loop repeats

The human becomes a bottleneck. The agent never learns. The system can't run unsupervised.

Better pattern:
1. Agent tries task
2. Agent fails, retries locally (bounded)
3. Agent escalates to supervisor with structured report
4. Supervisor tries reassignment, reframing, or batching similar failures
5. Supervisor escalates to human only when:
   - Multiple workers hit the same failure (systemic)
   - Failures exceed budget threshold (e.g., 5 escalations in 1 hour)
   - Requires policy decision (e.g., "skip flaky tests or block merge?")

The human sits at the top of the supervision tree, not in the middle. Escalations arrive batched, contextualized, and prioritized. The human makes decisions that propagate down, not one-off fixes in tight loops.

---

### Hierarchy Enables Autonomy

**Paradox: strict hierarchy enables more agent autonomy, not less.**

When agents know exactly who to escalate to, they stop hesitating. They don't waste cycles deciding "should I ask for help or try again?" They hit the retry limit, escalate, and move to the next task.

When supervisors have clear authority, they make fast decisions. They don't negotiate with peers. They reassign, reframe, or escalate. Work keeps moving.

When humans are at the top, they're not context-switching constantly. They review batched escalations, set policy, and let the tree handle execution.

Flat topologies require constant coordination. "Who should do this?" "Is this blocking you?" "Can you wait for me?" Every decision is a negotiation.

Hierarchies front-load decisions (who supervises whom, what triggers escalation), then execute without negotiation. The tree structure is the decision.

---

## What Good Looks Like

### Gas Town: Witness, Refinery, Mayor

Gas Town implements a three-level supervision tree:

```
Human (root)
  ↓
Mayor (town-level coordinator)
  ↓
Witness (rig-level supervisor) / Refinery (merge queue processor)
  ↓
Polecats (worker agents)
```

**Workers (Polecats):**
- Execute tasks in isolated worktrees
- Retry failures up to 3 times locally
- Escalate to Witness after retry budget exhausted
- Never coordinate with other polecats directly

**Supervisors (Witness/Refinery):**
- Monitor polecat health (hung sessions, resource leaks)
- Reassign work when polecat stuck
- Batch similar failures before escalating to Mayor
- Reframe tasks ("try X instead of Y")

**Town Coordinator (Mayor):**
- Receives escalations from multiple rigs
- Decides cross-rig priorities
- Escalates to human when policy decision needed
- Never directly manages individual polecats (that's Witness's job)

**Human (Root):**
- Receives batched escalations
- Sets policy (e.g., "security fixes override features")
- Reviews trends, not individual failures
- Intervenes only when supervision tree can't resolve

**Example escalation flow:**

1. Polecat hits merge conflict, retries 3 times, escalates to Witness
2. Witness checks: "Has this file been touched by another polecat recently?"
3. Yes → Reassigns to fresh polecat with updated base branch
4. Polecat retries, still conflicts (now a pattern)
5. Witness escalates to Mayor: "3 polecats hit conflicts on same file in 1 hour"
6. Mayor checks cross-rig: "Is this file shared between rigs?"
7. Yes → Mayor sends mail to human: "Cross-rig conflict on shared config, policy needed"
8. Human decides: "Rig A owns this file, Rig B adapts"
9. Mayor propagates decision to both rig Witnesses
10. Witnesses reassign work with new constraint

Notice: 9 steps before human involvement. The tree handled everything it could first.

---

### Olympus: Nested Skill Supervisors

Olympus (a multi-agent orchestration framework) uses nested skill hierarchies: low-level skills (file operations) escalate to mid-level skills (refactoring), which escalate to high-level skills (architecture planning), which escalate to the user only for ambiguous requirements.

---

### Escalation Triggers

**Define clear boundaries for when to escalate:**

| Trigger | Example | Action |
|---------|---------|--------|
| **Retry budget exhausted** | Worker tried 3 times, still fails | Escalate with failure history |
| **Time limit exceeded** | Task expected to take 10 min, at 30 min still running | Supervisor checks: stuck or complex? |
| **Resource threshold** | Worker using >80% disk | Supervisor reassigns to instance with more capacity |
| **Dependency cycle detected** | Worker A waiting on B, B waiting on A | Supervisor resequences or escalates |
| **Unknown error type** | Worker hits exception not in known failure list | Escalate for diagnosis |
| **Policy ambiguity** | Worker unsure if failure is acceptable | Escalate for policy decision |

**Anti-pattern:** "Escalate when I feel stuck." Too vague. Triggers must be mechanical.

**Good pattern:** "Escalate after 3 retries OR 30 minutes OR unknown error type."

---

### Structured Failure Reports

**When escalating, workers must provide:**

1. **What was attempted:** Specific task, exact command/operation
2. **What failed:** Error message, exit code, symptoms
3. **What was tried:** Retry attempts, variations, diagnostics run
4. **Current state:** Dirty files, partial progress, rollback status
5. **What's needed:** Diagnosis, reassignment, reframing, policy decision

**Anti-pattern (vague):**
> "Tests failed, not sure why, maybe flaky?"

**Good pattern (structured):**
> "Task: Run test suite on feature branch
> Failed: 3/50 tests failed (test_auth, test_cache, test_db)
> Tried: Reran 3 times, same failures. Checked logs: db connection timeout.
> State: No uncommitted changes, branch clean.
> Need: Diagnosis — is db service down, or tests assuming wrong db config?"

Supervisors can't make good decisions without good data. Structured reports are non-negotiable.

---

### Supervision Budget

**Supervisors have finite capacity. Don't overload them.**

If one supervisor manages 20 workers, and each worker escalates every 10 minutes, the supervisor is flooded. Design for:

- **Span of control:** 5-10 direct reports per supervisor (Witness manages 5-10 polecats)
- **Escalation rate:** <10% of tasks should escalate (if >10%, workers need better tools or training)
- **Batch escalations:** Similar failures batched into single report (3 polecats hit same error → 1 escalation)

If escalation rate exceeds budget, the tree is misconfigured:
- Workers need more autonomy (better tooling, clearer constraints)
- Supervisors need more workers (span of control too wide)
- Another supervisor level needed (too much distance from worker to root)

---

### Recovery Strategies

**Supervisors must have playbooks, not just escalation.**

When a worker fails, the supervisor tries (in order):

1. **Restart:** Same task, fresh environment (clears transient state)
2. **Retry with variation:** Same task, different approach (e.g., use merge instead of rebase)
3. **Reassign:** Different worker, same task (maybe worker-specific issue)
4. **Reframe:** Same worker, reformulated task (maybe task was ambiguous)
5. **Defer:** Put task back in queue, work on others (maybe blocker will clear)
6. **Escalate:** Pass to next level with diagnosis (out of local options)

**Anti-pattern:** Immediately escalate every failure. Supervisors exist to absorb failures.

**Good pattern:** Try 1-5 first. Escalate only when local recovery exhausted.

---

### Metrics That Matter

Track these to tune your supervision tree:

- **Escalation rate:** % of tasks that escalate vs. complete
- **Resolution level:** % resolved at worker level, supervisor level, coordinator level, human level
- **Time to resolution:** How long from failure to recovery
- **Repeat failures:** Same failure escalating multiple times (indicates systemic issue)

**Healthy tree:**
- 90% tasks complete at worker level (no escalation)
- 8% resolved at supervisor level (local recovery)
- 2% escalate to coordinator or human (rare, high-impact)

**Unhealthy tree:**
- 50% tasks escalate (workers under-equipped)
- 30% escalate to human (supervisors ineffective)
- Same failures repeating (no learning loop)

---

### Anti-Patterns

**Peer Coordination (Flat Topology):**
- Agents ask each other for help
- Circular dependencies proliferate
- No one has authority to reorder work
- Deadlocks resolved by human intervention

**Middle Management Theater:**
- Supervisors exist but have no authority
- All escalations go straight to human
- Supervisors are just messengers
- No value added, pure overhead

**Hero Workers:**
- Some agents "never fail"
- Actually, they suffer in silence, thrashing endlessly
- No escalation means no visibility
- Failures discovered only when deadline missed

**Human in the Loop:**
- Every retry involves human confirmation
- Agent: "This failed, should I retry?" Human: "Yes." Agent: "Failed again, retry?" Human: "Yes."
- Human becomes bottleneck
- No progress when human AFK

**Infinite Retries:**
- Workers retry indefinitely
- No bounded budget
- Waste resources on hopeless tasks
- Supervisor never gets signal to intervene

---

## Implementation Checklist

**For Workers:**
- [ ] Define retry budget (count and time)
- [ ] Capture structured failure reports
- [ ] Escalate when budget exhausted or unknown error
- [ ] Never escalate sideways to peers
- [ ] Clean up state before escalating (no dirty half-work)

**For Supervisors:**
- [ ] Monitor worker health (resource usage, time elapsed)
- [ ] Have recovery playbook (restart, reassign, reframe, defer, escalate)
- [ ] Batch similar failures before escalating up
- [ ] Track escalation rate and resolution level
- [ ] Never escalate without trying local recovery first

**For Coordinators:**
- [ ] Receive escalations from multiple supervisors
- [ ] Identify systemic issues (same failure across rigs)
- [ ] Set policy when ambiguity detected
- [ ] Escalate to human only for policy decisions or threshold breaches
- [ ] Propagate decisions down the tree

**For Humans:**
- [ ] Sit at top of tree, not in middle
- [ ] Receive batched, contextualized escalations
- [ ] Set policy, don't solve individual failures
- [ ] Review metrics to tune tree structure
- [ ] Trust the tree to handle what it can

---

## When to Skip This Factor

**You don't need supervision hierarchies if:**

- You run a single agent with no concurrency
- All tasks are independent (no shared state, no dependencies)
- You're present and active during every agent session (human-in-loop by design)
- Failures are rare and always require human diagnosis (not automatable)

**You need this factor when:**

- Multiple agents work concurrently on shared state
- Tasks have dependencies or require sequencing
- You want agents to run unsupervised (overnight, weekends)
- Failures are common enough to need automated recovery

This is a **scale factor**, not a starting factor. Build flat first, promote to hierarchy when coordination overhead becomes painful.

---

## The Core Insight

**Hierarchy isn't about control. It's about error handling.**

Flat topologies assume everything works. Hierarchies assume failures are normal and design for recovery.

Workers fail. Supervisors recover. Coordinators prioritize. Humans set policy.

Escalation flows up. Authority flows down. Work keeps moving.

Build the tree. Let it fail. Watch it recover.

---

## Further Reading

- **Factor X: Dispose Gracefully** — Clean shutdown enables clean restarts
- **Factor XII: Orchestrate Declaratively** — Declare the tree structure, let runtime enforce it
- Erlang OTP Design Principles (supervision trees)
- Gas Town Witness documentation (`gt witness --help`)
- Kubernetes controller hierarchy (similar pattern for container orchestration)
