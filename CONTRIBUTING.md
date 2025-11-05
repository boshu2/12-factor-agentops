# Contributing to 12-Factor AgentOps

Thank you for being here. This is early-stage exploration, and we need diverse perspectives to figure out what generalizes.

---

## What We're Looking For

**Real production patterns.** Not theory, not slides, not what you think might work.

Contributions should answer:
- **Have you tried this?** In production? With real workloads?
- **What happened?** Did it work? Did it fail? Why?
- **In what context?** Your domain, constraints, scale matter

That's it. We want your honest experience.

---

## Types of Contributions We Accept

### ✅ Patterns (Success)
- "Here's what worked in healthcare IT when operating AI agents"
- "Three lessons from running 50 agent workflows in manufacturing"
- Document: context, what you tried, what happened, why

### ✅ Failures (Even Better)
- "We tried this, it broke spectacularly, here's why"
- "This pattern works in federal infrastructure but falls apart at scale X"
- "This failed because of constraint Y in our domain"

### ✅ Adaptations
- "The core pattern is solid, here's how we modified it for our constraints"
- "Works in Kubernetes, here's the Docker Swarm version"
- "Same principle, different implementation for compliance reasons"

### ✅ Challenges
- "I don't think this generalizes, here's a counterexample"
- "This works but is overly complex—simpler approach: ..."
- "This assumes X, but in reality Y"

### ❌ We Don't Accept
- Pure theory without production testing
- "Best practices" not grounded in real failures/wins
- Proprietary company information
- Polished marketing (this is a learning space, not a sales deck)
- Untested hypotheses

---

## The Five Laws (Governance Model)

All contributions should follow the Five Laws of AgentOps:

1. **ALWAYS Extract Learnings** - Document patterns discovered, capture decision rationale, analyze failures for prevention
2. **ALWAYS Improve Self or System** - Identify at least 1 improvement opportunity, specify impact, propose implementation
3. **ALWAYS Document Context for Future** - Why this work was needed, what was done, reusable insights, quantified impact
4. **ALWAYS Validate Before Execute** - Preview changes, test in safe environments, validate configuration, human review at critical points
5. **ALWAYS Share Patterns Publicly** - Extract generalizable insights, document what worked AND what didn't, help others avoid your mistakes

See [CLAUDE.md](CLAUDE.md) for full details on the governance framework.

---

## How to Contribute

### Option 1: Open an Issue
**Quickest way to start a conversation.**

```
Title: [Pattern] Operating agents in healthcare compliance

Description:
- Context: Healthcare IT, 50+ federal compliance rules
- Pattern: How we validate agent actions pre-execution
- Outcome: 99.7% compliance, no regulatory violations
- Why share: Works in constrained environments, might generalize
```

### Option 2: Submit a Pattern (Pull Request)

**Follow the pattern template:**

```markdown
## Pattern: [Name]

**Your Context**
- Domain: (healthcare, finance, manufacturing, etc.)
- Scale: (# of agents, # of workloads, infrastructure size)
- Constraints: (What made this hard?)

**The Problem**
What operational challenge did you face with AI agents?

**What You Tried**
The pattern you applied. Code examples OK, not required.

**What Happened**
Did it work? How well? Metrics? Failures?

**Lessons**
- What would you do differently?
- What surprised you?
- What didn't transfer from infrastructure to agents?

**Generalizability**
- Does this work outside your domain?
- What constraints matter?
- What would break this?

**Laws Compliance**
- Law 1 (Learning): [Pattern extracted]
- Law 2 (Improvement): [How this improves operations]
- Law 3 (Context): [Why this matters]
- Law 4 (Validation): [How you tested this]
- Law 5 (Sharing): [Insights for others]

**Questions for Community**
What do you want to learn from others?
```

---

## Review Criteria

We accept contributions that are:

1. **Real** ✓
   - Tested in production (not a pilot, not a demo)
   - Real constraints and tradeoffs
   - Honest about failures

2. **Specific** ✓
   - Clear context (domain, scale, constraints)
   - Concrete details (not generic advice)
   - Shows your thinking, not just conclusions

3. **Generalizable** ✓
   - Might work beyond your domain
   - Clear about what's universal vs domain-specific
   - Helps others figure out adaptations

4. **Not gatekept** ✓
   - Doesn't require proprietary knowledge
   - No company confidential info
   - Sanitized examples if needed (rename companies, change numbers)

---

## What Gets Rejected

- "Here's what the internet says about best practices"
- "This is my opinion on how agents should work"
- "We're going to try this pattern" (come back with results)
- "This is a better version of the framework" (we decide on structure)
- Proprietary/confidential information

---

## The Bar Is Low for Early Stage

This is **alpha exploration**, not production documentation.

- ✅ Half-baked patterns welcome if you're honest about it
- ✅ Contradictions are great (helps us understand edge cases)
- ✅ Failures teach us more than successes
- ✅ "I don't know if this generalizes" is valid

What we need: **Your honest experience, not polish.**

---

## Licensing

By contributing, you agree your work is licensed under:
- **Code**: Apache 2.0
- **Patterns/Documentation**: CC BY-SA 4.0

You retain attribution. Your name stays on your contribution.

---

## Code of Conduct

We follow one simple rule: **no gatekeeping. No ego. Just learning.**

- Respectfully challenge assumptions
- Share failures as openly as successes
- Help others adapt your patterns
- Ask questions without fear

---

## Questions?

Open an issue. Describe what you're thinking about. We'll figure it out together.

**This is an experiment. Your participation shapes what it becomes.**
