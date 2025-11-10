# Data Science & Analytics Domain Guide

**Apply 12-Factor AgentOps to data analysis, modeling, and research with AI**

---

## Domain Context

### Typical AI Usage in Data Science

- Exploratory data analysis (EDA)
- Feature engineering
- Model development and tuning
- Data visualization
- Statistical analysis
- Report and notebook generation
- Documentation

### Common Pain Points

```
Week 1: ✨ "AI wrote perfect analysis code!" → Run it
Week 2: 😬 "Results don't reproduce, unclear methodology" → Re-run
Week 3: 🔥 "Stakeholders question statistical validity" → Redo
Week 4: 🚫 "Reviewing AI analysis takes longer than doing it" → Abandon
```

### Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Analysis reproducibility** | 100% | Re-run tests |
| **Statistical validity rate** | >95% | Peer review |
| **Time saved (vs manual)** | >50% | Time tracking |
| **Notebook reliability** | >90% | Execution tests |

---

## Factor Prioritization for Data Science

### Essential Foundation

**Factor I: Git Memory** - All analysis code and decisions tracked
**Factor II: JIT Context** - Load data in chunks, not entire datasets
**Factor IV: Validation Gates** - Statistical validity checks before publishing

### High-Value Add-Ons

**Factor VI: Session Continuity** - Save/load context for long analyses
**Factor IX: Pattern Extraction** - Document analysis patterns that work
**Factor V: Telemetry** - Track analysis quality over time

---

## Practical Examples

### Example 1: Exploratory Data Analysis

**With Framework:**

```python
# Factor II: Load data JIT, not all at once
import pandas as pd

# Don't: Load entire 10GB dataset
# df = pd.read_csv('huge_data.csv')  # OOM

# Do: Load in chunks
chunk_size = 10000
for chunk in pd.read_csv('huge_data.csv', chunksize=chunk_size):
    # Analyze chunk
    # AI assists with analysis code
    pass

# Factor IV: Validate statistical assumptions
from scipy import stats

# Check normality
statistic, p_value = stats.normaltest(data)
assert p_value > 0.05, "Data not normally distributed"

# Factor I: Commit with context
# git commit -m "analysis: customer churn EDA

# Context: Need to understand churn patterns
# Solution: EDA on 100k customer records
# AI-Assisted: ChatGPT suggested feature correlations
# Findings: Churn correlates with support tickets (r=0.72)
# Statistical Validity: All assumptions checked, p<0.05
#
# Next: Build predictive model"
```

### Example 2: Model Development

**With Framework:**

```python
# Research phase
# /research "best practices for churn prediction models"

# Plan phase
# /plan churn-research
# Output: Model approach, features, validation strategy

# Implement with validation (Factor IV)
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.linear_model import LogisticRegression

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Train model (AI-assisted)
model = LogisticRegression()
model.fit(X_train, y_train)

# Factor IV: Validate before claiming success
# Cross-validation
cv_scores = cross_val_score(model, X_train, y_train, cv=5)
assert cv_scores.mean() > 0.75, "Model accuracy too low"

# Test set
test_score = model.score(X_test, y_test)
assert test_score > 0.75, "Generalization poor"

# Statistical significance
# (Check that model beats baseline)

# Factor I: Document thoroughly
# git commit -m "model: add logistic regression for churn prediction

# Context: Predict customer churn for retention team
# Solution: Logistic regression, 12 features
# AI-Assisted: Claude Code suggested feature engineering
#
# Performance:
# - Train accuracy: 82%
# - Test accuracy: 79%
# - Cross-val mean: 81%
# - AUC-ROC: 0.85
#
# Features: support_tickets, tenure, payment_failures, ...
# Validation: Beats baseline (65%), statistically significant (p<0.001)
#
# Next: Deploy to staging for A/B test"
```

### Example 3: Reproducible Notebooks

**With Framework:**

```python
# Factor VI: Session continuity for long analyses

# === Day 1: Data exploration ===
# Notebook: exploration.ipynb
# Save bundle at end of day
# /bundle-save customer-churn-exploration

# === Day 2: Feature engineering ===
# Load previous work
# /bundle-load customer-churn-exploration
# Notebook: feature_engineering.ipynb
# /bundle-save customer-churn-features

# === Day 3: Modeling ===
# /bundle-load customer-churn-features
# Notebook: modeling.ipynb

# Factor IV: Notebook reliability
# Run all cells from top to bottom
# Assert no errors
# Assert all outputs reproducible

# Factor I: Version control
# git add exploration.ipynb feature_engineering.ipynb modeling.ipynb
# git commit -m "analysis: complete churn prediction pipeline
#
# Context: Full analysis pipeline from raw data to model
# Solution: 3 notebooks, end-to-end reproducible
# AI-Assisted: Claude Code for feature engineering
#
# Notebooks:
# 1. exploration.ipynb - EDA, data quality
# 2. feature_engineering.ipynb - 12 engineered features
# 3. modeling.ipynb - Logistic regression, validation
#
# Reproducibility: All cells run without errors
# Statistical validity: All checks passing"
```

---

## Tool Integration

### Jupyter Notebooks

```python
# Pre-commit validation for notebooks
# Run all cells from top to bottom
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor

def validate_notebook(notebook_path):
    with open(notebook_path) as f:
        nb = nbformat.read(f, as_version=4)

    ep = ExecutePreprocessor(timeout=600)
    try:
        ep.preprocess(nb, {'metadata': {'path': './'}})
        return True
    except Exception as e:
        print(f"Notebook failed: {e}")
        return False

# Run before committing
assert validate_notebook('analysis.ipynb'), "Notebook not reproducible"
```

### Statistical Validation

```python
# Factor IV: Statistical validity checks
def validate_analysis(data, results):
    """Validate statistical assumptions"""

    # Check sample size
    assert len(data) > 30, "Sample too small"

    # Check for outliers
    from scipy import stats
    z_scores = stats.zscore(data)
    assert (abs(z_scores) < 3).all(), "Outliers detected"

    # Check normality if required
    if results.get('assumes_normality'):
        stat, p = stats.normaltest(data)
        assert p > 0.05, "Data not normally distributed"

    # Check significance
    if results.get('p_value'):
        assert results['p_value'] < 0.05, "Not statistically significant"

    return True
```

---

## Success Patterns

### Pattern 1: Reproducible Analysis Pipeline

```
Data Exploration (Day 1):
├─ Load data with validation
├─ Check data quality
├─ Initial visualizations
├─ Save bundle (Factor VI)
└─ Commit notebook (Factor I)

Feature Engineering (Day 2):
├─ Load bundle from Day 1
├─ Engineer features (AI-assisted)
├─ Validate statistical properties
├─ Save bundle
└─ Commit notebook

Modeling (Day 3):
├─ Load bundle from Day 2
├─ Train models (AI-assisted)
├─ Cross-validation (Factor IV)
├─ Statistical significance tests
├─ Save bundle
└─ Commit final results

Documentation (Day 4):
├─ Generate report from notebooks
├─ Document methodology
├─ Include all validation results
└─ Commit documentation
```

### Pattern 2: Collaborative Data Science

```
Factor I: Git for collaboration
├─ All notebooks in version control
├─ Detailed commit messages with findings
├─ Branch per analysis
└─ Merge after peer review

Factor IX: Pattern extraction
├─ Document successful analysis patterns
├─ Build team library of validated approaches
├─ Reuse feature engineering code
└─ Share statistical validation functions
```

---

## Anti-Patterns

### ❌ "Run AI Analysis Without Validation"

**Wrong:**
```python
# Ask AI: "Analyze this data"
# Copy/paste code
# Run it
# Report results
# ❌ Wrong assumptions, invalid conclusions
```

**Right:**
```python
# Ask AI: "Analyze this data"
# Review code for statistical validity
# Add validation checks
# Run with assertions
# Peer review before reporting
```

### ❌ "Non-Reproducible Notebooks"

**Wrong:**
```python
# Notebook with cells in random order
# Manual data edits not in code
# Hard-coded paths
# No seed for random operations
# ❌ Can't reproduce results
```

**Right:**
```python
# Run all cells from top to bottom
# All data operations in code
# Configurable paths
# Set random seeds
# ✅ Reproducible
```

---

## Getting Started Checklist

**Day 1:**
- [ ] Set up notebook validation
- [ ] Create statistical validation functions
- [ ] Configure git for notebooks

**Week 1: Foundation**
- [ ] Factor I: Commit all analysis with context
- [ ] Factor II: Load data in chunks
- [ ] Factor IV: Statistical validation before publishing

**Week 2: Advanced**
- [ ] Factor VI: Session bundles for long analyses
- [ ] Factor IX: Document patterns
- [ ] Factor V: Track analysis quality

---

## Resources

- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)
- [Statistical Validity Checks](https://www.statsmodels.org/)
- [Quick Reference Card](../../tutorials/quick-reference-card.md)

**Related Guides:**
- [Software Development Guide](software-development.md) - For analysis code
- [Solo Developer Guide](solo-developer.md) - If working alone
