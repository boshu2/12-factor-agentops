#!/usr/bin/env python3
"""
Comprehensive markdown link validator for 12-factor-agentops repository.
Extracts and validates all internal and external links.
"""

import os
import re
from pathlib import Path
from typing import Dict, List, Tuple, Set
from collections import defaultdict

# Repository root
REPO_ROOT = Path("/home/user/12-factor-agentops")

# All markdown files to check
MD_FILES = [
    "AUDIT_REPORT.md",
    "CONTRIBUTING.md",
    "CODE_OF_CONDUCT.md",
    "CLAUDE.md",
    "README.md",
    "docs/README.md",
    "docs/advanced/intelligent-routing.md",
    "docs/advanced/context-bundles.md",
    "docs/advanced/README.md",
    "docs/advanced/phase-based-workflow.md",
    "docs/advanced/multi-agent-orchestration.md",
    "docs/assets/README.md",
    "docs/case-studies/production/README.md",
    "docs/domain-guides/README.md",
    "docs/case-studies/production/metrics.md",
    "docs/case-studies/production/factor-mapping.md",
    "docs/domain-guides/software-development.md",
    "docs/domain-guides/data-science-analytics.md",
    "docs/domain-guides/devops-infrastructure.md",
    "docs/principles/README.md",
    "docs/principles/comparison-table.md",
    "docs/domain-guides/solo-developer.md",
    "docs/principles/five-laws.md",
    "docs/principles/evolution-of-12-factor.md",
    "docs/principles/context-engineering.md",
    "docs/principles/knowledge-os.md",
    "docs/principles/four-pillars.md",
    "docs/research/validation/SYNTHESIS.md",
    "docs/tutorials/workflow-guide.md",
    "factors/03-focused-agents.md",
    "factors/02-context-loading.md",
    "factors/01-automated-tracking.md",
    "factors/05-measure-everything.md",
    "factors/04-continuous-validation.md",
    "factors/07-smart-routing.md",
    "factors/08-human-validation.md",
    "factors/06-resume-work.md",
    "factors/11-fail-safe-checks.md",
    "factors/10-small-iterations.md",
    "factors/09-mine-patterns.md",
    "factors/README.md",
    "factors/12-package-patterns.md"
]

# Regex patterns for link extraction
MARKDOWN_LINK_PATTERN = r'\[([^\]]+)\]\(([^)]+)\)'
ANCHOR_PATTERN = r'#([a-zA-Z0-9_-]+)'

class LinkValidator:
    def __init__(self):
        self.all_links = defaultdict(list)
        self.broken_links = []
        self.total_links = 0
        self.internal_file_links = 0
        self.internal_anchor_links = 0
        self.external_links = 0

    def extract_links_from_file(self, file_path: Path) -> List[Tuple[str, str, int]]:
        """Extract all markdown links from a file."""
        links = []
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                for line_num, line in enumerate(content.split('\n'), 1):
                    matches = re.findall(MARKDOWN_LINK_PATTERN, line)
                    for link_text, link_target in matches:
                        links.append((link_text, link_target, line_num))
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
        return links

    def categorize_link(self, link_target: str) -> str:
        """Categorize link as internal file, internal anchor, or external URL."""
        if link_target.startswith('http://') or link_target.startswith('https://'):
            return 'external'
        elif '#' in link_target:
            return 'anchor'
        else:
            return 'file'

    def resolve_relative_path(self, source_file: Path, target_path: str) -> Path:
        """Resolve relative path from source file to target."""
        source_dir = source_file.parent
        # Remove anchor if present
        if '#' in target_path:
            target_path = target_path.split('#')[0]

        # Handle empty path (anchor only in same file)
        if not target_path:
            return source_file

        # Resolve relative path
        resolved = (source_dir / target_path).resolve()
        return resolved

    def file_exists(self, file_path: Path) -> bool:
        """Check if file exists."""
        return file_path.exists() and file_path.is_file()

    def extract_anchors_from_file(self, file_path: Path) -> Set[str]:
        """Extract all heading anchors from a markdown file."""
        anchors = set()
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                # Find all markdown headings
                heading_pattern = r'^#{1,6}\s+(.+)$'
                for line in content.split('\n'):
                    match = re.match(heading_pattern, line)
                    if match:
                        heading_text = match.group(1)
                        # Convert heading to anchor format
                        # Remove special characters, convert spaces to hyphens, lowercase
                        anchor = re.sub(r'[^a-zA-Z0-9\s-]', '', heading_text)
                        anchor = anchor.strip().replace(' ', '-').lower()
                        anchors.add(anchor)
        except Exception as e:
            print(f"Error extracting anchors from {file_path}: {e}")
        return anchors

    def validate_anchor_link(self, source_file: Path, link_target: str) -> Tuple[bool, str]:
        """Validate an internal anchor link."""
        if '#' not in link_target:
            return True, "Not an anchor link"

        # Split file path and anchor
        if link_target.startswith('#'):
            # Anchor in same file
            target_file = source_file
            anchor = link_target[1:]
        else:
            parts = link_target.split('#')
            file_part = parts[0]
            anchor = parts[1] if len(parts) > 1 else ''
            target_file = self.resolve_relative_path(source_file, file_part)

        # Check if file exists
        if not self.file_exists(target_file):
            return False, f"Target file does not exist: {target_file}"

        # Extract anchors from target file
        anchors = self.extract_anchors_from_file(target_file)

        # Check if anchor exists
        if anchor and anchor not in anchors:
            return False, f"Anchor '{anchor}' not found in {target_file.name}"

        return True, "OK"

    def validate_external_url(self, url: str) -> Tuple[bool, str]:
        """Validate external URL formatting."""
        if url.startswith('http://') or url.startswith('https://'):
            return True, "OK"
        else:
            return False, "External URL must start with http:// or https://"

    def validate_all_links(self):
        """Main validation function."""
        print("="*80)
        print("MARKDOWN LINK VALIDATION REPORT")
        print("="*80)
        print()

        # Extract links from all files
        for md_file in MD_FILES:
            file_path = REPO_ROOT / md_file
            if not file_path.exists():
                print(f"WARNING: File not found: {file_path}")
                continue

            links = self.extract_links_from_file(file_path)
            self.all_links[md_file] = links

        # Validate each link
        for source_file_str, links in self.all_links.items():
            source_file = REPO_ROOT / source_file_str

            for link_text, link_target, line_num in links:
                self.total_links += 1
                link_type = self.categorize_link(link_target)

                is_valid = True
                error_msg = ""

                if link_type == 'external':
                    self.external_links += 1
                    is_valid, error_msg = self.validate_external_url(link_target)

                elif link_type == 'anchor':
                    self.internal_anchor_links += 1
                    is_valid, error_msg = self.validate_anchor_link(source_file, link_target)

                elif link_type == 'file':
                    self.internal_file_links += 1
                    target_path = self.resolve_relative_path(source_file, link_target)
                    if not self.file_exists(target_path):
                        is_valid = False
                        error_msg = f"File does not exist: {target_path}"

                if not is_valid:
                    self.broken_links.append({
                        'source_file': source_file_str,
                        'line_number': line_num,
                        'link_text': link_text,
                        'link_target': link_target,
                        'link_type': link_type,
                        'error': error_msg
                    })

        # Print summary
        self.print_summary()

        # Print broken links
        self.print_broken_links()

        # Print file summary
        self.print_file_summary()

    def print_summary(self):
        """Print validation summary."""
        print("SUMMARY")
        print("-"*80)
        print(f"Total links checked: {self.total_links}")
        print(f"  - Internal file links: {self.internal_file_links}")
        print(f"  - Internal anchor links: {self.internal_anchor_links}")
        print(f"  - External URLs: {self.external_links}")
        print()
        print(f"Total broken links: {len(self.broken_links)}")
        print(f"  - Broken internal file links: {sum(1 for l in self.broken_links if l['link_type'] == 'file')}")
        print(f"  - Broken internal anchor links: {sum(1 for l in self.broken_links if l['link_type'] == 'anchor')}")
        print(f"  - Malformed external URLs: {sum(1 for l in self.broken_links if l['link_type'] == 'external')}")
        print()
        print("="*80)
        print()

    def print_broken_links(self):
        """Print detailed broken links report."""
        if not self.broken_links:
            print("✅ NO BROKEN LINKS FOUND!")
            print()
            return

        print("BROKEN LINKS DETAIL")
        print("-"*80)
        print()

        for i, link in enumerate(self.broken_links, 1):
            print(f"{i}. {link['source_file']} (line {link['line_number']})")
            print(f"   Link text: [{link['link_text']}]")
            print(f"   Target: {link['link_target']}")
            print(f"   Type: {link['link_type']}")
            print(f"   Error: {link['error']}")
            print()

        print("="*80)
        print()

    def print_file_summary(self):
        """Print summary grouped by file."""
        print("BROKEN LINKS BY FILE")
        print("-"*80)
        print()

        files_with_broken_links = defaultdict(list)
        for link in self.broken_links:
            files_with_broken_links[link['source_file']].append(link)

        if not files_with_broken_links:
            print("✅ No files with broken links!")
            print()
            return

        for file_path in sorted(files_with_broken_links.keys()):
            broken_in_file = files_with_broken_links[file_path]
            print(f"{file_path}: {len(broken_in_file)} broken link(s)")
            for link in broken_in_file:
                print(f"  - Line {link['line_number']}: [{link['link_text']}]({link['link_target']})")
                print(f"    Error: {link['error']}")
            print()

        print("="*80)

def main():
    validator = LinkValidator()
    validator.validate_all_links()

if __name__ == "__main__":
    main()
