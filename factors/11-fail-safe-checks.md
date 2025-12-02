# Factor XI: Fail-Safe Checks

**Prevent repeating mistakes - add hooks and validations to catch bad patterns early**

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
Agent: *Deploys to production without validation*
Production: *Breaks*
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

SRE provides the fail-safe design pattern: make it harder to do the wrong thing. Poka-yoke (error-proofing from manufacturing) teaches that prevention beats detection. For agents, this means pre-commit hooks that catch invalid commits, CI/CD gates that flag untested deployments, runtime checks that warn about context overruns.

**Supporting: All Pillars**

Constitutional guardrails touch all pillars:
- **DevOps+SRE:** Policy as code, fail-safe design, defense in depth
- **Learning Science:** Progressive validation checkpoints, feedback loops
- **Context Engineering:** 40% rule monitoring helps prevent collapse
- **Knowledge OS:** Git hooks encourage institutional memory standards

---

## The Nine Laws

Constitutional guardrails help enforce all nine laws through automation:

**Law 1: Learn & Improve** - Extract patterns, identify improvements
- Guardrail: Encourage learnings in commits
- Enforcement: Pre-commit hook checks for Learning section

**Law 2: Document** - Context commits, progress files, bundles
- Guardrail: Encourage context documentation
- Enforcement: Pre-commit hook checks for Context section

**Law 3: Git Discipline** - Commit often, clean workspace
- Guardrail: Frequent checkpoint reminders
- Enforcement: Session monitoring, progress tracking

**Law 4: TDD + Tracers** - Tests first, tracers for complex tasks
- Guardrail: Validate before execution
- Enforcement: CI/CD pipeline gates, pre-deploy checks

**Law 5: Guide** - Suggest options, user chooses
- Guardrail: Present choices rather than assuming
- Enforcement: Workflow validation

**Law 6: Classify Level** - Assess vibe level (0-5) before work
- Guardrail: Prompt for level assessment on new tasks
- Enforcement: Session initialization

**Law 7: Measure** - Track metrics, break spirals early
- Guardrail: Spiral detection on fix chains
- Enforcement: Commit pattern monitoring

**Law 8: Session Protocol** - One feature, review before end
- Guardrail: Session checkpoint reminders
- Enforcement: Progress tracking, end-of-session prompts

**Law 9: Protect Definitions** - Features unchanged, mark passes only
- Guardrail: Prevent modification of feature definitions
- Enforcement: File protection, change validation

---

## Guardrail Implementation Layers

**Layer 1: Pre-Execution Guardrails** (catch before it happens)
```
Agent wants to commit → Pre-commit hook validates → Warn if issues
Agent wants to deploy → Pre-deploy validation → Flag if concerns
Agent context growing → Utilization check → Suggest compression at 35%
```

**Layer 2: Runtime Guardrails** (catch during execution)
```
Agent running → Monitor context utilization → Warn at 40%
Agent executing → Monitor for fix chains → Flag potential spiral
Agent deploying → Monitor deployment → Alert if errors
```

**Layer 3: Post-Execution Guardrails** (verify after completion)
```
Session complete → Check for learnings → Remind if missing
Week complete → Check for improvements → Suggest if none found
Pattern discovered → Track publication → Remind about sharing
```

---

## Why This Works

### 1. Policy as Code

**Infrastructure principle:**
> "Encode policies in automation, not documentation"

**For AI agents:**
```
Documentation (weak):
  "Consider including Learning in commits"
  Result: ~60% compliance

Policy as Code (strong):
  Pre-commit hook: "Check for Learning section"
  Result: Much higher compliance
```

### 2. Fail-Safe Design

**Safety principle:**
> "Design systems that fail safely, not dangerously"

**Fail-safe examples:**
```
Unsafe default: Agent can easily bypass validation
Fail-safe default: Validation runs automatically

Unsafe default: No context monitoring
Fail-safe default: Warnings at context thresholds

Unsafe default: Direct production deployment
Fail-safe default: Human review step for production
```

### 3. Defense in Depth

**Security principle:**
> "Multiple layers of protection, not single point of failure"

**For guardrails:**
```
Layer 1: Pre-commit hooks (development)
Layer 2: CI/CD gates (integration)
Layer 3: Production safeguards (runtime)
Layer 4: Post-execution verification (retrospective)

Result: Multiple opportunities to catch issues
```

---

## Implementation

### Pre-Commit Guardrails

**Git hook (`.git/hooks/pre-commit`):**
```bash
#!/bin/bash
# Guardrails for commits

echo "🔒 Running guardrails..."

# Read commit message
commit_msg=$(cat "$1")

# Law 1 & 2: Check for Learning and Context
if ! echo "$commit_msg" | grep -q "Learning:"; then
    echo "💡 Tip: Consider adding a 'Learning:' section"
fi

if ! echo "$commit_msg" | grep -q "Context:"; then
    echo "💡 Tip: Consider adding a 'Context:' section"
fi

# Law 4: Run validation
echo "  Running validation..."

if ! npm test --quiet 2>/dev/null; then
    echo "⚠️  Tests didn't pass - consider fixing before commit"
fi

echo "✅ Checks complete"
exit 0
```

### Runtime Guardrails

**Context monitoring:**
```python
class ContextGuardrail:
    def __init__(self, soft_limit=0.35, hard_limit=0.40):
        self.soft_limit = soft_limit
        self.hard_limit = hard_limit
        self.context_limit = 200000  # tokens

    def check_context(self, current_context):
        utilization = len(current_context) / self.context_limit

        if utilization > self.hard_limit:
            return Warning(
                message=f"Context at {utilization:.1%} - consider resetting or using bundles",
                remedy="See Factor VI for bundle patterns"
            )
        elif utilization > self.soft_limit:
            return Info(
                message=f"Context at {utilization:.1%} - good time for a checkpoint"
            )

        return None
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
- Pre-commit hooks (validate commits)
- Pre-deploy gates (validate deployments)
- Context checks (monitor 40% threshold)
- Input validation (check requests)

### Category 2: Runtime Guardrails

**Purpose:** Detect issues during execution

**Examples:**
- Context monitoring (warn at thresholds)
- Deployment monitoring (alert on errors)
- Spiral detection (flag fix chains)
- Circuit breakers (fail-safe patterns)

### Category 3: Post-Execution Guardrails

**Purpose:** Verify patterns after completion

**Examples:**
- Compliance dashboard (track adherence)
- Session retrospectives (verify learning extraction)
- Pattern tracking (encourage sharing)
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
- **Emergency:** Production issue, need immediate fix
- **Exceptional:** One-time unique circumstance
- **Temporary:** Should expire quickly
- **Logged:** Full audit trail for review
- **Reviewed:** Retrospective to prevent future need

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Git hooks support Laws 1 & 2
- **Factor IV: Continuous Validation**: Supports Law 4
- **Factor VI: Resume Work**: Supports context management
- **Factor IX: Mine Patterns**: Supports pattern sharing
- **Factor X: Small Iterations**: Supports continuous improvement

---

## Next Steps

1. **Document the Nine Laws** for your team
2. **Implement pre-commit hooks** with helpful feedback
3. **Add CI/CD gates** for validation (Law 4)
4. **Create compliance dashboard** tracking patterns
5. **Set up spiral detection** for fix chains

---

## Further Reading

- **DevOps + SRE Pillar**: [../docs/principles/four-pillars.md](../docs/principles/four-pillars.md)
- **Nine Laws**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md)
- **Factor IV: Continuous Validation**: [./04-continuous-validation.md](./04-continuous-validation.md)
- **Policy as Code**: [Open Policy Agent](https://www.openpolicyagent.org/)

---

**Remember:** The Nine Laws are guidelines that help agents succeed. Guardrails support the laws through automation. Make it easy to do the right thing. Prevention beats correction. Build trust through consistent patterns.
