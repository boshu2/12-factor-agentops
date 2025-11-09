# Context Bundles

**Compressed research and planning documents for multi-phase agentic work**

---

## Purpose

Context bundles enable session-spanning work by compressing large research and planning documents into reusable context that can be loaded in future sessions.

**Problem:** Research generates 40-60k tokens, planning generates another 40-60k. Can't fit both plus implementation in one 200k context window.

**Solution:** Compress research/planning into bundles (5-10:1 compression ratio), load them Just-In-Time when needed.

---

## How Bundles Work

### Compression
```
Original Research:    45,000 tokens
Compressed Bundle:     1,200 tokens
Compression Ratio:     37:1

What's preserved:
- Key findings and recommendations
- Constraints and edge cases
- File locations and integration points
- Validation strategy
- Risk assessment

What's compressed:
- Detailed exploration paths
- Alternative approaches evaluated
- Code examples and samples
- Verbose explanations
```

### Usage Pattern
```
Session 1 (Research):
  /research "How to implement Redis caching"
  → research.md (45k tokens)
  → Compress to bundle (1.2k tokens)
  → /bundle-save redis-caching-research

Session 2 (Planning):
  /bundle-load redis-caching-research
  → Research loaded (1.2k tokens vs 45k)
  /plan redis-caching-research.md
  → plan.md (40k tokens)
  → Compress to bundle (1.5k tokens)
  → /bundle-save redis-caching-plan

Session 3 (Implementation):
  /bundle-load redis-caching-plan
  → Plan loaded (1.5k tokens vs 40k)
  /implement redis-caching-plan.md
  → Execute changes
```

---

## Bundle Structure

Each bundle is a markdown file with metadata:

```markdown
---
type: research | plan | implementation
date: YYYY-MM-DD
topic: Brief description
original_tokens: 45000
compressed_tokens: 1200
compression_ratio: 37:1
---

# [Topic] Bundle

## Executive Summary
[1-2 sentence key finding]

## [Section 1]
[Compressed content]

## [Section 2]
[Compressed content]
```

---

## Creating Bundles

### Automatic (Recommended)
```bash
# After completing /research
/bundle-save redis-caching-research

# After completing /plan
/bundle-save redis-caching-plan
```

### Manual (Advanced)
1. Create markdown file in `.agents/bundles/`
2. Add metadata header
3. Compress content (keep key insights, remove verbosity)
4. Calculate compression ratio
5. Commit to git

---

## Loading Bundles

```bash
# List available bundles
/bundle-list

# Search for specific bundle
/bundle-list redis

# Load bundle into current session
/bundle-load redis-caching-research

# Load multiple bundles (for complex work)
/bundle-load redis-caching-research
/bundle-load api-optimization-plan
```

---

## Bundle Naming

Use format: `topic-phase.md`

**Examples:**
- `redis-caching-research.md` - Research findings
- `redis-caching-plan.md` - Implementation plan
- `postgres-migration-research.md` - Migration research
- `k8s-integration-implementation.md` - Implementation results

---

## Compression Best Practices

### ✅ Keep
- Key findings and recommendations
- Constraints and requirements
- File:line specifications
- Validation strategy
- Risk assessment
- Implementation order

### ❌ Remove
- Exploratory discussion
- Alternative approaches considered
- Verbose explanations
- Code samples (reference file:line instead)
- Repeated information

---

## Bundle Lifecycle

```
1. CREATE (during /research or /plan)
   → Original work: 40-60k tokens
   → Compress to bundle: 1-2k tokens

2. SAVE (commit to git)
   → /bundle-save [name]
   → git add .agents/bundles/
   → git commit

3. LOAD (in future session)
   → /bundle-load [name]
   → Bundle content loaded into context

4. USE (execute work)
   → /plan with loaded research
   → /implement with loaded plan

5. ARCHIVE (when work complete)
   → Bundle remains in git history
   → Available for future reference
```

---

## Multi-Bundle Loading

For complex work spanning multiple domains:

```bash
# Load related bundles together
/bundle-load redis-caching-research        # 1.2k tokens
/bundle-load api-architecture-plan         # 1.5k tokens
/bundle-load performance-optimization      # 1.0k tokens
# Total: 3.7k tokens (vs 120k+ uncompressed)

# Still have 196k tokens available for implementation
```

---

## Example Bundles

This directory may contain:

- **Research bundles** - Findings from exploration phase
- **Plan bundles** - Implementation specifications
- **Implementation bundles** - Execution summaries
- **Architecture bundles** - System design decisions

---

## Git Integration

Bundles are version controlled:

```bash
git add .agents/bundles/
git commit -m "research: add Redis caching findings bundle"

# Team can reference bundles
git log .agents/bundles/redis-caching-research.md

# Bundles compound institutional knowledge
```

---

## Token Budget Management

Bundles enable staying under the 40% rule:

```
Context Window: 200,000 tokens
Target: <40% (80,000 tokens)

Without bundles:
  Research: 45k + Planning: 40k = 85k tokens (42.5%) ❌ OVER

With bundles:
  Research bundle: 1.2k + Planning bundle: 1.5k = 2.7k (1.35%) ✅ UNDER
  Available for implementation: 197k tokens
```

---

## Questions?

- **How to create bundles?** Use `/bundle-save` after research/planning
- **How to find bundles?** Use `/bundle-list` to search
- **How to load bundles?** Use `/bundle-load [name]`
- **Can I edit bundles?** Yes, they're markdown files in git

---

**Part of:** 12-Factor-AgentOps Framework
**Pattern:** Context Engineering (40% rule)
**See:** [foundations/context-engineering.md](../../foundations/context-engineering.md)
