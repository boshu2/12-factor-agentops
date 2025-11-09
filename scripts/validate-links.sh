#!/bin/bash
# Link Validation Script for 12-Factor AgentOps
# Validates internal markdown links across the repository

set -e

REPO_ROOT="/Users/fullerbt/workspaces/personal/12-factor-agentops"
cd "$REPO_ROOT"

echo "=== Link Validation Report ==="
echo "Generated: $(date)"
echo "Repository: $REPO_ROOT"
echo ""

BROKEN_LINKS=0
CHECKED_FILES=0
TOTAL_LINKS=0

# Function to check if a file exists relative to the linking file
check_link() {
    local linking_file="$1"
    local link_target="$2"
    local linking_dir="$(dirname "$linking_file")"

    # Skip external links (http/https)
    if [[ "$link_target" == http* ]]; then
        return 0
    fi

    # Skip anchor-only links
    if [[ "$link_target" == \#* ]]; then
        return 0
    fi

    # Remove anchor from link
    local file_part="${link_target%%\#*}"

    # Skip empty links
    if [[ -z "$file_part" ]]; then
        return 0
    fi

    # Resolve relative path
    if [[ "$file_part" == /* ]]; then
        # Absolute path from repo root
        local resolved_path="$REPO_ROOT$file_part"
    else
        # Relative path from linking file
        local resolved_path="$linking_dir/$file_part"
    fi

    # Normalize path
    resolved_path="$(cd "$(dirname "$resolved_path")" 2>/dev/null && pwd)/$(basename "$resolved_path")" || resolved_path=""

    # Check if file exists
    if [[ ! -f "$resolved_path" ]]; then
        echo "  ❌ BROKEN: $link_target"
        echo "     In file: $linking_file"
        echo "     Resolved to: $resolved_path"
        echo ""
        ((BROKEN_LINKS++))
        return 1
    fi

    return 0
}

echo "Scanning markdown files..."
echo ""

# Find all markdown files (excluding .git and .agents)
while IFS= read -r file; do
    ((CHECKED_FILES++))

    # Extract markdown links from file
    links=$(grep -oE '\[([^\]]+)\]\(([^)]+)\)' "$file" 2>/dev/null | grep -oE '\([^)]+\)' | tr -d '()' || true)

    if [[ -n "$links" ]]; then
        file_has_broken=false

        while IFS= read -r link; do
            if [[ -n "$link" ]]; then
                ((TOTAL_LINKS++))

                if ! check_link "$file" "$link"; then
                    if [[ "$file_has_broken" == false ]]; then
                        echo "File: $file"
                        file_has_broken=true
                    fi
                fi
            fi
        done <<< "$links"

        if [[ "$file_has_broken" == true ]]; then
            echo ""
        fi
    fi
done < <(find . -name "*.md" -not -path "./.git/*" -not -path "./.agents/*" -type f)

echo "=== Summary ==="
echo "Files checked: $CHECKED_FILES"
echo "Links checked: $TOTAL_LINKS"
echo "Broken links: $BROKEN_LINKS"
echo ""

if [[ $BROKEN_LINKS -eq 0 ]]; then
    echo "✅ All internal links are valid!"
    exit 0
else
    echo "❌ Found $BROKEN_LINKS broken link(s)"
    exit 1
fi
