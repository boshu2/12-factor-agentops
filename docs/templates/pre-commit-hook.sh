#!/bin/bash
# .git/hooks/pre-commit
# Universal pre-commit validation hook for 12-Factor AgentOps
# Factor IV: Validation Gates Before Execution

set -e

echo "🔍 Running pre-commit validation..."

# ============================================
# 1. SYNTAX VALIDATION (Domain-Specific)
# ============================================

# Platform Engineering / IaC / GitOps
if [ -f "kustomization.yaml" ] || find . -name "*.yaml" -o -name "*.yml" | grep -q .; then
  echo "  → Validating YAML syntax..."
  if command -v yamllint >/dev/null; then
    find . -name "*.yaml" -o -name "*.yml" | xargs yamllint -d relaxed || {
      echo "❌ YAML validation failed"
      exit 1
    }
  fi
fi

# Web Development
if [ -f "package.json" ]; then
  echo "  → Running linter..."
  if command -v npm >/dev/null; then
    npm run lint --if-present || {
      echo "❌ Linting failed"
      exit 1
    }
  fi
fi

# DevOps / Bash Scripts
if git diff --cached --name-only --diff-filter=ACM | grep -q '\.sh$'; then
  echo "  → Checking shell scripts..."
  if command -v shellcheck >/dev/null; then
    git diff --cached --name-only --diff-filter=ACM | grep '\.sh$' | xargs shellcheck || {
      echo "❌ Shell script validation failed"
      exit 1
    }
  fi
fi

# ============================================
# 2. SECRET DETECTION (Universal)
# ============================================

echo "  → Scanning for secrets..."
if command -v detect-secrets >/dev/null; then
  detect-secrets scan --baseline .secrets.baseline || {
    echo "❌ Secrets detected!"
    echo "   Review and add to .secrets.baseline if safe:"
    echo "   detect-secrets scan --update .secrets.baseline"
    exit 1
  }
fi

# ============================================
# 3. FORMAT CHECKING (Universal)
# ============================================

echo "  → Checking formatting..."
if command -v prettier >/dev/null; then
  git diff --cached --name-only --diff-filter=ACM | \
    grep -E '\.(yaml|yml|json|md|ts|tsx|js|jsx)$' | \
    xargs prettier --check || {
    echo "❌ Formatting issues detected"
    echo "   Fix with: prettier --write <files>"
    exit 1
  }
fi

# ============================================
# 4. DOMAIN-SPECIFIC TESTS
# ============================================

# Kustomize validation (Platform Engineering)
if command -v kustomize >/dev/null; then
  for dir in apps/*/overlays/*/; do
    if [ -d "$dir" ]; then
      echo "  → Testing kustomize build: $dir"
      kubectl kustomize "$dir" > /dev/null || {
        echo "❌ Kustomize validation failed for $dir"
        exit 1
      }
    fi
  done
fi

# TypeScript type checking (Web Development)
if [ -f "tsconfig.json" ]; then
  echo "  → Type checking..."
  npm run type-check --if-present || {
    echo "❌ Type checking failed"
    exit 1
  }
fi

echo "✅ Pre-commit validation passed"
echo ""
echo "Next: git push will trigger pre-push validation"
