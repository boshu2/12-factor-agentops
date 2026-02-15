# III. One Agent, One Job
## Fresh context per task. Never reuse a saturated window.

## The Rule

Each agent gets a scoped task and fresh context. Never reuse a saturated window.

An agent that just finished researching your auth system is the worst agent to implement the fix — its window is full of research context, not implementation context. Spawn fresh. Scope tight.

When an agent completes a phase of work, end its session. The next phase gets a new agent with a clean window, loaded with only what it needs to execute.

## The Rationale

#### The Context Saturation Problem

Language models have finite context windows. Every conversation turn fills that window with history: tool outputs, code snippets, debugging traces, reasoning chains. The longer a session runs, the less room remains for new information.

A research session exploring your codebase might consume 50,000 tokens understanding architecture, reading files, tracing dependencies. When you hand that same session an implementation task, you're asking it to work in a cramped space, carrying irrelevant baggage.

The saturated agent makes mistakes. It confuses old context with new requirements. It references stale file contents. It reasons from outdated assumptions. The cost of a new agent is tokens (cheap); the cost of a confused agent is rework (expensive).

#### Phase Transitions Require Fresh Context

Different phases of work require different contexts:

**Research phase:**
- Broad exploration
- Reading many files
- Understanding architecture
- Tracing dependencies
- Building mental models

**Planning phase:**
- Focused on specific components
- Designing solutions
- Anticipating failures
- Creating task decomposition

**Implementation phase:**
- Narrow file set
- Precise edits
- Verification steps
- Testing protocols

**Validation phase:**
- Test results
- Behavior verification
- Regression checks
- Documentation updates

Each phase produces artifacts (findings, plans, code, test results). The next phase needs those artifacts, not the entire conversation that produced them.

A research agent reads 50 files and writes a 3-page findings document. The implementation agent needs the 3 pages, not the 50-file exploration history. Distill. Handoff. Spawn fresh.

#### The Single Issue Principle

Worker agents get a single issue, not a list.

When you assign an agent three issues at once, you force it to context-switch internally. It juggles three problem domains, three sets of files, three validation strategies. Quality suffers. Focus fragments.

Batch work belongs to orchestration layers (Convoys, Refineries). Individual workers execute atomically: one issue, full focus, complete closure.

If you have five similar issues, don't assign them all to one agent. Spawn five agents (or one agent, five times) in parallel. Each completes faster. Failures isolate. Learnings from early completions inform later ones.

#### The Handoff Protocol

Phase transitions are handoffs:

1. **Complete the current phase**
   - Produce artifacts (findings, plan, code, results)
   - Commit those artifacts to durable storage (files, beads, git)
   - End the session

2. **Prepare the handoff**
   - Distill learnings into summary form
   - Reference specific file paths, not "we changed X"
   - List dependencies for the next phase
   - Flag known blockers or risks

3. **Spawn the next phase**
   - New agent, clean window
   - Load only the distilled artifacts
   - Provide scoped instructions
   - Execute

The handoff document might be 500 words. The conversation that produced it might be 50,000 tokens. The next agent reads the 500 words, not the 50,000 tokens.

#### When to Spawn Fresh

Spawn a new agent when:

- **Phase transition**: Research → Planning → Implementation → Validation
- **Context saturation**: Window >70% full, losing room for new work
- **Task completion**: Finished one issue, starting another unrelated issue
- **Confusion**: Agent is contradicting itself, referencing stale information
- **Scope change**: Original task expanded into something significantly different
- **Stuck loop**: Agent tried the same approach 3+ times without progress

Don't spawn fresh when:

- **Mid-debugging**: Iterating on a solution in tight feedback loops
- **Clarification needed**: Quick back-and-forth to resolve ambiguity
- **Minor scope adjustment**: "Also update the docs" after code is done
- **Validation feedback**: Test failed, fix is straightforward

The cost of spawning is coordination overhead. The benefit is focus. Spawn when focus matters more than continuity.

#### The Anti-Pattern: The Eternal Session

The worst pattern: a single agent session that runs for hours, transitioning through research, planning, implementation, debugging, validation, documentation, and deployment.

This agent:
- Carries megabytes of irrelevant history
- Confuses old file contents with current state
- References decisions from two hours ago that no longer apply
- Loses track of what it already tried
- Burns context window on conversation turns, not task work

The eternal session feels efficient ("we're making progress!") but optimizes for local continuity at the expense of global quality. Each phase gets worse as the window fills.

End sessions early. Start fresh often. Optimize for quality, not conversation length.

#### The Multi-Issue Trap

Assigning multiple issues to one agent creates hidden problems:

**Cognitive load**: The agent must track state across multiple problems simultaneously.

**Interleaved context**: File reads from issue A pollute the context when working on issue B.

**Unclear closure**: Did the agent finish all issues, or just the first one?

**Failure blast radius**: If the agent gets confused mid-session, which issues are affected?

**Handoff ambiguity**: The next human (or agent) inherits partially-complete work across multiple issues.

Instead:

- **One agent, one issue**: Full focus, clear completion criteria
- **Parallel execution**: Spawn multiple agents for multiple issues
- **Sequential execution**: Complete issue A, spawn fresh for issue B
- **Convoy coordination**: Orchestration layer manages batch work, workers handle atomic units

The orchestration layer (Refinery, Convoy, human) sees the list of issues. The worker sees one issue. This separation of concerns prevents context pollution.

## What Good Looks Like

#### Research → Implementation Handoff

**Research agent** explores the codebase, produces findings document:

```markdown
# Auth System Research Findings

## Architecture
- Uses JWT tokens (jwt-go library)
- Token validation in middleware/auth.go:ValidateToken()
- User lookup in services/user.go:GetUserByID()

## Current Bug
- ValidateToken() doesn't check expiration timestamp
- Line 45: only validates signature, not `exp` claim

## Recommendation
- Add expiration check after signature validation
- Return 401 if token expired
- Update tests in middleware/auth_test.go
```

**Implementation agent** starts fresh, reads the findings, implements:

```bash
# New session, new agent
# Context: findings.md (500 words), not research transcript (50K tokens)

# Agent reads findings, edits middleware/auth.go, adds expiration check, updates tests
# Commits, closes issue, ends session
```

The implementation agent never saw the research conversation. It got the distilled result. Focus remains on implementation.

#### Issue Assignment: One at a Time

**Bad:**

```bash
# Assign three issues to one agent
gt sling sec-101,sec-102,sec-103 myrig
# Agent juggles three problems, context interleaves, quality suffers
```

**Good:**

```bash
# Convoy for coordination, workers get one issue each
gt convoy create "Security Fixes" sec-101 sec-102 sec-103
gt sling sec-101 myrig  # Worker A: full focus on sec-101
gt sling sec-102 myrig  # Worker B: full focus on sec-102
gt sling sec-103 myrig  # Worker C: full focus on sec-103
```

Each worker completes its issue independently. The Convoy tracks overall progress.

#### Detecting Saturation

You know an agent is saturated when:

- It references file contents from 10 conversation turns ago
- It contradicts earlier decisions without acknowledging the change
- It retries the same failed approach, forgetting it already tried
- It asks you questions it already asked earlier in the session
- The conversation history is so long you've lost track of what's been done

**Response:** End the session. Distill what you learned. Spawn fresh.

#### The Handoff Document Template

When ending a session mid-work, create a handoff:

```markdown
# Handoff: <Issue ID> - <Brief Description>

## What I Did
- Researched auth middleware (findings in docs/auth-research.md)
- Identified bug in token validation (line 45 of middleware/auth.go)
- Drafted fix but didn't implement (see draft below)

## What's Left
- Implement expiration check in ValidateToken()
- Add test case for expired tokens
- Update API documentation to mention 401 on expiration

## Context for Next Agent
- The bug is ONLY in middleware/auth.go — user service is fine
- Don't refactor the whole auth system — scoped fix only
- Existing tests use mock tokens — you'll need to generate expired one

## Blockers
- None known

## Files Modified (staged, not committed)
- docs/auth-research.md (new)

## Draft Fix
[Paste code snippet or pseudocode]
```

Next agent reads this, not the full conversation. Clean handoff.

#### Parallel Work: Fresh Agents, Same Rig

If you have five similar issues (e.g., "Add validation to endpoints"), spawn five agents:

```bash
# Create convoy for coordination
gt convoy create "Endpoint Validation" val-101 val-102 val-103 val-104 val-105

# Sling each issue to a fresh polecat
gt sling val-101 myrig  # Polecat A
gt sling val-102 myrig  # Polecat B
gt sling val-103 myrig  # Polecat C
gt sling val-104 myrig  # Polecat D
gt sling val-105 myrig  # Polecat E
```

Each polecat:
- Gets a fresh worktree (isolated filesystem)
- Gets a clean context window
- Focuses on one issue
- Completes and closes independently

The convoy tracks overall progress. Witness monitors individual polecats. Refinery merges completed work.

No single agent juggles five problems. Five agents each handle one.

#### When Continuity Matters

Not every task needs a fresh agent. Tight feedback loops benefit from continuity:

**Debugging session:**

```
Agent: I think the issue is in parseRequest(). Let me add debug logging.
[Adds logging, runs test]
Agent: The log shows the parser fails on null values. Let me add null check.
[Adds check, runs test]
Agent: Test passes. Committing.
```

This is one agent, one session, iterating rapidly. Fresh spawn would lose the debugging momentum.

**Rule of thumb:** If you're iterating on the same 2-3 files with tight feedback loops, stay in session. If you're transitioning to a new phase or different problem domain, spawn fresh.

#### The Research → Plan → Implement → Validate Cycle

Each phase gets a fresh agent:

**Research agent:**
- Explores codebase, understands architecture
- Produces findings document (docs/findings.md)
- Ends session

**Planning agent:**
- Reads findings document (not research transcript)
- Designs solution, creates task decomposition
- Produces plan document (docs/plan.md)
- Ends session

**Implementation agent:**
- Reads plan document (not planning conversation)
- Implements solution, updates tests
- Produces working code (committed to branch)
- Ends session

**Validation agent:**
- Reads plan document, runs tests
- Verifies behavior, checks edge cases
- Produces validation report (docs/validation.md)
- Closes issue, ends session

Each agent sees only the distilled output of the previous phase. No agent carries the full history. Quality improves at each phase.

#### Convoy Coordination

Convoys manage batch work by coordinating multiple single-issue agents:

```bash
# Create convoy for epic
gt convoy create "Auth Improvements" auth-101 auth-102 auth-103

# Convoy spawns workers as capacity allows
# Each worker gets one issue
# Convoy tracks completion, handles dependencies
```

The convoy sees the list. The workers see one item. Separation of concerns.

If auth-102 depends on auth-101, the convoy enforces that. Worker B doesn't start until Worker A finishes. Each worker still gets one issue, full focus.

#### The Session Length Heuristic

A good session length varies by phase:

- **Research**: 30-60 minutes of active exploration, then distill and end
- **Planning**: 15-30 minutes of design work, then document and end
- **Implementation**: 20-40 minutes of focused coding, then commit and end
- **Validation**: 10-20 minutes of testing, then report and end

If a session runs past 90 minutes, it's probably doing too much. Consider splitting into phases.

If a session runs past 2 hours, it's definitely saturated. End it. Distill. Spawn fresh.

## Without Tooling

If you're working with agents without formal orchestration tools, apply the principle manually:

#### Start New Sessions

When your conversation with an agent gets long (>50 exchanges) or confused, start a new chat session.

Don't paste the entire conversation history into the new session. Distill what you learned:

**Bad:**

```
[New session]
You: [Pastes 10,000 words of conversation history]
You: Now implement the fix.
```

**Good:**

```
[New session]
You: We discovered the auth bug is in token validation, line 45 of middleware/auth.go.
It doesn't check the expiration timestamp. Implement a fix: add expiration check,
return 401 if expired, update tests. Findings doc is in docs/auth-research.md.

[Attach findings.md as file]
```

The agent gets the conclusion, not the journey. Clean window.

#### One Issue per Session

Don't assign an agent three issues in one conversation:

**Bad:**

```
You: Fix issues #101, #102, and #103.
Agent: [Works on 101, gets confused, tries 102, context interleaves, quality drops]
```

**Good:**

```
[Session 1]
You: Fix issue #101.
Agent: [Fixes 101]
You: Thanks, closing this session.

[Session 2]
You: Fix issue #102.
Agent: [Fixes 102]
You: Thanks, closing this session.

[Session 3]
You: Fix issue #103.
Agent: [Fixes 103]
You: Done.
```

Three focused sessions beat one overloaded session.

#### Recognize Saturation

If your agent:
- Contradicts itself
- References old file contents you've since updated
- Forgets what it already tried
- Loops on the same failed approach
- Asks repeated questions

End the session. Distill what you learned. Start fresh. Give it the summary, not the saturated window.

#### Phase-Based Sessions

Structure your workflow as phase-based sessions:

**Research session:**

```
You: Explore the auth system and tell me how token validation works.
Agent: [Researches, explains]
You: Great. Write your findings to docs/auth-research.md.
Agent: [Writes file]
You: Thanks. [End session]
```

**Implementation session:**

```
[New session]
You: Read docs/auth-research.md. Implement the fix described in the recommendations.
Agent: [Reads file, implements]
You: Thanks. [End session]
```

Each session has one job. Clean input, focused execution, clear output.

#### The Handoff Note

When ending a session with incomplete work, write a handoff note for yourself (or the next agent):

```markdown
# Session ended 2026-02-15 14:30

## What we did
- Researched auth bug
- Found issue in middleware/auth.go line 45
- Wrote findings to docs/auth-research.md

## What's next
- Implement expiration check
- Add test for expired tokens

## Context
- Only touch middleware/auth.go — don't refactor the whole system
- Mock tokens in tests need expiration timestamp added
```

Next session, you (or the next agent) read this, not the conversation transcript. Efficiency.

#### Parallel Work: Multiple Sessions

If you have five similar issues, open five separate chat sessions (or run them sequentially with fresh sessions):

```
[Session A]
You: Fix validation in /api/users endpoint.
Agent: [Fixes]

[Session B]
You: Fix validation in /api/posts endpoint.
Agent: [Fixes]

[Session C]
You: Fix validation in /api/comments endpoint.
Agent: [Fixes]

...
```

Each session: one problem, full focus. No context pollution.

If you need all five done simultaneously and your platform supports it, literally open five browser tabs or five terminal sessions. Parallel execution, isolated contexts.

#### Document, Don't Carry

After each phase, document the result in a file:

- Research phase → findings.md
- Planning phase → plan.md
- Implementation phase → code + commit message
- Validation phase → validation.md

Next phase loads the document, not the conversation. This forces you to distill.

If you can't summarize the phase output in a document, the phase wasn't complete. Keep working until you can distill.

#### The 50-Exchange Rule

If your conversation with an agent exceeds 50 exchanges (100 messages total), it's saturated. End it.

Either:
1. You're done → Close the issue, end session
2. You're mid-work → Distill what you learned, end session, spawn fresh with summary

Don't continue past saturation hoping the agent "remembers." It won't. The window is full. Start fresh.

#### The Confusion Signal

The clearest signal to spawn fresh: the agent is confused.

If it references stale information, contradicts earlier statements, or loops on failed approaches, the context is polluted. No amount of clarification will fix it — the window is already full of contradictions.

End the session. Distill the current state. Spawn fresh. Give it clean input.

Confusion is not a sign of a bad agent. It's a sign of a saturated window. Treat it as a technical constraint, not a performance issue.

### Summary

One agent, one job. Fresh context per task. Never reuse a saturated window.

Research agents produce findings. Planning agents produce plans. Implementation agents produce code. Validation agents produce reports. Each phase gets a fresh agent with only the distilled output of the previous phase.

Worker agents get a single issue, not a list. Orchestration layers (Convoys, Refineries) manage batch work. Workers execute atomically.

When a session gets long or confused, end it. Distill what you learned. Spawn fresh. Optimize for quality, not conversation length.

The cost of a new agent is tokens (cheap). The cost of a confused agent is rework (expensive). Spawn generously. Focus ruthlessly. Execute cleanly.
