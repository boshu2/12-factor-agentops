---
name: factor-compliance-checker
description: Validate patterns and contributions against the 12-Factor AgentOps methodology. Use when auditing factor compliance, reviewing contributions, or ensuring patterns follow 12-factor principles.
---

# 12-Factor Compliance Checker

Validate patterns, workflows, and contributions against the 12-Factor AgentOps methodology to ensure they follow operational principles for reliable AI agent workflows.

## Purpose

This skill provides systematic validation of content against the twelve factors defined in the 12-Factor AgentOps framework. It ensures that patterns, workflows, and contributions properly derive from the Four Pillars and enforce the Five Laws.

## When to Use This Skill

Use this skill when:
- **Reviewing new patterns** submitted to the framework
- **Auditing existing patterns** for compliance
- **Writing new factor documentation** (Factors IV-XII)
- **Validating workflow implementations** in production
- **Ensuring contributions** follow framework principles
- **Quality checking** before committing factor-related changes

## Validation Workflow

### Step 1: Identify What to Validate

Determine what needs compliance checking:
- New factor documentation
- Pattern submissions
- Workflow implementations
- Case studies
- Research contributions

### Step 2: Load the Factors Checklist

Read `references/factors-checklist.md` to understand validation criteria for each factor. The checklist provides:
- Factor structure requirements
- Pillar derivation validation
- Laws enforcement verification
- Evidence requirements
- Anti-pattern identification

### Step 3: Perform Systematic Validation

For each factor or pattern being validated, check:

1. **Structure Compliance**: Does it follow the required format?
2. **Pillar Derivation**: Is it properly grounded in one or more Four Pillars?
3. **Laws Enforcement**: Does it enforce the appropriate Laws?
4. **Evidence**: Does it include real-world validation?
5. **Relationships**: Are connections to other factors documented?

### Step 4: Use Validation Script (Optional)

For automated checking of factor documentation:

```bash
python3 scripts/validate_factor.py path/to/factor.md
```

The script checks:
- Required sections present
- Pillar/Laws references
- Evidence sections
- Anti-patterns documented
- Cross-references to other factors

### Step 5: Document Findings

Create a validation report that includes:
- ✅ What passes compliance
- ❌ What needs improvement
- 💡 Suggestions for enhancement
- 🔗 Related factors or patterns

## Validation Criteria

### Factor Documentation Must Include

1. **Summary**: One-sentence principle
2. **The Problem**: What this factor solves
3. **The Principle**: How it works
4. **Why This Works**: Theory and evidence grounding
5. **Implementation**: Practical guidance
6. **Validation**: Success metrics
7. **Real-World Evidence**: Production data
8. **Anti-Patterns**: Common mistakes
9. **Relationships**: Connections to other factors

### Pattern Documentation Must Include

1. **Context**: Domain and use case
2. **Problem**: Operational challenge
3. **Solution**: Pattern application
4. **Outcome**: Results and metrics
5. **Laws Compliance**: Maps to Five Laws
6. **Pillar Grounding**: References Four Pillars
7. **Generalizability**: Transferability assessment

### Workflow Validation Must Check

1. **Factor Adherence**: Which factors does it implement?
2. **Laws Compliance**: Does it follow all Five Laws?
3. **Observability**: Can success be measured?
4. **Documentation**: Is context preserved for future agents?
5. **Reproducibility**: Can others replicate this?

## Example Validation Reports

### Validating a New Pattern Submission

```markdown
## Pattern: Multi-Agent Orchestration

**Validation Report**:

✅ **Structure**: Follows pattern template correctly
✅ **Pillar Grounding**: References DevOps + SRE (Pillar 1)
✅ **Laws Compliance**: Enforces Laws 2 (Improvement) and 5 (Sharing)
❌ **Evidence**: Missing production metrics - needs quantified results
💡 **Suggestion**: Add impact data from real implementations
✅ **Relationships**: Properly links to Factor III (Single-Responsibility)
❌ **Anti-Patterns**: Section exists but only 1 example - needs 2-3 more

**Overall**: 70% compliant. Needs evidence and anti-pattern expansion.
```

### Validating Factor Documentation

```markdown
## Factor IV: Validation Gates Before Execution

**Validation Report**:

✅ **Required Sections**: All 9 sections present
✅ **Summary**: Clear one-sentence principle
✅ **Problem/Principle**: Well-articulated
✅ **Pillar Derivation**: Correctly derives from DevOps + SRE
✅ **Laws Enforcement**: Enforces Laws 3 and 4 as specified
❌ **Evidence**: Draft status - needs production validation
💡 **Implementation**: Good examples, could use more code snippets
✅ **Relationships**: Links to Factors I, XI appropriately

**Overall**: 85% compliant. Production evidence needed before v1.0 release.
```

## Common Validation Issues

### Missing Evidence
**Problem**: Pattern or factor lacks production validation
**Solution**: Add metrics from real implementations or mark as "Draft"

### Weak Pillar Grounding
**Problem**: Connection to Four Pillars is superficial
**Solution**: Explain WHY the pillar supports this factor with theory

### Incomplete Laws Compliance
**Problem**: Claims to enforce laws but doesn't show how
**Solution**: Explicitly document how each law is enforced

### Poor Generalizability Assessment
**Problem**: Pattern seems domain-specific but claims universality
**Solution**: Identify what's generalizable vs. context-specific

## Resources

### references/factors-checklist.md
Comprehensive checklist of all 12 factors with validation criteria, required sections, and quality standards. Load this to understand what makes compliant factor documentation.

### scripts/validate_factor.py
Python script that performs automated structural validation of factor markdown files. Checks for required sections, proper formatting, and cross-references.

---

**Remember**: Compliance checking ensures the framework maintains quality and consistency so practitioners can trust the patterns they implement.
