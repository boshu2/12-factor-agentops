# Contributing to 12-Factor AgentOps

**The Operational Discipline for Working With AI Agents** -- principles that turn ad-hoc agent usage into a reliable, compounding practice.

---

## Our Focus: AI Agent Operations

We define the operational discipline for working with AI agents -- coding agents, research agents, planning agents, and beyond:

- Claude Code running in terminal/IDE
- AI pair programming sessions
- Multi-agent orchestration workflows
- Any tool-using agent that reads, writes, and executes

**We are NOT:**

- A framework for customer service chatbots
- A platform for RAG-based Q&A systems
- An SDK for multi-modal agents
- A solution for general autonomous production agents

For general autonomous agents, see [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) by Dex Horthy -- we're complementary, not competing.

---

## Philosophy: Operational Discipline

The model is not the problem. The operations are. We apply decades of DevOps and SRE methodology to how people work with AI agents:

| DevOps / SRE Principle | Our Application (v3 Factor) |
|------------------------|-----------------------------|
| Configuration Management | **I. Context Is Everything** -- manage what enters the context window like you manage what enters production |
| Infrastructure as Code | **II. Track Everything in Git** -- prompts, learnings, workflows as versioned artifacts |
| Single Responsibility | **III. One Agent, One Job** -- each agent gets a scoped task and fresh context |
| Design Reviews | **IV. Research Before You Build** -- understand the problem space before generating code |
| Zero-Trust Verification | **V. Validate Externally** -- no agent grades its own work, ever |
| Continuous Delivery | **VI. Lock Progress Forward** -- validated work ratchets and cannot regress |
| Post-Mortems | **VII. Extract Learnings** -- every session produces two outputs: the work and the lessons |
| Observability & Feedback Loops | **VIII. Compound Knowledge** -- the knowledge flywheel that makes sessions smarter over time |
| SLOs & Error Budgets | **IX. Measure What Matters** -- track fitness toward goals, not activity metrics |
| Process Isolation | **X. Isolate Workers** -- each worker gets its own workspace and zero shared mutable state |
| Escalation Hierarchies | **XI. Supervise Hierarchically** -- escalation flows up, never sideways |
| Blameless Post-Mortems | **XII. Harvest Failures as Wisdom** -- failed attempts are data, not waste |

**The core insight:** Better operations make the same model perform dramatically better. Knowledge compounding (Factor VIII) is the differentiator that no amount of model improvement replaces.

```
Ad-hoc:      Prompt agent -> Hope for good output -> Repeat from scratch
Disciplined: Context -> Research -> Implement -> Validate -> Extract -> Compound
```

### The Four-Tier Structure

Contributions map to the tier they strengthen:

| Tier | Factors | Focus |
|------|---------|-------|
| **Foundation (I-III)** | Context, Git, Scoping | Non-negotiable basics, zero tooling required |
| **Workflow (IV-VI)** | Research, Validation, Ratcheting | The discipline that separates hoping from operating |
| **Knowledge (VII-IX)** | Extraction, Compounding, Measurement | Where sessions get measurably smarter over time |
| **Scale (X-XII)** | Isolation, Supervision, Failure Harvesting | Multi-agent orchestration (advanced, optional) |

---

## How to Contribute

### 1. Add Operational Patterns (Highest Value)

The best contributions add new operational patterns that practitioners can apply. Every pattern should answer: **"What operational discipline does this enforce, and how does it make agent sessions more reliable?"**

Patterns can address any tier. Some high-value categories:

- **Context management patterns** (Factor I) -- techniques for loading, pruning, and structuring context windows
- **Workflow discipline patterns** (Factors IV-VI) -- research templates, validation checklists, ratcheting mechanisms
- **Knowledge compounding patterns** (Factor VIII) -- extraction workflows, quality gates, retrieval strategies, decay management
- **Failure harvesting patterns** (Factor XII) -- techniques for capturing and indexing what did not work

**Operational pattern checklist:**

- [ ] Addresses a specific factor or cross-cutting concern
- [ ] Works without tooling (the "Without Tooling" principle)
- [ ] Has clear trigger conditions (when to apply)
- [ ] Produces actionable output (not just "be careful")
- [ ] Includes evidence from real agent sessions

### 2. Add Skills to the Marketplace

Skills are executable implementations of operational patterns. They live in `marketplace/` and can be invoked as slash commands (`/skill-name`).

**To add a new skill:**

```bash
# 1. Create skill directory
mkdir -p marketplace/your-skill-name/.claude-plugin

# 2. Create plugin.json metadata
cat > marketplace/your-skill-name/.claude-plugin/plugin.json << 'EOF'
{
  "name": "your-skill-name",
  "version": "1.0.0",
  "description": "What operational discipline this skill enforces",
  "author": "your-github-username",
  "repository": "https://github.com/boshu2/12-factor-agentops",
  "keywords": ["agentops", "your-tier", "your-category"],
  "skills": ["skill.md"]
}
EOF

# 3. Create skill.md with definition (see template below)
# 4. Submit PR with usage evidence
```

**Skill template (`skill.md`):**

```markdown
---
name: your-skill-name
description: What operational discipline this skill enforces
version: 1.0.0
author: your-username
license: Apache-2.0
context: fork
user-invocable: true
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Your Skill Name

**What operational discipline this enforces**

| Aspect | Details |
|--------|---------|
| **Tier** | Foundation / Workflow / Knowledge / Scale |
| **Factor** | Which factor(s) this implements |
| **Trigger** | When to run (e.g., "before implementation", "end of session") |
| **Output** | What it produces (e.g., "extracted learnings for compounding") |

---

## What It Does

| Step | Action | Evidence Produced |
|------|--------|-------------------|
| **1. Step Name** | What this step does | What it outputs |
| **2. Step Name** | ... | ... |

## Process

Trigger condition met
    |
1. First operational step
    |
2. Second operational step
    |
3. Output actionable result

## Output Format

## Your Skill Report

**Context:** What was examined
**Tier:** Which operational tier
**Score:** X/Y checks passed

### Completed
- Step 1: Evidence
- Step 2: Evidence

### Gaps Found
- Step 3: What operational discipline was missing

### Recommended Actions
1. Immediate action
2. Follow-up improvement

## Usage

/your-skill-name
```

### 3. Report Operational Gaps

Found a class of agent failures that our factors do not address? That is exactly what we need.

**Good issue format:**

```markdown
## Operational Gap

**What I tried:** Describe the agent workflow
**What went wrong:** What operational failure occurred
**Which factor should have prevented it:** Map to the 12 factors
**Suggested discipline:** How to prevent it systematically

## Evidence

- Link to session where this happened
- Example of the failure
- Proposed operational check
```

### 4. Improve Existing Skills and Patterns

Our skills and patterns can always be sharper. Contributions that improve operational outcomes are valuable:

- Add edge cases the skill does not handle
- Improve output actionability
- Reduce false positives in validation skills
- Add clearer remediation guidance
- Strengthen the connection to specific factors

### 5. Share Knowledge Compounding Workflows

Factor VIII (Compound Knowledge) is the hero differentiator. Contributions that demonstrate real knowledge compounding workflows are especially valuable:

- How you structure `learnings.md` files
- Quality gating criteria for extracted knowledge
- Retrieval strategies that improve context relevance
- Decay management approaches for stale learnings
- Evidence of measurable improvement across sessions

### 6. Fix Documentation

Clear docs help everyone operate better:

- Fix unclear explanations
- Add examples of operational discipline in action
- Document failure patterns and how factors prevent them
- Improve factor interconnection explanations
- Ensure all internal links resolve correctly

---

## Contribution Process

### Small Changes (docs, examples)

1. Fork the repository
2. Create a branch: `git checkout -b docs/improve-factor-guide`
3. Make changes
4. Submit PR with clear description

### New Skills or Patterns

1. Fork the repository
2. Create skill in `marketplace/your-skill/` or pattern doc in appropriate location
3. Include:
   - `.claude-plugin/plugin.json` (metadata, for skills)
   - `skill.md` (skill definition, for skills)
   - Evidence from real agent sessions
4. Submit PR with usage evidence

**PR requirements for new skills:**

- [ ] Skill maps to one or more of the 12 factors
- [ ] Works without tooling (manual fallback documented)
- [ ] Trigger conditions are explicit
- [ ] Output is actionable (tells you what to do)
- [ ] Works within a single coding session
- [ ] Includes example of operational improvement it provides

### Framework Changes

Discussion first:

1. Open an issue describing the operational gap
2. Explain what the current factors do not address
3. Propose how the framework should evolve
4. Discuss approach with maintainers
5. Implement if approved

---

## What Makes a Good Contribution

| Quality | Good | Bad |
|---------|------|-----|
| **Actionable** | "Add this check before commit to enforce Factor V" | "Agents could be better" |
| **Grounded** | Maps to specific factor(s) and tier | Generic agent advice |
| **Evidence-based** | Shows real session improvement | Theoretical claims |
| **Portable** | Works without specific tooling | Requires proprietary setup |
| **Specific** | Clear trigger, clear output, clear remediation | Vague suggestions |

---

## Code of Conduct

- **Discipline over blame** -- We build operational discipline, not judgment systems
- **Assume good intent** -- AI-generated output needs operational guardrails, not criticism
- **Share what you learn** -- Every operational insight helps the entire community compound knowledge
- **Be specific** -- Vague feedback does not help anyone operate better
- **Without Tooling first** -- Every contribution should work manually before automating

---

## Questions?

- **How to apply a factor?** Open a discussion
- **Found an operational gap?** Open an issue
- **Want to add a skill?** Start with the template above
- **Not sure which tier it fits?** Ask -- we will help you map it

---

## Recognition

Contributors are recognized in:

- Git commit history (preserved forever)
- Release notes (for new skills and patterns)
- [Marketplace](./marketplace/) listing (skill authorship)

**Your work helps build the operational discipline for an entire field.**

---

**Welcome to 12-Factor AgentOps. The model is not the problem. The operations are.**
