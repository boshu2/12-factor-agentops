---
name: five-laws-auditor
description: Audit work for compliance with the Five Laws of AgentOps. Use before commits, when reviewing sessions, or validating that work follows AgentOps principles (Extract Learnings, Improve, Document Context, Validate, Share Patterns).
---

# Five Laws Compliance Auditor

Ensure all work follows the Five Laws of AgentOps: the mandatory principles for reliable, improving agent operations.

## Purpose

This skill provides systematic auditing of work against the Five Laws. Every agent session, pattern, workflow, or contribution must follow ALL five laws. This isn't optional—it's constitutional.

## When to Use This Skill

Use this skill:
- **Before committing work** - Ensure Laws compliance
- **Reviewing agent sessions** - Validate learning extraction
- **Auditing patterns/workflows** - Check all laws enforced
- **Pre-publication review** - Verify framework contributions
- **Quality gates** - As part of validation workflow

## The Five Laws

### Law 1: ALWAYS Extract Learnings
**Every session must extract at least one generalizable pattern, insight, or learning.**

**Audit questions:**
- ✅ What was learned from this work?
- ✅ Is the learning documented explicitly?
- ✅ Can future agents find and apply this learning?
- ✅ Is it generalizable beyond this specific instance?

**Compliance indicators:**
- Commit messages include "Learning:" section
- Patterns extracted to dedicated files
- Git history shows learning progression
- Documentation explains "why" not just "what"

### Law 2: ALWAYS Improve Self or System
**Identify at least one improvement opportunity and specify its impact.**

**Audit questions:**
- ✅ What improvement opportunity was identified?
- ✅ Is the impact quantified (time saved, quality improved)?
- ✅ Is implementation effort specified?
- ✅ Is it prioritized appropriately?

**Compliance indicators:**
- Improvement backlog exists and is maintained
- Each session documents improvements
- Impact is quantified, not vague
- Improvements are actually implemented over time

### Law 3: ALWAYS Document Context for Future
**Preserve Context, Solution, Learning, and Impact for future agents.**

**Audit questions:**
- ✅ **Context**: Why was this work needed?
- ✅ **Solution**: What was done and how?
- ✅ **Learning**: What reusable insights emerged?
- ✅ **Impact**: What quantified value was created?

**Compliance indicators:**
- Git commits follow Context/Solution/Learning/Impact structure
- Documentation answers "why" questions
- Future agents can understand decisions
- Audit trail is complete

### Law 4: ALWAYS Validate Before Execute
**Preview, test, and validate before making changes. Prevention beats recovery.**

**Audit questions:**
- ✅ Were changes previewed before execution?
- ✅ Was testing done in safe environment first?
- ✅ Were configurations validated?
- ✅ Was human review obtained for critical decisions?

**Compliance indicators:**
- Validation gates exist (make quick, make ci-all)
- Diff-first thinking practiced
- No production-first deployments
- Human gates at critical points

### Law 5: ALWAYS Share Patterns Publicly
**Extract generalizable insights and help others avoid your mistakes.**

**Audit questions:**
- ✅ Are patterns documented for others?
- ✅ Are failures shared, not just successes?
- ✅ Is context sanitized (remove proprietary details)?
- ✅ Can others learn from this work?

**Compliance indicators:**
- Patterns extracted to framework
- Anti-patterns documented
- Public documentation exists
- Generalizable insights highlighted

## Audit Workflow

### Step 1: Identify What to Audit

**Common audit targets:**
- Git commits before pushing
- Agent session work before completing
- Pattern documentation before publishing
- Workflow definitions before deployment
- Research contributions before submission

### Step 2: Systematic Compliance Check

Use `references/laws-audit-checklist.md` to systematically check each law.

**For each law:**
1. Read the law requirements
2. Look for compliance evidence
3. Document findings (✅ pass / ❌ fail)
4. Note improvement opportunities

### Step 3: Generate Audit Report

```markdown
# Five Laws Compliance Audit

**Artifact**: [What was audited]
**Date**: [When]
**Auditor**: [Who - often automated]

## Law 1: Extract Learnings
[✅ / ❌] Compliance status
**Evidence**: [What shows compliance]
**Gaps**: [What's missing, if any]

## Law 2: Improve Self or System
[✅ / ❌] Compliance status
**Evidence**: [What shows compliance]
**Gaps**: [What's missing, if any]

## Law 3: Document Context
[✅ / ❌] Compliance status
**Evidence**: [What shows compliance]
**Gaps**: [What's missing, if any]

## Law 4: Validate Before Execute
[✅ / ❌] Compliance status
**Evidence**: [What shows compliance]
**Gaps**: [What's missing, if any]

## Law 5: Share Patterns
[✅ / ❌] Compliance status
**Evidence**: [What shows compliance]
**Gaps**: [What's missing, if any]

## Overall: [X/5 laws compliant]
**Recommendation**: [Pass / Needs work / Reject]
```

### Step 4: Address Gaps

For any law violations:
1. Identify what's missing
2. Add missing evidence
3. Re-audit
4. Only proceed when all 5 laws satisfied

## Quick Audit Shortcuts

### Commit Message Audit
```bash
# Check if commit follows Law 3 structure
git log -1 --format="%B" | grep -E "(Context:|Solution:|Learning:|Impact:)"
```

### Session Audit
**Ask yourself:**
1. What did I learn? (Law 1)
2. What could be better? (Law 2)
3. Can future agents understand this? (Law 3)
4. Did I validate before executing? (Law 4)
5. Can others benefit from this? (Law 5)

### Pattern Audit
**Check documentation includes:**
- Problem/Solution/Evidence (Law 1, 3)
- Improvement opportunity (Law 2)
- Validation metrics (Law 4)
- Generalizability assessment (Law 5)

## Common Violations

### Law 1 Violation: No Learning Extraction
**Problem**: Work completed but no patterns extracted
**Fix**: Add "Learning:" section to commit, extract to patterns/

### Law 2 Violation: No Improvement Identified
**Problem**: Status quo accepted, no improvement opportunities
**Fix**: Identify at least one thing to improve, quantify impact

### Law 3 Violation: Missing Context
**Problem**: What/How documented but not Why
**Fix**: Add Context section explaining motivation

### Law 4 Violation: Execute-First
**Problem**: Changes made without validation
**Fix**: Add validation gates, preview changes first

### Law 5 Violation: Hoarding Knowledge
**Problem**: Patterns stay private, not shared
**Fix**: Sanitize and document for public consumption

## Resources

### references/laws-audit-checklist.md
Detailed checklist for auditing compliance with each law. Includes specific evidence to look for and common violations.

### scripts/audit_commit.sh
Shell script that audits git commits for Five Laws compliance. Checks for required sections and proper structure.

---

**Remember**: The Five Laws are constitutional. 5/5 compliance is mandatory, not aspirational.
