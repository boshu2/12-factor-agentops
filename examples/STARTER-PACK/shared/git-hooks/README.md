# Git Hooks for 12-Factor AgentOps

**Purpose:** Enforce the Five Laws automatically through git hooks

**Installation:** See `../INSTALL.md`

---

## Available Hooks

### prepare-commit-msg

**What it does:** Injects commit template if not already present

**When it runs:** Before commit message editor opens

**Template injected:**
```markdown
<type>(<scope>): <subject>

## Context


## Solution


## Learning


## Impact


🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Installation:**
```bash
cp prepare-commit-msg .git/hooks/
chmod +x .git/hooks/prepare-commit-msg
```

---

### commit-msg

**What it does:** Validates commit message format

**When it runs:** After commit message written, before commit created

**Validates:**
- ✅ Semantic commit format (`feat:`, `fix:`, `docs:`, etc.)
- ✅ Subject line length (< 72 characters)
- ✅ Has Context section
- ✅ Has Solution section
- ✅ Has Learning section (or "N/A Learning" if trivial)
- ✅ Has Impact section (or "N/A Impact" if trivial)

**Fails if:** Any validation check fails

**Installation:**
```bash
cp commit-msg .git/hooks/
chmod +x .git/hooks/commit-msg
```

---

### post-commit

**What it does:** Extracts learnings to session log

**When it runs:** After commit created successfully

**Actions:**
- Appends commit summary to `.agentops/session-log.md`
- Tracks session metrics (commits per session, time)
- Updates `.agentops/PROVENANCE.yml` with session metadata

**Installation:**
```bash
cp post-commit .git/hooks/
chmod +x .git/hooks/post-commit
```

---

### post-push (Optional)

**What it does:** Checks for hook loop violations (Law 4)

**When it runs:** After successful push to remote

**Checks:**
- Git status is clean (no files modified by hooks)
- If dirty: Warns user and shows what changed

**Why:** Prevents infinite loop where hook modifies file → commit → hook modifies → commit → ...

**Installation:**
```bash
cp post-push .git/hooks/
chmod +x .git/hooks/post-push
```

---

## Hook Implementations

### Example: prepare-commit-msg

```bash
#!/bin/bash
# .git/hooks/prepare-commit-msg

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2

# Only inject template for normal commits (not merge, squash, etc.)
if [ -z "$COMMIT_SOURCE" ]; then
  # Check if message is empty or default
  if ! grep -q '^[a-z]' "$COMMIT_MSG_FILE" 2>/dev/null; then
    cat > "$COMMIT_MSG_FILE" << 'EOF'
<type>(<scope>): <subject>

## Context


## Solution


## Learning


## Impact


🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
  fi
fi
```

### Example: commit-msg

```bash
#!/bin/bash
# .git/hooks/commit-msg

COMMIT_MSG_FILE=$1

# Read commit message
MSG=$(cat "$COMMIT_MSG_FILE")

# Check semantic commit format
if ! echo "$MSG" | grep -qE '^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .+'; then
  echo "❌ Commit message must follow semantic format:"
  echo "   <type>(<scope>): <subject>"
  echo ""
  echo "   Types: feat, fix, docs, style, refactor, test, chore, perf, ci, build, revert"
  echo "   Example: feat(auth): add JWT refresh token rotation"
  exit 1
fi

# Check for required sections
if ! echo "$MSG" | grep -q '## Context'; then
  echo "❌ Commit message missing '## Context' section"
  exit 1
fi

if ! echo "$MSG" | grep -q '## Solution'; then
  echo "❌ Commit message missing '## Solution' section"
  exit 1
fi

if ! echo "$MSG" | grep -qE '## Learning|N/A Learning'; then
  echo "❌ Commit message missing '## Learning' section (use 'N/A Learning' if trivial)"
  exit 1
fi

if ! echo "$MSG" | grep -qE '## Impact|N/A Impact'; then
  echo "❌ Commit message missing '## Impact' section (use 'N/A Impact' if trivial)"
  exit 1
fi

echo "✅ Commit message validated"
exit 0
```

---

## Installation Guide

**See:** `../INSTALL.md` for complete installation instructions

**Quick install:**
```bash
# From your project root
cd .git/hooks

# Copy all hooks
cp /path/to/STARTER-PACK/shared/git-hooks/* .

# Make executable
chmod +x prepare-commit-msg commit-msg post-commit post-push

# Test
git commit --allow-empty -m "test: verify hooks work"
```

---

## Customization

### Disable Specific Validation

Edit `commit-msg` hook to skip validation:

```bash
# Skip Learning check for trivial commits
if ! echo "$MSG" | grep -qE '## Learning'; then
  echo "⚠️  Warning: No Learning section (skipped for this repo)"
  # Don't exit 1, just warn
fi
```

### Add Domain-Specific Validation

Add checks for your domain:

```bash
# Kubernetes: Check for impacted resources
if echo "$MSG" | grep -q 'feat(k8s):'; then
  if ! echo "$MSG" | grep -q 'Resources:'; then
    echo "❌ K8s commits must list impacted resources"
    exit 1
  fi
fi
```

---

## Troubleshooting

### Hook not running

```bash
# Check hook is executable
ls -la .git/hooks/commit-msg
# Should show: -rwxr-xr-x (x = executable)

# Make executable if needed
chmod +x .git/hooks/commit-msg
```

### Hook fails unexpectedly

```bash
# Run hook manually to see error
.git/hooks/commit-msg .git/COMMIT_EDITMSG

# Check hook syntax
bash -n .git/hooks/commit-msg
```

### Want to skip hook temporarily

```bash
# Skip all hooks for one commit
git commit --no-verify -m "message"

# Not recommended! Only use for emergencies
```

---

## Version & Status

**Version:** 1.0.0
**Status:** Stable
**Compatibility:** Git 2.0+, Bash 4.0+

**See also:**
- `../LAWS.md` - The Five Laws these hooks enforce
- `../INSTALL.md` - Complete installation guide
- `../../WORKFLOWS.md` - Hooks in action

---

**Hooks enforce the Five Laws automatically.**

**Install once, benefit forever.**
