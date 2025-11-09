# Installation Guide

**Goal:** Install the 12-Factor AgentOps STARTER-PACK in your project

**Time:** 5 minutes

**Requirements:** Git 2.0+, Claude Code extension

---

## Quick Install (3 Steps)

### Step 1: Copy the Workflow (2 minutes)

```bash
# Clone the 12-factor-agentops repository
git clone https://github.com/[your-org]/12-factor-agentops.git /tmp/12-factor-agentops

# Navigate to your project
cd /path/to/your-project

# Copy the core workflow (agents + commands)
cp -r /tmp/12-factor-agentops/examples/STARTER-PACK/.claude/ .

# Verify
ls -la .claude/
# Should show: agents/ commands/ settings.json
```

---

### Step 2: Install Foundation (2 minutes)

```bash
# Still in your project root

# Install git hooks
mkdir -p .git/hooks
cp /tmp/12-factor-agentops/examples/STARTER-PACK/shared/git-hooks/* .git/hooks/
chmod +x .git/hooks/*

# Copy Laws reference (optional but recommended)
cp /tmp/12-factor-agentops/examples/STARTER-PACK/shared/LAWS.md .

# Copy Interaction Standards (optional)
cp /tmp/12-factor-agentops/examples/STARTER-PACK/shared/INTERACTION-STANDARDS.md .claude/

# Verify hooks installed
ls -la .git/hooks/
# Should show: prepare-commit-msg, commit-msg, post-commit (all executable)
```

---

### Step 3: Test It Works (1 minute)

```bash
# In Claude Code (VSCode/Cursor), try:
/workflow test-feature

# Should see:
# "Starting complete workflow: Research → Plan → Implement → Learn"
# If you see this, installation succeeded! ✅
```

---

## What You Just Installed

### Core Workflow (`.claude/` directory)

**4 Phase-Based Agents:**
- `research-agent.md` - Understand before acting (Phase 1)
- `plan-agent.md` - Design before building (Phase 2)
- `implement-agent.md` - Execute with validation (Phase 3)
- `learn-agent.md` - Extract patterns (Phase 4)

**5 Slash Commands:**
- `/research` - Start research phase
- `/plan` - Start planning phase
- `/implement` - Start implementation phase
- `/learn` - Extract learnings
- `/workflow` - Run complete cycle

**Settings:**
- Minimal hooks configuration
- Basic permissions
- Git commit template

---

### Foundation Layer (`shared/` or project root)

**Git Hooks:**
- `prepare-commit-msg` - Inject commit template
- `commit-msg` - Validate Five Laws compliance
- `post-commit` - Extract learnings to session log
- `post-push` - Check for hook loops

**Documentation:**
- `LAWS.md` - The Five Laws reference
- `INTERACTION-STANDARDS.md` - Consistent prompting guide

---

## Verify Installation

### Check 1: Agents Loaded

```bash
# In Claude Code
/research authentication

# Should trigger research-agent
# If error "command not found" → agents not loaded
```

### Check 2: Hooks Active

```bash
# Test commit hook
git commit --allow-empty

# Should open editor with template:
# <type>(<scope>): <subject>
# ## Context
# ## Solution
# ## Learning
# ## Impact

# If no template → hooks not installed correctly
```

### Check 3: Commands Work

```bash
# In Claude Code
/workflow test

# Should start workflow
# If "command not found" → commands not loaded
```

---

## Troubleshooting

### Problem: "Command not found" for `/research`, `/plan`, etc.

**Cause:** `.claude/commands/` not loaded by Claude Code

**Fix:**
```bash
# Check .claude/ exists in project root
ls -la .claude/

# Check commands directory exists
ls -la .claude/commands/

# Reload Claude Code window
# VSCode: Cmd+Shift+P → "Reload Window"
```

---

### Problem: Commit template not appearing

**Cause:** Git hooks not executable or not in correct location

**Fix:**
```bash
# Check hooks exist
ls -la .git/hooks/ | grep -E '(prepare-commit-msg|commit-msg)'

# Make executable
chmod +x .git/hooks/prepare-commit-msg
chmod +x .git/hooks/commit-msg

# Test manually
.git/hooks/prepare-commit-msg .git/COMMIT_EDITMSG
```

---

### Problem: Agents work but seem incomplete

**Cause:** Copied `.claude/` but not `shared/` foundation

**Impact:** Agents work but won't have access to Laws, standards

**Fix:**
```bash
# Copy foundation
cp /tmp/12-factor-agentops/examples/STARTER-PACK/shared/LAWS.md .
cp /tmp/12-factor-agentops/examples/STARTER-PACK/shared/INTERACTION-STANDARDS.md .claude/
```

---

### Problem: Want to customize agents

**Solution:** Agents are markdown files - edit directly!

```bash
# Example: Customize research-agent for Python projects
nano .claude/agents/research-agent.md

# Add Python-specific tools:
# - Tools: pytest, black, mypy, pylint
# - File patterns: **/*.py, requirements.txt, setup.py
```

---

## Next Steps

### Option 1: Try the Workflow Immediately

```bash
# In Claude Code
/workflow add-feature-name

# Follow prompts through all 4 phases
# See complete Research → Plan → Implement → Learn cycle
```

### Option 2: Start with Research

```bash
# Understand your codebase first
/research "How does authentication work?"

# Then plan improvements
/plan auth-research

# Then implement
/implement auth-plan
```

### Option 3: Read Documentation

```bash
# In your project
cat .claude/../STARTER-PACK/README.md  # Complete guide
cat .claude/../STARTER-PACK/WORKFLOWS.md  # Example workflows
cat LAWS.md  # The Five Laws
```

### Option 4: Customize for Your Domain

**See:** `examples/profiles/` for domain-specific examples
- `software-dev/` - General coding (Python, JS, Go, etc.)
- `platform-ops/` - Infrastructure (K8s, Terraform, etc.)
- `content-creation/` - Documentation and writing

**Copy domain customizations:**
```bash
# Example: Add platform-ops tools
cp -r /tmp/12-factor-agentops/examples/profiles/platform-ops/.claude/agents/* .claude/agents/
```

---

## Uninstall

**To remove 12-Factor AgentOps:**

```bash
# Remove workflow
rm -rf .claude/

# Remove hooks
rm .git/hooks/prepare-commit-msg
rm .git/hooks/commit-msg
rm .git/hooks/post-commit
rm .git/hooks/post-push

# Remove foundation docs (optional)
rm LAWS.md
```

---

## Support

**Issues:**
- GitHub: https://github.com/[your-org]/12-factor-agentops/issues
- Documentation: `examples/STARTER-PACK/README.md`

**Community:**
- Discussions: https://github.com/[your-org]/12-factor-agentops/discussions
- Examples: `examples/profiles/` (see domain-specific implementations)

---

**Installation complete! Try `/workflow test-feature` to see it in action.**
