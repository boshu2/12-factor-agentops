---
name: pattern-extraction-assistant
description: Extract reusable patterns from completed work sessions
version: 2.0.0
author: boshu2
license: Apache-2.0
context: fork
user-invocable: true
allowed-tools:
  - Read
  - Write
  - Grep
  - Glob
---

# Pattern Extraction Assistant

**Extract reusable patterns from completed work sessions**

| Aspect | Details |
|--------|---------|
| **Type** | Learning Skill |
| **Trigger** | After implementation, during retrospective |
| **Output** | Documented pattern ready for library |

---

## Summary

Convert session experience into reusable knowledge. Identify what worked, abstract from specific context, and document for future reuse.

## Pattern Template

Every extracted pattern follows this structure:

```markdown
# Pattern: [Name]

**One-line summary of what this pattern solves**

| Aspect | Details |
|--------|---------|
| **Category** | Workflow / Technical / Process / Meta |
| **Confidence** | Prototype / Validated / Standard |
| **Uses** | [Related patterns] |

---

## Problem

What challenge does this solve? When does it occur?

## Context

Where/when is this pattern applicable? What are the preconditions?

## Forces

What competing concerns must be balanced?

## Solution

How do you solve the problem? Include concrete examples.

## Consequences

**Benefits:**
- [Benefit 1]
- [Benefit 2]

**Tradeoffs:**
- [Tradeoff 1]

## Evidence

Where has this been validated? Metrics if available.

## Related Patterns

- **Uses:** [Pattern X]
- **Alternative to:** [Pattern Y]
- **Combines with:** [Pattern Z]
```

## Extraction Process

```
Session complete
    ↓
1. Review: What worked well?
    ↓
2. Identify: Is this reusable?
    ↓
3. Abstract: Remove specific details
    ↓
4. Document: Fill template
    ↓
5. Validate: Does it apply to 3+ contexts?
    ↓
6. Publish: Add to pattern library
```

## Pattern Maturity

| Stage | Evidence | Action |
|-------|----------|--------|
| **Prototype** | 1 session | Document with "experimental" flag |
| **Validated** | 3+ sessions | Promote to validated |
| **Standard** | 10+ sessions, >80% success | Promote to standard practice |
| **Deprecated** | Better pattern exists | Mark deprecated, link replacement |

## Example Extraction

**Session:** Deployed Redis Operator with Kustomization

**What worked:** Strategic merge patches for CRD field overrides

**Abstracted pattern:**

```markdown
# Pattern: Strategic Merge for CRD Overrides

**Use strategic merge patches to override specific CRD fields without duplicating the entire spec**

## Problem
Need to customize operator CRD values per environment without maintaining duplicate YAML.

## Solution
Create base CRD instance with defaults. Use Kustomization strategic merge patches to override specific fields (replicas, resources, storage) per environment.

## Evidence
- Redis Operator: 5 → 3 replicas for staging
- PostgreSQL Operator: Different storage classes per cluster
- Validated across 8 deployments
```

## Usage

After completing work:

```
/extract-pattern
```

With specific learning:

```
/extract-pattern "Kustomization patches work well for CRD field overrides"
```

---

**Remember:** One-time solutions are expendable. Patterns compound. Extract ruthlessly.
