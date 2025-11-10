# Factor VIII: Human Validation

**Embed human approvals between research → plan → implement phases**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Learning Science |
| **Supporting Pillar** | DevOps + SRE |
| **Enforces Laws** | Law 3 (Document Context), Law 4 (Validate Before Execute) |
| **Derived From** | Progressive complexity + Human-in-the-loop + Approval workflows |

📘 **[See complete derivation →](../ARCHITECTURE.md#factor-viii-human-gate-reviews)**

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

### Grounding in the Four Pillars

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

- **Learning Science Pillar**: [../foundations/four-pillars.md#pillar-2-learning-science](../foundations/four-pillars.md#pillar-2-learning-science)
- **Law 3 (Document Context)**: [../foundations/five-laws.md](../foundations/five-laws.md#law-3)
- **Law 4 (Validate Before Execute)**: [../foundations/five-laws.md](../foundations/five-laws.md#law-4)
- **Pattern: Human-in-the-Loop**: [../patterns/human-in-the-loop.md](../patterns/human-in-the-loop.md) (TBD)
- **HumanLayer Framework**: [https://humanlayer.dev](https://humanlayer.dev)

---

**Remember:** Human gates are not about distrust—they're about partnership. AI does the heavy lifting (research, planning, implementation), humans provide strategic oversight (is this the right direction?). Together, you catch expensive mistakes early when they're cheap to fix.
