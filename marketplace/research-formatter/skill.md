# Research Formatter

**Format research findings into structured, reusable documentation**

| Aspect | Details |
|--------|---------|
| **Type** | Documentation Skill |
| **Trigger** | End of Research phase |
| **Output** | Structured research document |

---

## Summary

Research without documentation is wasted effort. This skill formats your findings into a structure that future agents (and humans) can use.

## Research Document Template

```markdown
# Research: [Topic]

**Question:** What are we trying to learn?

| Aspect | Details |
|--------|---------|
| **Date** | YYYY-MM-DD |
| **Duration** | X hours |
| **Confidence** | Low / Medium / High |

---

## Problem Statement

What problem are we researching? Why does it matter?

## Approaches Considered

### Option A: [Name]

**Description:** Brief explanation

**Pros:**
- Pro 1
- Pro 2

**Cons:**
- Con 1
- Con 2

**Evidence:** Where was this validated?

### Option B: [Name]

[Same structure]

### Option C: [Name]

[Same structure]

## Recommendation

**Chosen approach:** Option [X]

**Rationale:** Why this approach over others

**Confidence:** [Low/Medium/High] because [reason]

## Open Questions

- Question 1 (blocks: nothing / implementation / decision)
- Question 2

## Sources

- [Source 1](url)
- [Source 2](url)

## Next Steps

1. [Action 1]
2. [Action 2]
```

## Formatting Guidelines

### Approaches Section

| Element | Requirement |
|---------|-------------|
| **Minimum options** | 2 (prevents tunnel vision) |
| **Maximum options** | 4 (prevents analysis paralysis) |
| **Pros/Cons** | At least 2 each |
| **Evidence** | Required for recommended option |

### Confidence Levels

| Level | Meaning | Action |
|-------|---------|--------|
| **High** | Strong evidence, validated | Proceed to plan |
| **Medium** | Good evidence, some gaps | Proceed with checkpoints |
| **Low** | Limited evidence | More research or prototype |

### Open Questions

Classify each question by what it blocks:

- **Blocks nothing:** Nice to know, don't delay for it
- **Blocks implementation:** Must answer before coding
- **Blocks decision:** Must answer before choosing approach

## Example

```markdown
# Research: Session State Persistence

**Question:** How should we persist state between AI agent sessions?

| Aspect | Details |
|--------|---------|
| **Date** | 2025-01-27 |
| **Duration** | 2 hours |
| **Confidence** | High |

## Approaches Considered

### Option A: File-based JSON

**Pros:** Simple, no dependencies, human-readable
**Cons:** No concurrent access, limited query capability
**Evidence:** Used in Claude Code, scales to 100+ sessions

### Option B: SQLite

**Pros:** SQL queries, ACID, single file
**Cons:** Schema management, overkill for simple state
**Evidence:** Common in desktop apps

### Option C: Redis

**Pros:** Fast, built-in expiry, pub/sub
**Cons:** External dependency, operational overhead
**Evidence:** Good for distributed systems

## Recommendation

**Chosen:** Option A (File-based JSON)

**Rationale:** Simplest solution that works. JSON files are human-readable for debugging, require no dependencies, and scale well for single-user agent workflows. Redis would be appropriate for multi-agent distributed systems.

**Confidence:** High - validated in production Claude Code workflows
```

## Usage

After completing research:

```
/format-research
```

From raw notes:

```
/format-research "Compared file, SQLite, Redis for state. File wins for simplicity."
```

---

**Remember:** Research is only valuable if it's findable. Format for future you.
