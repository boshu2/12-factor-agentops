# /analyze-incident - Incident Triage and Analysis

**Quick incident triage using SLO-based severity classification**

This slash command provides rapid incident assessment, investigation checklist generation, and communication templates following Google SRE and FEMA ICS principles.

---

## Purpose

**Use this command when:**
- Alert fires (PagerDuty, Prometheus, Datadog)
- Users report production issues
- Monitoring shows degradation
- Manual operations go wrong
- Deployment causes issues

**Time:** 2-3 minutes for triage (vs 15-20 minutes ad-hoc assessment)

---

## Usage

```bash
# Basic usage (paste alert text)
/analyze-incident

# With alert details
/analyze-incident "Database replica lag > 10 minutes (current: 25 min)"

# With context
/analyze-incident --context="Just deployed v2.5.0, 50% pods crashing"

# Severity override (if you disagree with agent assessment)
/analyze-incident --severity=SEV1
```

---

## What This Command Does

### 1. Triage Severity Based on SLO Impact

**Severity calculation:**
```yaml
SEV1 (Critical):
  definition: Complete outage or major functionality unavailable
  user_impact: All users affected, critical path blocked
  slo_impact: >50% of monthly error budget per hour
  examples:
    - "Payment processing down (0% success)"
    - "Database primary offline (all writes failing)"

SEV2 (High):
  definition: Significant degradation, partial functionality down
  user_impact: Subset of users affected or degraded performance
  slo_impact: 10-50% of monthly error budget per hour
  examples:
    - "API latency 5x normal (500ms → 2.5s)"
    - "10% of login attempts failing"

SEV3 (Medium):
  definition: Minor degradation, workaround available
  user_impact: Small subset or internal tools only
  slo_impact: <10% of monthly error budget per hour
  examples:
    - "Background job delayed 30 min"
    - "Analytics dashboard stale (6h lag)"

SEV4 (Low):
  definition: No current impact, trending toward issue
  user_impact: None (warning only)
  slo_impact: No error budget consumption yet
  examples:
    - "Disk usage at 78% (threshold: 80%)"
    - "Memory leak detected, OOM in 48h"
```

**Example triage output:**
```
🔴 SEV2 Incident: Database Replica Lag

Impact:
  - User-facing: Analytics dashboard stale data (25 min lag)
  - Internal: Reporting jobs reading outdated data
  - Severity rationale: Degraded read performance, writes unaffected

SLO Impact:
  - Availability: 99.9% (no impact - service is up)
  - Latency: Read queries 2x slower (P95: 100ms → 200ms)
  - Error budget consumed: 25 min = 0.96% of monthly budget (43.2 min)
  - Burn rate: Normal (not accelerating)

Recommended Response:
  ✅ Notify #incidents Slack
  ✅ Page database oncall
  ❌ No war room needed (degraded, not down)
  ⏱️ Target resolution: 60 minutes
```

### 2. Generate Investigation Checklist

**Tailored to incident type:**

**Database incident example:**
```markdown
# Investigation Checklist - Database Replica Lag

## Immediate Checks (5 minutes)

### 1. Primary Database Health
- [ ] CPU: `kubectl top pod db-primary`
- [ ] Memory: `kubectl top pod db-primary`
- [ ] Disk I/O: `iostat -x 1`
Expected: CPU <80%, memory <90%, I/O not saturated

### 2. Replication Status
- [ ] Replica lag: `SELECT now() - pg_last_xact_replay_timestamp()`
- [ ] Replication slot: `SELECT * FROM pg_replication_slots`
- [ ] Replication logs: `kubectl logs db-replica | grep replication`
Expected: Lag <1 min, slot active, no errors

### 3. Root Cause Hypotheses (Ordered by Likelihood)

Hypothesis 1 (70%): Large transaction blocking replication
  - Check: Long-running transactions on primary
  - Validation: Transaction started when lag began
  - Mitigation: Kill transaction if non-critical

Hypothesis 2 (15%): Network partition
  - Check: MTR report shows packet loss
  - Validation: Replication logs show connection errors
  - Mitigation: Investigate network (switch, CNI)

Hypothesis 3 (10%): Replica disk full
  - Check: `df -h` on replica, `iostat` 100% util
  - Validation: Logs show "disk full" errors
  - Mitigation: Delete old WAL, expand disk

## Mitigation Options

Option 1: Redirect reads to primary
  - Impact: Primary handles read+write (may degrade writes)
  - Rollback: Revert when replica catches up

Option 2: Kill blocking transaction
  - Impact: Transaction fails, app retries
  - Risk: Data inconsistency if critical
  - Command: `SELECT pg_terminate_backend(12345)`
```

**Deployment incident example:**
```markdown
# Investigation Checklist - Deployment Failure

## Immediate Actions (2 minutes)

### 1. Rollback Deployment
- [ ] Command: `kubectl rollout undo deployment/api`
- [ ] Verify: `kubectl rollout status deployment/api`
- [ ] Check: Error rate returns to baseline

### 2. Triage Impact
- [ ] Current error rate: Check Prometheus
- [ ] User reports: Search Twitter, #support-channel
- [ ] SLO impact: Calculate error budget burn

## Investigation (After Rollback)

### 1. Analyze Crashed Pods
- [ ] Logs: `kubectl logs api-<pod> --previous`
- [ ] Compare: What changed in v2.5.0?
- [ ] Test: Reproduce in staging?

### 2. Root Cause Hypotheses

Hypothesis 1: Configuration error
  - New environment variable missing
  - Database connection string wrong
  - Redis endpoint changed

Hypothesis 2: Code bug
  - Panic/crash on specific code path
  - Memory leak in new feature
  - Dependency version incompatibility

Hypothesis 3: Resource constraint
  - New version uses more memory
  - CPU limit too low for new workload
  - PVC storage full
```

### 3. Draft Communication Templates

**Initial announcement (within 5 min):**
```
🔴 SEV2 Incident: Database Replica Lag

Impact:
  - Analytics dashboard showing stale data (25 min lag)
  - Internal tools only (no customer impact)

Status:
  - Investigating root cause (database team paged)
  - Primary database healthy (writes unaffected)

Next Update:
  - 2:30am (in 15 minutes) or when root cause identified

Incident Commander: @oncall-sre
Technical Lead: @oncall-database
```

**Progress update (every 15 min):**
```
🟡 SEV2 Update (2:30am): Database Replica Lag

Root Cause Identified:
  - ETL job processing 6-month backfill
  - Excessive WAL traffic overwhelming replica

Mitigation In Progress:
  - Killing ETL job to stop WAL traffic
  - Manually advancing WAL to clear backlog

ETA to Resolution:
  - 5-10 minutes (replica should catch up quickly)

Next Update:
  - 2:45am (in 15 minutes) or when resolved
```

**Resolution announcement:**
```
✅ SEV2 Resolved (2:35am): Database Replica Lag

Resolution:
  - ETL job killed (will reschedule with rate limiting)
  - Replica lag recovered to <1 minute
  - Analytics dashboard back to real-time

Incident Duration:
  - 35 minutes (2:00am - 2:35am)
  - SLO impact: 1.35% of monthly error budget

Root Cause:
  - Manual backfill without capacity validation
  - No safeguards for large ETL during nightly window

Next Steps:
  - Postmortem Friday 2pm
  - Action items:
    1. Create "Safe Data Backfill" runbook
    2. Add WAL generation rate alert
    3. Require approval for manual backfills

Incident Commander: @oncall-sre
Postmortem owner: @sre-lead
```

### 4. Track Timeline Automatically

**Timeline export for postmortem:**
```yaml
timeline:
  - time: "2025-11-09T02:00:00Z"
    event: "Alert fired: Database replica lag > 10 min"
    actor: "Prometheus Alertmanager"

  - time: "2025-11-09T02:02:00Z"
    event: "Incident declared SEV2"
    actor: "@oncall-sre"

  - time: "2025-11-09T02:10:00Z"
    event: "Root cause identified: ETL job WAL saturation"
    actor: "@oncall-database"

  - time: "2025-11-09T02:15:00Z"
    event: "Mitigation: Killed ETL job"
    actor: "@oncall-database"

  - time: "2025-11-09T02:35:00Z"
    event: "Incident resolved"
    actor: "@oncall-sre"

# Exported to: incidents/2025-11-09-database-lag-timeline.yaml
```

---

## Example Scenarios

### Scenario 1: 2am Alert - Database Replica Lag

**User invokes:**
```bash
/analyze-incident "Database replica lag > 10 minutes (current: 25 min)"
```

**Output:**
```
🔴 SEV2 Incident Detected: Database Replica Lag

=== TRIAGE SUMMARY ===

Severity: SEV2 (High)
Rationale:
  - Degraded read performance (not complete outage)
  - Internal tools affected (analytics dashboard)
  - No customer-facing impact
  - Consuming 0.96% of monthly error budget (25 min of 43.2 min)

=== INVESTIGATION CHECKLIST ===

Priority 1 (Check First):
  1. Primary database health (CPU, memory, disk)
  2. Replication logs for errors
  3. Long-running transactions

Priority 2 (If P1 clear):
  1. Network connectivity (primary ↔ replica)
  2. Replica disk space
  3. Recent schema changes

Root Cause Hypotheses (Ordered):
  1. [70%] Large transaction blocking replication
  2. [15%] Network partition
  3. [10%] Replica disk full
  4. [5%] Postgres replication bug

=== COMMUNICATION ===

Slack Announcement (Copy & Paste to #incidents):
---
🔴 SEV2 Incident: Database Replica Lag

Impact: Analytics dashboard stale (25 min lag), internal only
Status: Investigating, database team paged
Next Update: 15 minutes or when root cause found

IC: @oncall-sre | TL: @oncall-database
---

=== NEXT STEPS ===

1. Post Slack announcement above
2. Page @oncall-database
3. Begin investigation checklist
4. Report findings back to this agent
5. Agent will suggest mitigation based on findings

Timeline tracking: STARTED (will export to postmortem)

Ready to investigate? (yes/no)
```

**User investigates:**
```
User: "Checked replication logs. Showing 'waiting for WAL segment'. ETL job running since 2am."
```

**Agent responds:**
```
ROOT CAUSE IDENTIFIED: ETL Job WAL Saturation

Hypothesis Confirmed: Large transaction overwhelming replication (70% probability)
Specific: ETL job generating excessive write-ahead log traffic

=== MITIGATION OPTIONS ===

Option 1: Kill ETL Job (RECOMMENDED)
  - Impact: ETL fails, will need to restart later
  - Benefit: Immediate relief for replica
  - Risk: Low (ETL can be restarted)
  - Command: kubectl delete pod etl-job-backfill-20251109
  - ETA: Recovery in 5-10 minutes

Option 2: Wait for ETL to Complete
  - Impact: Replica lag continues
  - Benefit: ETL completes successfully
  - Risk: Unknown duration, more error budget consumed
  - ETA: Unknown (ETL might run for hours)

Option 3: Promote Replica to Primary
  - Impact: Major (role reversal)
  - Benefit: Eliminates lag instantly
  - Risk: High (potential data loss)
  - Recommendation: Only if primary is truly failing (not this case)

RECOMMENDED: Option 1 (Kill ETL Job)

Proceed with Option 1? (yes/no)
```

**Time saved:** 35 minutes (vs 70 min without structured triage)

### Scenario 2: Deployment Failure

**User invokes:**
```bash
/analyze-incident --context="Deployed v2.5.0, 50% pods crashing, users reporting errors"
```

**Output:**
```
🔴 SEV1 Incident Detected: Deployment Failure - Partial Outage

=== TRIAGE SUMMARY ===

Severity: SEV1 (Critical)
Rationale:
  - 50% capacity loss
  - Users actively reporting errors
  - Consuming ~50% of monthly error budget per hour
  - Immediate action required

=== IMMEDIATE ACTIONS (DO NOW) ===

1. ROLLBACK DEPLOYMENT
   Command: kubectl rollout undo deployment/api
   Verify: kubectl rollout status deployment/api
   ETA: 2-5 minutes

2. POST TO #INCIDENTS
   Message: "🔴 SEV1: Deployment v2.5.0 causing crashes, rolling back NOW"

3. PAGE ADDITIONAL RESPONDERS (if rollback fails)
   Escalate to: @senior-sre, @app-owner

DO NOT INVESTIGATE YET - MITIGATE FIRST

Proceed with rollback? (yes/no)
```

**User rolls back:**
```
User: "Rollback complete. All pods healthy. Error rate back to 0.1%."
```

**Agent responds:**
```
✅ INCIDENT MITIGATED (Rollback Successful)

Service Status: RESTORED
  - Error rate: 0.1% (baseline)
  - All pods: Healthy (100% capacity)
  - User reports: Decreasing (users confirming resolution)

=== INCIDENT SUMMARY ===

Duration: 12 minutes (10:15 - 10:27 UTC)
SLO Impact: 4.2% of monthly error budget (12 min partial outage)

=== INVESTIGATION (Now Safe to Investigate) ===

Check crashed pod logs:
  Command: kubectl logs api-<pod> --previous

Preliminary root cause:
  - Logs show: "Failed to connect to Redis (ECONNREFUSED)"
  - Hypothesis: v2.5.0 changed Redis connection config

Next Steps:
  1. Schedule postmortem (tomorrow, incident fresh)
  2. Investigate in staging (reproduce Redis connection issue)
  3. Fix v2.5.0 before re-deploy

Action Items (Preliminary):
  - Add Redis connectivity check to pre-deployment validation
  - Implement canary deployment (catch issues before full rollout)

Timeline exported: incidents/2025-11-09-deployment-rollback.yaml

Declare incident resolved? (yes/no)
```

**Time saved:** 58 minutes (vs 70 min without agent prioritizing rollback over investigation)

---

## Parameters Reference

| Parameter | Description | Example | Default |
|-----------|-------------|---------|---------|
| `--context` | Additional context about incident | `--context="After deployment"` | None |
| `--severity` | Override severity assessment | `--severity=SEV1` | Auto-calculated |
| `--service` | Affected service name | `--service=api` | Auto-detect |
| `--skip-comms` | Skip communication templates | `--skip-comms` | false |

---

## Integration with Agents

### With `incident-response` Agent

**Workflow:**
1. `/analyze-incident` for quick triage (2-3 min)
2. If complex, switch to `incident-response` agent for full coordination
3. Agent provides timeline tracking, escalation management

**Example:**
```bash
# Quick triage
/analyze-incident "API latency 5x normal"

# Output: SEV2, investigation checklist provided

# If incident escalates
# Switch to agent: "I need help coordinating this incident"
# Agent provides: War room setup, role assignment, stakeholder comms
```

### With `postmortem-guide` Agent

**Workflow:**
1. `/analyze-incident` tracks timeline during incident
2. Timeline exported: `incidents/2025-11-09-incident-timeline.yaml`
3. After resolution, `postmortem-guide` uses timeline for postmortem
4. No manual timeline reconstruction needed

---

## Customization for Your Stack

### Custom Severity Levels

**Adapt to your organization:**
```yaml
# Example: E-commerce company
SEV1: Revenue-impacting (checkout down, payment failing)
SEV2: Customer-facing degradation (slow page loads, high error rate)
SEV3: Internal tools degraded (admin dashboard slow)
SEV4: Warning/trending (metrics approaching threshold)
```

### Custom Investigation Checklists

**Add domain-specific checks:**
```markdown
# Example: Kubernetes-specific checks
## Immediate Checks
- [ ] Pod status: `kubectl get pods -n production`
- [ ] Node health: `kubectl get nodes`
- [ ] Events: `kubectl get events --sort-by='.lastTimestamp'`
- [ ] Ingress: `kubectl describe ingress api`
```

### Custom Communication Channels

**Adapt to your tools:**
```diff
- Post to #incidents Slack
+ Post to #alerts PagerDuty Notes
+ Update status.example.com (status page)
+ Email leadership@example.com (SEV1 only)
```

---

## Troubleshooting

### "Cannot calculate SLO impact"

**Possible causes:**
1. SLO not defined for service
2. Prometheus unavailable

**Fix:**
```bash
# Define SLO
cat > slos/service-name.yaml <<EOF
service: service-name
slo:
  availability: 99.9%
  latency_p95: 200ms
EOF

# Manual severity assessment
/analyze-incident --severity=SEV2 "Based on user reports"
```

### "Investigation checklist too generic"

**Possible causes:**
1. Incident type not recognized
2. No custom checklists defined

**Fix:**
```bash
# Add custom checklist
cat > .claude/incident-types/database-replica-lag.md <<EOF
# Investigation steps for database replica lag
1. Check replication logs
2. Check WAL generation
3. Check long-running transactions
EOF
```

---

## Best Practices

### When to Use This Command

**✅ DO use for:**
- Quick triage (is this SEV1, SEV2, or SEV3?)
- Investigation guidance (where to look first?)
- Communication templates (what to say?)
- Timeline tracking (postmortem prep)

**❌ DON'T use for:**
- Complex multi-service incidents (use full `incident-response` agent)
- Long-running investigations (switch to agent for coordination)
- Postmortems (use `postmortem-guide` agent after resolution)

### Triage Best Practices

**Mitigate before investigating:**
- SEV1/SEV2: Rollback/mitigation first, investigate later
- SEV3/SEV4: Investigation okay, but set time limits

**SLO-based severity:**
- Use error budget impact, not gut feeling
- 50%+ budget/hour = SEV1
- 10-50% budget/hour = SEV2
- <10% budget/hour = SEV3

**Communication cadence:**
- Initial update: Within 5 minutes
- Progress updates: Every 15 minutes (or status change)
- Resolution: Final summary with action items

---

## Related Commands

- `/observe-metrics` - Quick service health check
- Full agents:
  - `incident-response` - Complex incident coordination
  - `postmortem-guide` - Blameless postmortem after resolution
  - `slo-dashboard` - SLO monitoring and alerting

---

## Version & Changelog

**Version:** 1.0.0
**Last Updated:** 2025-11-09

**Changelog:**
- v1.0.0 (2025-11-09): Initial release
  - SLO-based severity calculation
  - Investigation checklist generation
  - Communication templates
  - Timeline tracking

**Roadmap:**
- v1.1.0: ML-based root cause prediction
- v1.2.0: Automatic runbook suggestions
- v1.3.0: ChatOps integration (Slack bot)

---

## Learning Resources

**Google SRE:**
- [Managing Incidents](https://sre.google/sre-book/managing-incidents/)
- [Incident Command System (ICS)](https://sre.google/sre-book/incident-command/)

**PagerDuty:**
- [Incident Response Guide](https://response.pagerduty.com/)
- [Incident Commander Training](https://response.pagerduty.com/training/incident_commander/)

---

**Ready to triage your next incident?**

Run `/analyze-incident` and paste your alert text or describe the issue.

**Fast triage, clear action, reduced chaos. SLO-based incident management.**
