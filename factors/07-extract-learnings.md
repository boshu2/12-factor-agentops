# VII. Extract Learnings

## The Rule

Every session produces two outputs — the work product and the lessons learned.

The work is visible. The code merged, the bug fixed, the feature shipped. Everyone celebrates the work product. But there's a second output that most teams throw away: the knowledge generated during the session.

Every debugging session where you finally found the root cause. Every architectural decision made under pressure. Every dead end explored and abandoned. Every pattern discovered in the codebase. Every workaround invented for a thorny edge case.

This knowledge exists for exactly as long as the session stays open. The moment you close the tab, it evaporates. Tomorrow you'll rediscover the same root cause. Next week someone else will explore the same dead end. Next month you'll re-litigate the same architectural decision because no one remembers why you chose the current approach.

**Extraction is the difference between organizational learning and organizational amnesia.**

Most people think they'll remember. They won't. Most people think the commit message is enough. It isn't. Most people think "the code is the documentation." The code shows what you built, not why you built it that way, not what you tried first, not what traps to avoid.

A session you didn't extract from is a session the organization forgot.

---

## The Rationale

### The Knowledge Generation Rate

Every work session generates knowledge at a predictable rate:

**During execution:**
- Which approach worked vs which failed
- Why certain patterns exist in the codebase
- What mental models help navigate complexity
- Which edge cases matter and which don't
- What the critical decision points were
- Where future maintainers will get confused

**Without extraction:**
- This knowledge exists in your head for ~24 hours
- It fades to vague impressions in a week
- It's completely gone in a month
- The next person starts from zero

**With extraction:**
- Knowledge becomes searchable artifacts
- Patterns become reusable templates
- Decisions become traceable rationale
- Mistakes become institutional memory

The math is brutal: if you run 20 sessions a month and extract nothing, you generate zero institutional knowledge. If you extract from every session, you accumulate 240 knowledge artifacts per year.

### The Symptoms of Missing Extraction

You can diagnose missing extraction by observable symptoms:

**Symptom: Repetitive mistakes**
- Same bug reintroduced across sessions
- Same architectural dead ends explored repeatedly
- Same integration traps hit over and over

**Root cause:** No one extracted what failed last time.

**Symptom: Constant re-explanation**
- New team members ask the same questions
- "Why did we build it this way?" has no answer
- Tribal knowledge locked in senior developers' heads

**Root cause:** Decisions were never documented when they were made.

**Symptom: No recall of prior work**
- "Didn't we already solve this?"
- "I think we tried that before but I don't remember why it didn't work"
- Searching the codebase finds the code but not the context

**Root cause:** Work products exist, learnings don't.

**Symptom: Fear of refactoring**
- No one knows why the code is shaped this way
- Changing it might break invisible invariants
- "Just leave it, it works"

**Root cause:** The original design rationale was never extracted.

### What Gets Extracted

Not everything is worth extracting. Focus on knowledge with half-life longer than your memory:

**High-value extractions:**
- **Decisions and rationale** - "We chose approach X over Y because Z"
- **Non-obvious patterns** - "This module uses factory pattern to handle N edge cases"
- **Failure modes** - "Tried dependency injection, caused circular imports, reverted"
- **Integration gotchas** - "API requires auth token in header AND query param"
- **Mental models** - "Think of the queue as a state machine, not a list"

**Low-value extractions:**
- Obvious facts derivable from code
- Step-by-step what you did (that's the commit)
- Vague impressions without specifics
- "It was hard" without explaining why

**The test:** Will this help someone (including future you) avoid wasting time or make a better decision?

### Extraction Is Deliberate, Not Automatic

Your brain doesn't naturally produce good extractions. During execution, you're thinking in implementation details. You need a deliberate shift:

**During the session:** Focus on solving the problem
**At session end:** Step back and ask extraction questions

If you try to extract while coding, you'll slow down execution. If you finish coding and immediately close the tab, you'll lose everything. The extraction phase is a distinct activity with distinct value.

This is why tools exist for post-session extraction: `/post-mortem`, `/retro`, `ao forge transcript`. They force the deliberate shift from "what did I do" to "what did I learn."

---

## What Good Looks Like

### Good Extraction: Structured Artifacts

Bad extraction is a wall of text in a scratch file. Good extraction is structured, tagged, and retrievable.

**Example: Decision Record**

```markdown
# Decision: Use SQLite for local cache (not Redis)

## Context
Need persistent cache for API responses to reduce latency.
Considering SQLite vs Redis for local deployment.

## Decision
SQLite with 5-minute TTL.

## Rationale
- No external dependencies (Redis requires separate process)
- Sufficient performance for <10k entries
- File-based: easy backup/debugging
- Built-in expiration via DELETE trigger

## Alternatives Considered
- Redis: Better performance but operational complexity
- In-memory dict: No persistence across restarts
- File cache: No query capability, manual expiration

## Consequences
- If cache grows >10k entries, revisit Redis
- Backup strategy: copy .db file (no dump/restore needed)
- Testing: Use :memory: db for unit tests

## Tags
#architecture #caching #sqlite #decisions

Date: 2026-02-15
Session: ag-2047
```

**Why this works:**
- Future you searching for "cache" finds this
- Someone questioning the choice sees the rationale
- Performance problems? You documented the threshold to revisit
- Testing approach preserved

**Bad version:**

```
decided to use sqlite for caching because it's simpler
```

That tells you nothing. Why simpler? Simpler than what? What if it's not simple enough?

### Good Extraction: Failure Documentation

Most teams only document what worked. Elite teams document what failed.

**Example: Failed Approach Log**

```markdown
# Failed Approach: Token-based auth for WebSocket

## What We Tried
Pass JWT in WebSocket URL query parameter for authentication.

## Why It Failed
- Query params logged in plaintext (security issue)
- URL length limit ~2000 chars (tokens can be 500+)
- Browser history captures full URL (leak risk)

## Observable Symptoms
- Auth failures for long-lived tokens
- Security scanner flagged query param secrets
- Tokens visible in server access logs

## What We Did Instead
Use Sec-WebSocket-Protocol header for token (RFC 6455).
Client sends token in header, server validates before upgrade.

## Lessons
- Never put secrets in URLs (even over HTTPS)
- WebSocket headers are the blessed path for auth
- Test with production-sized tokens, not "test123"

## Tags
#websocket #authentication #failures #security

Date: 2026-02-15
Session: ag-2048
```

**Why this works:**
- Next person trying query param auth finds this first
- Security reasoning preserved
- Observable symptoms help diagnosis
- Solution documented alongside failure

**Bad version:**

```
tried query params but didn't work, used headers instead
```

That saves no one any time. What about query params didn't work? Why headers?

### Good Extraction: Pattern Catalog

As you work in a codebase, you discover patterns. Extract them.

**Example: Pattern Documentation**

```markdown
# Pattern: Retry with Exponential Backoff

## Where Used
- `api/client.go`: External API calls
- `queue/consumer.go`: Message processing
- `db/migrations.go`: Schema updates

## Structure
```go
func withRetry(fn func() error, maxAttempts int) error {
    for attempt := 1; attempt <= maxAttempts; attempt++ {
        err := fn()
        if err == nil {
            return nil
        }
        if !isRetryable(err) {
            return err
        }
        backoff := time.Duration(math.Pow(2, float64(attempt))) * time.Second
        time.Sleep(backoff)
    }
    return fmt.Errorf("max retries exceeded")
}
```

## When to Use
- Network calls to external services
- Operations with transient failures
- Race condition mitigation

## When NOT to Use
- User input validation (fail fast)
- Internal function calls (fix the bug)
- Operations with side effects (idempotency required first)

## Gotchas
- Exponential backoff can create retry storms (add jitter)
- Max backoff should cap at reasonable time (e.g., 30s)
- Log each retry attempt for debugging
- Ensure `isRetryable` is accurate (don't retry auth failures)

## Related Patterns
- Circuit Breaker (when retries aren't enough)
- Timeout Wrapper (prevent infinite hangs)

## Tags
#patterns #retry #reliability #networking

Date: 2026-02-15
Session: ag-2049
```

**Why this works:**
- New code can follow the pattern
- Gotchas prevent common mistakes
- When NOT to use prevents misapplication
- Related patterns guide next steps

**Bad version:**

```
we use retries with exponential backoff in a few places
```

Where? How? When should I use it? When shouldn't I?

### Good Extraction: Codebase Mental Models

The most valuable extractions are mental models — how to think about the system.

**Example: Mental Model Documentation**

```markdown
# Mental Model: Pipeline as State Machine

## The Insight
Don't think of the processing pipeline as a sequence of functions.
Think of it as a state machine where each stage is a state transition.

## Why This Matters
- Makes error handling obvious (invalid transitions)
- Makes logging obvious (state change events)
- Makes testing obvious (verify state transitions)
- Makes debugging obvious (which state transition failed)

## The States
```
RECEIVED → VALIDATED → ENRICHED → PROCESSED → COMPLETED
     ↓          ↓           ↓           ↓
  REJECTED  REJECTED   REJECTED    FAILED
```

## Code Manifestation
```go
type PipelineState int

const (
    StateReceived PipelineState = iota
    StateValidated
    StateEnriched
    StateProcessed
    StateCompleted
    StateRejected
    StateFailed
)

func (p *Pipeline) Transition(to PipelineState) error {
    if !p.isValidTransition(p.state, to) {
        return fmt.Errorf("invalid transition %v -> %v", p.state, to)
    }
    p.emit(StateTransitionEvent{From: p.state, To: to})
    p.state = to
    return nil
}
```

## Before This Mental Model
- Functions called functions (no structure)
- Error handling ad-hoc
- Hard to answer "where did this fail?"
- Testing focused on happy path

## After This Mental Model
- Clear state transitions (invalid ones rejected)
- Error handling is transition logic
- Every failure has a terminal state
- Testing covers all transitions

## Applying It
When adding a new pipeline stage:
1. Define the new state
2. Define valid transitions to/from it
3. Implement transition logic
4. Add tests for invalid transitions
5. Add logging for state changes

## Tags
#mental-models #architecture #state-machine #pipeline

Date: 2026-02-15
Session: ag-2050
```

**Why this works:**
- Transforms how you think about the code
- Before/after comparison shows impact
- Application guide makes it actionable
- New features inherit the model

**Bad version:**

```
the pipeline is kind of like a state machine
```

Kind of? How? What changes if I think of it that way?

### Good Extraction: Integration Gotchas

APIs lie. Docs are wrong. Behavior is weird. Extract the truth.

**Example: Integration Gotcha Documentation**

```markdown
# Integration Gotcha: GitHub API Rate Limits

## The Official Story
GitHub API allows 5000 requests/hour with authentication.

## The Actual Behavior
- Limit is per-token, not per-application
- Limit resets at fixed time (not sliding window)
- Some endpoints count as multiple requests (GraphQL)
- Search API has separate limit (30 requests/min)
- Conditional requests (If-None-Match) don't count if not modified

## What This Means
- Don't share tokens across parallel workers
- Cache reset time, don't spam retry
- Use GraphQL carefully (can burn 10+ requests in one call)
- Use search sparingly or separate token
- Use ETags religiously (free requests)

## How We Got Burned
Initially used single token for all workers. Hit rate limit in 15 minutes
because GraphQL queries counted as ~50 requests each.

## The Fix
```go
// Bad: Single shared token
client := github.NewClient(sharedToken)

// Good: Token pool with rate tracking
pool := NewTokenPool(tokens)
client := pool.GetClient() // Rotates to next available
```

## Observable Symptoms When You Violate This
- 403 responses with "rate limit exceeded"
- X-RateLimit-Remaining header at 0
- Mysterious failures at top of hour
- GraphQL succeeding but requests depleted

## Tags
#integration #github #rate-limiting #gotchas #api

Date: 2026-02-15
Session: ag-2051
```

**Why this works:**
- Official story vs reality documented
- How you got burned prevents repetition
- Observable symptoms aid debugging
- Fix is concrete code

**Bad version:**

```
watch out for github rate limits
```

Watch out how? What specifically? What happens if I don't?

### The Extraction Workflow

**At session end:**

1. **Trigger extraction** - `/post-mortem`, `/retro`, or manual review
2. **Answer extraction questions:**
   - What did I decide and why?
   - What approaches failed and why?
   - What patterns did I discover?
   - What gotchas should others know?
   - What mental model helps here?

3. **Create structured artifacts:**
   - Decision records
   - Failure logs
   - Pattern documentation
   - Mental model guides
   - Integration gotcha notes

4. **Tag and file appropriately:**
   - Add to knowledge base
   - Link from related code
   - Update project docs
   - Feed to AgentOps flywheel

5. **Make it searchable:**
   - Descriptive titles
   - Relevant tags
   - Observable symptoms for debugging
   - Keywords future you will search for

**Time investment:** 5-15 minutes per session
**ROI:** Prevents hours of duplicate work

### Extraction Formats

Different knowledge types need different formats:

| Knowledge Type | Format | Example |
|---------------|---------|---------|
| Decisions | Decision record | "Why we chose X" |
| Failures | Failure log | "Why approach Y failed" |
| Patterns | Pattern catalog | "How we handle Z" |
| Gotchas | Gotcha documentation | "API quirk W" |
| Mental models | Model guide | "Think of it as..." |
| Integration | Integration notes | "Service S behavior" |
| Debugging | Symptom-solution map | "Error E means F" |

**Consistency matters.** Use templates so extractions are comparable and searchable.

### Tools for Extraction

**Manual extraction:**
- End-of-session markdown files
- Decision records in `/docs/decisions/`
- Pattern catalog in `/docs/patterns/`
- ARCHITECTURE.md updates

**AgentOps extraction:**
- `/post-mortem` - Structured session analysis
- `/retro` - Team retrospective
- `ao forge transcript` - Mine session for learnings
- `ao pool promote` - Elevate extractions to knowledge base

**Storage locations:**
- **Project docs** - `/docs/` for project-specific knowledge
- **Knowledge base** - AgentOps pools for cross-project patterns
- **Wiki** - For broad organizational knowledge
- **Code comments** - For localized gotchas

**The key:** Pick a system and use it consistently. Inconsistent extraction is only marginally better than no extraction.

### Extraction Smells

Bad extraction has tells:

**Smell: Vague summaries**
- "Had some trouble with the API but figured it out"
- What trouble? How did you figure it out?

**Smell: No decisions documented**
- Code changed but no record of why
- Future refactors will repeat the analysis

**Smell: Only happy path documented**
- "Here's how it works"
- What about how it fails? What doesn't work?

**Smell: No observable symptoms**
- "Authentication was broken"
- How did you know? What did you see?

**Smell: Solutions without context**
- "Use approach X"
- Why? Instead of what? When not to use X?

**Good extraction answers:** What? Why? How? When? When not? What else did you try? What should someone watch out for?

### Organizational Impact

Extraction quality compounds:

**Month 1: Individual benefit**
- You stop repeating your own mistakes
- You recall decisions you made

**Month 3: Team benefit**
- New teammates find answers in extracted knowledge
- Less re-explanation required

**Month 6: Organizational benefit**
- Common patterns cataloged
- Decisions traceable
- Onboarding faster

**Year 1: Institutional knowledge**
- Codebase is navigable by extraction index
- Architectural evolution is documented
- Mistakes are not repeated across teams

**Without extraction:** Every session starts from zero. Knowledge resets with every personnel change. The organization has no memory.

**With extraction:** Knowledge accumulates. Each session builds on prior learnings. The organization gets smarter over time.

### The Discipline

Extraction is not natural. After solving a hard problem, your brain wants celebration, not documentation. After a long session, you want to close the laptop, not write markdown.

**This is why extraction must be part of the workflow.**

Not "extract if you feel like it." Not "extract the big stuff." Not "extract when you have time."

**Extract from every session.** Small extractions are fine. One decision record. One failure note. One pattern observation.

**The rule:** If it's worth doing, it's worth extracting from.

If you're not going to extract, question whether the session was valuable. If the session was valuable, the extraction is mandatory.

### Extraction vs. Documentation

These are different activities:

**Documentation:** Describes how the system works
- "The API returns JSON with these fields"
- "Call function X with parameter Y"
- Answers: How do I use this?

**Extraction:** Describes how the system came to work this way
- "We chose JSON over XML because..."
- "Function X exists to handle edge case Y"
- Answers: Why is it like this?

Both matter. Documentation enables usage. Extraction enables change.

**You need both.** Code without documentation is hard to use. Code without extraction is hard to modify.

### The Extraction Mindset

**During the session:** You're in execution mode
- Trying approaches
- Making decisions
- Discovering patterns
- Hitting obstacles

**At session end:** Shift to extraction mode
- Which approaches worked/failed?
- Which decisions matter?
- Which patterns are reusable?
- Which obstacles will others hit?

The mindset shift is critical. If you try to extract in execution mode, you'll slow down. If you skip extraction mode entirely, you'll forget everything.

**The discipline:** Every session has two phases. Execution, then extraction. Both are required.

### Measuring Extraction Quality

You can measure whether extraction is working:

**Leading indicators:**
- Extraction artifacts produced per session
- Extraction artifacts referenced in later work
- Time spent on extraction

**Lagging indicators:**
- Repetitive mistakes declining
- Onboarding time decreasing
- "Why did we do it this way?" questions dropping
- Refactoring confidence increasing

**If extractions are never referenced:** They're not useful. Improve searchability or content quality.

**If same questions keep arising:** Extraction is missing or not findable.

**The goal:** Every major decision, failure, and pattern is extracted and retrievable.

---

## Examples

### Example: Bad Session (No Extraction)

```
Session ag-2052: Fixed authentication bug

Work done:
- Found issue in token validation
- Updated middleware
- Tests passing
- Merged PR

Extraction: (none)
```

**Three months later:** Someone hits the same bug in a different service. Spends 4 hours debugging. Finds the merged PR but not the rationale. Implements a different fix. Now two services solve the same problem differently.

**Cost of missing extraction:** 4 hours duplicate work + inconsistent patterns

### Example: Good Session (With Extraction)

```
Session ag-2052: Fixed authentication bug

Work done:
- Found issue in token validation
- Updated middleware
- Tests passing
- Merged PR

Extraction:

# Bug: Token Validation Fails for Refresh Tokens

## Symptom
401 errors for valid refresh tokens.
Access tokens work fine.

## Root Cause
Middleware validates token signature but doesn't check token type.
Refresh tokens use different signing key.

## Fix
Added token type check before signature validation:

```go
func validateToken(token string) error {
    tokenType := extractTokenType(token)
    key := getKeyForType(tokenType) // Different keys!
    return verifySignature(token, key)
}
```

## Why This Wasn't Caught
- Unit tests only used access tokens
- Integration tests didn't exercise refresh flow
- Token type was in payload, not verified before signature check

## Prevention
- Added test case for refresh tokens
- Documented token types in auth README
- Added type check to linter rules

## Related
- See docs/auth/token-types.md for full token spec
- See docs/decisions/002-token-signing.md for key separation rationale

Tags: #authentication #bugs #tokens #security
```

**Three months later:** Someone working on refresh tokens searches for "refresh token." Finds this extraction. Understands the token type system. Implements new feature correctly. No bugs. No duplicate debugging.

**Value of extraction:** 4 hours saved + consistency maintained

### Example: Extracted Decision

```markdown
# Decision 003: Use gRPC for Internal Services

## Context
Microservices communicate frequently. Need efficient, type-safe RPC.
Considering REST, gRPC, GraphQL for internal communication.

## Decision
gRPC for all internal service-to-service communication.
REST reserved for external-facing APIs only.

## Rationale
**Pros:**
- Binary protocol (faster than JSON)
- Schema-first (protobuf prevents drift)
- Streaming support (long-running operations)
- Code generation (clients in all languages)

**Cons:**
- Harder to debug (binary, not text)
- Steeper learning curve
- Requires HTTP/2 (infrastructure requirement)

**Why not REST:**
- JSON overhead for internal chatty calls
- Schema drift common without enforcement
- No built-in streaming

**Why not GraphQL:**
- Over-fetching not a concern internally
- Complexity not worth it for point-to-point RPC
- gRPC faster for our access patterns

## Consequences
- All new services must define .proto files
- Debugging requires grpcurl or specialized tools
- Load balancers must support HTTP/2
- External APIs remain REST (no change)

## Success Metrics
- Inter-service latency <50ms p99
- Schema drift incidents zero
- New service integration time <1 day

## Review Date
2026-08-15 (6 months) - Evaluate if decision still holds

## Tags
#architecture #grpc #microservices #decisions

Date: 2026-02-15
Session: ag-2053
```

**Why this works:** Six months from now when someone questions "why gRPC?" this extraction answers it. When evaluating a new technology, this provides the comparison framework. When debugging latency, this sets the success criteria.

### Example: Extracted Failure

```markdown
# Failed Approach: Event Sourcing for User Preferences

## What We Tried
Store user preferences as event stream (event sourcing pattern).
Replay events to reconstruct current state.

## Why It Sounded Good
- Audit trail of all preference changes
- Temporal queries ("what were settings on date X")
- Undo/redo capability

## What Actually Happened
- State reconstruction slow (100+ events for active users)
- Queries require full replay (no indexing)
- Event schema migration nightmare
- Complexity overwhelmed benefits

## Observable Failures
- Preference load time >500ms for active users
- "What's the current value" requires scanning event log
- Event schema v1 incompatible with v2 (migration broke)
- Simple "update preference" required event versioning

## What We Did Instead
Traditional update-in-place with audit log table:

```sql
CREATE TABLE user_preferences (
    user_id INT PRIMARY KEY,
    theme VARCHAR,
    notifications BOOLEAN,
    updated_at TIMESTAMP
);

CREATE TABLE preference_audit (
    id SERIAL PRIMARY KEY,
    user_id INT,
    field VARCHAR,
    old_value VARCHAR,
    new_value VARCHAR,
    changed_at TIMESTAMP
);
```

## Why This Works
- Current state is single row read (fast)
- Audit trail still exists (separate table)
- Schema changes are normal migrations
- Simplicity appropriate for problem size

## Lessons
- Event sourcing is not free
- Most problems don't need temporal queries
- Complexity must be justified by requirements
- Simple solutions can still provide audit trails

## When Event Sourcing Might Work
- Financial transactions (audit critical)
- Collaborative editing (conflict resolution)
- True temporal requirements (not nice-to-have)

## Tags
#failures #event-sourcing #architecture #over-engineering

Date: 2026-02-15
Session: ag-2054
```

**Why this works:** Prevents someone else from making the same mistake. Documents when event sourcing might be appropriate. Provides the simpler alternative.

---

## Without Tooling

You don't need a knowledge flywheel or extraction CLI. You need five minutes at the end of every session.

### The End-of-Session Ritual

Before closing any work session, answer four questions in a text file:

1. **What did I decide?** — Any non-obvious choices, with the reasoning
2. **What failed?** — Approaches that didn't work, and why
3. **What pattern did I discover?** — Reusable insights about the codebase or tools
4. **What will trip up the next person?** — Gotchas, edge cases, surprising behavior

### Where to Put Extractions

Create a `learnings/` directory in your project. One file per session:

```
learnings/
  2026-02-15-auth-refactor.md
  2026-02-16-api-migration.md
```

### The Minimum Viable Extraction

Even a three-line commit message body is better than nothing:

```
fix: resolve race condition in session handler

Root cause: concurrent map access without mutex.
Tried channel-based approach first — too complex for this use case.
Simple sync.RWMutex was sufficient.
```

That's extraction. Three lines. Thirty seconds. The next person who hits the same race condition finds this in `git log` and saves an hour.

### Building the Habit

- **Set a timer** — when your session hits 90 minutes, pause and extract
- **Extract before committing** — make it part of your commit workflow
- **Review your own extractions** — they should be useful to someone who wasn't in the session
- **Keep them searchable** — use consistent headings so grep works

---

## The Bottom Line

**You are responsible for two outputs:**

1. **The work product** - Code, features, fixes
2. **The knowledge product** - What you learned doing it

Most teams only care about #1. They ship code and forget the process. Six months later they can't remember why they made the decisions they made. They repeat mistakes. They re-explore dead ends. They lose institutional knowledge with every personnel change.

**Elite teams extract from every session.**

They document decisions when they make them. They catalog patterns as they discover them. They record failures so others won't repeat them. They build mental model guides that transform how people think.

**The discipline is simple:**

At the end of every session, before you close the tab, ask:
- What did I decide?
- What failed?
- What pattern emerged?
- What will trip up the next person?

Then create structured artifacts answering those questions.

Five minutes of extraction can save five hours of duplicate work.

**A session you didn't extract from is a session the organization forgot.**

Don't let your knowledge evaporate. Extract it. Structure it. Make it searchable.

Your future self will thank you. Your teammates will thank you. Your organization will accumulate knowledge instead of resetting to zero with every personnel change.

**Extract from every session. No exceptions.**
