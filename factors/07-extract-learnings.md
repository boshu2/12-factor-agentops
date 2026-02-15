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

You can diagnose missing extraction by these patterns:

- **Repetitive mistakes** — Same bugs, same dead ends, same integration traps across sessions. No one extracted what failed last time.
- **Constant re-explanation** — New team members ask questions with no written answers. Tribal knowledge locked in senior developers' heads.
- **No recall of prior work** — "Didn't we already solve this?" The code exists but not the context around it.
- **Fear of refactoring** — No one knows why the code is shaped this way. "Just leave it, it works."

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

Your brain doesn't naturally produce good extractions. During execution, you're in implementation mode. At session end, you need a deliberate shift to ask: "What did I learn?"

If you try to extract while coding, you'll slow down. If you close the tab without extracting, you'll forget everything. The extraction phase is distinct from execution — and both are required.

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

### Good Extraction: Mental Models and Gotchas

The most valuable extractions are mental models (how to think about the system) and integration gotchas (where reality diverges from documentation).

**Mental model example:** Don't just note "the pipeline is kind of like a state machine." Document the states, transitions, why this framing helps, and how to apply it when adding new stages. A good mental model extraction transforms how people think about the code.

**Integration gotcha example:** Don't just write "watch out for GitHub rate limits." Document the official story vs actual behavior, how you got burned, the fix with code, and observable symptoms. Future developers need specifics to avoid repeating your mistakes.

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

Use templates so extractions are comparable and searchable. Pick a system and use it consistently — inconsistent extraction is only marginally better than no extraction.

### Extraction Smells

Bad extraction has tells: vague summaries ("had some trouble but figured it out"), no decisions documented, only happy path covered, no observable symptoms, and solutions without context.

**Good extraction answers:** What? Why? How? When? When not? What else did you try? What should someone watch out for?

### The Discipline

Extraction is not natural. After solving a hard problem, your brain wants celebration, not documentation. This is why extraction must be part of the workflow — not optional, not "when you have time."

**Extract from every session.** Small extractions are fine. One decision record. One failure note. One pattern observation. If the session was valuable, the extraction is mandatory.

Note that extraction differs from documentation. Documentation describes how the system works ("call function X with parameter Y"). Extraction describes how it came to work this way ("we chose X over Y because Z"). Documentation enables usage. Extraction enables change. You need both.

### Organizational Impact

Extraction quality compounds. Month 1: you stop repeating your own mistakes. Month 3: new teammates find answers without asking. Month 6: common patterns are cataloged and decisions are traceable. Year 1: architectural evolution is documented and mistakes are not repeated across teams.

**Without extraction:** Every session starts from zero. The organization has no memory. **With extraction:** Knowledge accumulates. The organization gets smarter over time.

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

See the "What Good Looks Like" section above for additional extraction formats: decision records, failure logs, and pattern catalogs.

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
