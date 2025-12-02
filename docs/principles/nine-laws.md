# The Nine Laws of an Agent

## Introduction

The Nine Laws of an Agent are **mandatory operational rules** that govern all agent sessions. These aren't aspirational guidelines—they're constitutional requirements that separate reliable agent operations from chaotic ones.

These laws emerged from thousands of hours operating AI agents in production, distilled into nine actionable principles.

---

## The Nine Laws

| Law | Principle | Summary |
|-----|-----------|---------|
| **1** | Learn and Improve | Extract patterns, identify improvements |
| **2** | Document for Future | Context commits, progress files, bundles |
| **3** | Git Discipline | Commit often, clean workspace, no hook loops |
| **4** | TDD with Tracers | Tests first for L1-L2 (high-risk) tasks |
| **5** | Guide with Workflows | Suggest options, let user choose |
| **6** | Classify Vibe Level | Ask "what level?" (0-5) before work |
| **7** | Measure and Calibrate | vibe-check before/after, break spirals |
| **8** | Session Protocol | One feature, review before end, update progress |
| **9** | Protect Feature Definitions | Never modify, only mark `passes` |

---

## Law 1: Learn and Improve

**Requirement:** Extract patterns and identify improvements from every work session.

### Why This Matters

Without learning extraction:
```
Session 1: Solve problem A (4 hours)
Session 2: Solve problem A' (4 hours, similar problem)
Session 3: Solve problem A'' (4 hours, same class of problem)
→ Linear progress: N problems = N × 4 hours
```

With learning extraction:
```
Session 1: Solve problem A → Extract pattern P (4 hours + 30 min)
Session 2: Apply pattern P to A' (1 hour)
Session 3: Apply pattern P to A'' (30 min)
→ Exponential improvement: Pattern pays for itself by session 2
```

### Implementation

- Document patterns discovered in commit messages
- Add learnings to session summaries
- Identify at least one improvement opportunity per session

**Institutional memory compounds. Today's learning is tomorrow's efficiency.**

---

## Law 2: Document for Future

**Requirement:** Every significant action must include context for future agents/humans.

### The Curse of Knowledge

Once you know something, it's hard to remember not knowing it. Context that's obvious now won't be obvious later.

**Future you is a stranger.** Documentation bridges the gap.

### Implementation

- Context commits with why, not just what
- Progress files (`claude-progress.json`, `claude-progress.txt`)
- Bundles for complex research/plans

### What to Document

- **Context:** Why this work was needed
- **Solution:** What was done and how
- **Learning:** Reusable insights extracted
- **Impact:** Quantified value delivered

---

## Law 3: Git Discipline

**Requirement:** Commit often, maintain clean workspace, prevent hook loops.

### Critical Rule

**Never commit files modified by git hooks.** Session logs, timestamps, and auto-generated files should not be committed unless explicitly requested.

Committing hook files creates infinite loops:
```
commit → hook modifies file → commit hook file → hook modifies → ...
```

### Implementation

- Small, focused commits with semantic messages
- Clean working tree before session end
- Check `git status` after push for hook-modified files

---

## Law 4: TDD with Tracers

**Requirement:** Tests first for L1-L2 (high-risk) tasks. Tracer bullets validate assumptions.

### When to Apply

| Vibe Level | Risk | TDD Required? |
|------------|------|---------------|
| 0-2 | High (architecture, novel) | **Yes** |
| 3 | Medium (features) | Recommended |
| 4-5 | Low (boilerplate, formatting) | Optional |

### Tracer Bullets

Before implementing a complex feature:
1. Write a minimal test that validates the critical assumption
2. Make it pass with the simplest possible implementation
3. Expand from there

**Prevention is cheaper than debugging. Tracers catch wrong assumptions early.**

---

## Law 5: Guide with Workflows

**Requirement:** Suggest workflow options, let user choose. Never prescribe.

### The Pattern

```
Based on your task, you might want:
1. /research - Explore problem space first
2. /plan - Design solution if research done
3. /implement - Execute if plan approved

Which approach?
```

### Why This Matters

- Workflows ensure quality
- Forcing them creates friction
- User autonomy builds trust

**Suggest, don't prescribe.**

---

## Law 6: Classify Vibe Level

**Requirement:** Ask "what level?" (0-5) before starting work.

### The Vibe Levels

| Level | Trust | Verify | Use For |
|-------|-------|--------|---------|
| 5 | 95% | Final only | Format, lint |
| 4 | 80% | Spot check | Boilerplate |
| 3 | 60% | Key outputs | CRUD, tests |
| 2 | 40% | Every change | Features |
| 1 | 20% | Every line | Architecture |
| 0 | 0% | N/A | Novel research |

### Why This Matters

Verification effort should match task risk. Over-verifying trivial tasks wastes time. Under-verifying critical tasks causes failures.

---

## Law 7: Measure and Calibrate

**Requirement:** Run vibe-check before/after significant work. Break debug spirals.

### The 5 Core Metrics

| Metric | Question | Target |
|--------|----------|--------|
| Iteration Velocity | How tight are feedback loops? | >3/hour |
| Rework Ratio | Building or debugging? | <50% |
| Trust Pass Rate | Does code stick? | >80% |
| Debug Spiral Duration | How long stuck? | <30m |
| Flow Efficiency | What % productive? | >75% |

### Debug Spiral Detection

If you see >3 consecutive fix commits without new features, you're in a debug spiral.

**Action:** Stop. Write a tracer test. Validate assumptions before proceeding.

---

## Law 8: Session Protocol

**Requirement:** One feature at a time, review before end, update progress.

### The Pattern

```
/session-start → [work on ONE feature] → /session-end
      ↓                                        ↓
  Read state                              Write state
  Show next item                          Update passes
  Orient                                  Append log
```

### Why This Matters

- Context switching is expensive
- State persistence enables continuity
- Review before end catches forgotten items

---

## Law 9: Protect Feature Definitions

**Requirement:** Never modify feature definitions. Only mark `passes: true`.

### The Rule

`feature-list.json` specs are immutable contracts:
- **Never delete** feature definitions
- **Never reword** feature descriptions
- **Only mark** `passes: true` when complete
- **Add** `completed_date` when done

### Why This Matters

Feature definitions are the contract between planning and execution. Changing specs mid-flight causes confusion and loses the original intent.

---

## Law Enforcement

### Violation Signals

| Law | Violation Signal |
|-----|------------------|
| 1 | Session without learning extraction |
| 2 | Commit without context |
| 3 | Committing hook-modified files |
| 4 | L1-L2 work without tests |
| 5 | Prescribing instead of suggesting |
| 6 | Starting without vibe level |
| 7 | >3 fix commits without pause |
| 8 | Multi-feature session |
| 9 | Modifying feature specs |

### Remediation

| Violation | Fix |
|-----------|-----|
| No learning | Add before session end |
| No context | Amend commit |
| Hook file commit | Reset, don't commit |
| No tests for L1-L2 | Write tracer test |
| Prescribing | Rephrase as options |
| No vibe level | Ask before proceeding |
| Debug spiral | Stop, write tracer |
| Multi-feature | Focus on one |
| Modified specs | Revert, only mark passes |

---

## Historical Context

These nine laws evolved from the original Five Laws (philosophical foundation) combined with operational requirements discovered in production:

**Original Five Laws (Philosophical):**
1. Extract Learnings
2. Improve Self or System
3. Document Context
4. Validate Before Execute
5. Share Patterns Publicly

**Added Operational Laws:**
- TDD with Tracers (from debugging pain)
- Classify Vibe Level (from vibe coding methodology)
- Measure and Calibrate (from FAAFO metrics)
- Session Protocol (from multi-day project needs)
- Protect Feature Definitions (from 2-Agent Harness requirements)

The laws consolidated to nine, with validation becoming part of other laws (Git Discipline, TDD with Tracers) and sharing becoming a documentation concern.

---

## Related

- [Constitution Plugin](https://github.com/boshu2/agentops/tree/main/plugins/constitution) - Implementation
- [Vibe Coding](https://itrevolution.com/product/vibe-coding-book/) - Gene Kim & Steve Yegge
- [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) - Dex Horthy
