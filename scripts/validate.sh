#!/bin/bash
# Master Validation Script for 12-factor-agentops
# Runs all validation checks before committing/pushing

set -e  # Exit on any error

echo "🔍 Running validation for 12-factor-agentops (Philosophy Layer)..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track overall success
FAILED=0

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
        FAILED=1
    fi
}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

# Check 1: Repository Structure
echo "📋 Validating repository structure..."
if bash "$SCRIPT_DIR/validate-structure.sh"; then
    print_status 0 "Repository structure valid"
else
    print_status 1 "Repository structure validation failed"
fi
echo ""

# Check 2: Documentation Links
echo "🔗 Validating documentation links..."
if bash "$SCRIPT_DIR/validate-doc-links.sh"; then
    print_status 0 "Documentation links valid"
else
    print_status 1 "Documentation links validation failed"
fi
echo ""

# Check 3: Trinity Alignment
echo "🔱 Validating Trinity alignment..."
if bash "$SCRIPT_DIR/validate-trinity.sh"; then
    print_status 0 "Trinity alignment valid"
else
    print_status 1 "Trinity alignment validation failed"
fi
echo ""

# Check 4: Required Files Content
echo "📄 Checking required files have content..."

check_file_not_empty() {
    if [ -f "$1" ] && [ -s "$1" ]; then
        print_status 0 "$1 exists and has content"
        return 0
    else
        print_status 1 "$1 missing or empty"
        return 1
    fi
}

check_file_not_empty "README.md"
check_file_not_empty "CONTRIBUTING.md"
check_file_not_empty "LICENSE"
check_file_not_empty "TRINITY.md"
check_file_not_empty "MISSION.md"
check_file_not_empty "VERSION"

echo ""

# Check 5: Markdown Formatting Issues
echo "✍️  Checking for common markdown issues..."

# Check for trailing whitespace in markdown files
TRAILING_WS=$(find . -name "*.md" \
  -not -path "./node_modules/*" \
  -not -path "./.git/*" \
  -exec grep -l ' $' {} \; 2>/dev/null | wc -l || true)

if [ "$TRAILING_WS" -gt 0 ]; then
    echo -e "${YELLOW}⚠${NC} Warning: Found $TRAILING_WS markdown files with trailing whitespace"
else
    print_status 0 "No trailing whitespace in markdown files"
fi

# Check for TODO comments
TODO_COUNT=$(grep -r "TODO:" --include="*.md" --include="*.sh" . 2>/dev/null | grep -v ".git" | wc -l || true)
if [ "$TODO_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}⚠${NC} Warning: Found $TODO_COUNT TODO comments"
else
    print_status 0 "No TODO comments found"
fi

echo ""

# Check 6: Version Consistency
echo "🔢 Checking version consistency..."
if [ -f "VERSION" ]; then
    VERSION_CONTENT=$(cat VERSION | tr -d '\n\r ')

    # Check if version is in README
    if grep -q "$VERSION_CONTENT" README.md 2>/dev/null; then
        print_status 0 "Version $VERSION_CONTENT found in README.md"
    else
        echo -e "${YELLOW}⚠${NC} Warning: Version $VERSION_CONTENT not found in README.md"
    fi

    # Check if version is in CHANGELOG
    if grep -q "$VERSION_CONTENT" CHANGELOG.md 2>/dev/null; then
        print_status 0 "Version $VERSION_CONTENT found in CHANGELOG.md"
    else
        echo -e "${YELLOW}⚠${NC} Warning: Version $VERSION_CONTENT not found in CHANGELOG.md"
    fi
else
    print_status 1 "VERSION file missing"
fi

echo ""

# Final result
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ All validation checks passed!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "12-factor-agentops (Philosophy Layer) is ready!"
    echo ""
    echo "Ready to commit and push!"
    exit 0
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}✗ Validation failed!${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Please fix the errors above before committing."
    exit 1
fi
