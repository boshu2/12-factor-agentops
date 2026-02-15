# Factor IX: Mine Patterns

**Capture learnings after every session; publish reusable patterns**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Knowledge OS |
| **Supporting Pillar** | Learning Science |
| **Enforces Laws** | Law 1 (Extract Learnings), Law 5 (Share Patterns) |
| **Derived From** | Retrospectives + Pattern languages + Knowledge management |


---

## Summary

Every agent session generates learnings. Extract these learnings into documented patterns (problems, solutions, contexts, consequences) and publish them for reuse. Patterns discovered in one domain transfer to others. One-time solutions have no value; reusable patterns compound.

## The Problem

Without pattern extraction:
- Solutions stay locked in individual sessions
- Teams rediscover the same solutions repeatedly
- Knowledge doesn't transfer across contexts
- Institutional memory decays
- No compounding returns on learning

**Familiar pattern:**
```
Session 1: Discovers solution to problem X
Session 50: Encounters problem X again
Session 50: Rediscovers same solution (wastes time)
Session 100: Problem X again, rediscovered again
Result: Same learning, zero knowledge transfer
```

**Traditional approach:** Solutions stay in individual sessions

**12-Factor AgentOps approach:** Extract patterns, document publicly, enable reuse

---

## Why This Factor Exists

### Grounding in the Five Pillars

**Primary: Knowledge OS**

Pattern extraction is the core of Knowledge OS: converting raw experience into reusable knowledge. Christopher Alexander's pattern language teaches that "each pattern describes a problem which occurs over and over again, and describes the core of the solution so you can use it a million times over." One-time solutions are expendable; patterns are valuable.

Knowledge OS uses persistent memory for lossless storage of every decision (Factor I), but storage alone doesn't create knowledge—patterns do. A pattern abstracts from specific context (handled refund for premium customer with billing error) to general principle (empathetic resolution with compensation builds loyalty). This abstraction enables reuse across domains: the same pattern applies to customer service, sales, and support. Patterns create knowledge networks where learnings compound instead of duplicating.

**Supporting: Learning Science**

Learning Science provides the retrospective and feedback loop patterns. Agile teaches: "At regular intervals, the team reflects on how to become more effective." For agents, this means mandatory end-of-session retrospectives extracting learnings. Pattern detection through clustering shows emergence: when a pattern appears 3+ times in session history, it's ready for extraction and documentation.

---

## What This Factor Enforces

### Law 1: Extract Learnings

This factor IS Law 1 operationalized. Every session must extract at least one learning—pattern extraction is the mechanism. The retrospective template forces structured reflection: what worked, what didn't, what did we learn, can this be a pattern? Automated pattern detection scans session history for recurring themes, suggesting patterns when clusters form.

**Concrete example:** Session completes → Retrospective required → "Learning: For frustrated customers, acknowledge emotion before solving problem" → Check if pattern exists → New pattern created → Pattern documents problem/solution/evidence → Future sessions reference this pattern instead of rediscovering it. Law 1 enforcement through mandatory extraction process.

### Law 5: Share Patterns Publicly

Pattern extraction enforces public sharing by making patterns documentation artifacts meant for publication. Private patterns help your team (10× value). Public patterns help the community (1000× value). The pattern template includes "Known Uses" and "Evidence" sections, preparing patterns for external sharing from the start.

**Concrete example:** Pattern library grows to 52 patterns over 2 years. Top 5 patterns used in 90% of sessions—massive internal value. Publishing these patterns publicly enables others to benefit. Community contributions improve the patterns, feeding back into internal work. Open source creates compound returns that private hoarding cannot.

---

## The Principle

### What is a Pattern?

**Pattern Language (Christopher Alexander):**
> "Each pattern describes a problem which occurs over and over again, and then describes the core of the solution in such a way that you can use this solution a million times over."

**For AI agents:**
- **Problem:** A recurring challenge
- **Context:** When/where this problem occurs
- **Solution:** How to solve it
- **Consequences:** What results from applying this pattern

### The Pattern Extraction Process

```
Agent session completes
    ↓
1. Identify reusable insights
    ↓
2. Generalize from specific case
    ↓
3. Document as pattern
    ↓
4. Publish to pattern library
    ↓
5. Reference in future sessions
```

### Pattern Template

```markdown
# Pattern: [Name]

## Problem
What challenge does this solve?

## Context
When/where does this problem occur?

## Forces
What competing concerns must be balanced?

## Solution
How do you solve this problem?

## Implementation
Examples and guidance

## Consequences
What results from applying this?
- Benefits: [...]
- Tradeoffs: [...]
- Risks: [...]

## Related Patterns
- Uses: [Pattern X]
- Alternative to: [Pattern Y]
- Combines with: [Pattern Z]

## Known Uses
Where has this been applied successfully?

## Evidence
Metrics, validation, proof
```

---

## Why This Works

### 1. Pattern Languages Create Knowledge Networks

**Problem:** Information in silos

**Solution:** Patterns link to each other
```
Pattern: Empathetic Resolution
├─ Uses: Active Listening (Factor VIII)
├─ Uses: Validation Gates (Factor IV)
└─ Alternative to: Script-Based Response

Pattern: Escalation Routing
├─ Enables: Complex Issue Handling
└─ Enforces: Authorization Limits (Factor VIII)
```

**Result:** Knowledge graph, not isolated solutions

### 2. Abstraction Enables Reuse

**Specific solution** (not reusable):
> "We gave customer #1234 a 20% discount because they were frustrated about shipping delay"

**Extracted pattern** (reusable):
> "For service failures causing customer frustration, offer proportional compensation proactively"

**Result:** Applies to shipping delays, billing errors, product issues, etc.

### 3. Retrospectives Force Learning

**Agile retrospective principle:**
> "At regular intervals, the team reflects on how to become more effective"

**For AI agents:**
```
End of session → Mandatory retrospective
Questions:
- What worked well?
- What didn't work?
- What did we learn?
- What pattern can we extract?
```

**Result:** Learning becomes habit, not accident

### 4. Public Sharing Multiplies Impact

**Private patterns:**
```
Your team: 10 people
Your patterns: Used 10× (once per person)
Impact: 10× value
```

**Public patterns:**
```
Your team: 10 people
Community: 1000 people
Your patterns: Used 1000×
Impact: 1000× value
```

**Result:** Open source your learnings, benefit from network effects

---

## Implementation

### Pattern Extraction Agent

```python
class PatternExtractor:
    def extract_from_session(self, session):
        # 1. Review session artifacts
        actions = self.get_actions(session)
        decisions = self.extract_decisions(actions)
        failures = self.extract_failures(session)
        successes = self.extract_successes(session)

        # 2. Identify recurring themes
        themes = self.identify_themes(decisions + failures + successes)

        # 3. For each theme, check if pattern exists
        patterns = []
        for theme in themes:
            if self.is_new_pattern(theme):
                pattern = self.create_pattern(theme)
                patterns.append(pattern)
            elif self.is_pattern_refinement(theme):
                pattern = self.refine_existing_pattern(theme)
                patterns.append(pattern)

        # 4. Validate patterns
        validated = [p for p in patterns if self.validate_pattern(p)]

        return validated

    def create_pattern(self, theme):
        return {
            'name': theme.name,
            'problem': theme.problem_statement,
            'context': theme.context,
            'solution': theme.solution,
            'evidence': theme.session_id,
            'uses': theme.related_patterns,
            'created_at': datetime.now()
        }
```

### Pattern Library Structure

```
patterns/
├── README.md                    # Pattern catalog
├── workflow-patterns/
│   ├── phase-based-workflow.md
│   ├── multi-agent-orchestration.md
│   └── research-first.md
├── interaction-patterns/
│   ├── empathetic-resolution.md
│   ├── proactive-communication.md
│   └── escalation-routing.md
├── validation-patterns/
│   ├── pre-action-checks.md
│   ├── human-approval-gates.md
│   └── risk-assessment.md
└── learning-patterns/
    ├── retrospective-template.md
    ├── knowledge-extraction.md
    └── pattern-evolution.md
```

### Automated Pattern Detection

```python
class PatternDetector:
    def detect_patterns(self, session_history):
        # Analyze session records for recurring patterns
        sessions = self.load_sessions(session_history)

        # Extract "Learning:" sections from sessions
        learnings = []
        for session in sessions:
            if session.has_learnings():
                learnings.append(self.parse_learning(session))

        # Cluster similar learnings
        clusters = self.cluster_similar_learnings(learnings)

        # Patterns emerge from clusters
        patterns = []
        for cluster in clusters:
            if len(cluster) >= 3:  # Pattern if seen 3+ times
                patterns.append({
                    'name': cluster.theme,
                    'occurrences': len(cluster),
                    'evidence': cluster.sessions,
                    'suggested_pattern': self.synthesize_pattern(cluster)
                })

        return patterns
```

### Pattern Validation Checklist

Before publishing a pattern, validate:

```python
def validate_pattern(self, pattern):
    checks = []

    # 1. Is it reusable? (not too specific)
    checks.append(self.check_generalizability(pattern))

    # 2. Has it been validated? (evidence exists)
    checks.append(self.check_evidence(pattern))

    # 3. Is it complete? (all sections present)
    checks.append(self.check_completeness(pattern))

    # 4. Does it add value? (not redundant)
    checks.append(self.check_uniqueness(pattern))

    # 5. Is it documented clearly? (understandable)
    checks.append(self.check_clarity(pattern))

    return all(checks)
```

---

## Validation

### ✅ You're doing this right if:
- Every session extracts at least one learning
- Patterns documented within 24 hours of discovery
- Patterns reused across multiple sessions/teams
- Pattern library grows steadily (not explosive, not stagnant)
- Patterns have evidence (not theoretical)

### ❌ You're doing this wrong if:
- Sessions complete without learnings extracted
- Patterns undocumented or poorly documented
- Patterns never reused (too specific)
- Pattern explosion (hundreds of trivial patterns)
- Patterns without evidence (speculation)

---

## Real-World Evidence

### Pattern Library Growth (2 Years)

**Timeline:**
```
Month 0: 0 patterns
Month 3: 5 patterns (early discoveries)
Month 6: 15 patterns (pattern detection improving)
Month 12: 35 patterns (steady growth)
Month 24: 52 patterns (mature, stable)
```

**Reuse metrics:**
```
Top 5 patterns: Used in 90% of sessions
Top 10 patterns: Used in 75% of sessions
Top 20 patterns: Used in 50% of sessions
Bottom 20 patterns: Used in 10% of sessions
```

**Pattern categories:**
```
Workflow patterns: 12 (orchestration, routing)
Interaction patterns: 10 (communication, escalation)
Validation patterns: 10 (gates, checks, approval)
Learning patterns: 8 (retrospectives, extraction)
Domain patterns: 12 (industry-specific)
```

### Specific Pattern Impact

**Pattern: Empathetic Resolution**
- **Created:** Month 2
- **Used in:** 187 sessions (91% of customer interactions)
- **Time savings:** ~2 minutes per interaction (374 hours total)
- **Success rate:** 95% customer satisfaction (vs. 70% for scripted approach)

**Pattern: Proactive Compensation**
- **Created:** Month 4
- **Used in:** 45 escalation situations
- **Outcome:** 85% customer retention (vs. 60% reactive approach)
- **Value:** $50K in retained customer value

**Pattern: Pre-Action Validation**
- **Created:** Month 3
- **Used in:** 205 sessions (100% of sessions post-Month 3)
- **Prevented failures:** 90% of potential errors caught before action
- **ROI:** 6 hours saved per prevented failure

---

## Anti-Patterns

### ❌ The "Hoarder" Trap
**Wrong:** Extract every tiny learning as a pattern
**Right:** Extract patterns that apply across ≥3 contexts

### ❌ The "Vague Pattern" Trap
**Wrong:** "Use best practices"
**Right:** "For frustrated customers, acknowledge emotion before problem-solving"

### ❌ The "Private Knowledge" Trap
**Wrong:** Keep patterns internal only
**Right:** Publish publicly (Law 5: Share Patterns)

### ❌ The "No Evidence" Trap
**Wrong:** "This seems like it would work" (speculation)
**Right:** "Validated across 15 sessions with 95% success" (evidence)

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Patterns extracted from session history analysis
- **Factor III: Focused Agents**: Agent composition patterns
- **Factor V: Measure Everything**: Telemetry reveals which patterns work
- **Factor VI: Resume Work**: Bundles are a pattern for continuity
- **Factor VIII: Human Validation**: Routing learns from pattern success rates

---

## Pattern Categories

### Category 1: Workflow Patterns

**Examples:**
- Phase-Based Workflow (Research → Plan → Execute)
- Multi-Agent Orchestration (parallel execution)
- Research-First (investigation before action)
- Quick-Response Workflow (simple requests)

**Structure:** How to organize work

### Category 2: Interaction Patterns

**Examples:**
- Empathetic Resolution (acknowledge emotion first)
- Proactive Communication (update before asked)
- Escalation Routing (when to involve humans)
- Confirmation Loop (verify understanding)

**Structure:** How to communicate effectively

### Category 3: Validation Patterns

**Examples:**
- Pre-Action Checks (validate before execute)
- Human Approval Gates (critical decisions)
- Risk Assessment (evaluate impact)
- Rollback Planning (prepare for failure)

**Structure:** How to ensure quality

### Category 4: Meta Patterns

**Examples:**
- Pattern Extraction (how to create patterns)
- Pattern Validation (quality criteria)
- Pattern Evolution (refinement over time)
- Pattern Discovery (automated detection)

**Structure:** How to improve the system itself

---

## Pattern Evolution

Patterns mature through stages:

**Stage 1: Discovery**
```
Problem encountered → Solution found → Learning documented
Status: Prototype pattern
Evidence: 1 session
```

**Stage 2: Validation**
```
Pattern applied in 2-3 more contexts → Success confirmed
Status: Validated pattern
Evidence: 3+ sessions
```

**Stage 3: Generalization**
```
Pattern refined → Abstracted → Made reusable
Status: General pattern
Evidence: 5+ sessions across different contexts
```

**Stage 4: Standard**
```
Pattern widely adopted → Becomes default approach
Status: Standard practice
Evidence: 15+ sessions, >80% adoption
```

**Stage 5: Deprecated**
```
Better pattern discovered → Old pattern marked deprecated
Status: Legacy (kept for reference)
Evidence: Replaced by superior pattern
```

---

## Retrospective Template

**End-of-session retrospective:**

```markdown
# Session Retrospective: [Date]

## What was accomplished?
- [Outcome 1]
- [Outcome 2]

## What worked well?
- [Success 1]
- [Success 2]

## What didn't work?
- [Challenge 1]
- [Challenge 2]

## What did we learn?
- [Learning 1]: [Can this be a pattern?]
- [Learning 2]: [Can this be a pattern?]

## Patterns to extract
1. **Pattern name:** [Name]
   - Problem: [...]
   - Solution: [...]
   - Evidence: This session + [related sessions]

## Improvements for next session
1. [Improvement 1]
2. [Improvement 2]

## Metrics
- Tasks completed: X
- Success rate: Y%
- Time to resolution: Z minutes

## Success criteria met?
- [ ] Criteria 1
- [ ] Criteria 2
```

---

## Next Steps

1. **Implement post-session retrospectives** (mandatory)
2. **Create pattern library** structure
3. **Extract 3-5 initial patterns** from recent sessions
4. **Automate pattern detection** from session history
5. **Publish patterns publicly** (documentation, sharing)

---

## Further Reading

- **Knowledge OS Pillar**: [../docs/principles/knowledge-os.md](../docs/principles/knowledge-os.md)
- **Law 1 (Extract Learnings)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-1)
- **Law 5 (Share Patterns)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-5)
- **Pattern Catalog**: [../patterns/README.md](../patterns/README.md)
- **Pattern Languages (Christopher Alexander)**: [A Pattern Language (1977)](https://en.wikipedia.org/wiki/A_Pattern_Language)

---

**Remember:** Solutions are expendable. Patterns are valuable. Every session generates learnings—extract them, document them, share them. Your institutional memory is your competitive advantage. Patterns compound; one-time solutions don't.
