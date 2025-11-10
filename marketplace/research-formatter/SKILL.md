---
name: research-formatter
description: Format research contributions, case studies, and empirical validation for the 12-Factor AgentOps framework. Use when documenting research findings, creating case studies, or submitting empirical evidence for patterns.
---

# Research Contribution Formatter

Structure research contributions, case studies, and empirical validation following 12-Factor AgentOps framework standards.

## Purpose

This skill ensures research contributions are properly formatted, grounded in theory, and provide actionable insights for practitioners. It transforms raw research findings into framework-compliant documentation.

## When to Use This Skill

Use this skill when:
- **Documenting research findings** for the framework
- **Creating case studies** from production experience
- **Submitting empirical validation** of patterns
- **Publishing experiment results**
- **Formalizing hypothesis testing** outcomes
- **Contributing theoretical grounding** for factors/patterns

## Research Contribution Types

### Type 1: Empirical Studies
Test pattern effectiveness with controlled experiments.

**Template**: `assets/research-template.md`

**Required sections:**
- Hypothesis
- Method
- Results
- Analysis
- Implications
- Connections (to patterns/factors)

### Type 2: Case Studies
Document real production applications.

**Template**: `assets/case-study-template.md`

**Required sections:**
- Context (domain, scale, duration)
- Pattern(s) Applied
- Results (quantified)
- Lessons Learned
- Validation

### Type 3: Theoretical Grounding
Provide academic/theoretical foundation for patterns.

**Template**: `assets/theoretical-grounding-template.md`

**Required sections:**
- Pattern/Factor being grounded
- Theoretical framework
- Supporting research
- Implications for practice

## Formatting Workflow

### Step 1: Identify Contribution Type

**Ask:**
- Is this testing a hypothesis? → Empirical study
- Is this documenting production use? → Case study
- Is this providing theory? → Theoretical grounding

### Step 2: Use Appropriate Template

Load template from `assets/` directory based on type.

**Templates include:**
- Required sections structure
- Example content
- Quality standards
- Metadata requirements

### Step 3: Complete All Sections

**For empirical studies:**
1. **Hypothesis**: What are you testing?
2. **Method**: How did you test it?
3. **Results**: What did you find (quantified)?
4. **Analysis**: What does it mean?
5. **Implications**: How should framework change?

**For case studies:**
1. **Context**: Domain, scale, duration
2. **Patterns Applied**: Which patterns from framework?
3. **Results**: Quantified outcomes
4. **Lessons**: What worked vs. didn't
5. **Validation**: Confidence in generalization

**For theoretical grounding:**
1. **Target**: Pattern/factor being grounded
2. **Framework**: Theoretical lens
3. **Research**: Supporting studies
4. **Practice**: Implications for operators

### Step 4: Quantify Everything

Research must include metrics:

**Good (quantified):**
- "95% success rate across 50 sessions"
- "40x speedup compared to baseline"
- "Reduced context collapse from 30% to 0%"

**Bad (vague):**
- "Much faster"
- "Really helped"
- "Significant improvement"

### Step 5: Connect to Framework

Every research contribution must link to framework:

**Required connections:**
- Which patterns does this validate/challenge?
- Which factors are supported/questioned?
- Which pillars provide grounding?
- Which laws are enforced?

### Step 6: Assess Generalizability

**Be honest about:**
- Sample size and selection
- Context limitations
- Confounding factors
- Reproducibility confidence

## Quality Standards

### Excellent Research Contribution
- Clear hypothesis or research question
- Rigorous methodology
- Quantified results with statistical analysis
- Honest about limitations
- Strong framework connections
- Actionable implications

### Needs Improvement
- Vague research question
- Methodology unclear or weak
- Results not quantified
- Overgeneralized conclusions
- Weak framework connections
- No clear implications

## Common Research Pitfalls

### P-Hacking / Cherry-Picking
**Problem**: Only reporting positive results
**Solution**: Document what didn't work too

### Small Sample Sizes
**Problem**: Claiming generalization from 3 data points
**Solution**: Acknowledge limitations, call for replication

### Confirmation Bias
**Problem**: Only looking for evidence supporting hypothesis
**Solution**: Actively seek disconfirming evidence

### Missing Confounds
**Problem**: Attributing results to pattern when other factors involved
**Solution**: Control for variables, acknowledge confounds

## Example Research Contribution

```markdown
# Research: Phase-Based Workflow Effectiveness

## Hypothesis
Separating work into Research → Plan → Implement phases reduces
rework and improves outcomes compared to code-first approaches.

## Method
- **Sample**: 204 agent sessions over 6 months
- **Conditions**: 102 phase-separated, 102 code-first
- **Metrics**: Success rate, rework time, final quality
- **Control**: Same operator, similar complexity tasks

## Results
| Metric | Phase-Based | Code-First | Improvement |
|--------|-------------|------------|-------------|
| Success rate | 95% | 60% | +58% |
| Rework time | 5% | 35% | -86% |
| Quality score | 9.2/10 | 7.1/10 | +30% |

## Analysis
Phase separation significantly improves outcomes by preventing
premature optimization and enabling context optimization per phase.

Statistical significance: p < 0.001 (chi-square test)

## Implications
1. Recommend phase-based as default pattern
2. Add Factor IV guidance on phase transitions
3. Create tooling to enforce phase separation

## Connections
- **Factor II**: Enables 40% rule per phase
- **Pillar 2**: Learning science (deliberate practice)
- **Law 1**: Each phase extracts learnings
```

## Resources

### assets/research-template.md
Template for empirical studies with hypothesis testing.

### assets/case-study-template.md
Template for production case studies.

### assets/theoretical-grounding-template.md
Template for providing theoretical foundation for patterns.

---

**Remember**: Research compounds. Rigorous validation builds trust in the framework.
