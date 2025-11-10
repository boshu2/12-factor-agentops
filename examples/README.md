# 12-Factor AgentOps: Example Profiles

**Copy-paste ready `.claude/` configurations demonstrating the framework**

This directory contains the **STARTER-PACK** (core workflow) plus a few domain-specific examples showing how to customize for your work.

---

## Quick Navigation

| I want to... | Go to | Time |
|--------------|-------|------|
| **Get started immediately** | [STARTER-PACK/QUICK-START.md](./STARTER-PACK/QUICK-START.md) | 5 min |
| **Understand the core workflow** | [STARTER-PACK/README.md](./STARTER-PACK/README.md) | 10 min |
| **See domain customization examples** | [profiles/](#domain-profiles) (below) | 5-10 min each |
| **Learn the 12 factors** | [../factors/README.md](../factors/README.md) | 15 min |

---

## The STARTER-PACK (Start Here)

**Location:** `STARTER-PACK/`

**What it is:** The basic package of Claude Code plugins for 12-Factor AgentOps

**What you get:**
- ✅ 4 phase-based agents (research, plan, implement, learn)
- ✅ 5 slash commands (/research, /plan, /implement, /learn, /workflow)
- ✅ Complete Research → Plan → Implement → Learn workflow
- ✅ Git hooks enforcing the Five Laws (optional)
- ✅ Works for ANY domain (code, docs, research, writing, analysis)

**Installation:** 5 minutes (see [STARTER-PACK/QUICK-START.md](./STARTER-PACK/QUICK-START.md))

**Token budget:** ~8,000 tokens (4% of context window) - composition-safe

**Who it's for:**
- ✅ Everyone starting with 12-Factor AgentOps
- ✅ Domain-agnostic work (research, docs, planning)
- ✅ Learning the framework
- ✅ Creating custom profiles

**Why start here:**
- Pure pattern demonstration (no domain noise)
- Shows ALL 12 factors working together
- Foundation for all domain customization
- Proven in 200+ sessions (95% success rate)

---

## Domain Profiles

**Location:** `profiles/`

**What they are:** Examples showing how to customize STARTER-PACK for specific domains

**Current profiles:**
- `software-dev/` - General coding (Python, JavaScript, Go, etc.)
- `platform-ops/` - Infrastructure and Kubernetes
- `content-creation/` - Documentation and writing

**Relationship to STARTER-PACK:**
```
Domain Profile = STARTER-PACK workflow + Domain-specific tools
```

**When to use:**
- You want domain-specific examples (see how others customized)
- You need quick templates for your domain
- You want inspiration for your own customization

---

## Comparison: STARTER-PACK vs Domain Profiles

| Aspect | STARTER-PACK | Domain Profiles |
|--------|--------------|-----------------|
| **Purpose** | Core workflow (universal) | Customization examples |
| **Use case** | Any work | Specific domain |
| **Tools** | Generic (Read, Write, Edit, Bash) | Domain-specific (kubectl, pytest, npm, etc.) |
| **Complexity** | Essential (4 agents) | Extended (4 agents + domain tools) |
| **Token budget** | ~8k tokens (4%) | ~12-15k tokens (6-7.5%) |
| **Who uses** | Everyone (starting point) | Domain practitioners |
| **Customization** | Copy as-is or customize | Copy and adapt further |

---

## Installation Paths

### Path 1: Use STARTER-PACK As-Is (Recommended)

**Best for:** Getting started, domain-agnostic work

```bash
# 1. Clone framework
git clone https://github.com/[your-org]/12-factor-agentops.git /tmp/12f

# 2. Copy STARTER-PACK to your project
cp -r /tmp/12f/examples/STARTER-PACK/.claude/ /path/to/your-project/

# 3. Optional: Install git hooks
cp /tmp/12f/examples/STARTER-PACK/shared/git-hooks/* /path/to/your-project/.git/hooks/
chmod +x /path/to/your-project/.git/hooks/*

# 4. Try it
# In Claude Code: /workflow test-feature
```

**Time:** 5 minutes
**See:** [STARTER-PACK/QUICK-START.md](./STARTER-PACK/QUICK-START.md)

---

### Path 2: Start with Domain Profile

**Best for:** Specific domain, want pre-customized example

```bash
# 1. Clone framework
git clone https://github.com/[your-org]/12-factor-agentops.git /tmp/12f

# 2. Copy STARTER-PACK (foundation)
cp -r /tmp/12f/examples/STARTER-PACK/.claude/ /path/to/your-project/

# 3. Add domain customization
# Example: software-dev
cp -r /tmp/12f/examples/profiles/software-dev/.claude/agents/* /path/to/your-project/.claude/agents/

# 4. Install hooks
cp /tmp/12f/examples/STARTER-PACK/shared/git-hooks/* /path/to/your-project/.git/hooks/
chmod +x /path/to/your-project/.git/hooks/*

# 5. Try it
# In Claude Code: /workflow test-feature
```

**Time:** 7-10 minutes
**See:** Domain profile README (e.g., `profiles/software-dev/README.md`)

---

### Path 3: Customize STARTER-PACK for Your Domain

**Best for:** Your domain not listed, want full control

```bash
# 1. Copy STARTER-PACK
cp -r /tmp/12f/examples/STARTER-PACK/.claude/ /path/to/your-project/

# 2. Customize agents
# Edit: .claude/agents/research-agent.md
# Add your domain-specific:
# - Tools (pytest, kubectl, npm, etc.)
# - File patterns (*.py, *.yaml, etc.)
# - Validation commands (make test, go test, etc.)

# 3. Keep:
# - Phase-based workflow (research → plan → implement → learn)
# - Validation gates (test before commit)
# - Five Laws (git memory, continuous improvement)

# 4. Try it
# In Claude Code: /workflow test-feature
```

**Time:** 15-30 minutes
**See:** [STARTER-PACK/README.md - Customization Guide](./STARTER-PACK/README.md#customization-guide)

---

## What Each Profile Includes

### STARTER-PACK Structure

```
STARTER-PACK/
├── README.md                    # Complete guide (10 min read)
├── QUICK-START.md               # 5-minute installation
├── WORKFLOWS.md                 # 3 universal examples
│
├── .claude/
│   ├── agents/
│   │   ├── research-agent.md    # Phase 1: Understanding
│   │   ├── plan-agent.md        # Phase 2: Designing
│   │   ├── implement-agent.md   # Phase 3: Executing
│   │   └── learn-agent.md       # Phase 4: Pattern extraction
│   │
│   ├── commands/
│   │   ├── research.md          # /research
│   │   ├── plan.md              # /plan
│   │   ├── implement.md         # /implement
│   │   ├── learn.md             # /learn
│   │   └── workflow.md          # /workflow (all 4 phases)
│   │
│   └── settings.json            # Minimal configuration
│
└── shared/                      # Foundation layer
    ├── LAWS.md                  # The Five Laws
    ├── INSTALL.md               # Installation guide
    ├── INTERACTION-STANDARDS.md # Consistent prompting
    └── git-hooks/               # Hook implementations
        ├── prepare-commit-msg
        ├── commit-msg
        ├── post-commit
        └── README.md
```

### Domain Profile Structure

```
profiles/software-dev/
├── README.md                    # Domain-specific guide
├── example-session.md           # Complete walkthrough
│
└── .claude/
    └── agents/
        └── [customized agents with domain tools]
```

---

## Token Budget & Composition

**Design principle:** Stay under 40% context utilization (Factor II: JIT Context Loading)

### Single Profile

```
STARTER-PACK:              8,000 tokens  (4%)    ✅ Safe
Headroom for work:       192,000 tokens (96%)
```

### STARTER-PACK + Domain Profile

```
STARTER-PACK:              8,000 tokens  (4%)
+ Domain profile:         12,000 tokens  (6%)
────────────────────────────────────────────
Total:                    20,000 tokens  (10%)   ✅ Safe
Headroom for work:       180,000 tokens (90%)
```

### Multi-Domain (Maximum Composition)

```
STARTER-PACK:              8,000 tokens  (4%)
+ software-dev:           12,000 tokens  (6%)
+ platform-ops:           10,000 tokens  (5%)
────────────────────────────────────────────
Total:                    30,000 tokens  (15%)   ✅ Safe
Headroom for work:       170,000 tokens (85%)
```

**Key insight:** Profiles designed for composition - combine multiple domains while staying under 40%.

---

## Production Validation

**From 200+ sessions using the STARTER-PACK workflow:**

- ✅ **Success rate:** 95% (validation gates catch errors before commit)
- ✅ **Efficiency:** 8x improvement vs ad-hoc approach
- ✅ **Context collapse:** 0% when following 40% rule
- ✅ **Pattern reuse:** 3-5x speedup on similar tasks
- ✅ **Time distribution:** Research 15-20%, Plan 20-30%, Implement 50-60%, Learn 5-10%

**See:** `../validation/SYNTHESIS.md` for complete metrics

---

## The 12 Factors Demonstrated

All profiles demonstrate the same 12 factors - domain customization doesn't change the principles:

| Factor | Implementation | Demonstrated In |
|--------|---------------|-----------------|
| **I. Git Memory** | Commits with Context/Solution/Learning/Impact | All phases |
| **II. JIT Context** | Load only what's needed, stay under 40% | Research phase |
| **III. Single-Responsibility** | One agent = one cognitive phase | Agent boundaries |
| **IV. Validation Gates** | 4-level validation before commit | Implement phase |
| **V. Operational Telemetry** | Track metrics, time, coverage | Implement phase |
| **VI. Session Continuity** | Bundles compress findings (37:1) | Between phases |
| **VII. Intelligent Routing** | Route to appropriate strategy | Research phase |
| **VIII. Human Gate Reviews** | Approval between plan and implement | Plan → Implement |
| **IX. Pattern Extraction** | Capture reusable insights | Plan + Learn phases |
| **X. Continuous Improvement** | Identify improvements with impact/effort | Learn phase |
| **XI. Constitutional Guardrails** | Hooks enforce Laws, validation | Git hooks + Implement |
| **XII. Domain Portability** | Works across domains | All agents (generic) |

**Domain profiles keep ALL factors** - they just add domain-specific tools.

---

## Contributing New Profiles

Want to add a profile for your domain?

**Requirements:**
1. Based on STARTER-PACK (don't reinvent the wheel)
2. Demonstrates same 12 factors
3. Includes example-session.md (show it working)
4. Documents token budget
5. README explains domain customization

**Process:**
1. Copy STARTER-PACK
2. Customize for your domain
3. Test in production (10+ sessions)
4. Document learnings
5. Submit PR to `profiles/[your-domain]/`

**See:** `../CONTRIBUTING.md` for detailed guidelines

---

## Frequently Asked Questions

### Q: Which profile should I start with?

**A:** STARTER-PACK. Always. It's the universal foundation everyone needs.

Then:
- Domain-agnostic work? → Use STARTER-PACK as-is
- Domain-specific work? → Add domain profile customization

---

### Q: Can I use multiple domain profiles together?

**A:** Yes! Profiles are designed for composition.

Example: software-dev + platform-ops = full-stack work

Just stay under 40% total context (see token budgets above).

---

### Q: Do I need to install git hooks?

**A:** No, but highly recommended.

**With hooks:** Five Laws enforced automatically (commit template, validation, learning extraction)

**Without hooks:** Manual discipline required (easy to skip)

**Install:** 2 minutes (see STARTER-PACK/shared/INSTALL.md)

---

### Q: Can I customize the agents?

**A:** Absolutely! Agents are markdown files - edit them directly.

**Keep:**
- Phase-based workflow (research → plan → implement → learn)
- Validation gates (test before commit)
- 12-Factor principles

**Customize:**
- Tools (kubectl, pytest, npm, etc.)
- File patterns (*.py, *.yaml, etc.)
- Domain terminology
- Examples

---

### Q: What if my domain isn't listed?

**A:** Create your own domain profile!

1. Copy STARTER-PACK
2. Add your domain tools
3. Test and iterate
4. (Optional) Contribute back

**See:** Path 3 above for customization guide

---

### Q: How do I know if I'm following 12-Factor principles?

**A:** Each agent documents which factors it implements.

**Check:**
- Git commits have Context/Solution/Learning/Impact? → Factor I ✅
- Staying under 40% context? → Factor II ✅
- One agent per phase? → Factor III ✅
- Validating before commit? → Factor IV ✅
- Tracking metrics? → Factor V ✅

**Full audit:** See `../validation/templates/` for compliance checklist

---

## Next Steps

### 1. Try STARTER-PACK (5 minutes)

```bash
# Quick-start guide
cat STARTER-PACK/QUICK-START.md

# Or just:
cp -r STARTER-PACK/.claude/ /path/to/your-project/
# In Claude Code: /workflow test
```

---

### 2. Read Complete Documentation

```bash
# Framework overview
cat ../README.md

# The 12 factors
cat ../factors/README.md

# Philosophical foundations
cat ../foundations/README.md
```

---

### 3. See Example Workflows

```bash
# Universal examples
cat STARTER-PACK/WORKFLOWS.md

# Domain-specific examples
cat profiles/software-dev/example-session.md
cat profiles/platform-ops/example-session.md
```

---

### 4. Validate Your Understanding

```bash
# Self-assessment
cat ../validation/templates/community-validation.md

# Try framework in your project
# Report back what worked/didn't
```

---

## Support

**Documentation:**
- STARTER-PACK guide: `STARTER-PACK/README.md`
- Quick-start: `STARTER-PACK/QUICK-START.md`
- Framework README: `../README.md`

**Community:**
- Issues: https://github.com/[your-org]/12-factor-agentops/issues
- Discussions: https://github.com/[your-org]/12-factor-agentops/discussions

---

**Start with STARTER-PACK. Customize for your domain. Ship great work.**

**Welcome to 12-Factor AgentOps.**
