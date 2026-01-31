# Contributing to 12-Factor AgentOps

**DevOps for Vibe-Coding** — Shift-left validation for coding agents.

---

## Our Focus: Coding Agents

We focus specifically on **coding agents** — AI assistants that write, modify, and review code:

- Claude Code running in terminal/IDE
- AI pair programming sessions
- Code generation with validation workflows
- Agents using Read, Edit, Write, Bash for development

**We are NOT:**

- A framework for customer service chatbots
- A platform for RAG-based Q&A systems
- An SDK for multi-modal agents
- A solution for general autonomous production agents

For general autonomous agents, see [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) by Dex Horthy — we're complementary, not competing.

---

## Philosophy: Validation First

We apply DevOps principles to coding agents:

| DevOps Principle | Our Application |
|------------------|-----------------|
| Shift-Left Testing | `/pre-mortem` before implementation |
| Continuous Integration | `/vibe` checks before every commit |
| Post-Mortems | `/retro` to extract and compound learnings |
| Observability | Knowledge flywheel tracks what works |
| Infrastructure as Code | Prompts and workflows as versioned artifacts |

**The core insight:** Validation happens BEFORE code ships, not after.

```
Traditional:  Write code → Ship → CI catches problems → Fix → Repeat
Shift-Left:   /pre-mortem → Implement → /vibe → Commit → Knowledge compounds
```

---

## How to Contribute

### 1. Add Validation Skills (Highest Value)

The best contributions add new validation patterns. Every skill should answer: **"What could go wrong, and how do we catch it early?"**

**Validation skill checklist:**

- [ ] Catches problems before they compound
- [ ] Has clear trigger conditions (when to run)
- [ ] Produces actionable output (not just "looks good")
- [ ] Works within a coding session (single-session scope)
- [ ] Can be invoked as a skill (`/skill-name`)

**To add a new validation skill:**

```bash
# 1. Create skill directory
mkdir -p marketplace/your-skill-name/.claude-plugin

# 2. Create plugin.json metadata
cat > marketplace/your-skill-name/.claude-plugin/plugin.json << 'EOF'
{
  "name": "your-skill-name",
  "version": "1.0.0",
  "description": "What this skill validates",
  "author": "your-github-username",
  "repository": "https://github.com/boshu2/12-factor-agentops",
  "keywords": ["validation", "agentops", "your-category"],
  "skills": ["skill.md"]
}
EOF

# 3. Create skill.md with definition (see template below)
# 4. Submit PR with validation evidence
```

**Skill template (`skill.md`):**

```markdown
---
name: your-skill-name
description: What this skill validates
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

**What this skill validates**

| Aspect | Details |
|--------|---------|
| **Type** | Validation Skill |
| **Trigger** | When to run (e.g., "before commit", "after implementation") |
| **Output** | What it produces (e.g., "compliance report with gaps") |

---

## What It Checks

| Check | Question | Evidence Required |
|-------|----------|-------------------|
| **1. Check Name** | What question does this answer? | What proves it passed? |
| **2. Check Name** | ... | ... |

## Validation Process

```
Trigger condition met
    ↓
1. First validation step
    ↓
2. Second validation step
    ↓
3. Output actionable report
```

## Output Format

```markdown
## Your Skill Audit

**Context:** What was checked
**Score:** X/Y checks passed

### Passed
- Check 1: Evidence
- Check 2: Evidence

### Failed
- Check 3: What went wrong

### Required Actions
1. Fix this before proceeding
2. Consider this improvement
```

## Usage

```
/your-skill-name
```
```

### 2. Report Validation Gaps

Found a class of errors that our skills don't catch? That's exactly what we need.

**Good issue format:**

```markdown
## Validation Gap

**What I tried:** Describe the situation
**What went wrong:** What error occurred
**When it should have been caught:** Which validation point
**Suggested check:** How to catch it early

## Evidence

- Link to session where this happened
- Example of the error
- Proposed validation criteria
```

### 3. Improve Existing Skills

Our skills can always be sharper. Contributions that improve catch rates are valuable:

- Add edge cases we're missing
- Improve output actionability
- Reduce false positives
- Add clearer remediation guidance

### 4. Share Patterns

Discovered a validation pattern that works in your domain? Document it:

- What problem it solves
- Why it works
- How to apply it
- Evidence it catches real issues

### 5. Fix Documentation

Clear docs help everyone validate better:

- Fix unclear explanations
- Add examples of validation in action
- Document failure patterns you've seen
- Improve skill trigger guidance

---

## Contribution Process

### Small Changes (docs, examples)

1. Fork the repository
2. Create a branch: `git checkout -b docs/improve-validation-guide`
3. Make changes
4. Submit PR with clear description

### New Validation Skills

1. Fork the repository
2. Create skill in `marketplace/your-skill/`
3. Include:
   - `.claude-plugin/plugin.json` (metadata)
   - `skill.md` (skill definition)
   - Evidence that it catches real issues
4. Submit PR with validation evidence

**PR requirements for new skills:**

- [ ] Skill has clear validation purpose (not just "information")
- [ ] Trigger conditions are explicit
- [ ] Output is actionable (tells you what to fix)
- [ ] Works within single coding session
- [ ] Includes example of what it catches

### Framework Changes

Discussion first:

1. Open an issue describing the validation gap
2. Explain what errors we're not catching
3. Propose how to catch them
4. Discuss approach with maintainers
5. Implement if approved

---

## What Makes a Good Validation Skill

| Quality | Good | Bad |
|---------|------|-----|
| **Actionable** | "Fix line 42: missing null check" | "Code could be improved" |
| **Timely** | Catches it before commit | Catches it in production |
| **Specific** | Clear what to fix | Vague suggestions |
| **Evidence-based** | Shows the problem | Asserts without proof |
| **Automatable** | Can run as skill | Requires manual analysis |

---

## Code of Conduct

- **Validation over blame** — We catch errors, we don't judge developers
- **Assume good intent** — AI-generated code needs validation, not criticism
- **Share what you learn** — Every caught error is a lesson for everyone
- **Be specific** — Vague feedback doesn't help anyone validate better

---

## Questions?

- **How to validate something?** Open a discussion
- **Found an uncaught error class?** Open an issue
- **Want to add a skill?** Start with the template above
- **Not sure if it fits?** Ask — we'll help you figure it out

---

## Recognition

Contributors are recognized in:

- Git commit history (preserved forever)
- Release notes (for new validation skills)
- Marketplace listing (skill authorship)

**Your work helps catch errors before they ship.**

---

**Welcome to 12-Factor AgentOps. Let's shift validation left — together.**
