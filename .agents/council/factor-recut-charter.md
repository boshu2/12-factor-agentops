# Council Charter — re-derive the 12 Factors (quorum required)

> 3-model council: **Opus 4.8** (claude), **Codex GPT-5.5** (codex), **Gemini 3.5 Flash** (antigravity/agy).
> Goal: agree on what the 12 factors SHOULD be — and crucially their **order** and **grouping** —
> from something closer to first principles. The operator's verdict on the current set: it "feels
> random," the factors aren't ordered properly, and the four tiers feel backfilled to hit twelve.
> Your job is to fix that, with a real organizing principle, and reach **quorum** (all three agree).

## The problem you are solving
The current 12-Factor AgentOps doctrine (read `factors/*.md`) is a *list*, not a *system*. The
adversarial accuracy audit (read `.agents/council/accuracy-audit-input.md`) found: overstatement,
a security/permissions gap, a probable XII→VIII redundancy, IX wedged into the wrong tier, and a
"12" that looks padded to match Heroku's number. Don't just patch it. Re-derive it so the **order
is meaningful** (each factor earns its position) and the **grouping reflects a genuine organizing
principle** (a lifecycle? a control loop? a dependency order? a maturity ladder? argue for one).

## Hard constraints (operator decisions — not up for debate)
1. **Exactly 12 factors.** The number is brand-load-bearing. If you believe the honest count is ~9,
   say so in your rationale, but deliver 12 (no padding-for-padding's-sake — if you must reach 12,
   the extra slots must be genuinely distinct primitives, e.g. security, cost, observability, HITL).
2. **Security/permissions MUST be represented** — least-privilege, sandboxing, untrusted-input /
   prompt-injection, blast-radius. The current set has none; that's the single biggest gap.
3. **Vendor-neutral, runtime-agnostic.** Applies to Claude/Codex/Gemini/Cursor alike.
4. **Each factor genuinely distinct** — no two are the same underlying primitive in different words.
5. **Voice:** punchy aphoristic headline rule + honest body (no invented numbers stated as fact,
   no pseudo-math, no absolutism the body contradicts).

## What "good order and grouping" means
- The **order** should tell a story — e.g. you cannot do factor N well without N-1, or the factors
  trace a work lifecycle, or they ascend a maturity ladder. Make the through-line explicit.
- The **grouping** must have ONE stated organizing principle. Name it. "Foundation/Flow/Knowledge/
  Scale" is the incumbent — improve on it or defend it, but justify the principle, don't assume it.

## Your output (each model, every round)
Write/overwrite your proposal to `.agents/council/proposals/<you>.md` where `<you>` is
`claude`, `codex`, or `gemini`. Structure:

```
# <model> proposal — round <N>
## Organizing principle
<the ONE principle behind the order + grouping, in 2-3 sentences>
## The 12 factors (in order)
| # | Factor name | One-line rule | Group |
（12 rows）
## Grouping
<the groups, the principle, why this order>
## What changed vs the current set & why
<additions (incl. security), merges (e.g. XII→VIII?), reorders, renames — with reasons>
## Open disagreements with the other two proposals
<after round 1: where you differ and your argument>
```

## Process / how to reach quorum
- **Round 1:** propose independently. Do NOT read the others first — derive your own best answer
  from the current factors + the audit, then write your file.
- **Round 2+:** read all three files in `.agents/council/proposals/`. Adopt what's better, argue
  what's worse, converge. Update your own file each round with a new "round N" version.
- **Quorum = all three proposals agree** on: the set of 12, their order, and the grouping/principle.
  Minor wording differences are fine; the structure must match. When you believe quorum is reached,
  state `QUORUM: yes` at the top of your file and list the agreed 12. Otherwise `QUORUM: no` + the
  remaining disagreement.
- Be intellectually honest, not agreeable-for-the-sake-of-it. A forced false consensus is worse than
  a logged disagreement. But genuinely try to converge — find the best answer, not a compromise.

## Inputs to read first
- `factors/*.md` — the current 12 (the thing you're improving).
- `.agents/council/accuracy-audit-input.md` — the adversarial audit's findings.
- `README.md` — current framing (tiers, heritage, the operator model).
