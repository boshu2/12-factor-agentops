# SRE Workflows - Day-in-the-Life Scenarios

**How 12-Factor AgentOps transforms daily SRE work**

This document shows real-world SRE scenarios and how the `.claude/` agents assist at each step.

---

## Workflow 1: Monday Morning - Weekly Reliability Review

**Context:** It's 9am Monday. You're the SRE on-call lead reviewing last week's metrics.

### Without AgentOps

**Manual process (90 minutes):**
1. Open Grafana, navigate to each service dashboard (10 services × 3 min = 30 min)
2. Check error rates, latency, saturation manually
3. Export screenshots to slides
4. Calculate SLO compliance for each service (10 × 4 min = 40 min)
5. Write summary email
6. Present to team in standup (15 min prep)

**Pain points:**
- Repetitive dashboard navigation
- Manual SLO math (error budget calculations)
- Risk of missing degraded services
- Time-consuming screenshot collection

### With AgentOps

**Assisted process (20 minutes):**

```bash
# 1. Quick golden signals check (2 minutes)
/observe-metrics --timerange=7d --services=all

# Agent returns:
# - Latency: API service P95 increased 15% (180ms → 207ms)
# - Traffic: Normal seasonal patterns
# - Errors: Database service error rate spiked Tuesday (0.05% → 0.2%)
# - Saturation: Redis memory at 78% (approaching 80% threshold)

# 2. Deep dive on concerning metrics (10 minutes)
"Generate SLO compliance report for last week, focus on API and database services"

# Agent:
# - Calculates error budget burn: API used 8% of monthly budget
# - Identifies Tuesday database incident consumed 15 minutes of budget
# - Suggests: "Redis capacity planning needed (projected full in 3 weeks)"

# 3. Generate standup summary (5 minutes)
"Create standup summary for reliability review"

# Agent generates:
# - One-slide overview (services green/yellow/red)
# - Top 3 action items (Redis scaling, database error investigation, API latency trend)
# - Links to relevant dashboards

# 4. Email team (3 minutes)
"Draft weekly reliability email"

# Agent produces ready-to-send email with:
# - Executive summary (1 paragraph)
# - SLO compliance table (all services)
# - Action items with owners
# - Links to detailed dashboards
```

**Time saved:** 70 minutes (78% reduction)

**Factors applied:**
- **Factor II (JIT Context):** Load only last 7 days of data
- **Factor V (Telemetry):** Golden signals prioritized automatically
- **Factor IX (Pattern Extraction):** Agent identifies trends (Redis capacity)

---

## Workflow 2: 2am Alert - Production Database Outage

**Context:** PagerDuty wakes you at 2am. Database replica lag alert firing.

### Without AgentOps

**Manual process (45 minutes to triage):**
1. Wake up, grab laptop (groggy, 5 min to focus)
2. Check PagerDuty alert → navigate to Grafana (2 min)
3. Try to remember: "What dashboard shows replica lag?" (3 min)
4. Find dashboard, see lag is 25 minutes (3 min)
5. Check runbook: "Where's the database runbook?" (5 min)
6. Follow runbook steps manually (15 min)
7. Decide severity, post to Slack (10 min)
8. Start investigating root cause (2 min, then realize you need coffee)

**Pain points:**
- Cognitive load at 2am (brain fog)
- Runbook discovery time
- Manual triage (what's affected?)
- Communication overhead (who to wake?)

### With AgentOps

**Assisted process (10 minutes to triage):**

```bash
# 1. Quick incident analysis (2 minutes)
/analyze-incident

# Paste alert text from PagerDuty:
# "Database replica lag > 10 minutes (current: 25m)"

# Agent immediately returns:
# - Severity: SEV2 (degraded read performance, writes unaffected)
# - Error budget impact: 25 minutes = 0.14% of monthly budget
# - Affected services: Analytics dashboard (read-only), reporting jobs
# - User impact: Moderate (internal tools only)
# - Investigation checklist:
#   1. Check primary database CPU/memory
#   2. Check replication logs for errors
#   3. Verify network connectivity between primary/replica
#   4. Check if large transaction is blocking replication

# 2. Generate incident communication (3 minutes)
"Draft Slack announcement for database replica lag incident"

# Agent produces:
# "🔴 SEV2 Incident: Database replica lag
#  - Impact: Analytics dashboard showing stale data (25min delay)
#  - User impact: Internal tools only, no customer-facing impact
#  - Investigating: Checking replication health and primary load
#  - Updates: Every 15 minutes in #incidents
#  - Incident commander: @oncall-sre"

# 3. Follow investigation steps (5 minutes)
# Agent pre-populated checklist, you execute:
# - Primary CPU: 45% (normal)
# - Replication logs: "waiting for WAL segment" (aha!)
# - Network: Healthy
# - Large transaction: Nightly analytics ETL still running (found it!)

# Root cause identified: ETL job overloaded WAL
```

**Time saved:** 35 minutes (78% reduction)

**More importantly:**
- Clear head at 2am (agent handles triage logic)
- No runbook hunting (investigation steps provided)
- Accurate severity classification (SLO-based, not guesswork)
- Professional communication (even when groggy)

**Factors applied:**
- **Factor II (JIT Context):** Only load relevant database metrics
- **Factor III (Single-Responsibility):** Incident agent focuses only on triage
- **Factor IV (Validation Gates):** Severity validated against SLO impact
- **Factor VI (Session Continuity):** Timeline auto-tracked for postmortem

---

## Workflow 3: Wednesday Afternoon - SLO Dashboard for New Service

**Context:** New microservice launching next week. Need monitoring before production.

### Without AgentOps

**Manual process (4 hours):**
1. Research: "What metrics should we track?" (30 min)
2. Write Prometheus queries for error rate, latency (45 min)
3. Create Grafana dashboard JSON manually (90 min)
4. Set up alerting rules (60 min)
5. Test dashboard with synthetic data (15 min)
6. Document SLO targets in wiki (20 min)

**Pain points:**
- PromQL syntax debugging
- Grafana JSON is verbose and error-prone
- Alert threshold selection (arbitrary thresholds = alert fatigue)
- Documentation often skipped due to time pressure

### With AgentOps

**Assisted process (45 minutes):**

```bash
# 1. Define SLO targets (10 minutes)
"Help me define SLOs for our new user-facing API service"

# Agent asks clarifying questions:
# - What's the user-facing impact? (High - login/authentication)
# - What's your risk tolerance? (Low - critical path)
# - What metrics matter most? (Availability, latency)

# Agent suggests:
# - Availability: 99.95% (21.6 minutes/month downtime budget)
# - Latency (P95): 200ms (user-perceivable threshold)
# - Error rate: 0.05% (50 errors per 100k requests)

# 2. Generate Prometheus queries (5 minutes)
"Generate Prometheus queries for these SLOs"

# Agent produces:
# Availability:
#   100 * (1 - (rate(http_requests_total{job="api",code=~"5.."}[5m])
#              / rate(http_requests_total{job="api"}[5m])))
#
# Latency P95:
#   histogram_quantile(0.95, rate(http_request_duration_seconds_bucket{job="api"}[5m]))
#
# Error rate:
#   100 * rate(http_requests_total{job="api",code!~"2.."}[5m])
#       / rate(http_requests_total{job="api"}[5m])

# 3. Create Grafana dashboard (15 minutes)
"Generate Grafana dashboard JSON for this service"

# Agent creates complete dashboard with:
# - SLO compliance gauges (red/yellow/green)
# - Golden signals panels (latency, traffic, errors, saturation)
# - Error budget burn graph
# - Multi-window burn rate alerts (1h, 6h, 24h)

# 4. Set up alerting (10 minutes)
"Generate alerting rules for SLO violations"

# Agent produces Prometheus alerting rules:
# - Fast burn (>14.4x rate): Page immediately (99.95% SLO)
# - Slow burn (>6x rate): Ticket for investigation
# - Error budget exhausted: Feature freeze alert

# 5. Document (5 minutes)
"Generate SLO documentation for this service"

# Agent creates:
# - slos/api-service.yaml (machine-readable spec)
# - README explaining rationale for targets
# - Links to dashboard and alerting rules
```

**Time saved:** 3 hours 15 minutes (81% reduction)

**Quality improvements:**
- SLO-based alerting (not arbitrary thresholds) → Less alert fatigue
- Complete documentation automatically generated
- Prometheus queries validated before dashboard creation
- Multi-window burn rate alerts (Google SRE best practice)

**Factors applied:**
- **Factor IV (Validation Gates):** Queries validated before dashboard generation
- **Factor V (Telemetry):** Golden signals + SLOs as first-class data
- **Factor I (Git Memory):** SLO definitions versioned in git

---

## Workflow 4: Friday Morning - Blameless Postmortem

**Context:** Wednesday's database incident resolved. Time for postmortem before people forget.

### Without AgentOps

**Manual process (3 hours):**
1. Collect timeline from Slack/PagerDuty (45 min)
2. Interview responders to fill gaps (30 min)
3. Perform 5 Whys root cause analysis (30 min)
4. Write postmortem document (60 min)
5. Identify action items and owners (15 min)
6. Schedule postmortem review meeting (10 min)

**Pain points:**
- Timeline reconstruction is tedious
- Easy to forget details after 48 hours
- 5 Whys often stops too shallow
- Action items vague or unassigned
- Postmortems often delayed/skipped due to time pressure

### With AgentOps

**Assisted process (45 minutes):**

```bash
# 1. Generate timeline (10 minutes)
"Create postmortem timeline for Wednesday database incident"

# Agent reconstructs from:
# - PagerDuty alert timestamps
# - Slack #incidents channel messages
# - Git commits during incident (if any fixes deployed)
# - Grafana dashboard snapshots

# Timeline generated:
# 02:00 - Alert: Database replica lag > 10 minutes
# 02:02 - Incident declared SEV2 by @oncall-sre
# 02:05 - Investigation started: Primary DB healthy
# 02:10 - Root cause identified: ETL job overloading WAL
# 02:15 - Mitigation: Kill ETL job, manual WAL cleanup
# 02:30 - Replica lag recovered to < 1 minute
# 02:35 - Incident resolved, monitoring continues

# 2. Perform 5 Whys analysis (10 minutes)
"Run 5 Whys analysis for database replica lag incident"

# Agent facilitates:
# Why did replica lag occur?
#   → Nightly ETL job generated excessive WAL traffic
# Why did ETL generate excessive WAL?
#   → Processing 6 months of backfill data (not typical nightly load)
# Why was 6-month backfill running during nightly window?
#   → Manual backfill triggered without checking impact
# Why wasn't impact checked before running?
#   → No runbook for "safe backfill procedures"
# Why don't we have backfill runbook?
#   → Backfills rare, considered one-off operations

# Root cause: Lack of operational runbook for large data backfills

# 3. Identify action items (10 minutes)
"Extract action items from this postmortem"

# Agent suggests:
# - [P0] Create "Safe Data Backfill" runbook (@data-eng, 1 week)
# - [P1] Add ETL monitoring alerts (WAL generation rate) (@sre, 2 weeks)
# - [P2] Document manual operations in #data-ops Slack before executing (@all, immediate)
# - [Pattern] Add to failure catalog: "Unvalidated manual operations"

# 4. Generate postmortem document (10 minutes)
"Write complete postmortem document"

# Agent produces markdown:
# - Executive summary (2 sentences)
# - Impact quantification (25 min of SLO budget, internal tools only)
# - Complete timeline (from step 1)
# - Root cause analysis (5 Whys from step 2)
# - Action items with owners and due dates (from step 3)
# - Lessons learned section
# - Related incidents links (other ETL-related issues)

# 5. Schedule review (5 minutes)
"Draft calendar invite for postmortem review"

# Agent creates:
# Subject: Postmortem Review - Database Replica Lag (2025-11-06)
# When: Friday 2pm (within 48 hours of resolution)
# Attendees: @oncall-sre, @data-eng, @manager-sre
# Agenda:
#   - Timeline walkthrough (10 min)
#   - Root cause discussion (10 min)
#   - Action items assignment (5 min)
#   - Q&A (5 min)
```

**Time saved:** 2 hours 15 minutes (75% reduction)

**Quality improvements:**
- Complete timeline (no missing gaps)
- Deeper root cause (5 Whys validation)
- Actionable items with owners
- Pattern extraction for future prevention
- Postmortem completed within 48 hours (fresh memory)

**Factors applied:**
- **Factor VI (Session Continuity):** Timeline preserved from incident response
- **Factor IX (Pattern Extraction):** Automatic pattern identification
- **Factor XII (Continuous Learning):** Action items tracked for follow-up

---

## Workflow 5: Quarterly Planning - Reliability Roadmap

**Context:** Q4 planning. Need to justify SRE headcount and reliability investments.

### Without AgentOps

**Manual process (8 hours):**
1. Export all Q3 incident data (1 hour)
2. Categorize incidents by type (2 hours)
3. Calculate aggregate metrics (MTTR, MTBF, SLO compliance) (2 hours)
4. Create slide deck with charts (2 hours)
5. Write reliability narrative for leadership (1 hour)

**Pain points:**
- Data scattered across systems (PagerDuty, Jira, Confluence)
- Manual categorization is subjective
- Difficult to justify investments with data
- Hard to identify systemic issues

### With AgentOps

**Assisted process (90 minutes):**

```bash
# 1. Analyze quarterly incidents (30 minutes)
"Analyze all postmortems from Q3 2025 and identify patterns"

# Agent processes: postmortems/2025-Q3/*.md

# Findings:
# - Total incidents: 23 (12 SEV3, 8 SEV2, 3 SEV1)
# - SLO budget consumed: 4.2 hours (of 7.2 hour quarterly budget = 58%)
# - Top categories:
#   1. Database capacity (8 incidents, 35%)
#   2. Deployment issues (5 incidents, 22%)
#   3. Dependency failures (4 incidents, 17%)
# - MTTR trend: Improving (45min → 32min average)
# - Repeat incidents: 4 incidents were repeat failures

# 2. Generate reliability metrics (15 minutes)
"Create quarterly reliability dashboard"

# Agent generates:
# - Availability by service (heatmap: green/yellow/red)
# - Error budget burn rate trend (improving 15% vs Q2)
# - Incident frequency by week (spike in week 8 - deployment freeze)
# - On-call load distribution (fairness check)

# 3. Identify investment areas (20 minutes)
"Based on Q3 incidents, what should we invest in for Q4?"

# Agent recommends:
# - [HIGH] Database capacity automation (eliminates 35% of incidents)
#   - ROI: 8 incidents/quarter × 45min MTTR = 6 hours saved
#   - Investment: 2 weeks eng time to build auto-scaling
#
# - [MEDIUM] Deployment safety improvements (22% of incidents)
#   - ROI: 5 incidents/quarter × 32min MTTR = 2.7 hours saved
#   - Investment: Implement canary deployments (1 week)
#
# - [LOW] Dependency circuit breakers (17% of incidents)
#   - ROI: 4 incidents/quarter × 40min MTTR = 2.7 hours saved
#   - Investment: Add circuit breakers to 5 critical dependencies (3 weeks)

# 4. Generate executive summary (15 minutes)
"Create Q3 reliability review for leadership"

# Agent produces:
# - One-page executive summary
# - Key metrics (availability, SLO compliance, MTTR)
# - Top 3 reliability wins (MTTR improvement, fewer SEV1s, better runbooks)
# - Top 3 investment priorities (database, deployments, dependencies)
# - Headcount justification (savings from automation > cost of hire)

# 5. Create presentation (10 minutes)
"Generate slide deck for quarterly review"

# Agent creates 5-slide deck:
# - Slide 1: Executive summary
# - Slide 2: Q3 metrics (availability, incidents, MTTR)
# - Slide 3: Pattern analysis (database capacity is #1 issue)
# - Slide 4: Q4 roadmap (3 investment areas)
# - Slide 5: Team health (on-call load, burnout risk)
```

**Time saved:** 6.5 hours (81% reduction)

**Strategic benefits:**
- Data-driven prioritization (not opinions)
- Clear ROI for investments
- Patterns visible across quarters
- Repeatable process for future planning

**Factors applied:**
- **Factor IX (Pattern Extraction):** Systemic issues identified automatically
- **Factor XII (Continuous Learning):** Quarterly review feeds next quarter's roadmap
- **Factor I (Git Memory):** All postmortems in git enable historical analysis

---

## Summary: Time Savings by Workflow

| Workflow | Manual Time | AgentOps Time | Savings | Reduction |
|----------|-------------|---------------|---------|-----------|
| Weekly reliability review | 90 min | 20 min | 70 min | 78% |
| Midnight incident response | 45 min | 10 min | 35 min | 78% |
| SLO dashboard creation | 240 min | 45 min | 195 min | 81% |
| Blameless postmortem | 180 min | 45 min | 135 min | 75% |
| Quarterly planning | 480 min | 90 min | 390 min | 81% |
| **Total (monthly)** | **1035 min** | **210 min** | **825 min** | **80%** |

**Monthly savings:** 13.75 hours (nearly 2 full workdays)

**Annually:** 165 hours saved (4+ weeks of productivity)

**Cost savings (assuming $150k/year SRE salary):**
- Hourly rate: $75/hour (assuming 2000 work hours/year)
- Annual savings: 165 hours × $75 = $12,375 per SRE
- Team of 5 SREs: $61,875/year saved

**Quality improvements:**
- Fewer missed reliability issues (automated pattern detection)
- Faster incident response (pre-built investigation checklists)
- Better postmortems (no skipped due to time pressure)
- Data-driven planning (pattern analysis across quarters)

---

## Anti-Patterns to Avoid

### Anti-Pattern 1: Alert Fatigue from Over-Automation

**Problem:** Automatically creating alerts for every metric

**Symptom:**
```bash
# DON'T DO THIS:
"Create alerts for all Prometheus metrics"

# Result: 500+ alerts, 99% noise
```

**Solution:** Use SLO-based alerting only
```bash
# DO THIS:
"Create alerts for SLO violations only (availability, latency, error rate)"

# Result: 5-10 high-signal alerts
```

**Factor applied:** Factor V (Telemetry as First-Class) - measure what matters

### Anti-Pattern 2: Skipping Validation Gates

**Problem:** Applying dashboard changes directly to production without preview

**Symptom:**
```bash
# DON'T DO THIS:
"Update Grafana dashboard directly in production"

# Risk: Break existing dashboards, lose visibility during incident
```

**Solution:** Preview changes first
```bash
# DO THIS:
"Generate Grafana dashboard JSON, let me review before applying"

# Then: Manual review → Test in staging → Apply to production
```

**Factor applied:** Factor IV (Validation Gates) - validate before execute

### Anti-Pattern 3: Overloading Agent Context

**Problem:** Asking agent to analyze entire year of incidents at once

**Symptom:**
```bash
# DON'T DO THIS:
"Analyze all 300 incidents from the past year"

# Result: Context collapse, superficial analysis
```

**Solution:** Break into phases
```bash
# DO THIS:
"Analyze Q1 incidents" → patterns
"Analyze Q2 incidents" → patterns
"Compare Q1 vs Q2 patterns" → trends
```

**Factor applied:** Factor II (JIT Context Loading) - stay under 40% context

### Anti-Pattern 4: No Human Review of Action Items

**Problem:** Blindly accepting all agent-suggested action items

**Symptom:**
```bash
# Agent suggests: "Rewrite entire database in Rust for performance"
# You: "Sounds good!" ← DON'T DO THIS
```

**Solution:** Human judgment on priority/feasibility
```bash
# Agent suggests 10 action items
# You: Review ROI, effort, risk
# You: Select top 3 that are high-impact, low-effort
# You: Defer low-ROI items
```

**Factor applied:** Factor IV (Validation Gates) - human validates AI suggestions

### Anti-Pattern 5: Forgetting to Extract Patterns

**Problem:** Using agents for one-off tasks without capturing learnings

**Symptom:**
```bash
# Solve incident → Move on to next task
# Result: Same incident repeats next month
```

**Solution:** Always extract patterns
```bash
# After every postmortem:
"What pattern does this represent? What runbook would prevent recurrence?"

# Result: Runbook added, pattern cataloged, future prevention
```

**Factor applied:** Factor IX (Pattern Extraction) - learn from every incident

---

## Next Steps

### Try These Workflows

**Start simple:**
1. **Weekly review:** Use `/observe-metrics` next Monday morning
2. **Dashboard creation:** Pick one service without monitoring, use `slo-dashboard` agent
3. **Next incident:** Use `/analyze-incident` for triage

**Build gradually:**
1. After 3 incidents with `/analyze-incident`, review time savings
2. After 3 postmortems with `postmortem-guide`, look for patterns
3. After 1 quarter, run quarterly analysis workflow

**Measure impact:**
- Track time spent on each workflow (before/after AgentOps)
- Count patterns extracted from postmortems
- Monitor MTTR trends (should improve with better runbooks)
- Survey team: "Do you feel less stressed during incidents?" (yes/no)

### Customize for Your Team

**Add your runbooks:**
```markdown
# runbooks/database-replica-lag.md
# (Agent will reference during incidents)
```

**Define your SLOs:**
```yaml
# slos/service-name.yaml
# (Agent will calculate compliance automatically)
```

**Add your dashboards:**
```json
# dashboards/service-name.json
# (Agent will reference when creating new dashboards)
```

**Track your patterns:**
```markdown
# patterns/database-capacity-saturation.md
# (Agent will suggest during similar incidents)
```

---

## Questions?

**How do I get started?**
- Copy `examples/sre/.claude/` to your SRE project
- Try `/observe-metrics` on your existing Prometheus/Grafana setup
- Customize agents for your environment (see README.md)

**What if I don't use Prometheus/Grafana?**
- Agents adapt to Datadog, New Relic, Splunk, etc.
- Edit agent prompts to reference your observability stack
- Core principles (SLOs, golden signals) remain the same

**Can I use this for on-call rotations?**
- Yes! The `incident-response` agent is designed for 2am alerts
- Reduces cognitive load during high-stress incidents
- Provides investigation checklists (no need to remember runbooks)

**How do I measure ROI?**
- Track time spent on workflows (before/after)
- Count incidents prevented by extracted patterns
- Survey team on stress levels (incidents are less chaotic)
- Calculate: (hours saved × hourly rate) = ROI

---

**Ready to transform your SRE workflows?**

Start with the weekly reliability review workflow on Monday morning. You'll save an hour and get better insights than manual dashboard navigation.

**Reliability through operational discipline. Efficiency through AI agents.**
