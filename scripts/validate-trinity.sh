#!/usr/bin/env bash
# Trinity Validation Script
# Validates alignment across 12-factor-agentops, agentops, and agentops-showcase

set -uo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0
CHECKS=0
SUCCESSES=0

# Helper functions
error() {
    echo -e "${RED}✗ ERROR: $1${NC}"
    ((ERRORS++))
}

warn() {
    echo -e "${YELLOW}⚠ WARNING: $1${NC}"
    ((WARNINGS++))
}

success() {
    echo -e "${GREEN}✓ $1${NC}"
    ((SUCCESSES++))
}

info() {
    echo -e "ℹ $1"
}

check() {
    ((CHECKS++))
}

# Determine repository root and trinity siblings
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_NAME="$(basename "$REPO_ROOT")"

# Determine trinity repository paths based on current repo
case "$REPO_NAME" in
    "12-factor-agentops")
        PHILOSOPHY_REPO="$REPO_ROOT"
        ENGINE_REPO="$(dirname "$REPO_ROOT")/agentops"
        VOICE_REPO="$(dirname "$REPO_ROOT")/agentops-showcase"
        ;;
    "agentops")
        PHILOSOPHY_REPO="$(dirname "$REPO_ROOT")/12-factor-agentops"
        ENGINE_REPO="$REPO_ROOT"
        VOICE_REPO="$(dirname "$REPO_ROOT")/agentops-showcase"
        ;;
    "agentops-showcase")
        PHILOSOPHY_REPO="$(dirname "$REPO_ROOT")/12-factor-agentops"
        ENGINE_REPO="$(dirname "$REPO_ROOT")/agentops"
        VOICE_REPO="$REPO_ROOT"
        ;;
    *)
        error "Unknown repository: $REPO_NAME (expected 12-factor-agentops, agentops, or agentops-showcase)"
        exit 1
        ;;
esac

echo "================================================"
echo "Trinity Validation - $REPO_NAME"
echo "================================================"
echo ""

# Check 1: Repository existence
info "Checking Trinity repository existence..."
check

if [[ ! -d "$PHILOSOPHY_REPO" ]]; then
    error "Philosophy repo not found: $PHILOSOPHY_REPO"
else
    success "Philosophy repo exists: $PHILOSOPHY_REPO"
fi

if [[ ! -d "$ENGINE_REPO" ]]; then
    error "Engine repo not found: $ENGINE_REPO"
else
    success "Engine repo exists: $ENGINE_REPO"
fi

if [[ ! -d "$VOICE_REPO" ]]; then
    warn "Voice repo not found: $VOICE_REPO (optional)"
else
    success "Voice repo exists: $VOICE_REPO"
fi

echo ""

# Check 2: Universal files existence
info "Checking universal files..."
check

for repo in "$PHILOSOPHY_REPO" "$ENGINE_REPO"; do
    repo_name="$(basename "$repo")"

    if [[ ! -f "$repo/TRINITY.md" ]]; then
        error "$repo_name: TRINITY.md missing"
    else
        success "$repo_name: TRINITY.md exists"
    fi

    if [[ ! -f "$repo/VERSION" ]]; then
        error "$repo_name: VERSION missing"
    else
        success "$repo_name: VERSION exists"
    fi

    if [[ ! -f "$repo/MISSION.md" ]]; then
        error "$repo_name: MISSION.md missing"
    else
        success "$repo_name: MISSION.md exists"
    fi
done

echo ""

# Check 3: Version alignment
info "Checking version alignment..."
check

PHILOSOPHY_VERSION=""
ENGINE_VERSION=""
VOICE_VERSION=""

if [[ -f "$PHILOSOPHY_REPO/VERSION" ]]; then
    PHILOSOPHY_VERSION="$(cat "$PHILOSOPHY_REPO/VERSION" | tr -d '\n\r ')"
fi

if [[ -f "$ENGINE_REPO/VERSION" ]]; then
    ENGINE_VERSION="$(cat "$ENGINE_REPO/VERSION" | tr -d '\n\r ')"
fi

if [[ -f "$VOICE_REPO/VERSION" ]]; then
    VOICE_VERSION="$(cat "$VOICE_REPO/VERSION" | tr -d '\n\r ')"
fi

info "Philosophy version: $PHILOSOPHY_VERSION"
info "Engine version: $ENGINE_VERSION"
info "Voice version: $VOICE_VERSION"

if [[ "$PHILOSOPHY_VERSION" != "$ENGINE_VERSION" ]]; then
    error "Version mismatch: Philosophy ($PHILOSOPHY_VERSION) != Engine ($ENGINE_VERSION)"
elif [[ -n "$VOICE_VERSION" ]] && [[ "$PHILOSOPHY_VERSION" != "$VOICE_VERSION" ]]; then
    error "Version mismatch: Philosophy ($PHILOSOPHY_VERSION) != Voice ($VOICE_VERSION)"
else
    success "All versions aligned: $PHILOSOPHY_VERSION"
fi

echo ""

# Check 4: MISSION.md content consistency
info "Checking MISSION.md consistency..."
check

if [[ -f "$PHILOSOPHY_REPO/MISSION.md" ]] && [[ -f "$ENGINE_REPO/MISSION.md" ]]; then
    # Use md5 on macOS, md5sum on Linux
    if command -v md5 &> /dev/null; then
        PHILOSOPHY_MISSION_HASH="$(md5 -q "$PHILOSOPHY_REPO/MISSION.md")"
        ENGINE_MISSION_HASH="$(md5 -q "$ENGINE_REPO/MISSION.md")"
    elif command -v md5sum &> /dev/null; then
        PHILOSOPHY_MISSION_HASH="$(md5sum "$PHILOSOPHY_REPO/MISSION.md" | awk '{print $1}')"
        ENGINE_MISSION_HASH="$(md5sum "$ENGINE_REPO/MISSION.md" | awk '{print $1}')"
    else
        warn "md5/md5sum not available, skipping MISSION.md hash check"
        PHILOSOPHY_MISSION_HASH=""
        ENGINE_MISSION_HASH=""
    fi

    if [[ -n "$PHILOSOPHY_MISSION_HASH" ]] && [[ "$PHILOSOPHY_MISSION_HASH" != "$ENGINE_MISSION_HASH" ]]; then
        warn "MISSION.md content differs between Philosophy and Engine repos"
    elif [[ -n "$PHILOSOPHY_MISSION_HASH" ]]; then
        success "MISSION.md content consistent across repos"
    fi
fi

echo ""

# Check 5: Documentation structure
info "Checking documentation structure..."
check

if [[ ! -d "$PHILOSOPHY_REPO/docs/trinity" ]]; then
    error "Philosophy repo: docs/trinity/ directory missing"
else
    success "Philosophy repo: docs/trinity/ exists"

    if [[ ! -f "$PHILOSOPHY_REPO/docs/trinity/README.md" ]]; then
        warn "Philosophy repo: docs/trinity/README.md missing (cross-reference matrix)"
    else
        success "Philosophy repo: docs/trinity/README.md exists"
    fi
fi

if [[ ! -d "$ENGINE_REPO/docs/trinity" ]]; then
    error "Engine repo: docs/trinity/ directory missing"
else
    success "Engine repo: docs/trinity/ exists"

    if [[ ! -f "$ENGINE_REPO/docs/trinity/implementation-map.md" ]]; then
        warn "Engine repo: docs/trinity/implementation-map.md missing"
    else
        success "Engine repo: docs/trinity/implementation-map.md exists"
    fi
fi

echo ""

# Check 6: Git repository status
info "Checking git status..."
check

for repo in "$PHILOSOPHY_REPO" "$ENGINE_REPO"; do
    repo_name="$(basename "$repo")"

    if [[ ! -d "$repo/.git" ]]; then
        warn "$repo_name: Not a git repository"
    else
        # Check for uncommitted trinity files
        cd "$repo"
        if git status --porcelain 2>/dev/null | grep -E "(TRINITY.md|VERSION|MISSION.md|docs/trinity)" > /dev/null 2>&1; then
            warn "$repo_name: Uncommitted Trinity files detected"
        else
            success "$repo_name: All Trinity files committed"
        fi
    fi
done

echo ""

# Summary
echo "================================================"
echo "Validation Summary"
echo "================================================"
echo "Total checks: $CHECKS"
echo -e "${GREEN}Successes: $SUCCESSES${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
echo -e "${RED}Errors: $ERRORS${NC}"
echo ""

if [[ $ERRORS -gt 0 ]]; then
    echo -e "${RED}❌ Trinity validation FAILED${NC}"
    exit 1
elif [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}⚠️  Trinity validation passed with warnings${NC}"
    exit 0
else
    echo -e "${GREEN}✅ Trinity validation PASSED${NC}"
    exit 0
fi
