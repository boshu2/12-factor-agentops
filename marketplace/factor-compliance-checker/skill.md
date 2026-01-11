---
name: factor-compliance-checker
description: Validate workflows against the 12-Factor AgentOps methodology
version: 2.0.0
author: boshu2
license: Apache-2.0
context: fork
user-invocable: true
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Factor Compliance Checker

**Validate workflows against the 12-Factor AgentOps methodology**

| Aspect | Details |
|--------|---------|
| **Type** | Validation Skill |
| **Trigger** | After implementation, before commit |
| **Output** | Compliance report with recommendations |

---

## Summary

Analyze a workflow, commit, or session against the 12 factors. Report compliance gaps and provide actionable recommendations.

## When to Use

- Before committing significant work
- During code review
- After implementing new workflows
- Periodic compliance audits

## Validation Checklist

### Foundation (I-IV)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **I. Automated Tracking** | Commit message structure | Context/Solution/Learning/Impact present |
| **II. Context Loading** | Context utilization | Under 40% threshold |
| **III. Focused Agents** | Agent scope | Single responsibility per agent |
| **IV. Continuous Validation** | Validation gates | Check before each major step |

### Operations (V-VIII)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **V. Measure Everything** | Telemetry | Metrics/logs/traces emitted |
| **VI. Resume Work** | State persistence | Can resume from checkpoint |
| **VII. Smart Routing** | Task routing | Right agent for right task |
| **VIII. Human Validation** | Approval gates | Critical steps require human |

### Improvement (IX-XII)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **IX. Mine Patterns** | Pattern extraction | At least one learning documented |
| **X. Small Iterations** | Iteration size | Changes are incremental |
| **XI. Fail-Safe Checks** | Guardrails | Hooks prevent known failures |
| **XII. Package Patterns** | Reusability | Patterns documented for reuse |

## Output Format

```markdown
## Compliance Report

**Overall Score:** 8/12 factors compliant

### Passing
- ✅ Factor I: Commit includes Context/Solution/Learning/Impact
- ✅ Factor IV: Validation gates present
- ✅ Factor IX: Pattern extracted and documented

### Needs Attention
- ⚠️ Factor II: Context at 45% (threshold: 40%)
- ⚠️ Factor V: No telemetry found

### Recommendations
1. Reduce context by extracting helper functions to sub-agent
2. Add metrics emission at phase boundaries
```

## Usage

Invoke after completing significant work:

```
/factor-check
```

Or specify a commit:

```
/factor-check commit:abc123
```

---

**Remember:** Compliance is a practice, not a checkbox. Each check teaches you something about your workflow.
