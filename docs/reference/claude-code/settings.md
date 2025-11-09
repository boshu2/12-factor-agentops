# Settings & Hooks Configuration

**Purpose:** Document Claude Code settings.json configuration and hooks system

**Version:** 1.0.0

**Status:** ✅ Production

---

## Overview

The `.claude/settings.json` file configures Claude Code behavior, permissions, hooks, and integrations.

**Key Concept:** Settings inherit from workspace → repository, with repository settings taking precedence.

---

## Settings Inheritance

```
Workspace: .claude/settings.json
    ↓ inherited
Repository: [repo]/.claude/settings.json
    ↓ extended by
Developer: [repo]/.claude/settings.local.json (not committed)
```

**Precedence:** Developer > Repository > Workspace

---

## Core Settings

### Model Selection

```json
{
  "defaultModel": "opus",
  "modelOverrides": {
    "quick-tasks": "sonnet",
    "complex-research": "opus"
  }
}
```

**Options:** `opus`, `sonnet`, `haiku`

---

### Permissions

```json
{
  "allowed": [
    "Bash(git:*)",           // All git commands
    "Bash(docker:*)",        // Docker operations
    "Bash(./scripts/*)",     // Repository scripts
    "Read(*)",               // Read any file
    "Write(docs/*)"          // Write to docs/
  ],
  "denied": [
    "Bash(rm -rf:*)",        // Dangerous deletions
    "Write(.git/*)"          // Protect git internals
  ]
}
```

---

## Hooks System

### Hook Types

**beforeTool:** Execute before Claude uses a tool

```json
{
  "hooks": {
    "beforeTool": [
      {
        "filter": {
          "toolName": "Bash",
          "toolInput": {
            "command": "git push*"
          }
        },
        "bashCommand": "echo '⚠️ Pre-Push Validation Active' && sleep 2"
      }
    ]
  }
}
```

**afterTool:** Execute after Claude uses a tool

```json
{
  "hooks": {
    "afterTool": [
      {
        "filter": {
          "toolName": "Write"
        },
        "bashCommand": "echo 'File written: {file_path}' >> .logs/changes.log"
      }
    ]
  }
}
```

---

## Example: Pre-Push Validation

**From agentops-showcase:**

```json
{
  "hooks": {
    "beforeTool": [
      {
        "filter": {
          "toolName": "Bash",
          "toolInput": {
            "command": "git push*"
          }
        },
        "bashCommand": "echo '\n⚠️ PRE-PUSH VALIDATION\n\nThe pre-push hook will run ./scripts/test-container.sh\nThis validates the Docker container before pushing.\n\nTo skip: SKIP_CONTAINER_TEST=1 git push\n' && sleep 2"
      }
    ]
  }
}
```

**Integration:**
1. Claude Code shows notification (beforeTool hook)
2. Git pre-push hook runs `./scripts/test-container.sh`
3. Tests pass → push proceeds
4. Tests fail → push blocked

**Result:** Three layers of protection (notification, validation, blocking)

---

## Integration with 12-Factor AgentOps

### Factor IV: Validation Gates Before Execution

**Implementation:** Hooks enforce validation before critical operations

**Example:** Pre-push validation prevents broken containers

**Benefit:** Shift-left testing (catch locally, not in CI/CD)

---

### Factor V: Operational Telemetry

**Implementation:** Hooks log operations for analysis

**Example:** Log all Write operations to track changes

**Benefit:** Audit trail and metrics collection

---

### Factor XI: Constitutional Guardrails

**Implementation:** Hooks enforce operational laws

**Example:** Block dangerous operations, require validations

**Benefit:** Safety guardrails always active

---

## Best Practices

### For Repository Maintainers

1. **Extend, don't override** - Keep workspace settings, add repository-specific
2. **Document hooks** - Clear README explaining what hooks do
3. **Test thoroughly** - Hooks affect all users
4. **Version carefully** - Breaking changes impact workflows

### For Developers

1. **Use settings.local.json** - Personal overrides (not committed)
2. **Respect hooks** - Don't bypass unless emergency
3. **Report issues** - Help improve configuration
4. **Share learnings** - Document useful patterns

---

## Troubleshooting

### "Hook not running"

**Check:**
```bash
cat .claude/settings.json | grep hooks
cat .git/hooks/pre-push     # For git hooks
```

**Fix:** Ensure hook filter matches actual command

---

### "Permission denied"

**Check:**
```bash
cat .claude/settings.json | grep allowed
```

**Fix:** Add permission to `allowed` array, or use settings.local.json

---

## Related Documentation

- [Command Hierarchy](command-hierarchy.md) - How hooks integrate with commands
- [Agents](agents.md) - How agents use settings
- [Skills](skills.md) - How skills are invoked

---

**Version:** 1.0.0 | **Status:** ✅ Production
