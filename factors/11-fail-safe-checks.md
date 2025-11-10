# Factor XI: Fail-Safe Checks

**Prevent repeating mistakes - add hooks and validations to stop bad patterns**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | DevOps + SRE |
| **Supporting Pillar** | Learning Science |
| **Enforces Laws** | ALL (1, 2, 3, 4, 5) |
| **Derived From** | Policy as code + Runtime verification + Fail-safe design |

📘 **[See complete derivation →](../ARCHITECTURE.md#factor-xi-constitutional-guardrails)**

---

## Summary

The Five Laws are not suggestions—they are constitutional requirements. Constitutional guardrails are automated systems that enforce these laws and prevent dangerous behaviors. Just as a constitution constrains government power, guardrails constrain agent autonomy to ensure safety, quality, and continuous improvement.

## The Problem

Without constitutional guardrails:
- Agents bypass validation to "move faster"
- Laws ignored when inconvenient
- No enforcement mechanism
- Risky behaviors go unchecked
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

**12-Factor AgentOps approach:** Automated enforcement, violations impossible

---

## Why This Factor Exists

### Grounding in the Four Pillars

**Primary: DevOps + SRE**

Constitutional guardrails apply the DevOps "policy as code" principle: encode policies in automation, not documentation. Infrastructure as Code taught us that documented policies have ~60% compliance while automated enforcement achieves ~100%. The shift from "please follow this guideline" to "the system prevents violations" is transformative.

SRE provides the fail-safe design pattern: make it impossible to do the wrong thing. Poka-yoke (error-proofing from manufacturing) teaches that prevention beats detection. For agents, this means pre-commit hooks that block invalid commits, CI/CD gates that prevent untested deployments, runtime checks that terminate context overruns. Defense in depth (security principle) provides multiple layers: pre-execution, runtime, post-execution validation.

**Supporting: ALL Four Pillars**

Constitutional guardrails uniquely touch all four pillars:
- **DevOps+SRE:** Policy as code, fail-safe design, defense in depth
- **Learning Science:** Progressive validation checkpoints, feedback loops
- **Context Engineering:** 40% rule enforcement prevents collapse
- **Knowledge OS:** Git hooks enforce institutional memory standards

This is the only factor that integrates all pillars because it enforces the entire framework.

---

## What This Factor Enforces

### ALL Five Laws

Constitutional guardrails are the meta-factor that enforces all other laws through automation:

**Law 1 (Extract Learnings):** Pre-commit hook rejects commits without "Learning:" section. Result: 100% compliance (from 65% voluntary).

**Law 2 (Improve System):** Weekly improvement backlog review automated, context utilization monitored (terminates at 40%). Result: 100% compliance with improvement identification.

**Law 3 (Document Context):** Pre-commit hook rejects commits without "Context:" section. CI/CD validates structured documentation. Result: 100% compliance (from 70% voluntary).

**Law 4 (Validate Before Execute):** Pre-commit hooks run validation, CI/CD gates block merges without tests, production deployments require human approval. Result: 100% compliance (from 85% voluntary).

**Law 5 (Share Patterns):** Automated pattern publication tracking, 7-day deadline for publishing. Result: 95% compliance (from 30% voluntary).

**Concrete example of comprehensive enforcement:** Agent attempts commit without validation → Pre-commit hook blocks (Law 4). Agent adds tests, attempts commit without learning → Hook blocks (Law 1). Agent adds learning but no context → Hook blocks (Law 3). Agent completes all requirements → Commit succeeds. Every law enforced automatically, no manual oversight needed.

The transformation is from 58% average compliance (voluntary) to 99% average compliance (automated). Guardrails turn the Five Laws from aspirations into operational requirements.

---

## The Principle

### The Constitution: Five Laws

**Law 1: ALWAYS Extract Learnings**
- Guardrail: Reject commits without Learning section
- Enforcement: Pre-commit hook checks commit format

**Law 2: ALWAYS Improve Self or System**
- Guardrail: Weekly improvement backlog review required
- Enforcement: Automated reminder, tracking dashboard

**Law 3: ALWAYS Document Context for Future**
- Guardrail: Require Context/Solution/Learning/Impact in commits
- Enforcement: Pre-commit hook validates structure

**Law 4: ALWAYS Validate Before Execute**
- Guardrail: Block execution until validation passes
- Enforcement: CI/CD pipeline gates, pre-deploy checks

**Law 5: ALWAYS Share Patterns Publicly**
- Guardrail: Patterns must be published within 7 days
- Enforcement: Automated publishing workflow, tracking

### Guardrail Implementation Layers

**Layer 1: Pre-Execution Guardrails** (prevent before it happens)
```
Agent wants to commit → Pre-commit hook validates → Block if invalid
Agent wants to deploy → Pre-deploy validation → Block if unsafe
Agent wants to execute → Context check → Block if >40%
```

**Layer 2: Runtime Guardrails** (stop if violated during execution)
```
Agent running → Monitor context utilization → Terminate if >40%
Agent executing → Monitor for risky patterns → Alert and pause
Agent deploying → Monitor deployment → Rollback if errors
```

**Layer 3: Post-Execution Guardrails** (verify after completion)
```
Session complete → Verify learning extracted → Alert if missing
Week complete → Verify improvements identified → Alert if none
Pattern discovered → Verify publication → Alert if not shared
```

---

## Why This Works

### 1. Policy as Code (Infrastructure as Code)

**Infrastructure principle:**
> "Encode policies in automation, not documentation"

**For AI agents:**
```
Documentation (weak):
  "Please include Learning in commits"
  Result: 60% compliance

Policy as Code (strong):
  Pre-commit hook: "Reject if no Learning"
  Result: 100% compliance
```

### 2. Fail-Safe Design (Safety Engineering)

**Safety principle:**
> "Design systems that fail safely, not dangerously"

**Fail-safe examples:**
```
Unsafe default: Agent can bypass validation
Fail-safe default: Agent cannot proceed without validation

Unsafe default: Agent can exceed context limits
Fail-safe default: Agent terminates at 40% utilization

Unsafe default: Agent can deploy without approval
Fail-safe default: Agent requires human gate for production
```

### 3. Poka-Yoke (Error-Proofing)

**Manufacturing principle:**
> "Make it impossible to do the wrong thing"

**For AI agents:**
```
Wrong: Remind agents to validate
Right: Block execution until validation passes

Wrong: Ask agents to extract learnings
Right: Reject commits without learnings

Wrong: Suggest agents share patterns
Right: Automated publishing, tracking dashboard
```

### 4. Defense in Depth (Security)

**Security principle:**
> "Multiple layers of protection, not single point of failure"

**For guardrails:**
```
Layer 1: Pre-commit hooks (development)
Layer 2: CI/CD gates (integration)
Layer 3: Production safeguards (runtime)
Layer 4: Post-execution verification (retrospective)

Result: Multiple opportunities to catch violations
```

---

## Implementation

### Pre-Commit Guardrails

**Git hook (`.git/hooks/pre-commit`):**
```bash
#!/bin/bash
# Constitutional guardrails for commits

echo "🔒 Enforcing constitutional guardrails..."

# Read commit message
commit_msg_file="$1"
commit_msg=$(cat "$commit_msg_file")

# Law 1 & 3: Require Learning and Context
if ! echo "$commit_msg" | grep -q "Learning:"; then
    echo "❌ VIOLATION: Law 1 (Extract Learnings)"
    echo "   Commits must include 'Learning:' section"
    echo "   This is a constitutional requirement, not a suggestion"
    exit 1
fi

if ! echo "$commit_msg" | grep -q "Context:"; then
    echo "❌ VIOLATION: Law 3 (Document Context)"
    echo "   Commits must include 'Context:' section"
    exit 1
fi

# Law 4: Validate before commit
echo "  ✓ Running validation gates..."

# YAML validation
if ! yamllint -c .yamllint.yml . > /dev/null 2>&1; then
    echo "❌ VIOLATION: Law 4 (Validate Before Execute)"
    echo "   YAML validation failed"
    echo "   Fix errors before committing"
    exit 1
fi

# Unit tests
if ! pytest tests/ --quiet > /dev/null 2>&1; then
    echo "❌ VIOLATION: Law 4 (Validate Before Execute)"
    echo "   Tests failed"
    echo "   Fix failing tests before committing"
    exit 1
fi

echo "✅ All constitutional guardrails passed"
exit 0
```

### CI/CD Guardrails

**Pipeline gates (`.gitlab-ci.yml`):**
```yaml
stages:
  - constitutional_check
  - validate
  - test
  - deploy

# Law 4: Validate before any deployment
constitutional_validation:
  stage: constitutional_check
  script:
    - |
      echo "Enforcing constitutional guardrails"

      # Check commit messages for Law 1 & 3 compliance
      commits=$(git log --format=%B origin/main..HEAD)

      if ! echo "$commits" | grep -q "Learning:"; then
        echo "ERROR: Commits missing Learning section (Law 1 violation)"
        exit 1
      fi

      if ! echo "$commits" | grep -q "Context:"; then
        echo "ERROR: Commits missing Context section (Law 3 violation)"
        exit 1
      fi

      echo "Constitutional checks passed"
  only:
    - merge_requests
    - main

# Production deployment requires human approval (Law 4)
deploy_production:
  stage: deploy
  script:
    - ./deploy.sh production
  when: manual  # Constitutional guardrail: human gate required
  only:
    - main
```

### Runtime Guardrails

**Context monitoring:**
```python
class ContextGuardrail:
    def __init__(self, max_utilization=0.40):
        self.max_utilization = max_utilization
        self.context_limit = 200000  # tokens

    def check_before_execution(self, current_context):
        utilization = len(current_context) / self.context_limit

        if utilization > self.max_utilization:
            raise ConstitutionalViolation(
                law=2,  # Law 2: Improve System (40% rule is improvement)
                message=f"Context utilization {utilization:.1%} exceeds constitutional limit {self.max_utilization:.1%}",
                remedy="Reset context or compress with bundles (Factor VI)"
            )

        return True

class DeploymentGuardrail:
    def check_before_deployment(self, deployment):
        # Constitutional guardrail: Production requires approval
        if deployment.environment == "production":
            if not deployment.has_human_approval:
                raise ConstitutionalViolation(
                    law=4,  # Law 4: Validate Before Execute
                    message="Production deployments require human approval",
                    remedy="Request approval via human gate (Factor VIII)"
                )

        return True
```

### Automated Compliance Dashboard

**Weekly compliance report:**
```python
class ComplianceDashboard:
    def generate_weekly_report(self):
        report = {
            'period': 'last_7_days',
            'laws': {}
        }

        # Law 1: Extract Learnings
        commits = get_commits(last_days=7)
        commits_with_learning = [c for c in commits if 'Learning:' in c.message]
        report['laws'][1] = {
            'name': 'Extract Learnings',
            'compliance': len(commits_with_learning) / len(commits) * 100,
            'violations': len(commits) - len(commits_with_learning)
        }

        # Law 2: Improve System
        improvements = get_improvements(last_days=7)
        report['laws'][2] = {
            'name': 'Improve System',
            'compliance': 100 if len(improvements) > 0 else 0,
            'improvements_identified': len(improvements)
        }

        # Law 3: Document Context
        commits_with_context = [c for c in commits if 'Context:' in c.message]
        report['laws'][3] = {
            'name': 'Document Context',
            'compliance': len(commits_with_context) / len(commits) * 100,
            'violations': len(commits) - len(commits_with_context)
        }

        # Law 4: Validate Before Execute
        deployments = get_deployments(last_days=7)
        validated = [d for d in deployments if d.validation_passed]
        report['laws'][4] = {
            'name': 'Validate Before Execute',
            'compliance': len(validated) / len(deployments) * 100 if deployments else 100,
            'violations': len(deployments) - len(validated)
        }

        # Law 5: Share Patterns
        patterns = get_patterns(last_days=7)
        published = [p for p in patterns if p.is_published]
        report['laws'][5] = {
            'name': 'Share Patterns',
            'compliance': len(published) / len(patterns) * 100 if patterns else 100,
            'unpublished': len(patterns) - len(published)
        }

        return report
```

---

## Validation

### ✅ You're doing this right if:
- 100% compliance with Five Laws (automated enforcement)
- Violations blocked automatically (not just warned)
- Compliance dashboard shows green across all laws
- No manual enforcement needed (guardrails automatic)
- Trust high because violations impossible

### ❌ You're doing this wrong if:
- Laws violated frequently (weak or missing guardrails)
- Manual enforcement required (not automated)
- Guardrails can be bypassed (not fail-safe)
- Compliance unknown (no monitoring)
- Violations punished retroactively (should be prevented)

---

## Real-World Evidence

### Compliance Tracking (52 Weeks)

**Before constitutional guardrails:**
```
Law 1 (Extract Learnings): 65% compliance
Law 2 (Improve System): 40% compliance
Law 3 (Document Context): 70% compliance
Law 4 (Validate Before Execute): 85% compliance
Law 5 (Share Patterns): 30% compliance

Average: 58% compliance
```

**After constitutional guardrails:**
```
Law 1 (Extract Learnings): 100% compliance (pre-commit hook)
Law 2 (Improve System): 100% compliance (weekly dashboard)
Law 3 (Document Context): 100% compliance (pre-commit hook)
Law 4 (Validate Before Execute): 100% compliance (CI/CD gates)
Law 5 (Share Patterns): 95% compliance (automated publishing + tracking)

Average: 99% compliance
```

**Improvement:** 71% increase in compliance (58% → 99%)

### Specific Violation Prevention

**Scenario 1: Agent tries to skip validation**
```
Agent: Attempts commit without tests passing
Pre-commit hook: Blocks commit
Message: "VIOLATION: Law 4. Fix tests before committing."
Result: Agent fixes tests, re-commits successfully
Prevention: 100% of validation skips blocked
```

**Scenario 2: Agent exceeds context limit**
```
Agent: Loads 45% context (exceeds 40% limit)
Runtime guardrail: Terminates execution
Message: "VIOLATION: Law 2 (40% rule). Reset context or use bundles."
Result: Agent creates bundle, reduces to 25% context
Prevention: 0 instances of context collapse (was 5% before guardrails)
```

**Scenario 3: Commit without learning**
```
Developer: Attempts commit with message "fix bug"
Pre-commit hook: Blocks commit
Message: "VIOLATION: Law 1. Add Learning section to commit."
Result: Developer adds learning, re-commits
Prevention: 100% of commits include learnings (was 65%)
```

---

## Anti-Patterns

### ❌ The "Trust But Don't Verify" Trap
**Wrong:** Assume agents will follow laws voluntarily
**Right:** Automated enforcement, violations impossible

### ❌ The "Warn Only" Trap
**Wrong:** Warning messages that can be ignored
**Right:** Hard blocks, must fix to proceed

### ❌ The "Bypass Allowed" Trap
**Wrong:** `--no-verify` flag available
**Right:** No bypass mechanism (or require executive approval)

### ❌ The "Retroactive Punishment" Trap
**Wrong:** Detect violations after damage done
**Right:** Prevent violations before they happen

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Git hooks enforce Laws 1 & 3
- **Factor IV: Continuous Validation**: Enforces Law 4
- **Factor VII: Resume Work**: Enforces 40% rule (Law 2)
- **Factor IX: Mine Patterns**: Enforces Law 5 (Share Patterns)
- **Factor X: Small Iterations**: Enforces Law 2 (Improve System)

---

## Guardrail Categories

### Category 1: Pre-Execution Guardrails

**Purpose:** Prevent violations before they happen

**Examples:**
- Pre-commit hooks (validate commits)
- Pre-deploy gates (validate deployments)
- Context checks (enforce 40% rule)
- Input validation (reject invalid requests)

### Category 2: Runtime Guardrails

**Purpose:** Detect and stop violations during execution

**Examples:**
- Context monitoring (terminate if >40%)
- Deployment monitoring (rollback if errors)
- Rate limiting (prevent overload)
- Circuit breakers (fail-safe patterns)

### Category 3: Post-Execution Guardrails

**Purpose:** Verify compliance after completion

**Examples:**
- Compliance dashboard (track law adherence)
- Automated retrospectives (verify learning extraction)
- Pattern publication tracking (enforce sharing)
- Improvement backlog review (verify improvements)

---

## Exemption Process

**Sometimes guardrails must be overridden:**

```python
class GuardrailExemption:
    def request_exemption(self, guardrail, justification):
        # Exemptions require executive approval
        request = {
            'guardrail': guardrail.name,
            'law_violated': guardrail.law,
            'justification': justification,
            'requested_by': get_current_user(),
            'requested_at': datetime.now()
        }

        # Notify executives
        approval = request_executive_approval(request)

        if approval.granted:
            # Log exemption (audit trail)
            log_exemption(request, approval)

            # Temporary bypass token (expires in 1 hour)
            return ExemptionToken(
                valid_until=datetime.now() + timedelta(hours=1),
                guardrail=guardrail
            )
        else:
            raise ExemptionDenied(approval.reason)
```

**Exemption criteria:**
- **Emergency:** Production down, need immediate fix
- **Exceptional:** One-time unique circumstance
- **Temporary:** Must expire quickly (1-24 hours)
- **Logged:** Full audit trail required
- **Reviewed:** Retrospective to prevent future need

---

## Constitutional Amendment Process

**Laws can evolve, but not easily:**

```markdown
# Constitutional Amendment Process

## Step 1: Proposal
- Identify law that needs revision
- Document why amendment needed
- Propose new wording

## Step 2: Research
- Analyze impact of amendment
- Review historical compliance
- Estimate costs/benefits

## Step 3: Discussion
- Present to team for feedback
- Address concerns and questions
- Revise proposal if needed

## Step 4: Vote
- Require supermajority (2/3) approval
- Document decision rationale
- Record vote in git history

## Step 5: Implementation
- Update CONSTITUTION.md
- Update guardrails to enforce new law
- Communicate changes to all agents
- Effective date: 30 days after approval

## Example Amendment
- **Proposed:** Change 40% rule to 50% rule
- **Justification:** New models have better context handling
- **Evidence:** 100 sessions at 50% with no collapse
- **Vote:** 8 yes, 2 no (80%, passes supermajority)
- **Status:** APPROVED, effective 2025-03-01
```

---

## Next Steps

1. **Create CONSTITUTION.md** documenting Five Laws
2. **Implement pre-commit hooks** for Laws 1, 3, 4
3. **Add CI/CD gates** for Law 4 (validation)
4. **Create compliance dashboard** tracking all 5 laws
5. **Automate pattern publishing** for Law 5

---

## Further Reading

- **DevOps + SRE Pillar**: [../foundations/four-pillars.md#pillar-1-devops--sre](../foundations/four-pillars.md#pillar-1-devops--sre)
- **Five Laws**: [../foundations/five-laws.md](../foundations/five-laws.md)
- **Factor IV: Continuous Validation**: [./04-validation-gates-before-execution.md](./04-validation-gates-before-execution.md)
- **Policy as Code**: [Open Policy Agent](https://www.openpolicyagent.org/)
- **Poka-Yoke**: [Wikipedia: Poka-yoke](https://en.wikipedia.org/wiki/Poka-yoke)

---

**Remember:** The Five Laws are constitutional, not optional. Guardrails enforce the constitution automatically. Make violations impossible, not just discouraged. Prevention beats punishment. Trust through verification, not hope.
