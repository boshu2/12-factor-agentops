# Reference Profile: Core 12-Factor AgentOps

**The universal meta-profile demonstrating ALL 12 factors working together**

This is the **canonical reference implementation** of 12-Factor AgentOps. It's domain-agnostic, pure pattern demonstration, and the foundation all other profiles build upon.

---

## What Is This?

**Core meta-profile that:**
- ✅ Demonstrates ALL 12 factors in action
- ✅ Works across ANY domain (code, docs, research, design, writing)
- ✅ Provides copy-paste ready `.claude/` configuration
- ✅ Serves as "hello world" of 12-Factor AgentOps
- ✅ Foundation you customize for your specific needs

**This is what you wanted:** The universal reference everyone starts from.

---

## Why This Exists

**Problem:** Domain profiles (platform-engineering, devops, etc.) are domain-specific.

**Gap:** No pure implementation showing "this is what 12-Factor looks like" before domain customization.

**Solution:** This reference profile.
- Demonstrates the framework without domain noise
- Shows how all 12 factors integrate
- Provides baseline everyone can understand
- Starting point for custom profiles

---

## What You Get

```
.claude/
├── agents/
│   ├── research-agent.md        # Phase 1: Understanding
│   ├── plan-agent.md            # Phase 2: Designing
│   ├── implement-agent.md       # Phase 3: Executing
│   └── learn-agent.md           # Post: Pattern Extraction
│
└── commands/
    ├── research.md              # /research - Start research phase
    ├── plan.md                  # /plan - Start planning phase
    ├── implement.md             # /implement - Start implementation
    ├── learn.md                 # /learn - Extract patterns
    └── workflow.md              # /workflow - Complete cycle
```

---

## The Complete Workflow

### Research → Plan → Implement → Learn

**Phase 1: Research** (Factor II, VI, VII)
```bash
/research

# Agent gathers context, understands problem
# Uses JIT loading (stay under 40%)
# Creates research bundle for continuity

Output: Research findings + bundle
```

**Phase 2: Plan** (Factor III, IX, XII)
```bash
/plan [research-bundle]

# Agent designs solution, breaks down tasks
# Extracts patterns, documents decisions
# Creates portable implementation spec

Output: Implementation plan
```

**Phase 3: Implement** (Factor IV, V, XI)
```bash
/implement [plan]

# Agent executes with validation gates
# Tracks metrics, enforces Laws
# Commits with learnings

Output: Working solution + metrics
```

**Phase 4: Learn** (Factor IX, X)
```bash
/learn

# Agent extracts reusable patterns
# Identifies improvements
# Documents for future work

Output: Pattern library updates
```

**Or run complete cycle:**
```bash
/workflow [topic]

# Orchestrates all 4 phases
# Guides through transitions
# Demonstrates full 12-Factor integration
```

---

## 12-Factor Mapping

| Factor | Demonstrated By | Where |
|--------|----------------|-------|
| **I. Git Memory** | All phases commit learnings | All agents |
| **II. JIT Context** | Load only what's needed | research-agent |
| **III. Single-Responsibility** | One agent = one phase | Agent boundaries |
| **IV. Validation Gates** | Test before commit | implement-agent |
| **V. Operational Telemetry** | Track metrics | implement-agent |
| **VI. Session Continuity** | Bundles between phases | research/plan/implement |
| **VII. Intelligent Routing** | Route to right approach | research-agent |
| **VIII. Human Gate Reviews** | Approval between phases | plan → implement transition |
| **IX. Pattern Extraction** | Capture reusable insights | plan-agent, learn-agent |
| **X. Continuous Improvement** | Identify improvements | learn-agent |
| **XI. Constitutional Guardrails** | Enforce Laws automatically | implement-agent hooks |
| **XII. Domain Portability** | Works in any domain | All agents (generic) |

---

## Quick Start (5 Minutes)

### Step 1: Copy to Your Project

```bash
# From 12-factor-agentops repository
cp -r examples/reference/.claude/ /path/to/your-project/
```

### Step 2: Try the Workflow

```bash
cd /path/to/your-project/

# Open in Claude Code, then:
/workflow test-feature

# Follow prompts through Research → Plan → Implement → Learn
```

### Step 3: Customize for Your Domain

```bash
# Edit agents to use your tools
# Example: research-agent.md
# Change: Generic file patterns
# To: Your project structure

# Keep: Phase-based workflow, validation gates, 12-Factor principles
```

---

## When to Use This Profile

### Use Reference Profile When:

✅ **Learning 12-Factor AgentOps**
- Understand how all factors work together
- See pure implementation without domain noise
- Study phase-based workflow pattern

✅ **Starting Custom Profile**
- Begin with universal foundation
- Customize for your specific domain
- Maintain 12-Factor compliance while adapting

✅ **Domain-Agnostic Work**
- Research work (any topic)
- Documentation writing
- Design/planning activities
- Analysis tasks

### Use Domain Profile When:

🎯 **Domain-Specific Work**
- Platform Engineering → `examples/platform-engineering/`
- DevOps → `examples/devops/`
- SRE → `examples/sre/`
- Web Development → `examples/web-development/`

**Domain profiles = This reference + domain-specific tools/patterns**

---

## Customization Guide

### Adapting for Your Domain

**Keep (12-Factor principles):**
- ✅ Phase-based workflow (Research → Plan → Implement)
- ✅ Validation gates (test before commit)
- ✅ Git memory (commit with learnings)
- ✅ Single-responsibility (one agent = one phase)

**Customize (domain specifics):**
- 🔧 File patterns (replace generic with your project structure)
- 🔧 Tools (add domain-specific commands: terraform, kubectl, npm, etc.)
- 🔧 Validation commands (swap `make test` for your test runner)
- 🔧 Examples (use your domain's terminology)

**Example: Adapting for Python Project**

```markdown
# research-agent.md

# Generic (reference profile):
Glob: "**/*.{py,js,go,rs}"

# Customized (Python project):
Glob: "**/*.py"
Bash: pytest --collect-only  # Discover tests
Read: requirements.txt        # Check dependencies
```

---

## Agent Details

### research-agent.md
**Purpose:** Understand before acting
**Demonstrates:** Factor II (JIT), Factor VI (Continuity), Factor VII (Routing)
**Output:** Research bundle
**Time:** 30-90 minutes
**Use when:** Starting complex work, unclear requirements

### plan-agent.md
**Purpose:** Design before building
**Demonstrates:** Factor III (Single-Responsibility), Factor IX (Patterns), Factor XII (Portability)
**Output:** Implementation specification
**Time:** 1-3 hours
**Use when:** After research, before implementation

### implement-agent.md
**Purpose:** Execute with validation
**Demonstrates:** Factor IV (Validation), Factor V (Telemetry), Factor XI (Guardrails)
**Output:** Working solution + metrics
**Time:** 4-8 hours
**Use when:** Plan approved, ready to build

### learn-agent.md
**Purpose:** Extract and improve
**Demonstrates:** Factor IX (Patterns), Factor X (Improvement)
**Output:** Pattern library updates
**Time:** 30-60 minutes
**Use when:** After implementation, before next project

---

## Complete Example

See [WORKFLOWS.md](./WORKFLOWS.md) for detailed examples across domains:
- Adding API feature
- Refactoring codebase
- Writing documentation
- Infrastructure change
- Research project

---

## Success Metrics

**From production use (200+ sessions):**
- **Efficiency:** 8x improvement vs ad-hoc approach
- **Context collapse:** 0% (when following 40% rule)
- **Success rate:** 95% (validation gates catch errors)
- **Pattern reuse:** 3-5x through extracted patterns

**Time distribution:**
- Research: 20%
- Plan: 30%
- Implement: 40%
- Learn: 10%

**Total:** 4-12 hours for complex features (vs 10-60 hours ad-hoc)

---

## Next Steps

**After trying reference profile:**

1. **Customize for your domain**
   - Add domain-specific tools
   - Update file patterns
   - Keep 12-Factor principles

2. **Explore domain profiles**
   - See how others adapted reference
   - Copy patterns that fit
   - Contribute back if you create new domain

3. **Read the framework**
   - [Four Pillars](../../foundations/four-pillars.md) - Why patterns work
   - [Five Laws](../../foundations/five-laws.md) - Mandatory principles
   - [All 12 Factors](../../factors/README.md) - Complete methodology

4. **Join community**
   - Share your adaptations
   - Contribute patterns
   - Help validate framework

---

## Questions?

**"Why so many agents?"** → Single-responsibility (Factor III). Each phase = one agent. Composable, testable, maintainable.

**"Can I skip phases?"** → For trivial work (<30 min), yes. For complex work, phases prevent expensive rework.

**"What if my workflow is different?"** → Customize! This is a reference, not a mandate. Keep principles, adapt implementation.

**"Which factors are most important?"** → Start with I (Git Memory), II (JIT Context), IV (Validation Gates). Others build from there.

**"How do I know it's working?"** → Track metrics (Factor V). Compare time/quality before and after. Iterate based on data.

---

## Resources

- **Full Documentation:** [../../README.md](../../README.md)
- **Pattern Library:** [../../patterns/](../../patterns/)
- **Factor Docs:** [../../factors/](../../factors/)
- **Domain Examples:** [../](../)
- **Contributing:** [../../CONTRIBUTING.md](../../CONTRIBUTING.md)

---

**This is the foundation. Build your domain on top of it. The 12 factors scale across all contexts.**

**Welcome to 12-Factor AgentOps.** 🎯
