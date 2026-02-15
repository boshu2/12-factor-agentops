# Factor Mapping: v1 → v3

| Old # | Old Title | New # | New Title | Disposition | Notes |
|-------|-----------|-------|-----------|-------------|-------|
| 01 | Automated Tracking | 02 | Track Everything in Git | rewrite | Old focus: automated issue tracking. New focus: git as single source of truth for all artifacts. |
| 02 | Context Loading | 01 | Context Is Everything | merge | 870 lines. Core content (40% rule, observable symptoms, cognitive load research, "lost in the middle") migrates to new Factor I. Sub-agent deep-dive and HumanLayer attribution stay archived (Phase 2 tutorial material). Factor I capped at 600 lines. |
| 03 | Focused Agents | 03 | One Agent, One Job | rewrite | Concept preserved (scoped agents). New framing: fresh context per task, never reuse saturated windows. |
| 04 | Continuous Validation | 05 | Validate Externally | rewrite | Old focus: continuous validation pipeline. New focus: no agent grades its own work, external validation always. |
| 05 | Measure Everything | 09 | Measure What Matters | rewrite | Old focus: measure all metrics. New focus: fitness toward goals, not vanity metrics. Dormancy is success. |
| 06 | Resume Work | — | (archived) | split | Session resumption content partially absorbed by Factor II (git tracking) and Factor VII (extraction). No direct 1:1 mapping. |
| 07 | Smart Routing | — | (archived) | split | Multi-agent routing content absorbed by Factor X (worker isolation) and Factor XI (hierarchical supervision). |
| 08 | Human Validation | 05 | Validate Externally | merge | Human-in-the-loop validation merged with automated external validation into unified Factor V. |
| 09 | Mine Patterns | 07 | Extract Learnings | rewrite | Old focus: pattern mining. New focus: deliberate extraction of learnings, decisions, and dead ends from every session. |
| 10 | Small Iterations | 06 | Lock Progress Forward | rewrite | Old focus: small iteration cycles. New focus: Brownian Ratchet pattern — validated work is permanent. |
| 11 | Fail-Safe Checks | 12 | Harvest Failures as Wisdom | rewrite | Old focus: safety checks. New focus: failures as data — extract and index with same rigor as successes. |
| 12 | Package Patterns | 08 | Compound Knowledge | rewrite | Old focus: packaging reusable patterns. New focus: automated knowledge flywheel (extract → gate → decay → inject). THE hero factor. |
| — | (new) | 04 | Research Before You Build | new | Entirely new factor. Research as distinct phase producing findings, not code. |
| — | (new) | 10 | Isolate Workers | new | Entirely new factor (Scale tier). Worker isolation via worktrees, fresh context. Draws from Olympus/Gas Town patterns. |
| — | (new) | 11 | Supervise Hierarchically | new | Entirely new factor (Scale tier). Erlang-style supervision trees. Draws from Olympus/Gas Town patterns. |
