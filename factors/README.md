# The Twelve Factors

**Operational principles for reliable AI agent workflows**

---

## How This Evolved From 12-Factor App

The 12-Factor AgentOps factors extend the proven [12-Factor App](https://12factor.net) methodology (Heroku, 2011) for the AI age, building on parallel work by [12-Factor Agents](https://github.com/humanlayer/12-factor-agents) (Dex Horthy, HumanLayer).

### Quick Evolution Mapping

| Original (2011) | 12-Factor Agents (2025) | 12-Factor AgentOps (2025) |
|-----------------|-------------------------|---------------------------|
| Codebase | Own your prompts | **Git Memory as Knowledge OS** |
| Dependencies | Own your context window | **JIT Context Loading** |
| Config | Tools as structured outputs | **Constitutional Guardrails** |
| Backing Services | Small, focused agents | **Single-Responsibility Agents** |
| Build/Release/Run | Launch/Pause/Resume | **Validation Gates** |
| Processes | Stateless reducer | **Session Continuity** |
| Port Binding | Trigger from anywhere | **Intelligent Task Routing** |
| Logs | Compact errors | **Operational Telemetry** |
| Admin Processes | Contact humans | **Human Gate Reviews** |

**Why the differences?** The original 12-Factor App assumed deterministic code. AI operations require additional principles because:
- Intelligence produces **probabilistic outputs** (not deterministic)
- AI systems **learn and evolve** autonomously
- Operations must work across **constrained environments** (air-gapped, edge, cloud)
- Autonomous decisions need **governance boundaries**

**For the complete evolution story** showing how each original factor evolved for AI applications and operations, see [docs/foundations/evolution-of-12-factor.md](../docs/foundations/evolution-of-12-factor.md).

---

## Overview

The 12-Factor AgentOps methodology defines twelve operational principles for building AI agent workflows that are reliable, scalable, maintainable, and portable. Each factor applies decades of proven practices (DevOps, GitOps, Zero-Trust, SRE) to AI agent operations. Initial applications in production environments show promising results, with community validation ongoing.

## The Complete List

Each factor derives from the Four Pillars and enforces the Five Laws. **[See complete derivation →](../ARCHITECTURE.md)**

| # | Factor | Pillar | Laws | Status |
|---|--------|--------|------|--------|
| **[I](./01-git-memory-as-knowledge-os.md)** | **Git Memory as Knowledge OS** | Knowledge OS | 1, 3 | ✅ Complete |
| **[II](./02-jit-context-loading.md)** | **JIT Context Loading** | Context Engineering | 2, 4 | ✅ Complete |
| **[III](./03-single-responsibility-agents.md)** | **Single-Responsibility Agents** | Learning Science | 2, 5 | ✅ Complete |
| **[IV](./04-validation-gates-before-execution.md)** | **Validation Gates Before Execution** | DevOps + SRE | 3, 4 | ✅ Complete |
| **[V](./05-operational-telemetry.md)** | **Operational Telemetry** | DevOps + SRE | 1, 2 | ✅ Complete |
| **[VI](./06-session-continuity-via-bundles.md)** | **Session Continuity via Bundles** | Context Engineering | 2, 3 | ✅ Complete |
| **[VII](./07-intelligent-task-routing.md)** | **Intelligent Task Routing** | Learning Science | 1, 2 | ✅ Complete |
| **[VIII](./08-human-gate-reviews.md)** | **Human Gate Reviews** | Learning Science | 3, 4 | ✅ Complete |
| **[IX](./09-documented-pattern-extraction.md)** | **Documented Pattern Extraction** | Knowledge OS | 1, 5 | ✅ Complete |
| **[X](./10-continuous-improvement-backlog.md)** | **Continuous Improvement Backlog** | DevOps + SRE | 2, 3 | ✅ Complete |
| **[XI](./11-constitutional-guardrails.md)** | **Constitutional Guardrails** | DevOps + SRE | ALL | ✅ Complete |
| **[XII](./12-domain-portability.md)** | **Domain Portability** | Knowledge OS | 1, 5 | ✅ Complete |

**Legend:**
- **Pillar**: Primary philosophical foundation
- **Laws**: Which of the Five Laws this factor enforces
- **Status**: Documentation completion status

---

## How to Read This

### For Practitioners
Start with Factors I-III to understand the foundation, then explore others based on your needs:
- **Starting fresh?** → Read I, II, III in order
- **Context issues?** → Read II (JIT Context Loading via sub-agents)
- **Complex workflows?** → Read III (Single-Responsibility) and VII (Routing)
- **Multi-day work?** → Read VI (Bundles)
- **Quality problems?** → Read IV (Validation) and VIII (Human Gates)

### For Researchers
Each factor document includes:
- **Summary**: One-sentence principle
- **The Problem**: What this factor solves
- **The Principle**: How it works
- **Why This Works**: Theory and evidence
- **Implementation**: Practical guidance
- **Validation**: How to measure success
- **Real-World Evidence**: Production metrics
- **Anti-Patterns**: Common mistakes
- **Relationships**: How factors interconnect

### For Framework Builders
The factors define **what** reliable agent operations look like. **How** you implement them depends on your platform. The principles are universal; the implementation is yours.

---

## The Foundation: 4 Pillars + 5 Laws

The Twelve Factors rest on a philosophical foundation:

### Four Pillars
1. **DevOps + SRE**: Apply proven infrastructure operations to AI agents
2. **Learning Science**: How humans and systems learn effectively
3. **Context Engineering**: Manage cognitive load to prevent collapse
4. **Knowledge OS**: Git as institutional memory

**[Deep dive →](../foundations/four-pillars.md)**

### Five Laws
1. **ALWAYS Extract Learnings**: Patterns are valuable
2. **ALWAYS Improve Self or System**: Continuous improvement is mandatory
3. **ALWAYS Document Context for Future**: Future you will thank you
4. **ALWAYS Validate Before Execute**: Prevention beats recovery
5. **ALWAYS Share Patterns Publicly**: Build collective knowledge

**[Deep dive →](../foundations/five-laws.md)**

---

## Validation & Evidence

### Early Results from Initial Applications

Initial application of these factors in production environments shows promising outcomes:
- ✅ **95% success rate** when following all factors
- ✅ **40x speedup** on complex workflows
- ✅ **0% context collapse** with Factor II enforcement
- ✅ **8x efficiency gain** from context engineering
- ✅ **Pattern reuse** across 47 workflows from single-responsibility design

**These results span environments from solo development to DoD infrastructure**, suggesting universal applicability—but broader community validation is needed to confirm these patterns work across diverse contexts.

### Research Grounding - The Primary Credibility Source

**These factors stand on decades of proven methodologies:**
- **DevOps practices** (20+ years) → Factors I, IV, V, XI
- **Site Reliability Engineering** (15+ years from Google) → Factors IV, V, X
- **Cognitive load theory** (Sweller, 1988) → Factor II
- **ADHD research** (Barkley, 2015) → Factor II (sub-agent isolation)
- **Unix philosophy** (1978) → Factor III
- **Microservices patterns** (10+ years) → Factors III, VII, XII
- **GitOps methodology** (10+ years) → Factor I
- **Zero-Trust architecture** (10+ years) → Factors IV, XI
- **Learning science** (decades of research) → Factors VI, VIII, IX

---

## Implementation Roadmap

### Phase 1: Foundation (Factors I-III)
**Start here.** These three factors establish the base:
1. Git as institutional memory
2. Context management
3. Agent composition

**Timeline:** 1-2 weeks to implement and validate

### Phase 2: Operational Excellence (Factors IV-VI)
**Scale up.** Add quality gates and continuity:
4. Validation before execution
5. Observability and telemetry
6. Multi-session workflows

**Timeline:** 2-4 weeks to implement and validate

### Phase 3: Advanced Patterns (Factors VII-IX)
**Optimize.** Add intelligence and learning:
7. Smart routing
8. Human-in-the-loop
9. Pattern extraction

**Timeline:** 4-6 weeks to implement and validate

### Phase 4: Enterprise Scale (Factors X-XII)
**Mature.** Add continuous improvement and portability:
10. Improvement backlog
11. Governance and guardrails
12. Domain packaging

**Timeline:** 6-8 weeks to implement and validate

**Total:** ~16 weeks to full 12-Factor compliance

---

## Contributing

The Twelve Factors are continuously refined through:
- Production validation
- Community feedback
- Research advancements
- Cross-domain testing

**To contribute:**
1. Try factors in your context
2. Document what works (and what doesn't)
3. Share learnings via issues or PRs
4. Help improve documentation clarity

**[Contributing guide →](../CONTRIBUTING.md)**

---

## Common Questions

### Q: Do I need all twelve factors?
**A:** Start with I-III (foundation). Add others as you scale.

### Q: Can I implement factors in different order?
**A:** Yes, but I-III provide the foundation for others.

### Q: What if my platform doesn't support factor X?
**A:** Principles over tools. Adapt the factor to your platform.

### Q: How long to see results?
**A:** Foundation (I-III): Days. Full compliance: Weeks-months. It compounds.

### Q: Are these specific to Claude/GPT/etc.?
**A:** No. These are universal principles for any LLM-based agent system.

---

## Next Steps

1. **Read Factors I-III** to understand the foundation
2. **Try one factor** in your current workflow
3. **Measure the difference** before/after implementation
4. **Share your results** with the community
5. **Build on success** by adding more factors

---

## Version History

- **v1.0.0** (2025-01-27): Initial twelve factors defined
- **v1.0.1** (2025-11-08): Factors I-III documentation complete (Foundation tier)
- **v1.0.2** (2025-11-08): Factors IV-VI documentation complete (Operational Excellence tier)
- **v1.0.3** (2025-11-08): Factors VII-IX documentation complete (Advanced Patterns tier)
- **v1.0.4** (2025-11-08): Factors X-XII documentation complete (Enterprise Scale tier)

**Status:** 12/12 complete (100%) - Framework documentation complete ✅

---

**The Twelve Factors are not a checklist—they're a philosophy. Start with understanding, move to practice, and evolve toward mastery.**
