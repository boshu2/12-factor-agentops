# Cross-Reference Template

**Purpose:** Template for creating bidirectional cross-references between 12-factor-agentops (framework) and agentops (implementation).

**Last Updated:** 2025-11-05

---

## Overview

The 12-factor-agentops and agentops repositories are complementary:

- **12-factor-agentops** = Theory, patterns, research, philosophy
- **agentops** = Tools, agents, how-to guides, implementation

Cross-references should:
- Be bidirectional (both directions)
- Be contextual (explain when to use each)
- Be discoverable (prominent placement)
- Be helpful (guide users to the right repo)

---

## Pattern 1: From Framework → Implementation

**Use when:** Documenting a pattern/concept in 12-factor-agentops that has a working implementation in agentops.

**Template:**

```markdown
## See It In Action

Want to use this pattern in practice? See the [pattern-name workflow](https://github.com/boshu2/agentops/blob/main/profiles/default/commands/pattern-name/) in agentops for a working implementation.

**Quick Start:**
1. Install agentops: `curl -sSL https://raw.githubusercontent.com/boshu2/agentops/main/scripts/base-install.sh | bash`
2. Run the workflow: `/pattern-name`
3. See [how-to guide](https://github.com/boshu2/agentops/blob/main/docs/how-to/run-pattern-name.md) for detailed usage

**Related Implementation:**
- [Agent: pattern-agent](https://github.com/boshu2/agentops/blob/main/profiles/default/agents/pattern-agent/)
- [How-To: Use Pattern](https://github.com/boshu2/agentops/blob/main/docs/how-to/use-pattern.md)
```

**Where to place:**
- At the end of pattern documentation (patterns/*.md)
- At the end of foundation documents (foundations/*.md)
- In relevant sections of README.md

**Examples:**
- `patterns/phase-based-workflow.md` → link to plan-product workflow
- `patterns/multi-agent-orchestration.md` → link to multi-agent commands
- `foundations/context-engineering.md` → link to bundle commands

---

## Pattern 2: From Implementation → Framework

**Use when:** Documenting a tool/agent/workflow in agentops that implements a framework pattern from 12-factor-agentops.

**Template:**

```markdown
## Theoretical Foundation

This workflow implements the [Pattern Name](https://github.com/boshu2/12-factor-agentops/blob/main/patterns/pattern-name.md) pattern from 12-Factor AgentOps.

**Why this works:**
Brief 1-2 sentence explanation of the underlying pattern/theory.

**Learn more:**
- [Pattern documentation](https://github.com/boshu2/12-factor-agentops/blob/main/patterns/pattern-name.md)
- [Four Pillars](https://github.com/boshu2/12-factor-agentops/blob/main/foundations/four-pillars.md)
- [Five Laws](https://github.com/boshu2/12-factor-agentops/blob/main/foundations/five-laws.md)
```

**Where to place:**
- In how-to guides (docs/how-to/*.md)
- In agent documentation (profiles/default/agents/*/README.md)
- In command documentation (profiles/default/commands/*/README.md)

**Examples:**
- `docs/how-to/run-plan-product.md` → link to phase-based-workflow pattern
- `profiles/default/commands/multi-agent/README.md` → link to multi-agent-orchestration pattern
- `profiles/default/agents/bundle-manager/README.md` → link to context-bundles pattern

---

## Pattern 3: Repository-Level Cross-Reference

**Use when:** Adding high-level cross-references in README files to guide users between repos.

### In 12-factor-agentops/README.md

```markdown
## Reference Implementation

Want to use AgentOps in practice? See [agentops](https://github.com/boshu2/agentops) for production-ready tools, working agents, and how-to guides.

**Start here if you want to:**
- Use AgentOps tools immediately
- Follow practical tutorials
- Implement workflows in your operations
- Create custom agents for your domain

**See Also:** [agentops README](https://github.com/boshu2/agentops#readme) for quick-start and installation.
```

**Placement:** Early in README (after introduction, before detailed content)

### In agentops/README.md

```markdown
## Philosophical Foundation

Want to understand why AgentOps works? See [12-factor-agentops](https://github.com/boshu2/12-factor-agentops) for the framework, patterns, and research.

**Start there if you want to:**
- Understand AgentOps deeply
- Learn the Four Pillars and Five Laws
- Study operational patterns and theory
- Contribute new patterns or research

**See Also:** [12-Factor AgentOps README](https://github.com/boshu2/12-factor-agentops#readme) for the framework overview.
```

**Placement:** Early in README (after introduction, before main content)

---

## Pattern 4: Contribution Routing

**Use when:** Directing contributors to the correct repository for their contribution type.

### In 12-factor-agentops/CONTRIBUTING.md

```markdown
## What to Contribute Here

✅ **Contribute to 12-factor-agentops if you want to:**
- Propose new patterns or refine existing ones
- Share research or case studies
- Contribute to theoretical foundations
- Improve framework documentation

❌ **Don't contribute here if you want to:**
- Create new agents or commands → see [agentops](https://github.com/boshu2/agentops/blob/main/CONTRIBUTING.md)
- Write how-to guides or tutorials → see [agentops](https://github.com/boshu2/agentops/blob/main/CONTRIBUTING.md)
- Report tool bugs → see [agentops issues](https://github.com/boshu2/agentops/issues)
```

### In agentops/CONTRIBUTING.md

```markdown
## What to Contribute Here

✅ **Contribute to agentops if you want to:**
- Create new agents or commands
- Write how-to guides or tutorials
- Share implementation examples
- Report or fix bugs in tools

❌ **Don't contribute here if you want to:**
- Propose patterns or research → see [12-factor-agentops](https://github.com/boshu2/12-factor-agentops/blob/main/CONTRIBUTING.md)
- Contribute to theoretical foundations → see [12-factor-agentops](https://github.com/boshu2/12-factor-agentops/blob/main/CONTRIBUTING.md)
- Discuss framework philosophy → see [12-factor-agentops issues](https://github.com/boshu2/12-factor-agentops/issues)
```

**Placement:** Near the top of CONTRIBUTING.md, before detailed contribution instructions

---

## Validation Checklist

When adding cross-references, verify:

- [ ] Link URLs are correct (check repo name, branch, file path)
- [ ] Links use relative paths when within same repo
- [ ] Links use absolute GitHub URLs when cross-repo
- [ ] Link text is descriptive (not "click here")
- [ ] Context explains why user should follow link
- [ ] Bidirectional where appropriate (framework ↔ implementation)
- [ ] No broken links (test manually or with link checker)
- [ ] Cross-reference adds value (not just noise)

---

## Anti-Patterns (What NOT to Do)

❌ **Don't:**
- Link without context ("See agentops")
- Create circular references that confuse users
- Duplicate content instead of cross-referencing
- Use vague link text ("here", "this", "link")
- Overload pages with excessive cross-references
- Link to outdated or deprecated content

✅ **Do:**
- Provide clear context for why to follow link
- Use descriptive link text
- Keep cross-references focused and relevant
- Validate links regularly
- Update cross-references when content moves

---

## Examples in Use

### Example 1: Pattern → Implementation

**File:** `12-factor-agentops/patterns/phase-based-workflow.md`

```markdown
## See It In Action

Want to use the phase-based workflow in practice? See the [plan-product workflow](https://github.com/boshu2/agentops/blob/main/profiles/default/commands/plan-product/) in agentops.

This workflow implements all three phases:
1. Research phase (`/plan-product` with research agents)
2. Planning phase (spec shaping and writing)
3. Implementation phase (task creation and execution)

**Quick Start:**
```bash
# Install agentops
curl -sSL https://raw.githubusercontent.com/boshu2/agentops/main/scripts/base-install.sh | bash

# Run the workflow
/plan-product
```

See the [how-to guide](https://github.com/boshu2/agentops/blob/main/docs/how-to/run-plan-product.md) for detailed usage.
```

### Example 2: Implementation → Framework

**File:** `agentops/docs/how-to/run-plan-product.md`

```markdown
## Theoretical Foundation

The plan-product workflow implements the [Phase-Based Workflow](https://github.com/boshu2/12-factor-agentops/blob/main/patterns/phase-based-workflow.md) pattern from 12-Factor AgentOps.

**Why this works:**
Breaking work into distinct cognitive phases (research → plan → implement) prevents context overload and enables the 40% rule to work effectively.

**Learn more:**
- [Phase-Based Workflow Pattern](https://github.com/boshu2/12-factor-agentops/blob/main/patterns/phase-based-workflow.md)
- [Context Engineering Foundations](https://github.com/boshu2/12-factor-agentops/blob/main/foundations/context-engineering.md)
```

---

## Maintenance

Cross-references should be reviewed and updated:

- **When content moves:** Update all links pointing to moved content
- **When content is deprecated:** Remove or redirect cross-references
- **Quarterly:** Run link checker to catch broken links
- **On major releases:** Verify all cross-references still valid

**Automation:**
- CI/CD runs link checker on every PR
- Automated alerts for broken cross-references
- Link validation included in pre-commit hooks

---

## Questions?

If you're unsure whether to add a cross-reference:

1. **Ask:** Does this link add value for the reader?
2. **Ask:** Is the target content stable (not likely to change soon)?
3. **Ask:** Is the context clear (why should they follow this link)?

If yes to all three, add the cross-reference.

If no to any, consider:
- Improving the context
- Waiting until content stabilizes
- Finding a better cross-reference target

---

**Template Version:** 1.0
**Last Updated:** 2025-11-05
**Maintained By:** 12-Factor AgentOps Team
