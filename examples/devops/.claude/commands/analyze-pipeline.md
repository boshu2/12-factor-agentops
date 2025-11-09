Analyze CI/CD pipeline performance, identify bottlenecks, and recommend optimizations.

This command provides data-driven insights following Factor X (Telemetry) and Factor XI (Adaptive Learning) principles.

## What This Command Does

1. **Performance Analysis** - Identify slow pipeline stages
2. **Reliability Analysis** - Track success/failure rates
3. **Trend Analysis** - Compare current vs historical performance
4. **Optimization Recommendations** - Suggest concrete improvements
5. **Cost Analysis** - Estimate compute costs and savings

## Usage

```bash
# Analyze all pipelines
/analyze-pipeline

# Analyze specific pipeline
/analyze-pipeline --name=payment-service

# Analyze time range
/analyze-pipeline --last=7d
/analyze-pipeline --last=30d

# Focus on specific metric
/analyze-pipeline --metric=duration
/analyze-pipeline --metric=success-rate
/analyze-pipeline --metric=cost
```

## Example Output

```
=====================================
Pipeline Performance Analysis
=====================================

Period: Last 30 days
Total Pipelines: 247
Success Rate: 94% (target: >95%) ⚠️

=== Performance Metrics ===

Average Duration: 18m 34s
P95 Duration: 35m 12s (target: <30m) ⚠️
P99 Duration: 52m 45s

Fastest: 8m 12s (user-auth-api)
Slowest: 52m 45s (analytics-processor)

=== Stage Breakdown ===

| Stage      | Avg Duration | % of Total | Issues |
|------------|--------------|------------|--------|
| Validate   | 2m 15s       | 12%        | ✅     |
| Security   | 8m 45s       | 47%        | ⚠️     |
| Test       | 5m 30s       | 30%        | ✅     |
| Build      | 1m 34s       | 8%         | ✅     |
| Deploy     | 30s          | 3%         | ✅     |

=== Top Issues ===

1. Flaky Tests (8 pipelines, 3.2% failure rate)
   - test_api_rate_limiting (12% failure)
   - test_websocket_reconnect (8% failure)
   - test_async_batch_processing (6% failure)

2. Slow Security Scans (15 pipelines, >10m for SAST)
   - Semgrep running serially
   - No caching of scan results
   - Too many rules enabled

3. Cache Misses (32 pipelines, rebuilding dependencies)
   - Dependency cache hit rate: 45% (target: >80%)
   - Average cache miss cost: 5m per pipeline

=== Optimization Opportunities ===

1. Parallelize Security Scans
   Impact: Save ~7m per pipeline
   Effort: 2 hours
   Annual savings: 1,456 hours (61 days)

2. Fix Top 3 Flaky Tests
   Impact: Success rate 94% → 97%
   Effort: 1 day
   Prevented failures: ~8/week

3. Optimize Dependency Caching
   Impact: Save ~5m per pipeline
   Effort: 3 hours
   Cache hit rate: 45% → 85%
   Annual savings: 1,040 hours (43 days)

4. Reduce SAST Rules
   Impact: Save ~3m per pipeline
   Effort: 4 hours
   Trade-off: Reduce false positives by 40%

Total Potential Savings: 2,496 hours/year (104 days)
Estimated Implementation Time: 2 days

=== Cost Analysis ===

Current Monthly Cost: $1,250
Optimized Monthly Cost: $750 (-40%)
Annual Savings: $6,000

=== Recommendations ===

High Priority:
- [ ] Parallelize security scans (highest impact, low effort)
- [ ] Optimize dependency caching (high impact, low effort)

Medium Priority:
- [ ] Fix flaky tests (improves reliability)
- [ ] Reduce SAST rules (reduces noise)

Low Priority:
- [ ] Investigate analytics-processor slowness (isolated issue)

=== Next Steps ===

1. Review recommendations with team
2. Create tickets for high-priority items
3. Implement optimizations incrementally
4. Measure impact after 2 weeks
5. Share learnings with other teams (Factor IX)

Report saved to: reports/pipeline-analysis-2025-11-09.md
```

## When to Use

- **Daily:** Quick check of pipeline health
- **Weekly:** Comprehensive performance review
- **Monthly:** Trend analysis and optimization planning
- **After incidents:** Understand pipeline failures
- **Before scaling:** Identify bottlenecks before team growth

## Integration with 12-Factor

- **Factor X:** Data-driven decision making via telemetry
- **Factor XI:** Continuous improvement from historical data
- **Factor IX:** Optimization patterns shared across teams
- **Factor I:** Analysis results documented in git

## Metrics Tracked

**Performance:**
- Pipeline duration (avg, p50, p95, p99)
- Stage duration breakdown
- Queue time, execution time

**Reliability:**
- Success/failure rate
- Flaky test detection
- Error patterns

**Efficiency:**
- Cache hit rates
- Parallelization opportunities
- Resource utilization

**Cost:**
- Compute time
- Storage costs
- Optimization ROI

## Related

- See `/agent pipeline-guide` for implementing optimizations
- See `examples/devops/WORKFLOWS.md` for optimization workflow examples
- See `.claude/agents/pipeline-guide.md` for CI/CD best practices

## Implementation

This command queries pipeline metrics from:
- GitLab CI/CD API (`.gitlab-ci.yml` pipelines)
- GitHub Actions API (`.github/workflows/`)
- Local git history (commit/pipeline correlations)
- Prometheus/Grafana (runtime metrics)

Analysis uses statistical methods to identify:
- Outliers (unusually slow/fast pipelines)
- Trends (performance degradation over time)
- Patterns (common failure modes)

Results are saved to `reports/pipeline-analysis-{timestamp}.md` for tracking improvements.
