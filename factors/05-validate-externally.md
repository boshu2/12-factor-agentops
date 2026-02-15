# Factor V: Validate Externally

## Rule

**No agent grades its own work. Ever.**

Self-validation is confirmation bias with extra steps. The same context that generated the work is the worst possible context to validate it. Validation must come from outside the agent that did the work: a different agent, a different model, a test suite, or a human reviewer.

If you can't validate externally, you haven't validated at all.

---

## Rationale

### The Context Bias Problem

When an agent validates its own work, it brings the same assumptions, the same blind spots, and the same context that produced the work in the first place. It's like asking a novelist to proofread their own manuscript—they'll read what they *intended* to write, not what they *actually* wrote.

This isn't a failure of intelligence. It's a fundamental property of context:

**The agent that wrote the code knows what the code is supposed to do.** When it reviews the code, it pattern-matches against its intent, not against the actual implementation. It sees the function call it meant to write, not the one it actually wrote. It assumes the error handling exists because it planned to add it.

**The agent that designed the system knows the implicit assumptions.** When it validates the design, it fills in gaps with knowledge that isn't in the documentation. It sees the complete picture because it constructed the complete picture. A fresh reviewer sees only what's written.

**The agent that fixed the bug knows why the fix should work.** When it tests the fix, it tests the happy path it designed for, not the edge cases it didn't consider. It validates against the mental model that produced the fix.

This is why humans have editors, code reviewers, and QA teams. This is why scientific papers undergo peer review. External validation catches what internal validation cannot: the errors that feel obviously correct to the person who made them.

### Self-Validation Theater

Self-validation creates a dangerous illusion of rigor. The agent generates a checklist. The agent works through the checklist. The agent reports success. From the outside, it *looks* like validation happened.

But all that happened was confirmation bias, dressed up in the language of process.

**Example: The Security Review That Wasn't**

Agent implements authentication. Agent generates security checklist:
- ✓ Passwords are hashed
- ✓ Sessions have timeouts
- ✓ HTTPS is enforced
- ✓ Input is validated

Agent marks all items complete. Agent reports "security validated."

What the agent missed:
- Password hashing uses MD5 (broken algorithm)
- Session timeout is 30 days (absurdly long)
- HTTPS enforcement is client-side only (trivially bypassed)
- Input validation checks length, not content (SQL injection still possible)

The checklist wasn't wrong. The agent genuinely implemented all four things. But "implemented" isn't the same as "implemented correctly," and the agent couldn't see the difference because it was validating against its own flawed understanding of what "correct" means.

A different agent, reviewing the same code with the same checklist, would have caught three of these immediately. A security-focused model would have caught all four. A human security engineer would have questioned why these specific four items constituted a complete security review.

**The self-validation loop:** Generate → Validate against generation context → Confirm that generation matches intent → Declare success. At no point does external reality enter the loop.

### The Proofreading Parallel

Humans are terrible at proofreading their own writing. Not because they're bad at proofreading, but because they read what they intended to write. Their brain autocorrects errors in real-time, filling in missing words, fixing transposed letters, smoothing over awkward phrasing.

The exact same text, given to a different person, reveals errors immediately. The fresh reader doesn't have the author's intent in their head. They read what's actually on the page.

Agents have the same problem, except worse. Humans at least have some metacognitive awareness that they might be biased. Agents operate as if their context is objective reality. When an agent reviews its own code, it's not fighting against bias—it's unaware bias exists.

### The Validation Hierarchy

Not all external validation is equally valuable. The validation hierarchy, from weakest to strongest:

1. **Same agent, later in the same session:** Marginally better than immediate self-validation, but the context is still too similar. Use this only for catching trivial typos.

2. **Same agent, different session:** Better, especially if context has been cleared. The agent has "forgotten" some of its assumptions. Still not ideal, but acceptable for low-stakes work.

3. **Different agent, same model:** Good. Different context, different generation path, fresh perspective. Will catch most context-dependent errors.

4. **Different model:** Better. Different training, different biases, different strengths. Catches errors the first model is systematically blind to.

5. **Multi-model council (3+ models):** Best for subjective decisions. Architecture, design, prioritization. Independent evaluation, then synthesis.

6. **Automated test suite:** Best for objective correctness. Tests don't have context bias—they pass or fail based on behavior, not intent.

7. **Human expert review:** Best for high-stakes decisions. Security, architecture, legal, regulatory. Humans bring domain knowledge and intuition that models lack.

The goal is to match validation strength to decision risk. Refactoring a helper function? Different agent is fine. Designing authentication? Multi-model council plus human review. Releasing to production? Automated tests plus human signoff.

### Why Test Suites Are Validation Gold

Automated tests are the purest form of external validation because they don't care about your context. They don't care what you intended. They don't care about your mental model. They care about one thing: does the code do what the tests say it should do?

**Tests validate behavior, not explanation.** An agent can write a beautiful explanation of why its code is correct. Tests don't read the explanation—they run the code and check the output.

**Tests don't have confirmation bias.** A test suite doesn't "want" the code to pass. It mechanically evaluates assertions. If the assertion fails, the test fails, no matter how confident the agent is that it should pass.

**Tests are reproducible.** Human review varies by reviewer and by day. Agent review varies by context and session. Tests are deterministic. The same code produces the same results every time.

**Tests accumulate.** Each bug you fix gets a regression test. Each feature you ship gets acceptance tests. Over time, the test suite becomes an increasingly comprehensive validator of correctness.

The limitation of test suites: they only validate what they're designed to test. If your tests check happy paths but not edge cases, you'll get false confidence. If your tests validate behavior but not performance, you won't catch performance regressions. If your tests validate functionality but not security, you won't catch vulnerabilities.

This is why test suites are necessary but not sufficient. They're one layer in a defense-in-depth validation strategy.

### The Multi-Model Council

For subjective decisions—architecture, design, priorities—no single model has perfect judgment. Each model has biases from its training. Each model has strengths and blind spots.

A multi-model council works like this:

1. **Independent evaluation:** Three or more models independently assess the decision. No model sees the others' responses.

2. **Structured prompts:** Each model gets the same context, the same prompt, the same evaluation criteria. This ensures fair comparison.

3. **Synthesis, not voting:** Don't just count votes. Look for consensus on core points. Investigate disagreements—they often reveal edge cases or assumptions that need to be made explicit.

4. **Diversity matters:** Use genuinely different models, not just different versions of the same model family. Different architectures, different training data, different design philosophies.

**Example: Architecture Decision**

Question: Should we use microservices or a monolith for this new system?

- **Model A (GPT-4):** Recommends microservices. Emphasizes scalability, team autonomy, technology flexibility.

- **Model B (Claude):** Recommends monolith. Emphasizes simplicity, debugging ease, deployment atomicity. Notes that the team is small and the system's scale is uncertain.

- **Model C (Gemini):** Recommends monolith initially, with a plan to extract services later. Emphasizes reducing upfront complexity while preserving future optionality.

The synthesis: All three models identified the same trade-off (simplicity vs. scalability). Two out of three lean toward starting simple. The third provides a middle path. The decision isn't "microservices won" or "monolith won"—it's "we understand the trade-offs, we've considered multiple perspectives, and we're choosing monolith-first with an extraction plan."

This is better than any single model's answer because it's more robust to individual model biases.

### When Humans Must Validate

Some decisions are too high-stakes or too contextual for agent validation alone. Humans must review:

**Security decisions.** Agents can implement security controls, but humans must validate that the controls are appropriate, correctly implemented, and sufficient for the threat model.

**Architecture decisions.** Agents can propose architectures, but humans must validate that the architecture aligns with long-term goals, team capabilities, and organizational constraints.

**Legal and regulatory decisions.** Agents can draft policies, but humans must validate legal compliance. Regulations change. Jurisdictions vary. Liability is real.

**Irreversible decisions.** Database migrations. API deprecations. Data deletions. Anything you can't undo needs human signoff.

**Customer-facing decisions.** Product direction. Pricing. UX changes. Humans understand customer needs in ways models don't.

The pattern: agents can *propose* and *implement*, but humans must *validate* when stakes are high or context is critical.

---

## What Good Looks Like

### Validation Gates in the Development Pipeline

Every stage of development has appropriate external validation:

**Code changes:**
- Author: Agent A
- Reviewer: Agent B (different session or different model)
- Gate: Agent B approves PR, or raises questions

**Tests:**
- Author: Same agent that wrote the code (tests are specification)
- Validator: Test suite (automated, objective)
- Gate: All tests pass

**Architecture:**
- Proposer: Agent or human
- Validators: Multi-model council (3+ models)
- Gate: Consensus on approach, documented trade-offs

**Security:**
- Implementer: Agent
- Validators: Security-focused model + human security engineer
- Gate: Both approve

**Deployment:**
- Implementer: Agent
- Validators: Automated test suite + human operator
- Gate: Tests pass, human signs off

### The Validation Contract

When agent A hands work to agent B for validation, the contract is explicit:

**Agent A provides:**
- The work itself (code, document, design)
- The acceptance criteria (what "correct" means)
- Context needed to evaluate (requirements, constraints)

**Agent B validates:**
- Does the work meet the acceptance criteria?
- Are there errors, omissions, or inconsistencies?
- Does this make sense to a fresh reader?

**Agent B does NOT:**
- Assume the work is probably correct
- Fill in gaps with charitable interpretation
- Validate against what the work "should" be instead of what it is

The validator's job is to be skeptical, not supportive. The validator is the adversary in a formal proof, looking for counterexamples.

### Test-Driven Development as External Validation

TDD inverts the validation relationship:

1. Write tests first (specification of correct behavior)
2. Write code to pass tests (implementation)
3. Tests validate code (external validation, because tests were written before code)

This works because the tests are external to the implementation. The test context is "what should this do?" The implementation context is "how do I make this work?" Different contexts, different biases.

Even better: tests written by a different agent than the one writing the code. The test author thinks about behavior and edge cases. The code author thinks about implementation and optimization. The test suite catches cases where implementation intuition diverges from behavioral requirements.

### The Review Culture

Good validation creates a culture where review is normal, expected, and valued:

**Reviews are not adversarial.** The reviewer is not trying to prove the author wrong. The reviewer is trying to find errors before they reach production.

**Reviews are not optional.** Every PR, every design doc, every architectural decision gets reviewed. No exceptions for "small" changes or "trusted" authors.

**Reviews are timely.** Work doesn't sit waiting for review. Review is part of the workflow, not a bottleneck.

**Reviews are documented.** What was reviewed, by whom, with what result. When something goes wrong, you can trace back to see what the validation process missed.

**Reviews improve over time.** When a bug escapes validation, the review process is updated to catch similar bugs in the future. Reviews are not static—they evolve as the system learns.

### The Validation Checklist (Meta)

A checklist for validating your validation:

- [ ] Was this work reviewed by someone/something other than the author?
- [ ] Did the reviewer have different context than the author?
- [ ] Did the reviewer actually evaluate the work, or just confirm it looks plausible?
- [ ] Are there automated tests validating objective correctness?
- [ ] For high-stakes decisions, did a human review?
- [ ] Is the validation documented (who, when, what result)?
- [ ] If validation found issues, were they fixed and re-validated?

If you can't check all these boxes, you haven't validated externally.

### Example: Code Review Flow

**Agent A (author):**
1. Implements feature `implement-auth`
2. Writes tests for happy path
3. Commits code and tests
4. Creates PR, assigns to Agent B

**Agent B (reviewer):**
1. Reads the requirements (not the implementation first)
2. Reviews tests: do they cover edge cases, not just happy path?
3. Reviews code: does it match the tests? Are there obvious errors?
4. Runs tests locally: do they actually pass?
5. Identifies gaps: "What happens if the password is empty?"

**Agent A (revision):**
1. Adds test for empty password case
2. Adds validation to reject empty passwords
3. Re-requests review

**Agent B (final review):**
1. Confirms new test exists and fails without the fix
2. Confirms code now handles empty password
3. Approves PR

**Test suite (automated gate):**
1. Runs all tests on merge
2. Tests pass → merge completes
3. Tests fail → merge blocked, back to Agent A

**Human (deploy gate):**
1. Reviews deploy plan
2. Confirms this is a backward-compatible change
3. Approves deploy

Four layers of validation: peer review, self-review of feedback, automated tests, human deploy gate. Each layer catches different classes of errors.

### Example: Architecture Council

**Question:** How should we structure our data pipeline for processing user events?

**Context provided to all models:**
- Current volume: 10K events/day
- Growth projection: 100K events/day within 6 months
- Processing requirements: deduplication, enrichment, aggregation
- Latency requirement: sub-second for real-time dashboard, batch for analytics
- Team size: 2 engineers

**Model A (Claude Opus):**
- Recommends: Kafka + Stream processing (Flink or Spark Streaming)
- Rationale: Handles scale, real-time + batch, industry standard
- Concerns: Operational complexity for a 2-person team
- Suggests: Managed services (AWS MSK, AWS Kinesis)

**Model B (GPT-4):**
- Recommends: Event streaming with simpler stack (AWS Kinesis + Lambda)
- Rationale: Serverless reduces operational burden, scales automatically
- Concerns: Vendor lock-in, cost at high volume
- Suggests: Plan for migration to self-hosted if cost becomes prohibitive

**Model C (Gemini):**
- Recommends: Start with simple queue (SQS) + workers, evolve later
- Rationale: Current volume doesn't justify streaming complexity
- Concerns: May need rewrite when scaling to 100K/day
- Suggests: Design for easy migration (clean abstractions around ingestion)

**Synthesis:**
- Consensus: Current volume is low, projected volume is moderate, team is small
- Key trade-off: Operational complexity vs. future-proofing
- Disagreement: How much to optimize for 6-month future vs. today's needs
- Decision: Start with SQS + Lambda (Model C/B hybrid), with clean abstractions that allow migration to Kinesis/Kafka if volume projections prove accurate. Re-evaluate at 50K events/day.

**Why this is better than single-model decision:**
- Model A would have over-engineered for current needs
- Model C might have under-engineered for projected growth
- Model B found the middle path, validated by considering all three perspectives
- The team now understands the trade-offs, not just the conclusion

### Red Flags: Validation Theater

Signs that you're performing validation theater instead of actual validation:

🚩 **"I reviewed my own code and it looks good"**
- This is not validation. This is reading your code a second time with the same context.

🚩 **"I generated a checklist and everything passed"**
- Who validated the checklist? Who validated that "passing" is correct?

🚩 **"The tests pass"**
- Did you write the tests? Do they test edge cases or just happy path?

🚩 **"Another agent reviewed it and said it was fine"**
- Did that agent actually evaluate, or just pattern-match "looks reasonable"?

🚩 **"I asked three models and they all agreed"**
- Did you ask independently, or did each model see the previous models' answers?

🚩 **"We have a code review process"**
- Does the process have teeth? Can reviewers block merges? Do they actually find issues?

🚩 **"A human approved it"**
- Did the human review in detail, or rubber-stamp because "the AI is usually right"?

Validation theater is worse than no validation because it creates false confidence. Better to know you haven't validated than to believe you have when you haven't.

### The Validation Mindset

External validation requires a mindset shift:

**Assume you are wrong.** Not "assume you might be wrong." Assume you ARE wrong, and the validator's job is to find where.

**Invite scrutiny.** The validator is doing you a favor by finding errors before production. Thank them, don't defend yourself.

**Document validation.** Not just "reviewed by Agent B," but "Agent B found 3 issues, all resolved, re-reviewed and approved."

**Learn from validation.** When a validator finds an error, ask: what about my process allowed this error? How do I prevent similar errors in the future?

**Validate the validators.** Are your reviewers actually catching issues? If not, are they too similar in context, too rushed, or not incentivized to find problems?

### Automation Is Your Friend

The more validation you can automate, the more consistent and thorough it becomes:

**Automated tests:** Run on every commit, every PR, every deploy. No human needs to remember to run them.

**Static analysis:** Linters, type checkers, security scanners. Catch entire classes of errors before human review.

**Integration tests:** Validate that components work together, not just in isolation.

**Load tests:** Validate performance under realistic load.

**Chaos tests:** Validate resilience by injecting failures.

Each automated validator is a permanent reviewer that never gets tired, never forgets, never assumes "this probably works."

### The Validation Budget

Validation costs time and resources. Infinite validation is not practical. The question is: how much validation is enough?

**Risk-based validation:**
- High risk (security, data loss, regulatory): Maximum validation (multi-model + human + tests)
- Medium risk (features, refactors): Standard validation (peer review + tests)
- Low risk (docs, comments, formatting): Minimal validation (automated tools)

**Proportional validation:**
- Large changes: More validation
- Small changes: Less validation (but never zero)

**Incremental validation:**
- Validate as you go, not all at once at the end
- Small validated increments > large unvalidated batch

The goal is not to eliminate all errors—that's impossible. The goal is to catch enough errors early enough that the errors reaching production are rare, minor, and quickly fixed.

---

## Anti-Patterns

### The Self-Review Loop

Agent writes code. Agent reviews code. Agent finds no issues. Agent merges.

No external validation occurred. This is not validation—it's reading your own work twice.

### The Rubber Stamp Review

Agent A writes code. Agent B "reviews" by pattern-matching "this looks like code." Agent B approves without actually evaluating correctness.

Superficially looks like external validation, but no real evaluation occurred.

### The Checklist Fallacy

Agent generates checklist. Agent marks all items complete. Agent concludes validation is done.

The checklist itself was never validated. "Complete" doesn't mean "correct."

### The Test After the Fact

Agent writes code. Agent writes tests that match what the code does (not what it should do). All tests pass. Agent declares success.

Tests are validating implementation, not requirements. This is confirmation bias with extra steps.

### The Expert Override

"I'm the expert in this area, so I don't need review."

Experts have blind spots too. Often bigger blind spots, because they're confident in their expertise.

### The Time Pressure Skip

"We don't have time for review, we need to ship now."

You'll spend more time fixing the bugs that escaped than you would have spent on review.

---

## The Bottom Line

**Self-validation is not validation.** It's confirmation bias dressed up as rigor.

**External validation works** because it brings different context, different assumptions, different blind spots. The errors you can't see are obvious to someone else.

**Good validation is layered:** Peer review. Automated tests. Multi-model councils. Human experts. Each layer catches different error classes.

**Validation is not optional.** It's not a nice-to-have for when you have time. It's a required step between "work done" and "work shipped."

If you can't validate externally, don't ship. Wait until you can. The bug you catch in review costs minutes. The bug you catch in production costs hours or days. The bug you never catch costs customer trust.

**No agent grades its own work. Ever.**

That's the rule. Follow it.
