---
name: diataxis-organizer
description: Organize documentation using the Diátaxis framework (Tutorials, How-to Guides, Reference, Explanation). Use when creating or reorganizing documentation to ensure proper structure and discoverability.
---

# Diátaxis Documentation Organizer

Organize documentation using the Diátaxis framework to maximize clarity and usability for different reader needs.

## Purpose

This skill applies the Diátaxis framework to documentation, ensuring content is properly categorized and structured for its intended purpose. Diátaxis recognizes four distinct documentation types, each serving different reader needs.

## When to Use This Skill

Use this skill when:
- **Creating new documentation** - Determine proper type/structure
- **Reorganizing existing docs** - Fix mismatched content/format
- **Planning documentation strategy** - Design doc structure
- **Auditing documentation** - Ensure Diátaxis compliance
- **Improving discoverability** - Help readers find what they need

## The Four Diátaxis Types

### 1. Tutorials (Learning-Oriented)

**Purpose**: Guide a beginner through their first experience
**Audience**: Complete newcomers to the framework
**Format**: Step-by-step lesson with guaranteed success

**Characteristics:**
- Learning by doing
- Guaranteed to work
- Beginner-friendly
- Hands-on practice
- Minimal explanation (just enough)

**Example**: "Your First 12-Factor Agent"

**Structure:**
```markdown
# Tutorial: [Title]

## What You'll Learn
[Specific outcomes]

## Prerequisites
[What they need first]

## Step 1: [Action]
[Do this exact thing]
[Expected result]

## Step 2: [Action]
[Do this next]
[Expected result]

...

## What You Accomplished
[Summary of learning]

## Next Steps
[Where to go from here]
```

---

### 2. How-To Guides (Problem-Oriented)

**Purpose**: Solve a specific practical problem
**Audience**: Practitioners with some experience
**Format**: Recipe/checklist for accomplishing a goal

**Characteristics:**
- Goal-focused
- Assumes some knowledge
- Practical steps
- Multiple paths OK
- "Do X to achieve Y"

**Example**: "How to Extract a Pattern from Production"

**Structure:**
```markdown
# How-To: [Goal]

## Overview
[What this guide helps you achieve]

## Prerequisites
[What you need to know/have]

## Steps

### 1. [First step]
[Instructions]

### 2. [Second step]
[Instructions]

...

## Troubleshooting
[Common issues and solutions]

## Variations
[Alternative approaches]
```

---

### 3. Reference (Information-Oriented)

**Purpose**: Provide authoritative, accurate information
**Audience**: Anyone needing to look something up
**Format**: Structured, searchable, comprehensive

**Characteristics:**
- Dry and factual
- Comprehensive
- Structured consistently
- Easy to scan
- No opinions/advice

**Example**: "12-Factor Compliance Checklist"

**Structure:**
```markdown
# Reference: [Topic]

## Overview
[Brief description]

## [Category 1]

### [Item 1.1]
**Description**: [What it is]
**Required**: [Yes/No]
**Format**: [Structure]
**Example**: [Concrete example]

### [Item 1.2]
...

## [Category 2]
...
```

---

### 4. Explanation (Understanding-Oriented)

**Purpose**: Deepen understanding of a concept
**Audience**: Those seeking "why" and context
**Format**: Discussion, exploration, reasoning

**Characteristics:**
- Theory and background
- "Why" not "how"
- Multiple perspectives
- Historical context
- Deeper understanding

**Example**: "Why the 40% Rule Works"

**Structure:**
```markdown
# Explanation: [Concept]

## Introduction
[What we're exploring]

## The Problem
[What challenge does this address?]

## Historical Context
[How did this emerge?]

## Theoretical Foundation
[Academic/research grounding]

## Why This Matters
[Practical implications]

## Related Concepts
[Connections to other ideas]
```

---

## Decision Tree: Which Type?

```
Is the reader brand new to this topic?
├─ YES → Tutorial
└─ NO ↓

Does the reader have a specific problem to solve?
├─ YES → How-To Guide
└─ NO ↓

Does the reader need to look up factual information?
├─ YES → Reference
└─ NO ↓

Does the reader want to understand "why"?
└─ YES → Explanation
```

## Organizing Workflow

### Step 1: Identify Current Content Type

**Ask:**
- What is this documentation trying to do?
- Who is the intended audience?
- What questions does it answer?

### Step 2: Match to Diátaxis Type

Use decision tree above to determine proper type.

**Common mismatches:**
- Tutorial that explains too much → Split into Tutorial + Explanation
- How-To that's too reference-y → Split into How-To + Reference
- Reference with opinions → Move opinions to Explanation
- Explanation that's too prescriptive → Move steps to How-To

### Step 3: Restructure Content

Use appropriate template from `assets/` for chosen type.

**Restructuring principles:**
- One doc = one type (don't mix)
- Link between related docs of different types
- Keep tutorials short and guaranteed to work
- Make reference scannable

### Step 4: Organize Directory Structure

```
docs/
├── tutorials/          # Learning-oriented
│   ├── first-agent.md
│   └── your-first-pattern.md
├── how-to/             # Problem-oriented
│   ├── extract-pattern.md
│   └── validate-factor.md
├── reference/          # Information-oriented
│   ├── factors-checklist.md
│   └── laws-reference.md
└── explanation/        # Understanding-oriented
    ├── why-40-percent-rule.md
    └── four-pillars.md
```

### Step 5: Cross-Reference

Link related content across types:

**Example in Tutorial:**
> For deeper understanding of why this works, see [Explanation: 40% Rule](../explanation/why-40-percent-rule.md)

**Example in How-To:**
> For complete reference, see [Laws Checklist](../reference/laws-reference.md)

## Common Documentation Problems

### Problem: Tutorial Too Long
**Symptom**: 30+ steps, lots of explanation
**Solution**: Split into Tutorial (15 steps max) + Explanation (why it works)

### Problem: How-To Too Theoretical
**Symptom**: More "why" than "how"
**Solution**: Move theory to Explanation, keep only practical steps

### Problem: Reference Too Conversational
**Symptom**: Opinions, advice, storytelling
**Solution**: Extract opinions to Explanation, keep facts in Reference

### Problem: Explanation Too Prescriptive
**Symptom**: Step-by-step instructions in conceptual doc
**Solution**: Move steps to How-To, keep concepts in Explanation

## Audit Checklist

### For Tutorials
- [ ] Can a complete beginner follow this?
- [ ] Is success guaranteed if followed exactly?
- [ ] Are explanations minimal (just enough)?
- [ ] Is it hands-on and practical?
- [ ] Does it take <30 minutes?

### For How-To Guides
- [ ] Does it solve a specific problem?
- [ ] Are prerequisites clearly stated?
- [ ] Are steps actionable?
- [ ] Does it assume some knowledge?
- [ ] Are troubleshooting tips included?

### For Reference
- [ ] Is it comprehensive?
- [ ] Is it structured consistently?
- [ ] Is it scannable?
- [ ] Are facts separated from opinions?
- [ ] Is it easy to find specific information?

### For Explanations
- [ ] Does it explain "why" not "how"?
- [ ] Is theoretical grounding provided?
- [ ] Does it deepen understanding?
- [ ] Are multiple perspectives considered?
- [ ] Does it avoid being prescriptive?

## Resources

### assets/tutorial-template.md
Template for learning-oriented tutorials.

### assets/how-to-template.md
Template for problem-oriented guides.

### assets/reference-template.md
Template for information-oriented reference docs.

### assets/explanation-template.md
Template for understanding-oriented explanations.

### references/diataxis-guide.md
Complete guide to Diátaxis framework with examples and decision trees.

---

**Remember**: The right structure makes documentation 10x more valuable. Match content to reader needs.
