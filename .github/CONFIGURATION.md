# GitHub Configuration

This directory contains GitHub-specific configuration for the 12-factor-agentops repository.

## Structure

- `workflows/` - GitHub Actions CI/CD workflows
- `ISSUE_TEMPLATE/` - Issue templates for bug reports and feature requests

## Workflows

GitHub Actions workflows for automated validation and deployment.

### Validation Workflow

Recommended workflow to add:

```yaml
name: Validate Repository

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  validate:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Validate Repository Structure
      run: make validate-structure

    - name: Validate Documentation Links
      run: make validate-docs

    - name: Validate Trinity Alignment
      run: make trinity-validate
```

## Issue Templates

Templates help standardize issue reporting for better triaging and resolution.

Recommended templates:
- Bug report
- Feature request
- Documentation improvement
- Trinity synchronization

## Pull Request Template

Consider adding `.github/PULL_REQUEST_TEMPLATE.md` for consistent PR descriptions.
