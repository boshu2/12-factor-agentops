# AgentOps Framework - Contributing Patterns & Research

**Apply DevOps + SRE principles to AI agent operations.**

This repository documents the **philosophical framework** for AgentOps: patterns, research, and principles.

**For working tools and implementation** → See [agentops](https://github.com/boshu2/agentops)

---

## What is This Repository?

**12-factor-agentops** is the **framework repository**:
- Philosophical foundations (Four Pillars, Five Laws)
- Operational patterns (validated templates)
- Research and case studies
- Theoretical grounding and rationale

**This repository does NOT contain:**
- Working agents or commands → [agentops](https://github.com/boshu2/agentops)
- How-to guides or tutorials → [agentops/docs/how-to](https://github.com/boshu2/agentops/tree/main/docs/how-to)
- Implementation tools → [agentops/profiles](https://github.com/boshu2/agentops/tree/main/profiles)

---

## The Four Pillars

### 1. DevOps + SRE

Apply proven practices you already know:
- Version control (Git as source of truth)
- Validation gates (test before deploy)
- Observability (metrics, logs, traces)
- Reliability engineering (SLOs, error budgets)

**Read:** [Four Pillars Documentation](./foundations/four-pillars.md#pillar-1-devops--sre)

---

### 2. Learning Science

How humans and systems learn effectively:
- Research → Plan → Implement (not code-first)
- Pattern recognition (extract reusable insights)
- Failure analysis (learn from what breaks)
- Progressive complexity (start simple, build up)

**Read:** [Four Pillars Documentation](./foundations/four-pillars.md#pillar-2-learning-science)

---

### 3. Context Engineering

Manage cognitive load and information flow:
- Just-in-time loading (load what you need, when needed)
- Progressive disclosure (reveal complexity gradually)
- Context preservation (document for future you/agents)
- 40% rule (stay under capacity to avoid collapse)

**Read:** [Context Engineering Foundation](./foundations/context-engineering.md)

---

### 4. Knowledge OS

Git as operating system for institutional memory:
- Commits = memory writes (immutable, traceable)
- Branches = process isolation (parallel work)
- History = audit trail (every decision captured)
- Patterns compound over time (build on learnings)

**Read:** [Knowledge OS Foundation](./foundations/knowledge-os.md)

---

## The Five Laws of AgentOps

**ALL work (framework and implementation) follows these laws:**

### Law 1: ALWAYS Extract Learnings

- Document patterns discovered
- Capture decision rationale
- Analyze failures for prevention

**Why:** Patterns are valuable. One-time solutions are not.

**Read:** [Five Laws Documentation](./foundations/five-laws.md#law-1-always-extract-learnings)

---

### Law 2: ALWAYS Improve Self or System

- Identify at least 1 improvement opportunity
- Specify impact (time saved, quality improved)
- Propose implementation (effort, priority)

**Why:** Stagnation is regression. Continuous improvement is mandatory.

**Read:** [Five Laws Documentation](./foundations/five-laws.md#law-2-always-improve-self-or-system)

---

### Law 3: ALWAYS Document Context for Future

- **Context:** Why this work was needed
- **Solution:** What was done and how
- **Learning:** Reusable insights
- **Impact:** Quantified value

**Why:** Future you (or future contributors) will thank you.

**Read:** [Five Laws Documentation](./foundations/five-laws.md#law-3-always-document-context-for-future)

---

### Law 4: ALWAYS Validate Before Execute

- Preview changes (diff-first thinking)
- Test in safe environments first
- Validate configuration before applying
- Human review at critical points

**Why:** Prevention is cheaper than recovery.

**Read:** [Five Laws Documentation](./foundations/five-laws.md#law-4-always-validate-before-execute)

---

### Law 5: ALWAYS Share Patterns Publicly

- Extract generalizable insights from proprietary work
- Document what worked AND what didn't
- Help others avoid your mistakes
- Build collective knowledge

**Why:** Rising tide lifts all boats.

**Read:** [Five Laws Documentation](./foundations/five-laws.md#law-5-always-share-patterns-publicly)

---

## Repository Structure

```
12-factor-agentops/                    # Framework (this repo)
├── README.md                          # Framework overview
├── CLAUDE.md                          # This file - contribution guide
├── CONTRIBUTING.md                    # Detailed contribution process
├── LICENSE                            # Apache 2.0 + CC BY-SA 4.0
│
├── foundations/                       # Explanation (WHY)
│   ├── README.md                      # Foundations overview
│   ├── four-pillars.md                # Philosophical foundation
│   ├── five-laws.md                   # Operational principles
│   ├── context-engineering.md         # 40% rule, JIT loading
│   └── knowledge-os.md                # Git as institutional memory
│
├── patterns/                          # Reference (reusable templates)
│   ├── README.md                      # Pattern catalog
│   ├── phase-based-workflow.md        # Research → Plan → Implement
│   ├── multi-agent-orchestration.md   # Parallel execution
│   ├── intelligent-routing.md         # Workflow selection
│   └── context-bundles.md             # Session continuity
│
├── product/                           # Product planning
│   ├── mission.md                     # Framework mission
│   ├── roadmap.md                     # Development roadmap
│   └── tech-stack.md                  # Technology choices
│
└── docs/                              # Supporting documentation
    └── cross-reference-template.md    # Linking framework ↔ implementation
```

**For implementation structure** → See [agentops README](https://github.com/boshu2/agentops#readme)

---

## Contributing to This Repository

### What to Contribute Here

✅ **Contribute to 12-factor-agentops if you want to:**
- Propose new operational patterns
- Share research or case studies
- Contribute to theoretical foundations
- Improve framework documentation
- Refine existing patterns based on validation

❌ **Don't contribute here if you want to:**
- Create new agents or commands → [agentops/CONTRIBUTING.md](https://github.com/boshu2/agentops/blob/main/CONTRIBUTING.md)
- Write how-to guides or tutorials → [agentops/docs/how-to](https://github.com/boshu2/agentops/tree/main/docs/how-to)
- Report tool bugs → [agentops issues](https://github.com/boshu2/agentops/issues)
- Submit implementation code → [agentops](https://github.com/boshu2/agentops)

---

### Contributing Patterns

**We're looking for:**
- Real production patterns (not theoretical)
- Context-specific adaptations (your domain)
- Failure modes documented (what doesn't work)
- Generalizable insights (transfers across contexts)
- Laws-compliant contributions (follow the 5 laws)

**Pattern contribution template:**

```markdown
## Pattern: [Name]

**Context:** [Your domain/use case]
**Problem:** [What operational challenge did you face?]
**Solution:** [What pattern did you apply?]
**Outcome:** [Did it work? What changed?]
**Lessons:** [What would you do differently?]
**Generalizability:** [Does this transfer to other domains?]

**Laws Compliance:**
- Law 1 (Learning): [Pattern extracted]
- Law 2 (Improvement): [How this improves operations]
- Law 3 (Context): [Why this matters]
- Law 4 (Validation): [How you tested this]
- Law 5 (Sharing): [Insights for others]

**Grounding in Four Pillars:**
- Which pillar(s) support this pattern?
- Why does this pattern work (theoretical basis)?
- What evidence validates effectiveness?
```

**Process:**
1. Open an issue describing the pattern
2. Get feedback on generalizability
3. Submit PR with pattern documentation
4. Address review feedback
5. Pattern merges when validated

**Full guidelines:** [CONTRIBUTING.md](./CONTRIBUTING.md)

---

### Contributing Research

**We welcome:**
- Empirical studies on pattern effectiveness
- Validation of patterns in new domains
- Theoretical grounding for existing patterns
- Case studies with quantified results
- Failure analysis and lessons learned

**Research contribution template:**

```markdown
## Research: [Topic]

**Hypothesis:** [What were you testing?]
**Method:** [How did you test it?]
**Results:** [What did you find?]
**Analysis:** [What does it mean?]
**Implications:** [How should this change the framework?]

**Connections:**
- Related patterns: [Which patterns does this validate/challenge?]
- Related foundations: [Which pillars does this support/question?]
```

---

### Contributing Case Studies

**We're looking for:**
- Production validation of patterns
- Quantified impact (time saved, errors reduced, etc.)
- Domain-specific adaptations
- Failure modes and recovery strategies

**Case study template:**

```markdown
## Case Study: [Title]

**Context:**
- Domain: [Your industry/context]
- Scale: [How many agents, workflows, users?]
- Duration: [How long tested?]

**Pattern(s) Applied:**
- [Which patterns from the catalog?]
- [Any adaptations for your domain?]

**Results:**
- Metric 1: [Quantified impact]
- Metric 2: [Quantified impact]
- Qualitative: [What changed?]

**Lessons Learned:**
- What worked well
- What didn't work
- What you'd do differently
- What generalizes vs. context-specific

**Validation:**
- How did you measure impact?
- What's your confidence in generalization?
```

---

## The Intersection Perspective

**This framework comes from operating at a unique intersection:**

1. **Building infrastructure FOR AI**
   - GPU/HPC platforms for ML workloads
   - High-performance, multi-tenant systems
   - Federal/compliance-hardened environments

2. **Using AI FOR infrastructure**
   - AI agents automating GitOps
   - LLMs for runbook generation
   - Intelligent policy validation

3. **Operating both at production scale**
   - Mission-critical systems
   - High-stakes reliability requirements
   - Real operational constraints

**If you're at a similar intersection, your contributions are especially valuable.**

**If you're in a different domain, your validation is critical** — help us understand what generalizes and what doesn't.

---

## Code of Conduct

- Be respectful and collaborative
- Share failures as openly as successes
- Focus on production learnings, validated patterns
- Follow the Five Laws in all contributions
- Help make operational patterns accessible to all

**No gatekeeping. No guru worship. Just rigorous operational discipline.**

---

## Quick Start for Contributors

### For Pattern Contributors

1. **Read the foundations** (understand philosophical basis)
   - [Four Pillars](./foundations/four-pillars.md) — 15 minutes
   - [Five Laws](./foundations/five-laws.md) — 20 minutes

2. **Study existing patterns** (understand format and quality bar)
   - [Pattern Catalog](./patterns/) — Browse examples
   - Note structure: Problem → Solution → Why It Works → Empirical Evidence

3. **Try patterns in your context** (validate generalization)
   - Pick 1-2 patterns relevant to your work
   - Apply them in production
   - Document results (what worked, what didn't)

4. **Propose your pattern** (share your learnings)
   - Open issue with pattern template
   - Get feedback on generalizability
   - Submit PR with documentation
   - Address review feedback

---

### For Researchers

1. **Identify research question** (what needs validation?)
   - Which patterns lack empirical evidence?
   - Which domains haven't been tested?
   - Which foundations need deeper grounding?

2. **Design study** (how will you test it?)
   - What metrics will you measure?
   - What's your sample size/duration?
   - How will you control variables?

3. **Conduct research** (validate in production)
   - Apply patterns systematically
   - Collect data rigorously
   - Document methodology

4. **Share findings** (contribute back)
   - Open issue or PR with research template
   - Include data, analysis, implications
   - Link to relevant patterns/foundations

---

## Questions or Ideas?

- **Have a pattern idea?** Open an issue for discussion
- **Found a bug in documentation?** Submit a PR
- **Want to validate a pattern?** Comment on existing patterns
- **Challenge an assumption?** Open an issue with your reasoning

**All feedback welcome. Early-stage framework needs diverse perspectives.**

---

## Resources

### In This Repository

- **Foundations:** [./foundations/](./foundations/) — Philosophical grounding
- **Patterns:** [./patterns/](./patterns/) — Operational templates
- **Product:** [./product/](./product/) — Framework vision and roadmap

### In agentops Repository

- **Implementation:** [agentops](https://github.com/boshu2/agentops) — Working tools
- **How-To Guides:** [agentops/docs/how-to](https://github.com/boshu2/agentops/tree/main/docs/how-to)
- **Tutorials:** [agentops/docs/tutorials](https://github.com/boshu2/agentops/tree/main/docs/tutorials)

### Related Frameworks

- [12-Factor Apps](https://12factor.net) — SaaS operational discipline
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) — LLM reliability
- [DevOps Handbook](https://itrevolution.com/product/the-devops-handbook-second-edition/) — DevOps principles

---

**Let's make AI agents as reliable as the infrastructure they run on.**

*Framework status: Alpha — patterns proven in production, validating generalization*

**This is the framework repository. For implementation → [agentops](https://github.com/boshu2/agentops)**
