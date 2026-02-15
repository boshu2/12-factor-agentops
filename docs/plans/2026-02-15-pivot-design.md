# 12-Factor AgentOps: Pivot Design (v3)

**Date:** 2026-02-15
**Status:** Revised after pre-mortem WARN (v2). Ready for implementation planning.
**Pre-mortem v1:** .agents/council/2026-02-15-pre-mortem-pivot-consolidated.md (FAIL)
**Pre-mortem v2:** .agents/council/2026-02-15-pre-mortem-v2-pivot-consolidated.md (WARN → proceed)

## Changes from v2

v3 incorporates the 3 pre-implementation fixes from the v2 pre-mortem council:

1. **GOALS.yaml exit criteria expanded.** 14 mechanically verifiable checks (up from 6). Covers README sections, factor depth (500+ words), "Without Tooling" checks for I-III, archival manifest, Scale factors marked optional. Phase 1 is now ~90% mechanically verifiable.
2. **Time estimate revised to 12-18 days.** Current factors are 500-870 lines each — complete rewrites, not reframes. Resequenced: archive+mapping first (dependency blocker), then factors in batches, then README.
3. **Content budgets added.** 400-600 lines per factor, 800-1000 lines README, Factor I capped at 600 lines (prevents bloat from absorbing old Factor II content).

Also incorporated from council recommendations: tier transition guidance, descriptive tier names, concrete learnings.md examples, and positioning as "foundation that amplifies existing tools."

---

## The Pivot

**From:** "Shift-Left Validation for Coding Agents" (QA slice)
**To:** "The Operational Discipline for Working With Agents" (full operating model)

12-Factor AgentOps defines vendor-neutral principles for how to work with AI agents reliably, with compounding returns. The AgentOps plugin is the reference implementation — not the prerequisite.

## The Pitch (30-second version)

Every agent session you run today starts from zero. Same mistakes, same context problems, same rework. 12-Factor AgentOps makes each session smarter than the last. Start with a `learnings.md` file. In 5 minutes, your agent stops repeating your mistakes. In a week, it knows your codebase patterns. In a month, your team has institutional memory that actually compounds.

**The hook:** Knowledge compounding. It's the one thing no competitor offers and no amount of model improvements replaces. Better models with amnesia still repeat your mistakes.

## Core Insight

Agent output quality is determined by context input quality. Most people blame the model when they get bad results. The real problem is how they operate — overloaded context windows, no session memory, no validation, no learning loops. Fix the operations and the same model performs dramatically better.

## Audience

Individual-first, scales up. The entry point is one developer working with one agent. Scale factors (X-XII) are explicitly optional — an advanced tier for multi-agent workflows, not prerequisites for getting value.

## Adoption Model (INVERTED from v1)

```
v1 (rejected):  Read manifesto → Install plugin → See results
v3 (this plan): Try 5-min quickstart → See results → Understand why (manifesto)
```

### The Entry Ramp

**Quickstart: Zero Infrastructure (5 minutes, no tooling)**
- Create `learnings.md` in your repo
- After each agent session, append what worked and what didn't
- Point your agent at it on startup (CLAUDE.md, .cursorrules, etc.)
- You're now doing Factors I, II, and VII at a basic level
- Example entry: `"Auth middleware requires explicit CORS headers for OPTIONS requests. Default config silently drops preflight. — 2026-02-15"`
- **When to level up:** When learnings.md exceeds ~50 entries or you stop reading it before sessions, you're ready for Foundation.

**Foundation (Factors I-III) — no tooling required**
- Context management: keep sessions focused, start fresh for new tasks
- Track artifacts in git (commit your learnings.md)
- One agent, one job — stop reusing saturated windows
- **When to level up:** When you find yourself re-explaining codebase patterns to new agent sessions, you're ready for Workflow.

**Workflow (Factors IV-VI) — plugin adds value, manual works too**
- Research-before-build, external validation, progress ratcheting
- The AgentOps plugin starts adding value here (automation of these patterns)
- But manual application still works — the factors are practices, not features
- **When to level up:** When you notice the same mistakes recurring across sessions despite research, you need systematic extraction.

**Knowledge (Factors VII-IX) — where compounding kicks in**
- Systematic extraction, automated injection, fitness measurement
- Plugin provides significant acceleration (manual extraction is tedious but possible)
- This tier is where compounding truly kicks in — sessions get measurably smarter
- Foundation and Workflow factors work anywhere. Knowledge factors work best with tooling but principles are portable.

**Scale (Factors X-XII) — OPTIONAL: multi-agent only**
- Multi-agent isolation, hierarchical supervision, failure harvesting
- Explicitly for teams and multi-agent orchestration
- Skip entirely if you work solo — you lose nothing
- References Olympus patterns for advanced implementations

**Key principle:** You can stop at any level and keep the value. Each level justifies the next, but none requires it.

## Competitive Positioning

**Position:** The operational foundation that makes build methodologies work better.

Not "complementary but separate" from GSD/Superpowers/Agent OS/Spec Kitty. Instead: "GSD specs are more accurate when agents have context discipline (Factor I). Superpowers TDD is faster when agents inject prior learnings (Factor VIII). Your existing tools get more out of agents when you add operational discipline."

**Moat:** Not "no one else offers knowledge compounding" — competitors could add basic compounding in weeks. The moat is automated compounding with quality gates, semantic retrieval, and decay management. Manual learnings.md files don't scale past ~50 sessions. The AgentOps flywheel does.

| Project | Relationship |
|---------|-------------|
| 12-Factor Agents (HumanLayer) | How to *build* agent applications. We're how to *operate with* them. |
| Vibe Coding (Gene Kim, Steve Yegge) | The methodology of AI-assisted coding. We're the operational foundation underneath. |
| AgentOps plugin | Reference implementation (best-in-class, not the only path). |
| Olympus | Multi-agent orchestration system demonstrating Factors X–XII at scale. |

---

## The 12 Factors

### Foundation (I–III) — Start Here

Non-negotiable. Get these wrong and nothing else matters. **These work with zero tooling.**

#### Factor I: Context Is Everything

**Rule: Manage what enters the context window like you manage what enters production.**

Observable symptoms of violation: agent repeats itself, ignores recent instructions, confabulates details, contradicts its own earlier output. These are signs of context overload — the agent is drowning in irrelevant information.

Practically: load context just-in-time, not just-in-case. Scope what each agent sees to its task. Compress between phases. Use handoff summaries instead of carrying full history. The agent that knows less but knows the *right things* outperforms the one drowning in context.

Research backing: The "lost in the middle" effect is well-documented — LLMs attend to the start and end of context, losing information in the middle. Cognitive load theory (40+ years of research) predicts this. Keep context lean and relevant.

**What good looks like:**
- Each agent receives only task-relevant information
- Phase transitions produce compressed summaries, not full transcripts
- Handoffs carry structured context, not "read the whole thread"
- You notice when the agent starts ignoring instructions (symptom of overload)

**Without tooling:** Keep sessions short. Start fresh for new tasks. Write a 3-line summary when handing off between sessions.

**Content budget:** 600 lines max (absorbs old Factor II context-loading content; no bloat beyond that).

#### Factor II: Track Everything in Git

**Rule: If it's not in git, it didn't happen.**

Not just code — issues, learnings, patterns, session artifacts, decisions. Git gives you history, diffability, collaboration, and auditability for free. When your agent's knowledge base, issue tracker, and work artifacts all live in the repo, any agent can pick up where any other left off. No external databases, no cloud state, no vendor lock-in.

**What good looks like:**
- Issues tracked in-repo (beads, GitHub issues, or similar)
- Learnings and patterns stored as versioned artifacts
- Session state can be reconstructed from git history
- Any agent can resume any other agent's work from the repo alone

**Without tooling:** Commit your `learnings.md`. That's it. You're tracking knowledge in git.

#### Factor III: One Agent, One Job

**Rule: Each agent gets a scoped task and fresh context. Never reuse a saturated window.**

An agent that just finished researching your auth system is the worst agent to then implement the fix — its window is full of research context, not implementation context. Spawn fresh. Scope tight. The cost of a new agent is tokens; the cost of a confused agent is rework.

**What good looks like:**
- Research agents produce findings; implementation agents consume them
- Phase transitions spawn new agents with scoped context
- No agent carries context from a previous unrelated task
- Worker agents get a single issue, not a list of issues

**Without tooling:** When your session gets long or confused, start a new one. Paste a summary of what you learned, not the whole conversation.

---

### Workflow (IV–VI) — The Discipline

How work flows through agents — the discipline that separates "prompting and hoping" from a reliable operating model.

#### Factor IV: Research Before You Build

**Rule: Understand the problem space before generating a single line of code.**

The cheapest agent session is the one that doesn't get thrown away. Agents that dive straight into implementation without understanding existing patterns, constraints, and conventions produce plausible-looking code that doesn't fit. Research is a distinct phase — it produces findings, not code.

This is the "measure twice, cut once" of agent operations. A 10-minute research phase routinely saves hours of rework.

**What good looks like:**
- Research is a named phase with its own output artifacts
- Implementation agents receive research findings, not raw questions
- Existing codebase patterns are understood before new code is written
- Research findings are stored and reusable across sessions

#### Factor V: Validate Externally

**Rule: No agent grades its own work. Ever.**

When you ask an agent "does this look right?" after it just wrote the code, it will say yes. This isn't malice — it's the same context bias that makes humans bad at proofreading their own writing. Validation must come from outside: a different agent, a different model, a test suite, a human review.

Self-validation isn't validation. It's confirmation bias with extra steps.

**What good looks like:**
- Code is validated by an agent that didn't write it
- Critical decisions get multi-model review (2+ independent assessments)
- Test suites run as automated validation gates
- Humans review architectural decisions and security-sensitive changes

#### Factor VI: Lock Progress Forward

**Rule: Once work passes validation, it ratchets — it cannot regress.**

The Brownian Ratchet pattern: chaos is cheap (spawn multiple attempts), filtering is the gate (validation, tests, review), the ratchet is the lock (merge, close, record). Progress accumulates because validated work is permanent. Failed attempts aren't waste — they're the cost of finding what works.

**What good looks like:**
- Validated work merges to a protected branch (permanent)
- Issues close only after external validation (state locks)
- Multiple parallel attempts are encouraged (chaos is cheap)
- Unvalidated work never reaches shared branches

---

### Knowledge (VII–IX) — The Compounding Advantage

Where agent operations diverges most sharply from ad-hoc agent usage. Without these, every session starts from zero. With them, every session is smarter than the last.

**This tier contains the project's unique differentiator: knowledge compounding (Factor VIII).** No competitor offers automated compounding with quality gates, semantic retrieval, and decay management. Foundation and Workflow factors work anywhere; Knowledge factors work best with tooling but principles are portable.

#### Factor VII: Extract Learnings From Every Session

**Rule: Every session produces two outputs — the work product and the lessons learned.**

Most people close the tab and move on. The patterns discovered, the dead ends hit, the decisions made — all evaporate. Extraction is a deliberate act: at the end of each session, mine it for what worked, what failed, and what was decided.

Observable symptoms of missing extraction: same mistakes across sessions, no recall of prior decisions, constant re-explanation of codebase patterns to new agent sessions.

A session you didn't extract from is a session the organization forgot.

**What good looks like:**
- Every session ends with explicit learning extraction
- Learnings are structured: what, why, context, confidence level
- Decisions are recorded with rationale, not just outcomes
- Dead ends are documented (what was tried and why it failed)

#### Factor VIII: Compound Knowledge Across Sessions

**Rule: Learnings must flow back into future sessions automatically.**

*This is the factor that changes everything.*

Extraction without injection is a write-only database. The flywheel pattern: extract learnings → gate for quality → decay stale ones → inject relevant ones at session startup. The compounding equation: if retrieval rate × citation rate exceeds decay rate, knowledge grows. If not, it decays to zero.

This is institutional memory that actually works — not a wiki nobody reads. It's the reason session 50 dramatically outperforms session 1, even on the same model. And it's the one thing that can't be replicated by a better model, a faster API, or a new framework — because the value comes from *your* accumulated context, not the model's training data.

Observable symptoms of missing compounding: agent keeps suggesting approaches you've already tried and rejected, no improvement in first-pass quality over time, useful patterns discovered in one session never appear in subsequent sessions.

**What good looks like:**
- Session startup automatically loads relevant prior learnings
- Learnings pass quality gates before entering the knowledge base
- Stale knowledge decays over time (freshness weighting)
- Knowledge reuse rate is tracked and growing

#### Factor IX: Measure What Matters

**Rule: Track fitness toward goals, not activity metrics.**

Token count, session count, lines of code — these are vanity metrics. What matters: Are goals being met? Are the same mistakes recurring? Is knowledge actually being reused? Dormancy is success — when all goals pass, the system should stop, not manufacture work.

Observable symptoms of wrong measurement: agent stays busy but goals don't advance, same types of failures recur weekly, knowledge base grows but citation rate is flat.

**What good looks like:**
- Goals are defined and measurable (not "be productive")
- Recurring failures trigger pattern extraction, not just retries
- Knowledge reuse rate is tracked (are learnings actually applied?)
- The system stops when goals are met (dormancy, not busywork)

---

### Scale (X–XII) — OPTIONAL: Multi-Agent Patterns

These kick in when you move beyond one agent. **Not prerequisites** — you can get enormous value from Factors I–IX alone. These are explicitly for teams, multi-agent orchestration, and advanced workflows. Skip entirely if you work solo.

#### Factor X: Isolate Workers

**Rule: Each worker gets its own workspace, its own context, and zero shared mutable state.**

When two agents share a context window or a working directory, they corrupt each other. Isolation means separate git worktrees, fresh context per worker, no bleed-through between execution waves.

**What good looks like:**
- Each worker agent operates in its own git worktree
- No shared mutable state between concurrent agents
- Context is scoped per-worker, not shared across workers
- Parallel execution waves get fresh context (no bleed-through)

#### Factor XI: Supervise Hierarchically

**Rule: Escalation flows up, never sideways. Each level handles what it can and passes up what it can't.**

Mirrors Erlang supervision trees: let workers fail, let supervisors decide what failure means. Flat agent topologies where everyone talks to everyone produce deadlocks and circular dependencies. Hierarchy isn't bureaucracy — it's error handling.

**What good looks like:**
- Clear supervision hierarchy (worker → supervisor → coordinator)
- Workers escalate after bounded retries (e.g., 3 attempts)
- Supervisors can reassign, reframe, or escalate further
- Humans sit at the top of the tree, not in the middle of every loop

#### Factor XII: Harvest Failures as Wisdom

**Rule: Failed attempts are data. Extract and index them with the same rigor as successes.**

Over time, the system accumulates negative knowledge ("don't try X when Y is true") that's as valuable as positive knowledge. Failures are the tuition. Learnings are the degree.

**What good looks like:**
- Failed attempts are logged with context, not silently discarded
- Post-mortems run on failures with the same rigor as successes
- Negative knowledge ("X doesn't work when Y") is indexed and retrievable
- Failure rate decreases over time as harvested wisdom prevents repeats

---

## Implementation Plan (Phased)

### Phase 1: Core Content Pivot — 12-18 days elapsed

Scope boundary: Archive + 12 factor files + README + GOALS.yaml. Nothing else.

**Content budgets:**
- Factor files: 400-600 lines each (maintain depth without verbosity)
- Factor I specifically: 600 lines max (absorbs old Factor II content, no bloat)
- README: 800-1000 lines
- Archival MAPPING.md: no budget (as long as needed)

**Sequenced work (dependencies respected):**

| Step | Work | Est. Hours | Dependencies |
|------|------|-----------|--------------|
| 1 | Archive old factors to `_archived/factors-v1/` + create MAPPING.md | 8-12 | None (do first) |
| 2 | Rewrite Factors I-III (Foundation + "Without Tooling" sections) | 24-36 | Step 1 (need mapping for I/II collision) |
| 3 | Draft README (hero, pitch, quickstart, tiering, factor overview, ref impl) | 15-20 | Step 2 (needs Foundation factors for quickstart examples) |
| 4 | Rewrite Factors IV-VI (Workflow) | 18-24 | Step 1 |
| 5 | Rewrite Factors VII-IX (Knowledge) | 18-24 | Step 1 |
| 6 | Rewrite Factors X-XII (Scale, marked OPTIONAL) | 12-18 | Step 1 |
| 7 | Update GOALS.yaml (already done in v3, verify checks pass) | 2-4 | Steps 2-6 |
| 8 | Final review: all links work, no stubs, GOALS.yaml passes | 4-6 | All above |

**Total: 101-144 hours (12-18 days)**

Steps 4, 5, 6 can run in parallel (all depend only on Step 1). Steps 2 and 3 are sequential (README needs Foundation factors). Step 7 is verification.

**Archival MAPPING.md spec:**

| Column | Description |
|--------|-------------|
| Old Number | v1 factor number (01-12) |
| Old Title | v1 factor filename |
| New Number | v3 factor number (01-12) |
| New Title | v3 factor filename |
| Content Disposition | `rewrite` / `merge` / `split` / `new` |
| Notes | Migration details (e.g., "Old Factor II context-loading content → new Factor I") |

**Factor I/II collision resolution:** Old Factor II "Context Loading" (870 lines) migrates to new Factor I "Context Is Everything." Specifically: 40% rule content, observable symptoms, cognitive load research backing, and "lost in the middle" references migrate. Sub-agent architecture deep-dive and HumanLayer attribution stay in archive (tutorial material for Phase 2). Factor I capped at 600 lines.

**Explicit scope exclusions for Phase 1:**
- No new marketplace skills
- No Olympus cross-references beyond exactly 1 sentence per Scale factor (X-XII)
- No tutorial rewrites
- No new tooling or plugins
- No "Getting Started Without Tooling" standalone guide (Phase 2)

### Phase 2: Supporting Content (future, scoped after Phase 1 validation)

**Gate:** Validate Phase 1 with 5+ external users before scoping. Target: 80%+ can complete Quickstart from README alone in 5 minutes.

- Migration guide (v1 → v3 factor mapping, based on MAPPING.md)
- Tutorials rewritten for new factor structure
- "Getting Started Without Tooling" standalone guide (expanding Quickstart + Foundation)
- Factor I sub-agent deep-dive (extracted from archive)

### Phase 3: Ecosystem (future, scoped after Phase 2)

- Reframe existing marketplace skills under Factor V
- Exactly 2 new skills: `context-audit` (Factor I) and `extract-learnings` (Factor VII)
- No open-ended "consider new skills"
- Ship AgentOps flywheel implementation (competitive moat depends on execution speed)

## Vendor Neutrality Position

**Honest framing:** The 12 factors are vendor-neutral principles. The AgentOps plugin is the best-in-class implementation — it automates what you'd otherwise do manually. Foundation and Workflow factors (I-VI) work with any agent tool, proven by "Without Tooling" sections. Knowledge factors (VII-IX) work best with tooling but principles are portable. Scale factors (X-XII) are advanced patterns, tooling-optional for reference architecture.

## README Structure (Phase 1, 800-1000 lines)

1. **Hero:** Knowledge compounding pitch ("your sessions get smarter over time")
2. **30-second pitch:** Pain → solution → proof → hook, in three sentences
3. **5-minute quickstart:** Quickstart tier — learnings.md with copy-paste examples, no tooling
4. **The 12 Factors:** Overview with tiering (Quickstart → Foundation → Workflow → Knowledge → Scale/Optional)
5. **Go deeper:** Links to individual factor files
6. **Reference implementation:** AgentOps plugin (automates what you'd otherwise do manually)

## GOALS.yaml (v2, 14 checks)

See `GOALS.yaml` — updated with substance checks per pre-mortem findings. Key additions:
- Factor depth: 500+ words per factor (prevents stubs)
- Foundation "Without Tooling" sections: verified for factors 01-03
- Factor I observable symptoms: verified by keyword check
- Factor VIII flywheel content: verified by keyword check
- Scale factors optional marking: verified for factors 10-12
- README sections: hero, quickstart, tiering, no-tooling language all checked
- README depth: 800+ words minimum
- Archive: `_archived/factors-v1/` exists with MAPPING.md
