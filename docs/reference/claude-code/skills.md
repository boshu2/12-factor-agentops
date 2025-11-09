# Skills System

**Purpose:** Reusable components that can be invoked by Claude Code during workflows

**Version:** 1.0.0

**Status:** ✅ Production (2+ workspace skills, growing)

---

## Overview

Skills are **reusable capabilities** that Claude Code can invoke during conversations to perform specific tasks.

**Difference from Agents:**
- **Agents:** Autonomous workflows with specific goals
- **Skills:** Invocable tools used within conversations

---

## Skill Types

### Script-Based Skills

**Purpose:** Deterministic, repeatable operations

**Characteristics:**
- Bash/Python/Node scripts
- Fast execution
- Reliable output
- No LLM calls required

**Example:** `test-container` skill

---

### AI-Powered Skills

**Purpose:** Adaptive, context-aware operations

**Characteristics:**
- Uses LLM for decision-making
- Slower execution
- Context-sensitive
- Non-deterministic

**Example:** `pattern-recognition` skill (future)

---

## Skill Format

### Frontmatter Structure

```markdown
---
skill: test-container
type: script-based
purpose: Validate Docker container builds and runs correctly
status: production
version: 1.0.0
estimated_time: 60s
dependencies:
  - Docker daemon
  - write permissions to /tmp
outputs:
  - test results (pass/fail)
  - detailed logs
integration:
  - git pre-push hook
  - /test command
---

# Test Container Skill

[Skill implementation...]
```

---

## Example: test-container Skill

**Purpose:** Validate Docker containers before deployment

**Location:** `agentops-showcase/.claude/skills/test-container.md`

**Tests Performed:**
1. Docker daemon running ✓
2. Image builds successfully ✓
3. Container starts without errors ✓
4. Health endpoint responds ✓
5. Homepage loads correctly ✓
6. Running as non-root user ✓
7. Clean shutdown ✓

**Integration:**
- Git pre-push hook (automatic)
- `/test` slash command (manual)
- CI/CD pipeline (GitHub Actions)

**Time:** ~60 seconds

---

## Integration with 12-Factor AgentOps

### Factor IV: Validation Gates Before Execution

**Implementation:** Skills provide validation checkpoints

**Example:** `test-container` runs before git push

**Benefit:** Catch issues locally before CI/CD

---

### Factor V: Operational Telemetry

**Implementation:** Skills log execution metrics

**Example:** Test duration, pass/fail rates, error patterns

**Benefit:** Track reliability over time

---

## Best Practices

### For Skill Authors

1. **Clear purpose** - One capability per skill
2. **Deterministic when possible** - Prefer scripts
3. **Fast execution** - Target <2 minutes
4. **Document integration** - How to use it
5. **Version carefully** - Breaking changes affect workflows

### For Skill Users

1. **Invoke via commands** - Use established workflows
2. **Trust the output** - Skills are validated
3. **Report failures** - Help improve reliability

---

## Related Documentation

- [Agents](agents.md) - Autonomous workflows
- [Command Hierarchy](command-hierarchy.md) - How commands use skills
- [Settings](settings.md) - Configuration reference

---

**Version:** 1.0.0 | **Status:** ✅ Production
