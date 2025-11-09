---
name: cross-reference-validator
description: Validate and maintain cross-references between framework components (patterns, factors, pillars, laws). Use when adding documentation, checking link integrity, or ensuring ecosystem coherence.
---

# Cross-Reference Validator

Validate and maintain proper cross-references between all framework components to ensure ecosystem coherence.

## Purpose

This skill ensures that patterns, factors, pillars, and laws are properly linked throughout the framework. Cross-references enable navigation, show relationships, and maintain consistency across the entire ecosystem.

## When to Use This Skill

Use this skill when:
- **Adding new documentation** - Ensure proper cross-links
- **Auditing existing docs** - Find broken/missing references
- **Validating patterns** - Check factor relationships documented
- **Reviewing contributions** - Verify ecosystem integration
- **Reorganizing docs** - Update references after moves

## Cross-Reference Types

### Type 1: Factor → Pattern
**Relationship**: Factors are implemented by patterns

**Example:**
```markdown
# Factor III: Single-Responsibility Agents

## Relationship to Other Patterns

- **Multi-Agent Orchestration**: Enables parallel execution
  of independent agents
- **Intelligent Routing**: Requires well-scoped agents to
  route effectively
```

### Type 2: Pattern → Factor
**Relationship**: Patterns implement/enable factors

**Example:**
```markdown
# Pattern: Multi-Agent Orchestration

## Relationship to Factors

- **Factor III (Single-Responsibility)**: Requires agents
  to be independently executable
- **Factor VII (Intelligent Routing)**: Determines which
  agents to orchestrate
```

### Type 3: Factor → Pillar
**Relationship**: Factors derive from pillars

**Example:**
```markdown
# Factor II: Fresh Context Windows

**Primary Pillar**: Context Engineering
**Supporting Pillar**: Learning Science

## Why This Works

From Context Engineering: Cognitive load theory (Sweller)
shows 40% threshold before degradation...
```

### Type 4: Pattern → Laws
**Relationship**: Patterns enforce laws

**Example:**
```markdown
# Pattern: Phase-Based Workflow

## Laws Compliance

- **Law 1 (Extract Learnings)**: Each phase produces learnings
- **Law 2 (Improve)**: Identifies inefficiencies in workflow
- **Law 4 (Validate)**: Planning phase validates before execution
```

### Type 5: Cross-Pattern
**Relationship**: Patterns work together or are alternatives

**Example:**
```markdown
# Pattern: Context Bundles

## Pattern Relationships

- **Complementary to**: Phase-Based Workflow (bundle per phase)
- **Requires**: Multi-Agent Orchestration (for bundle creation)
- **Alternative to**: N/A (unique solution to multi-session problem)
```

## Validation Workflow

### Step 1: Identify All References

**In new documentation, look for:**
- Factor mentions (Factor I, II, III, etc.)
- Pattern names (Phase-Based Workflow, etc.)
- Pillar references (DevOps + SRE, Learning Science, etc.)
- Law citations (Law 1, Law 2, etc.)

### Step 2: Check Bidirectional Links

**For each reference, verify:**
1. Source document mentions target
2. Target document mentions source (bidirectional)
3. Relationship is clearly explained
4. Links are valid (no broken paths)

**Example bidirectional check:**
```
Factor III mentions Pattern: Multi-Agent Orchestration ✅
Pattern: Multi-Agent Orchestration mentions Factor III ✅
```

### Step 3: Use Validation Script

```bash
python3 scripts/validate_cross_refs.py path/to/doc.md
```

**Script checks:**
- All referenced factors exist
- All referenced patterns exist
- Links are valid file paths
- Bidirectional references present

### Step 4: Verify Relationship Accuracy

**Check that:**
- Relationship type is correct (enables/requires/complements)
- Explanation matches actual connection
- No contradictions across docs

### Step 5: Generate Reference Map

Use `references/cross-reference-map.md` to visualize ecosystem:

```
Factor I (Git Memory)
├─ Enables → Pattern: Pattern Extraction
├─ Requires → Pillar: Knowledge OS
└─ Enforces → Law 1, Law 3

Factor II (40% Rule)
├─ Enables → Pattern: Context Bundles
├─ Requires → Pillar: Context Engineering
└─ Enforces → Law 2, Law 4

Pattern: Phase-Based Workflow
├─ Implements → Factor II, Factor VII
├─ Grounded in → Pillar: Learning Science
├─ Enforces → Law 1, Law 2, Law 4
└─ Complements → Pattern: Multi-Agent Orchestration
```

## Common Cross-Reference Issues

### Issue 1: One-Way References
**Problem**: Doc A mentions Doc B, but B doesn't mention A
**Impact**: Asymmetric knowledge graph, poor discoverability
**Solution**: Add bidirectional link to Doc B

### Issue 2: Broken Links
**Problem**: Reference to moved/renamed/deleted file
**Impact**: Navigation fails, ecosystem fragmented
**Solution**: Update all references when moving files

### Issue 3: Vague Relationships
**Problem**: "Related to Factor X" without explanation
**Impact**: Unclear how components connect
**Solution**: Specify relationship type and why

### Issue 4: Missing Pillar Grounding
**Problem**: Pattern doesn't reference supporting pillars
**Impact**: Weak theoretical foundation
**Solution**: Add explicit pillar grounding section

### Issue 5: Orphaned Documents
**Problem**: Doc has no incoming references
**Impact**: Undiscoverable, isolated knowledge
**Solution**: Add references from related docs

## Quick Reference Commands

### Find All References to Factor III
```bash
grep -r "Factor III" --include="*.md" .
```

### Find All Pattern References
```bash
grep -r "Pattern:" --include="*.md" patterns/
```

### Check for Broken Links
```bash
python3 scripts/validate_cross_refs.py --check-all
```

### Generate Reference Map
```bash
python3 scripts/generate_ref_map.py > references/cross-reference-map.md
```

## Maintenance Checklist

### When Adding New Factor
- [ ] Reference primary + supporting pillars
- [ ] List laws enforced
- [ ] Link to implementing patterns
- [ ] Link to related factors
- [ ] Update patterns to reference this factor

### When Adding New Pattern
- [ ] Reference factors implemented
- [ ] Reference pillar grounding
- [ ] List laws enforced
- [ ] Link to related patterns
- [ ] Update factors to reference this pattern

### When Moving/Renaming Files
- [ ] Update all incoming references
- [ ] Update all outgoing references
- [ ] Run full cross-reference validation
- [ ] Update reference map

## Resources

### scripts/validate_cross_refs.py
Python script that validates all cross-references in documentation. Checks for broken links, missing bidirectional references, and orphaned documents.

### scripts/generate_ref_map.py
Generates visual reference map showing all relationships between framework components.

### references/cross-reference-map.md
Complete map of framework ecosystem showing all relationships between factors, patterns, pillars, and laws.

---

**Remember**: Cross-references are the connective tissue of the framework. Keep them healthy and bidirectional.
