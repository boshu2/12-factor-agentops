# Judge: missing-requirements

## Verdict: WARN
## Confidence: HIGH

## Key Insight
V2 addresses v1's critical adoption barriers but lacks concrete transition mechanics for learnings.md growth, tier progression discovery, and Phase 1 completion criteria.

## Findings

### Finding 1: Learnings.md Growth Path Undefined
- **Severity:** significant
- **Category:** requirements
- **Description:** Tier 0 says "append what worked and what didn't" to learnings.md after each session, but provides no guidance on what happens when this file reaches 500 lines, 5000 lines, or 50,000 lines. No maximum size, no compaction strategy, no point at which it becomes the problem it's trying to solve (context overload). Factor I warns against context bloat, but Tier 0 creates an unbounded accumulation mechanism.
- **Recommendation:** Add explicit guidance in Tier 0 or README: "When learnings.md exceeds ~200 lines, you're ready for Tier 3 (automated extraction/injection). Manual curation doesn't scale — that's the upgrade path." Define the failure mode that motivates tier progression.
- **Why:** Users need to know when to stop doing what worked at Tier 0. Without exit criteria, learnings.md becomes a write-only knowledge graveyard that violates Factor I.

### Finding 2: Tier Progression Discovery Mechanism Missing
- **Severity:** significant
- **Category:** requirements
- **Description:** Plan explains what each tier offers but not HOW users discover they need the next tier. No symptoms of "Tier N is no longer enough" documented. A user doing Tier 1 manually has no trigger to recognize they'd benefit from Tier 2 automation. The tiering exists in the docs but not in the user's workflow.
- **Recommendation:** Add "When to level up" sections to each tier. Tier 0 → Tier 1: "When you start forgetting to update learnings.md." Tier 1 → Tier 2: "When research notes become long enough that you skip reading them." Tier 2 → Tier 3: "When you catch yourself referencing a learning you forgot you wrote." Make progression observable, not just documentable.
- **Why:** Progressive disclosure only works if users have signals for when to progress. Without symptoms, users plateau or skip tiers entirely.

### Finding 3: Phase 1 Exit Criteria Are Input-Focused, Not Outcome-Focused
- **Severity:** significant
- **Category:** requirements
- **Description:** Phase 1 scope defines what to create (README, 12 factor files, GOALS.yaml updates) but not what readiness looks like. "Complete rewrites" is a task, not a standard. No definition of when a factor rewrite is done beyond "contains 'Without Tooling' section." No quality bar for the README hero section beyond "lead with knowledge compounding hook." Substance checks in GOALS.yaml are binary (mention X or not) rather than validating depth.
- **Recommendation:** Add outcome-based exit criteria for Phase 1: "A new user can start Tier 0 in under 5 minutes from README alone (no external docs)." "Each Foundation factor (I-III) demonstrates zero-tooling application in under 100 words." "README pitch tested with 3+ non-users; 80%+ can explain knowledge compounding in one sentence after reading." Make "done" observable by someone other than the writer.
- **Why:** Input-focused scope leads to completion bias ("I wrote all 12 files, therefore I'm done"). Outcome-focused scope forces validation against user needs.

### Finding 4: Factor I "Observable Symptoms" Lack Concrete Examples
- **Severity:** minor
- **Category:** requirements
- **Description:** Factor I (lines 99-101) lists symptoms of context overload: "agent repeats itself, ignores recent instructions, confabulates details, contradicts its own earlier output." Good start, but lacks concrete examples users can pattern-match. "Repeats itself" is vague — does that mean exact duplication, restating earlier advice, or regenerating already-written code?
- **Recommendation:** Expand symptoms with examples: "Repeats itself = regenerates a function you already reviewed three messages ago." "Ignores instructions = you said 'use snake_case' but it still uses camelCase." "Confabulates = invents API methods that don't exist in the library you're using." Make symptoms recognizable in actual transcripts.
- **Why:** Generic symptoms feel like checklists that always apply. Specific examples create "aha, THAT'S what's happening" moments that drive behavior change.

### Finding 5: "Without Tooling" Sections May Not Scale to All Foundation Factors
- **Severity:** minor
- **Category:** requirements
- **Description:** Plan commits to "Without Tooling" sections for Factors I-III (lines 311, 332) but doesn't validate whether this is actually feasible for all three. Factor II (Track Everything in Git) works trivially (commit learnings.md). Factor III (One Agent, One Job) works (start new sessions). But Factor I (Context Is Everything) requires understanding context window utilization, compression techniques, and handoff summarization — the manual version of "manage what enters context window like production" may be too abstract for zero-tooling newcomers.
- **Recommendation:** Pre-draft the Factor I "Without Tooling" section NOW (in the plan or a scratch doc) to validate feasibility. If it requires 300+ words of theory to explain manual context management, that's a signal Factor I may not belong in the zero-tooling tier. Alternative: Split Factor I into "Recognize symptoms" (Tier 0) and "Actively manage context" (Tier 1+).
- **Why:** Committing to "Without Tooling" for all Foundation factors without validating writeability risks discovering during execution that the commitment can't be kept, undermining the zero-infrastructure promise.

### Finding 6: Knowledge Compounding as "Hero" Lacks Proof Point
- **Severity:** minor
- **Category:** requirements
- **Description:** Plan elevates Factor VIII (knowledge compounding) to hero positioning (line 213-218) with claim "session 50 dramatically outperforms session 1, even on the same model." Strong claim, zero evidence provided. No case study, no before/after metrics, no demo. For a claim this central to differentiation, "trust me" isn't sufficient — especially when targeting skeptical developers.
- **Recommendation:** Add to Phase 1 scope: "Identify or create one concrete proof point for knowledge compounding hero claim (AgentOps internal usage data, Gas Town trajectory, or controlled before/after experiment)." Doesn't need to be peer-reviewed research, but needs to be real. Include in README as "This isn't theory — here's what happened when we tracked knowledge reuse rate over 6 weeks."
- **Why:** Extraordinary claims require ordinary evidence. Developers dismiss marketing speak but trust data. One real example beats ten philosophical arguments.

### Finding 7: Vendor Neutrality "Honest Framing" Doesn't Address Factors VII-IX Gap
- **Severity:** minor
- **Category:** requirements
- **Description:** Line 312-313 claims vendor neutrality is proven by "Without Tooling" sections in Factors I-III, but this only covers Foundation tier. The v1 pre-mortem (lines 65-69) correctly identified that Factors VII-IX (knowledge tier) require infrastructure most users don't have. V2 doesn't resolve this — it just omits "Without Tooling" for those factors. Neutrality claim still rests on "you can do this manually" without proving anyone actually would.
- **Recommendation:** Either add "Manual Approach (Advanced)" sections to Factors VII-IX showing realistic manual workflows (learnings.md + grep/awk/fzf for injection? CSV tracking for reuse rates?), OR reframe neutrality claim as "Foundation factors work anywhere; Knowledge factors work best with tooling but principles are portable." Honesty means acknowledging where tooling becomes necessary, not just omitting the hard cases.
- **Why:** Neutrality claims are sticky — users remember the promise even if the footnotes qualified it. Better to set correct expectations upfront than defend against "you said it was tool-agnostic but I can't do Factor VIII without your plugin" complaints later.

### Finding 8: Phased Implementation Has No Feedback Loop Between Phases
- **Severity:** minor
- **Category:** requirements
- **Description:** Phase 1 → 2 → 3 progression (lines 283-309) is sequential with no validation gates between phases. Phase 1 ships core content, Phase 2 adds supporting docs, Phase 3 builds ecosystem. But there's no requirement to validate Phase 1 reception before scoping Phase 2. What if users find the 12-factor structure confusing? What if Tier 0 doesn't resonate? The plan assumes Phase 1 content will work and builds on that assumption.
- **Recommendation:** Add explicit validation gate between Phase 1 and Phase 2: "Before scoping Phase 2, validate Phase 1 with 5+ external users (not Gas Town agents). Target: 80%+ can complete Tier 0 from README alone, 60%+ articulate knowledge compounding value prop unprompted." Make Phase 2 scope contingent on Phase 1 learnings. This matches Factor VII (extract learnings from every session) applied to your own work.
- **Why:** Sequential phasing without validation gates is waterfall planning. Agile phasing validates assumptions before compounding them. The plan preaches Factor VII but doesn't practice it on itself.

## Recommendation

V2 successfully addresses v1's FAIL on adoption barriers through tier inversion, zero-infrastructure entry, and knowledge compounding as hero. The vision is now solid. However, execution still has gaps:

1. **Add tier transition mechanics** — Define "When to level up" signals for each tier, learnings.md growth handling, and progression discovery.
2. **Convert Phase 1 scope to outcomes** — "A new user can X" not "We wrote Y files."
3. **Pre-validate "Without Tooling" feasibility** — Draft Factor I's manual section now to test the commitment.
4. **Add proof point to knowledge compounding claim** — One real example beats philosophy.
5. **Insert validation gate between Phase 1 and Phase 2** — Practice Factor VII on yourself.

Verdict is WARN not FAIL because these are execution refinements, not foundational flaws. The v1 critical findings are adequately addressed. These gaps won't prevent Phase 1 from shipping, but addressing them will make what ships more likely to succeed.
