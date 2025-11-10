# /observe-metrics - Quick Metrics Analysis

**Quick analysis of service health using golden signals**

This slash command provides a rapid overview of service health based on Google SRE's Four Golden Signals: Latency, Traffic, Errors, and Saturation.

---

## Purpose

**Use this command when:**
- Starting your shift (morning health check)
- Investigating vague reports ("something feels slow")
- Weekly reliability reviews
- Before/after deployments (health validation)
- On-call handoff (status summary)

**Time:** 2-5 minutes (vs 15-20 minutes manual dashboard review)

---

## Usage

```bash
# Basic usage (all services)
/observe-metrics

# Specific service
/observe-metrics --service=api

# Specific timerange
/observe-metrics --timerange=24h

# Multiple services
/observe-metrics --services=api,database,cache

# Custom threshold (alert if above)
/observe-metrics --latency-threshold=200ms
```

---

## What This Command Does

### 1. Queries Prometheus for Golden Signals

**Latency (P50, P95, P99):**
```promql
# P95 latency for all services
histogram_quantile(0.95,
  rate(http_request_duration_seconds_bucket[5m])
)
```

**Traffic (Requests per second):**
```promql
# Request rate for all services
rate(http_requests_total[5m])
```

**Errors (Error rate %):**
```promql
# Error rate (4xx + 5xx) for all services
100 * (
  rate(http_requests_total{code!~"2.."}[5m])
  /
  rate(http_requests_total[5m])
)
```

**Saturation (Resource utilization):**
```promql
# Average latency as saturation proxy
rate(http_request_duration_seconds_sum[5m])
/
rate(http_request_duration_seconds_count[5m])
```

### 2. Compares Against SLO Targets

**Example SLO comparison:**
```
Service: authentication-api
--------------------------
Latency (P95):
  Current: 180ms
  Target:  200ms
  Status:  ✅ Within SLO (10% headroom)

Traffic:
  Current: 1,250 req/s
  Baseline: 1,000 req/s
  Status:  ℹ️ 25% above baseline (normal variation)

Errors:
  Current: 0.05%
  Target:  0.1%
  Status:  ✅ Within SLO (50% headroom)

Saturation:
  CPU:    45%
  Memory: 60%
  Status:  ✅ Healthy (no bottlenecks)
```

### 3. Identifies Anomalies

**Anomaly detection:**
```
⚠️ Anomalies Detected

payment-service:
  - Latency P95 increased 50% (150ms → 225ms) in last 1 hour
  - Error rate elevated (0.1% → 0.3%) since 2025-11-09 10:30 UTC
  - Recommendation: Check recent deployments or dependency health

database-service:
  - CPU saturation trending up (65% → 78%) over last 6 hours
  - Projected to reach 80% threshold in 12 hours
  - Recommendation: Plan capacity increase or investigate query performance
```

### 4. Generates Health Summary

**Example output:**
```
🟢 Overall System Health: GOOD
----------------------------------

Services by Status:
  ✅ Healthy (7):  api, auth, payments, users, notifications, search, analytics
  ⚠️ Warning (2):  database (CPU trending up), cache (memory at 75%)
  🔴 Critical (0): None

SLO Compliance (Last 24h):
  - All services within SLO targets
  - Error budget consumption: 15% of monthly budget (healthy)
  - No SLO violations in last 24 hours

Top Action Items:
  1. Monitor database CPU trend (projected saturation in 12 hours)
  2. Investigate payment service latency increase (50% jump)
  3. Review cache memory usage (approaching 80% threshold)

Next Review: 2025-11-10 09:00 UTC (tomorrow morning)
```

---

## Example Scenarios

### Scenario 1: Monday Morning Health Check

**User invokes:**
```bash
/observe-metrics --timerange=7d
```

**Output:**
```
🟢 Weekly Health Summary (Last 7 Days)
---------------------------------------

Overall Trends:
  - Availability: 99.97% (Target: 99.9%) ✅
  - Latency (P95): 180ms avg (Target: 200ms) ✅
  - Error rate: 0.05% avg (Target: 0.1%) ✅
  - Traffic: 10M requests/day (baseline: 9.5M) ℹ️ +5%

Service-Specific:
  api-service:
    - ✅ All golden signals within SLO
    - ℹ️ Latency spike on Wed 11/06 (deployment, recovered)
    - No action needed

  database-service:
    - ⚠️ CPU utilization trending up (60% → 75% over 7 days)
    - ⚠️ Slow query count increased 20%
    - Action: Review query performance, consider scaling

  cache-service:
    - ✅ Healthy
    - ℹ️ Cache hit rate decreased 5% (93% → 88%)
    - Action: Investigate if cache warming needed

SLO Status:
  - Weekly error budget consumed: 8% (43.2 min budget, 3.5 min used)
  - On track for monthly SLO compliance

Top Recommendations:
  1. Database capacity planning (CPU trend concerning)
  2. Cache hit rate investigation (not critical, but worth checking)
  3. Continue monitoring (overall system healthy)
```

**Time saved:** 15 minutes (vs manually checking 10 service dashboards)

### Scenario 2: Deployment Health Check

**User invokes:**
```bash
/observe-metrics --service=api --timerange=1h
```

**Output:**
```
📊 API Service Health (Last 1 Hour)
------------------------------------

Deployment Detected:
  - Version: v2.5.1 → v2.5.2
  - Deployment started: 2025-11-09 10:15 UTC
  - Rollout complete: 2025-11-09 10:25 UTC (10 minutes)

Golden Signals (Post-Deployment):
  Latency (P95):
    - Before: 180ms
    - After:  175ms
    - Status: ✅ Improved by 3%

  Traffic:
    - Current: 1,250 req/s
    - Baseline: 1,200 req/s
    - Status: ✅ Normal (within 5% variance)

  Errors:
    - Before: 0.05%
    - After:  0.04%
    - Status: ✅ Stable (no regression)

  Saturation:
    - CPU: 42% → 40%
    - Memory: 55% → 55%
    - Status: ✅ No regression

Verdict: ✅ Deployment successful, no regressions detected

Recommendation: Monitor for next 2 hours, then mark deployment complete
```

**Time saved:** 5 minutes (vs manually comparing before/after metrics)

### Scenario 3: Investigating "Slow Reports"

**User invokes:**
```bash
/observe-metrics --service=reporting --timerange=4h
```

**Output:**
```
⚠️ Reporting Service Health (Last 4 Hours)
------------------------------------------

Anomaly Detected:
  - Latency P95 spiked at 10:30 UTC (200ms → 1.2s)
  - Latency remains elevated (current: 950ms)
  - Duration: 2 hours 15 minutes

Golden Signals Analysis:
  Latency:
    - P50: 450ms (baseline: 100ms) ⚠️ 4.5x increase
    - P95: 950ms (baseline: 200ms) ⚠️ 4.75x increase
    - P99: 1.8s  (baseline: 500ms) ⚠️ 3.6x increase
    - Status: 🔴 Degraded (violating SLO target: 500ms P95)

  Traffic:
    - Current: 50 req/s
    - Baseline: 45 req/s
    - Status: ✅ Normal (11% increase, not significant)

  Errors:
    - Current: 0.2%
    - Baseline: 0.1%
    - Status: ⚠️ Slightly elevated (but not critical)

  Saturation:
    - CPU: 65% (elevated from 40%)
    - Memory: 55% (normal)
    - Database connections: 85% of pool (high!)

Root Cause Hypothesis:
  1. Database connection pool saturation (85% utilization)
  2. Slow queries causing connection hold time increase
  3. Traffic increase (11%) pushing system toward capacity limit

Recommended Actions:
  1. Check slow query log (likely culprit)
  2. Review active database connections: `SELECT * FROM pg_stat_activity`
  3. Consider scaling reporting service (add replicas)
  4. Temporary: Increase connection pool size (quick mitigation)

SLO Impact:
  - 2h 15min of degraded performance = 5.2% of monthly error budget
  - Action needed to prevent further SLO consumption
```

**Time saved:** 10 minutes (vs manually investigating multiple dashboards)

---

## Parameters Reference

| Parameter | Description | Example | Default |
|-----------|-------------|---------|---------|
| `--service` | Single service to analyze | `--service=api` | All services |
| `--services` | Multiple services (comma-separated) | `--services=api,db,cache` | All services |
| `--timerange` | Time window to analyze | `--timerange=24h` | 1h |
| `--latency-threshold` | Alert if P95 exceeds (ms) | `--latency-threshold=200ms` | SLO target |
| `--error-threshold` | Alert if error rate exceeds (%) | `--error-threshold=1` | SLO target |
| `--format` | Output format | `--format=json` | text |

**Timerange values:**
- `5m`, `15m`, `30m`, `1h`, `6h`, `12h`, `24h`, `7d`, `30d`

---

## Integration with Agents

### With `slo-dashboard` Agent

**Workflow:**
1. `/observe-metrics` identifies anomaly (latency spike)
2. If investigation needed, switch to `slo-dashboard` agent
3. Agent creates detailed dashboard for deeper analysis

**Example:**
```bash
# Quick check
/observe-metrics --service=api

# Output shows latency spike
# ⚠️ Latency P95: 450ms (target: 200ms)

# Deep dive with agent
"Create detailed SLO dashboard for API service, focus on latency breakdown"
# Agent generates dashboard with:
#   - Latency by endpoint (which routes are slow?)
#   - Latency by region (geographic issue?)
#   - Latency by user cohort (specific users affected?)
```

### With `incident-response` Agent

**Workflow:**
1. `/observe-metrics` detects SLO violation
2. If incident declared, use `/analyze-incident` command
3. Metrics context automatically included in incident triage

**Example:**
```bash
# Quick check
/observe-metrics

# Output shows critical issue
# 🔴 Payment service: Error rate 5% (target: 0.1%)

# Declare incident
/analyze-incident
# "Payment service error rate 5%, users reporting failures"

# Agent uses metrics context for severity calculation
```

---

## Customization for Your Stack

### Datadog Instead of Prometheus

**Replace Prometheus queries with Datadog queries:**

```diff
- Prometheus query:
  histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

+ Datadog query:
  avg:http.request.duration{service:api}.as_count().rollup(avg, 60)
  # Then calculate P95 from distribution
```

### New Relic Instead of Prometheus

**Replace with NRQL queries:**

```diff
- Prometheus query:
  rate(http_requests_total{code!~"2.."}[5m])

+ NRQL query:
  SELECT percentage(count(*), WHERE httpResponseCode >= 400)
  FROM Transaction
  WHERE appName = 'api'
  SINCE 5 minutes ago
```

### Custom Metrics

**Add domain-specific golden signals:**

```bash
# Example: Video streaming service
/observe-metrics --custom-metrics=buffering_ratio,bitrate_avg,playback_errors

# Output includes:
# Buffering ratio: 2% (target: <5%) ✅
# Average bitrate: 4.5 Mbps (target: >3 Mbps) ✅
# Playback errors: 0.1% (target: <0.5%) ✅
```

---

## Troubleshooting

### "No data returned for service X"

**Possible causes:**
1. Service not instrumented (missing Prometheus metrics)
2. Service name mismatch (check `job` label in Prometheus)
3. Prometheus query syntax error

**Fix:**
```bash
# Check if service exports metrics
curl http://service-name:8080/metrics | grep http_requests_total

# Check Prometheus job name
curl http://prometheus:9090/api/v1/label/__name__/values | grep http_requests_total
```

### "SLO targets not found"

**Possible causes:**
1. SLO not defined for service (no `slos/service-name.yaml`)
2. SLO file format incorrect

**Fix:**
```bash
# Create SLO definition
cat > slos/service-name.yaml <<EOF
service: service-name
slo:
  availability: 99.9%
  latency_p95: 200ms
  error_rate: 0.1%
EOF
```

### "Anomaly detection false positives"

**Possible causes:**
1. Baseline calculated from too short timeframe
2. Normal variance flagged as anomaly

**Fix:**
```bash
# Use longer baseline for comparison
/observe-metrics --timerange=7d --baseline=30d

# Adjust sensitivity threshold
/observe-metrics --anomaly-threshold=2.0  # 2x increase required (default: 1.5x)
```

---

## Best Practices

### When to Use This Command

**✅ DO use for:**
- Quick health checks (morning standup, shift handoff)
- Deployment validation (before/after comparison)
- Triage (is issue real or perception?)
- Weekly reviews (trend identification)

**❌ DON'T use for:**
- Deep root cause analysis (use full dashboards)
- Historical analysis (use Grafana for multi-week trends)
- Alert investigation (use `/analyze-incident` for structured response)

### Interpreting Results

**Green (✅):**
- Metrics within SLO targets
- No action needed (but continue monitoring)

**Yellow (⚠️):**
- Metrics approaching SLO limits (70-90% of threshold)
- Investigation recommended (not urgent)
- Plan mitigation during business hours

**Red (🔴):**
- SLO violation or imminent
- Immediate action required
- Use `/analyze-incident` to declare incident

### Integration with Daily Workflow

**Morning routine:**
```bash
# 1. Health check
/observe-metrics --timerange=24h

# 2. Review anomalies
# (If any found, investigate with detailed dashboard)

# 3. Check error budget
/observe-metrics --slo-status

# 4. Report to team (standup)
# "All services green, payment latency trending up (75% of SLO), monitoring"
```

**Before deployment:**
```bash
# 1. Capture baseline
/observe-metrics --service=api > before-deploy.txt

# 2. Deploy

# 3. Compare post-deployment
/observe-metrics --service=api > after-deploy.txt
diff before-deploy.txt after-deploy.txt

# 4. Validate no regressions
```

---

## Related Commands

- `/analyze-incident` - Declare and triage incidents
- `/slo-dashboard` - Create detailed SLO dashboards (agent)
- `/postmortem` - Run blameless postmortem (agent)

---

## Version & Changelog

**Version:** 1.0.0
**Last Updated:** 2025-11-09

**Changelog:**
- v1.0.0 (2025-11-09): Initial release
  - Golden signals analysis (latency, traffic, errors, saturation)
  - SLO comparison and compliance
  - Anomaly detection
  - Multi-service support

**Roadmap:**
- v1.1.0: ML-based anomaly detection (reduce false positives)
- v1.2.0: Automatic root cause hypothesis (suggest likely causes)
- v1.3.0: Integration with ChatOps (Slack notifications)

---

## Learning Resources

**Google SRE Book:**
- [Monitoring Distributed Systems](https://sre.google/sre-book/monitoring-distributed-systems/)
- [The Four Golden Signals](https://sre.google/sre-book/monitoring-distributed-systems/#xref_monitoring_golden-signals)

**Prometheus:**
- [Querying Basics](https://prometheus.io/docs/prometheus/latest/querying/basics/)
- [Best Practices](https://prometheus.io/docs/practices/naming/)

---

**Ready to check your service health?**

Run `/observe-metrics` to get a quick overview of all services, or `/observe-metrics --service=api` to focus on a specific service.

**Quick insights, fast decisions. Golden signals for SRE success.**
