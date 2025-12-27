# 12-Factor AgentOps Marketplace

**Validation and pattern extraction skills for Claude Code**

| Aspect | Details |
|--------|---------|
| **Skills** | 5 |
| **Type** | Validation, Learning, Documentation |
| **Compatibility** | Claude Code v1.0+ |

---

## Available Skills

| Skill | Purpose | Trigger |
|-------|---------|---------|
| **[factor-compliance-checker](./factor-compliance-checker/)** | Validate against 12 factors | After implementation |
| **[nine-laws-auditor](./nine-laws-auditor/)** | Audit against Nine Laws | End of session |
| **[pattern-extraction-assistant](./pattern-extraction-assistant/)** | Extract reusable patterns | During retrospective |
| **[research-formatter](./research-formatter/)** | Format research findings | End of research phase |
| **[cross-reference-validator](./cross-reference-validator/)** | Validate documentation links | Before commit |

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

### Validation Skills

**Purpose:** Catch problems before they compound

| Skill | What It Validates |
|-------|-------------------|
| factor-compliance-checker | Workflow against 12 factors |
| nine-laws-auditor | Session against Nine Laws |
| cross-reference-validator | Documentation links |

### Learning Skills

**Purpose:** Convert experience into knowledge

| Skill | What It Produces |
|-------|------------------|
| pattern-extraction-assistant | Documented patterns |
| research-formatter | Structured research docs |

---

## When to Use Each Skill

```
Research phase complete
    → /format-research

Implementation complete
    → /factor-check
    → /extract-pattern

Before commit
    → /validate-refs

End of session
    → /laws-audit
```

---

## External Marketplaces

This marketplace links to complementary resources:

| Marketplace | Description |
|-------------|-------------|
| **[boshu2/agentops](https://github.com/boshu2/agentops)** | Production workflow plugins (RPI cycle, DevOps, development) |
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
- Must relate to 12-Factor AgentOps methodology
- Must include validation criteria
- Must have clear trigger conditions
- Must produce actionable output

---

**Remember:** Skills compound knowledge. Each skill you use teaches you something about your workflow.
