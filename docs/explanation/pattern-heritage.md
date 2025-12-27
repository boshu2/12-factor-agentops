# Pattern Heritage: Houston + Fractal

**How two prototype control planes informed 12-Factor AgentOps production patterns**

---

## Overview

The Implementation Patterns in 12-Factor AgentOps don't come from theory—they come from production. Two prototype control planes, built between 2024-2025, validated these patterns before they were codified:

| Control Plane | Era | Philosophy | Key Contribution |
|---------------|-----|------------|------------------|
| **Houston** | 2024 | Local-first, filesystem-based | Mission lifecycle, SSE telemetry, N+1 workers |
| **Fractal** | 2024-2025 | Kubernetes-native, CRD-based | Shard/ShardRun, BudgetQuota, Blackboard |

These patterns then informed **ai-platform** (2025), the production Kubernetes deployment for IC environments.

---

## Houston: Local-First Control Plane (2024)

### Philosophy

Houston proved that multi-agent coordination doesn't require complex infrastructure. Using only the filesystem and Python, Houston implemented patterns that later scaled to Kubernetes.

**Core principle:** Agents coordinate through shared filesystem, not network calls.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        HOUSTON ARCHITECTURE                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                      FILESYSTEM                                  │   │
│  │                                                                  │   │
│  │  missions/                    workers/                          │   │
│  │  ├── mission-001/            ├── worker-a/                     │   │
│  │  │   ├── state.json          │   └── heartbeat                 │   │
│  │  │   ├── context.md          ├── worker-b/                     │   │
│  │  │   └── results/            │   └── heartbeat                 │   │
│  │  └── mission-002/            └── worker-c/                     │   │
│  │      └── ...                     └── heartbeat                 │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                              │                                          │
│              ┌───────────────┼───────────────┐                         │
│              │               │               │                         │
│              ▼               ▼               ▼                         │
│       ┌───────────┐   ┌───────────┐   ┌───────────┐                   │
│       │ Worker A  │   │ Worker B  │   │ Worker C  │                   │
│       │ (watches) │   │ (watches) │   │ (watches) │                   │
│       └───────────┘   └───────────┘   └───────────┘                   │
│                                                                         │
│  COORDINATION: mkdir atomic locking, file watches, no network needed   │
└─────────────────────────────────────────────────────────────────────────┘
```

### Pattern 1: Mission Lifecycle State Machine

Houston introduced explicit state machines for multi-phase work.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    MISSION LIFECYCLE (Houston)                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  PRE-EXECUTION                                                          │
│  ┌────────┐      ┌────────┐      ┌────────┐                            │
│  │  PREP  │ ───► │ QUEUED │ ───► │  HELD  │ ◄── Human gate             │
│  └────────┘      └────────┘      └────────┘                            │
│       │                               │                                 │
│       │                               │ approve                         │
│       ▼                               ▼                                 │
│  EXECUTION                                                              │
│  ┌──────────┐    ┌────────┐                                            │
│  │LAUNCHING │ ──►│ ACTIVE │                                            │
│  └──────────┘    └────────┘                                            │
│                       │                                                 │
│           ┌───────────┼───────────┐                                    │
│           ▼           ▼           ▼                                    │
│  TERMINAL                                                               │
│  ┌──────────┐  ┌────────┐  ┌─────────┐                                │
│  │ COMPLETE │  │ FAILED │  │ ABORTED │                                │
│  └──────────┘  └────────┘  └─────────┘                                │
│                                                                         │
│  INFORMED: Factor VI (Resume Work), Factor VIII (Human Validation)     │
└─────────────────────────────────────────────────────────────────────────┘
```

**State transitions are explicit and auditable:**

```python
# Houston mission state (simplified)
class MissionState(Enum):
    PREP = "prep"           # Being configured
    QUEUED = "queued"       # Ready for worker
    HELD = "held"           # Waiting human approval
    LAUNCHING = "launching" # Worker claimed
    ACTIVE = "active"       # Running
    COMPLETE = "complete"   # Success
    FAILED = "failed"       # Error
    ABORTED = "aborted"     # Cancelled

class Mission:
    def transition(self, new_state: MissionState):
        # Validate transition is legal
        if new_state not in VALID_TRANSITIONS[self.state]:
            raise InvalidTransition(f"{self.state} -> {new_state}")

        # Persist state change
        self.state = new_state
        self.save_state()  # Write to filesystem

        # Emit event for telemetry
        self.emit_event(StateChange(self.id, new_state))
```

**Factors informed:** VI (Resume Work), VIII (Human Validation)

---

### Pattern 2: mkdir Atomic Locking

Houston used filesystem mkdir for zero-dependency distributed locking.

```python
class AtomicLock:
    """Zero-dependency distributed lock using mkdir atomicity."""

    def __init__(self, lock_dir: Path):
        self.lock_dir = lock_dir

    def acquire(self, timeout: float = 10.0) -> bool:
        """Try to acquire lock via mkdir (atomic on all filesystems)."""
        start = time.time()

        while time.time() - start < timeout:
            try:
                # mkdir is atomic - only one process succeeds
                self.lock_dir.mkdir(parents=False, exist_ok=False)

                # Write our PID for debugging
                (self.lock_dir / "owner").write_text(str(os.getpid()))
                return True

            except FileExistsError:
                # Someone else has the lock
                time.sleep(0.1)

        return False

    def release(self):
        """Release lock by removing directory."""
        shutil.rmtree(self.lock_dir)
```

**Why this matters:** No Redis, no Zookeeper, no network. Just filesystem semantics that work everywhere, including air-gapped environments.

**Factors informed:** XII (Package Patterns) - works in any environment

---

### Pattern 3: SSE Telemetry (Server-Sent Events)

Houston used SSE for one-way observability—simpler than WebSocket, works through proxies.

```python
from fastapi import FastAPI
from sse_starlette.sse import EventSourceResponse

app = FastAPI()

@app.get("/missions/{mission_id}/events")
async def mission_events(mission_id: str):
    """SSE stream for mission telemetry."""

    async def event_generator():
        # Watch mission directory for changes
        async for event in watch_mission(mission_id):
            yield {
                "event": event.type,
                "data": json.dumps({
                    "mission_id": mission_id,
                    "state": event.state,
                    "progress": event.progress,
                    "timestamp": event.timestamp.isoformat()
                })
            }

    return EventSourceResponse(event_generator())
```

**Benefits:**
- One-way (server → client) is simpler than bidirectional
- Works through corporate proxies
- Auto-reconnects on disconnect
- No WebSocket complexity

**Factors informed:** V (Measure Everything), VIII (Human Validation async gates)

---

### Pattern 4: N+1 Worker Pattern

Houston maximized throughput with N parallel workers + 1 initializer.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      N+1 WORKER PATTERN                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                    ┌─────────────────┐                                 │
│                    │   INITIALIZER   │                                 │
│                    │   (1 worker)    │                                 │
│                    │                 │                                 │
│                    │ • Create mission│                                 │
│                    │ • Set up context│                                 │
│                    │ • Queue tasks   │                                 │
│                    └────────┬────────┘                                 │
│                             │                                           │
│              ┌──────────────┼──────────────┐                           │
│              ▼              ▼              ▼                           │
│       ┌───────────┐  ┌───────────┐  ┌───────────┐                     │
│       │ Worker 1  │  │ Worker 2  │  │ Worker N  │                     │
│       │           │  │           │  │           │                     │
│       │ • Claim   │  │ • Claim   │  │ • Claim   │                     │
│       │   task    │  │   task    │  │   task    │                     │
│       │ • Execute │  │ • Execute │  │ • Execute │                     │
│       │ • Report  │  │ • Report  │  │ • Report  │                     │
│       └───────────┘  └───────────┘  └───────────┘                     │
│                                                                         │
│  BENEFIT: Maximum parallelism with minimal coordination overhead        │
└─────────────────────────────────────────────────────────────────────────┘
```

**Factors informed:** III (Focused Agents), VII (Smart Routing)

---

### Pattern 5: PID-Based Crash Recovery

Houston detected worker crashes without heartbeats—just check if PID is alive.

```python
class WorkerMonitor:
    """Detect crashed workers via PID check."""

    def check_worker_health(self, worker_dir: Path) -> bool:
        pid_file = worker_dir / "pid"

        if not pid_file.exists():
            return False

        pid = int(pid_file.read_text())

        try:
            # Check if process exists (signal 0 doesn't kill)
            os.kill(pid, 0)
            return True
        except ProcessLookupError:
            # Process doesn't exist - worker crashed
            return False
        except PermissionError:
            # Process exists but we can't signal it
            return True

    def recover_orphaned_missions(self):
        """Find missions claimed by dead workers."""
        for mission in self.get_active_missions():
            if not self.check_worker_health(mission.worker_dir):
                # Worker died - requeue mission
                mission.transition(MissionState.QUEUED)
                mission.worker = None
```

**Factors informed:** XI (Fail-Safe Checks)

---

## Fractal: Kubernetes-Native Control Plane (2024-2025)

### Philosophy

Fractal proved that Kubernetes primitives (CRDs, controllers, reconciliation) are natural fits for agent orchestration. Agents become CRDs. Coordination becomes reconciliation.

**Core principle:** Agents are Kubernetes resources, coordination via reconciliation loops.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                       FRACTAL ARCHITECTURE                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  CUSTOM RESOURCES                                                       │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                                                                  │   │
│  │  KAgent          Shard           ShardRun        ToolCall       │   │
│  │  (agent def)     (intent)        (execution)     (audit)        │   │
│  │                                                                  │   │
│  │  BudgetQuota     Blackboard                                     │   │
│  │  (limits)        (coordination)                                 │   │
│  │                                                                  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                              │                                          │
│                    ┌─────────┴─────────┐                               │
│                    │    CONTROLLERS    │                               │
│                    │  (reconcile loops)│                               │
│                    └─────────┬─────────┘                               │
│                              │                                          │
│              ┌───────────────┼───────────────┐                         │
│              ▼               ▼               ▼                         │
│       ┌───────────┐   ┌───────────┐   ┌───────────┐                   │
│       │  Shard    │   │ ShardRun  │   │  Budget   │                   │
│       │Controller │   │Controller │   │Controller │                   │
│       └───────────┘   └───────────┘   └───────────┘                   │
│                                                                         │
│  COORDINATION: etcd watches, level-triggered, eventually consistent   │
└─────────────────────────────────────────────────────────────────────────┘
```

---

### Pattern 1: Shard/ShardRun Separation

Fractal separated **intent** (Shard) from **execution** (ShardRun), enabling retries without changing intent.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    SHARD / SHARDRUN MODEL                               │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  SHARD (Intent)                      SHARDRUN (Execution)               │
│  ─────────────                       ───────────────────                │
│  • What you want done                • One attempt to do it             │
│  • Immutable after creation          • Has status, logs, metrics        │
│  • Survives failures                 • Can fail, be retried             │
│                                                                         │
│  ┌──────────────────┐                                                  │
│  │     SHARD        │                                                  │
│  │                  │                                                  │
│  │  task: "analyze" │───────┬───────┬───────┐                          │
│  │  input: {...}    │       │       │       │                          │
│  │  agent: research │       ▼       ▼       ▼                          │
│  │                  │  ┌─────────┐ ┌─────────┐ ┌─────────┐             │
│  └──────────────────┘  │ShardRun │ │ShardRun │ │ShardRun │             │
│                        │   #1    │ │   #2    │ │   #3    │             │
│                        │ FAILED  │ │ FAILED  │ │ SUCCESS │             │
│                        └─────────┘ └─────────┘ └─────────┘             │
│                                                                         │
│  BENEFIT: Retry logic is clean - create new ShardRun, same Shard       │
└─────────────────────────────────────────────────────────────────────────┘
```

**CRD definitions:**

```yaml
# Shard - the intent
apiVersion: fractal.ai/v1alpha1
kind: Shard
metadata:
  name: analyze-api-docs
spec:
  task: "Analyze API documentation for pagination patterns"
  agentRef:
    name: research-agent
  input:
    url: "https://api.example.com/docs"
  maxRetries: 3
  timeout: "30m"

---
# ShardRun - one execution attempt
apiVersion: fractal.ai/v1alpha1
kind: ShardRun
metadata:
  name: analyze-api-docs-run-3
  ownerReferences:
    - kind: Shard
      name: analyze-api-docs
spec:
  shardRef:
    name: analyze-api-docs
  attempt: 3
status:
  phase: Succeeded
  startTime: "2025-01-15T10:00:00Z"
  completionTime: "2025-01-15T10:15:00Z"
  tokensUsed: 45000
  result:
    findings:
      - "API uses cursor-based pagination"
      - "Rate limit: 100 req/min"
```

**Factors informed:** VI (Resume Work), III (Focused Agents)

---

### Pattern 2: BudgetQuota CRD

Fractal enforced hard limits via CRD + controller—infrastructure enforcement, not agent promises.

```yaml
apiVersion: fractal.ai/v1alpha1
kind: BudgetQuota
metadata:
  name: team-alpha-budget
  namespace: ai-agents
spec:
  limits:
    maxTokensPerRun: 100000
    maxTotalTokens: 1000000
    maxCostPerRun: "$10.00"
    maxTotalCost: "$100.00"
    maxConcurrentRuns: 5
    maxDuration: "1h"

  enforcement:
    onTokenLimit: terminate
    onCostLimit: terminate
    onDurationLimit: pause

  notifications:
    slack: "#ai-ops"
    threshold: 0.80  # Warn at 80%

status:
  currentUsage:
    tokens: 450000
    cost: "$45.00"
    activeRuns: 3
  lastCheck: "2025-01-15T10:30:00Z"
```

**Controller logic:**

```go
func (c *BudgetController) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
    quota := &v1alpha1.BudgetQuota{}
    if err := c.Get(ctx, req.NamespacedName, quota); err != nil {
        return ctrl.Result{}, client.IgnoreNotFound(err)
    }

    // Calculate current usage
    usage := c.calculateUsage(ctx, quota.Namespace)

    // Check limits and enforce
    if usage.Tokens > quota.Spec.Limits.MaxTotalTokens {
        // HARD STOP - terminate runs
        c.terminateActiveRuns(ctx, quota.Namespace)
        c.sendAlert(quota, "Token limit exceeded")
    }

    // Update status
    quota.Status.CurrentUsage = usage

    // Requeue for continuous monitoring
    return ctrl.Result{RequeueAfter: 10 * time.Second}, nil
}
```

**Factors informed:** VIII (Human Validation), XI (Fail-Safe Checks)

---

### Pattern 3: Blackboard Coordination

Fractal introduced blackboard pattern—agents read/write shared state, don't call each other.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      BLACKBOARD PATTERN                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                    ┌─────────────────────────┐                         │
│                    │       BLACKBOARD        │                         │
│                    │    (Shared State)       │                         │
│                    │                         │                         │
│                    │  Decisions (append)     │                         │
│                    │  Directives (upsert)    │                         │
│                    └───────────┬─────────────┘                         │
│                          ▲     │                                        │
│              ┌───────────┘     └───────────┐                           │
│              │ write                  read │                           │
│              │                             ▼                           │
│       ┌──────┴──────┐             ┌──────────────┐                    │
│       │  Research   │             │   Planning   │                    │
│       │   Agent     │             │    Agent     │                    │
│       └─────────────┘             └──────┬───────┘                    │
│                                          │ write                       │
│                                          ▼                             │
│                    ┌─────────────────────────┐                         │
│                    │       BLACKBOARD        │                         │
│                    │  (Updated with plan)    │                         │
│                    └───────────┬─────────────┘                         │
│                                │ read                                   │
│                                ▼                                        │
│                    ┌─────────────────────────┐                         │
│                    │   Implementation Agent  │                         │
│                    └─────────────────────────┘                         │
│                                                                         │
│  KEY: Agents don't know about each other, only the blackboard          │
└─────────────────────────────────────────────────────────────────────────┘
```

**Blackboard entry types:**

```yaml
# Decision (append-only, creates audit trail)
apiVersion: fractal.ai/v1alpha1
kind: BlackboardEntry
metadata:
  name: research-decision-001
spec:
  type: decision
  phase: research
  author: research-agent
  content:
    findings:
      - "API supports cursor pagination"
      - "Rate limit is 100/min"
    confidence: 0.92

---
# Directive (upsertable, current state)
apiVersion: fractal.ai/v1alpha1
kind: BlackboardEntry
metadata:
  name: current-approach
spec:
  type: directive
  content:
    approach: "cursor-pagination"
    constraints:
      - "no breaking changes"
```

**Factors informed:** VII (Smart Routing)

---

### Pattern 4: Level-Triggered Reconciliation

Fractal used Kubernetes reconciliation loops—compare desired vs actual, converge continuously.

```go
// Level-triggered: Always compare desired vs actual
func (c *Controller) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
    // 1. Get desired state (from spec)
    desired := c.getDesiredState(req)

    // 2. Get actual state (from status + cluster)
    actual := c.getActualState(req)

    // 3. Diff and act
    if desired != actual {
        c.takeAction(desired, actual)
    }

    // 4. Requeue (even if nothing changed - catch missed events)
    return ctrl.Result{RequeueAfter: 30 * time.Second}, nil
}
```

**Why level-triggered beats edge-triggered:**

| Edge-Triggered | Level-Triggered |
|----------------|-----------------|
| "Event happened, react" | "What's the current state?" |
| Miss event = lost forever | Miss event = catch next loop |
| Must track what's processed | Idempotent by design |
| Complex event ordering | Simple state comparison |

**Factors informed:** XI (Fail-Safe Checks)

---

### Pattern 5: ToolCall Audit Trail

Fractal made every tool call a CRD—auditable, approvable, reversible.

```yaml
apiVersion: fractal.ai/v1alpha1
kind: ToolCall
metadata:
  name: tc-a1b2c3d4-write-file
  labels:
    shardrun: sr-123
    agent: implement-agent
spec:
  tool: write_file
  arguments:
    path: "/app/src/pagination.py"
    content: "..."
  requiresApproval: true
  approvalTimeout: "1h"

status:
  phase: Approved
  approval:
    decision: approved
    approvedBy: user@example.com
    approvedAt: "2025-01-15T10:45:00Z"
  execution:
    startTime: "2025-01-15T10:45:01Z"
    completionTime: "2025-01-15T10:45:02Z"
    success: true
```

**Benefits:**
- `kubectl get toolcalls` shows full audit trail
- Dangerous tools require human approval
- Reversible actions can be rolled back
- Compliance-ready logging

**Factors informed:** VIII (Human Validation), V (Measure Everything)

---

## Pattern-to-Factor Mapping

| Pattern | Source | Primary Factor | Supporting Factors |
|---------|--------|----------------|-------------------|
| Mission Lifecycle State Machine | Houston | VI (Resume Work) | VIII (Human Validation) |
| mkdir Atomic Locking | Houston | XII (Package Patterns) | - |
| SSE Telemetry | Houston | V (Measure Everything) | VIII (Human Validation) |
| N+1 Worker Pattern | Houston | III (Focused Agents) | VII (Smart Routing) |
| PID-Based Crash Recovery | Houston | XI (Fail-Safe Checks) | - |
| Shard/ShardRun Separation | Fractal | VI (Resume Work) | III (Focused Agents) |
| BudgetQuota CRD | Fractal | VIII (Human Validation) | XI (Fail-Safe Checks) |
| Blackboard Coordination | Fractal | VII (Smart Routing) | III (Focused Agents) |
| Level-Triggered Reconciliation | Fractal | XI (Fail-Safe Checks) | IV (Continuous Validation) |
| ToolCall Audit Trail | Fractal | VIII (Human Validation) | V (Measure Everything) |

---

## Evolution to ai-platform (2025)

ai-platform combined Houston's simplicity with Fractal's Kubernetes-native approach, adding IC-specific hardening:

| Layer | Houston | Fractal | ai-platform |
|-------|---------|---------|-------------|
| **Coordination** | Filesystem | etcd/CRDs | etcd/CRDs |
| **State Machine** | Python classes | CRD status | CRD status |
| **Limits** | Config files | BudgetQuota CRD | BudgetQuota + NetworkPolicy |
| **Audit** | Log files | ToolCall CRD | ToolCall + Splunk |
| **Deployment** | Docker Compose | Helm charts | 86-template Helm + Air-gap |
| **Security** | Basic auth | RBAC | RBAC + Classification boundaries |

**ai-platform innovations:**
- 3-tier deployment model (Edge/Datacenter/Connected)
- Air-gap deployment playbook
- Classification boundary enforcement via NetworkPolicy
- Multi-tenancy via namespace isolation
- 86-template Helm chart for complete stack

---

## Lessons Learned

### From Houston

1. **Start simple** - Filesystem coordination proved most patterns before adding infrastructure
2. **SSE > WebSocket** - One-way telemetry is simpler and sufficient
3. **Explicit state machines** - Named states prevent ambiguity
4. **Crash recovery via PID** - No heartbeats needed for local processes

### From Fractal

1. **CRDs for everything** - Makes state visible and queryable
2. **Separate intent from execution** - Shard/ShardRun pattern enables clean retries
3. **Level-triggered reconciliation** - More robust than edge-triggered
4. **Infrastructure enforcement** - BudgetQuota controller can't be bypassed

### For Production (ai-platform)

1. **Design for constraints first** - Air-gap compatibility drives everything
2. **Namespace = classification boundary** - Simple, enforceable model
3. **Fail closed by default** - Network policies deny-all, explicit allows
4. **Audit everything** - CRDs + events + Splunk for compliance

---

## Further Reading

- **From Theory to Production**: [./from-theory-to-production.md](./from-theory-to-production.md)
- **The 12 Factors**: [../../factors/README.md](../../factors/README.md)
- **Factor III Implementation Patterns**: [../../factors/03-focused-agents.md#implementation-patterns](../../factors/03-focused-agents.md#implementation-patterns)
- **Factor VI Implementation Patterns**: [../../factors/06-resume-work.md#implementation-patterns](../../factors/06-resume-work.md#implementation-patterns)
- **Factor VII Implementation Patterns**: [../../factors/07-smart-routing.md#implementation-patterns](../../factors/07-smart-routing.md#implementation-patterns)
- **Factor VIII Implementation Patterns**: [../../factors/08-human-validation.md#implementation-patterns](../../factors/08-human-validation.md#implementation-patterns)
- **Factor XI Implementation Patterns**: [../../factors/11-fail-safe-checks.md#implementation-patterns](../../factors/11-fail-safe-checks.md#implementation-patterns)
- **Factor XII Implementation Patterns**: [../../factors/12-package-patterns.md#implementation-patterns](../../factors/12-package-patterns.md#implementation-patterns)

---

**Version:** 1.0.0
**Last Updated:** 2025-12-27
**Status:** Living document (evolves with production learnings)

---

*The patterns in 12-Factor AgentOps aren't theoretical—they're battle-tested. Houston proved simplicity. Fractal proved Kubernetes-native. ai-platform proved production at scale. This heritage informs every Implementation Pattern in the framework.*
