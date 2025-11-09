# Quantitative Study Template

**Purpose:** Conduct and submit a rigorous quantitative validation study

**Who should use this:** Researchers, teams tracking detailed metrics

**Effort:** 4-8 hours (study design + execution + analysis)

---

## Study Metadata

**Study Title:** [Descriptive title, e.g., "Validation of JIT Context Loading in Data Science Workflows"]
**Researcher(s):** [Names/handles]
**Affiliation(s):** [Institution/company or "Independent"]
**Date:** [YYYY-MM-DD]
**Study Duration:** [e.g., "6 weeks", "3 months"]

---

## Research Question

**Primary hypothesis:**
[State your hypothesis clearly, e.g., "Factor II (JIT Context Loading) reduces context collapse events by >50% in data science workflows"]

**Factors being validated:** [Select from I-XII]

**Domain/Context:** [Where is this being tested]

---

## Methodology

### Sample

**Sample size:**
- Planned: [n = ?]
- Actual: [n = ?]
- Unit of analysis: [e.g., "agent sessions", "workflow executions", "commits"]

**Sample characteristics:**
- Domain: [e.g., "Web development", "Data pipelines"]
- Complexity: [Simple | Moderate | Complex]
- Team size: [Solo | Small | Medium | Large]
- Duration: [How long was each unit observed]

**Sampling method:**
- [ ] Random sampling
- [ ] Convenience sampling
- [ ] Stratified sampling
- [ ] Other: ________________

### Design

**Study type:**
- [ ] Observational (track existing usage)
- [ ] Before/After comparison (with vs without framework)
- [ ] Controlled experiment (random assignment)
- [ ] Case study (deep dive on specific instances)

**Controls:**
[What variables were controlled? What potential confounds exist?]

**Blinding:**
- [ ] Not applicable (observational)
- [ ] Single-blind (participants didn't know hypothesis)
- [ ] Double-blind (analyst didn't know group assignments)

### Metrics

**Primary outcome measure:**
[What are you measuring? e.g., "Context collapse rate", "Task completion time"]

**Operational definition:**
[How exactly did you measure it? Be specific.]

**Secondary measures:**
- Measure 1: [Description + how measured]
- Measure 2: [Description + how measured]

**Data collection method:**
- [ ] Automated telemetry
- [ ] Manual tracking
- [ ] Git history analysis
- [ ] Survey/self-report
- [ ] Mixed methods

---

## Results

### Descriptive Statistics

**Sample achieved:**
- n = [actual sample size]
- Attrition: [if any participants dropped out]
- Data quality: [complete data for all cases? missing data?]

**Outcome distributions:**

| Metric | Mean | SD | Median | Min | Max |
|--------|------|-----|--------|-----|-----|
| [Primary outcome] | | | | | |
| [Secondary 1] | | | | | |
| [Secondary 2] | | | | | |

### Inferential Statistics

**Primary hypothesis test:**
- Test used: [e.g., "t-test", "ANOVA", "chi-square", "regression"]
- Result: [test statistic, p-value]
- Effect size: [Cohen's d, R², etc.]
- Confidence interval: [95% CI]

**Interpretation:**
[What do these results mean? Did hypothesis hold?]

**Statistical significance:**
- [ ] p < 0.05 (statistically significant)
- [ ] p < 0.01 (highly significant)
- [ ] p ≥ 0.05 (not statistically significant)

**Practical significance:**
[Even if statistically significant, is the effect large enough to matter?]

### Visualization

**Graphs/charts:**
[Include or describe key visualizations]

```
[If text-based, include ASCII plots or describe charts you'd attach]
```

---

## Analysis

### Findings

**Key finding 1:**
[Description + supporting data]

**Key finding 2:**
[Description + supporting data]

**Unexpected results:**
[Anything surprising or contradictory to hypothesis]

### Limitations

**Internal validity threats:**
- [What alternative explanations exist?]
- [What confounds weren't controlled?]

**External validity threats:**
- [How might results differ in other contexts?]
- [What limits generalizability?]

**Construct validity threats:**
- [Are you measuring what you think you're measuring?]

**Statistical conclusion validity:**
- [Sample size adequate for power?]
- [Assumptions of tests met?]

### Recommendations

**For framework:**
[How should the framework be modified based on findings?]

**For future research:**
[What questions remain? What should be studied next?]

---

## Raw Data (Optional)

**Data sharing:**
- [ ] Anonymized dataset attached
- [ ] Aggregated data only (in results section)
- [ ] Available upon request
- [ ] Cannot be shared (proprietary/sensitive)

**Data format:**
[If sharing: CSV, JSON, etc.]

**Data dictionary:**
[Variable names and definitions if dataset provided]

---

## Validation Criteria

**This study meets requirements for:**

- [ ] 🟢 **Strong Evidence** (n≥30, stats, CI, documented methodology)
- [ ] 🟡 **Qualitative Evidence** (multiple observations, no stats)
- [ ] 🔴 **Insufficient** (anecdotal only)

**Quality checklist:**
- [ ] Sample size ≥ 30
- [ ] Statistical analysis performed
- [ ] Confidence intervals reported
- [ ] Methodology clearly documented
- [ ] Limitations acknowledged
- [ ] Raw data available (or aggregate sufficient)

---

## Publication

**Consent:**
- [ ] This study may be published in validation/studies/ directory
- [ ] Results may be cited in framework documentation
- [ ] Include in aggregate meta-analysis

**Attribution:**
- [ ] Attribute to researchers by name
- [ ] Attribute to affiliation
- [ ] Anonymous contribution

**License:**
- [ ] CC BY-SA 4.0 (same as framework)
- [ ] CC BY 4.0 (attribution only)
- [ ] Other: ________________

---

## Peer Review (Optional)

**External review:**
- [ ] Study was peer-reviewed before submission
- [ ] Seeking peer review as part of validation process
- [ ] No external review

**Reviewer comments:**
[If reviewed, summarize key feedback]

---

## Submission

**How to submit:**

1. **Pull Request:** Add this file to `validation/studies/[factor-name]-[your-name]-[date].md`
2. **Include:** Raw data (if possible), visualizations, supplementary materials
3. **Discussion:** Open an issue for community discussion of findings

**Questions?** Contact [email] or open a discussion at https://github.com/boshu2/12-factor-agentops/discussions

---

## Appendix: Statistical Guidance

### Recommended Sample Sizes

**For claims of difference:**
- Minimum: n = 30 per group
- Better: n = 50 per group
- Best: n = 100+ per group (detects smaller effects)

### Common Tests

**Comparing before/after:** Paired t-test
**Comparing two groups:** Independent t-test
**Comparing 3+ groups:** ANOVA
**Proportion comparison:** Chi-square test
**Relationship strength:** Correlation, regression

### Effect Size Interpretation

**Cohen's d:**
- Small: d = 0.2
- Medium: d = 0.5
- Large: d = 0.8

**R² (variance explained):**
- Small: R² = 0.01
- Medium: R² = 0.09
- Large: R² = 0.25

---

**Thank you for contributing rigorous validation research!**

Your quantitative study helps build the evidence base for what works across domains and contexts.
