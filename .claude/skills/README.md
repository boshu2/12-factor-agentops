# 12-Factor AgentOps Skills

**6 specialized skills for working with the 12-Factor AgentOps framework**

Created: 2025-11-08
Location: `/Users/fullerbt/workspaces/personal/12-factor-agentops/.claude/skills/`

---

## Available Skills

### 1. Factor Compliance Checker
**File**: `factor-compliance-checker/SKILL.md`

**Purpose**: Validate patterns and contributions against the 12-Factor AgentOps methodology

**Use when**:
- Reviewing new patterns submitted to the framework
- Auditing existing patterns for compliance
- Writing new factor documentation (Factors IV-XII)
- Validating workflow implementations in production
- Ensuring contributions follow framework principles
- Quality checking before committing factor-related changes

**Key resources**:
- `references/factors-checklist.md` - Complete validation checklist for all 12 factors
- `scripts/validate_factor.py` - Automated compliance checking script

**Example usage**:
```bash
python3 .claude/skills/factor-compliance-checker/scripts/validate_factor.py factors/04-validation-gates.md
```

---

### 2. Pattern Extraction Assistant
**File**: `pattern-extraction-assistant/SKILL.md`

**Purpose**: Extract reusable patterns from production implementations and format them for the framework

**Use when**:
- Extracting patterns from production (gitops/.claude/agents/ → patterns/)
- Converting operational workflows into reusable patterns
- Formalizing discovered practices after successful implementations
- Documenting learnings from multi-session work
- Creating new pattern documentation for the framework
- Preparing case studies from real production experience

**Key resources**:
- `assets/pattern-template.md` - Complete markdown template for new patterns
- `references/pillar-mapping-guide.md` - Guide for grounding patterns in Four Pillars
- `references/cross-reference-map.md` - Framework ecosystem relationship map
- `references/extraction-guide.md` - Step-by-step extraction examples

**Example workflow**:
1. Identify pattern candidate (3+ successful applications)
2. Copy `assets/pattern-template.md` to `patterns/new-pattern.md`
3. Complete all template sections
4. Validate with factor-compliance-checker
5. Submit PR

---

### 3. Five Laws Compliance Auditor
**File**: `five-laws-auditor/SKILL.md`

**Purpose**: Audit work for compliance with the Five Laws of AgentOps

**Use when**:
- Before committing work - Ensure Laws compliance
- Reviewing agent sessions - Validate learning extraction
- Auditing patterns/workflows - Check all laws enforced
- Pre-publication review - Verify framework contributions
- Quality gates - As part of validation workflow

**Key resources**:
- `references/laws-audit-checklist.md` - Detailed audit criteria for each law
- `scripts/audit_commit.sh` - Git commit compliance checker

**The Five Laws**:
1. ALWAYS Extract Learnings
2. ALWAYS Improve Self or System
3. ALWAYS Document Context for Future
4. ALWAYS Validate Before Execute
5. ALWAYS Share Patterns Publicly

**Quick audit**:
```bash
# Check last commit for Laws compliance
git log -1 --format="%B" | grep -E "(Context:|Solution:|Learning:|Impact:)"
```

---

### 4. Research Contribution Formatter
**File**: `research-formatter/SKILL.md`

**Purpose**: Format research contributions, case studies, and empirical validation for the framework

**Use when**:
- Documenting research findings for the framework
- Creating case studies from production experience
- Submitting empirical validation of patterns
- Publishing experiment results
- Formalizing hypothesis testing outcomes
- Contributing theoretical grounding for factors/patterns

**Key resources**:
- `assets/research-template.md` - Template for empirical studies
- `assets/case-study-template.md` - Template for production case studies
- `assets/theoretical-grounding-template.md` - Template for theoretical foundations

**Research types supported**:
1. **Empirical Studies**: Hypothesis testing with controlled experiments
2. **Case Studies**: Real production application documentation
3. **Theoretical Grounding**: Academic/theoretical foundations

---

### 5. Diátaxis Documentation Organizer
**File**: `diataxis-organizer/SKILL.md`

**Purpose**: Organize documentation using the Diátaxis framework (Tutorials, How-to, Reference, Explanation)

**Use when**:
- Creating new documentation - Determine proper type/structure
- Reorganizing existing docs - Fix mismatched content/format
- Planning documentation strategy - Design doc structure
- Auditing documentation - Ensure Diátaxis compliance
- Improving discoverability - Help readers find what they need

**Key resources**:
- `assets/tutorial-template.md` - Learning-oriented tutorials
- `assets/how-to-template.md` - Problem-oriented guides
- `assets/reference-template.md` - Information-oriented reference
- `assets/explanation-template.md` - Understanding-oriented explanations
- `references/diataxis-guide.md` - Complete framework guide

**The Four Types**:
1. **Tutorials**: Learning-oriented (for beginners)
2. **How-To Guides**: Problem-oriented (for practitioners)
3. **Reference**: Information-oriented (for lookup)
4. **Explanation**: Understanding-oriented (for context)

**Decision tree**:
```
Brand new to topic? → Tutorial
Have specific problem? → How-To
Need to look up info? → Reference
Want to understand why? → Explanation
```

---

### 6. Cross-Reference Validator
**File**: `cross-reference-validator/SKILL.md`

**Purpose**: Validate and maintain cross-references between framework components

**Use when**:
- Adding new documentation - Ensure proper cross-links
- Auditing existing docs - Find broken/missing references
- Validating patterns - Check factor relationships documented
- Reviewing contributions - Verify ecosystem integration
- Reorganizing docs - Update references after moves

**Key resources**:
- `scripts/validate_cross_refs.py` - Automated cross-reference validation
- `scripts/generate_ref_map.py` - Generate visual reference map
- `references/cross-reference-map.md` - Complete ecosystem map

**Cross-reference types**:
1. Factor → Pattern (factors are implemented by patterns)
2. Pattern → Factor (patterns implement/enable factors)
3. Factor → Pillar (factors derive from pillars)
4. Pattern → Laws (patterns enforce laws)
5. Cross-Pattern (patterns work together/are alternatives)

**Quick commands**:
```bash
# Find all references to Factor III
grep -r "Factor III" --include="*.md" .

# Check for broken links
python3 scripts/validate_cross_refs.py --check-all

# Generate reference map
python3 scripts/generate_ref_map.py > references/cross-reference-map.md
```

---

## Skill Integration

These skills work together to maintain framework quality:

```
Pattern Extraction Assistant
    ↓ (creates patterns)
Factor Compliance Checker
    ↓ (validates structure)
Five Laws Auditor
    ↓ (ensures Laws compliance)
Cross-Reference Validator
    ↓ (verifies ecosystem integration)
Diátaxis Organizer
    ↓ (proper documentation type)
Research Formatter
    ↓ (empirical validation)
```

## Common Workflows

### Creating a New Pattern

1. **Extract**: Use Pattern Extraction Assistant to create from production
2. **Validate**: Run Factor Compliance Checker on pattern doc
3. **Audit Laws**: Ensure Five Laws Compliance Auditor passes
4. **Cross-ref**: Add bidirectional links with Cross-Reference Validator
5. **Format docs**: Apply Diátaxis Organizer for proper structure
6. **Add research**: Use Research Formatter for case study

### Reviewing a Contribution

1. **Structure**: Factor Compliance Checker for basic structure
2. **Laws**: Five Laws Auditor for constitutional compliance
3. **Links**: Cross-Reference Validator for ecosystem integration
4. **Docs**: Diátaxis Organizer for proper documentation type
5. **Evidence**: Research Formatter for validation quality

### Preparing for Publication

1. **Final audit**: All compliance checkers (factor, laws, cross-ref)
2. **Documentation**: Diátaxis Organizer for reader experience
3. **Evidence**: Research Formatter for credibility
4. **Extraction**: Pattern Extraction Assistant for generalizability

---

## Quick Reference

| Need to... | Use this skill |
|-----------|---------------|
| Validate a pattern | Factor Compliance Checker |
| Extract from production | Pattern Extraction Assistant |
| Check Laws compliance | Five Laws Auditor |
| Add case study | Research Formatter |
| Organize documentation | Diátaxis Organizer |
| Fix broken links | Cross-Reference Validator |

---

## Next Steps

1. **Try the skills**: Pick one and use it on existing documentation
2. **Provide feedback**: What works? What's missing?
3. **Extend as needed**: Add more references, scripts, assets
4. **Package**: Use skill-creator's package_skill.py when ready to distribute

---

**Status**: All 6 skills complete and ready to use
**Quality**: Skills follow skill-creator best practices
**Integration**: Skills complement each other for complete framework maintenance

**Created for the 12-Factor AgentOps framework to maintain quality, consistency, and ecosystem coherence.**
