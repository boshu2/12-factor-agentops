---
name: factor-compliance-checker
description: Validate workflows against the 12-Factor AgentOps operational discipline
version: 3.0.0
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

**Validate workflows against the 12-Factor AgentOps operational discipline**

| Aspect | Details |
|--------|---------|
| **Type** | Operational Discipline Skill |
| **Trigger** | After implementation, before commit |
| **Output** | Compliance report with recommendations |

---

## Summary

Analyze a workflow, commit, or session against the 12 factors of operational discipline for working with AI agents. Report compliance gaps and provide actionable recommendations.

## When to Use

- Before committing significant work
- During code review
- After implementing new workflows
- Periodic operational discipline audits

## Validation Checklist

### Foundation (I-III)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **I. Context Is Everything** | Context quality | Relevant context loaded; under 40% window threshold |
| **II. Track Everything in Git** | Git hygiene | All artifacts tracked; structured commit messages |
| **III. One Agent, One Job** | Agent scope | Single responsibility per agent; clear boundaries |

### Workflow (IV-VI)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **IV. Research Before You Build** | Research phase | Problem explored before implementation started |
| **V. Validate Externally** | External validation | Tests, linters, or CI confirm correctness (not just LLM self-check) |
| **VI. Lock Progress Forward** | Progress persistence | Incremental commits; can resume from checkpoint |

### Knowledge (VII-IX)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **VII. Extract Learnings** | Learning capture | At least one learning documented from session |
| **VIII. Compound Knowledge** | Knowledge reuse | Patterns documented for reuse; HERO loop active |
| **IX. Measure What Matters** | Metrics | Relevant metrics tracked; outcomes measured |

### Scale (X-XII, optional)

| Factor | Check | Pass Criteria |
|--------|-------|---------------|
| **X. Isolate Workers** | Worker isolation | Each agent has its own worktree/environment |
| **XI. Supervise Hierarchically** | Oversight structure | Supervisors monitor workers; escalation paths defined |
| **XII. Harvest Failures as Wisdom** | Failure capture | Failures documented with root cause and fix |

## Output Format

```markdown
## Compliance Report

**Overall Score:** 8/12 factors compliant

### Passing
- Factor I: Context loaded and under threshold
- Factor V: External validation gates present (tests pass)
- Factor VII: Learning extracted and documented

### Needs Attention
- Factor II: Uncommitted changes found; track in git
- Factor IX: No metrics captured for this session

### Recommendations
1. Commit work-in-progress before switching tasks (Factor II)
2. Add a metrics summary at session end (Factor IX)
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

**Remember:** Operational discipline is a practice, not a checkbox. Each check teaches you something about your workflow.
