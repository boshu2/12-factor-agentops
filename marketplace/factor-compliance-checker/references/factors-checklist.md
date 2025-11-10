# 12-Factor AgentOps Compliance Checklist

Comprehensive validation criteria for all twelve factors. Use this to systematically audit factor documentation, patterns, and workflows.

---

## Factor I: Git Memory as Knowledge OS

**Primary Pillar**: Knowledge OS
**Enforces Laws**: Law 1 (Extract Learnings), Law 3 (Document Context)

### Required Sections
- [ ] Summary (one-sentence principle)
- [ ] The Problem (what this solves)
- [ ] The Principle (how it works)
- [ ] Why This Works (theory + evidence)
- [ ] Implementation (practical guidance)
- [ ] Validation (success metrics)
- [ ] Real-World Evidence (production data)
- [ ] Anti-Patterns (common mistakes)
- [ ] Relationships (connections to other factors)

### Validation Criteria
- [ ] Commit message template includes: Context, Solution, Learning, Impact
- [ ] Git as institutional memory concept clearly explained
- [ ] Real git log examples showing proper usage
- [ ] Metrics on knowledge retention and discovery
- [ ] At least 3 anti-patterns documented
- [ ] Links to Factors IV (validation), IX (patterns), XI (guardrails)

---

## Factor II: JIT Context Loading

**Primary Pillar**: Context Engineering
**Enforces Laws**: Law 2 (Improve), Law 4 (Validate)

### Required Sections
- [ ] Summary (sub-agent delegation principle)
- [ ] The Problem (monolithic context bloat)
- [ ] The Principle (JIT loading via sub-agents, main context stays lean)
- [ ] Why This Works (isolation prevents pollution, cognitive load theory)
- [ ] Implementation (sub-agent orchestration patterns)
- [ ] Validation (metrics showing main context stays under 20%)
- [ ] Real-World Evidence (3.75x speedup, 98% success rate)
- [ ] Anti-Patterns (monolithic main agent, sub-agent bloat)
- [ ] Relationships (to bundles, routing, single-responsibility)

### Validation Criteria
- [ ] Sub-agent architecture explained with isolation benefits
- [ ] JIT loading pattern with concrete examples
- [ ] Main agent context monitoring (10-20% target)
- [ ] 98% success rate metric documented
- [ ] At least 3 anti-patterns (monolithic agent, context dumping, etc.)
- [ ] Links to Factor III (single-responsibility), VI (bundles), VII (routing)

---

## Factor III: Single-Responsibility Agents

**Primary Pillar**: Learning Science
**Enforces Laws**: Law 2 (Improve), Law 5 (Share)

### Required Sections
- [ ] Summary (one agent, one job)
- [ ] The Problem (monolithic agents)
- [ ] The Principle (Unix philosophy for agents)
- [ ] Why This Works (microservices patterns)
- [ ] Implementation (how to decompose workflows)
- [ ] Validation (reuse metrics)
- [ ] Real-World Evidence (47+ workflows from modular design)
- [ ] Anti-Patterns (swiss-army agents, god agents)
- [ ] Relationships (to routing, orchestration)

### Validation Criteria
- [ ] Unix philosophy connection explained
- [ ] Clear decomposition guidance
- [ ] Examples of well-scoped agents
- [ ] Pattern reuse metrics (47+ reuses)
- [ ] At least 3 anti-patterns (god agents, etc.)
- [ ] Links to Factor VII (routing), patterns (orchestration)

---

## Factor IV: Validation Gates Before Execution

**Primary Pillar**: DevOps + SRE
**Enforces Laws**: Law 3 (Document), Law 4 (Validate)

### Required Sections
- [ ] Summary (validate before execute)
- [ ] The Problem (costly failures)
- [ ] The Principle (shift-left testing for agents)
- [ ] Why This Works (prevention > recovery)
- [ ] Implementation (validation patterns)
- [ ] Validation (error prevention metrics)
- [ ] Real-World Evidence (production validation data)
- [ ] Anti-Patterns (YOLO execution, post-hoc validation)
- [ ] Relationships (to git hooks, human gates)

### Validation Criteria
- [ ] Validation gate types documented (syntax, semantic, policy)
- [ ] Git hooks as enforcement mechanism
- [ ] Diff-first thinking explained
- [ ] Error prevention metrics quantified
- [ ] At least 3 anti-patterns
- [ ] Links to Factor I (git hooks), VIII (human review), XI (guardrails)

---

## Factor V: Operational Telemetry

**Primary Pillar**: DevOps + SRE
**Enforces Laws**: Law 1 (Learn), Law 2 (Improve)

### Required Sections
- [ ] Summary (observe everything)
- [ ] The Problem (blind execution)
- [ ] The Principle (logs, metrics, traces)
- [ ] Why This Works (SRE observability patterns)
- [ ] Implementation (what to measure)
- [ ] Validation (observability coverage)
- [ ] Real-World Evidence (incident resolution times)
- [ ] Anti-Patterns (logging theater, metric vanity)
- [ ] Relationships (to improvement backlog, pattern extraction)

### Validation Criteria
- [ ] Three pillars of observability (logs, metrics, traces)
- [ ] Agent-specific telemetry patterns
- [ ] Success/failure/duration tracking
- [ ] Debugging improvements quantified
- [ ] At least 3 anti-patterns
- [ ] Links to Factor X (backlog), IX (patterns)

---

## Factor VI: Session Continuity via Bundles

**Primary Pillar**: Context Engineering
**Enforces Laws**: Law 2 (Improve), Law 3 (Document)

### Required Sections
- [ ] Summary (multi-session workflows)
- [ ] The Problem (context loss between sessions)
- [ ] The Principle (compressed context bundles)
- [ ] Why This Works (40% rule + compression)
- [ ] Implementation (bundle creation/loading)
- [ ] Validation (session continuity metrics)
- [ ] Real-World Evidence (multi-day workflows)
- [ ] Anti-Patterns (bundle bloat, stale bundles)
- [ ] Relationships (to 40% rule, orchestration)

### Validation Criteria
- [ ] Bundle compression ratios (5:1 to 10:1)
- [ ] Multi-session success metrics
- [ ] Creation and loading workflows
- [ ] Staleness prevention strategies
- [ ] At least 3 anti-patterns
- [ ] Links to Factor II (JIT context loading), pattern (bundles)

---

## Factor VII: Intelligent Task Routing

**Primary Pillar**: Learning Science
**Enforces Laws**: Law 1 (Learn), Law 2 (Improve)

### Required Sections
- [ ] Summary (right agent for right task)
- [ ] The Problem (manual routing, poor matches)
- [ ] The Principle (intelligent routing patterns)
- [ ] Why This Works (pattern recognition, metadata)
- [ ] Implementation (routing mechanisms)
- [ ] Validation (routing accuracy)
- [ ] Real-World Evidence (speedup from correct routing)
- [ ] Anti-Patterns (random routing, one-size-fits-all)
- [ ] Relationships (to single-responsibility, orchestration)

### Validation Criteria
- [ ] Routing decision trees or algorithms
- [ ] Metadata-based selection
- [ ] Accuracy and speedup metrics
- [ ] Failure recovery from misrouting
- [ ] At least 3 anti-patterns
- [ ] Links to Factor III (single-responsibility), pattern (routing)

---

## Factor VIII: Human Gate Reviews

**Primary Pillar**: Learning Science
**Enforces Laws**: Law 3 (Document), Law 4 (Validate)

### Required Sections
- [ ] Summary (human-in-the-loop at critical points)
- [ ] The Problem (autonomous failures)
- [ ] The Principle (approval workflows)
- [ ] Why This Works (human judgment for high-stakes)
- [ ] Implementation (when and how to gate)
- [ ] Validation (error prevention from human review)
- [ ] Real-World Evidence (critical decision accuracy)
- [ ] Anti-Patterns (review theater, rubber-stamping)
- [ ] Relationships (to validation gates, guardrails)

### Validation Criteria
- [ ] Critical decision identification patterns
- [ ] Approval workflow examples
- [ ] Human catch rate metrics
- [ ] Friction vs. safety balance
- [ ] At least 3 anti-patterns
- [ ] Links to Factor IV (validation), XI (guardrails)

---

## Factor IX: Documented Pattern Extraction

**Primary Pillar**: Knowledge OS
**Enforces Laws**: Law 1 (Learn), Law 5 (Share)

### Required Sections
- [ ] Summary (extract reusable patterns)
- [ ] The Problem (tribal knowledge, rediscovery)
- [ ] The Principle (systematic extraction workflow)
- [ ] Why This Works (pattern compounds over time)
- [ ] Implementation (extraction process)
- [ ] Validation (pattern reuse metrics)
- [ ] Real-World Evidence (pattern catalog growth)
- [ ] Anti-Patterns (extract everything, extract nothing)
- [ ] Relationships (to git memory, sharing)

### Validation Criteria
- [ ] Pattern extraction template
- [ ] Generalizability assessment framework
- [ ] Reuse tracking metrics
- [ ] Pattern library organization
- [ ] At least 3 anti-patterns
- [ ] Links to Factor I (git), Law 5 (sharing)

---

## Factor X: Continuous Improvement Backlog

**Primary Pillar**: DevOps + SRE
**Enforces Laws**: Law 2 (Improve), Law 3 (Document)

### Required Sections
- [ ] Summary (systematic improvement tracking)
- [ ] The Problem (improvement theater, no follow-through)
- [ ] The Principle (backlog as improvement queue)
- [ ] Why This Works (Kaizen, SRE error budgets)
- [ ] Implementation (backlog management)
- [ ] Validation (improvement velocity)
- [ ] Real-World Evidence (compounding efficiency gains)
- [ ] Anti-Patterns (backlog bloat, wishlist thinking)
- [ ] Relationships (to telemetry, pattern extraction)

### Validation Criteria
- [ ] Backlog structure and prioritization
- [ ] Improvement effort tracking
- [ ] Impact measurement framework
- [ ] Velocity metrics (improvements/month)
- [ ] At least 3 anti-patterns
- [ ] Links to Factor V (telemetry), IX (patterns)

---

## Factor XI: Constitutional Guardrails

**Primary Pillar**: DevOps + SRE
**Enforces Laws**: ALL (enforcement layer)

### Required Sections
- [ ] Summary (non-negotiable policies)
- [ ] The Problem (unsafe autonomy)
- [ ] The Principle (constitutional enforcement)
- [ ] Why This Works (policy as code, immutable rules)
- [ ] Implementation (guardrail types and enforcement)
- [ ] Validation (violation prevention metrics)
- [ ] Real-World Evidence (zero policy violations)
- [ ] Anti-Patterns (permission creep, exception culture)
- [ ] Relationships (to validation gates, human gates)

### Validation Criteria
- [ ] Policy categories (security, compliance, quality)
- [ ] Enforcement mechanisms (hooks, operators)
- [ ] Zero tolerance for critical violations
- [ ] Exception handling for non-critical
- [ ] At least 3 anti-patterns
- [ ] Links to Factor IV (validation), VIII (human review)

---

## Factor XII: Domain Portability

**Primary Pillar**: Knowledge OS
**Enforces Laws**: Law 1 (Learn), Law 5 (Share)

### Required Sections
- [ ] Summary (patterns transfer across domains)
- [ ] The Problem (domain silos, reinvention)
- [ ] The Principle (portable patterns and packaging)
- [ ] Why This Works (abstraction, workflow packages)
- [ ] Implementation (portability mechanisms)
- [ ] Validation (cross-domain success rate)
- [ ] Real-World Evidence (pattern adoption across domains)
- [ ] Anti-Patterns (over-abstraction, domain coupling)
- [ ] Relationships (to pattern extraction, sharing)

### Validation Criteria
- [ ] Abstraction layers defined
- [ ] Workflow package structure
- [ ] Cross-domain validation metrics
- [ ] Domain-specific vs. universal distinction
- [ ] At least 3 anti-patterns
- [ ] Links to Factor IX (patterns), Law 5 (sharing)

---

## Pattern Validation Checklist

### Required Pattern Elements
- [ ] **Context**: Domain and use case clearly described
- [ ] **Problem**: Specific operational challenge identified
- [ ] **Solution**: Pattern application explained with examples
- [ ] **Outcome**: Results with quantified metrics
- [ ] **Laws Compliance**: Maps to 1+ of Five Laws
- [ ] **Pillar Grounding**: References 1+ of Four Pillars
- [ ] **Generalizability**: Assessment of transferability

### Quality Standards
- [ ] Real production validation (not theoretical)
- [ ] Quantified impact metrics
- [ ] At least 2 concrete examples
- [ ] Failure modes documented
- [ ] Relationship to other patterns noted

---

## Workflow Validation Checklist

### Factor Adherence
- [ ] Lists which factors it implements (at least 1)
- [ ] Shows how each factor is applied
- [ ] Includes validation of factor compliance

### Laws Compliance
- [ ] Law 1: Extracts learnings from execution
- [ ] Law 2: Identifies improvement opportunities
- [ ] Law 3: Documents context for future agents
- [ ] Law 4: Validates before executing
- [ ] Law 5: (if applicable) Shares patterns publicly

### Observability
- [ ] Success metrics defined
- [ ] Failure modes documented
- [ ] Execution logs/traces available
- [ ] Impact quantifiable

### Documentation
- [ ] Why this workflow exists (context)
- [ ] How to use it (step-by-step)
- [ ] What it produces (outputs)
- [ ] When it applies (use cases)

### Reproducibility
- [ ] Clear prerequisites
- [ ] Executable examples
- [ ] Expected outcomes documented
- [ ] Environment requirements specified

---

## Quality Bar Summary

### Excellent Compliance (90%+)
- All required sections present and substantive
- Strong pillar grounding with theory
- Real production evidence with metrics
- 3+ well-documented anti-patterns
- Clear relationships to other factors
- Actionable implementation guidance

### Good Compliance (70-89%)
- Most sections present
- Adequate pillar grounding
- Some production evidence
- 2+ anti-patterns
- Basic relationships documented
- Implementation guidance exists

### Needs Work (<70%)
- Missing required sections
- Weak or missing pillar connection
- Theoretical only, no production data
- <2 anti-patterns
- Isolated (no relationships)
- Implementation unclear

---

**Use this checklist systematically to ensure all 12-Factor AgentOps contributions maintain high quality and consistency.**
