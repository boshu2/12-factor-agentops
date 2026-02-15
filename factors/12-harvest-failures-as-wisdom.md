# XII. Harvest Failures as Wisdom

> **This factor is part of the Scale tier (X-XII) — advanced patterns for multi-agent workflows. Not a prerequisite for getting value from Factors I-IX.**

## Rule

**Failed attempts are data. Extract and index them with the same rigor as successes.**

Every failed approach is a negative result. Negative results are knowledge. Knowledge compounds. Most systems treat failures as noise to be suppressed. 12-Factor AgentOps treats them as signal to be harvested.

When an agent tries three approaches before the fourth works, you don't just have one success — you have three documented learnings about what doesn't work under specific conditions. That's the wisdom that prevents the next agent from burning cycles on the same dead ends.

## Rationale

### Failures Are Tuition, Learnings Are the Degree

Compute costs money. Failed attempts cost compute. If you pay tuition but don't extract the learning, you're funding the same education twice.

Example: Agent tries to parse configuration with regex. Fails on nested structures. Tries YAML parser. Fails on custom tags. Tries JSON with preprocessing. Works. Next week, different agent encounters similar config. Without harvested wisdom, they repeat the regex attempt. With harvested wisdom, they skip straight to JSON preprocessing.

The second agent saved two failed attempts worth of compute. The savings compound across every agent, every similar task, forever. That's the return on harvesting failures.

### Most Systems Discard Failed Attempts

Standard logging: "ERROR: Parse failed. Retrying with alternative method."

What you lost:
- Which method failed
- What input triggered the failure
- What the error signature looked like
- What context made this method seem reasonable to try
- Why the next method succeeded where this one failed

Without that detail, the next agent starts from zero knowledge. With it, they start from negative knowledge — "don't try X when Y is true" — which is often more valuable than positive knowledge because it prunes the search space.

### Negative Knowledge Accumulates

Positive knowledge: "Use JSON preprocessing for configs with custom tags."

Negative knowledge:
- "Don't use regex on nested structures"
- "Don't use standard YAML parser on custom tags"
- "Don't trust config schema documentation when vendor uses extensions"

Each negative rule prevents a class of failures. As you accumulate negative knowledge, your failure rate drops not because agents get smarter, but because the knowledge base gets wiser.

This is how human expertise works. Experts don't just know what works — they know what doesn't work and why. They've paid the tuition. Harvesting failures lets your agent system build expertise without paying the same tuition repeatedly.

### Post-Mortems on Failures, Not Just Successes

Most teams do post-mortems on outages. Few do them on failed agent attempts. But a failed agent attempt is a micro-outage — a local failure to deliver value.

Post-mortem discipline:
- What was attempted
- Why it seemed reasonable
- What failed
- What the failure revealed
- What should be tried instead next time
- What should never be tried again under these conditions

This isn't expensive. It's a structured extraction at the moment of failure when context is fresh. The alternative is agents repeating failures because nobody captured why they happened.

### Failure Rate as a Metric

Track your agent system's failure rate over time. If it's not decreasing, you're not harvesting failures effectively.

Good trajectory:
- Month 1: 40% of agent attempts fail before success
- Month 3: 25% fail (harvested wisdom preventing repeats)
- Month 6: 15% fail (negative knowledge accumulating)
- Month 12: 10% fail (only novel failures, harvested immediately)

If your failure rate stays flat, you're paying tuition repeatedly. Every plateau in the curve is wasted learning.

### Olympus Runs Harvested Post-Mortems Through Enhancement Loops for Synthetic Learnings

The harvested failures feed back into knowledge systems. Failed attempts become training data. Patterns in failures become rules. Rules become preventative checks. The system learns not just "this failed" but "this class of approaches fails under these conditions."

## What Good Looks Like

### Failed Attempt Capture

Every failed attempt is logged with:
- Approach attempted
- Contextual state (what made this seem reasonable)
- Failure mode (what broke, how it broke)
- Agent's hypothesis about why
- Next approach to try
- Timestamp and session ID

Format:
```yaml
failed_attempt:
  id: "fa-20260215-001"
  session: "ses-abc123"
  task: "Parse custom config format"
  approach: "Regex pattern matching"
  context:
    - "Config appeared to have regular structure"
    - "Prior configs in this repo used simple key=value"
  failure_mode: "Regex failed on nested structures in lines 45-67"
  hypothesis: "Custom format supports nesting not visible in first 40 lines"
  next_approach: "Try YAML parser"
  timestamp: "2026-02-15T14:23:01Z"
```

This isn't a wall of stack traces. It's structured knowledge.

### Post-Mortem Extraction

After task completion (whether success or abandoned), run extraction:

```bash
ao forge transcript <session-id>
# Extracts:
# - All failed attempts
# - Pattern across attempts
# - What eventually worked
# - Negative rules to prevent repeats
```

Extraction produces:
- Individual failed attempt records
- Meta-learning: "When X condition is present, approaches Y and Z fail because W"
- Preventative rule: "Before attempting regex on config, check for nested structures"

### Knowledge Base Integration

Failed attempts feed into knowledge pools:

```bash
ao pool list --type=negative-knowledge
# Shows:
# - Documented failures
# - Conditions under which they failed
# - Alternative approaches that worked
# - Confidence (how many times has this pattern held)
```

When planning new work, agents query negative knowledge:
```bash
ao recall "config parsing failures"
# Returns:
# - "Regex fails on nested structures (confidence: 95%, n=12)"
# - "YAML parser fails on custom tags (confidence: 87%, n=8)"
# - "Recommend: JSON with preprocessing (success rate: 89%, n=15)"
```

### Failure Rate Dashboard

Track and display failure metrics:

```
Agent Failure Rate Trends
┌─────────────────────────────────────────┐
│ Month    Failed  Total  Rate   Trend    │
├─────────────────────────────────────────┤
│ 2025-11    45    112   40.2%    --     │
│ 2025-12    38    125   30.4%    ↓ 9.8  │
│ 2026-01    28    134   20.9%    ↓ 9.5  │
│ 2026-02    15    118   12.7%    ↓ 8.2  │
└─────────────────────────────────────────┘

Top Failure Categories (2026-02):
- Parsing novel formats: 6 (harvested: 6)
- Network timeouts: 4 (harvested: 4)
- Dependency conflicts: 3 (harvested: 3)
- API rate limits: 2 (harvested: 2)

Repeat Failures (same pattern as prior month): 0
```

Zero repeat failures means perfect harvest. Any repeat means you missed a learning.

### Negative Knowledge as Documentation

Failed approaches become documentation:

```markdown
# Config Parsing Patterns

## What Works
- JSON with preprocessing: 89% success rate
- Custom parser for known formats: 95% success rate

## What Doesn't Work
- **Regex on nested structures** (n=12 failures)
  - Fails when: Nesting depth > 2, or nesting not visible in first scan
  - Why: Regex can't handle recursive structures
  - Instead: Use JSON or custom parser

- **Standard YAML parser on custom tags** (n=8 failures)
  - Fails when: Vendor uses custom YAML extensions
  - Why: Parser doesn't recognize extension syntax
  - Instead: Preprocess to strip extensions or use vendor-specific parser
```

This is more valuable than "here's what works" because it prunes the search space. An agent reading this knows to skip two entire classes of approaches.

### Failure Replay for Validation

When you harvest a failure pattern, validate it:

```bash
ao validate-failure-pattern "fa-20260215-001"
# Checks:
# - Does this failure pattern match prior failures?
# - Would the negative rule have prevented this failure?
# - Is the confidence threshold justified?
# - Are there edge cases where this rule shouldn't apply?
```

Validation prevents false negatives — rules that are too broad and prevent valid approaches.

### Time-to-Repeat Metric

Measure time between identical failures:

```
Failure Repeat Analysis
┌────────────────────────────────────────────────┐
│ Pattern                  First    Repeat  Days │
├────────────────────────────────────────────────┤
│ Regex on nested config   11/12    12/08   26  │
│ YAML on custom tags      11/15    12/15   30  │
│ API without rate limit   11/20    (none)  --  │
│ Network without retry    11/22    (none)  --  │
└────────────────────────────────────────────────┘

Harvested patterns with no repeats: 8
Unharvested patterns (repeated within 30d): 2
Harvest effectiveness: 80%
```

Goal: Increase time-to-repeat until it approaches infinity. Harvested failures shouldn't repeat.

### Failure Libraries by Domain

Organize negative knowledge by domain:

```
knowledge/
├── parsing/
│   ├── config-parsing-failures.md
│   ├── log-parsing-failures.md
│   └── schema-inference-failures.md
├── network/
│   ├── timeout-failures.md
│   ├── retry-failures.md
│   └── rate-limit-failures.md
└── dependencies/
    ├── version-conflict-failures.md
    ├── circular-dependency-failures.md
    └── missing-dependency-failures.md
```

Each file documents:
- What was attempted
- Why it failed
- What works instead
- Conditions under which the failure pattern applies

### Confidence Decay on Stale Failures

Failure patterns age. A failure from 2023 might not apply to 2026 tooling.

```yaml
failure_pattern:
  id: "fp-regex-nested-config"
  rule: "Don't use regex on nested config structures"
  confidence: 0.95
  last_validated: "2026-01-15"
  first_observed: "2025-11-12"
  observation_count: 12
  decay_rate: 0.02  # 2% confidence loss per month without revalidation
```

If a failure pattern hasn't been revalidated in 6 months, confidence drops. If it drops below threshold (e.g., 0.6), require revalidation before applying the rule.

This prevents outdated negative knowledge from blocking valid approaches.

### Pre-Flight Failure Checks

Before attempting an approach, check negative knowledge:

```bash
# Agent planning to parse config with regex
ao check-approach "regex config parsing" --context "nested structures present"

# Returns:
# ⚠️  High failure risk (95% confidence, n=12)
# Pattern: "Regex fails on nested config structures"
# Recommendation: Use JSON parser with preprocessing
# Override: Proceed anyway (will be logged as informed decision)
```

Agents can override, but overrides are logged. If an override succeeds, that's data too — maybe the rule needs refinement.

### Failure Clustering

Group similar failures to find patterns:

```bash
ao cluster-failures --time-range="last-30d"

# Output:
# Cluster 1: "Parsing custom formats" (15 failures)
#   - 8: Regex on nested structures
#   - 4: YAML on custom tags
#   - 3: Schema inference on dynamic types
#   Common theme: Tool mismatch for complexity level
#   Recommendation: Add complexity pre-check before tool selection

# Cluster 2: "Network operations" (8 failures)
#   - 4: Timeout without retry
#   - 2: Rate limit without backoff
#   - 2: DNS resolution in flaky network
#   Common theme: Missing resilience patterns
#   Recommendation: Add network operation wrapper with retries
```

Clusters reveal meta-patterns. Individual failures are data points. Clusters are insights.

### Success Rate by Approach

Track which approaches work and which don't:

```
Approach Success Rates (Config Parsing)
┌──────────────────────────────────────────────────┐
│ Approach              Attempts  Success  Rate    │
├──────────────────────────────────────────────────┤
│ JSON preprocessing       18       16     88.9%  │
│ Custom parser            12       11     91.7%  │
│ YAML standard             9        4     44.4%  │
│ Regex                     8        2     25.0%  │
└──────────────────────────────────────────────────┘
```

This isn't just negative knowledge (regex bad) — it's ranked approaches. Agent should try custom parser first (highest rate), then JSON preprocessing (second highest).

### Failure Retrospectives

Quarterly, review all failures:

```bash
ao retro failures --quarter=Q1-2026

# Agenda:
# 1. Failure rate trend (are we learning?)
# 2. Repeat failures (what didn't we harvest?)
# 3. Novel failure patterns (new classes of problems?)
# 4. Obsolete negative knowledge (rules we can retire?)
# 5. Gaps in documentation (where do failures cluster?)
```

Retrospectives turn failures into process improvements. High failure rate in a domain? Add pre-checks. Lots of repeats? Improve harvest automation. Novel patterns? Update agent training.

## Implementation Checklist

Basic harvest:
- [ ] Log all failed attempts with context
- [ ] Extract structured failure records after task completion
- [ ] Store failures in searchable knowledge base
- [ ] Track failure rate over time

Advanced harvest:
- [ ] Cluster failures to find patterns
- [ ] Generate negative knowledge rules
- [ ] Integrate negative knowledge into agent planning
- [ ] Implement confidence decay for stale failures
- [ ] Track time-to-repeat for failure patterns
- [ ] Build domain-specific failure libraries
- [ ] Add pre-flight failure checks
- [ ] Run quarterly failure retrospectives

Expert harvest:
- [ ] Automate failure extraction from session transcripts
- [ ] Generate synthetic training data from failure patterns
- [ ] Build approach ranking based on success rates
- [ ] Implement override tracking for negative knowledge
- [ ] Create failure dashboards for visibility
- [ ] Feed failures into model fine-tuning pipelines
- [ ] Measure harvest effectiveness (repeat rate)
- [ ] Build tooling to validate failure patterns

## Anti-Patterns

### Silent Failures

Agent fails, retries, succeeds. No record of the failure. Next agent repeats it.

Why it's bad: You paid tuition and got no degree. Silent failures are wasted learning opportunities.

Fix: Log every failed attempt, even if subsequent attempt succeeds.

### Failure Blame Culture

Team sees high failure harvesting as "look how much we're failing."

Why it's bad: Discourages transparent logging. Agents hide failures. Learning stops.

Fix: Reframe failures as tuition payments. Celebrate harvest, not absence of failure. Declining failure rate is the success metric.

### Overfitting Negative Knowledge

One failure → "Never do X." Agent blocks valid approaches based on single data point.

Why it's bad: False negatives. You prevent solutions that would work.

Fix: Require minimum observation count (n>3) before promoting failure to rule. Use confidence thresholds.

### Harvesting Without Application

You log failures beautifully. Nobody reads them. Agents repeat failures anyway.

Why it's bad: Harvest without application is theater. Knowledge that doesn't inform decisions is trivia.

Fix: Integrate negative knowledge into agent planning. Require agents to query failures before attempting approaches. Track whether harvest reduces repeat rate.

### Stale Negative Knowledge

Rule from 2023: "API X is unreliable." API was fixed in 2024. Agent still avoids it.

Why it's bad: Negative knowledge becomes superstition. You block approaches that would work now.

Fix: Implement confidence decay. Revalidate old rules. Retire obsolete negative knowledge.

### Analysis Paralysis

Before attempting anything, check 50 failure patterns. Planning takes longer than execution.

Why it's bad: Perfect harvest, zero velocity. The goal is faster learning, not perfect knowledge.

Fix: Quick pre-flight checks on major decisions. Don't block on every micro-decision. Trust agents to log surprises.

## Why This Is Optional

Factors I-IX get you 80% of the value: research before implementation, explicit transitions, tight feedback loops, quality pools, knowledge accumulation. You can run effective agent workflows without harvesting failures.

Factor XII is about the last 20%: compound learning efficiency. You're already learning from successes (Factor X: Knowledge Flywheel). Harvesting failures adds negative knowledge — what doesn't work and why.

This matters at scale. One agent, one project? Manual learning is fine. Ten agents, ten projects, six months? Unharvested failures become expensive. Agents repeat mistakes. Compute costs compound.

Start with Factors I-IX. Add Factor XII when:
- You're running multiple agents on similar tasks
- Failure rate isn't declining over time
- You notice agents repeating mistakes
- Compute costs are rising without proportional output increase
- You want compound learning across agent generations

## The Payoff

Harvesting failures turns compute waste into knowledge assets. Every failed attempt that doesn't repeat is compute saved forever. The return compounds.

Month 1: High failure rate, high learning cost.
Month 6: Declining failure rate, harvested wisdom preventing repeats.
Month 12: New agents start with negative knowledge from all prior failures.

The system gets smarter not because agents get smarter, but because the knowledge base gets wiser. That's the multiplier effect of harvesting failures.

You paid tuition. Extract the degree.
