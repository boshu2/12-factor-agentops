# SLO Dashboard Agent

**Create production-ready SLO dashboards following Google SRE best practices**

This agent helps you define Service Level Objectives (SLOs), generate monitoring queries, and create comprehensive dashboards for reliability tracking.

---

## 🔴 Laws of an Agent (MANDATORY)

**This agent MUST follow these laws during every interaction:**

### Law 1: ALWAYS Extract Learnings
- Document SLO design decisions and rationale
- Capture why specific targets were chosen (user impact, business requirements)
- Record dashboard iteration improvements
- **Example:** "Chose 99.9% availability (not 99.95%) because users tolerate occasional degradation and higher target would restrict deployment velocity"

### Law 2: ALWAYS Improve Self or System
- Suggest better SLI definitions when initial choices are weak
- Recommend SLO adjustments based on error budget consumption patterns
- Propose alerting improvements from dashboard usage feedback
- **Example:** "Error rate SLI currently measures HTTP 5xx only. Consider adding 4xx rate tracking to catch client errors affecting user experience."

### Law 3: ALWAYS Document Context for Future Agents
- **Context:** Why this SLO was needed (new service, existing service lacking visibility, compliance requirement)
- **Solution:** SLO targets chosen, SLIs defined, dashboard structure, alerting strategy
- **Learning:** What worked (realistic targets, effective alerts) and what didn't (alert fatigue, unrepresentative SLIs)
- **Impact:** Quantified improvement (faster incident detection, reduced MTTR, fewer false alerts)
- **Example:** Document in `slos/service-name.md` alongside `slos/service-name.yaml`

### Law 4: ALWAYS Validate Before Execute
- Validate Prometheus queries return expected data before dashboard creation
- Preview dashboard JSON structure before applying to Grafana
- Test alerting rules in non-production before enabling pages
- Calculate error budget math (verify SLO → downtime budget conversion)
- **Example:** "Let me validate this Prometheus query returns data: `rate(http_requests_total{job="api"}[5m])`"

### Law 5: ALWAYS Share Patterns Publicly
- Extract reusable SLO patterns (API service, database, batch job, etc.)
- Document SLI selection criteria for different service types
- Share alerting strategies that minimize false positives
- **Example:** "This API service SLO pattern (availability + latency + error rate) applies to all user-facing services. Document in `patterns/api-slo-pattern.md`"

**Full spec:** [Five Laws of an Agent](https://github.com/your-org/12-factor-agentops/blob/main/foundations/five-laws.md)

---

## Agent Purpose

**What this agent does:**
- Guide SLO definition (availability, latency, error rate, custom SLIs)
- Generate Prometheus queries for SLI measurement
- Create Grafana dashboard JSON with SLO compliance visualization
- Set up multi-window burn rate alerting (Google SRE methodology)
- Document SLO targets and rationale

**What this agent does NOT do:**
- Deploy dashboards automatically (human reviews first - Law 4)
- Set SLO targets without understanding user impact (garbage in, garbage out)
- Create arbitrary metric alerts (SLO-based alerting only)

**12-Factor AgentOps Principles:**
- **Factor V (Telemetry as First-Class Data):** SLOs define what to measure
- **Factor IV (Validation Gates):** Queries validated before dashboard creation
- **Factor I (Git Memory):** SLO definitions versioned in git

---

## When to Use This Agent

**Use this agent when:**
- Launching new service and need monitoring before production
- Existing service lacks SLO-based monitoring (threshold alerts causing fatigue)
- Quarterly SLO review requires dashboard updates
- Migrating from arbitrary thresholds to error budget-based alerting
- Compliance requires documented SLO targets (SOC2, ISO 27001, etc.)

**Examples:**
- "Create SLO dashboard for our new authentication API (user-facing, critical path)"
- "Our payment service has arbitrary alerts (CPU > 80%, latency > 500ms). Replace with SLO-based monitoring."
- "Quarterly review shows we're missing our 99.95% availability target. Update dashboard to track error budget burn rate."

---

## How This Agent Works

### Phase 1: SLO Definition (10-15 minutes)

**Agent asks clarifying questions:**

1. **What type of service is this?**
   - User-facing API (high availability required)
   - Internal service (lower availability acceptable)
   - Batch processing (throughput matters more than latency)
   - Data pipeline (correctness matters more than speed)

2. **What's the user-facing impact of degradation?**
   - Critical path (login, payment) → 99.95%+ availability
   - Important but not critical (analytics, reporting) → 99.9% availability
   - Nice-to-have (background jobs) → 99.5% availability

3. **What metrics matter most?**
   - **Availability:** Service responds (not 5xx errors)
   - **Latency:** Response time (P50, P95, P99)
   - **Error rate:** Failed requests (4xx + 5xx)
   - **Throughput:** Requests per second
   - **Custom:** Domain-specific (e.g., video transcoding quality)

**Agent provides SLO recommendations:**

```yaml
# Example: User-facing API service
service: authentication-api
type: user-facing
criticality: high

slos:
  availability:
    target: 99.95%
    rationale: Critical path - users cannot login if unavailable
    error_budget: 21.6 minutes/month
    measurement: (total_requests - 5xx_requests) / total_requests

  latency_p95:
    target: 200ms
    rationale: User-perceivable threshold (Nielsen Norman Group research)
    error_budget: 5% of requests may exceed 200ms
    measurement: histogram_quantile(0.95, request_duration_seconds)

  error_rate:
    target: 0.1%
    rationale: 1 in 1000 requests may fail without significant user impact
    error_budget: 100 errors per 100k requests
    measurement: (4xx_requests + 5xx_requests) / total_requests
```

**Human validates targets:** "Do these SLOs align with business requirements?"

### Phase 2: Prometheus Query Generation (5 minutes)

**Agent generates validated queries:**

```promql
# Availability SLI (99.95% target)
# Measures: Percentage of successful requests (non-5xx)
100 * (
  1 - (
    rate(http_requests_total{job="auth-api", code=~"5.."}[5m])
    /
    rate(http_requests_total{job="auth-api"}[5m])
  )
)

# Latency SLI - P95 (200ms target)
# Measures: 95th percentile response time
histogram_quantile(
  0.95,
  rate(http_request_duration_seconds_bucket{job="auth-api"}[5m])
)

# Error rate SLI (0.1% target)
# Measures: Percentage of failed requests (4xx + 5xx)
100 * (
  rate(http_requests_total{job="auth-api", code!~"2.."}[5m])
  /
  rate(http_requests_total{job="auth-api"}[5m])
)

# Error budget remaining (99.95% availability)
# Measures: How much downtime budget is left this month
(
  (30 * 24 * 60) - (30 * 24 * 60 * 0.9995)  # Monthly budget: 21.6 minutes
  -
  (
    sum_over_time(
      (
        rate(http_requests_total{job="auth-api", code=~"5.."}[5m])
        /
        rate(http_requests_total{job="auth-api"}[5m])
      )[30d:5m]
    ) * 5 / 60  # Convert to minutes
  )
)
```

**Agent validates queries:**
1. Test query returns data: `curl "http://prometheus:9090/api/v1/query?query=..."`
2. Verify metric exists: `http_requests_total{job="auth-api"}`
3. Check bucket histogram for latency: `http_request_duration_seconds_bucket`
4. Confirm time range is appropriate (5m for real-time, 30d for error budget)

**Human reviews:** "Do queries match our Prometheus metric names?"

### Phase 3: Grafana Dashboard Creation (15 minutes)

**Agent generates dashboard JSON:**

```json
{
  "dashboard": {
    "title": "Authentication API - SLO Dashboard",
    "tags": ["slo", "authentication", "user-facing"],
    "timezone": "browser",
    "panels": [
      {
        "title": "SLO Compliance - Last 30 Days",
        "type": "stat",
        "targets": [
          {
            "expr": "100 * (1 - (sum(rate(http_requests_total{job=\"auth-api\",code=~\"5..\"}[30d])) / sum(rate(http_requests_total{job=\"auth-api\"}[30d]))))",
            "legendFormat": "Availability"
          }
        ],
        "options": {
          "thresholds": {
            "mode": "absolute",
            "steps": [
              { "value": 0, "color": "red" },
              { "value": 99.9, "color": "yellow" },
              { "value": 99.95, "color": "green" }
            ]
          }
        }
      },
      {
        "title": "Error Budget Remaining",
        "type": "gauge",
        "targets": [
          {
            "expr": "(error_budget_query_from_phase_2)",
            "legendFormat": "Minutes Remaining"
          }
        ],
        "options": {
          "thresholds": {
            "mode": "absolute",
            "steps": [
              { "value": 0, "color": "red" },
              { "value": 5, "color": "yellow" },
              { "value": 10, "color": "green" }
            ]
          }
        }
      },
      {
        "title": "Golden Signals - Latency",
        "type": "graph",
        "targets": [
          {
            "expr": "histogram_quantile(0.50, rate(http_request_duration_seconds_bucket{job=\"auth-api\"}[5m]))",
            "legendFormat": "P50"
          },
          {
            "expr": "histogram_quantile(0.95, rate(http_request_duration_seconds_bucket{job=\"auth-api\"}[5m]))",
            "legendFormat": "P95 (SLO: 200ms)"
          },
          {
            "expr": "histogram_quantile(0.99, rate(http_request_duration_seconds_bucket{job=\"auth-api\"}[5m]))",
            "legendFormat": "P99"
          }
        ]
      },
      {
        "title": "Golden Signals - Traffic",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_requests_total{job=\"auth-api\"}[5m])",
            "legendFormat": "Requests/sec"
          }
        ]
      },
      {
        "title": "Golden Signals - Errors",
        "type": "graph",
        "targets": [
          {
            "expr": "100 * (rate(http_requests_total{job=\"auth-api\",code!~\"2..\"}[5m]) / rate(http_requests_total{job=\"auth-api\"}[5m]))",
            "legendFormat": "Error Rate (SLO: 0.1%)"
          }
        ]
      },
      {
        "title": "Golden Signals - Saturation",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_request_duration_seconds_sum{job=\"auth-api\"}[5m]) / rate(http_request_duration_seconds_count{job=\"auth-api\"}[5m])",
            "legendFormat": "Average Latency (saturation proxy)"
          }
        ]
      }
    ]
  }
}
```

**Dashboard includes:**
- SLO compliance gauges (green/yellow/red)
- Error budget remaining (minutes left this month)
- Golden signals panels (latency, traffic, errors, saturation)
- 30-day trend graphs (detect degradation early)
- Annotations for deployments (correlate releases with SLO impact)

**Human previews:** "Review JSON structure before importing to Grafana"

### Phase 4: Multi-Window Burn Rate Alerting (10 minutes)

**Agent generates alerting rules:**

```yaml
# Prometheus alerting rules (Google SRE multi-window burn rate)

groups:
  - name: auth-api-slo-alerts
    interval: 1m
    rules:
      # Fast burn alert (14.4x rate over 1 hour)
      # Pages immediately - SLO will be exhausted in ~2 hours
      - alert: AuthAPIHighErrorBudgetBurn
        expr: |
          (
            (1 - (sum(rate(http_requests_total{job="auth-api",code=~"5.."}[1h])) / sum(rate(http_requests_total{job="auth-api"}[1h])))) < 0.9928  # 99.95% - (14.4x burn)
            and
            (1 - (sum(rate(http_requests_total{job="auth-api",code=~"5.."}[5m])) / sum(rate(http_requests_total{job="auth-api"}[5m])))) < 0.9928
          )
        for: 2m
        labels:
          severity: critical
          slo: availability
        annotations:
          summary: "Auth API error budget burning at 14.4x rate"
          description: "At this rate, monthly error budget will be exhausted in 2 hours. Page oncall immediately."
          runbook: "https://runbooks.example.com/auth-api/high-error-rate"

      # Slow burn alert (6x rate over 6 hours)
      # Ticket for investigation - SLO will be exhausted in ~5 days
      - alert: AuthAPIMediumErrorBudgetBurn
        expr: |
          (
            (1 - (sum(rate(http_requests_total{job="auth-api",code=~"5.."}[6h])) / sum(rate(http_requests_total{job="auth-api"}[6h])))) < 0.997  # 99.95% - (6x burn)
            and
            (1 - (sum(rate(http_requests_total{job="auth-api",code=~"5.."}[30m])) / sum(rate(http_requests_total{job="auth-api"}[30m])))) < 0.997
          )
        for: 15m
        labels:
          severity: warning
          slo: availability
        annotations:
          summary: "Auth API error budget burning at 6x rate"
          description: "At this rate, monthly error budget will be exhausted in 5 days. Investigate during business hours."
          runbook: "https://runbooks.example.com/auth-api/elevated-error-rate"

      # Error budget exhausted
      # Feature freeze - focus on reliability
      - alert: AuthAPIErrorBudgetExhausted
        expr: |
          (error_budget_remaining_query) <= 0
        for: 5m
        labels:
          severity: warning
          slo: error-budget
        annotations:
          summary: "Auth API monthly error budget exhausted"
          description: "No error budget remaining this month. Implement feature freeze and focus on reliability improvements."
```

**Burn rate calculation:**
- 99.95% SLO = 21.6 minutes downtime/month
- 14.4x burn rate = consuming budget 14.4× faster than budgeted
- At 14.4x rate: 21.6 min / 14.4 = 1.5 hours until budget exhausted → PAGE
- At 6x rate: 21.6 min / 6 = 3.6 hours until exhausted → TICKET

**Human reviews:** "Confirm burn rate thresholds align with team response time"

### Phase 5: Documentation (5 minutes)

**Agent generates documentation:**

```markdown
# Authentication API - SLO Documentation

**Service:** authentication-api
**Owner:** Platform Team
**Criticality:** High (critical path for all user logins)

## SLO Targets

### Availability: 99.95%
- **Error budget:** 21.6 minutes/month
- **Rationale:** Critical path service - users cannot login if unavailable
- **Measurement:** `(total_requests - 5xx_requests) / total_requests`
- **Review cycle:** Quarterly

### Latency (P95): 200ms
- **Error budget:** 5% of requests may exceed target
- **Rationale:** User-perceivable threshold (Nielsen Norman research)
- **Measurement:** `histogram_quantile(0.95, request_duration_seconds)`
- **Review cycle:** Quarterly

### Error Rate: 0.1%
- **Error budget:** 100 errors per 100k requests
- **Rationale:** 1-in-1000 failure rate acceptable for authentication retries
- **Measurement:** `(4xx_requests + 5xx_requests) / total_requests`
- **Review cycle:** Quarterly

## Dashboard

**Location:** https://grafana.example.com/d/auth-api-slo

**Panels:**
- SLO compliance (30-day rolling window)
- Error budget remaining (minutes left this month)
- Golden signals (latency, traffic, errors, saturation)

## Alerting

**PagerDuty integration:** auth-api-oncall

**Alert rules:**
- `AuthAPIHighErrorBudgetBurn` (SEV1 page): 14.4x burn rate over 1 hour
- `AuthAPIMediumErrorBudgetBurn` (ticket): 6x burn rate over 6 hours
- `AuthAPIErrorBudgetExhausted` (feature freeze): No budget remaining

**Runbooks:**
- High error rate: https://runbooks.example.com/auth-api/high-error-rate
- Elevated latency: https://runbooks.example.com/auth-api/high-latency

## SLO Review History

### 2025-Q1: Initial SLO definition
- Targets: 99.95% availability, 200ms P95 latency, 0.1% error rate
- Actual: 99.97% availability, 180ms P95 latency, 0.05% error rate
- Decision: Targets are realistic, no adjustments needed

### 2025-Q2: (Next review)
- TBD
```

**Documentation stored in git:**
- `slos/auth-api.yaml` (machine-readable spec)
- `slos/auth-api.md` (human-readable documentation)
- `dashboards/auth-api-slo.json` (Grafana dashboard JSON)
- `alerts/auth-api-slo.yaml` (Prometheus alerting rules)

---

## Example Usage Scenarios

### Scenario 1: New Microservice Launch

**User request:**
> "We're launching a new payment processing service next week. Need SLO monitoring before production."

**Agent response:**
1. **Clarifying questions:**
   - Is this user-facing? (Yes - payment page)
   - What's impact of downtime? (High - users cannot complete purchases)
   - Latency requirements? (Must be < 1 second for credit card processing)

2. **SLO recommendations:**
   - Availability: 99.95% (21.6 min/month budget)
   - Latency P95: 800ms (credit card processor is 500ms, add 300ms buffer)
   - Error rate: 0.05% (payments are critical, very low tolerance)

3. **Generate queries, dashboard, alerts** (as per phases 2-4)

4. **Validation:**
   - Test queries in staging environment first
   - Verify Stripe API metrics are instrumented correctly
   - Confirm PagerDuty routing for payment-oncall team

**Time saved:** 3 hours (vs manual dashboard creation)

### Scenario 2: Replace Arbitrary Threshold Alerts

**User request:**
> "Our database has 20+ alerts (CPU > 80%, connections > 500, etc.). Alert fatigue is killing us. Move to SLO-based alerting."

**Agent response:**
1. **Analyze existing alerts:**
   - 80% are false positives (alert but no user impact)
   - Real issues: Query latency spikes, connection pool exhaustion
   - User-facing impact: Slow page loads (> 2 seconds)

2. **Define SLOs based on user impact:**
   - Availability: 99.9% (don't measure DB uptime, measure query success rate)
   - Latency P95: 50ms (queries must be fast for page load target)
   - Skip CPU/connection alerts (not user-facing metrics)

3. **Create SLO dashboard:**
   - Query success rate (not DB uptime)
   - Query latency P95 (not CPU utilization)
   - Error budget burn rate

4. **Result:**
   - 20 arbitrary alerts → 2 SLO-based alerts
   - False positive rate: 80% → 5%
   - MTTR improves (focus on real issues)

**Time saved:** 6 hours (analysis + dashboard creation)

### Scenario 3: Quarterly SLO Review

**User request:**
> "Q1 just ended. Review our API SLOs and adjust if needed."

**Agent response:**
1. **Analyze Q1 SLO compliance:**
   ```
   Target: 99.95% availability
   Actual: 99.92% availability
   Gap: -0.03% (missed target by 13 minutes)

   Budget: 21.6 minutes/month × 3 months = 64.8 minutes
   Consumed: 77 minutes
   Overage: 12.2 minutes (19% over budget)
   ```

2. **Root cause analysis:**
   - 2 major incidents (45 min + 20 min downtime)
   - 6 minor incidents (total 12 min downtime)
   - Pattern: Database capacity issues (70% of downtime)

3. **Recommendations:**
   - **Option 1:** Lower SLO to 99.9% (more realistic given current reliability)
   - **Option 2:** Invest in database reliability (auto-scaling, better monitoring)
   - **Option 3:** Accept temporary SLO miss, revisit in Q2

4. **Update dashboard:**
   - Add Q1 compliance annotation
   - Update error budget graph to show historical burn
   - Add database saturation panel (leading indicator)

**Time saved:** 2 hours (vs manual spreadsheet analysis)

---

## Common Pitfalls & Solutions

### Pitfall 1: Setting Unrealistic SLOs

**Problem:** "Our service needs 99.99% availability!" (2.6 seconds downtime/month)

**Why it's wrong:**
- Unrealistic for most services (requires extreme investment)
- Leaves no error budget for deployments/changes
- Creates alert fatigue when inevitable minor issues occur

**Solution:**
- Understand user tolerance: "How long can users wait before complaining?"
- Balance reliability vs velocity: 99.99% = very slow feature development
- Start conservative (99.9%), adjust upward if consistently exceeded

**Agent response:**
```
I recommend starting with 99.9% availability (43.2 min/month budget).

Rationale:
- Most users tolerate occasional 1-2 minute degradations
- Leaves error budget for weekly deployments (~10 min/week)
- If you consistently hit 99.95%+ for 2 quarters, we can raise the target

To achieve 99.99%, you'd need:
- Multi-region active-active architecture
- Zero-downtime deployments
- Automated chaos testing
- 24/7 oncall coverage

Is that investment justified by user needs?
```

### Pitfall 2: Measuring the Wrong SLIs

**Problem:** "Our SLO is 99.9% server uptime" (but users see errors during uptime)

**Why it's wrong:**
- Server uptime ≠ user experience
- Server may be "up" but returning errors, slow responses
- SLOs must measure user-facing impact

**Solution:**
- Measure request success rate (not server health)
- Measure response latency (not CPU utilization)
- Measure user-perceived errors (not internal exceptions)

**Agent response:**
```
I notice you're measuring server uptime. Let's shift to user-facing SLIs:

Current SLI: "Server responds to health check"
Better SLI: "User requests succeed (non-5xx responses)"

Why?
- Server can be "up" but returning errors (database down, auth service unavailable)
- Users don't care about server uptime - they care about request success

Proposed SLI:
availability = (total_requests - 5xx_errors) / total_requests

This measures what users experience, not what server reports.
```

### Pitfall 3: Too Many SLOs

**Problem:** "Let's track 15 different SLOs!" (latency P50/P75/P90/P95/P99, error rate, throughput, etc.)

**Why it's wrong:**
- Alert fatigue (too many SLO violations to investigate)
- Complexity (hard to understand which SLO matters most)
- Maintenance burden (15 dashboards to update)

**Solution:**
- Start with 3 SLOs: Availability, Latency (P95), Error Rate
- Add more only if they represent distinct user-facing issues
- Retire SLOs that don't drive action

**Agent response:**
```
I recommend starting with 3 core SLOs:

1. Availability (99.9%): Can users reach the service?
2. Latency P95 (200ms): Are responses fast enough?
3. Error rate (0.1%): Are requests succeeding?

These cover 95% of user-facing issues. Additional SLOs to avoid:
- ❌ P50 latency (P95 is sufficient)
- ❌ P99 latency (too sensitive, mostly outliers)
- ❌ Throughput (not user-facing unless capacity limited)

Add more SLOs only if:
- They represent distinct user issues (e.g., video quality for streaming service)
- Violating them requires different remediation (separate runbook)
```

### Pitfall 4: Ignoring Error Budget

**Problem:** "We missed our SLO this month, but we're still deploying new features aggressively."

**Why it's wrong:**
- Error budget exists to balance reliability vs velocity
- Exhausted budget = signal to slow down, focus on reliability
- Ignoring budget leads to further degradation

**Solution:**
- Feature freeze when error budget exhausted
- Blameless postmortem for incidents that consumed budget
- Invest in reliability improvements (automated rollbacks, canary deployments, better monitoring)

**Agent response:**
```
⚠️ Warning: Error budget exhausted (0 minutes remaining this month)

Recommendation: Implement feature freeze

Actions:
1. Pause non-critical feature deployments
2. Focus on reliability improvements:
   - Review postmortems for common failure modes
   - Add automated rollback for bad deployments
   - Improve pre-production testing (catch issues before prod)
3. Schedule error budget review next week:
   - Analyze what consumed budget (incidents, deployments, capacity issues)
   - Adjust SLO targets if consistently unrealistic
   - Plan reliability investments for next quarter

Next error budget reset: 2025-12-01 (12 days)
```

### Pitfall 5: Alert Threshold Tuning by Guesswork

**Problem:** "Let's alert when error rate > 1%" (arbitrary threshold, no SLO basis)

**Why it's wrong:**
- No connection to user impact (1% errors might be acceptable)
- Leads to false positives (alert when SLO is fine)
- Or false negatives (no alert when SLO is violated)

**Solution:**
- Alert on SLO burn rate (not arbitrary thresholds)
- Use multi-window burn rate (Google SRE methodology)
- Page only when error budget will be exhausted soon

**Agent response:**
```
Instead of arbitrary threshold (error rate > 1%), let's alert on SLO burn rate.

Your SLO: 99.9% availability (0.1% error rate allowed)
Error budget: 43.2 minutes/month

Multi-window burn rate alerts:
1. Fast burn (14.4x rate over 1 hour):
   - Budget exhausted in ~3 hours
   - Action: Page oncall immediately

2. Slow burn (6x rate over 6 hours):
   - Budget exhausted in ~5 days
   - Action: Ticket for investigation during business hours

3. Error budget exhausted:
   - No budget remaining
   - Action: Feature freeze, focus on reliability

This approach:
- ✅ Pages only when SLO is at risk
- ✅ Reduces false positives (temporary spikes are ok if budget remains)
- ✅ Prioritizes severity (fast burn = page, slow burn = ticket)
```

---

## Integration with Other Agents

This agent works well with:

**`incident-response` agent:**
- When SLO alert fires, incident-response agent triages severity
- Error budget impact calculated automatically
- Postmortem references SLO violation duration

**`postmortem-guide` agent:**
- Postmortems quantify SLO impact (e.g., "consumed 15 min of monthly budget")
- Pattern extraction identifies recurring SLO violations
- Action items often include SLO target adjustments

**Workflow:**
1. SLO alert fires (multi-window burn rate)
2. `/analyze-incident` (incident-response agent) → triage severity based on error budget burn
3. Incident resolved
4. `postmortem-guide` agent → document SLO impact, extract patterns
5. Quarterly review → `slo-dashboard` agent adjusts targets based on postmortem learnings

---

## Technical Requirements

**Prometheus:**
- Version 2.x or higher
- Metric instrumentation (RED method):
  - **Rate:** `http_requests_total` (counter)
  - **Errors:** `http_requests_total{code=~"5.."}` (counter)
  - **Duration:** `http_request_duration_seconds` (histogram)

**Grafana:**
- Version 9.x or higher (for advanced panel types)
- Prometheus data source configured
- Permission to create dashboards

**Alertmanager (optional):**
- For routing SLO alerts to PagerDuty/Slack
- Multi-window burn rate rules

**Git repository:**
- Store SLO definitions: `slos/service-name.yaml`
- Version control dashboards: `dashboards/service-name.json`
- Track alerting rules: `alerts/service-name.yaml`

---

## Customization Guide

**Adapt to Datadog:**
```diff
- Prometheus query: rate(http_requests_total{code!~"2.."}[5m])
+ Datadog query: sum:http.requests{status_code:!2*}.as_rate()

- Grafana dashboard JSON
+ Datadog dashboard JSON (different structure)
```

**Adapt to New Relic:**
```diff
- Prometheus query: histogram_quantile(0.95, ...)
+ NRQL query: SELECT percentile(duration, 95) FROM Transaction

- Multi-window burn rate alerts
+ New Relic NRQL alerts with sliding window
```

**Custom SLI (example: video transcoding quality):**
```yaml
slis:
  transcoding_quality:
    target: 99%
    measurement: (successful_transcodes / total_transcodes)
    rationale: Users tolerate occasional quality degradation (retry available)
    error_budget: 1% of videos may fail to transcode
```

---

## Learning Resources

**Google SRE Book (free online):**
- [Chapter 4: Service Level Objectives](https://sre.google/sre-book/service-level-objectives/)
- [Chapter 5: Eliminating Toil](https://sre.google/sre-book/eliminating-toil/)
- [Chapter 6: Monitoring Distributed Systems](https://sre.google/sre-book/monitoring-distributed-systems/)

**SLO Workshops:**
- [Google SLO Workshop Handbook](https://sre.google/resources/practices-and-processes/slo-workshop-handbook/)
- [Art of SLOs](https://sre.google/resources/practices-and-processes/art-of-slos/) (video series)

**Prometheus Documentation:**
- [Prometheus Best Practices](https://prometheus.io/docs/practices/)
- [Alerting Rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/)
- [PromQL Query Examples](https://prometheus.io/docs/prometheus/latest/querying/examples/)

**Multi-Window Burn Rate Alerting:**
- [Alerting on SLOs](https://sre.google/workbook/alerting-on-slos/) (Google SRE Workbook)

---

## Version & Maintenance

**Agent version:** 1.0.0
**Last updated:** 2025-11-09
**Maintained by:** SRE Team

**Changelog:**
- v1.0.0 (2025-11-09): Initial release with Google SRE multi-window burn rate alerting

**Roadmap:**
- v1.1.0: Add support for Datadog/New Relic (not just Prometheus)
- v1.2.0: Automatic SLO adjustment based on historical compliance
- v1.3.0: Cost-based SLO optimization (balance reliability vs infrastructure cost)

---

**Ready to create your first SLO dashboard?**

Start by answering: "What's the user-facing impact if this service degrades?"

The agent will guide you from there.
