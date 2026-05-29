# Rethinking the 12 Factors From First Principles

**Date:** 2026-05-29
**Status:** Proposal. A design artifact, not an in-place rewrite. Adoption is the maintainer's call.
**Relates to:** `docs/explanation/operator-model.md`, `docs/plans/2026-02-15-pivot-design.md`, `factors/`

---

## Why redo this now

v3 is a strong doctrine. This document does not argue otherwise. It does
something the version history hasn't done explicitly: **derive the factors from
the ground up, then check whether the twelve we ship actually fall out of that
derivation** — with no gaps, no redundancy, and the right priority.

The method is deliberate. Instead of starting from the existing list and editing
it (which produces reshuffles, not rethinks), we start from the irreducible
facts about what an LLM agent *is*, ask what disciplines those facts force, and
only then lay the result next to the current twelve.

The headline finding: the derivation **validates most of v3** — which is
reassuring, because it means the factors were not arbitrary. But it also surfaces
**one redundancy** (the knowledge loop is split into three factors when it is
one machine) and **one genuine gap** (nothing covers the agent–world boundary:
authority, blast radius, reversibility). Fixing both keeps the count at twelve
while changing the content in two load-bearing places.

---

## Part 1 — The physics: six axioms

Everything below is derived from six facts. If you disagree with the factors,
disagree here first — this is where the load is.

### Axiom 1 — The actor is stateless and frozen
The model learns nothing between sessions; its weights don't update from your
work. Within a session its only memory is the context window. **Continuity
therefore cannot live in the actor.** It must live in something outside the
actor that survives session boundaries.

### Axiom 2 — Attention is finite and non-uniform
Performance degrades non-linearly with context volume, and it is position-
sensitive ("lost in the middle"). More context is not more capability past a
point; it is dilution. **Context must be curated, not accumulated.**

### Axiom 3 — The actor cannot certify itself
An LLM has no privileged access to the correctness of its own output. Its
expressed confidence is largely uncorrelated with whether it is right. **What
counts as "done" must be decided by something the actor does not control** —
reality, a test, a different actor, a human.

### Axiom 4 — Output is non-deterministic and cheap to regenerate
The same input yields different outputs; quality varies per draw; drafts are
cheap. This cuts two ways. It means you can **sample many and select the best**
(generation is sampling, and the value is created at the selection step). It
also means a later draw can be *worse* — so accepted progress must be made
**monotonic**, or regeneration will quietly undo it.

### Axiom 5 — Experience evaporates unless externalized
Anything an agent figures out in a session is gone at session end unless it is
written down and deliberately re-injected. **Improvement over time is not
automatic** — it requires an explicit extract → store → retrieve → inject loop.
Without that loop you have a flat line, not a flywheel.

### Axiom 6 — Actions have consequences, some irreversible
Agents run commands, write files, call paid APIs, touch production. The world
does not roll back like a git branch. **Autonomy without bounds is liability**,
so authority, objective, and escalation must be set explicitly from outside the
actor.

These six are the same six primitives named in `operator-model.md` (stateful
environment, replaceable actors, durable traces, selection gates, promotion
loops, governance) — but *derived* rather than asserted. That the existing
operator model survives a from-scratch derivation is itself a result: the
compression layer is sound. The open question is whether the **factor surface**
maps onto it cleanly.

---

## Part 2 — What each axiom forces

| Axiom | Disciplines it forces |
|---|---|
| 1 — stateless actor | Externalize continuity into the environment; keep actors scoped and replaceable; let a fresh actor resume from the environment |
| 2 — finite attention | Curate context just-in-time; less-but-right beats more |
| 3 — no self-certification | Ground the actor in reality *before* acting; let reality judge *after* acting |
| 4 — cheap non-determinism | Sample then select; ratchet the winner so it can't regress; isolate parallel attempts so they don't corrupt each other |
| 5 — no retention | Run one promotion loop: extract → validate → store → re-inject (successes *and* failures) |
| 6 — consequences | Bound authority and blast radius; govern by objective and stop when met; make escalation structural |

Read that column top to bottom and you have the candidate factor set, derived
without once looking at the current list.

---

## Part 3 — The derived twelve, mapped to v3

Laying the derivation next to today's factors:

| # | Derived factor | First-principles statement | v3 origin |
|---|---|---|---|
| 1 | **Externalize continuity** | State lives in the environment, never in the actor's head | II (Track Everything in Git), generalized |
| 2 | **Keep actors replaceable** | One scoped job, fresh context, designed for restart | III (One Agent, One Job) |
| 3 | **Curate context** | Load what *this* step needs, JIT and bounded | I (Context Is Everything) |
| 4 | **Ground before acting** | The actor's prior is not your reality; observe before you generate | IV (Research Before You Build), reframed |
| 5 | **Let reality judge** | Acceptance is decided outside the author — by tests, reality, another actor, a human | V (Validate Externally), reframed |
| 6 | **Sample, then select** | Chaos is cheap; the selection gate is where value is created | *new — was implicit inside VI* |
| 7 | **Ratchet progress** | The selected winner becomes irreversible; work never regresses | VI (Lock Progress Forward) |
| 8 | **Isolate parallel work** | Independent attempts must not share mutable state | X (Isolate Workers) |
| 9 | **Run one promotion loop** | extract → validate → store → re-inject; failures feed the same loop as wins | VII + VIII + XII, **fused** |
| 10 | **Bound authority & blast radius** | Least privilege; prefer reversible actions; contain damage | *new — the gap* |
| 11 | **Govern by objective** | Define fitness, steer to it, stop when met (dormancy is success) | IX (Measure What Matters), reframed as governance |
| 12 | **Make escalation structural** | Bounded retries; escalate up, never sideways; human at the top | XI (Supervise Hierarchically) |

**The net change is small in count and large in content:**

- **Collapse 3 → 1.** Extract Learnings (VII), Compound Knowledge (VIII), and
  Harvest Failures (XII) are not three principles. They are one loop with three
  well-known failure modes (you don't extract; you extract but never re-inject —
  the write-only database; you only log wins and discard failures). First
  principles name the machine once and list its failure modes; they don't
  promote each failure mode to a peer of "curate context."
- **Spend the recovered budget on what v3 under-weights.** Two slots open up.
  They go to the two disciplines the derivation insists on but the current set
  treats as afterthoughts: **selection** (Axiom 4's value-creating step) and
  **authority/blast-radius** (Axiom 6's safety boundary).

The count stays at twelve. That is convenient for the brand, but note it is an
*outcome* of the fusion-plus-two-additions, not a target we worked backward
from. See "On the number twelve" below.

---

## Part 4 — The two substantive deltas, in detail

### Delta A — Fuse the knowledge loop (VII + VIII + XII → one factor)

**Claim:** The Knowledge tier over-represents a single mechanism. Axiom 5
produces exactly one obligation — *close the extract→store→retrieve→inject loop*
— and the polarity of the signal (success vs. failure) is a property of the
inputs, not a separate principle.

Evidence from the current text itself: Factor VII ("every session produces the
work product and the lessons") and Factor XII ("failed attempts are data,
indexed with the same rigor as successes") describe the *same act* of extraction
on opposite signs. Factor VIII is the re-injection half of the same loop. The
`operator-model.md` crosswalk already routes VII and XII to the same primitive
(promotion loops) — the model knows they're one thing; the factor surface
hasn't caught up.

**Why it was split, steelmanned:** Teams reliably fail at this loop in three
distinct places, and naming each place separately creates accountability. Most
people extract nothing; of those who extract, most never re-inject; almost
nobody captures failures. Three factors put a spotlight on each weak point.

**Resolution:** Keep the spotlight, drop the inflation. One factor — "Run one
promotion loop" — with its three failure modes called out explicitly as
sub-points. You lose nothing pedagogically and you stop implying the loop is
half the doctrine (it is currently 3 of 12, and Factor VIII is even labelled
"the hero"). Compounding is the differentiator; it does not need three of twelve
slots to be the differentiator.

### Delta B — Add "Bound authority & blast radius" (the gap)

**Claim:** Axiom 6 forces a discipline the current twelve do not contain. Today's
set covers *measuring* toward the objective (IX) and *escalation* structure
(XI), but nothing says: **what is the agent allowed to do, how reversible is it,
and how large is the blast radius when it's wrong?**

This is not covered by "Isolate Workers" (X) — that is agent-vs-agent isolation,
keeping parallel attempts from corrupting each other. It is not covered by
"Supervise Hierarchically" (XI) — that is the escalation tree. The missing
dimension is the **agent-vs-world boundary**: least privilege, dry-run before
apply, prefer reversible operations, scope credentials and tool access to the
task, contain the damage when (not if) the non-deterministic actor does the
wrong thing.

**Why this matters more now than in v1 (2025):** The original factors were
written when agents mostly proposed code a human then ran. In 2026 agents
execute shell, deploy, spend, and touch production directly. The autonomy
surface grew; the safety factor didn't. This is the single change most justified
by *what changed in the world* since the doctrine was first written, rather than
by internal tidiness.

**What it looks like in practice:** scoped tokens per task not standing
god-credentials; reversible-by-default (write to a branch/worktree, not main;
propose a migration, don't run it against prod); dry-run and diff before apply;
explicit allowlists for destructive commands; blast radius sized to the trust
level of the validator that will catch mistakes.

### Delta C (minor) — Reframe IV and V as one principle at two ends

Not a count change, but worth stating: "Ground before acting" (IV) and "Let
reality judge" (V) are the **same principle applied before and after the
action**. Axiom 3 says the actor's internal state is not ground truth; the cure
is to bind it to external reality on both sides — observe reality *before*
generating, and let reality decide *after*. Framing them as input/output halves
of one idea (rather than two unrelated factors in different tiers) makes the
doctrine more coherent and explains why skipping either produces the same
failure: plausible output that doesn't fit the world.

The current "Validate Externally" framing also slightly over-indexes on the
*social* validator ("a different agent") and under-indexes the strongest one:
**reality itself** (does it compile, does the test pass, does prod stay up). The
reframe puts reality first and the second-opinion agent second.

---

## Part 5 — A first-principles tiering

The current tiers (Foundation / Flow / Knowledge / Scale) are good pedagogy but
are not derived. A derivation-true ordering groups factors by the axiom they
serve, which also happens to be a sensible adoption order:

1. **The environment carries state** (Axiom 1): Externalize continuity ·
   Keep actors replaceable
2. **The actor sees only what it needs** (Axiom 2): Curate context
3. **Bind the actor to reality** (Axiom 3): Ground before acting · Let reality
   judge
4. **Turn noise into progress** (Axiom 4): Sample then select · Ratchet ·
   Isolate parallel work
5. **Make it compound** (Axiom 5): Run one promotion loop
6. **Keep autonomy safe and aimed** (Axiom 6): Bound authority & blast radius ·
   Govern by objective · Make escalation structural

This is offered as a lens, not a mandate. The existing tiers may stay for the
public surface; the axiom grouping is what to reach for when explaining *why*
the factors cohere — the same job `operator-model.md` does today, but tied
directly to the physics.

---

## Part 6 — On the number twelve

An honest first-principles exercise has to confront this: **twelve is inherited,
not derived.** It comes from 12-Factor App for brand resonance. The axioms
produce six invariants and roughly a dozen disciplines, but the exact count is
soft — a defensible derivation could land on nine or fourteen.

Two ways to hold this:

- **Brand-preserving (recommended):** The deltas above keep the count at twelve
  by construction (fuse three into one, add two). This is the path of least
  disruption and keeps the "12-Factor" name honest, because the twelve are now
  *derived* rather than assembled.
- **Derivation-pure (noted, not recommended):** Publish the six axioms as the
  real spine and let the disciplines float beneath them without forcing a count.
  More intellectually honest, more disruptive to brand and muscle memory.

This proposal takes the brand-preserving path while documenting the tension, so
the maintainer can choose with eyes open rather than discovering later that
"twelve" was load-bearing in marketing but not in logic.

---

## Part 7 — Pre-mortem (how this proposal fails)

In the repo's tradition, the strongest objections to *this document*:

1. **"v3 just shipped; this churns stable doctrine."** Fair. Mitigation: this is
   a design artifact, not a rewrite. Nothing in `factors/` changes until the
   maintainer agrees the derivation is right. Cost of reading: one doc.
2. **"Fusing VII/VIII/XII loses the accountability the split created."**
   Addressed in Delta A: keep the three failure modes as named sub-points; only
   the inflation goes.
3. **"'Sample then select' is just the mechanism inside VI."** Partly — but VI
   conflates *selecting* a good draft from a noisy generator with *locking* the
   winner so it can't regress. Different operations, different failure modes (no
   selection → you ship noise; no ratchet → you regress). Splitting them is the
   point.
4. **"'Bound authority' overlaps Isolate (X) and Supervise (XI)."** Addressed in
   Delta B: X is agent-vs-agent, XI is escalation structure, neither is the
   agent-vs-world boundary. No overlap on inspection.
5. **"This is a solution looking for a problem — nobody asked for new factors."**
   The gap (Delta B) is driven by an external change (agents now act directly in
   2026, not just propose). That is the opposite of internal tidiness; it's the
   doctrine catching up to the threat model.

---

## Recommendation

Adopt the **brand-preserving** rethink:

1. **Fuse** VII + VIII + XII into one promotion-loop factor with three named
   failure modes.
2. **Add** "Bound authority & blast radius" as a first-class factor.
3. **Reframe** IV and V as the before/after halves of "bind the actor to
   reality," with reality (not a second agent) as the primary validator.
4. **Keep** the public tier names; add the six-axiom grouping to
   `operator-model.md` as the conceptual spine.

If the maintainer agrees with the derivation, the natural follow-up is a phased
rewrite of `factors/` mirroring the 2026-02-15 pivot's design-then-implement
sequence: archive current files, write the fused promotion-loop factor and the
new authority factor, reframe IV/V, update the README crosswalk and
`operator-model.md`, and extend `GOALS.yaml` with checks for the new factor and
the fused loop.

The point of the exercise is not to renumber. It is to be able to say, of every
factor, *which axiom forces it* — and to notice when one axiom is carrying three
factors while another is carrying none.
