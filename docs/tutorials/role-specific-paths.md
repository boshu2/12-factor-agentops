# Role-Specific Learning Paths

**Choose your path based on your goals and available time**

Everyone using AI agents needs reliable workflows. But your starting point and learning path depend on your role and objectives. This guide helps you navigate the 12-Factor AgentOps framework efficiently.

---

## Quick Path Selection

**Choose the path that matches your primary goal:**

| Role | Goal | Time Investment | Where to Start |
|------|------|-----------------|----------------|
| **[Researcher](#researcher-path)** | Deep understanding of theory and evidence | 60-90 minutes | Four Pillars → Five Laws → All Factors |
| **[Practitioner](#practitioner-path)** | Start using patterns immediately | 45-60 minutes | Quick Start → Foundation Factors → Apply |
| **[Contributor](#contributor-path)** | Validate and improve framework | 2-4 weeks | Quick Start → Pick domain → Validate → Submit |
| **[Solo Developer](#solo-developer-path)** | Pragmatic adoption for personal work | 20-30 minutes | Quick Start → Top 3 Factors → Iterate |

---

## Researcher Path

**Goal:** Understand the complete theoretical foundation and empirical evidence

**Time:** 60-90 minutes initial, ongoing for deep dives

### Phase 1: Foundation (30 minutes)

**1. Start with Why (10 min)**
- Read: [README.md](../../README.md) - Framework overview
- Read: [docs/foundations/evolution-of-12-factor.md](../foundations/evolution-of-12-factor.md) - Historical context
- **Key question:** How does this extend proven methodologies?

**2. Philosophical Grounding (20 min)**
- Read: [foundations/four-pillars.md](../../foundations/four-pillars.md) - DevOps+SRE, Learning Science, Context Engineering, Knowledge OS
- Read: [foundations/five-laws.md](../../foundations/five-laws.md) - Mandatory operational principles
- **Key question:** What assumptions underpin this framework?

### Phase 2: Complete Framework (30 minutes)

**3. All Twelve Factors (20 min)**
- Read: [factors/README.md](../../factors/README.md) - Complete factor list
- Skim: Each individual factor document (2 min each)
- **Key question:** How do factors derive from pillars and enforce laws?

**4. Validation Status (10 min)**
- Read: [validation/DISCLAIMER.md](../../validation/DISCLAIMER.md) - What's validated vs in-progress
- Read: [validation/DATA_SCHEMA.md](../../validation/DATA_SCHEMA.md) - How validation data is structured
- **Key question:** What evidence supports these claims?

### Phase 3: Deep Dives (30+ minutes, ongoing)

**5. Pick Your Research Interest**

**Context Engineering:**
- [foundations/context-engineering.md](../../foundations/context-engineering.md) - The 40% rule
- Factor II: [JIT Context Loading](../../factors/02-jit-context-loading.md)
- Factor VI: [Session Continuity via Bundles](../../factors/06-session-continuity-via-bundles.md)

**Learning Science:**
- [foundations/four-pillars.md](../../foundations/four-pillars.md) - Learning science section
- Factor III: [Single-Responsibility Agents](../../factors/03-single-responsibility-agents.md)
- Factor VII: [Intelligent Task Routing](../../factors/07-intelligent-task-routing.md)

**Zero-Trust Architecture:**
- [README.md](../../README.md) - Zero-trust cognitive infrastructure
- Factor IV: [Validation Gates Before Execution](../../factors/04-validation-gates-before-execution.md)
- Factor XI: [Constitutional Guardrails](../../factors/11-constitutional-guardrails.md)

**Institutional Memory:**
- [foundations/knowledge-os.md](../../foundations/knowledge-os.md) - Git as memory
- Factor I: [Git Memory as Knowledge OS](../../factors/01-git-memory-as-knowledge-os.md)
- Factor IX: [Documented Pattern Extraction](../../factors/09-documented-pattern-extraction.md)

### Researcher Next Steps

**After completing this path:**

1. **Identify research questions**
   - What claims need more evidence?
   - What domains need validation?
   - What edge cases aren't covered?

2. **Review validation templates**
   - [validation/templates/quantitative-study.md](../../validation/templates/quantitative-study.md) - Full research protocol
   - [validation/DATA_SCHEMA.md](../../validation/DATA_SCHEMA.md) - Data format specification

3. **Design validation study**
   - Pick domain (your area of expertise)
   - Define hypothesis
   - Plan methodology
   - Specify metrics

4. **Contribute findings**
   - Use quantitative study template
   - Submit via [CONTRIBUTING.md](../../CONTRIBUTING.md)
   - Help strengthen framework evidence base

---

## Practitioner Path

**Goal:** Start using reliable AI agent patterns immediately in your work

**Time:** 45-60 minutes to understand, then apply iteratively

### Phase 1: Quick Start (15 minutes)

**1. Understand the Problem (5 min)**
- Read: [docs/tutorials/first-30-minutes.md](first-30-minutes.md) - Part 1 (Why)
- **Key insight:** The 4-week trajectory from excitement to abandonment

**2. Learn the Solution (10 min)**
- Read: [docs/tutorials/first-30-minutes.md](first-30-minutes.md) - Part 2 (Philosophy)
- Focus: Four Pillars, Five Laws, quick overview of 12 Factors
- **Key insight:** Zero-trust validation infrastructure

### Phase 2: Foundation Factors (15 minutes)

**3. Master the Essential Three (15 min)**

These three factors form the foundation—implement them first:

**Factor I: Git Memory as Knowledge OS (5 min)**
- Read: [factors/01-git-memory-as-knowledge-os.md](../../factors/01-git-memory-as-knowledge-os.md)
- **Apply:** Commit all AI-generated work with context in commit messages
- **Why:** Git becomes institutional memory, patterns compound over time

**Factor II: JIT Context Loading (5 min)**
- Read: [factors/02-jit-context-loading.md](../../factors/02-jit-context-loading.md)
- **Apply:** Load context Just-In-Time, stay under 40% of context window
- **Why:** Prevents context collapse, maintains decision quality

**Factor IV: Validation Gates (5 min)**
- Read: [factors/04-validation-gates-before-execution.md](../../factors/04-validation-gates-before-execution.md)
- **Apply:** Test AI output locally before commit (shift left)
- **Why:** Catch errors when they're cheap to fix

### Phase 3: Apply to Your Work (15-30 minutes)

**4. Start Small, Iterate**

**Week 1: Foundation**
- Implement Factors I, II, IV in your current work
- Track what works, what doesn't
- Measure: Error rate, rework time, confidence level

**Week 2: Expand**
- Add Factor III (Single-Responsibility Agents)
- Add Factor VI (Session Continuity) if doing multi-day work
- Measure: Task completion rate, context utilization

**Week 3: Optimize**
- Add Factor VII (Intelligent Task Routing) for complex workflows
- Add Factor VIII (Human Gate Reviews) for high-stakes work
- Measure: Time saved, quality improvement

**Week 4: Mature**
- Review all 12 factors, implement what makes sense
- Document your patterns (Factor IX)
- Continuous improvement (Factor X)

### Practitioner Next Steps

**After completing this path:**

1. **Share your experience**
   - Use [validation/templates/community-validation.md](../../validation/templates/community-validation.md)
   - 30-60 minutes to document what worked
   - Help others in your domain

2. **Explore advanced factors**
   - Pick factors relevant to your challenges
   - Read implementation sections carefully
   - Adapt to your context

3. **Join the community**
   - Share patterns that worked
   - Document anti-patterns (what didn't work)
   - Help improve the framework

---

## Contributor Path

**Goal:** Validate framework in your domain and contribute improvements

**Time:** 2-4 weeks (intermittent), depending on validation depth

### Phase 1: Understand Framework (Week 1, 2-3 hours)

**1. Quick Start (30 min)**
- Read: [docs/tutorials/first-30-minutes.md](first-30-minutes.md)
- Read: [README.md](../../README.md)
- **Goal:** Understand what you're validating

**2. Validation Context (30 min)**
- Read: [validation/DISCLAIMER.md](../../validation/DISCLAIMER.md) - Current status
- Read: [CONTRIBUTING.md](../../CONTRIBUTING.md) - How to contribute
- Read: [validation/DATA_SCHEMA.md](../../validation/DATA_SCHEMA.md) - Data format
- **Goal:** Understand validation process

**3. Pick Your Template (1-2 hours)**

**Option A: Community Validation (30-60 min per validation)**
- Template: [validation/templates/community-validation.md](../../validation/templates/community-validation.md)
- Best for: Practitioners validating in their work
- Depth: Qualitative + lightweight quantitative
- Commitment: 1-4 validations over 2-4 weeks

**Option B: Quantitative Study (4-8 hours per study)**
- Template: [validation/templates/quantitative-study.md](../../validation/templates/quantitative-study.md)
- Best for: Researchers conducting rigorous validation
- Depth: Full statistical methodology
- Commitment: 1 comprehensive study

### Phase 2: Apply & Validate (Weeks 2-3, ongoing)

**4. Apply Factors in Your Domain**

**Choose your domain:**
- Software development (coding, testing, deployment)
- Content creation (writing, documentation, marketing)
- Data analysis (research, analytics, insights)
- Operations (DevOps, SRE, infrastructure)
- Product development (design, planning, execution)
- Other (specify your domain)

**Apply systematically:**
- Week 1: Baseline (your current AI usage, no framework)
- Week 2: Foundation factors (I, II, IV)
- Week 3: Expand (add 3-4 more factors)
- Week 4: Measure and document

**Track everything:**
- What factors you applied
- What worked well
- What didn't work
- Quantitative metrics (time, errors, quality)
- Qualitative observations

### Phase 3: Document & Submit (Week 4, 2-4 hours)

**5. Complete Validation Template**

**For community validation:**
- Fill out [validation/templates/community-validation.md](../../validation/templates/community-validation.md)
- Include: Context, factors applied, outcomes, evidence
- Time: 30-60 minutes
- Format: Markdown, YAML, or JSON (see DATA_SCHEMA.md)

**For quantitative study:**
- Fill out [validation/templates/quantitative-study.md](../../validation/templates/quantitative-study.md)
- Include: Hypothesis, methodology, data, analysis, conclusions
- Time: 4-8 hours
- Format: Full research paper structure

**6. Submit Contribution**

**Via Pull Request:**
1. Fork repository
2. Add your validation to `validation/submissions/[your-domain]/`
3. Follow DATA_SCHEMA.md format
4. Submit PR with description
5. Address review feedback

**Via Issue:**
1. Create issue with "Validation Submission" label
2. Paste validation data (or link to file)
3. Specify consent/attribution preferences
4. Engage in discussion

### Contributor Next Steps

**After submitting validation:**

1. **Engage with feedback**
   - Respond to questions about your validation
   - Clarify methodology if needed
   - Discuss findings with community

2. **Continue validating**
   - Try different factors
   - Explore different scenarios
   - Build longitudinal data

3. **Contribute improvements**
   - Suggest factor clarifications
   - Propose new patterns
   - Document anti-patterns
   - Improve documentation

4. **Help others**
   - Review other validations
   - Share domain expertise
   - Mentor new contributors

---

## Solo Developer Path

**Goal:** Pragmatic adoption for personal AI usage with minimal time investment

**Time:** 20-30 minutes to start, then iterate as needed

### Quick Start (10 minutes)

**1. The Problem You're Solving (2 min)**

You're probably experiencing this:
- Week 1: "Wow, AI code looks great!" → Ship it
- Week 2: "Why did this break?" → Manual rollback
- Week 3: "I need to review everything" → Bottleneck
- Week 4: "Slower than writing myself" → Abandon AI

**The solution:** Validation gates, not trust.

**2. Read Just Enough (8 min)**
- Read: [docs/tutorials/first-30-minutes.md](first-30-minutes.md) - Part 1 (Why) and Part 3 (Apply)
- Focus: Solo developer scenario
- Skip: Deep theory (read later if curious)

### The Pragmatic Three (10 minutes)

**3. Implement Three Simple Rules**

**Rule 1: Always Test Before Commit (Factor IV)**
```bash
# AI generated some code for you

# Before: git add . && git commit
# After:  Run tests first!

make test          # or npm test, pytest, go test, etc.
# Only commit if tests pass ✅
```

**Why:** Catch errors locally, not in production. Shift-left validation.

**Rule 2: Use Git Commit Messages as Memory (Factor I)**
```bash
# Before:
git commit -m "fix stuff"

# After:
git commit -m "fix(auth): add JWT validation

Context: Users could bypass auth with malformed tokens
Solution: Added JWT signature validation in middleware
AI-Assisted: Claude Code generated validation logic"
```

**Why:** Future you will thank you. Git becomes searchable memory.

**Rule 3: Stay Under 40% Context Window (Factor II)**
```bash
# If using Claude Code or similar AI tools

# Before: Load everything, context collapse, bad decisions
# After:  Load Just-In-Time, stay focused

# Keep context under 40% (track in UI)
# If approaching 40%, save progress and start fresh session
```

**Why:** Quality degrades above 40% utilization. Stay sharp.

### Iterate From Here (ongoing)

**4. Add More When You Need It**

**You'll naturally discover when you need more factors:**

**Multi-day project?** → Add Factor VI (Session Continuity via Bundles)
- Save progress at end of each session
- Load context efficiently in next session

**Complex workflow?** → Add Factor VII (Intelligent Task Routing)
- Break work into focused subtasks
- Use right AI tool for each task

**High-stakes work?** → Add Factor VIII (Human Gate Reviews)
- Flag critical changes for human review
- Don't blindly trust AI for production code

**Want to improve?** → Add Factor IX (Pattern Extraction)
- Document what works
- Build personal playbook over time

### Solo Developer Next Steps

**After using the pragmatic three for 2-4 weeks:**

1. **Measure your improvement**
   - Fewer rollbacks?
   - Less rework?
   - More confidence?
   - Faster iteration?

2. **Read more factors as needed**
   - Browse [factors/README.md](../../factors/README.md)
   - Pick what solves your pain points
   - Ignore what doesn't apply (for now)

3. **Share what worked**
   - Quick validation: [validation/templates/community-validation.md](../../validation/templates/community-validation.md)
   - 30 minutes to help others
   - No pressure, just patterns

---

## Switching Paths

**Your path isn't fixed.** You can switch or combine paths:

**Solo → Practitioner**
- You've been using the pragmatic three for a while
- Ready to learn the complete framework
- Jump to Practitioner Phase 2 (Foundation Factors)

**Practitioner → Contributor**
- You've applied factors in your work
- Have data on what works
- Jump to Contributor Phase 3 (Document & Submit)

**Practitioner → Researcher**
- You want to understand the theory
- Have questions about evidence
- Jump to Researcher Phase 1 (Foundation)

**Researcher → Contributor**
- You've studied the framework deeply
- Want to validate empirically
- Jump to Contributor Phase 2 (Apply & Validate)

---

## Common Questions

### "Which path should I choose?"

**Ask yourself:**
- Do you need to use AI reliably today? → **Solo Developer** or **Practitioner**
- Do you want to understand the theory deeply? → **Researcher**
- Do you want to validate and improve the framework? → **Contributor**
- Still unsure? → Start with **Solo Developer** (20 min), iterate from there

### "Can I skip factors?"

**Yes.** The framework is modular:
- **Foundation tier** (I, II, III): Start here, apply everywhere
- **Governance tier** (IV, VIII, XI): Add when quality/safety matter
- **Scale tier** (V, VI, VII, IX, X, XII): Add when complexity increases

Start with what solves your immediate pain points.

### "How much time do I need?"

**Minimum viable adoption:**
- Solo Developer path: 20-30 minutes to start
- Apply pragmatic three: Immediate value
- Iterate as needed: Add factors when pain points emerge

**Full framework understanding:**
- Practitioner path: 45-60 minutes to understand, then apply
- Researcher path: 60-90 minutes for deep understanding
- Contributor path: 2-4 weeks for validation

### "What if I'm not a developer?"

**The framework works for any AI usage:**
- **Writers:** AI for content, editing, research
- **Analysts:** AI for data analysis, insights, reports
- **Designers:** AI for wireframes, copy, user research
- **Researchers:** AI for literature review, hypothesis generation
- **Managers:** AI for planning, documentation, communication

**Key insight:** Replace "code" with "output" and principles still apply:
- Test AI content before publishing (validation gates)
- Save context between work sessions (session continuity)
- Track what works in git/notes (knowledge OS)

### "Can I contribute without being an expert?"

**Yes!** Contributions needed:
- **Experience reports:** "I tried Factor IV in my work, here's what happened"
- **Domain adaptation:** "Here's how I adapted this for writing/design/analysis"
- **Anti-patterns:** "This didn't work in my context, here's why"
- **Questions:** "This factor is unclear, can you explain?"

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for details.

---

## Next Steps by Path

### If you chose Researcher
→ Start with [README.md](../../README.md), then [foundations/four-pillars.md](../../foundations/four-pillars.md)

### If you chose Practitioner
→ Start with [docs/tutorials/first-30-minutes.md](first-30-minutes.md), then apply Foundation Factors (I, II, IV)

### If you chose Contributor
→ Start with [validation/DISCLAIMER.md](../../validation/DISCLAIMER.md), pick a template, start validating

### If you chose Solo Developer
→ Start with [docs/tutorials/first-30-minutes.md](first-30-minutes.md) Part 3, implement the pragmatic three

---

**Ready to begin?** Choose your path above and start reading.

**Questions?** Open an issue or see [CONTRIBUTING.md](../../CONTRIBUTING.md)

**Want to contribute?** See [validation/templates/](../../validation/templates/) for how to submit your experience
