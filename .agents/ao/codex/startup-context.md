# Codex Startup Context

- Runtime: codex
- Lifecycle mode: codex-hookless-fallback
- Thread: Update doctrine with operator model
- Query: Update doctrine with operator model

## Briefings
- No recent knowledge briefing surfaced. Build one with `ao knowledge brief --goal "Update doctrine with operator model"` when workspace builders are available.

## Selected Context
The sections below favor stable operator surfaces and canonical runtime artifacts before recency-heavy history.

### Relevant Next Work
- [MEDIUM] Add target_repo field to next-work.jsonl schema - Evolve loop had to manually distinguish repo-relevant items from cross-repo process improvements. Adding a target_repo field enables automatic filtering.
- [LOW] Extend no-stale-framing GOALS.yaml check to SVGs - The no-stale-framing goal only checks factors/ docs/ README.md CONTRIBUTING.md. SVGs in docs/assets/ containing old factor names were missed until manual sweep ...
- [LOW] Add cycle-0 comprehensive sweep to evolve skill - Before consuming harvested work, run a full-repo scan to discover items the harvest missed. The SVG old names were found by manual sweep, not by the harvest system.


## Excluded By Default
- Discovery outputs stay out of default runtime injection until promoted into higher-trust artifacts.
- Pending knowledge remains extraction-only until it is promoted or curated.
- Raw transcripts remain lookup-only because they are noisy and too large for default runtime context.
- Topic packets remain experimental and require packet-health review before default startup injection.
- Source manifests remain experimental and do not enter default runtime payloads.
- Promoted packets remain experimental until packet health and rollout metrics stabilize.
