#!/usr/bin/env python3
"""
Validate 12-Factor AgentOps factor documentation for compliance

This script checks factor markdown files for:
- Required sections present
- Proper structure and formatting
- Pillar and Laws references
- Anti-patterns documented
- Cross-references to other factors
"""

import re
import sys
from pathlib import Path
from typing import List, Dict, Tuple

# Required sections for factor documentation
REQUIRED_SECTIONS = [
    "Summary",
    "The Problem",
    "The Principle",
    "Why This Works",
    "Implementation",
    "Validation",
    "Real-World Evidence",
    "Anti-Patterns",
    "Relationship to Other Factors"
]

# All twelve factors
ALL_FACTORS = [
    "Git Memory as Knowledge OS",
    "Fresh Context Windows",
    "Single-Responsibility Agents",
    "Validation Gates Before Execution",
    "Operational Telemetry",
    "Session Continuity via Bundles",
    "Intelligent Task Routing",
    "Human Gate Reviews",
    "Documented Pattern Extraction",
    "Continuous Improvement Backlog",
    "Constitutional Guardrails",
    "Domain Portability"
]

# Four Pillars
PILLARS = [
    "DevOps + SRE",
    "Learning Science",
    "Context Engineering",
    "Knowledge OS"
]

# Five Laws
LAWS = [
    "Law 1",
    "Law 2",
    "Law 3",
    "Law 4",
    "Law 5"
]


def read_file(filepath: Path) -> str:
    """Read markdown file content"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"❌ Error: File not found: {filepath}")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error reading file: {e}")
        sys.exit(1)


def extract_headings(content: str) -> List[str]:
    """Extract all markdown headings from content"""
    heading_pattern = r'^#{1,6}\s+(.+)$'
    headings = re.findall(heading_pattern, content, re.MULTILINE)
    return headings


def check_required_sections(headings: List[str]) -> Tuple[List[str], List[str]]:
    """Check if all required sections are present"""
    found = []
    missing = []

    for section in REQUIRED_SECTIONS:
        # Check if section appears in headings (case-insensitive, partial match)
        if any(section.lower() in heading.lower() for heading in headings):
            found.append(section)
        else:
            missing.append(section)

    return found, missing


def check_pillar_references(content: str) -> List[str]:
    """Find references to Four Pillars"""
    found_pillars = []
    for pillar in PILLARS:
        if pillar in content:
            found_pillars.append(pillar)
    return found_pillars


def check_law_references(content: str) -> List[str]:
    """Find references to Five Laws"""
    found_laws = []
    for law in LAWS:
        if law in content:
            found_laws.append(law)
    return found_laws


def count_anti_patterns(content: str) -> int:
    """Count documented anti-patterns"""
    # Look for patterns like ❌, "Anti-pattern", "Wrong:", etc.
    anti_pattern_markers = [r'❌', r'Anti-pattern', r'\*\*Wrong\*\*:', r'Don\'t:']

    total = 0
    for marker in anti_pattern_markers:
        total += len(re.findall(marker, content, re.IGNORECASE))

    return total


def check_factor_cross_references(content: str) -> List[str]:
    """Find cross-references to other factors"""
    referenced_factors = []

    # Look for "Factor I", "Factor II", etc.
    factor_pattern = r'Factor\s+(I{1,3}|IV|VI{0,3}|IX|XI{0,2})'
    matches = re.findall(factor_pattern, content)

    for match in matches:
        referenced_factors.append(f"Factor {match}")

    return list(set(referenced_factors))  # dedupe


def check_evidence_metrics(content: str) -> bool:
    """Check if quantified evidence/metrics are present"""
    # Look for patterns like: 95%, 40x, 8x efficiency, etc.
    metrics_patterns = [
        r'\d+%',
        r'\d+x\s+\w+',
        r'\d+\s+sessions',
        r'Impact:',
        r'Result:',
        r'speedup',
        r'efficiency gain'
    ]

    for pattern in metrics_patterns:
        if re.search(pattern, content, re.IGNORECASE):
            return True

    return False


def validate_factor(filepath: Path) -> Dict:
    """Main validation function"""
    content = read_file(filepath)
    headings = extract_headings(content)

    found_sections, missing_sections = check_required_sections(headings)
    pillars = check_pillar_references(content)
    laws = check_law_references(content)
    anti_pattern_count = count_anti_patterns(content)
    cross_refs = check_factor_cross_references(content)
    has_metrics = check_evidence_metrics(content)

    return {
        'file': filepath.name,
        'sections_found': found_sections,
        'sections_missing': missing_sections,
        'pillars': pillars,
        'laws': laws,
        'anti_patterns': anti_pattern_count,
        'cross_references': cross_refs,
        'has_metrics': has_metrics
    }


def print_validation_report(result: Dict):
    """Print formatted validation report"""
    print(f"\n{'='*70}")
    print(f"  12-Factor AgentOps Validation Report")
    print(f"  File: {result['file']}")
    print(f"{'='*70}\n")

    # Structure compliance
    print("📋 **Structure Compliance**")
    sections_percent = (len(result['sections_found']) / len(REQUIRED_SECTIONS)) * 100
    print(f"   Sections: {len(result['sections_found'])}/{len(REQUIRED_SECTIONS)} ({sections_percent:.0f}%)")

    if result['sections_missing']:
        print(f"   ❌ Missing sections:")
        for section in result['sections_missing']:
            print(f"      - {section}")
    else:
        print(f"   ✅ All required sections present")
    print()

    # Pillar grounding
    print("🏛️  **Pillar Grounding**")
    if result['pillars']:
        print(f"   ✅ References {len(result['pillars'])} pillar(s):")
        for pillar in result['pillars']:
            print(f"      - {pillar}")
    else:
        print(f"   ❌ No pillar references found")
    print()

    # Laws enforcement
    print("⚖️  **Laws Enforcement**")
    if result['laws']:
        print(f"   ✅ References {len(result['laws'])} law(s):")
        for law in result['laws']:
            print(f"      - {law}")
    else:
        print(f"   ❌ No law references found")
    print()

    # Evidence and metrics
    print("📊 **Evidence & Metrics**")
    if result['has_metrics']:
        print(f"   ✅ Quantified evidence present")
    else:
        print(f"   ❌ Missing quantified metrics")
    print()

    # Anti-patterns
    print("⚠️  **Anti-Patterns**")
    if result['anti_patterns'] >= 3:
        print(f"   ✅ {result['anti_patterns']} anti-patterns documented")
    elif result['anti_patterns'] > 0:
        print(f"   ⚠️  Only {result['anti_patterns']} anti-pattern(s) documented (need 3+)")
    else:
        print(f"   ❌ No anti-patterns documented")
    print()

    # Cross-references
    print("🔗 **Cross-References**")
    if result['cross_references']:
        print(f"   ✅ References {len(result['cross_references'])} other factor(s):")
        for ref in result['cross_references']:
            print(f"      - {ref}")
    else:
        print(f"   ⚠️  No cross-references to other factors")
    print()

    # Overall compliance
    compliance_score = 0
    max_score = 6

    if len(result['sections_found']) == len(REQUIRED_SECTIONS):
        compliance_score += 1
    if result['pillars']:
        compliance_score += 1
    if result['laws']:
        compliance_score += 1
    if result['has_metrics']:
        compliance_score += 1
    if result['anti_patterns'] >= 3:
        compliance_score += 1
    if result['cross_references']:
        compliance_score += 1

    compliance_percent = (compliance_score / max_score) * 100

    print(f"{'='*70}")
    print(f"  Overall Compliance: {compliance_percent:.0f}% ({compliance_score}/{max_score})")

    if compliance_percent >= 90:
        print(f"  ✅ Excellent - Ready for production")
    elif compliance_percent >= 70:
        print(f"  ⚠️  Good - Minor improvements needed")
    else:
        print(f"  ❌ Needs Work - Significant gaps to address")

    print(f"{'='*70}\n")


def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        print("Usage: python3 validate_factor.py <path/to/factor.md>")
        print("\nExample:")
        print("  python3 validate_factor.py ../../factors/01-git-memory-as-knowledge-os.md")
        sys.exit(1)

    filepath = Path(sys.argv[1])

    if not filepath.exists():
        print(f"❌ Error: File not found: {filepath}")
        sys.exit(1)

    if not filepath.suffix == '.md':
        print(f"❌ Error: File must be a markdown file (.md)")
        sys.exit(1)

    result = validate_factor(filepath)
    print_validation_report(result)


if __name__ == "__main__":
    main()
