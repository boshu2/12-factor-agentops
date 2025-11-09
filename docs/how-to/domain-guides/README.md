# Domain-Specific Implementation Guides

**Apply 12-Factor AgentOps patterns to your specific domain**

The 12-Factor AgentOps methodology is designed to be universal—the same principles work whether you're writing code, analyzing data, creating content, or managing infrastructure. However, the **implementation details** vary by domain.

These guides show you how to apply the framework to your specific work.

---

## Available Domain Guides

| Domain | Guide | Time to Read | Who It's For |
|--------|-------|--------------|--------------|
| **Software Development** | [Software Development Guide](software-development.md) | 20-30 min | Developers using AI for coding |
| **DevOps & Infrastructure** | [DevOps Guide](devops-infrastructure.md) | 20-30 min | SREs, DevOps engineers, platform teams |
| **Data Science & Analytics** | [Data Science Guide](data-science-analytics.md) | 20-30 min | Data scientists, analysts, researchers |
| **Solo Developer** | [Solo Developer Guide](solo-developer.md) | 15-20 min | Individual developers, freelancers |

---

## How Domain Guides Work

**Each domain guide includes:**

1. **Domain Context**
   - Typical AI usage patterns in this domain
   - Common pain points and challenges
   - Success metrics relevant to domain

2. **Factor Prioritization**
   - Which factors matter most for this domain
   - Which factors can be deferred
   - Domain-specific implementation order

3. **Practical Examples**
   - Real scenarios from this domain
   - Before/after comparisons
   - Code samples and configurations

4. **Tool Integration**
   - How to integrate with domain-specific tools
   - Recommended AI tools for this domain
   - Configuration examples

5. **Success Stories**
   - Measured results from this domain
   - Common implementation patterns
   - Lessons learned

---

## Choosing Your Domain Guide

### Software Development
**Read this if you:**
- Use AI for coding, testing, refactoring
- Work with IDEs like VS Code, Cursor, or Claude Code
- Need to ship production code safely
- Care about code quality, tests, CI/CD

**Common scenarios:**
- AI-generated code review
- Test generation and coverage
- Refactoring assistance
- Documentation generation

### DevOps & Infrastructure
**Read this if you:**
- Manage infrastructure, Kubernetes, cloud resources
- Use AI for automation, scripts, IaC
- Need to ensure production reliability
- Work with monitoring, observability, incident response

**Common scenarios:**
- Infrastructure as Code generation
- Kubernetes manifest creation
- Monitoring/alerting configuration
- Incident response automation

### Data Science & Analytics
**Read this if you:**
- Use AI for data analysis, visualization, modeling
- Work with Python, R, SQL, notebooks
- Need reproducible analysis
- Care about statistical validity

**Common scenarios:**
- Exploratory data analysis
- Feature engineering
- Model development
- Report generation

### Solo Developer
**Read this if you:**
- Work alone or on small teams
- Wear multiple hats (dev, ops, design, etc.)
- Need maximum productivity with minimal overhead
- Want pragmatic patterns, not enterprise process

**Common scenarios:**
- Full-stack development
- Side projects and startups
- Freelance client work
- Learning and experimentation

---

## Universal Principles (All Domains)

**Regardless of domain, these patterns always apply:**

### The Pragmatic Three (Always Start Here)

**Factor I: Git Memory**
- Commit all AI work with detailed context
- Applies to: Code, configs, analysis scripts, documentation

**Factor II: JIT Context Loading**
- Stay under 40% context utilization
- Applies to: Long sessions, complex projects, multi-file work

**Factor IV: Validation Gates**
- Test before commit (shift-left)
- Applies to: Code tests, config validation, analysis checks

### Context Engineering (40% Rule)

**Universal observation:** Performance degrades above 40% context utilization

**Applies to:**
- Software development: Code generation sessions
- DevOps: Infrastructure automation
- Data science: Analysis workflows
- Solo work: Any extended AI interaction

**Implementation varies by domain** (see domain guides for specifics)

### Zero-Trust Validation

**Universal principle:** Never trust AI output without validation

**Applies to:**
- Software development: Run tests, lint, build
- DevOps: Validate configs, dry-run changes
- Data science: Check statistical validity, verify results
- Solo work: Test locally before deploying

**Implementation varies by domain** (see domain guides for tools)

---

## Domain Adaptation Pattern

**When adapting framework to your domain:**

### Step 1: Identify Your Core AI Usage

**Questions:**
- What do you use AI for most often?
- What are your biggest pain points with AI?
- What would failure look like in your domain?

**Example (Software Development):**
- Primary use: Code generation and refactoring
- Pain point: AI code breaks tests, causes bugs
- Failure: Production incidents from untested AI code

### Step 2: Map to Relevant Factors

**Use the decision tree:**
- [Decision Tree](../../tutorials/decision-tree.md) - Which factor for which problem?

**Example (Software Development):**
- Pain: AI code breaks tests → Factor IV (Validation Gates)
- Pain: Context collapse → Factor II (JIT Context Loading)
- Pain: No memory of decisions → Factor I (Git Memory)

### Step 3: Implement Foundation Factors (I, II, IV)

**Universal starting point** for all domains

**Software Development:**
```bash
# Factor I: Git Memory
git commit -m "feat(auth): Add JWT validation

Context: Users bypassing auth
Solution: JWT signature verification
AI-Assisted: Claude Code generated logic"

# Factor II: JIT Context
# Monitor context % in IDE, stay under 40%

# Factor IV: Validation Gates
npm test && git commit  # Test before commit
```

**DevOps:**
```bash
# Factor I: Git Memory
git commit -m "feat(k8s): Add resource limits

Context: Pods consuming too much memory
Solution: Added requests/limits to deployment
AI-Assisted: Copilot generated YAML"

# Factor II: JIT Context
# Load manifests JIT, not all at once

# Factor IV: Validation Gates
kubectl apply --dry-run=client -f manifest.yaml
kustomize build . | kubeval
```

**Data Science:**
```python
# Factor I: Git Memory
git commit -m "analysis: Customer churn prediction

Context: Need to identify at-risk customers
Solution: Logistic regression model, 85% accuracy
AI-Assisted: ChatGPT suggested feature engineering"

# Factor II: JIT Context
# Load data in chunks, not entire dataset at once

# Factor IV: Validation Gates
pytest tests/  # Test data processing
python -m mypy analysis.py  # Type checking
```

### Step 4: Add Domain-Specific Factors

**Read your domain guide** for which factors to add next

**Software Development:** VII (Task Routing), VIII (Human Gates)
**DevOps:** V (Telemetry), XI (Constitutional Guardrails)
**Data Science:** VI (Session Continuity), IX (Pattern Extraction)
**Solo:** III (Single-Responsibility), X (Continuous Improvement)

### Step 5: Measure and Iterate

**Track domain-specific metrics:**

**Software Development:**
- Test pass rate (before/after AI)
- Bug rate in AI-generated code
- Time saved on development

**DevOps:**
- Config validation pass rate
- Incident rate (AI vs manual changes)
- Time saved on automation

**Data Science:**
- Analysis reproducibility rate
- Statistical validity checks passed
- Time saved on exploratory analysis

**Solo Developer:**
- Features shipped per week
- Rework rate (changes after commit)
- Overall velocity improvement

---

## Cross-Domain Patterns

**Patterns that work across multiple domains:**

### Pattern: Phase-Based Workflow

**Domains:** All
**Factors:** VI (Session Continuity), VII (Task Routing)

```
Research Phase:
- Understand problem deeply
- Explore solutions
- Document findings
- Save bundle

Plan Phase:
- Design solution
- Specify implementation
- Review with human (if high-stakes)
- Save bundle

Implement Phase:
- Execute plan
- Validate continuously
- Commit with context
- Extract learnings
```

**Software Development:** Research API → Plan architecture → Implement code
**DevOps:** Research tools → Plan infrastructure → Implement IaC
**Data Science:** Research data → Plan analysis → Implement models

### Pattern: Validation Cascade

**Domains:** All
**Factor:** IV (Validation Gates)

```
Level 1: Syntax Validation (Immediate)
- Lint, type check, format

Level 2: Unit Validation (Per Change)
- Run relevant tests

Level 3: Integration Validation (Before Commit)
- Run test suite

Level 4: Production Validation (Before Deploy)
- Dry-run, staging tests
```

**Software Development:** ESLint → Jest → CI pipeline → Staging
**DevOps:** YAML lint → kubeval → kubectl apply --dry-run → Staging cluster
**Data Science:** mypy → pytest → notebooks run → Results validation

### Pattern: Institutional Memory

**Domains:** All
**Factors:** I (Git Memory), IX (Pattern Extraction)

```
Commit Message Template:
---
<type>(<scope>): <subject>

Context: Why was this needed?
Solution: What was done and how?
AI-Assisted: Which AI tool/model?
Learning: What pattern emerged?
Impact: What improved?
---
```

**Software Development:** Track code patterns that work
**DevOps:** Track automation patterns that work
**Data Science:** Track analysis patterns that work

---

## Domain-Specific Metrics

**Success metrics by domain:**

### Software Development
| Metric | Target | Measurement |
|--------|--------|-------------|
| Test pass rate (first try) | >90% | CI results |
| Bug rate (AI code) | <5% | Issue tracker |
| Code review cycles | <2 | PR metrics |
| Time saved (vs manual) | >40% | Time tracking |

### DevOps & Infrastructure
| Metric | Target | Measurement |
|--------|--------|-------------|
| Config validation pass rate | >95% | Dry-run results |
| Change failure rate | <5% | Deployment tracking |
| MTTR (AI-assisted) | <Manual | Incident tracking |
| Automation coverage | >80% | Runbook audit |

### Data Science & Analytics
| Metric | Target | Measurement |
|--------|--------|-------------|
| Analysis reproducibility | 100% | Re-run tests |
| Statistical validity rate | >95% | Peer review |
| Time saved (vs manual) | >50% | Time tracking |
| Notebook reliability | >90% | Execution tests |

### Solo Developer
| Metric | Target | Measurement |
|--------|--------|-------------|
| Features shipped/week | +50% | Commit tracking |
| Rework rate | <10% | Changes after commit |
| Overall velocity | +3x | Baseline comparison |
| Confidence level | High | Subjective rating |

---

## Getting Started with Your Domain

**Quick start by domain:**

### Software Development → Start Here
1. Read [Software Development Guide](software-development.md)
2. Implement Factors I, II, IV (Git Memory, JIT Context, Validation Gates)
3. Add VII (Task Routing) for complex projects
4. Track: Test pass rate, bug rate, time saved

### DevOps & Infrastructure → Start Here
1. Read [DevOps Guide](devops-infrastructure.md)
2. Implement Factors I, II, IV (same foundation)
3. Add V (Telemetry) for observability
4. Track: Config validation, change failure rate, MTTR

### Data Science & Analytics → Start Here
1. Read [Data Science Guide](data-science-analytics.md)
2. Implement Factors I, II, IV (same foundation)
3. Add VI (Session Continuity) for long analyses
4. Track: Reproducibility, validity, time saved

### Solo Developer → Start Here
1. Read [Solo Developer Guide](solo-developer.md)
2. Implement Factors I, II, IV (the pragmatic three)
3. Add III (Single-Responsibility) when complexity grows
4. Track: Features shipped, rework rate, velocity

---

## Contributing Domain Knowledge

**Have experience applying 12-Factor AgentOps in a specific domain?**

### Share Your Patterns

**We need:**
- Domain-specific implementation examples
- Tool integration guides
- Success metrics from your domain
- Anti-patterns (what didn't work)

**Submit via:**
1. [Community Validation Template](../../validation/templates/community-validation.md)
2. Pull request to appropriate domain guide
3. Issue with "domain-specific pattern" label

### Request a Domain Guide

**Need a guide for a domain not listed?**

**Domains we're considering:**
- Content Creation & Marketing
- Product Management
- Customer Support
- Research & Academic Work
- Design & UX
- Education & Teaching

**Request via:**
- Open issue: "Domain Guide Request: [Your Domain]"
- Include: Common AI usage, pain points, success metrics

---

## Next Steps

**Choose your domain guide above and start reading!**

**Not sure which domain?** Read [Role-Specific Paths](../../tutorials/role-specific-paths.md) first

**Want quick reference?** See [Quick Reference Card](../../tutorials/quick-reference-card.md)

**Have a specific problem?** Use [Decision Tree](../../tutorials/decision-tree.md)
