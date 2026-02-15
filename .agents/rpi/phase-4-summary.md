# Phase 4 Summary: Crank (v3 docs rewrite)

**Epic:** 12-pr7 (v3 Documentation Full Rewrite)
**Status:** DONE (recovered from context explosion)

## What Happened
- /crank spawned parallel agents for issues 12-pr7.1 through 12-pr7.14
- All agents completed their file edits successfully
- Context exploded: agents returned full results into orchestrator context
- "Prompt is too long" errors prevented close-out (bd close, git commit)
- Session exited with all work done but nothing committed or closed

## Recovery (this session)
- Ran conformance checks: stale framing PASS, old factor names PASS (remaining hits are comparison tables / historical context)
- Closed issues 12-pr7.1 through 12-pr7.14 in bulk
- Fixed broken links in docs/README.md (old factor filenames → v3 names, removed dead links)
- Issue 12-pr7.15 (CHANGELOG + link verification) handled inline

## Root Cause Filed
- `ag-o294` in agentops: "Subagents must write results to files, not return in context"
- Fix: agents write to file, return only signal. Orchestrator reads on-demand.

## Files Modified
40+ files across docs/, factors/, marketplace/, CONTRIBUTING.md, and SVG assets.
