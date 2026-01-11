---
name: nine-laws-auditor
description: Audit sessions against the Nine Laws of AgentOps
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

# Nine Laws Auditor

**Audit sessions against the Nine Laws of AgentOps**

| Aspect | Details |
|--------|---------|
| **Type** | Governance Skill |
| **Trigger** | End of session, before commit |
| **Output** | Law compliance audit with gaps |

---

## Summary

Every agent session should uphold the Nine Laws. This skill audits your work against each law and highlights violations before they compound.

## The Nine Laws

### Core Laws (Always Enforce)

| Law | Question | Evidence Required |
|-----|----------|-------------------|
| **1. Extract Learnings** | Did you capture what you learned? | Learning section in commit |
| **2. Improve Self or System** | Did you make something better? | Improvement documented |
| **3. Document for Future** | Will future agents understand? | Context preserved |
| **4. Validate Before Execute** | Did you check before acting? | Validation gates used |
| **5. Share Patterns Publicly** | Can others benefit? | Pattern documented |

### Extended Laws (Context-Dependent)

| Law | Question | When Required |
|-----|----------|---------------|
| **6. Git Discipline** | Clean commits? No secrets? | Every commit |
| **7. Respect Constraints** | Under 40%? Single responsibility? | Complex work |
| **8. Human-in-Loop** | Did you ask when unsure? | Critical decisions |
| **9. Compound Knowledge** | Did you build on previous? | Research phase |

## Audit Process

```
Session work complete
    ↓
1. Check each law against session artifacts
    ↓
2. Score compliance (0-9)
    ↓
3. Identify violations
    ↓
4. Recommend fixes before commit
    ↓
5. Re-audit after fixes
```

## Output Format

```markdown
## Nine Laws Audit

**Session:** 2025-01-27 Redis Operator Deployment
**Score:** 7/9 laws upheld

### Upheld
- ✅ Law 1: Learning documented in commit
- ✅ Law 3: Context section complete
- ✅ Law 4: Dry-run validation used
- ✅ Law 5: Pattern added to library
- ✅ Law 6: Clean commit, no secrets
- ✅ Law 7: Context at 35%
- ✅ Law 9: Built on existing patterns

### Violated
- ❌ Law 2: No improvement suggested
- ❌ Law 8: Critical config applied without review

### Required Actions
1. Add improvement to backlog (Factor X)
2. Add human checkpoint for production configs
```

## Usage

Run at session end:

```
/laws-audit
```

Or audit specific commit:

```
/laws-audit commit:abc123
```

---

**Remember:** Laws aren't restrictions—they're guardrails. Each violation is a lesson about where your process needs strengthening.
