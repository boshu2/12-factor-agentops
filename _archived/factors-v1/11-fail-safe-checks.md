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

## Implementation Patterns

These patterns emerge from production deployments in Houston (local-first), Fractal (Kubernetes-native), and ai-platform (IC-hardened). They extend the conceptual guardrail principles with battle-tested infrastructure patterns.

### Pattern 1: Reconciliation Loops (Kubernetes Level-Triggered)

**The Problem:** Edge-triggered systems (react to events) miss events during failures. If you miss the "agent started" event, you never know to monitor it.

**The Solution:** Level-triggered reconciliation loops that continuously converge to desired state.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    RECONCILIATION LOOP PATTERN                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  EDGE-TRIGGERED (Fragile)              LEVEL-TRIGGERED (Robust)             │
│                                                                             │
│  Event occurs ──► Handler runs         Current State ◄───┐                  │
│       │                                      │           │                  │
│       │ (if missed, lost forever)            ▼           │                  │
│       ▼                                ┌──────────┐      │                  │
│  State changes                         │ COMPARE  │      │                  │
│                                        │ desired  │      │                  │
│  Problem: Miss an event?               │ vs actual│      │                  │
│  System never recovers.                └────┬─────┘      │                  │
│                                             │            │                  │
│                                        ┌────▼─────┐      │                  │
│                                        │  DIFF?   │──No──┘                  │
│                                        └────┬─────┘                         │
│                                             │ Yes                           │
│                                             ▼                               │
│                                        ┌──────────┐                         │
│                                        │  TAKE    │                         │
│                                        │  ACTION  │──────►  Desired State   │
│                                        └──────────┘                         │
│                                             │                               │
│                                        (Loop every N seconds)               │
│                                                                             │
│  BENEFIT: If you miss something, next loop catches it                      │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Reconciliation Controller (Fractal):**

```go
// AgentGuardrailController reconciles agent behavior
type AgentGuardrailController struct {
    client    kubernetes.Interface
    informer  cache.SharedInformer
    recorder  record.EventRecorder
}

func (c *AgentGuardrailController) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
    // 1. Get current state
    agent := &v1alpha1.KAgent{}
    if err := c.client.Get(ctx, req.NamespacedName, agent); err != nil {
        return ctrl.Result{}, client.IgnoreNotFound(err)
    }

    // 2. Get desired state (from guardrail policies)
    policy := c.getGuardrailPolicy(agent.Namespace)

    // 3. Compare and reconcile
    violations := c.checkViolations(agent, policy)

    if len(violations) > 0 {
        // 4. Take corrective action
        for _, v := range violations {
            switch v.Severity {
            case Critical:
                // Terminate immediately
                c.terminateAgent(ctx, agent)
                c.recorder.Event(agent, "Warning", "GuardrailViolation",
                    fmt.Sprintf("Critical violation: %s - agent terminated", v.Message))

            case Warning:
                // Add warning annotation, continue monitoring
                c.addWarningAnnotation(agent, v.Message)
                c.recorder.Event(agent, "Warning", "GuardrailWarning", v.Message)

            case Info:
                // Log for audit, no action
                c.recorder.Event(agent, "Normal", "GuardrailInfo", v.Message)
            }
        }
    }

    // 5. Update status
    agent.Status.LastGuardrailCheck = metav1.Now()
    agent.Status.ViolationCount = len(violations)

    // 6. Requeue for next check (every 30 seconds)
    return ctrl.Result{RequeueAfter: 30 * time.Second}, nil
}

func (c *AgentGuardrailController) checkViolations(agent *v1alpha1.KAgent, policy *GuardrailPolicy) []Violation {
    var violations []Violation

    // Check token budget
    if agent.Status.TokensUsed > policy.MaxTokens {
        violations = append(violations, Violation{
            Severity: Critical,
            Message:  fmt.Sprintf("Token limit exceeded: %d > %d", agent.Status.TokensUsed, policy.MaxTokens),
        })
    }

    // Check cost budget
    if agent.Status.CostIncurred > policy.MaxCost {
        violations = append(violations, Violation{
            Severity: Critical,
            Message:  fmt.Sprintf("Cost limit exceeded: $%.2f > $%.2f", agent.Status.CostIncurred, policy.MaxCost),
        })
    }

    // Check runtime duration
    if agent.Status.RunningDuration > policy.MaxDuration {
        violations = append(violations, Violation{
            Severity: Warning,
            Message:  fmt.Sprintf("Duration exceeded: %v > %v", agent.Status.RunningDuration, policy.MaxDuration),
        })
    }

    // Check tool call patterns
    if c.detectSpiral(agent) {
        violations = append(violations, Violation{
            Severity: Warning,
            Message:  "Potential failure spiral detected - same tool failing repeatedly",
        })
    }

    return violations
}
```

**Why Level-Triggered Wins:**

| Aspect | Edge-Triggered | Level-Triggered |
|--------|----------------|-----------------|
| **Missed events** | Lost forever | Caught next loop |
| **Restart recovery** | Must replay events | Just compare states |
| **Debugging** | "What event did we miss?" | "What's the current state?" |
| **Complexity** | Event ordering matters | Order doesn't matter |
| **Idempotency** | Must track what's processed | Natural idempotency |

---

### Pattern 2: Fail-Closed Defaults

**The Problem:** When something goes wrong, systems often fail open (continue operating without safety checks). This leads to cascading failures.

**The Solution:** Fail-closed defaults—when uncertain, deny/stop/wait rather than proceed.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         FAIL-CLOSED DEFAULTS                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FAIL-OPEN (Dangerous)                 FAIL-CLOSED (Safe)                   │
│                                                                             │
│  ┌─────────────┐                      ┌─────────────┐                      │
│  │   Request   │                      │   Request   │                      │
│  └──────┬──────┘                      └──────┬──────┘                      │
│         │                                    │                              │
│         ▼                                    ▼                              │
│  ┌─────────────┐                      ┌─────────────┐                      │
│  │  Validation │                      │  Validation │                      │
│  │   Service   │                      │   Service   │                      │
│  └──────┬──────┘                      └──────┬──────┘                      │
│         │                                    │                              │
│         ▼                                    ▼                              │
│  ┌─────────────┐                      ┌─────────────┐                      │
│  │  Service    │──── timeout ────►    │  Service    │──── timeout ────►    │
│  │  unavailable│                      │  unavailable│                      │
│  └──────┬──────┘                      └──────┬──────┘                      │
│         │                                    │                              │
│         ▼                                    ▼                              │
│  ┌─────────────┐                      ┌─────────────┐                      │
│  │  DEFAULT:   │                      │  DEFAULT:   │                      │
│  │   ALLOW     │ ← Dangerous!         │    DENY     │ ← Safe!              │
│  └─────────────┘                      └─────────────┘                      │
│         │                                    │                              │
│         ▼                                    ▼                              │
│  Unvalidated request                  Request blocked,                      │
│  proceeds, potential                  human notified,                       │
│  security breach                      retry when service                    │
│                                       is available                          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Fail-Closed Implementation:**

```python
class FailClosedGuardrail:
    """Guardrail that fails closed (denies) on any uncertainty."""

    def __init__(self, validation_service: ValidationService):
        self.validation = validation_service
        self.timeout = timedelta(seconds=30)

    def check(self, action: Action) -> GuardrailResult:
        try:
            # Try to validate
            result = self.validation.validate(action, timeout=self.timeout)
            return result

        except TimeoutError:
            # Validation timed out - FAIL CLOSED (deny)
            return GuardrailResult(
                allowed=False,
                reason="Validation service timeout - fail closed",
                retry_after=timedelta(minutes=5)
            )

        except ConnectionError:
            # Service unavailable - FAIL CLOSED (deny)
            return GuardrailResult(
                allowed=False,
                reason="Validation service unavailable - fail closed",
                retry_after=timedelta(minutes=1)
            )

        except Exception as e:
            # Unknown error - FAIL CLOSED (deny)
            logger.error(f"Unexpected validation error: {e}")
            return GuardrailResult(
                allowed=False,
                reason=f"Unexpected error - fail closed: {e}",
                needs_human_review=True
            )


class BudgetGuardrail:
    """Budget enforcement with fail-closed defaults."""

    def check_budget(self, agent: Agent, action: Action) -> GuardrailResult:
        # If we can't determine current usage, fail closed
        try:
            current_usage = self.get_usage(agent)
        except Exception:
            return GuardrailResult(
                allowed=False,
                reason="Cannot determine current usage - fail closed"
            )

        # If we can't determine action cost, fail closed
        try:
            estimated_cost = self.estimate_cost(action)
        except Exception:
            return GuardrailResult(
                allowed=False,
                reason="Cannot estimate action cost - fail closed"
            )

        # Check if within budget
        if current_usage + estimated_cost > agent.budget_limit:
            return GuardrailResult(
                allowed=False,
                reason=f"Would exceed budget: {current_usage + estimated_cost} > {agent.budget_limit}"
            )

        return GuardrailResult(allowed=True)
```

**Fail-Closed Kubernetes Resources:**

```yaml
# Admission webhook with fail-closed policy
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: agent-guardrails
webhooks:
  - name: guardrails.fractal.ai
    rules:
      - apiGroups: ["fractal.ai"]
        resources: ["kagents", "shardruns", "toolcalls"]
        operations: ["CREATE", "UPDATE"]
    clientConfig:
      service:
        name: guardrail-webhook
        namespace: ai-platform
        path: "/validate"
    # CRITICAL: Fail closed - if webhook unreachable, deny
    failurePolicy: Fail  # NOT "Ignore"
    timeoutSeconds: 10
    sideEffects: None

---
# Network policy with fail-closed default
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
  namespace: ai-agents
spec:
  podSelector: {}  # Apply to all pods
  policyTypes:
    - Ingress
    - Egress
  # No rules = deny all (fail closed)
  # Must explicitly allow what's needed
```

---

### Pattern 3: Circuit Breaker Pattern

**The Problem:** When an external service fails, agents may keep retrying, wasting resources and potentially causing cascading failures.

**The Solution:** Circuit breaker that opens after repeated failures, preventing retry storms.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         CIRCUIT BREAKER STATES                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                    ┌──────────────────────────┐                            │
│                    │         CLOSED           │                            │
│                    │    (Normal operation)    │                            │
│                    │                          │                            │
│                    │  Requests flow through   │                            │
│                    │  Failures counted        │                            │
│                    └────────────┬─────────────┘                            │
│                                 │                                           │
│                    failures > threshold                                     │
│                                 │                                           │
│                                 ▼                                           │
│                    ┌──────────────────────────┐                            │
│                    │          OPEN            │                            │
│                    │   (Fail fast mode)       │                            │
│                    │                          │                            │
│                    │  Requests fail           │                            │
│                    │  immediately             │                            │
│                    │  No calls to service     │                            │
│                    └────────────┬─────────────┘                            │
│                                 │                                           │
│                    timeout expires                                          │
│                                 │                                           │
│                                 ▼                                           │
│                    ┌──────────────────────────┐                            │
│                    │       HALF-OPEN          │                            │
│                    │   (Testing recovery)     │                            │
│                    │                          │                            │
│                    │  Allow one test request  │                            │
│                    │  Success → CLOSED        │                            │
│                    │  Failure → OPEN          │                            │
│                    └──────────────────────────┘                            │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Circuit Breaker Implementation:**

```python
from enum import Enum
from dataclasses import dataclass
from datetime import datetime, timedelta
from threading import Lock

class CircuitState(Enum):
    CLOSED = "closed"      # Normal operation
    OPEN = "open"          # Failing fast
    HALF_OPEN = "half_open"  # Testing recovery

@dataclass
class CircuitBreaker:
    """Circuit breaker for external service calls."""

    name: str
    failure_threshold: int = 5      # Failures before opening
    reset_timeout: timedelta = timedelta(minutes=1)
    half_open_max_calls: int = 1

    def __post_init__(self):
        self.state = CircuitState.CLOSED
        self.failure_count = 0
        self.last_failure_time: Optional[datetime] = None
        self.half_open_calls = 0
        self._lock = Lock()

    def can_execute(self) -> bool:
        """Check if request should proceed."""
        with self._lock:
            if self.state == CircuitState.CLOSED:
                return True

            if self.state == CircuitState.OPEN:
                # Check if timeout expired
                if datetime.now() - self.last_failure_time > self.reset_timeout:
                    self.state = CircuitState.HALF_OPEN
                    self.half_open_calls = 0
                    return True
                return False

            if self.state == CircuitState.HALF_OPEN:
                # Allow limited test requests
                if self.half_open_calls < self.half_open_max_calls:
                    self.half_open_calls += 1
                    return True
                return False

        return False

    def record_success(self):
        """Record successful call."""
        with self._lock:
            if self.state == CircuitState.HALF_OPEN:
                # Recovery successful, close circuit
                self.state = CircuitState.CLOSED
                self.failure_count = 0

    def record_failure(self):
        """Record failed call."""
        with self._lock:
            self.failure_count += 1
            self.last_failure_time = datetime.now()

            if self.state == CircuitState.HALF_OPEN:
                # Test failed, reopen circuit
                self.state = CircuitState.OPEN
            elif self.failure_count >= self.failure_threshold:
                # Threshold exceeded, open circuit
                self.state = CircuitState.OPEN


class CircuitBreakerGuardrail:
    """Guardrail that uses circuit breaker for external calls."""

    def __init__(self):
        self.breakers: Dict[str, CircuitBreaker] = {}

    def get_breaker(self, service_name: str) -> CircuitBreaker:
        if service_name not in self.breakers:
            self.breakers[service_name] = CircuitBreaker(name=service_name)
        return self.breakers[service_name]

    async def call_with_breaker(self, service_name: str, func, *args, **kwargs):
        """Execute function with circuit breaker protection."""
        breaker = self.get_breaker(service_name)

        if not breaker.can_execute():
            raise CircuitOpenError(
                f"Circuit breaker open for {service_name}. "
                f"Will retry after {breaker.reset_timeout}"
            )

        try:
            result = await func(*args, **kwargs)
            breaker.record_success()
            return result
        except Exception as e:
            breaker.record_failure()
            raise
```

---

### Pattern 4: Spiral Detection and Break

**The Problem:** Agents can get stuck in failure loops—retrying the same failing action repeatedly.

**The Solution:** Spiral detection that identifies repeated failures and forces escalation.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         SPIRAL DETECTION                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  FAILURE SPIRAL                        SPIRAL BREAK                         │
│                                                                             │
│  Action fails                          Action fails                         │
│       │                                     │                               │
│       ▼                                     ▼                               │
│  Retry action ────────────────────►   ┌──────────────┐                     │
│       │                               │ Increment    │                     │
│       ▼                               │ failure count│                     │
│  Action fails                         └──────┬───────┘                     │
│       │                                      │                              │
│       ▼                                      ▼                              │
│  Retry action ────────────────────►   ┌──────────────┐                     │
│       │                               │ Count > 3?   │                     │
│       ▼                               └──────┬───────┘                     │
│  Action fails                                │ Yes                          │
│       │                                      ▼                              │
│       ▼                               ┌──────────────┐                     │
│  Retry action...                      │ SPIRAL       │                     │
│       │                               │ DETECTED!    │                     │
│       ▼                               │              │                     │
│  (Continues forever,                  │ • Stop agent │                     │
│   wasting tokens,                     │ • Notify     │                     │
│   never succeeds)                     │ • Escalate   │                     │
│                                       │ • Log for    │                     │
│                                       │   analysis   │                     │
│                                       └──────────────┘                     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Spiral Detection Implementation:**

```python
from collections import defaultdict
from dataclasses import dataclass
from typing import List, Optional

@dataclass
class ToolCallRecord:
    tool: str
    args_hash: str
    timestamp: datetime
    success: bool
    error: Optional[str] = None

class SpiralDetector:
    """Detects and breaks failure spirals."""

    def __init__(
        self,
        max_consecutive_failures: int = 3,
        max_similar_failures: int = 5,
        time_window: timedelta = timedelta(minutes=10)
    ):
        self.max_consecutive = max_consecutive_failures
        self.max_similar = max_similar_failures
        self.time_window = time_window
        self.history: Dict[str, List[ToolCallRecord]] = defaultdict(list)

    def record_call(self, agent_id: str, tool: str, args: dict, success: bool, error: str = None):
        """Record a tool call for spiral analysis."""
        record = ToolCallRecord(
            tool=tool,
            args_hash=self._hash_args(args),
            timestamp=datetime.now(),
            success=success,
            error=error
        )
        self.history[agent_id].append(record)

        # Prune old records
        self._prune_old_records(agent_id)

    def check_spiral(self, agent_id: str) -> Optional[SpiralAlert]:
        """Check if agent is in a failure spiral."""
        records = self.history.get(agent_id, [])
        if not records:
            return None

        # Check consecutive failures
        recent_records = records[-self.max_consecutive:]
        if all(not r.success for r in recent_records):
            return SpiralAlert(
                type="consecutive_failures",
                count=len(recent_records),
                message=f"Last {len(recent_records)} tool calls failed consecutively",
                recommendation="Stop agent and escalate to human review"
            )

        # Check similar failures (same tool, same args)
        failures_by_signature = defaultdict(list)
        for r in records:
            if not r.success:
                signature = f"{r.tool}:{r.args_hash}"
                failures_by_signature[signature].append(r)

        for signature, failures in failures_by_signature.items():
            if len(failures) >= self.max_similar:
                return SpiralAlert(
                    type="similar_failures",
                    count=len(failures),
                    signature=signature,
                    message=f"Same action failed {len(failures)} times",
                    recommendation="Agent stuck on impossible task - needs different approach"
                )

        return None

    def _hash_args(self, args: dict) -> str:
        """Create hash of arguments for similarity detection."""
        import hashlib
        import json
        return hashlib.md5(json.dumps(args, sort_keys=True).encode()).hexdigest()[:8]


class SpiralBreaker:
    """Guardrail that breaks failure spirals."""

    def __init__(self, detector: SpiralDetector):
        self.detector = detector

    def post_tool_call_hook(self, agent_id: str, tool: str, args: dict, result: ToolResult):
        """Called after every tool call to check for spirals."""
        # Record the call
        self.detector.record_call(
            agent_id=agent_id,
            tool=tool,
            args=args,
            success=result.success,
            error=result.error if not result.success else None
        )

        # Check for spiral
        alert = self.detector.check_spiral(agent_id)
        if alert:
            # Break the spiral
            self._break_spiral(agent_id, alert)

    def _break_spiral(self, agent_id: str, alert: SpiralAlert):
        """Take action to break the spiral."""
        logger.warning(f"Spiral detected for agent {agent_id}: {alert.message}")

        # 1. Pause the agent
        self.pause_agent(agent_id)

        # 2. Notify humans
        self.notify_spiral(agent_id, alert)

        # 3. Create incident
        self.create_incident(agent_id, alert)

        # 4. Clear spiral history (prevent re-triggering)
        self.detector.history[agent_id] = []
```

---

### Anti-Patterns for Fail-Safe Checks

**❌ Anti-Pattern 1: Fail Open**
```
Wrong: If validation fails, proceed anyway
       try:
           validate(action)
       except:
           pass  # Continue without validation

Right: Fail closed on any uncertainty
       try:
           validate(action)
       except:
           raise GuardrailViolation("Validation failed - cannot proceed")
```

**❌ Anti-Pattern 2: Edge-Triggered Only**
```
Wrong: Only react to events
       @on_event("agent_started")
       def check_guardrails():
           # What if we miss this event?

Right: Level-triggered reconciliation
       def reconcile_loop():
           while True:
               current = get_current_state()
               desired = get_desired_state()
               if current != desired:
                   take_action()
               sleep(30)
```

**❌ Anti-Pattern 3: No Spiral Detection**
```
Wrong: Let agent retry forever
       while not success:
           result = try_action()
           if not result.success:
               continue  # Infinite loop possible

Right: Detect and break spirals
       failures = 0
       while not success and failures < MAX_FAILURES:
           result = try_action()
           if not result.success:
               failures += 1
       if failures >= MAX_FAILURES:
           escalate_to_human()
```

---

### Production Checklist for Fail-Safe Checks

```markdown
## Fail-Safe Infrastructure Checklist

### Reconciliation Loops
- [ ] Controller uses level-triggered (not edge-triggered)
- [ ] Reconciliation interval configured (e.g., 30 seconds)
- [ ] Controller handles its own restart gracefully
- [ ] Status updated after each reconciliation

### Fail-Closed Defaults
- [ ] Admission webhook has failurePolicy: Fail
- [ ] Network policies default deny-all
- [ ] Budget checks fail closed on uncertainty
- [ ] Validation failures block execution

### Circuit Breakers
- [ ] External service calls wrapped in circuit breaker
- [ ] Failure thresholds configured per service
- [ ] Half-open testing prevents retry storms
- [ ] Circuit state visible in metrics/logs

### Spiral Detection
- [ ] Tool call history tracked per agent
- [ ] Consecutive failure threshold configured
- [ ] Similar failure detection enabled
- [ ] Automatic escalation on spiral detected
```

---

**Remember:** The Nine Laws are guidelines that help agents succeed. Guardrails support the laws through automation. Make it easy to do the right thing. Prevention beats correction. Build trust through consistent patterns.
