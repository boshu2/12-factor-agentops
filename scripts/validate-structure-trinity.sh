#!/bin/bash
# Trinity Repository Structure Validation Script
# Works for all 3 Trinity repos: 12-factor-agentops, agentops, agentops-showcase
# Enforces: ONLY 8 files allowed in root, ALL docs go in docs/

set -e

ERRORS=0
WARNINGS=0

echo "🔍 Validating Trinity repository structure..."
echo "   Standard: TRINITY-REPO-STANDARDS.md v1.0.0"
echo ""

# Detect which Trinity repo we're in
REPO_NAME=$(basename "$(pwd)")
case "$REPO_NAME" in
  "12-factor-agentops"|"agentops"|"agentops-showcase")
    echo "📦 Repository: $REPO_NAME"
    ;;
  *)
    echo "⚠️  Warning: Not in a known Trinity repository"
    echo "   This script is designed for: 12-factor-agentops, agentops, agentops-showcase"
    echo "   Current directory: $(pwd)"
    echo ""
    ;;
esac

echo ""

# ============================================================================
# RULE #1: Only 8 files allowed in root (STRICT)
# ============================================================================

echo "📋 Checking root files (Rule #1: Only 8 allowed)..."

# Required root files (must exist)
required_root=(
  "README.md"
  "LICENSE"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "SECURITY.md"
  "CHANGELOG.md"
  "VERSION"
  "Makefile"
  "CLAUDE.md"
)

# Check required files exist
echo "  Checking required files..."
for file in "${required_root[@]}"; do
  if [ ! -f "$file" ]; then
    echo "  ❌ Missing required file: $file"
    ((ERRORS++))
  else
    echo "  ✅ $file"
  fi
done

echo ""

# Check for ANY markdown files not in the allowed list
echo "  Checking for stray markdown files (STRICT)..."
# Additional allowed markdown in root (beyond required)
allowed_root_md=("CONSTITUTION.md")
echo "  Required: README.md LICENSE CONTRIBUTING.md CODE_OF_CONDUCT.md SECURITY.md CHANGELOG.md VERSION Makefile CLAUDE.md"
echo "  Also allowed: ${allowed_root_md[@]}"
echo ""

stray_found=0
shopt -s nullglob
for md in *.md; do
  # Check if this markdown file is allowed (required or optional)
  if [[ ! " ${required_root[@]} " =~ " ${md} " ]] && [[ ! " ${allowed_root_md[@]} " =~ " ${md} " ]]; then
    echo "  ❌ VIOLATION: $md"
    echo "     → Must move to docs/ subdirectory"
    echo "     → See: docs/operations/TRINITY-REPO-STANDARDS.md"
    ((ERRORS++))
    stray_found=1
  fi
done
shopt -u nullglob

if [ $stray_found -eq 0 ]; then
  echo "  ✅ No stray markdown files in root"
fi

echo ""

# ============================================================================
# RULE #2: Required directories
# ============================================================================

echo "📁 Checking required directories (Rule #2)..."

# All Trinity repos must have these
required_dirs=(
  "docs"
  "scripts"
)

# Repo-specific directories
case "$REPO_NAME" in
  "12-factor-agentops")
    required_dirs+=("foundations" "patterns" "product" "specs")
    ;;
  "agentops")
    required_dirs+=("core" "profiles")
    ;;
  "agentops-showcase")
    required_dirs+=("src")
    ;;
esac

for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "  ❌ Missing required directory: $dir/"
    ((ERRORS++))
  else
    echo "  ✅ $dir/"
  fi
done

echo ""

# ============================================================================
# RULE #3: docs/ structure
# ============================================================================

echo "📚 Checking docs/ structure..."

# Standard docs structure (all Trinity repos)
required_docs_dirs=(
  "docs/architecture"
  "docs/development"
  "docs/operations"
  "docs/project"
  "docs/reference"
  "docs/specification"
)

# Optional but recommended
optional_docs_dirs=(
  "docs/guides"
)

echo "  Required subdirectories:"
for dir in "${required_docs_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "  ❌ Missing: $dir/"
    echo "     Create with: mkdir -p $dir"
    ((ERRORS++))
  else
    echo "  ✅ $dir/"
  fi
done

echo ""
echo "  Optional subdirectories:"
for dir in "${optional_docs_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "  ⚠️  Not found: $dir/ (recommended but optional)"
    ((WARNINGS++))
  else
    echo "  ✅ $dir/"
  fi
done

# Check docs README exists
echo ""
echo "  Checking docs index:"
if [ ! -f "docs/README.md" ]; then
  echo "  ❌ Missing: docs/README.md (index required)"
  ((ERRORS++))
else
  echo "  ✅ docs/README.md"
fi

echo ""

# ============================================================================
# RULE #4: Validation scripts
# ============================================================================

echo "🔧 Checking validation scripts..."

required_scripts=(
  "scripts/validate.sh"
  "scripts/validate-structure.sh"
  "scripts/validate-doc-links.sh"
)

# Trinity-specific validation
if [ "$REPO_NAME" != "agentops-showcase" ]; then
  required_scripts+=("scripts/validate-trinity.sh")
fi

for script in "${required_scripts[@]}"; do
  if [ ! -f "$script" ]; then
    echo "  ❌ Missing script: $script"
    ((ERRORS++))
  else
    # Check if executable
    if [ ! -x "$script" ]; then
      echo "  ⚠️  Script not executable: $script"
      echo "     Fix with: chmod +x $script"
      ((WARNINGS++))
    else
      echo "  ✅ $script"
    fi
  fi
done

echo ""

# ============================================================================
# RULE #5: AI Agent instructions
# ============================================================================

echo "🤖 Checking AI agent instructions..."

if [ -f "docs/development/CLAUDE.md" ]; then
  # Check if it references the Trinity standards
  if grep -q "TRINITY-REPO-STANDARDS" docs/development/CLAUDE.md; then
    echo "  ✅ docs/development/CLAUDE.md (references Trinity standards)"
  else
    echo "  ⚠️  docs/development/CLAUDE.md exists but doesn't reference Trinity standards"
    echo "     Add link to: docs/operations/TRINITY-REPO-STANDARDS.md"
    ((WARNINGS++))
  fi
else
  echo "  ⚠️  Missing: docs/development/CLAUDE.md (AI agent instructions)"
  echo "     AI agents won't know the rules without this file"
  ((WARNINGS++))
fi

echo ""

# ============================================================================
# Summary
# ============================================================================

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Trinity Structure Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "❌ Structure validation FAILED"
  echo ""
  echo "   Repository: $REPO_NAME"
  echo "   Errors: $ERRORS"
  echo "   Warnings: $WARNINGS"
  echo ""
  echo "🚨 CRITICAL: Fix errors above before committing"
  echo ""
  echo "Common fixes:"
  echo "  • Move markdown files: mv FILE.md docs/subdirectory/"
  echo "  • Create missing directories: mkdir -p docs/architecture"
  echo "  • Make scripts executable: chmod +x scripts/*.sh"
  echo ""
  echo "See: docs/operations/TRINITY-REPO-STANDARDS.md"
  echo ""
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "⚠️  Structure validation PASSED with warnings"
  echo ""
  echo "   Repository: $REPO_NAME"
  echo "   Warnings: $WARNINGS"
  echo ""
  echo "Consider addressing warnings for best practices."
  echo "See: docs/operations/TRINITY-REPO-STANDARDS.md"
  echo ""
  exit 0
else
  echo "✅ Repository structure is VALID"
  echo ""
  echo "   Repository: $REPO_NAME"
  echo "   All Trinity standards enforced!"
  echo ""
  echo "🎯 Standards-Based. Documentation-Driven. Trinity-Aligned."
  echo ""
  exit 0
fi
