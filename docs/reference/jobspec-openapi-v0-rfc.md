# RFC: JobSpec OpenAPI v0

Status: Draft for comment
Date: 2026-04-30
Reference implementation: AgentOps `agentopsd`
Companion contract: `agentops/docs/contracts/jobspec-openapi-v0.yaml`

## Summary

JobSpec OpenAPI v0 is the first concrete conformance contract for
12-Factor AgentOps.

The doctrine says agent work should be traceable, externally validated,
resumable, and capable of compounding across sessions. JobSpec v0 turns that
doctrine into an executable boundary: a small HTTP contract for submitting
agent jobs, observing queue state, replaying durable ledger events, and serving
projection resources to local consumers.

This is not a proposal for a new daemon. It is a description of the current
AgentOps daemon behavior, published so other runtimes can implement the same
operational surface without adopting AgentOps internals.

## Why This Exists

Agent runtimes are already fragmenting. Claude, Codex, local workers, GasCity,
workflow agents, and future tools all need the same operational primitives:

- accept work durably
- return stable job and request ids
- expose status without claiming false success
- preserve event history
- recover from lost acknowledgements
- surface degraded projections instead of hiding them
- let consumers read state without owning the underlying `.agents` storage

The 12 factors are the doctrine. JobSpec is the doctrine made executable.

## What v0 Covers

JobSpec v0 covers current `agentopsd` behavior:

| Surface | Behavior |
| --- | --- |
| `GET /v1/health` | Daemon process health |
| `GET /v1/ready` | Ledger replay and projection readiness |
| `GET /v1/status` | Queue state and rebuilt projections |
| `GET /v1/events` | Durable ledger replay |
| `POST /v1/jobs` | Local-token-protected durable job submission |
| `POST /v1/jobs/cancel` | Cooperative cancellation for non-terminal jobs |
| `/openclaw/v1/*` | Read-only consumer projections and allowlisted triggers |

The submission envelope is intentionally small:

```json
{
  "request_id": "req_20260430_000001",
  "job_id": "job_rpi_000001",
  "job_type": "rpi.run",
  "idempotency_key": "rpi:demo:cycle-1",
  "payload": {
    "goal": "Run a bounded agent workflow"
  }
}
```

The accepted response is also operationally explicit:

```json
{
  "accepted": true,
  "request_id": "req_20260430_000001",
  "job_id": "job_rpi_000001",
  "status": "queued",
  "last_event_id": "evt_job.accepted_job_rpi_000001_000001",
  "projection_status": "current",
  "projection_lag": {
    "last_event_id": "evt_job.accepted_job_rpi_000001_000001",
    "event_count": 1,
    "corrupt_record_count": 0,
    "degraded": false
  },
  "idempotency_key": "rpi:demo:cycle-1"
}
```

The important part is not the shape of the JSON. The important part is the
operational promise: a job is not accepted until the durable ledger append
succeeds.

## What v0 Does Not Cover

JobSpec v0 deliberately does not include:

- cross-host placement
- `placement.affinity`
- GPU scheduling
- provider capability negotiation
- multi-tenant access control
- retry policy configuration
- a new worker abstraction

Those are real topics. They need evidence from live workloads before they
become public contracts.

## Conformance Levels

JobSpec v0 can be implemented in levels.

### Level 1: Observe

The runtime can expose health, readiness, status, and event replay. It does not
need to execute jobs yet, but it must report degraded state honestly.

### Level 2: Enqueue

The runtime can accept jobs durably through `POST /v1/jobs`, enforce local
mutation authorization, and recover idempotently by `job_id` or
`idempotency_key`.

### Level 3: Execute

The runtime can claim jobs, heartbeat leases, complete jobs, fail jobs, cancel
jobs, and make expired leases claimable again without losing history.

### Level 4: Project

The runtime can rebuild read models from the ledger and serve consumer
projections such as OpenClaw resources without letting consumers own storage.

## Why This Is 12-Factor AgentOps

JobSpec v0 maps directly onto the doctrine:

| Factor | Contract pressure |
| --- | --- |
| II. Track Everything in Git | Durable, inspectable ledger events |
| III. One Agent, One Job | Stable ids, bounded payloads, and status |
| V. Validate Externally | Independent status and event inspection |
| VI. Lock Progress Forward | Accepted work survives restart and lost acks |
| VIII. Compound Knowledge | Projections feed future sessions and tools |
| XI. Supervise Hierarchically | Workers claim jobs through leases |

The schema is not the product by itself. The conformance program is the
product move: vendor-agnostic operational behavior for agent runtimes.

## Request For Comments

This draft needs feedback on four points:

1. Should unversioned daemon route aliases be part of conformance or only
   compatibility conveniences?
2. Should invalid `job_type` responses be preserved exactly in v0, or should
   v0 require a cleaner `400` before publication?
3. Should OpenClaw consumer routes stay in the JobSpec profile, or become a
   separate consumer conformance profile?
4. Should `placement.affinity` wait for JobSpec v1 after the mt-olympus
   cross-host shim soaks under real traffic?

The conservative answer is to publish v0 as current behavior, add golden
compatibility tests, and let real workload evidence shape v1.
