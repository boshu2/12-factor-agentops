# Factor XI: Fail-Safe Checks

**Prevent repeating mistakes - add guardrails to catch bad patterns early**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | DevOps + SRE |
| **Supporting Pillar** | Learning Science |
| **Enforces Laws** | All Nine Laws |
| **Derived From** | Policy as code + Runtime verification + Fail-safe design |

---

## Summary

The Nine Laws guide agent behavior. Constitutional guardrails are automated systems that help enforce these laws and catch dangerous behaviors early. Just as a constitution constrains government power, guardrails constrain agent autonomy to support safety, quality, and continuous improvement.

## The Problem

Without constitutional guardrails:
- Agents may bypass validation to "move faster"
- Guidelines get ignored when inconvenient
- No enforcement mechanism
- Risky behaviors slip through
- Trust erodes through violations

**Familiar pattern:**
```
Agent: "This validation is slow, I'll skip it"
Agent: *Executes action without validation*
System: *Breaks*
Team: "Why didn't validation catch this?"
Answer: Agent bypassed validation
```

**Traditional approach:** Hope agents follow rules voluntarily

**12-Factor AgentOps approach:** Automated enforcement catches violations early

---

## Why This Factor Exists

### Grounding in the Pillars

**Primary: DevOps + SRE**

Constitutional guardrails apply the DevOps "policy as code" principle: encode policies in automation, not documentation. Infrastructure as Code taught us that documented policies have ~60% compliance while automated enforcement achieves much higher rates. The shift from "please follow this guideline" to "the system catches violations" is transformative.

SRE provides the fail-safe design pattern: make it harder to do the wrong thing. Poka-yoke (error-proofing from manufacturing) teaches that prevention beats detection. For agents, this means pre-action checks that catch invalid operations, runtime monitoring that flags risky patterns, and post-action verification that confirms compliance.

**Supporting: All Pillars**

Constitutional guardrails touch all pillars:
- **DevOps+SRE:** Policy as code, fail-safe design, defense in depth
- **Learning Science:** Progressive validation checkpoints, feedback loops
- **Context Engineering:** Utilization monitoring helps prevent overload
- **Knowledge OS:** Hooks encourage institutional memory standards

---

## The Nine Laws

Constitutional guardrails help enforce all nine laws through automation:

**Law 1: Learn & Improve** - Extract patterns, identify improvements
- Guardrail: Encourage learnings in session records
- Enforcement: Post-action hook checks for Learning section

**Law 2: Document** - Context records, progress tracking, bundles
- Guardrail: Encourage context documentation
- Enforcement: Pre-action hook checks for Context section

**Law 3: State Discipline** - Save state often, maintain clean workspace
- Guardrail: Frequent checkpoint reminders
- Enforcement: Session monitoring, progress tracking

**Law 4: Validate First** - Check before acting, verify before executing
- Guardrail: Validate before execution
- Enforcement: Pre-action gates, validation checks

**Law 5: Guide** - Suggest options, user chooses
- Guardrail: Present choices rather than assuming
- Enforcement: Workflow validation

**Law 6: Classify Level** - Assess complexity (0-5) before work
- Guardrail: Prompt for level assessment on new tasks
- Enforcement: Session initialization

**Law 7: Measure** - Track metrics, break spirals early
- Guardrail: Spiral detection on repeated failures
- Enforcement: Action pattern monitoring

**Law 8: Session Protocol** - One task focus, review before end
- Guardrail: Session checkpoint reminders
- Enforcement: Progress tracking, end-of-session prompts

**Law 9: Protect Definitions** - Requirements unchanged, mark passes only
- Guardrail: Prevent modification of requirement definitions
- Enforcement: Definition protection, change validation

---

## Guardrail Implementation Layers

**Layer 1: Pre-Execution Guardrails** (catch before it happens)
```
Agent wants to act → Pre-action hook validates → Warn if issues
Agent wants to execute → Pre-execution validation → Flag if concerns
Agent context growing → Utilization check → Suggest pause at threshold
```

**Layer 2: Runtime Guardrails** (catch during execution)
```
Agent running → Monitor resource utilization → Warn at thresholds
Agent executing → Monitor for failure chains → Flag potential spiral
Agent processing → Monitor quality → Alert if degradation
```

**Layer 3: Post-Execution Guardrails** (verify after completion)
```
Session complete → Check for learnings → Remind if missing
Week complete → Check for improvements → Suggest if none found
Pattern discovered → Track documentation → Remind about sharing
```

---

## Why This Works

### 1. Policy as Code

**Infrastructure principle:**
> "Encode policies in automation, not documentation"

**For AI agents:**
```
Documentation (weak):
  "Consider including Learning in records"
  Result: ~60% compliance

Policy as Code (strong):
  Pre-action hook: "Check for Learning section"
  Result: Much higher compliance
```

### 2. Fail-Safe Design

**Safety principle:**
> "Design systems that fail safely, not dangerously"

**Fail-safe examples:**
```
Unsafe default: Agent can easily bypass validation
Fail-safe default: Validation runs automatically

Unsafe default: No resource monitoring
Fail-safe default: Warnings at utilization thresholds

Unsafe default: Direct high-risk execution
Fail-safe default: Human review step for critical actions
```

### 3. Defense in Depth

**Security principle:**
> "Multiple layers of protection, not single point of failure"

**For guardrails:**
```
Layer 1: Pre-action hooks (before execution)
Layer 2: Runtime monitoring (during execution)
Layer 3: Post-action verification (after execution)
Layer 4: Retrospective analysis (periodic review)

Result: Multiple opportunities to catch issues
```

---

## Implementation

### Pre-Action Guardrails

**Validation hook:**
```python
def pre_action_guardrail(action):
    """Guardrails for actions"""

    warnings = []

    # Law 1 & 2: Check for Learning and Context
    if not has_learning_section(action.context):
        warnings.append("Consider adding a 'Learning:' section")

    if not has_context_section(action.context):
        warnings.append("Consider adding a 'Context:' section")

    # Law 4: Run validation
    validation_result = validate_action(action)
    if not validation_result.passed:
        warnings.append(f"Validation issue: {validation_result.message}")

    return GuardrailResult(warnings=warnings)
```

### Runtime Guardrails

**Resource monitoring:**
```python
class ResourceGuardrail:
    def __init__(self, soft_limit=0.35, hard_limit=0.40):
        self.soft_limit = soft_limit
        self.hard_limit = hard_limit

    def check_utilization(self, current_usage, max_capacity):
        utilization = current_usage / max_capacity

        if utilization > self.hard_limit:
            return Warning(
                message=f"Utilization at {utilization:.1%} - consider pausing",
                remedy="Take a checkpoint and review progress"
            )
        elif utilization > self.soft_limit:
            return Info(
                message=f"Utilization at {utilization:.1%} - good time for a checkpoint"
            )

        return None
```

### Domain-Specific Guardrails

**Customer Service Agent:**
```python
def validate_refund_action(action):
    # Check refund within authorization
    if action.amount > agent.max_authorization:
        return RequireEscalation("Amount exceeds authorization limit")

    # Check for duplicate processing
    if has_recent_similar_action(action, hours=24):
        return Warning("Similar action found in last 24 hours - verify")

    # Check customer satisfaction context
    if action.customer.recent_complaints > 2:
        return Info("Multiple recent complaints - consider extra care")

    return Success()
```

**Research Agent:**
```python
def validate_publication_action(action):
    # Check source verification
    if not all_sources_verified(action.sources):
        return Error("Unverified sources - cannot publish")

    # Check for required approvals
    if action.is_external and not has_approval(action):
        return RequireApproval("External publication requires approval")

    # Check quality metrics
    if action.quality_score < MINIMUM_QUALITY:
        return Warning("Quality score below threshold - review recommended")

    return Success()
```

**Sales Agent:**
```python
def validate_discount_action(action):
    # Check discount within policy
    if action.discount_percent > MAX_DISCOUNT:
        return Error("Discount exceeds maximum allowed")

    # Check margin requirements
    if calculate_margin(action) < MIN_MARGIN:
        return RequireApproval("Low margin requires manager approval")

    # Check customer eligibility
    if not customer_qualifies(action.customer, action.discount_type):
        return Error("Customer not eligible for this discount type")

    return Success()
```

---

## Validation

### ✅ You're doing this right if:
- High compliance with Nine Laws (automated support)
- Issues caught early (not just warned about later)
- Compliance dashboard shows healthy metrics
- Guardrails feel helpful, not punitive
- Trust builds through consistent patterns

### ❌ You're doing this wrong if:
- Laws frequently bypassed (weak or missing guardrails)
- Manual enforcement required (not automated)
- Guardrails easily circumvented
- Compliance unknown (no monitoring)
- Team resents guardrails (too strict, not helpful)

---

## Guardrail Categories

### Category 1: Pre-Execution Guardrails

**Purpose:** Catch issues before they happen

**Examples:**
- Pre-action hooks (validate actions)
- Pre-execution gates (validate operations)
- Resource checks (monitor utilization)
- Input validation (check parameters)

### Category 2: Runtime Guardrails

**Purpose:** Detect issues during execution

**Examples:**
- Resource monitoring (warn at thresholds)
- Operation monitoring (alert on errors)
- Spiral detection (flag repeated failures)
- Circuit breakers (fail-safe patterns)

### Category 3: Post-Execution Guardrails

**Purpose:** Verify patterns after completion

**Examples:**
- Compliance dashboard (track adherence)
- Session retrospectives (verify learning extraction)
- Pattern tracking (encourage documentation)
- Improvement review (identify opportunities)

---

## Exemption Process

**Sometimes guardrails need to be adjusted:**

```python
class GuardrailExemption:
    def request_exemption(self, guardrail, justification):
        request = {
            'guardrail': guardrail.name,
            'justification': justification,
            'requested_by': get_current_user(),
            'requested_at': datetime.now()
        }

        # Log for review
        log_exemption_request(request)

        # Temporary adjustment (expires in 1 hour)
        return ExemptionToken(
            valid_until=datetime.now() + timedelta(hours=1),
            guardrail=guardrail
        )
```

**Exemption criteria:**
- **Emergency:** Critical issue, need immediate action
- **Exceptional:** One-time unique circumstance
- **Temporary:** Should expire quickly
- **Logged:** Full audit trail for review
- **Reviewed:** Retrospective to prevent future need

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Hooks support Laws 1 & 2
- **Factor IV: Continuous Validation**: Supports Law 4
- **Factor VI: Resume Work**: Supports state management
- **Factor IX: Mine Patterns**: Supports pattern sharing
- **Factor X: Small Iterations**: Supports continuous improvement

---

## Next Steps

1. **Document the Nine Laws** for your team
2. **Implement pre-action hooks** with helpful feedback
3. **Add validation gates** for critical operations
4. **Create compliance dashboard** tracking patterns
5. **Set up spiral detection** for failure chains

---

## Further Reading

- **DevOps + SRE Pillar**: [../docs/principles/four-pillars.md](../docs/principles/four-pillars.md)
- **Nine Laws**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md)
- **Factor IV: Continuous Validation**: [./04-continuous-validation.md](./04-continuous-validation.md)
- **Policy as Code**: [Open Policy Agent](https://www.openpolicyagent.org/)

---

**Remember:** The Nine Laws are guidelines that help agents succeed. Guardrails support the laws through automation. Make it easy to do the right thing. Prevention beats correction. Build trust through consistent patterns.
