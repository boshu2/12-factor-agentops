---
name: cross-reference-validator
description: Validate cross-references and links across documentation
version: 3.0.0
author: boshu2
license: Apache-2.0
context: fork
user-invocable: true
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
  - WebFetch
---

# Cross-Reference Validator

**Validate cross-references and links across documentation**

| Aspect | Details |
|--------|---------|
| **Type** | Operational Discipline Skill |
| **Trigger** | Before commit, during review |
| **Output** | Broken link report with fixes |
| **Factors** | V: Validate Externally, VI: Lock Progress Forward |

---

## Summary

Documentation rots when links break. This skill implements Factor V (Validate Externally) for documentation: it scans your docs for broken cross-references, outdated links, and orphaned files using external file-system and HTTP checks -- not LLM guesswork.

## What Gets Validated

### Internal Links

| Check | Example | Fix |
|-------|---------|-----|
| **Broken paths** | `[text](./missing.md)` | Update or remove link |
| **Wrong anchors** | `[text](./file.md#wrong)` | Fix anchor name |
| **Case mismatches** | `./File.md` vs `./file.md` | Normalize case |

### External Links

| Check | Example | Fix |
|-------|---------|-----|
| **Dead URLs** | 404 responses | Update or archive |
| **Redirects** | 301/302 responses | Update to final URL |
| **HTTP to HTTPS** | Insecure links | Upgrade to HTTPS |

### Cross-References

| Check | Example | Fix |
|-------|---------|-----|
| **Factor references** | "See Factor XIV" | Only 12 factors exist (I-XII) |
| **Factor name accuracy** | "Factor IV: Continuous Validation" | Correct: Factor V: Validate Externally |
| **Pattern references** | "Uses Pattern X" | Pattern X not in library |

### Orphaned Files

| Check | Description |
|-------|-------------|
| **Unreferenced docs** | Markdown files linked nowhere |
| **Dead patterns** | Patterns not referenced by any factor |
| **Unused assets** | Images/diagrams not embedded |

## v3 Factor Reference (for validation)

When checking factor references, validate against these canonical names:

| Number | Name | Tier |
|--------|------|------|
| I | Context Is Everything | Foundation |
| II | Track Everything in Git | Foundation |
| III | One Agent, One Job | Foundation |
| IV | Research Before You Build | Workflow |
| V | Validate Externally | Workflow |
| VI | Lock Progress Forward | Workflow |
| VII | Extract Learnings | Knowledge |
| VIII | Compound Knowledge | Knowledge |
| IX | Measure What Matters | Knowledge |
| X | Isolate Workers | Scale |
| XI | Supervise Hierarchically | Scale |
| XII | Harvest Failures as Wisdom | Scale |

## Validation Process

```
Documentation change detected
    |
1. Scan changed files for links
    |
2. Validate internal links (path exists, anchor exists)
    |
3. Validate external links (HTTP HEAD request)
    |
4. Check cross-references (factors, patterns)
    |
5. Report findings with fixes
```

## Output Format

```markdown
## Cross-Reference Validation Report

**Scanned:** 24 files
**Links checked:** 156
**Issues found:** 4

### Broken Internal Links

| File | Line | Link | Issue |
|------|------|------|-------|
| docs/principles/five-pillars.md | 112 | `#pillar-6` | Anchor not found |

### External Link Issues

| File | Line | URL | Issue |
|------|------|-----|-------|
| README.md | 54 | `http://12factor.net` | Upgrade to HTTPS |

### Invalid References

| File | Line | Reference | Issue |
|------|------|-----------|-------|
| workflow-guide.md | 89 | "Factor XIV" | Only 12 factors exist |
| tutorial.md | 23 | "Factor IV: Continuous Validation" | Stale name; correct: Factor V: Validate Externally |

### Orphaned Files

| File | Last Modified | Action |
|------|---------------|--------|
| patterns/draft-pattern.md | 2024-06-15 | Review or delete |

### Recommended Fixes

1. Fix anchor to match actual heading
2. Update HTTP to HTTPS
3. Change "Factor XIV" to valid factor (I-XII)
4. Update stale factor names to v3 canonical names
5. Review orphaned pattern for inclusion or deletion
```

## Configuration

Create `.cross-ref-config.json` to customize:

```json
{
  "ignore_patterns": [
    "node_modules/**",
    "*.draft.md"
  ],
  "external_link_timeout": 5000,
  "check_external": true,
  "report_orphans": true
}
```

## Usage

Validate all docs:

```
/validate-refs
```

Validate specific file:

```
/validate-refs path:docs/tutorials/workflow-guide.md
```

Fix mode (auto-fix where possible):

```
/validate-refs --fix
```

---

**Remember:** Broken links erode trust. Every dead link is a promise unkept. Validate externally before you commit.
