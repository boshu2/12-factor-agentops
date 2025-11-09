#!/bin/bash
# Repository Structure Validation Script
# Ensures 12-factor-agentops follows open source standards

set -e

ERRORS=0
WARNINGS=0

echo "🔍 Validating repository structure..."
echo ""

# Check required root files
echo "📋 Checking required root files..."
required_root=(
  "README.md"
  "LICENSE"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "SECURITY.md"
  "CHANGELOG.md"
  "TRINITY.md"
  "MISSION.md"
  "VERSION"
)

for file in "${required_root[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Missing required file: $file"
    ((ERRORS++))
  else
    echo "✅ $file"
  fi
done

echo ""

# Check no stray markdown in root (except allowed)
echo "📄 Checking for stray markdown files in root..."
allowed_root_md=(
  "README.md"
  "CONTRIBUTING.md"
  "CODE_OF_CONDUCT.md"
  "SECURITY.md"
  "CHANGELOG.md"
  "TRINITY.md"
  "MISSION.md"
  "NAVIGATION.md"
  "CLAUDE.md"
  "ANALYSIS_INDEX.md"
  "ECOSYSTEM_POSITIONING.md"
  "EARLY_TESTER_GUIDE.md"
  "REPOSITORY_STRUCTURE_ANALYSIS.md"
  "STRUCTURE_SUMMARY.txt"
  "V1_RELEASE_NOTES.md"
)

stray_found=0
for md in *.md *.txt; do
  # Skip if no files found
  [ "$md" = "*.md" ] && continue
  [ "$md" = "*.txt" ] && continue

  if [[ ! " ${allowed_root_md[@]} " =~ " ${md} " ]]; then
    echo "⚠️  Markdown/text file in root (consider docs/): $md"
    ((WARNINGS++))
    stray_found=1
  fi
done

if [ $stray_found -eq 0 ]; then
  echo "✅ No unexpected files in root"
fi

echo ""

# Check required directories
echo "📁 Checking required directories..."
required_dirs=(
  "docs"
  "foundations"
  "patterns"
  "profiles"
  "scripts"
)

for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "❌ Missing required directory: $dir"
    ((ERRORS++))
  else
    echo "✅ $dir/"
  fi
done

echo ""

# Check docs structure
echo "📚 Checking docs/ structure..."
required_docs_dirs=(
  "docs/trinity"
)

for dir in "${required_docs_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "❌ Missing docs directory: $dir"
    ((ERRORS++))
  else
    echo "✅ $dir/"
  fi
done

# Check docs README exists
if [ ! -f "docs/README.md" ]; then
  echo "⚠️  Missing docs/README.md index (recommended)"
  ((WARNINGS++))
else
  echo "✅ docs/README.md"
fi

# Check Trinity cross-reference
if [ ! -f "docs/trinity/README.md" ]; then
  echo "❌ Missing docs/trinity/README.md (required for Trinity)"
  ((ERRORS++))
else
  echo "✅ docs/trinity/README.md"
fi

echo ""

# Check .github structure
echo "🔧 Checking .github/ structure..."
required_github_dirs=(
  ".github/workflows"
  ".github/ISSUE_TEMPLATE"
)

for dir in "${required_github_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "⚠️  Missing .github directory: $dir (optional but recommended)"
    ((WARNINGS++))
  else
    echo "✅ $dir/"
  fi
done

echo ""

# Check Trinity-specific files
echo "🔱 Checking Trinity files..."
trinity_files=(
  "TRINITY.md"
  "MISSION.md"
  "VERSION"
)

for file in "${trinity_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Missing Trinity file: $file"
    ((ERRORS++))
  else
    echo "✅ $file"
  fi
done

echo ""

# Check foundations structure
echo "🏛️ Checking foundations/ structure..."
if [ -d "foundations" ]; then
  if [ -f "foundations/README.md" ]; then
    echo "✅ foundations/README.md"
  else
    echo "⚠️  Missing foundations/README.md index"
    ((WARNINGS++))
  fi

  # Count foundation documents
  foundation_count=$(find foundations -name "*.md" -not -name "README.md" | wc -l)
  echo "ℹ️  Found $foundation_count foundation documents"
fi

echo ""

# Check patterns structure
echo "🎨 Checking patterns/ structure..."
if [ -d "patterns" ]; then
  if [ -f "patterns/README.md" ]; then
    echo "✅ patterns/README.md"
  else
    echo "⚠️  Missing patterns/README.md index"
    ((WARNINGS++))
  fi

  # Count pattern documents
  pattern_count=$(find patterns -name "*.md" -not -name "README.md" | wc -l)
  echo "ℹ️  Found $pattern_count pattern documents"
fi

echo ""

# Check profiles structure
echo "👤 Checking profiles/ structure..."
if [ -d "profiles" ]; then
  # Count profile directories
  profile_count=$(find profiles -maxdepth 1 -type d | tail -n +2 | wc -l)
  echo "ℹ️  Found $profile_count profiles"

  # Check for YAML profile files
  for profile_dir in profiles/*/; do
    if [ -f "${profile_dir}profile.yaml" ] || [ -f "${profile_dir}profile.yml" ]; then
      echo "✅ $(basename "$profile_dir")/profile.yaml"
    else
      echo "⚠️  Missing profile.yaml in $(basename "$profile_dir")"
      ((WARNINGS++))
    fi
  done
fi

echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "❌ Structure validation FAILED"
  echo "   Errors: $ERRORS"
  echo "   Warnings: $WARNINGS"
  echo ""
  echo "Fix errors above and re-run validation."
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "⚠️  Structure validation PASSED with warnings"
  echo "   Warnings: $WARNINGS"
  echo ""
  echo "Consider addressing warnings for best practices."
  exit 0
else
  echo "✅ Repository structure is VALID"
  echo "   All checks passed!"
  exit 0
fi
