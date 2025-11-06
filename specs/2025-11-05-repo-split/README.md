# Spec: Repository Split (12-factor-agentops / agentops)

**Created:** 2025-11-05
**Status:** Requirements gathering

## Overview

This spec establishes a clean separation between:
- **12-factor-agentops** - Framework and documentation repository
- **agentops** - Reference implementation repository

## Problem Statement

Currently, framework principles and implementation details may be conflated or unclear. This spec defines:
- What belongs in each repository
- How they reference each other
- Migration strategy for existing content
- Maintenance boundaries

## Purpose

Create clear architectural boundaries that:
- Make the framework repository focused on principles, patterns, and documentation
- Keep implementation details, tooling, and reference code in the agentops repository
- Establish sustainable maintenance patterns for both repositories
- Enable independent evolution while maintaining coherence

## Structure

- `planning/` - Requirements, architecture decisions, and planning artifacts
  - `requirements.md` - Detailed requirements and acceptance criteria
  - `visuals/` - Diagrams, mockups, and visual aids
