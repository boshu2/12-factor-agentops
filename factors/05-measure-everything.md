# Factor V: Measure Everything

**Metrics, logs, and observability for every agent run**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | DevOps + SRE |
| **Supporting Pillar** | Learning Science |
| **Enforces Laws** | Law 1 (Extract Learnings), Law 2 (Improve System) |
| **Derived From** | SRE observability + Metrics-driven improvement + Data-informed decisions |

📘 **[See complete derivation →](../ARCHITECTURE.md#factor-v-operational-telemetry)**

---

## Summary

You can't improve what you don't measure. Every agent execution must emit metrics (latency, success rate, resource usage), logs (what happened), and traces (workflow steps). Telemetry enables data-driven decisions, failure analysis, and continuous improvement.

## The Problem

Agents without telemetry:
- Fail silently with no trace
- Can't measure improvement over time
- Have no data for debugging
- Make decisions based on intuition, not data
- Can't identify performance bottlenecks

**Familiar pattern:**
```
Agent runs → Something breaks
User: "What went wrong?"
Agent: ¯\_(ツ)_/¯
```

**Traditional approach:** "It worked on my machine"

**12-Factor AgentOps approach:** Comprehensive telemetry for every execution

---

## Why This Factor Exists

### Grounding in the Four Pillars

**Primary: DevOps + SRE**

Operational telemetry comes from SRE observability practices and the Four Golden Signals (latency, traffic, errors, saturation). Google's SRE book teaches that "hope is not a strategy"—data-driven decisions beat intuition every time. Without metrics, you can't measure improvement. Without logs, you can't debug failures. Without traces, you can't identify bottlenecks.

SRE wisdom says "you can't improve what you don't measure." For AI agents, this means every execution must emit telemetry: how long did it take? Did it succeed? How much context did it use? What errors occurred? The data reveals patterns invisible to humans—85% of failures happen in the implementation phase, 95th percentile context utilization is 38%—enabling targeted improvements.

**Supporting: Knowledge OS**

Knowledge OS requires telemetry for institutional memory. Git captures decisions (commits), but telemetry captures execution (runtime behavior). Together they form complete memory: what was decided + what actually happened. Telemetry feeds the improvement backlog (Factor X), revealing which patterns work and which don't. This creates a feedback loop where the system learns from its own execution history.

---

## What This Factor Enforces

### Law 1: Extract Learnings

Telemetry enforces learning extraction by making patterns visible. Without telemetry, learnings are subjective ("it felt slow"). With telemetry, learnings are quantified ("research phase averages 45 seconds, 95th percentile is 120 seconds"). Metrics reveal which workflows succeed most often, which agents are fastest, which validation gates catch the most errors.

**Concrete example:** Telemetry shows that 85% of failures occur in the implementation phase → Extract learning: "Add validation gate before implementation" → Implement improvement → Validation gate prevents 90% of subsequent failures. The telemetry made the learning possible.

### Law 2: Improve System

Telemetry drives continuous improvement by identifying optimization opportunities. The improvement backlog (Factor X) is fed by telemetry: slow executions → performance improvements, high error rates → quality improvements, context overruns → efficiency improvements.

**Concrete example:** Telemetry dashboard shows research phase takes 30 seconds, mostly loading full documentation. Improvement identified: "Load only relevant sections based on task keywords." Implementation reduces loading to 5 seconds. Improvement measured: 25-second savings per workflow, 10 workflows/day = 250 seconds/day saved. ROI: 2 hours investment pays back in 29 days.

Without telemetry, you'd never know what to improve. With telemetry, the system tells you exactly where optimization opportunities exist and proves when improvements work.

---

## The Principle

### The Three Pillars of Observability

**1. Metrics** (quantitative data)
- Success rate
- Execution time
- Resource utilization (tokens, memory, CPU)
- Error rate

**2. Logs** (event streams)
- What actions occurred
- What decisions were made
- What errors happened
- Context at each step

**3. Traces** (request paths)
- End-to-end workflow execution
- Phase-by-phase breakdown
- Agent-to-agent handoffs
- Bottleneck identification

### The Four Golden Signals (from Google SRE)

**1. Latency**: How long did it take?
```
Research phase: 45s
Plan phase: 30s
Implement phase: 120s
Total: 195s (3m 15s)
```

**2. Traffic**: How much load?
```
Total executions today: 42
Peak executions/hour: 12
Average executions/hour: 5
```

**3. Errors**: What failed?
```
Success rate: 95% (190/200)
Validation failures: 3%
Timeout failures: 1%
Unknown failures: 1%
```

**4. Saturation**: How close to limits?
```
Context utilization: 35% (under 40% threshold ✅)
Token budget remaining: 65%
Memory usage: 45%
```

---

## Why This Works

### 1. SRE Observability Practices

**Google SRE wisdom:**
> "Hope is not a strategy. Data-driven decisions beat intuition every time."

**For AI agents:**
- Metrics reveal patterns invisible to humans
- Logs provide debugging breadcrumbs
- Traces show system behavior under load

### 2. Feedback Loops Enable Learning

**Learning Science principle:**
> "Feedback is the breakfast of champions"

**For AI agents:**
```
No telemetry:
  Execute → No data → No improvement → Stagnation

With telemetry:
  Execute → Collect data → Analyze patterns → Improve → Execute better
```

**Result:** Continuous improvement based on real data

### 3. Attribution and Accountability

**Problem:** "Which agent caused this failure?"

**Solution:** Telemetry provides attribution
```
2025-01-27 14:32:15 [research-agent] Started
2025-01-27 14:32:45 [research-agent] Completed (30s)
2025-01-27 14:32:46 [plan-agent] Started
2025-01-27 14:33:12 [plan-agent] ERROR: Invalid input format
```

**Result:** Clear accountability per agent

### 4. Capacity Planning

**Problem:** "Will this scale?"

**Solution:** Telemetry reveals capacity limits
```
Baseline: 5 executions/hour, 35% context utilization
10x traffic: 50 executions/hour → 350% context utilization → FAILURE

Action: Implement Factor II: Context Loading before scaling
```

---

## Implementation

### Metrics Collection

**Prometheus metrics** (example):
```python
from prometheus_client import Counter, Histogram, Gauge

# Counters
agent_executions = Counter(
    'agent_executions_total',
    'Total agent executions',
    ['agent_name', 'status']
)

agent_errors = Counter(
    'agent_errors_total',
    'Total agent errors',
    ['agent_name', 'error_type']
)

# Histograms
agent_duration = Histogram(
    'agent_duration_seconds',
    'Agent execution duration',
    ['agent_name', 'phase']
)

# Gauges
context_utilization = Gauge(
    'agent_context_utilization_percent',
    'Current context window utilization',
    ['agent_name']
)

# Usage in agent
class ResearchAgent:
    def execute(self, task):
        agent_executions.labels(agent_name='research', status='started').inc()
        start_time = time.time()

        try:
            result = self.research(task)

            # Record success
            duration = time.time() - start_time
            agent_duration.labels(agent_name='research', phase='execute').observe(duration)
            agent_executions.labels(agent_name='research', status='success').inc()
            context_utilization.labels(agent_name='research').set(self.get_context_usage())

            return result

        except Exception as e:
            # Record failure
            agent_errors.labels(agent_name='research', error_type=type(e).__name__).inc()
            agent_executions.labels(agent_name='research', status='failure').inc()
            raise
```

### Structured Logging

**JSON logging** (machine-readable):
```python
import logging
import json
from datetime import datetime

class StructuredLogger:
    def __init__(self, agent_name):
        self.agent_name = agent_name
        self.logger = logging.getLogger(agent_name)

    def log(self, level, message, **kwargs):
        log_entry = {
            'timestamp': datetime.utcnow().isoformat(),
            'agent': self.agent_name,
            'level': level,
            'message': message,
            **kwargs
        }
        self.logger.log(getattr(logging, level), json.dumps(log_entry))

# Usage
logger = StructuredLogger('research-agent')
logger.log('INFO', 'Research phase started', task_id='12345', phase='research')
logger.log('ERROR', 'API timeout', task_id='12345', error='TimeoutError', duration_ms=30000)
```

### Distributed Tracing

**OpenTelemetry tracing** (workflow visualization):
```python
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# Setup
trace.set_tracer_provider(TracerProvider())
tracer = trace.get_tracer(__name__)
span_processor = BatchSpanProcessor(OTLPSpanExporter())
trace.get_tracer_provider().add_span_processor(span_processor)

# Usage in workflow
def execute_workflow(task):
    with tracer.start_as_current_span("workflow") as workflow_span:
        workflow_span.set_attribute("task.id", task.id)

        # Research phase
        with tracer.start_as_current_span("research") as research_span:
            research_result = research_agent.execute(task)
            research_span.set_attribute("result.size", len(research_result))

        # Plan phase
        with tracer.start_as_current_span("plan") as plan_span:
            plan_result = plan_agent.execute(research_result)
            plan_span.set_attribute("plan.complexity", plan_result.complexity)

        # Implement phase
        with tracer.start_as_current_span("implement") as impl_span:
            impl_result = implement_agent.execute(plan_result)
            impl_span.set_attribute("files.changed", len(impl_result.files))

        return impl_result
```

### Telemetry Dashboard

**Grafana dashboard** (example queries):
```promql
# Success rate (last 24h)
sum(rate(agent_executions_total{status="success"}[24h]))
  /
sum(rate(agent_executions_total[24h]))

# Average execution time by agent
avg(agent_duration_seconds_sum / agent_duration_seconds_count) by (agent_name)

# Error rate by type
sum(rate(agent_errors_total[5m])) by (error_type)

# Context utilization (95th percentile)
histogram_quantile(0.95, agent_context_utilization_percent)
```

---

## Validation

### ✅ You're doing this right if:
- Every agent execution emits metrics
- Logs are structured and searchable
- Traces show end-to-end workflow paths
- Dashboards visualize key metrics
- Alerts fire on anomalies

### ❌ You're doing this wrong if:
- No metrics collection
- Logs are unstructured ("printf debugging")
- Can't trace failures to root cause
- Making decisions without data
- Reactive (fixing problems) instead of proactive (preventing them)

---

## Real-World Evidence

### Before Telemetry

**Problem diagnosis:**
```
User: "The agent failed"
Dev: "What failed?"
User: "I don't know, it just didn't work"
Dev: "What was the error?"
User: "There was no error message"
Dev: "What step did it fail on?"
User: "Not sure"

Result: 2 hours of guessing and reproducing the issue
```

### After Telemetry

**Problem diagnosis:**
```
User: "The agent failed"
Dev: *Checks dashboard*
  - Trace ID: abc-123
  - Failed at: plan-agent execution
  - Error: ValidationError: missing required field 'namespace'
  - Context: Task ID 456, triggered at 14:32:15 UTC
  - Root cause: Input from research-agent missing namespace

Result: 30 seconds to identify root cause, 5 minutes to fix
```

**Improvement:** 24x faster debugging

### Production Metrics (200+ Sessions)

**Telemetry revealed:**
- 85% of failures occur in implementation phase
- Average workflow takes 3m 15s
- 95th percentile context utilization: 38% (under 40% threshold ✅)
- Most common error: ValidationError (12%)
- Peak load: 12 executions/hour

**Actions taken based on data:**
1. Added validation gate before implementation (Factor IV)
2. Optimized implementation agents (reduced from 180s to 120s)
3. Improved input validation (ValidationError dropped from 12% to 3%)
4. Scaled infrastructure for 15 executions/hour (headroom for growth)

**Result:** Data-driven improvements, not guesswork

---

## Anti-Patterns

### ❌ The "Logging is Enough" Trap
**Wrong:** Only collect logs, no metrics
**Right:** Metrics + Logs + Traces (all three pillars)

### ❌ The "Too Much Data" Trap
**Wrong:** Log everything at DEBUG level (noise)
**Right:** Strategic logging at appropriate levels, sample high-volume data

### ❌ The "Manual Metrics" Trap
**Wrong:** Manually track metrics in spreadsheets
**Right:** Automated telemetry collection and aggregation

### ❌ The "No Retention Policy" Trap
**Wrong:** Keep all telemetry forever (storage costs)
**Right:** Aggregate old data, retain raw data for limited time (30-90 days)

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Git commits log decisions, telemetry logs execution
- **Factor IV: Continuous Validation**: Telemetry measures validation effectiveness
- **Factor VII: Resume Work**: Telemetry tracks multi-session workflows
- **Factor IX: Mine Patterns**: Telemetry data reveals patterns
- **Factor X: Small Iterations**: Telemetry drives improvement backlog

---

## Telemetry Design Patterns

### Pattern 1: Hierarchical Metrics

```
Workflow metrics (top-level)
├── Phase metrics (research, plan, implement)
├── Agent metrics (per agent execution)
└── Tool metrics (per tool invocation)
```

### Pattern 2: Correlation IDs

```python
import uuid

class Workflow:
    def __init__(self):
        self.correlation_id = str(uuid.uuid4())

    def execute(self, task):
        # All logs/metrics for this workflow share the same correlation_id
        logger.log('INFO', 'Workflow started', correlation_id=self.correlation_id)

        research_result = research_agent.execute(task, correlation_id=self.correlation_id)
        plan_result = plan_agent.execute(research_result, correlation_id=self.correlation_id)

        logger.log('INFO', 'Workflow completed', correlation_id=self.correlation_id)

# Query logs: WHERE correlation_id = 'abc-123'
# Result: All related log entries for that workflow
```

### Pattern 3: Telemetry-Driven Alerts

```yaml
# alerts.yml
groups:
  - name: agent_alerts
    rules:
      - alert: HighErrorRate
        expr: rate(agent_errors_total[5m]) > 0.05
        annotations:
          summary: "Agent error rate above 5%"

      - alert: ContextUtilizationHigh
        expr: agent_context_utilization_percent > 40
        annotations:
          summary: "Context utilization exceeds 40% threshold"

      - alert: SlowExecution
        expr: agent_duration_seconds > 300
        annotations:
          summary: "Agent execution taking longer than 5 minutes"
```

---

## Next Steps

1. **Instrument agents** with metrics, logs, and traces
2. **Set up collection infrastructure** (Prometheus, Loki, Jaeger)
3. **Create dashboards** for key metrics
4. **Define SLOs** (Service Level Objectives) for your workflows
5. **Set up alerts** for critical failures and anomalies

---

## Further Reading

- **DevOps + SRE Pillar**: [../foundations/four-pillars.md#pillar-1-devops--sre](../foundations/four-pillars.md#pillar-1-devops--sre)
- **Law 1 (Extract Learnings)**: [../foundations/five-laws.md](../foundations/five-laws.md#law-1)
- **Law 2 (Improve System)**: [../foundations/five-laws.md](../foundations/five-laws.md#law-2)
- **Pattern: Observability Stack**: [../patterns/observability-stack.md](../patterns/observability-stack.md) (TBD)

---

**Remember:** You can't improve what you don't measure. Telemetry turns "it failed" into "it failed at step 3 due to X, here's how to fix it." Data beats intuition every time.
