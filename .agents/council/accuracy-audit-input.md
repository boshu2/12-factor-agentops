# Adversarial accuracy audit of the current 12 factors (council input)

> Four independent adversarial auditors (mandate: refute, not affirm) reviewed the current
> factors. Condensed findings below. Use as evidence for the re-derivation — these are the
> known defects of the incumbent set.

## Per-factor problems
- **I Context Is Everything** — "40% utilization rule" is an invented number dressed as if it
  follows from Liu et al. (it doesn't); "lost in the middle is how attention works" stated as a
  fixed law (it's a training-dependent, shrinking empirical tendency).
- **II Track Everything in Git** — "if it's not in git it didn't happen" self-contradicted by its
  own LFS/S3 carve-outs; a `git bisect` misuse; overstates that raw git-merge handles concurrent
  structured-data edits.
- **III One Agent, One Job** — invented "50-exchange / 70%" thresholds; conflates exchange count
  with token fill; "research-warm agent is the worst to implement" overstated.
- **IV Research Before You Build** — "no exceptions / always" absolutism; unfalsifiable "every
  agent eventually does research"; unsupported "simple tasks benefit more than complex."
- **V Validate Externally** — strongest factor. "single-writer / sole writer" was overstated
  (worker can author its own gate via TDD); "the moat" claimed here AND in VIII (can't both be).
- **VI Lock Progress Forward** — OBJECTIVE BUG: cited "Factor III (Validation First)" — III is
  One-Agent-One-Job, validation is V. "agent quality doesn't matter / filter is perfect" overstated.
- **VII Extract Learnings** — clean. Genuine producer (write) half of the knowledge loop.
- **VIII Compound Knowledge** — signature inequality `retrieval × citation > decay` is
  dimensionally incoherent pseudo-math; "decays to zero" false (artifacts persist). Hero factor.
- **IX Measure What Matters** — "dormancy is success" false for continuous-ops/SRE agents;
  "harder to game" overstated (goal-redefinition games it). **Likely mis-tiered**: it's a
  governance/feedback factor, not a Knowledge factor — wedged into the Knowledge tier to fill 4×3.
- **X Isolate Workers** — "zero shared mutable state" overstated (the tracker + main ARE shared
  mutable state by design); true claim is "no shared mutable *working* state."
- **XI Supervise Hierarchically** — OBJECTIVE BUGS: "Further Reading" linked factors from a
  different framework (Dispose Gracefully / Orchestrate Declaratively); "root supervisor never
  crashes" is false about Erlang/OTP; OTP analogy misapplied (OTP restarts deterministic processes
  to a known state; agents are stochastic).
- **XII Harvest Failures as Wisdom** — likely **collapses into VIII** (it's the flywheel applied to
  negative knowledge; "prune the search space" is a metaphor, no literal tree). The genuinely
  distinct ideas (negative-knowledge value, fresh-agent-on-failure) survive but may not need a slot.

## Set-level findings
1. **Security / permissions / sandboxing / untrusted-input is absent from all 12** — the biggest
   gap. A doctrine for operating write-capable agent fleets with no permission/blast-radius/
   prompt-injection primitive. MUST be added.
2. **"12" looks padded** to Heroku's number; honest count is ~9-10. XII→VIII; IX is governance.
   (Operator decision: keep 12, but the extra slots must be real primitives — security is one.)
3. **Tiers may be post-hoc.** Foundation/Flow/Knowledge/Scale maps onto the old product partition.
   The order and grouping feel backfilled, not derived. THIS is the core thing to fix.
4. **Genuine distinctions that DO hold:** III (temporal: one agent over time) vs X (concurrent:
   many agents at once); X (independence between peers) vs XI (authority up a chain); VII (write/
   capture) vs VIII (read/inject loop). Preserve these axes if you keep these factors.

## Current grouping (the incumbent to beat)
- Foundation (I–III): Context, Track, Scope
- Flow (IV–VI): Research, Validate, Lock
- Knowledge (VII–IX): Extract, Compound, Measure
- Scale (X–XII): Isolate, Supervise, Harvest

The operator finds this grouping unprincipled. Propose a better organizing principle or defend
this one with a real argument.
