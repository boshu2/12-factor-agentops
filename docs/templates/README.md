# Templates - Copy & Adapt

**Purpose:** Production-ready templates you can copy and customize for your projects

**Status:** ✅ Validated in production (production use since Claude 2.0)

---

## Available Templates

### 1. Pre-Commit Hook (Universal)

**File:** [pre-commit-hook.sh](pre-commit-hook.sh)

**Purpose:** Validation gates that run before every commit (Factor IV)

**Includes:**
- YAML syntax validation (Platform Engineering)
- ESLint/TypeScript checking (Web Development)
- Shell script validation (DevOps)
- Secret detection (Universal)
- Format checking (Universal)
- Kustomize validation (Platform Engineering)

**Usage:**
```bash
# Copy to your repository
cp pre-commit-hook.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Test it
git add .
git commit -m "test: validate pre-commit hook"
```

**Customize:**
- Add domain-specific validations
- Adjust yamllint rules
- Add custom test commands
- Modify exit behavior

---

### 2. Claude Code Settings

**File:** [claude-settings.json](claude-settings.json)

**Purpose:** Claude Code configuration with validation hooks (Factor XI)

**Includes:**
- Model selection (Opus for research, Sonnet for quick tasks)
- Allowed commands (git, docker, npm, scripts)
- Denied commands (dangerous operations)
- Pre-push notification hook
- Production file warning hook

**Usage:**
```bash
# Copy to your repository
mkdir -p .claude
cp claude-settings.json .claude/settings.json

# Customize for your needs
vim .claude/settings.json
```

**Customize:**
- Adjust allowed/denied commands
- Add domain-specific hooks
- Modify model preferences
- Add custom notifications

---

### 3. Container Test Script

**File:** [test-container.sh](test-container.sh)

**Purpose:** Docker container validation (Factor IV - Web Development)

**Includes:**
- Docker daemon check
- Image build validation
- Container startup test
- Health endpoint verification
- Homepage loading test
- Security check (non-root user)
- Graceful shutdown test

**Usage:**
```bash
# Copy to your repository
mkdir -p scripts
cp test-container.sh scripts/
chmod +x scripts/test-container.sh

# Test manually
./scripts/test-container.sh

# Add to pre-push hook
echo '#!/bin/bash
./scripts/test-container.sh' > .git/hooks/pre-push
chmod +x .git/hooks/pre-push
```

**Customize:**
- Adjust ports (TEST_PORT, APP_PORT)
- Add custom health check logic
- Modify timeout values
- Add domain-specific tests

---

## Integration Examples

### Complete Setup (New Repository)

```bash
# 1. Initialize Claude Code
mkdir -p .claude
cp templates/claude-settings.json .claude/settings.json

# 2. Add pre-commit validation
cp templates/pre-commit-hook.sh .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# 3. Add container testing (if applicable)
mkdir -p scripts
cp templates/test-container.sh scripts/
chmod +x scripts/test-container.sh

# Create pre-push hook
cat > .git/hooks/pre-push <<'EOF'
#!/bin/bash
if [ -z "$SKIP_CONTAINER_TEST" ]; then
  ./scripts/test-container.sh
fi
EOF
chmod +x .git/hooks/pre-push

# 4. Test the setup
echo "# Test" >> README.md
git add README.md
git commit -m "test: validate hooks setup"
```

---

### Platform Engineering / IaC / GitOps

**Additional templates needed:**
- Kustomize validation
- ArgoCD application templates
- Helm chart validation
- GitLab CI pipeline

**Example pre-commit additions:**
```bash
# Add to pre-commit-hook.sh

# Validate Kustomize overlays
for dir in apps/*/overlays/*/; do
  if [ -d "$dir" ]; then
    echo "  → Testing kustomize: $dir"
    kubectl kustomize "$dir" > /dev/null || exit 1
  fi
done

# Validate ArgoCD applications
find . -name "application.yaml" -o -name "app-*.yaml" | while read -r app; do
  echo "  → Validating ArgoCD app: $app"
  argocd app validate "$app" || exit 1
done
```

---

### Web Development

**Additional templates needed:**
- Next.js validation
- TypeScript type checking
- Component testing
- Build verification

**Example pre-commit additions:**
```bash
# Add to pre-commit-hook.sh

# Type checking
if [ -f "tsconfig.json" ]; then
  echo "  → Type checking..."
  npm run type-check || exit 1
fi

# Build test
if [ -f "package.json" ]; then
  echo "  → Testing build..."
  npm run build --if-present || exit 1
fi
```

---

### DevOps / CI-CD

**Additional templates needed:**
- GitLab CI validation
- Pipeline testing
- Automation script validation

**Example pre-commit additions:**
```bash
# Add to pre-commit-hook.sh

# Validate GitLab CI
if [ -f ".gitlab-ci.yml" ]; then
  echo "  → Validating GitLab CI..."
  gitlab-ci-lint .gitlab-ci.yml || exit 1
fi

# Validate bash scripts
find scripts/ -name "*.sh" | while read -r script; do
  echo "  → Checking: $script"
  shellcheck "$script" || exit 1
done
```

---

## Customization Guidelines

### 1. Start Minimal

**Don't:** Copy all templates and enable all validations on day 1
**Do:** Start with pre-commit hook only, add others as needed

**Why:** Reduce cognitive load, learn incrementally

---

### 2. Adjust for Speed

**Don't:** Run full test suite on every commit (too slow)
**Do:** Fast syntax checks on commit, full tests on push

**Why:** Pre-commit should be <5 seconds, pre-push <2 minutes

---

### 3. Make It Skippable

**Don't:** Force validation with no escape hatch
**Do:** Allow `SKIP_VALIDATION=1 git commit` for emergencies

**Why:** Sometimes you need to bypass (doc changes, WIP commits)

---

### 4. Document Locally

**Don't:** Assume others know what hooks do
**Do:** Create `.claude/README.md` explaining the setup

**Why:** Future you (or teammates) will thank you

---

## Template Maintenance

### When to Update Templates

1. **New validation tool available** - Add to pre-commit
2. **Pattern proven in production** - Extract to template
3. **Security improvement needed** - Update immediately
4. **Domain-specific need arises** - Create specialized variant

### How to Contribute Template Improvements

1. Test change in your repository (validate it works)
2. Document the improvement (why it's better)
3. Submit PR with before/after comparison
4. Include usage instructions

---

## Related Documentation

- [Production Workflows](../production-workflows/README.md) - How to use these templates
- [Claude Code Reference](../reference/claude-code/README.md) - .claude/ system architecture
- [Validation Gates (Factor IV)](../../factors/04-validation-gates.md) - Theory behind validation

---

## Version History

**v1.0.0** (2025-11-09)
- Initial template collection
- Pre-commit hook (universal)
- Claude Code settings
- Container test script

---

**Copy. Customize. Validate. Ship with confidence.**

**That's 12-Factor AgentOps in practice.**
