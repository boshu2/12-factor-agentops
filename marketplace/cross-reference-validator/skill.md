---
name: cross-reference-validator
description: Validate cross-references and links across documentation
version: 2.0.0
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
| **Type** | Validation Skill |
| **Trigger** | Before commit, during review |
| **Output** | Broken link report with fixes |

---

## Summary

Documentation rots when links break. This skill scans your docs for broken cross-references, outdated links, and orphaned files.

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
| **HTTP → HTTPS** | Insecure links | Upgrade to HTTPS |

### Cross-References

| Check | Example | Fix |
|-------|---------|-----|
| **Factor references** | "See Factor XIV" | Factor XIV doesn't exist |
| **Pattern references** | "Uses Pattern X" | Pattern X not in library |
| **Law references** | "Law 10" | Only 9 laws exist |

### Orphaned Files

| Check | Description |
|-------|-------------|
| **Unreferenced docs** | Markdown files linked nowhere |
| **Dead patterns** | Patterns not referenced by any factor |
| **Unused assets** | Images/diagrams not embedded |

## Validation Process

```
Documentation change detected
    ↓
1. Scan changed files for links
    ↓
2. Validate internal links (path exists, anchor exists)
    ↓
3. Validate external links (HTTP HEAD request)
    ↓
4. Check cross-references (factors, laws, patterns)
    ↓
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
| factors/01-automated-tracking.md | 45 | `../patterns/git-workflow.md` | File not found |
| docs/principles/five-pillars.md | 112 | `#pillar-6` | Anchor not found |

### External Link Issues

| File | Line | URL | Issue |
|------|------|-----|-------|
| README.md | 54 | `http://12factor.net` | Upgrade to HTTPS |

### Invalid References

| File | Line | Reference | Issue |
|------|------|-----------|-------|
| workflow-guide.md | 89 | "Factor XIV" | Only 12 factors exist |

### Orphaned Files

| File | Last Modified | Action |
|------|---------------|--------|
| patterns/draft-pattern.md | 2024-06-15 | Review or delete |

### Recommended Fixes

1. Create `patterns/git-workflow.md` or update link
2. Rename anchor to match actual heading
3. Update HTTP to HTTPS
4. Change "Factor XIV" to valid factor
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

**Remember:** Broken links erode trust. Every dead link is a promise unkept. Validate before you ship.
