# SRE Domain Example - 12-Factor AgentOps

**A production-ready `.claude/` configuration for Site Reliability Engineering**

This example demonstrates how to apply 12-Factor AgentOps principles to SRE workflows: incident response, SLO management, postmortem analysis, and observability.

---

## What This Example Contains

**Agents (AI-powered workflows):**
- `slo-dashboard.md` - Create and maintain SLO dashboards (Grafana/Prometheus)
- `incident-response.md` - Structured incident response procedures
- `postmortem-guide.md` - Blameless postmortem facilitation

**Commands (quick actions):**
- `/observe-metrics` - Rapid metrics analysis (golden signals)
- `/analyze-incident` - Incident triage and analysis

**Workflows:**
- `WORKFLOWS.md` - Day-in-the-life scenarios for SRE teams

---

## Quick Start

### Installation

```bash
# 1. Copy this folder to your SRE project
cp -r examples/sre/.claude /path/to/your/sre-project/

# 2. Customize for your environment
cd /path/to/your/sre-project
edit .claude/agents/slo-dashboard.md  # Update Prometheus/Grafana URLs
edit .claude/agents/incident-response.md  # Update Slack/PagerDuty config

# 3. Start using agents
# In Claude Code, navigate to your project and use slash commands
/observe-metrics
/analyze-incident
```

### Using Agents

**Create an SLO dashboard:**
```bash
# 1. In Claude Code, load agent context
cd /path/to/your/sre-project

# 2. Ask Claude to help with SLO dashboard
"Create an SLO dashboard for our API service with 99.9% availability target"

# 3. Agent will guide you through:
#    - Defining SLIs (error rate, latency)
#    - Calculating SLO targets
#    - Creating Prometheus queries
#    - Building Grafana dashboard JSON
#    - Setting up alerting rules
```

**Respond to an incident:**
```bash
# 1. Use quick command
/analyze-incident

# 2. Provide incident details
"API latency spiked to 5s, error rate increased to 2%"

# 3. Agent will:
#    - Triage severity based on SLO impact
#    - Generate investigation checklist
#    - Draft incident communication
#    - Track timeline for postmortem
```

**Facilitate a postmortem:**
```bash
# 1. After incident resolution, start postmortem
"Help me run a blameless postmortem for yesterday's database outage"

# 2. Agent will guide through:
#    - Timeline construction
#    - Root cause analysis (5 Whys)
#    - Action items extraction
#    - Pattern identification
#    - Documentation in standard format
```

---

## 12-Factor AgentOps Mapping

This SRE example demonstrates these factors:

### Factor I: Git Memory as Knowledge OS
- Postmortems stored in git (`postmortems/YYYY-MM-DD-incident-name.md`)
- SLO definitions versioned (`slos/service-name.yaml`)
- Runbooks tracked with history (`runbooks/service-name.md`)
- **Benefit:** Institutional memory of failures and learnings

### Factor II: JIT Context Loading
- Agents load only relevant SLO data per service
- Incident agent focuses on single incident at a time
- Dashboard agent scopes to one service/team
- **Benefit:** Stay under 40% context usage during high-stress incidents

### Factor III: Single-Responsibility Agents
- `slo-dashboard` - Only dashboard creation
- `incident-response` - Only incident management
- `postmortem-guide` - Only postmortem facilitation
- **Benefit:** Predictable behavior when reliability matters most

### Factor IV: Validation Gates
- SLO definitions validated before dashboard creation
- Incident severity checked against error budget impact
- Postmortem completeness verified (timeline, root cause, actions)
- **Benefit:** No bad dashboards, proper incident classification

### Factor V: Telemetry as First-Class Data
- **Core principle for SRE**
- Golden signals (latency, traffic, errors, saturation) built into workflows
- SLO-based alerting (not threshold-based)
- Metrics inform all decisions
- **Benefit:** Observable, measurable reliability

### Factor VI: Session Continuity
- Incident context preserved across shifts
- Postmortem data persists for week-long analysis
- SLO dashboard iterations tracked
- **Benefit:** Handoffs don't lose critical context

### Factor IX: Pattern Extraction
- Postmortems automatically extract reusable patterns
- Common failure modes cataloged
- Runbook improvements suggested
- **Benefit:** Learn from every incident

### Factor XII: Continuous Learning
- Postmortem reviews identify recurring issues
- SLO trends reveal degradation patterns
- Incident playbooks evolve with each use
- **Benefit:** System gets more reliable over time

---

## File Structure

```
examples/sre/
├── README.md                          # This file
├── WORKFLOWS.md                       # Day-in-the-life scenarios
├── .claude/
│   ├── agents/
│   │   ├── slo-dashboard.md           # SLO dashboard creation
│   │   ├── incident-response.md       # Incident management
│   │   └── postmortem-guide.md        # Blameless postmortems
│   └── commands/
│       ├── observe-metrics.md         # Quick metrics check
│       └── analyze-incident.md        # Incident triage
└── templates/                         # (Optional) Output templates
    ├── slo-definition.yaml            # SLO spec format
    ├── incident-report.md             # Incident documentation
    └── postmortem-template.md         # Postmortem structure
```

---

## Technology Stack

**This example assumes:**
- **Monitoring:** Prometheus (metrics) + Grafana (dashboards)
- **Alerting:** Alertmanager or PagerDuty
- **Logging:** Loki, Elasticsearch, or CloudWatch
- **Communication:** Slack or similar

**But adapts to:**
- Datadog, New Relic, Splunk (commercial observability)
- Custom metrics systems
- Any alerting platform
- Any communication tool

**Adaptation notes:**
- Prometheus queries → Datadog queries (similar syntax)
- Grafana dashboards → Datadog dashboards (different JSON structure)
- Alertmanager → PagerDuty (different routing logic)

---

## Google SRE Principles Applied

This example follows best practices from the [Google SRE Book](https://sre.google/books/):

### SLOs (Service Level Objectives)
- Define reliability targets (99.9%, 99.95%, etc.)
- Measure against SLIs (Service Level Indicators)
- Track error budgets (100% - SLO = budget for risk)
- Alert on burn rate (SLO depletion speed)

### Golden Signals
- **Latency:** How long requests take
- **Traffic:** How many requests/second
- **Errors:** Rate of failed requests
- **Saturation:** How "full" the service is

### Incident Management
- Severity classification (SEV1-SEV4)
- Clear roles (Incident Commander, Comms Lead, Technical Lead)
- Time-boxed investigation phases
- Regular stakeholder updates

### Blameless Postmortems
- Focus on systems, not people
- 5 Whys root cause analysis
- Action items with owners and deadlines
- Extract learnings for future prevention

### Error Budgets
- SLO budget = acceptable downtime
- Budget exhausted = feature freeze, focus on reliability
- Budget available = safe to take risks

---

## Example Scenarios

### Scenario 1: New Service SLO Dashboard

**Goal:** Create monitoring for new API service

**Workflow:**
1. Define SLIs (error rate, P95 latency, availability)
2. Set SLO targets (99.9% uptime, <200ms P95, <0.1% errors)
3. Use `slo-dashboard` agent to:
   - Generate Prometheus queries
   - Create Grafana dashboard JSON
   - Set up alerting rules (burn rate)
   - Document SLO rationale

**Time:** 30 minutes (vs 2-3 hours manually)

**Factor applied:** Factor V (Telemetry as First-Class Data)

### Scenario 2: Midnight Database Outage

**Goal:** Respond to production database failure

**Workflow:**
1. Alert fires: "Database replica lag > 10 minutes"
2. Use `/analyze-incident` command
3. Agent triages:
   - Severity: SEV2 (degraded, not down)
   - Error budget impact: 15 minutes of SLO burn
   - Initial investigation: Check replica health, replication logs
4. Use `incident-response` agent to:
   - Draft Slack announcement
   - Generate investigation checklist
   - Track timeline automatically
   - Coordinate with oncall team

**Time:** Structured response in 5 minutes (vs 20+ minutes scrambling)

**Factors applied:** Factor II (JIT loading), Factor III (single responsibility), Factor VI (session continuity)

### Scenario 3: Quarterly Reliability Review

**Goal:** Extract patterns from 12 postmortems over Q1

**Workflow:**
1. Use `postmortem-guide` agent to analyze postmortems/2025-Q1/*.md
2. Agent identifies:
   - 60% of outages involved database saturation
   - 3 incidents had similar root cause (connection pool exhaustion)
   - 80% of action items completed within 30 days
3. Agent suggests:
   - Pattern: "Database connection pool saturation"
   - Preventive action: Automated connection pool scaling
   - Runbook: Connection pool debugging guide

**Time:** 1 hour analysis (vs 4-6 hours manually reviewing postmortems)

**Factors applied:** Factor IX (Pattern Extraction), Factor XII (Continuous Learning)

---

## Customization Guide

### Adapt to Your Environment

**Prometheus → Datadog:**
```diff
# In slo-dashboard.md agent

- Prometheus query: rate(http_requests_total{code!~"2.."}[5m])
+ Datadog query: sum:http.requests{status_code:!2*}.as_rate()

- Grafana dashboard JSON
+ Datadog dashboard JSON (different structure)
```

**PagerDuty instead of Alertmanager:**
```diff
# In incident-response.md agent

- Alertmanager routing config
+ PagerDuty escalation policy

- Alertmanager silence API
+ PagerDuty incident notes API
```

**Custom SLO format:**
```diff
# In templates/slo-definition.yaml

- Standard format (Prometheus Operator)
+ Your internal SLO spec (YAML/JSON)
```

### Add Your Services

**Define SLOs for your services:**
```yaml
# slos/api-service.yaml
service: api-service
slo:
  availability: 99.9%
  latency_p95: 200ms
  error_rate: 0.1%
error_budget:
  monthly_downtime: 43.2m  # (1 - 0.999) * 30 days
```

**Create runbooks:**
```markdown
# runbooks/api-service.md

## High Latency Response

**Symptoms:** P95 latency > 500ms

**Investigation:**
1. Check database query performance
2. Review cache hit rate
3. Inspect external API latencies

**Mitigation:**
- Scale horizontally (add replicas)
- Invalidate stale cache
- Circuit-break slow external APIs
```

---

## Best Practices

### When Using SRE Agents

**DO:**
- Define SLOs before creating dashboards (measure what matters)
- Use golden signals as starting point (latency, traffic, errors, saturation)
- Set realistic targets (99.9% for user-facing, 99.5% for internal)
- Alert on SLO burn rate (not arbitrary thresholds)
- Run blameless postmortems within 48 hours of incident

**DON'T:**
- Alert on every metric (alert fatigue)
- Skip postmortems for "small" incidents (patterns hide in small failures)
- Blame individuals in postmortems (focus on systems)
- Set 100% SLOs (leaves no error budget for change)
- Ignore toil automation opportunities

### When Adapting This Example

**DO:**
- Preserve the Laws of an Agent header (essential for safety)
- Customize metrics/queries for your stack
- Add your team's specific runbooks
- Version control all SLO definitions
- Test agents on non-production data first

**DON'T:**
- Remove validation gates (prevent bad dashboards/alerts)
- Skip JIT context loading (incidents are high-stress)
- Combine agents (single-responsibility is critical for reliability)
- Hard-code credentials (use environment variables)

---

## Learning Resources

### Google SRE Resources
- [Site Reliability Engineering Book](https://sre.google/sre-book/table-of-contents/) (free online)
- [The Site Reliability Workbook](https://sre.google/workbook/table-of-contents/) (practical exercises)
- [Building Secure and Reliable Systems](https://sre.google/books/building-secure-reliable-systems/)

### Prometheus + Grafana
- [Prometheus Best Practices](https://prometheus.io/docs/practices/)
- [Grafana Dashboarding Best Practices](https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/best-practices/)
- [Alerting Best Practices](https://prometheus.io/docs/practices/alerting/)

### SLO Resources
- [SLO Workshop by Google](https://sre.google/resources/practices-and-processes/slo-workshop-handbook/)
- [Art of SLOs](https://sre.google/resources/practices-and-processes/art-of-slos/) (video series)

### Incident Management
- [Incident Command System (ICS)](https://training.fema.gov/is/courseoverview.aspx?code=is-100.c) (FEMA, free course)
- [PagerDuty Incident Response Guide](https://response.pagerduty.com/)

---

## Support & Contributions

**Questions?**
- Open an issue on the main 12-factor-agentops repo
- Tag with `domain:sre` label

**Found a bug?**
- Submit a PR with fix
- Include test scenario demonstrating the issue

**Want to contribute?**
- Add more SRE agents (capacity planning, toil automation, etc.)
- Share production-validated patterns
- Improve documentation with real-world examples

---

## Version & Status

**Version:** 1.0.0
**Last Updated:** 2025-11-09
**Status:** Production-ready

**Validation:**
- Tested with Prometheus 2.x + Grafana 9.x
- Used in production SRE workflows (DoD infrastructure scale)
- Covers Google SRE Book principles
- Adapts to commercial observability platforms (Datadog, New Relic, Splunk)

**Next steps:**
- Add capacity planning agent
- Add toil automation agent
- Add chaos engineering workflows

---

**Ready to make your SRE workflows more reliable?**

Start with `/observe-metrics` to check your golden signals, then build SLO dashboards with the `slo-dashboard` agent.

**Reliability through operational discipline. Automation through AI agents.**

Welcome to SRE + 12-Factor AgentOps.
