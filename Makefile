# Makefile for 12-factor-agentops (Philosophy Layer)
# Part of the Trinity: Mind (Philosophy) → Engine (Orchestration) → Voice (Presentation)

.PHONY: help trinity-validate trinity-status validate-structure validate-trinity-strict validate-docs validate-all clean

# Default target
help:
	@echo "12-factor-agentops - Philosophy Layer (The Mind)"
	@echo ""
	@echo "Validation Targets:"
	@echo "  make validate-trinity-strict - Validate Trinity repo structure (STRICT)"
	@echo "  make validate-structure      - Validate repository structure"
	@echo "  make validate-docs           - Validate documentation links"
	@echo "  make validate-all            - Run all validations"
	@echo ""
	@echo "Trinity Targets:"
	@echo "  make trinity-validate  - Validate Trinity alignment across all repos"
	@echo "  make trinity-status    - Show Trinity integration status"
	@echo ""
	@echo "Utility Targets:"
	@echo "  make clean             - Clean artifacts (none for philosophy repo)"
	@echo "  make help              - Show this help message"
	@echo ""
	@echo "Part of the Trinity architecture (v2.0.0)"

# Validate Trinity repository structure (STRICT - only 8 root files allowed)
validate-trinity-strict:
	@echo "Validating Trinity repository structure (STRICT)..."
	@./scripts/validate-structure-trinity.sh

# Validate repository structure (legacy)
validate-structure:
	@echo "Validating repository structure..."
	@./scripts/validate-structure.sh

# Validate documentation links
validate-docs:
	@echo "Validating documentation links..."
	@./scripts/validate-doc-links.sh

# Run all validations (including STRICT Trinity validation)
validate-all: validate-trinity-strict validate-docs trinity-validate
	@echo ""
	@echo "✅ All validations complete!"

# Validate Trinity alignment
trinity-validate:
	@echo "Running Trinity validation..."
	@./scripts/validate-trinity.sh

# Show Trinity status
trinity-status:
	@echo "================================================"
	@echo "Trinity Integration Status"
	@echo "================================================"
	@echo ""
	@echo "Repository: 12-factor-agentops (Philosophy Layer - The Mind)"
	@echo "Role: Define WHY patterns work"
	@echo ""
	@if [ -f VERSION ]; then \
		echo "Version: $$(cat VERSION)"; \
	else \
		echo "Version: NOT SET"; \
	fi
	@echo ""
	@echo "Universal files:"
	@if [ -f TRINITY.md ]; then echo "  ✓ TRINITY.md"; else echo "  ✗ TRINITY.md"; fi
	@if [ -f VERSION ]; then echo "  ✓ VERSION"; else echo "  ✗ VERSION"; fi
	@if [ -f MISSION.md ]; then echo "  ✓ MISSION.md"; else echo "  ✗ MISSION.md"; fi
	@echo ""
	@echo "Documentation:"
	@if [ -d docs/trinity ]; then echo "  ✓ docs/trinity/"; else echo "  ✗ docs/trinity/"; fi
	@if [ -f docs/trinity/README.md ]; then echo "  ✓ docs/trinity/README.md"; else echo "  ✗ docs/trinity/README.md"; fi
	@echo ""
	@echo "Sibling repositories:"
	@if [ -d ../agentops ]; then echo "  ✓ agentops (Engine)"; else echo "  ✗ agentops (Engine) - NOT FOUND"; fi
	@if [ -d ../agentops-showcase ]; then echo "  ✓ agentops-showcase (Voice)"; else echo "  ✗ agentops-showcase (Voice) - NOT FOUND"; fi
	@echo ""
	@echo "For full validation: make trinity-validate"

# Clean build artifacts (none for philosophy repo, but included for consistency)
clean:
	@echo "Nothing to clean in philosophy repository"
