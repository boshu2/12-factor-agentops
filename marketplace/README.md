# 12-Factor AgentOps Marketplace

**Operational discipline skills for Claude Code -- implementations of the 12-Factor AgentOps methodology**

| Aspect | Details |
|--------|---------|
| **Skills** | 5 |
| **Type** | Operational Discipline, Knowledge Extraction, Documentation |
| **Compatibility** | Claude Code v1.0+ |

---

## Philosophy

Each skill in this marketplace is a concrete implementation of one or more 12-Factor AgentOps principles. The 12 factors define the operational discipline for working with AI agents; these skills put that discipline into practice during your workflow.

Skills are organized around the four tiers of the methodology:

- **Foundation (Factors I-III):** Context, tracking, and agent scoping
- **Workflow (Factors IV-VI):** Research, validation, and progress locking
- **Knowledge (Factors VII-IX):** Learning extraction, knowledge compounding, and measurement
- **Scale (Factors X-XII):** Worker isolation, hierarchical supervision, and failure harvesting

---

## Available Skills

| Skill | Purpose | Trigger | Factors |
|-------|---------|---------|---------|
| **[factor-compliance-checker](./factor-compliance-checker/)** | Validate against 12 factors | After implementation | All |
| **[nine-laws-auditor](./nine-laws-auditor/)** | Audit against Nine Laws | End of session | VII, IX |
| **[pattern-extraction-assistant](./pattern-extraction-assistant/)** | Extract reusable patterns | During retrospective | VII, VIII |
| **[research-formatter](./research-formatter/)** | Format research findings | End of research phase | IV |
| **[cross-reference-validator](./cross-reference-validator/)** | Validate documentation links | Before commit | V, VI |

---

## Installation

```bash
# Add the marketplace
/plugin marketplace add boshu2/12-factor-agentops

# Install specific skills
/plugin install factor-compliance-checker@12-factor-agentops
/plugin install nine-laws-auditor@12-factor-agentops
/plugin install pattern-extraction-assistant@12-factor-agentops
/plugin install research-formatter@12-factor-agentops
/plugin install cross-reference-validator@12-factor-agentops
```

---

## Skill Categories

### Discipline Skills

**Purpose:** Enforce operational discipline at key workflow moments

| Skill | What It Enforces |
|-------|-----------------|
| factor-compliance-checker | Full 12-factor compliance |
| nine-laws-auditor | Session-level discipline audit |
| cross-reference-validator | Documentation integrity (Validate Externally) |

### Knowledge Skills

**Purpose:** Convert experience into compounding knowledge (Factors VII-VIII)

| Skill | What It Produces |
|-------|------------------|
| pattern-extraction-assistant | Documented, reusable patterns |
| research-formatter | Structured research artifacts |

---

## When to Use Each Skill

```
Research phase complete
    -> /format-research         (Factor IV: Research Before You Build)

Implementation complete
    -> /factor-check            (All factors: compliance audit)
    -> /extract-pattern         (Factor VII: Extract Learnings)

Before commit
    -> /validate-refs           (Factor V: Validate Externally)

End of session
    -> /laws-audit              (Factor IX: Measure What Matters)
```

---

## External Marketplaces

This marketplace links to complementary resources:

| Marketplace | Description |
|-------------|-------------|
| **[boshu2/agentops](https://github.com/boshu2/agentops)** | Production workflow plugins (RPI cycle, operational discipline, development) |
| **[aitmpl](https://github.com/aitmpl)** | AI Template Marketplace (63+ plugins, 85+ agents) |

---

## Contributing

To contribute a new skill:

1. Create directory under `marketplace/`
2. Add `.claude-plugin/plugin.json` with metadata
3. Add `skill.md` with skill definition
4. Add `references/` for supporting materials
5. Submit PR with evidence of validation

**Skill requirements:**
- Must implement one or more 12-Factor AgentOps principles
- Must include validation criteria
- Must have clear trigger conditions
- Must produce actionable output

---

**Remember:** Skills compound knowledge. Each skill you use applies operational discipline and teaches you something about your workflow.
