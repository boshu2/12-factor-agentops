#!/bin/bash
# Documentation Link Validation Script
# Validates all internal markdown links in 12-factor-agentops

set -e

ERRORS=0
WARNINGS=0

echo "🔗 Validating documentation links..."
echo ""

# Find all markdown files
find . -name "*.md" \
  -not -path "./node_modules/*" \
  -not -path "./.git/*" | sort | while read file; do

  echo "📄 Checking $file..."

  # Extract markdown links: [text](url)
  grep -o '\[.*\]([^)]*)' "$file" 2>/dev/null | grep -o '([^)]*)' | tr -d '()' | while read link; do

    # Skip empty links
    [ -z "$link" ] && continue

    # Skip external links (http/https)
    if [[ $link =~ ^https?:// ]]; then
      continue
    fi

    # Skip mailto links
    if [[ $link =~ ^mailto: ]]; then
      continue
    fi

    # Skip anchors only (#section)
    if [[ $link =~ ^# ]]; then
      continue
    fi

    # Remove anchor from link (file.md#section → file.md)
    link_without_anchor="${link%#*}"

    # Resolve relative to file location
    dir=$(dirname "$file")
    target="$dir/$link_without_anchor"

    # Normalize path (resolve ../ and ./)
    # Use Python for cross-platform path normalization
    target=$(python3 -c "import os; print(os.path.normpath('$target'))" 2>/dev/null || echo "$target")

    # Check if target exists
    if [ ! -f "$target" ] && [ ! -d "$target" ]; then
      echo "  ❌ Broken link: $link"
      echo "     Source: $file"
      echo "     Target: $target"
      ((ERRORS++))
    fi
  done
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Link Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "❌ Link validation FAILED"
  echo "   Broken links: $ERRORS"
  echo ""
  echo "Fix broken links above and re-run validation."
  exit 1
else
  echo "✅ All documentation links are VALID"
  echo "   No broken links found!"
  exit 0
fi
