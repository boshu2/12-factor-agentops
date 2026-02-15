# Factor VIII: Human Validation

**Embed human approvals between research → plan → implement phases**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Learning Science |
| **Supporting Pillar** | DevOps + SRE |
| **Enforces Laws** | Law 3 (Document Context), Law 4 (Validate Before Execute) |
| **Derived From** | Progressive complexity + Human-in-the-loop + Approval workflows |


---

## Summary

AI agents should not execute critical changes without human oversight. Strategic human gates between workflow phases (Research → Plan → Implement → Deploy) enable review, course correction, and trust building. Humans review plans before implementation, not after failures.

## The Problem

Fully autonomous agents without human gates:
- Make expensive mistakes autonomously
- Implement the wrong solution correctly
- Miss critical business context
- Erode trust through unexpected changes
- Have no opportunity for course correction

**Familiar pattern:**
```
Agent: *Researches for 1 hour*
Agent: *Plans solution for 1 hour*
Agent: *Implements for 2 hours*
Agent: *Deploys*
Human: "Wait, that's not what I wanted at all!"
Result: 4 hours wasted
```

**Traditional approach:** Full automation or full manual control

**12-Factor AgentOps approach:** Hybrid human-in-the-loop at strategic gates

---

## Why This Factor Exists

### Grounding in the Five Pillars

**Primary: Learning Science**

Human gates apply the Learning Science principle of progressive complexity with checkpoints. Students need moments to consolidate understanding before advancing to the next level. For AI workflows, gates serve as these consolidation points: research findings reviewed before planning begins, plan approved before implementation starts. This prevents compounding errors where a flawed foundation cascades into expensive failures.

The key insight is fail-safe design: catch errors at boundaries when they're cheap, not after compounding. Gate 1 (research review) costs 10 minutes to redirect. Gate 2 (plan approval) costs 1 hour to revise. Gate 3 (implementation review) costs 4 hours to fix. No gate costs days to recover from production disasters. Progressive complexity teaches us to validate at each level before proceeding.

**Supporting: DevOps + SRE**

DevOps provides the human-in-the-loop deployment pattern: automation handles the heavy lifting, humans provide strategic oversight. The $10M feature story exemplifies this: 6 weeks of autonomous implementation, then "we changed our mind." A simple Week 1 gate would have caught this in 30 minutes. SRE teaches fail-safe design—systems should fail safely, not catastrophically. Human gates are circuit breakers that stop dangerous execution before damage occurs.

---

## What This Factor Enforces

### Law 3: Document Context for Future

Human gates enforce context documentation by requiring rich approval requests. To get approval, agents must articulate: summary, research findings, proposed approach, alternatives considered, impact assessment, risks, rollback plan. This forces structured thinking and comprehensive documentation that future agents (and future humans) need.

**Concrete example:** Gate 2 (plan approval) template requires documenting alternatives rejected and why. This forces agents to explore the solution space and document the decision rationale. Result: future similar tasks can reference this reasoning instead of re-researching alternatives. Context documented as a side effect of seeking approval.

### Law 4: Validate Before Execute

Human gates ARE validation for high-risk decisions. Automated validation catches syntax and logic errors, but humans catch semantic issues: "This solves the wrong problem" or "This has unintended consequences." The production deployment gate (100% reduction in broken deployments) shows human judgment preventing automated validation from missing the big picture.

**Concrete example:** Agent generates technically correct Kubernetes migration plan, passes all automated validation. Human reviewer: "This will cause 30 seconds of downtime during business hours." Plan revised for off-hours execution. Automated validation couldn't catch this business context. Human gate validated that correct solution was also appropriate solution.

---

## The Principle

### The Four Gates

**Gate 1: Research Review** (Optional)
- **When:** After research phase, before planning
- **Question:** "Did we research the right things?"
- **Decision:** Proceed / Redirect research / Abort

**Gate 2: Plan Approval** (Critical)
- **When:** After planning, before implementation
- **Question:** "Is this the right solution?"
- **Decision:** Approve / Revise plan / Abort

**Gate 3: Implementation Review** (Optional)
- **When:** After implementation, before deployment
- **Question:** "Does implementation match plan?"
- **Decision:** Deploy / Fix issues / Abort

**Gate 4: Deployment Approval** (Critical)
- **When:** After implementation, before production deployment
- **Question:** "Safe to deploy to production?"
- **Decision:** Deploy / Rollback / Hold

### Human Gate Design Principles

**1. Strategic, Not Constant**
```
❌ Wrong: Human approves every line of code
✅ Right: Human approves high-level plan before hours of implementation
```

**2. Async-Friendly**
```
❌ Wrong: Agent blocks until human responds (could be hours)
✅ Right: Agent saves state, human reviews when available, agent resumes
```

**3. Context-Rich**
```
❌ Wrong: "Approve this change? (yes/no)"
✅ Right: Here's what we researched, why we chose this approach, what alternatives we rejected, what the impact will be. Approve?
```

**4. Time-Bounded**
```
❌ Wrong: Wait indefinitely for approval
✅ Right: Escalate after 4 hours, timeout after 24 hours
```

---

## Why This Works

### 1. Progressive Complexity (Learning Science)

**Learning principle:**
> "Learners need checkpoints to consolidate understanding before advancing"

**For AI workflows:**
```
Research phase → [CHECKPOINT] Review findings
Plan phase → [CHECKPOINT] Approve plan
Implement phase → [CHECKPOINT] Verify implementation

Result: Catch errors at boundaries, not after compounding
```

### 2. Fail-Safe Design (SRE)

**Safety principle:**
> "Systems should fail safely, not catastrophically"

**Human gates as circuit breakers:**
```
Autonomous execution:
  Research → Plan → Implement → Deploy → DISASTER

Human-gated execution:
  Research → [GATE] → Plan → [GATE] → Implement → [GATE] → Deploy
                ↓              ↓                    ↓
            Abort here    Abort here          Abort here
           (minutes)     (hours)           (hours)
         instead of after disaster (days)
```

### 3. Trust Through Transparency

**Problem:** "I don't trust AI to make decisions autonomously"

**Solution:** Human gates provide oversight
```
Without gates:
  Human: "What did the AI do?"
  Result: Anxiety, micromanagement, distrust

With gates:
  Human: "AI researched X, proposes plan Y, I approve"
  Result: Confidence, partnership, trust
```

### 4. Course Correction Opportunity

**Analogy:** Agile sprints have daily standups to course-correct

**For AI workflows:**
```
Gate 1 (Research):
  Human: "You researched the right area, but missed consideration X"
  Agent: "Understood, adding X to research"
  Result: 10 minutes of additional research vs. hours of wrong implementation

Gate 2 (Plan):
  Human: "Approach A makes sense, but use library B instead of C"
  Agent: "Understood, updating plan"
  Result: 5 minutes of plan revision vs. hours of wrong code
```

---

## Implementation

### Gate Implementation Pattern

**Synchronous gate** (blocking):
```python
class SynchronousGate:
    def request_approval(self, context, timeout_seconds=3600):
        # Present context to human
        print(f"===== APPROVAL REQUIRED =====")
        print(f"Phase: {context.phase}")
        print(f"Summary: {context.summary}")
        print(f"Proposal: {context.proposal}")
        print(f"Alternatives: {context.alternatives}")
        print(f"Impact: {context.impact}")
        print(f"=============================")

        # Wait for approval (with timeout)
        response = self.wait_for_human_input(timeout_seconds)

        if response == "approved":
            return True
        elif response == "rejected":
            return False
        elif response == "timeout":
            # Escalate or use default (safer to block than proceed)
            self.escalate()
            return False
```

**Asynchronous gate** (non-blocking):
```python
class AsyncGate:
    def request_approval(self, context):
        # Create approval request
        approval_id = self.create_approval_request({
            'phase': context.phase,
            'summary': context.summary,
            'proposal': context.proposal,
            'context_bundle': context.bundle,
            'created_at': datetime.now()
        })

        # Notify human (email, Slack, etc.)
        self.notify_human(approval_id)

        # Agent saves state and exits
        self.save_checkpoint(context.phase, approval_id)

        print(f"Approval request {approval_id} created. Agent paused.")
        print(f"Resume with: agent resume --approval-id {approval_id}")

        return approval_id

    def resume_after_approval(self, approval_id):
        # Load approval decision
        approval = self.load_approval(approval_id)

        if not approval.decided:
            raise ValueError("Approval not yet decided")

        # Load checkpoint
        checkpoint = self.load_checkpoint(approval_id)

        if approval.approved:
            # Continue from where we left off
            return self.resume_workflow(checkpoint)
        else:
            # Human rejected, handle feedback
            return self.handle_rejection(checkpoint, approval.feedback)
```

### Integration with HumanLayer

**Using HumanLayer SDK:**
```python
from humanlayer import HumanLayer

hl = HumanLayer()

class PlanAgent:
    def execute(self, research_results):
        # Generate plan
        plan = self.generate_plan(research_results)

        # Request human approval
        approval = hl.request_approval(
            message=f"Plan generated for task: {plan.summary}",
            context={
                'plan': plan.to_dict(),
                'research': research_results.summary,
                'alternatives': plan.alternatives,
                'estimated_time': plan.estimated_hours,
                'risks': plan.risks
            }
        )

        if approval.approved:
            return plan
        else:
            # Handle rejection
            feedback = approval.feedback
            return self.revise_plan(plan, feedback)
```

### Gate Decision Matrix

**When to require human approval:**

| Factor | Low | Medium | High |
|--------|-----|--------|------|
| **Impact** | Few files | Multiple files | System-wide |
| **Risk** | Reversible | Production | Critical |
| **Cost** | Minutes | Hours | Days |
| **Novelty** | Routine | Uncommon | First time |
| **Gate?** | Optional | Recommended | **Required** |

**Examples:**
```
Low impact + Low risk = Optional gate
  → "Fix typo in README" (auto-proceed)

Medium impact + Medium risk = Recommended gate
  → "Refactor authentication module" (suggest approval)

High impact + High risk = Required gate
  → "Migrate database schema in production" (mandatory approval)
```

---

## Validation

### ✅ You're doing this right if:
- Humans review plans before implementation, not after
- Gates are strategic (between phases), not constant (every action)
- Context is rich (why, alternatives, impact)
- Async gates don't block agent indefinitely
- Approval rate >80% (agent proposals are generally good)

### ❌ You're doing this wrong if:
- No human gates (fully autonomous for critical work)
- Too many gates (human bottleneck)
- Poor context (human can't make informed decision)
- Synchronous gates block for hours/days
- Approval rate <50% (agent proposals are bad)

---

## Real-World Evidence

### The $10M Feature That Wasn't Needed

**What happened (no gates):**
```
Week 1: Agent researches feature implementation
Week 2: Agent plans 20,000 line implementation
Weeks 3-6: Agent implements feature
Week 7: Product owner: "We changed our mind, we don't need this"
Result: 6 weeks of engineering time wasted ($10M equivalent)
```

**What would have prevented it (with gates):**
```
Week 1: Agent researches feature implementation
Week 1: [GATE] Product owner reviews research → "This is too complex, let's simplify"
Week 2: Agent plans simplified version
Week 2: [GATE] Product owner approves plan → Proceed
Week 3: Agent implements simplified version
Result: 3 weeks vs 7 weeks, correct solution
```

### Production Deployment Gate Analysis

**Measured over 50 production deployments:**

**Without human gate (first 25 deployments):**
```
Deployments: 25
Broken deployments: 4 (16%)
Average fix time: 2 hours
Total time wasted: 8 hours
```

**With human gate (last 25 deployments):**
```
Deployments: 25
Rejected at gate: 3 (12%) - caught before deployment
Broken deployments: 0 (0%)
Average gate review time: 5 minutes
Total time invested: 125 minutes (2 hours)
Time saved: 8 hours - 2 hours = 6 hours net savings
```

**Improvement:** 100% reduction in broken deployments, 75% time savings

---

## Anti-Patterns

### ❌ The "Approve Everything" Trap
**Wrong:** Human rubber-stamps every approval without review
**Right:** If approval rate is 100%, gate is useless. Target: 80-90%

### ❌ The "Gate Everything" Trap
**Wrong:** Require approval for every tiny decision
**Right:** Strategic gates between major phases only

### ❌ The "No Context" Trap
**Wrong:** "Approve changes? (yes/no)"
**Right:** "Here's what we researched, why we chose this, what it impacts. Approve?"

### ❌ The "Blocking Forever" Trap
**Wrong:** Agent waits indefinitely for approval
**Right:** Async gates with timeout and escalation

---

## Relationship to Other Factors

- **Factor II: Context Loading**: Gates enable context delegation (research done, plan approved, sub-agent handles implementation)
- **Factor III: Focused Agents**: Each gate reviews one phase's output
- **Factor IV: Continuous Validation**: Human gates supplement automated validation
- **Factor VII: Resume Work**: Gates natural boundaries for session bundles
- **Factor VIII: Smart Routing**: Route high-risk tasks to human-gated workflows

---

## Gate Patterns

### Pattern 1: Escalating Gates

```python
class EscalatingGate:
    def request_approval(self, context):
        # Try primary approver
        approval = self.request_from_primary(context)

        if approval.decided_within(hours=4):
            return approval

        # Escalate to secondary
        approval = self.request_from_secondary(context)

        if approval.decided_within(hours=8):
            return approval

        # Final escalation to manager
        approval = self.request_from_manager(context)

        if approval.decided_within(hours=24):
            return approval

        # Timeout - default to safe (reject)
        return Approval(approved=False, reason="Timeout")
```

### Pattern 2: Confidence-Based Gates

```python
class ConfidenceGate:
    def should_require_approval(self, plan, confidence):
        # High confidence, low risk → Auto-proceed
        if confidence > 0.95 and plan.risk == "low":
            return False

        # Medium confidence → Request approval
        elif confidence > 0.75:
            return True

        # Low confidence → Mandatory approval
        else:
            return True
```

### Pattern 3: Diff-Based Gates

```python
class DiffGate:
    def request_approval(self, changes):
        # Small changes → Show inline diff
        if changes.lines_changed < 50:
            return self.inline_diff_approval(changes)

        # Medium changes → Show summary + diff
        elif changes.lines_changed < 500:
            return self.summary_diff_approval(changes)

        # Large changes → Show summary + link to full diff
        else:
            return self.summary_link_approval(changes)
```

---

## Approval Request Template

**Effective approval request structure:**

```markdown
# Approval Request: [Phase] for [Task]

## Summary
[1-2 sentence overview]

## Research Findings (if applicable)
- Finding 1
- Finding 2
- Finding 3

## Proposed Approach
[Detailed description of what will be done]

## Alternatives Considered
- Alternative A: [Why rejected]
- Alternative B: [Why rejected]

## Impact Assessment
- Files changed: X
- Services affected: Y
- Estimated time: Z hours
- Risk level: [Low/Medium/High]

## Risks
- Risk 1: [Mitigation]
- Risk 2: [Mitigation]

## Rollback Plan
[How to undo if this goes wrong]

## Questions for Reviewer
1. Question 1?
2. Question 2?

---

**Action Required:**
[ ] Approve (proceed with implementation)
[ ] Revise (provide feedback below)
[ ] Reject (explain reason below)

**Feedback:**
[Your comments here]
```

---

## Next Steps

1. **Identify critical decision points** in your workflows
2. **Implement gates** at Research→Plan and Plan→Implement boundaries
3. **Create approval templates** with rich context
4. **Measure approval rates** (target: 80-90%)
5. **Collect feedback** on gate effectiveness

---

## Further Reading

- **Learning Science Pillar**: [../docs/principles/four-pillars.md#pillar-2-learning-science](../docs/principles/four-pillars.md#pillar-2-learning-science)
- **Law 3 (Document Context)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-3)
- **Law 4 (Validate Before Execute)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-4)
- **Pattern: Human-in-the-Loop**: [../patterns/human-in-the-loop.md](../patterns/human-in-the-loop.md) (TBD)
- **HumanLayer Framework**: [https://humanlayer.dev](https://humanlayer.dev)

---

## Implementation Patterns

These patterns emerge from production deployments in Houston (local-first), Fractal (Kubernetes-native), and ai-platform (IC-hardened). They extend the conceptual human validation principles with battle-tested infrastructure patterns.

### Pattern 1: BudgetQuota CRD (Hard Limits from Fractal)

**The Problem:** Agents without hard limits can run away—spending unlimited tokens, making unlimited API calls, or running indefinitely.

**The Solution:** BudgetQuota CRD that enforces hard limits at infrastructure level, not agent level.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         BUDGETQUOTA ENFORCEMENT                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│                    ┌─────────────────────────────┐                     │
│                    │       BUDGETQUOTA CRD       │                     │
│                    │                             │                     │
│                    │  maxTokens: 100000          │                     │
│                    │  maxCost: $10.00            │                     │
│                    │  maxConcurrency: 5          │                     │
│                    │  maxDuration: 1h            │                     │
│                    └─────────────────────────────┘                     │
│                              │                                          │
│                    ┌─────────┴─────────┐                               │
│                    │ QUOTA CONTROLLER  │                               │
│                    │ (Watches usage)   │                               │
│                    └─────────┬─────────┘                               │
│                              │                                          │
│           ┌──────────────────┼──────────────────┐                      │
│           │                  │                  │                      │
│           ▼                  ▼                  ▼                      │
│   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐              │
│   │  ShardRun   │    │  ShardRun   │    │  ShardRun   │              │
│   │   #1        │    │   #2        │    │   #3        │              │
│   │             │    │             │    │             │              │
│   │ tokens: 30k │    │ tokens: 25k │    │ tokens: 40k │              │
│   │ cost: $3.00 │    │ cost: $2.50 │    │ cost: $4.00 │              │
│   └─────────────┘    └─────────────┘    └─────────────┘              │
│           │                  │                  │                      │
│           └──────────────────┼──────────────────┘                      │
│                              │                                          │
│                              ▼                                          │
│                    ┌─────────────────┐                                 │
│                    │ TOTAL: 95k/$9.50│                                 │
│                    │                 │                                 │
│                    │ ⚠️  APPROACHING  │                                 │
│                    │    LIMIT!       │                                 │
│                    └─────────────────┘                                 │
│                                                                         │
│  ENFORCEMENT: Controller KILLS ShardRuns that exceed quota             │
└─────────────────────────────────────────────────────────────────────────┘
```

**BudgetQuota CRD Definition:**

```yaml
apiVersion: fractal.ai/v1alpha1
kind: BudgetQuota
metadata:
  name: research-task-budget
  namespace: ai-agents
spec:
  # Hard limits - infrastructure enforced
  limits:
    maxTokensPerRun: 100000      # Max tokens per ShardRun
    maxTotalTokens: 500000       # Max tokens across all runs
    maxCostPerRun: "$10.00"      # Max cost per run
    maxTotalCost: "$50.00"       # Max total cost
    maxConcurrentRuns: 5         # Max parallel ShardRuns
    maxDuration: "1h"            # Max runtime per ShardRun
    maxRetries: 3                # Max retry attempts

  # Soft limits - warnings before hard stop
  warnings:
    tokenThreshold: 0.80         # Warn at 80% of token limit
    costThreshold: 0.80          # Warn at 80% of cost limit
    durationThreshold: 0.75      # Warn at 75% of duration

  # Actions when limits exceeded
  enforcement:
    onTokenLimit: "terminate"    # terminate | pause | alert
    onCostLimit: "terminate"
    onDurationLimit: "pause"
    onConcurrencyLimit: "queue"  # Queue new runs, don't reject

  # Escalation
  escalation:
    notifyOnWarning:
      - slack: "#ai-ops"
    notifyOnLimit:
      - slack: "#ai-ops"
      - pagerduty: "ai-platform-oncall"
```

**Quota Controller Implementation:**

```go
// QuotaController enforces BudgetQuota limits
type QuotaController struct {
    client    kubernetes.Interface
    informer  cache.SharedInformer
    recorder  record.EventRecorder
}

func (c *QuotaController) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
    // Get the BudgetQuota
    quota := &v1alpha1.BudgetQuota{}
    if err := c.client.Get(ctx, req.NamespacedName, quota); err != nil {
        return ctrl.Result{}, err
    }

    // List all ShardRuns in this namespace
    runs := &v1alpha1.ShardRunList{}
    if err := c.client.List(ctx, runs, client.InNamespace(req.Namespace)); err != nil {
        return ctrl.Result{}, err
    }

    // Calculate current usage
    usage := c.calculateUsage(runs)

    // Check limits
    if usage.TotalTokens > quota.Spec.Limits.MaxTotalTokens {
        // HARD STOP - Kill the highest-consuming run
        c.terminateHighestConsumer(ctx, runs)
        c.recorder.Event(quota, "Warning", "TokenLimitExceeded",
            fmt.Sprintf("Total tokens %d exceeded limit %d",
                usage.TotalTokens, quota.Spec.Limits.MaxTotalTokens))
    }

    if usage.TotalCost > quota.Spec.Limits.MaxTotalCost {
        // HARD STOP - Kill all runs
        c.terminateAllRuns(ctx, runs)
        c.recorder.Event(quota, "Warning", "CostLimitExceeded",
            fmt.Sprintf("Total cost $%.2f exceeded limit %s",
                usage.TotalCost, quota.Spec.Limits.MaxTotalCost))
    }

    // Update status
    quota.Status.CurrentUsage = usage
    return ctrl.Result{RequeueAfter: 10 * time.Second}, nil
}
```

**Why Infrastructure Enforcement:**

| Aspect | Agent Self-Enforcement | Infrastructure Enforcement |
|--------|------------------------|---------------------------|
| **Trust** | Agent "promises" to stop | Cannot exceed (killed) |
| **Bugs** | Bug could ignore limit | Bug cannot bypass K8s |
| **Visibility** | Hidden in agent logs | CRD status visible |
| **Recovery** | Agent must handle | Controller handles |
| **Audit** | Manual log parsing | Events + metrics |

---

### Pattern 2: Three-Phase Pipeline with Human Gates (Houston)

**The Problem:** Long-running agent tasks need natural breakpoints for human review.

**The Solution:** Three-phase pipeline with explicit HOLD states for human approval.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    THREE-PHASE PIPELINE (Houston)                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  PHASE 1: RESEARCH                                                      │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                                                                  │   │
│  │   [prep] ──► [queued] ──► [launching] ──► [active] ──► [done]  │   │
│  │                                                                  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                              │                                          │
│                              ▼                                          │
│                    ┌─────────────────┐                                 │
│                    │   GATE 1: HOLD  │ ◄── Human reviews research      │
│                    │   (Research     │                                 │
│                    │    Review)      │                                 │
│                    └─────────────────┘                                 │
│                              │ approve                                  │
│                              ▼                                          │
│  PHASE 2: PLANNING                                                      │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                                                                  │   │
│  │   [prep] ──► [queued] ──► [launching] ──► [active] ──► [done]  │   │
│  │                                                                  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                              │                                          │
│                              ▼                                          │
│                    ┌─────────────────┐                                 │
│                    │   GATE 2: HOLD  │ ◄── Human approves plan         │
│                    │   (Plan         │                                 │
│                    │    Approval)    │                                 │
│                    └─────────────────┘                                 │
│                              │ approve                                  │
│                              ▼                                          │
│  PHASE 3: IMPLEMENTATION                                                │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                                                                  │   │
│  │   [prep] ──► [queued] ──► [launching] ──► [active] ──► [done]  │   │
│  │                                                                  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                              │                                          │
│                              ▼                                          │
│                    ┌─────────────────┐                                 │
│                    │   GATE 3: HOLD  │ ◄── Human reviews before deploy │
│                    │   (Deploy       │                                 │
│                    │    Approval)    │                                 │
│                    └─────────────────┘                                 │
│                              │ approve                                  │
│                              ▼                                          │
│                         [DEPLOYED]                                      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

**Mission State Machine (Houston):**

```python
class MissionState(Enum):
    """Houston mission lifecycle states."""

    # Pre-execution states
    PREP = "prep"           # Mission being configured
    QUEUED = "queued"       # Ready to execute, waiting for worker
    HELD = "held"           # Waiting for human approval

    # Execution states
    LAUNCHING = "launching" # Worker claimed, starting
    ACTIVE = "active"       # Running

    # Terminal states
    COMPLETE = "complete"   # Successfully finished
    FAILED = "failed"       # Error occurred
    ABORTED = "aborted"     # Manually cancelled


class Mission:
    """Houston mission with human gates."""

    def __init__(self, name: str, phases: List[Phase]):
        self.name = name
        self.phases = phases
        self.current_phase = 0
        self.state = MissionState.PREP

    def advance_to_gate(self) -> bool:
        """Execute current phase, stop at gate."""
        phase = self.phases[self.current_phase]

        # Execute phase
        self.state = MissionState.ACTIVE
        result = phase.execute()

        if result.success:
            if phase.has_gate:
                # Stop at gate, wait for human
                self.state = MissionState.HELD
                self.save_gate_context(result)
                return False  # Not done, waiting at gate
            else:
                # No gate, continue to next phase
                self.current_phase += 1
                if self.current_phase >= len(self.phases):
                    self.state = MissionState.COMPLETE
                    return True
                return self.advance_to_gate()
        else:
            self.state = MissionState.FAILED
            return True  # Done (failed)

    def approve_gate(self, feedback: Optional[str] = None) -> bool:
        """Human approves gate, mission continues."""
        if self.state != MissionState.HELD:
            raise InvalidStateTransition(f"Cannot approve from {self.state}")

        if feedback:
            self.incorporate_feedback(feedback)

        self.current_phase += 1
        if self.current_phase >= len(self.phases):
            self.state = MissionState.COMPLETE
            return True

        self.state = MissionState.QUEUED
        return self.advance_to_gate()

    def reject_gate(self, reason: str) -> None:
        """Human rejects at gate, mission aborted."""
        if self.state != MissionState.HELD:
            raise InvalidStateTransition(f"Cannot reject from {self.state}")

        self.state = MissionState.ABORTED
        self.abort_reason = reason
```

**Gate Context Template:**

```yaml
# Gate context saved for human review
apiVersion: houston.ai/v1
kind: GateContext
metadata:
  name: mission-123-gate-2
spec:
  mission: mission-123
  phase: planning
  gate: plan-approval

  # What happened
  summary: "Generated implementation plan for API pagination feature"

  # Research findings (from previous phase)
  research:
    findings:
      - "API supports cursor-based pagination"
      - "Rate limit is 100 req/min"
      - "Existing clients expect offset pagination"
    confidence: 0.92

  # Proposed plan
  plan:
    approach: "Implement cursor pagination with offset fallback"
    files_to_change:
      - src/api/pagination.py
      - src/api/routes.py
      - tests/test_pagination.py
    estimated_tokens: 50000
    estimated_duration: "30m"

  # Alternatives considered
  alternatives:
    - name: "Cursor-only"
      reason_rejected: "Would break existing clients"
    - name: "Offset-only"
      reason_rejected: "Poor performance on large datasets"

  # Risk assessment
  risks:
    - risk: "Backwards compatibility"
      mitigation: "Fallback to offset when cursor not provided"
    - risk: "Performance regression"
      mitigation: "Add caching layer"

  # Human decision required
  decision_required:
    approve: "Proceed with implementation"
    reject: "Abort mission"
    revise: "Modify plan based on feedback"
```

---

### Pattern 3: ToolCall Audit Trail (Fractal)

**The Problem:** Understanding what agents did requires parsing logs, which is unreliable.

**The Solution:** Every tool call is a CRD—auditable, approvable, reversible.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                       TOOLCALL AUDIT TRAIL                              │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  AGENT EXECUTION                      AUDIT TRAIL (CRDs)                │
│                                                                         │
│  ┌─────────────┐                     ┌─────────────────────────────┐   │
│  │   Agent     │                     │ ToolCall: tc-001            │   │
│  │  executes   │ ──────────────────► │ tool: read_file             │   │
│  │ read_file() │                     │ args: {path: "config.yaml"} │   │
│  └─────────────┘                     │ status: completed           │   │
│        │                             │ result: {content: "..."}    │   │
│        │                             │ duration: 150ms             │   │
│        ▼                             │ tokens: 500                 │   │
│  ┌─────────────┐                     └─────────────────────────────┘   │
│  │   Agent     │                                                        │
│  │  executes   │ ──────────────────► ┌─────────────────────────────┐   │
│  │ write_file()│                     │ ToolCall: tc-002            │   │
│  └─────────────┘                     │ tool: write_file            │   │
│        │                             │ args: {path: "config.yaml"} │   │
│        │                             │ status: pending_approval    │   │
│        ▼                             │ requires_approval: true     │   │
│  ┌─────────────┐                     └─────────────────────────────┘   │
│  │   BLOCKED   │                              │                        │
│  │  (waiting   │ ◄────────────────────────────┘                        │
│  │  approval)  │                                                        │
│  └─────────────┘                                                        │
│        │                                                                │
│        │ human approves                                                 │
│        ▼                                                                │
│  ┌─────────────┐                     ┌─────────────────────────────┐   │
│  │   Agent     │                     │ ToolCall: tc-002            │   │
│  │  continues  │                     │ status: approved            │   │
│  │             │                     │ approved_by: user@example   │   │
│  └─────────────┘                     │ approved_at: 2025-01-15...  │   │
│                                      └─────────────────────────────┘   │
│                                                                         │
│  QUERYABLE: kubectl get toolcalls -l shardrun=sr-123                   │
│  REVERSIBLE: kubectl delete toolcall tc-002 (with rollback)            │
└─────────────────────────────────────────────────────────────────────────┘
```

**ToolCall CRD Definition:**

```yaml
apiVersion: fractal.ai/v1alpha1
kind: ToolCall
metadata:
  name: tc-001-read-config
  namespace: ai-agents
  labels:
    shardrun: sr-123
    agent: research-agent
    phase: research
spec:
  # What tool was called
  tool: read_file
  arguments:
    path: "/app/config.yaml"

  # Approval requirements
  requiresApproval: false  # Read is safe
  approvalTimeout: "1h"

  # Context
  shardRunRef:
    name: sr-123
    namespace: ai-agents
  agentRef:
    name: research-agent
  sequence: 1  # Order in execution

status:
  phase: Completed  # Pending | Approved | Rejected | Completed | Failed

  # Execution details
  startTime: "2025-01-15T10:30:00Z"
  completionTime: "2025-01-15T10:30:00.150Z"
  duration: "150ms"

  # Result
  result:
    success: true
    output: |
      api_version: v1
      pagination:
        default_limit: 100
    tokensUsed: 500

  # Approval (if required)
  approval:
    required: false

  # Error (if failed)
  error: null
```

**ToolCall Approval Flow:**

```python
class ToolCallController:
    """Controller that manages ToolCall approval flow."""

    DANGEROUS_TOOLS = {
        'write_file': {'approval': 'required', 'timeout': '1h'},
        'delete_file': {'approval': 'required', 'timeout': '1h'},
        'execute_command': {'approval': 'required', 'timeout': '30m'},
        'send_email': {'approval': 'required', 'timeout': '2h'},
        'deploy': {'approval': 'required', 'timeout': '4h'},
    }

    SAFE_TOOLS = {
        'read_file': {'approval': 'none'},
        'list_directory': {'approval': 'none'},
        'search_code': {'approval': 'none'},
        'get_documentation': {'approval': 'none'},
    }

    def create_toolcall(self, agent: str, tool: str, args: dict) -> ToolCall:
        """Create ToolCall CRD for tracking."""
        tc = ToolCall(
            metadata=ObjectMeta(
                name=f"tc-{uuid.uuid4().hex[:8]}-{tool}",
                labels={
                    'agent': agent,
                    'tool': tool,
                }
            ),
            spec=ToolCallSpec(
                tool=tool,
                arguments=args,
                requiresApproval=tool in self.DANGEROUS_TOOLS,
            )
        )

        # Create CRD
        self.client.create(tc)

        # If requires approval, wait
        if tc.spec.requiresApproval:
            tc = self.wait_for_approval(tc)
            if tc.status.approval.decision == 'rejected':
                raise ToolCallRejected(tc.status.approval.reason)

        return tc

    def wait_for_approval(self, tc: ToolCall) -> ToolCall:
        """Block until human approves or rejects."""
        timeout = self.DANGEROUS_TOOLS[tc.spec.tool]['timeout']

        # Notify human
        self.notify_approval_required(tc)

        # Wait with timeout
        start = time.time()
        while time.time() - start < parse_duration(timeout):
            tc = self.client.get(tc.metadata.name)
            if tc.status.approval.decision:
                return tc
            time.sleep(5)

        # Timeout - reject by default (fail safe)
        tc.status.approval.decision = 'rejected'
        tc.status.approval.reason = 'Approval timeout'
        return tc
```

---

### Pattern 4: Async Human Gates with SSE Telemetry (Houston)

**The Problem:** Synchronous human gates block agent execution. Humans may not be available immediately.

**The Solution:** Async gates with SSE (Server-Sent Events) for real-time notifications.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    ASYNC GATES + SSE TELEMETRY                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  AGENT                           GATE SERVICE              HUMAN        │
│                                                                         │
│  ┌─────────┐                    ┌─────────────┐          ┌─────────┐  │
│  │ Execute │                    │             │          │         │  │
│  │ Phase 1 │                    │             │          │         │  │
│  └────┬────┘                    │             │          │         │  │
│       │                         │             │          │         │  │
│       │ POST /gates/create      │             │          │         │  │
│       │ {phase: "plan",         │             │          │         │  │
│       │  context: {...}}        │             │          │         │  │
│       │─────────────────────────►│  Create    │          │         │  │
│       │                         │   Gate     │          │         │  │
│       │◄─────────────────────────│            │          │         │  │
│       │ {gate_id: "g-123",      │             │          │         │  │
│       │  status: "pending"}     │             │          │         │  │
│       │                         │             │ SSE push │         │  │
│       │                         │─────────────────────────►│ Review  │  │
│  ┌────┴────┐                    │             │          │ Request │  │
│  │  SAVE   │                    │             │          │         │  │
│  │  STATE  │                    │             │          │         │  │
│  │ (pause) │                    │             │          │         │  │
│  └─────────┘                    │             │          │         │  │
│                                 │             │          │         │  │
│       ... hours later ...       │             │          │         │  │
│                                 │             │          │         │  │
│                                 │             │ approve  │         │  │
│                                 │◄─────────────────────────│         │  │
│                                 │             │          │         │  │
│  ┌─────────┐                    │             │ SSE push │         │  │
│  │  RESUME │◄─────────────────────────────────│          │         │  │
│  │  STATE  │ {gate_id: "g-123", │             │          │         │  │
│  │         │  status: "approved"}             │          │         │  │
│  └────┬────┘                    │             │          │         │  │
│       │                         │             │          │         │  │
│       │                         │             │          │         │  │
│  ┌────┴────┐                    │             │          │         │  │
│  │ Execute │                    │             │          │         │  │
│  │ Phase 2 │                    │             │          │         │  │
│  └─────────┘                    │             │          │         │  │
│                                                                         │
│  KEY: Agent doesn't block. Saves state. Resumes when approved.         │
└─────────────────────────────────────────────────────────────────────────┘
```

**SSE Gate Service (Houston):**

```python
from fastapi import FastAPI, HTTPException
from sse_starlette.sse import EventSourceResponse
import asyncio

app = FastAPI()

# In-memory gate store (use Redis/DB in production)
gates: Dict[str, Gate] = {}
subscribers: Dict[str, List[asyncio.Queue]] = {}


@app.post("/gates")
async def create_gate(request: GateCreateRequest) -> Gate:
    """Create a new human gate."""
    gate = Gate(
        id=f"g-{uuid.uuid4().hex[:8]}",
        mission_id=request.mission_id,
        phase=request.phase,
        context=request.context,
        status="pending",
        created_at=datetime.utcnow(),
    )
    gates[gate.id] = gate

    # Notify subscribers
    await notify_subscribers(gate.mission_id, {
        "type": "gate_created",
        "gate": gate.dict()
    })

    return gate


@app.post("/gates/{gate_id}/approve")
async def approve_gate(gate_id: str, request: ApprovalRequest) -> Gate:
    """Human approves a gate."""
    gate = gates.get(gate_id)
    if not gate:
        raise HTTPException(404, "Gate not found")

    gate.status = "approved"
    gate.approved_by = request.user
    gate.approved_at = datetime.utcnow()
    gate.feedback = request.feedback

    # Notify subscribers (agent waiting for approval)
    await notify_subscribers(gate.mission_id, {
        "type": "gate_approved",
        "gate": gate.dict()
    })

    return gate


@app.get("/gates/{mission_id}/stream")
async def gate_stream(mission_id: str) -> EventSourceResponse:
    """SSE stream for gate events."""
    queue = asyncio.Queue()

    if mission_id not in subscribers:
        subscribers[mission_id] = []
    subscribers[mission_id].append(queue)

    async def event_generator():
        try:
            while True:
                event = await queue.get()
                yield {
                    "event": event["type"],
                    "data": json.dumps(event)
                }
        finally:
            subscribers[mission_id].remove(queue)

    return EventSourceResponse(event_generator())


async def notify_subscribers(mission_id: str, event: dict):
    """Push event to all subscribers."""
    if mission_id in subscribers:
        for queue in subscribers[mission_id]:
            await queue.put(event)
```

**Agent-Side Gate Handling:**

```python
class GateAwareAgent:
    """Agent that handles async human gates."""

    def __init__(self, gate_service_url: str):
        self.gate_url = gate_service_url
        self.state_store = StateStore()

    async def execute_with_gates(self, mission: Mission):
        """Execute mission, pausing at gates."""
        for phase in mission.phases:
            # Execute phase
            result = await phase.execute()

            if phase.has_gate:
                # Create gate
                gate = await self.create_gate(mission.id, phase, result)

                # Save state
                await self.state_store.save(mission.id, {
                    'current_phase': phase.name,
                    'result': result,
                    'gate_id': gate.id,
                })

                # Wait for approval (async)
                gate = await self.wait_for_gate(gate.id)

                if gate.status == "rejected":
                    raise GateRejected(gate.reason)

                # Incorporate feedback if any
                if gate.feedback:
                    mission.incorporate_feedback(gate.feedback)

        return mission.result

    async def wait_for_gate(self, gate_id: str) -> Gate:
        """Wait for gate approval via SSE."""
        async with aiohttp.ClientSession() as session:
            async with session.get(
                f"{self.gate_url}/gates/{gate_id}/stream"
            ) as response:
                async for line in response.content:
                    if line.startswith(b"data:"):
                        event = json.loads(line[5:])
                        if event["type"] in ("gate_approved", "gate_rejected"):
                            return Gate(**event["gate"])
```

---

### Anti-Patterns for Human Validation

**❌ Anti-Pattern 1: No Hard Limits**
```
Wrong: Trust agent to respect token budget
       agent.max_tokens = 100000  # Agent might ignore

Right: Infrastructure-enforced BudgetQuota
       BudgetQuota CRD + Controller = Cannot exceed
```

**❌ Anti-Pattern 2: Synchronous Blocking**
```
Wrong: Agent blocks thread waiting for human
       approval = wait_for_human()  # Thread blocked for hours

Right: Async gates with state persistence
       gate = create_gate()
       save_state()
       # Resume when notified
```

**❌ Anti-Pattern 3: Invisible Tool Calls**
```
Wrong: Tool calls buried in logs
       agent.execute()  # What did it do? Check logs...

Right: Every tool call is a CRD
       kubectl get toolcalls -l agent=research  # Full audit trail
```

---

### Production Checklist for Human Validation

```markdown
## Human Validation Infrastructure Checklist

### Budget Enforcement
- [ ] BudgetQuota CRD defines hard limits
- [ ] Controller watches usage in real-time
- [ ] Automatic termination on limit exceeded
- [ ] Slack/PagerDuty alerts on warnings

### Three-Phase Pipeline
- [ ] HOLD state implemented in state machine
- [ ] Gate context saved with full details
- [ ] Human can approve/reject/request-revision
- [ ] Feedback incorporated into next phase

### ToolCall Audit
- [ ] Every tool call creates CRD
- [ ] Dangerous tools require approval
- [ ] Full audit trail queryable via kubectl
- [ ] Rollback capability for reversible actions

### Async Gates
- [ ] SSE or webhook for real-time notifications
- [ ] State persistence across gate waits
- [ ] Timeout handling with safe defaults
- [ ] Escalation path defined
```

---

**Remember:** Human gates are not about distrust—they're about partnership. AI does the heavy lifting (research, planning, implementation), humans provide strategic oversight (is this the right direction?). Together, you catch expensive mistakes early when they're cheap to fix.
