# Documentation

**Welcome to 12-Factor AgentOps documentation!**

This documentation follows the [Diataxis](https://diataxis.fr/) framework: **Tutorials, How-To Guides, Reference, Explanation**

---

## 🌐 The Ecosystem

12-Factor AgentOps is one layer in a three-layer AI agent ecosystem:

```
BUILD → WORK → RUN

12-Factor Agents  → Vibe Coding → 12-Factor AgentOps
(HumanLayer)        (Gene & Steve)    (This repo)
```

| Layer | Framework | Focus |
|-------|-----------|-------|
| **BUILD** | [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) | Engineering patterns for building AI apps |
| **WORK** | [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) | Methodology for working with AI agents |
| **RUN** | **12-Factor AgentOps** (this repo) | Operational principles for reliability |

**This is the SRE to their DevOps.**

→ [Full ecosystem overview](./ecosystem.md)

---

## 🚀 Start Here

**New to 12-Factor AgentOps?**
→ [Getting Started Guide](./getting-started/) - Choose your path (15 min - 1 week)

**Want FAAFO immediately?**
→ [Quick Start](./getting-started/quick-start.md) - 15 minutes to first workflow

**Solo developer?**
→ [Solo Developer Guide](./getting-started/solo-developer.md) - 35% → 95% success rate

---

## 📚 Documentation by Type (Diataxis)

### 🎓 Tutorials (Learning-Oriented)
**Step-by-step learning paths for beginners**

- [Getting Started](./getting-started/) - Choose your journey
  - [Quick Start](./getting-started/quick-start.md) - 15 min to FAAFO
  - [Solo Developer](./getting-started/solo-developer.md) - 35% → 95% success rate
- [Complete Workflow Guide](./tutorials/workflow-guide.md) - Research → Plan → Implement → Learn

---

### 🛠️ How-To Guides (Task-Oriented)
**Problem-solving recipes for specific tasks**

- [How-To Index](./how-to/) - All guides organized by task
  - [Implement Validation Gates](./how-to/README.md#validation--quality) - Factor IV
  - [Prevent Context Collapse](./how-to/README.md#context-management) - Factor II
  - [Build Pattern Library](./how-to/README.md#pattern-libraries) - Factor XII
  - [Track Success Rates](./how-to/README.md#measurement--observability) - Factor V
  - [Resume Work Across Sessions](./how-to/README.md#session-management) - Factor VI
  - [And 20+ more...](./how-to/)

---

### 📖 Reference (Information-Oriented)
**Quick lookup for facts, APIs, and details**

- [Reference Index](./reference/) - Quick lookup
  - [12 Factors Table](./reference/README.md#the-12-factors) - All factors at a glance
  - [FAAFO Dimensions](./reference/README.md#faafo-dimensions) - Fast, Ambitious, Autonomous, Fun, Optionality
  - [Five Pillars](./reference/README.md#five-pillars) - Constraint-Based Engineering, DevOps/SRE, Learning Science, Context Engineering, Knowledge OS
  - [Nine Laws](./reference/README.md#five-laws) - Mandatory principles
  - [Key Metrics](./reference/README.md#key-metrics) - Success rate, speedup, FAAFO score
  - [Common Commands](./reference/README.md#common-commands) - Make targets, git workflow
  - [Glossary](./reference/README.md#glossary) - Terms and definitions

---

### 💡 Explanation (Understanding-Oriented)
**Conceptual deep dives and background**

- [FAAFO North Star](./explanation/faafo-north-star.md) ⭐ - Why this exists (the driving belief)
- [Standing on Giants](./explanation/standing-on-giants.md) - How we adapted 12-Factor App, DevOps, Learning Science
- [AI Summit Validation 2025](./explanation/ai-summit-validation-2025.md) - Industry validation from 22 technical leaders
- [Five Pillars](./principles/five-pillars.md) - Technical foundations (detailed)
- [Nine Laws](./principles/nine-laws.md) - Mandatory operational principles
- [Context Engineering](./principles/context-engineering.md) - The 40% rule explained
- [Knowledge OS](./principles/knowledge-os.md) - Git as institutional memory
- [Constraint-Based Engineering](./principles/constraint-based-engineering.md) - Designing within limits
- [Scientific Foundation](./reference/scientific-foundation.md) - Research backing the patterns
- [Production Metrics](./case-studies/production/metrics.md) - Real-world results (35% → 95%, 2.7-40x speedup)

---

### 📊 Case Studies
**Real-world implementations and outcomes**

- [Production Case Studies](./case-studies/production/) - How it works in practice
  - [Factor Mapping](./case-studies/production/factor-mapping.md)
  - [Metrics](./case-studies/production/metrics.md)

---

### 🎯 Domain-Specific
**Specialized guides for specific domains**

- [Platform Engineering Agent](./domain-guides/platform-engineering-agent.md)

---

## 🗺️ Navigation by Goal

### "I want to start using this"
→ [Getting Started](./getting-started/) → Pick your path

### "I have a specific problem to solve"
→ [How-To Guides](./how-to/) → Find your task

### "I need to look something up quickly"
→ [Reference](./reference/) → Quick lookup

### "I want to understand why this works"
→ [Explanation](./explanation/) → Deep dives

### "I want to see real examples"
→ [Case Studies](./case-studies/) → Production stories

---

## 🔍 Find by Factor

Looking for documentation about a specific factor?

| Factor | Getting Started | How-To | Reference | Explanation |
|--------|-----------------|--------|-----------|-------------|
| **I: Automated Tracking** | [Quick Start](./getting-started/quick-start.md#step-1) | Git Workflow | [Factor I](../factors/01-automated-tracking.md) | [Knowledge OS](./principles/knowledge-os.md) |
| **II: Context Loading** | [Quick Start](./getting-started/quick-start.md#add-factor-ii) | [Prevent Collapse](./how-to/README.md#context-management) | [Factor II](../factors/02-context-loading.md) | [Context Engineering](./principles/context-engineering.md) |
| **III: Focused Agents** | [Solo Dev](./getting-started/solo-developer.md#factor-iii) | Multi-Phase | [Factor III](../factors/03-focused-agents.md) | [Learning Science](./principles/five-pillars.md) |
| **IV: Continuous Validation** | [Quick Start](./getting-started/quick-start.md#step-2) | [Validation Gates](./how-to/README.md#validation--quality) | [Factor IV](../factors/04-continuous-validation.md) | [DevOps/SRE](./principles/five-pillars.md) |
| **V: Measure Everything** | [Solo Dev](./getting-started/solo-developer.md#factor-v) | [Track Success](./how-to/README.md#measurement--observability) | [Factor V](../factors/05-measure-everything.md) | [Metrics](./production-metrics.md) |
| **VI: Resume Work** | [Solo Dev](./getting-started/solo-developer.md#factor-vi) | [Session Notes](./how-to/README.md#session-management) | [Factor VI](../factors/06-resume-work.md) | [Context Engineering](./principles/context-engineering.md) |
| **VII-XII** | [Workflow Guide](./tutorials/workflow-guide.md) | [How-To](./how-to/) | [Factors](../factors/) | [Pillars](./principles/five-pillars.md) |

---

## 📈 Find by FAAFO Dimension

Looking to achieve a specific FAAFO goal?

| FAAFO Goal | Start Here | Relevant Factors |
|------------|------------|------------------|
| **Fast** | [Validation Gates](./how-to/README.md#validation--quality) | II, IV, V |
| **Ambitious** | [Pattern Library](./how-to/README.md#pattern-libraries) | IX, XII |
| **Autonomous** | [Solo Developer Guide](./getting-started/solo-developer.md) | I, III, IV, VII, VIII |
| **Fun** | [Quick Start](./getting-started/quick-start.md) | IV, XI |
| **Optionality** | [Context Management](./how-to/README.md#context-management) | II, VI |

---

## 🆘 Common Questions

**"Where do I start?"**
→ [Getting Started](./getting-started/) - Choose based on your role and goals

**"How do I do X?"**
→ [How-To Guides](./how-to/) - Task-oriented recipes

**"What does Y mean?"**
→ [Reference](./reference/) - Quick lookup and glossary

**"Why does this work?"**
→ [Explanation](./explanation/) - Conceptual understanding

**"Does this actually work in production?"**
→ [Production Metrics](./production-metrics.md) + [Case Studies](./case-studies/)

---

## 🔗 External Resources

### Ecosystem
- **Ecosystem Overview:** [./ecosystem.md](./ecosystem.md) - Where we fit
- **Ecosystem Position:** [./explanation/ecosystem-position.md](./explanation/ecosystem-position.md) - Deep dive

### Related Frameworks
- **12-Factor App (original):** https://12factor.net - Adam Wiggins, 2011
- **12-Factor Agents:** https://github.com/humanlayer/12-factor-agents - Dex Horthy, HumanLayer
- **Vibe Coding:** https://itrevolution.com/product/vibe-coding-book/ - Gene Kim & Steve Yegge

### Internal
- **Main README:** [../README.md](../README.md)
- **The 12 Factors:** [../factors/](../factors/)
- **Gene Kim (FAAFO):** [./explanation/faafo-north-star.md](./explanation/faafo-north-star.md)
- **Diátaxis Framework:** https://diataxis.fr/

---

**Choose your path and get started! 🚀**
