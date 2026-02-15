# IV. Research Before You Build

**Understand the problem space before generating a single line of code.**

---

## The Rule

Every implementation begins with research. Every single one.

You don't start writing code until you've explored the codebase, understood existing patterns, identified relevant files, and documented your findings. Research is a distinct phase that produces findings, not code. Those findings become scoped context for the implementation phase.

No exceptions. No shortcuts. No "I'll just quickly add this feature real fast."

**Research first. Build second. Always.**

---

## The Rationale

### Why This Matters

Agents that skip research produce plausible-looking code that doesn't fit.

You've seen this pattern: an agent gets a feature request, generates a beautiful implementation, runs the tests, everything passes. Except the code duplicates an existing utility. Or contradicts an architectural decision. Or breaks a convention used everywhere else in the codebase. The code works in isolation but fails the integration test—does it fit with everything that already exists?

The problem isn't the agent's coding ability. The problem is information asymmetry. The agent generated code without understanding the context it would live in.

**Research closes that gap.** It transforms "generate code that solves this problem" into "generate code that solves this problem in a way that fits this specific codebase."

### Measure Twice, Cut Once

Every carpenter knows this principle. Every craftsperson who's ever cut a board too short, drilled a hole in the wrong place, or welded two pieces that don't quite align.

Measure twice. Cut once.

In software, research is the measuring. Implementation is the cutting. And just like woodworking, the measuring takes far less time than fixing a bad cut.

Ten minutes of research can save hours of rework. Thirty minutes of exploration can prevent days of architectural mismatch. An hour of understanding existing patterns can eliminate entire classes of bugs before they're written.

The math is simple: research is cheap, rework is expensive, and throwing away code hurts.

### The Hidden Cost of "Just Do It"

When you skip research, you're not saving time. You're deferring discovery.

Instead of spending 15 minutes finding the existing authentication helper, you spend an hour writing a new one. Then you discover the existing helper during code review. Now you've written code that needs to be deleted.

Instead of spending 20 minutes understanding the error handling convention, you invent your own. Then you discover that every other module uses a different pattern. Now you've created inconsistency that will confuse every future reader.

Instead of spending 10 minutes checking if a utility exists, you implement it from scratch. Then you discover three other implementations scattered across the codebase. Now you've contributed to the duplication problem.

**Every shortcut in research becomes a long road in implementation.**

### Research Produces Reusable Context

Here's the real power move: research findings persist.

When you document what you learned during research, you create context that can be reused across sessions, shared with other agents, and referenced by future work. That 30-minute investigation into the database schema becomes a resource that saves time on every subsequent database feature.

Research findings become part of your knowledge base. They accumulate. They compound. The more you research, the faster future research becomes, because you're building on previous understanding instead of starting from zero.

**Research isn't a cost. It's an investment.**

---

## What Good Looks Like

### The Research Phase is Explicit

Good agent workflows have a distinct research phase that happens before implementation.

```bash
# Phase 1: Research (produces findings)
ao research --target "authentication system"

# Phase 2: Implementation (consumes findings)
ao implement --bead auth-123
```

You can tell when research happened. You can see the boundary between understanding and building. The phases are separated, not interleaved.

Bad agent workflows jump straight to implementation and do "just-in-time research" while generating code. This creates the illusion of speed but produces mismatched code.

### Research Findings Are Documented

Good research produces artifacts you can read, reference, and reuse.

```markdown
# Research Findings: Authentication System

## Existing Implementation
- Location: `src/auth/authenticator.py`
- Pattern: Token-based JWT with refresh tokens
- Storage: Redis for session state
- Convention: All auth middleware inherits from `BaseAuthMiddleware`

## Relevant Files
- `src/auth/authenticator.py` - Main auth logic
- `src/auth/middleware.py` - Request middleware
- `src/auth/tokens.py` - Token generation/validation
- `tests/auth/test_authenticator.py` - Test patterns

## Key Decisions
- Tokens expire after 15 minutes (design doc: ADR-007)
- Refresh tokens use rotating secrets
- Failed auth attempts rate-limited at middleware layer

## Integration Points
- User service for credential validation
- Session service for token storage
- Audit log for auth events

## Recommendations
- New auth providers should subclass `BaseAuthProvider`
- Follow test patterns in `test_authenticator.py`
- Rate limiting handled automatically by middleware
```

This document is the bridge between research and implementation. It tells the implementer (you or another agent) exactly what context matters.

### Research Scope Is Explicit

Good research defines boundaries. You're not exploring the entire codebase—you're investigating specific questions.

**Clear scope:**
- "Understand how error handling works in API routes"
- "Find existing date formatting utilities"
- "Identify authentication middleware patterns"
- "Map database schema for user tables"

**Unclear scope:**
- "Understand the codebase" (too broad)
- "Learn about the project" (no specific goal)
- "Research everything" (unbounded)

Research with clear scope finishes. Research without scope never does.

### Research Questions Drive Exploration

Good research starts with questions, not wandering.

Before you start reading files, write down what you need to know:

```markdown
## Research Questions

1. How are database migrations currently handled?
2. What ORM patterns are used for model definitions?
3. Are there existing utilities for date/time handling?
4. What's the convention for API error responses?
5. How are environment-specific configs managed?
```

These questions focus your exploration. Every file you read, every grep you run, every directory you explore—it's all in service of answering these questions.

When the questions are answered, research is complete.

### Findings Include Negative Results

Good research documents what doesn't exist, not just what does.

```markdown
## Findings

- No existing utility for CSV parsing (would need to add dependency)
- No standardized pagination helper (each endpoint implements its own)
- No rate limiting middleware (currently manual in each route)
```

This matters because it tells the implementer what they'll need to build from scratch versus what they can reuse. Negative results are findings too.

### Research Informs Implementation Scope

Good research changes what you build.

You thought you needed to implement a new caching layer. Research revealed an existing caching utility that just needs configuration. Scope reduced by 80%.

You thought you needed to add authentication to three endpoints. Research revealed a middleware that can handle all three. Scope reduced to configuration.

You thought the feature was straightforward. Research revealed architectural constraints that require a different approach. Scope adjusted before writing code that would need to be thrown away.

**Research doesn't just inform how you build. It informs whether you build, what you build, and how much you build.**

### Research Findings Are Scoped for Handoff

Good research produces findings that can be handed off to an implementer without requiring them to re-research.

The researcher says: "Here's what I found. Here are the patterns you should follow. Here are the files that matter. Here's what doesn't exist yet."

The implementer says: "Got it. I have everything I need to build this correctly."

No round trips. No questions. No "wait, how does this work again?" The research was thorough enough to enable autonomous implementation.

This is especially critical in multi-agent workflows where the researcher and implementer might be different agents (or the same agent in different sessions). Research findings are the handoff document.

---

## Anti-Patterns: What Bad Looks Like

### "I'll Just Start Coding and Figure It Out"

You open the file, start writing code, hit a question about how something works, grep for an example, find something that looks reasonable, copy the pattern, keep going.

This feels productive. It's not.

You're doing research and implementation simultaneously, which means you're making implementation decisions with incomplete context. Every line you write might be wrong because you haven't finished understanding the problem space yet.

**Result:** Code that works in isolation but doesn't integrate well. Rework. Frustration.

### "I Already Know How This Should Work"

You've implemented this feature a hundred times in other codebases. You know the right pattern. You know the best practice. You just need to apply it here.

Except every codebase is different. Maybe this codebase has a utility that does what you're about to build. Maybe it has an architectural constraint you're not aware of. Maybe it uses a different convention for the same problem.

**Your prior knowledge is valuable, but it's not a substitute for understanding this specific codebase.**

Experienced agents fall into this trap more often than beginners because confidence can override curiosity.

### "Research Will Slow Me Down"

You have a simple feature to implement. Just add one endpoint. Five minutes of coding, tops. Research would take longer than the implementation.

Then you spend 20 minutes figuring out why the tests are failing because you didn't realize there's a base class all endpoints inherit from. Or you duplicate a utility that already exists. Or you break a convention and it gets flagged in code review.

**The research would have taken 10 minutes. The rework took 45.**

Simple tasks still benefit from research. Sometimes more than complex ones, because the rework cost is harder to justify.

### "I'll Research Later If I Need To"

You start implementing, planning to look things up if you hit a problem. Just-in-time research.

This creates context switching thrash. You're in implementation mode, then research mode, then back to implementation, then back to research. Every switch breaks focus and loses context.

Worse, you've already made architectural decisions during the first implementation attempt. When research reveals a better approach, you're now emotionally invested in the code you've already written. The sunk cost fallacy kicks in.

**Research first means you make decisions with full context, not partial knowledge.**

### "The Research Isn't Written Down"

You spend 30 minutes exploring the codebase, understanding the patterns, identifying the files that matter. Then you start implementing.

Next session, you've forgotten half of what you learned. Or another agent needs to implement a related feature and has to redo your research. Or you need to justify a decision and can't remember what you found.

**Research that isn't documented might as well not have happened.** The value evaporates as soon as you context-switch.

Write it down. Even if it's just bullet points. Even if it's "rough notes." Documentation makes research reusable.

---

## Implementation Checklist

### Before You Start Research

- [ ] Define research questions (what do you need to know?)
- [ ] Set scope boundaries (what are you NOT researching?)
- [ ] Identify success criteria (when is research complete?)

### During Research

- [ ] Document findings as you go (don't wait until the end)
- [ ] Note both positive and negative results
- [ ] Capture file paths, function names, specific examples
- [ ] Test your understanding (run existing code, read tests)

### After Research

- [ ] Review findings document (is it complete?)
- [ ] Verify it answers your research questions
- [ ] Check if findings change implementation scope
- [ ] Store findings where they can be found again

### Before Implementation

- [ ] Read your research findings
- [ ] Verify you understand existing patterns
- [ ] Identify files you'll modify or create
- [ ] Confirm approach fits with codebase conventions

---

## Common Research Strategies

### Top-Down: Start with Architecture

Begin with high-level structure, narrow to specifics.

1. Review documentation and design docs
2. Examine directory structure
3. Identify main entry points
4. Trace execution flow
5. Zoom in on specific implementations

Good for: Understanding overall system design, identifying architectural patterns, mapping component relationships.

### Bottom-Up: Start with Examples

Find working examples and generalize.

1. Search for similar features
2. Read existing implementations
3. Extract common patterns
4. Identify reusable utilities
5. Understand conventions through examples

Good for: Learning conventions, finding utilities, understanding testing patterns, seeing the "house style."

### Follow the Data

Trace how data flows through the system.

1. Identify data sources (API, database, files)
2. Find where data enters the system
3. Track transformations and processing
4. Locate storage/persistence
5. Map output/consumption

Good for: Understanding state management, finding validation logic, identifying integration points.

### Follow the Tests

Let tests guide your understanding.

1. Read test files for the area you're working in
2. Understand what behaviors are tested
3. Identify test utilities and helpers
4. Learn the testing conventions
5. Use tests as examples of correct usage

Good for: Understanding expected behavior, finding edge cases, learning how to test similar features.

### Grep-Driven Discovery

Use search to find patterns and examples.

```bash
# Find all authentication middleware
rg "class.*AuthMiddleware"

# Find error handling patterns
rg "raise.*Error" --type py

# Find all uses of a utility
rg "import.*date_formatter"

# Find configuration patterns
rg "config\[" --type python
```

Good for: Finding existing utilities, understanding conventions, identifying all usages of a pattern.

---

## Research Tools in Gas Town

### AgentOps Research Skill

```bash
# Deep codebase exploration
ao research --target "authentication system"

# Research with specific questions
ao research --target "database schema" --questions "How are migrations handled?"

# Research with scope
ao research --target "API routes" --scope "error handling only"
```

The `/research` skill produces structured findings documents that become context for implementation.

### Beads for Research Tracking

```bash
# Create research bead
bd create "Research: existing auth patterns"

# Link to implementation bead
bd dep add implement-auth-feature research-auth

# Research findings go in bead notes
bd note research-auth "Findings: uses JWT with Redis sessions..."
```

Research beads block implementation beads. You can't start building until research is complete.

### Knowledge Flywheel

```bash
# Store research findings in knowledge base
ao forge transcript

# Recall relevant research from previous sessions
ao inject

# Promote high-value findings to permanent knowledge
ao pool promote finding-auth-patterns
```

Research findings become part of your knowledge base, making future research faster.

---

## When Research Is Complete

Research is complete when you can answer these questions:

1. **What exists?** What utilities, patterns, conventions already exist that relate to this work?
2. **What doesn't exist?** What will need to be built from scratch?
3. **How does it work?** How do the existing implementations approach this problem?
4. **What are the constraints?** What architectural or technical constraints apply?
5. **What's the right approach?** Given what you've learned, what's the best way to implement this feature?

If you can't answer all five, keep researching.

If you can answer all five, write down your findings and move to implementation.

---

## Research is Not Optional

Here's the hard truth: every agent eventually does research. The only question is when.

You can research before implementation, while you have an empty slate and no sunk costs. Or you can research during rework, after you've already written code that doesn't fit and now have to throw it away.

You can research deliberately, producing documented findings that help with this task and future tasks. Or you can research frantically, trying to understand why your perfectly reasonable code isn't working.

You can research once, thoroughly. Or you can research repeatedly, rediscovering the same information every session because you didn't write it down.

**You're going to research. The only choice is whether you do it efficiently or wastefully.**

Measure twice. Cut once.

Research before you build.

---

## Without Tooling

You don't need a research skill or knowledge base to apply this factor. You need discipline.

### Before Any Implementation Session

1. **Open a fresh session** dedicated to research — not implementation
2. **Write down your questions** before touching the codebase: What exists? What patterns does this project use? Where does this code live?
3. **Read before you write** — open the relevant files, trace the call paths, understand the data flow
4. **Document what you find** in a simple markdown file: `research-YYYY-MM-DD-topic.md`

### The Research Document Template

```markdown
# Research: [Topic]

## Questions
- What does the current implementation look like?
- What patterns does this project follow?
- Where are the integration points?

## Findings
- [What you actually found]

## Recommendations
- [What you'd suggest for implementation]

## Files Examined
- [List of files you read and why they matter]
```

### Simple Research Habits

- **Grep before you create** — search for existing implementations before writing new ones
- **Read the tests** — they document intended behavior better than comments
- **Check git log** — understand why the current code looks the way it does
- **Look at adjacent code** — follow existing patterns rather than inventing new ones
- **Time-box research** — 15-30 minutes is usually enough. If you're still confused, the problem scope is too large; break it down

### The Research → Implementation Handoff

When you switch from research to implementation:
1. Close the research session
2. Open a fresh implementation session
3. Load only the research findings document
4. The research document IS your context — everything else is noise

This keeps implementation focused on what you learned, not burdened by how you learned it.

---

## The Promise

When you commit to research-first development, you make a promise to yourself and your codebase:

"I will understand before I build. I will learn the patterns before I apply them. I will document what I find so others can benefit. I will respect the existing work by integrating with it, not duplicating it."

This promise compounds over time. Each research session makes you faster. Each finding you document saves time for the next agent. Each pattern you learn makes you more effective in this codebase.

**Research-first development isn't slower. It's front-loaded.**

You pay the cost of understanding up front, and you reap the benefits for every subsequent implementation. The first feature takes longer. The tenth feature takes half the time. The hundredth feature is trivial because you understand the patterns so deeply you barely need to think about them.

That's the promise. That's what good looks like.

Research before you build.
