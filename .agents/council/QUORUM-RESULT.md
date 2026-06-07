# 12-Factor AgentOps — re-derivation quorum result

> **3-0 quorum** reached 2026-06-07 by a cross-model NTM council: **Opus 4.8** (claude),
> **Codex GPT-5.5** (codex, xhigh), **Gemini 3.5 Flash High** (antigravity/agy). Verified against
> the artifacts (`proposals/{claude,codex,gemini}.md`), not self-report. Round 1 independent →
> Round 2 converge → Round 3 resolve the single residual (measurement placement; Codex conceded
> to last). Supersedes the v3.2 patch branch — this is a re-derivation (v4.0 candidate).

## Organizing principle
A **closed operational control loop** / dependency chain: each factor earns its position because
later factors can't be trusted without it. Four phases — **Prepare → Bound → Select → Govern** —
are one pass through the loop; Govern (compounding + measurement) feeds back into Prepare.

## The 12 (agreed order + grouping)

### Prepare (I–III) — set up the environment
| # | Factor | Rule |
|---|--------|------|
| I | Context Is Everything | Manage what enters the window like what enters production. |
| II | Track Everything in Git | Durable record (or a committed reference) lives in git. |
| III | One Agent, One Job | Scoped task, fresh context per phase. |

### Bound (IV–VI) — constrain what may act
| # | Factor | Rule |
|---|--------|------|
| IV | **Enforce Least Privilege** *(new)* | Least-privilege envelope; sandbox; untrusted input can't widen it; bound the blast radius. |
| V | Research Before You Build | Understand the integration surface before changing it. |
| VI | Isolate Workers | Concurrent workers share only gated coordination state, never mutable working state. |

### Select (VII–IX) — decide what survives
| # | Factor | Rule |
|---|--------|------|
| VII | Validate Externally | Worker emits claims+evidence; an independent checker writes the binding verdict. |
| VIII | Lock Progress Forward | Validated work ratchets; regression needs an explicit recorded reversal. |
| IX | Extract Learnings | Every non-trivial session yields the work product + provenance-backed lessons (incl. failures). |

### Govern (X–XII) — steer and feed back
| # | Factor | Rule |
|---|--------|------|
| X | Compound Knowledge *(absorbs Harvest Failures)* | Gate, inject, cite, decay learnings — positive and negative — so future sessions start smarter. |
| XI | Supervise Hierarchically | One escalation path per worker; failures move up with evidence, authority flows down. |
| XII | Measure Outcomes | Track fitness toward goals, not activity; the feedback that closes the loop. |

## Changes vs the current set
- **Added IV Enforce Least Privilege** — the security/permissions gap (unanimous round 1).
- **Merged old XII Harvest Failures → X Compound Knowledge** (unanimous; negative knowledge is the same flywheel).
- **Reordered by dependency control loop**, replacing the Foundation/Flow/Knowledge/Scale adoption tiers (the "feels random" complaint).
- **Measure Outcomes → XII** (governance capstone), out of the old Knowledge tier.
- **Groups renamed** to verbs/phases: Prepare / Bound / Select / Govern.
- Accuracy fixes from the v3.2 audit carried in (no pseudo-math, invented numbers, or absolutism).

## Residual (non-blocking)
- Naming: Gemini preferred "Track Durable State"; 2-1 kept "Track Everything in Git."

## Status
Quorum is on the SET + ORDER + GROUPING. Adoption (writing v4.0 across canonical repo + showcase
+ redirects) is a separate operator decision — not yet executed.
