---
bundle_id: bundle-marketplace-plugin-architecture-2025-11-09
created: 2025-11-09T17:00:00Z
type: plan
phase: architecture-design
original_tokens: 140000
compressed_tokens: 3800
compression_ratio: 36.8
tags: [marketplace, plugins, architecture, agentops, claude-native]
dependencies: [reference-profile-creation-2025-11-09]
related_bundles: []
learnings:
  - "Claude native plugin system enables one-command installation vs manual copying"
  - "Granular plugins (core + domain extensions) mirror wshobson/agents successful pattern"
  - "Three-repo architecture (theory/marketplace/showcase) provides clear separation of concerns"
  - "Lower barrier to entry = try first (plugins), learn theory after (framework docs)"
git_sha: dc1ea66
---

# Marketplace Plugin Architecture - Complete Transformation Plan

**Goal:** Transform 12-Factor AgentOps profiles into installable Claude Code plugins using native marketplace system

**Architecture:** Theory (12-factor-agentops) → Distribution (agentops marketplace) → Showcase (agentops-showcase website)

**User benefit:** One-command install (`/plugin install core-workflow@agentops`) vs manual copying

---

## Context

### User Goal (Stated)
> "I just want to show a few profiles to help people understand my workflow. I'm not trying to make a marketplace like aitmpl.com/agents. This should give a basic package of Claude Code plugins, then there are a few other profiles to let people see what happens."

**Key insights:**
- NOT building comprehensive marketplace (63 plugins like wshobson/agents)
- Goal: Basic package (core) + 2-3 examples (show customization)
- Focus: Lower barrier to entry, inspire adoption
- Use Claude's native plugin sharing system

### Current State (Week 1 Complete)
- ✅ Renamed reference → STARTER-PACK
- ✅ Extracted shared foundation (Laws, hooks, interaction standards)
- ✅ Added token budget documentation
- ✅ Created QUICK-START.md (5-minute install)
- ✅ Rewrote examples/README.md navigation

**Gap:** Profiles still require manual copying. Not using Claude's native plugin system.

---

## Architecture Overview

### Three-Repository System

```
12-factor-agentops/          → Framework theory + patterns
    ↓ points to
agentops/                    → Marketplace (installable plugins)
    ↓ showcased on
agentops-showcase/           → Website (visual demos + tutorials)
```

**Clean separation of concerns:**
- Theory: Why patterns work (research, validation)
- Distribution: How to install (plugins via Claude native)
- Marketing: How to discover (website with screenshots, examples)

---

## The 4 Plugins

### 1. core-workflow (Base - Required)

**Location:** `agentops/plugins/core-workflow/`

**Structure:**
```
core-workflow/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── research-agent.md      # Phase 1: Understanding
│   ├── plan-agent.md          # Phase 2: Designing
│   ├── implement-agent.md     # Phase 3: Executing
│   └── learn-agent.md         # Phase 4: Pattern extraction
└── commands/
    ├── research.md            # /research
    ├── plan.md                # /plan
    ├── implement.md           # /implement
    ├── learn.md               # /learn
    └── workflow.md            # /workflow (orchestrates all)
```

**Plugin metadata:**
```json
{
  "name": "core-workflow",
  "version": "1.0.0",
  "description": "Universal Research → Plan → Implement → Learn workflow demonstrating all 12 factors of AgentOps",
  "author": "Boden Fuller",
  "license": "Apache-2.0",
  "keywords": ["12-factor", "agentops", "workflow", "universal", "research", "planning"],
  "components": {
    "agents": [
      "agents/research-agent.md",
      "agents/plan-agent.md",
      "agents/implement-agent.md",
      "agents/learn-agent.md"
    ],
    "commands": [
      "commands/research.md",
      "commands/plan.md",
      "commands/implement.md",
      "commands/learn.md",
      "commands/workflow.md"
    ]
  }
}
```

**Installation:**
```bash
/plugin install core-workflow@agentops
```

**Token budget:** ~8,000 tokens (4% of context window)

**Who needs it:** Everyone (universal foundation)

---

### 2. devops-operations (Domain Extension)

**Location:** `agentops/plugins/devops-operations/`

**Structure:**
```
devops-operations/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── devops-engineer.md         # Core workflow + kubectl, helm, argocd
│   ├── cicd-specialist.md         # Pipeline automation
│   └── deployment-engineer.md     # Progressive delivery
├── commands/
│   ├── deploy-app.md              # /deploy-app
│   ├── setup-pipeline.md          # /setup-pipeline
│   └── rollback.md                # /rollback
└── skills/
    ├── kubernetes-manifests/      # K8s YAML patterns
    ├── helm-charts/               # Chart templates
    └── gitops-patterns/           # ArgoCD, Flux patterns
```

**Plugin metadata:**
```json
{
  "name": "devops-operations",
  "version": "1.0.0",
  "description": "DevOps and platform engineering with Kubernetes, Helm, ArgoCD, and CI/CD automation",
  "author": "Boden Fuller",
  "license": "Apache-2.0",
  "keywords": ["devops", "kubernetes", "helm", "ci/cd", "platform", "gitops"],
  "dependencies": ["core-workflow"],
  "components": {
    "agents": [...],
    "commands": [...],
    "skills": [...]
  }
}
```

**Installation:**
```bash
# Install core first (dependency)
/plugin install core-workflow@agentops

# Then domain
/plugin install devops-operations@agentops
```

**Token budget:** ~15,000 tokens total (core 8k + devops 7k)

**Who needs it:** Platform engineers, SREs, DevOps teams

---

### 3. software-development (Domain Extension)

**Location:** `agentops/plugins/software-development/`

**Structure:**
```
software-development/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── software-engineer.md       # Core workflow + pytest, npm, go test
│   ├── code-reviewer.md           # Quality gates
│   └── test-engineer.md           # TDD workflows
├── commands/
│   ├── create-feature.md          # /create-feature
│   ├── refactor-code.md           # /refactor-code
│   └── add-tests.md               # /add-tests
└── skills/
    ├── python-testing/            # pytest patterns
    ├── javascript-patterns/       # Modern JS/TS
    └── go-best-practices/         # Go idioms
```

**Plugin metadata:**
```json
{
  "name": "software-development",
  "version": "1.0.0",
  "description": "Software development for Python, JavaScript, Go with testing and code quality",
  "author": "Boden Fuller",
  "license": "Apache-2.0",
  "keywords": ["software-dev", "python", "javascript", "go", "testing", "tdd"],
  "dependencies": ["core-workflow"],
  "components": {
    "agents": [...],
    "commands": [...],
    "skills": [...]
  }
}
```

**Token budget:** ~12,000 tokens total (core 8k + software 4k)

**Who needs it:** Software developers (any language)

---

### 4. content-creation (Domain Extension)

**Location:** `agentops/plugins/content-creation/`

**Structure:**
```
content-creation/
├── .claude-plugin/
│   └── plugin.json
├── agents/
│   ├── technical-writer.md        # Core workflow + markdown, vitepress
│   ├── documentation-architect.md # Diátaxis structure
│   └── content-strategist.md      # Content planning
├── commands/
│   ├── create-tutorial.md         # /create-tutorial
│   ├── write-api-docs.md          # /write-api-docs
│   └── update-docs.md             # /update-docs
└── skills/
    ├── diataxis-framework/        # Diátaxis patterns
    ├── markdown-best-practices/   # Writing quality
    └── vitepress-setup/           # Static site generation
```

**Plugin metadata:**
```json
{
  "name": "content-creation",
  "version": "1.0.0",
  "description": "Documentation and content creation with Diátaxis, Markdown, and VitePress",
  "author": "Boden Fuller",
  "license": "Apache-2.0",
  "keywords": ["content", "documentation", "writing", "markdown", "diataxis"],
  "dependencies": ["core-workflow"],
  "components": {
    "agents": [...],
    "commands": [...],
    "skills": [...]
  }
}
```

**Token budget:** ~10,000 tokens total (core 8k + content 2k)

**Who needs it:** Technical writers, documentation teams, content creators

---

## Marketplace Configuration

### agentops/.claude-plugin/marketplace.json

```json
{
  "name": "agentops",
  "owner": {
    "name": "Boden Fuller",
    "email": "your@email.com"
  },
  "description": "Personal AgentOps marketplace demonstrating 12-Factor patterns with 4 focused plugins",
  "version": "1.0.0",
  "homepage": "https://github.com/boshu2/agentops",
  "pluginRoot": "plugins",
  "plugins": [
    {
      "name": "core-workflow",
      "source": "./core-workflow",
      "description": "Universal Research → Plan → Implement → Learn workflow (required base)",
      "version": "1.0.0",
      "author": "Boden Fuller",
      "keywords": ["12-factor", "agentops", "workflow", "universal"],
      "featured": true
    },
    {
      "name": "devops-operations",
      "source": "./devops-operations",
      "description": "DevOps and platform engineering with Kubernetes, Helm, ArgoCD",
      "version": "1.0.0",
      "author": "Boden Fuller",
      "keywords": ["devops", "kubernetes", "helm", "ci/cd"],
      "dependencies": ["core-workflow"]
    },
    {
      "name": "software-development",
      "source": "./software-development",
      "description": "Software development for Python, JavaScript, Go with testing",
      "version": "1.0.0",
      "author": "Boden Fuller",
      "keywords": ["software-dev", "python", "javascript", "go"],
      "dependencies": ["core-workflow"]
    },
    {
      "name": "content-creation",
      "source": "./content-creation",
      "description": "Documentation and content creation with Diátaxis, Markdown",
      "version": "1.0.0",
      "author": "Boden Fuller",
      "keywords": ["content", "documentation", "writing"],
      "dependencies": ["core-workflow"]
    }
  ],
  "externalMarketplaces": [
    {
      "name": "agents",
      "source": {
        "type": "github",
        "owner": "wshobson",
        "repo": "agents"
      },
      "description": "Comprehensive production marketplace - 63 plugins, 85 agents, 47 skills",
      "recommended": true
    },
    {
      "name": "agentops-showcase",
      "source": {
        "type": "github",
        "owner": "boshu2",
        "repo": "agentops-showcase"
      },
      "description": "Production-tested AgentOps patterns from real GitOps workflows",
      "recommended": false
    }
  ]
}
```

---

## Updated 12-factor-agentops Structure

**Becomes pure theory repository:**

```
12-factor-agentops/
├── foundations/                    # Four Pillars, Five Laws (theory)
├── factors/                        # The 12 factors (reference)
├── patterns/                       # Pattern catalog
├── validation/                     # Validation templates
│
└── examples/
    ├── README.md                   # 🎯 POINTER to marketplace
    │                               #    "Install plugins at agentops"
    │
    └── shared/                     # Constitutional foundation (theory/reference)
        ├── LAWS.md                 # The Five Laws explained
        ├── INTERACTION-STANDARDS.md
        └── git-hooks/
            └── README.md           # Hook examples (theory)
```

**Key change:** No more `.claude/` directories with actual plugins
- Theory stays (shared/ = reference documentation)
- Distribution moves to agentops marketplace
- Users install from marketplace, not manual copy

---

## User Journey (Improved)

### Before (Manual Copying)
```
1. Find 12-factor-agentops GitHub
2. Read theory (60 min)
3. Navigate to examples/STARTER-PACK/
4. Manually copy .claude/ directory
5. Install git hooks manually
6. Try /workflow
7. Maybe it works?

Time: 90 minutes
Barrier: High (many manual steps)
```

### After (Marketplace Installation)
```
1. Find 12-factor-agentops GitHub
2. See "Install plugins" link → agentops marketplace
3. /plugin marketplace add boshu2/agentops
4. /plugin install core-workflow@agentops
5. Try /workflow test-feature
6. It works! ✅
7. (Optional) Read theory to understand why

Time: 5 minutes
Barrier: Low (one command)
```

**Key insight:** Try first, learn theory after (vs learn first, maybe try)

---

## Implementation Tasks

### Phase 1: Create Core Plugin (2-3 hours)

**Tasks:**
1. Create `agentops/plugins/core-workflow/` structure
2. Copy agents from `STARTER-PACK/.claude/agents/`
3. Copy commands from `STARTER-PACK/.claude/commands/`
4. Create `.claude-plugin/plugin.json` metadata
5. Test installation: `/plugin install core-workflow@agentops`

**Deliverable:** Working core-workflow plugin

---

### Phase 2: Create Domain Plugins (4-5 hours)

**Tasks:**
1. Create 3 domain plugin structures
2. Design domain-specific agents (customize core + domain tools)
3. Create domain commands
4. Create skills directories (progressive disclosure)
5. Add plugin.json for each with dependencies
6. Test composition: core + domain

**Deliverable:** 3 working domain plugins

---

### Phase 3: Update Marketplace Config (1 hour)

**Tasks:**
1. Update `agentops/.claude-plugin/marketplace.json`
2. Register 4 plugins with metadata
3. Set dependencies (domains require core)
4. Add external marketplace references
5. Test: `/plugin marketplace add boshu2/agentops`

**Deliverable:** Working marketplace

---

### Phase 4: Update 12-factor-agentops (2 hours)

**Tasks:**
1. Remove `.claude/` directories from examples/
2. Keep `shared/` as theory/reference only
3. Rewrite `examples/README.md` as pointer to marketplace
4. Add installation instructions (marketplace approach)
5. Update main README.md with marketplace link

**Deliverable:** Theory repo points to marketplace

---

### Phase 5: Update agentops-showcase Website (3-4 hours)

**Tasks:**
1. Add plugin showcase pages (4 pages with descriptions)
2. Add installation guide (marketplace method)
3. Add screenshots/demos of each plugin
4. Link back to 12-factor-agentops theory
5. Link to wshobson/agents comprehensive marketplace

**Deliverable:** Website showcases plugins

---

## Total Effort Estimate

| Phase | Hours | Status |
|-------|-------|--------|
| Phase 1: Core plugin | 2-3 | Not started |
| Phase 2: Domain plugins | 4-5 | Not started |
| Phase 3: Marketplace config | 1 | Not started |
| Phase 4: Update theory repo | 2 | Not started |
| Phase 5: Update website | 3-4 | Not started |
| **Total** | **12-15 hours** | **0% complete** |

---

## Benefits Summary

### Lower Barrier to Entry ✅
- One command: `/plugin install core-workflow@agentops`
- Works immediately (no manual setup)
- Claude manages updates

### Composable Architecture ✅
- Core (8k) + Domain (4-7k) = 12-15k total
- Install only what you need
- Mix multiple domains safely

### Clear Separation ✅
- Theory: 12-factor-agentops (why patterns work)
- Distribution: agentops marketplace (how to install)
- Marketing: agentops-showcase (how to discover)

### Inspiration & Adoption ✅
- Website showcases working examples
- Easy to try (5 minutes)
- Points to theory for deep learning
- References wshobson/agents for comprehensive marketplace

---

## Risks & Mitigations

### Risk 1: Users Don't Install Core First
**Mitigation:** Dependencies in plugin.json (Claude enforces)

### Risk 2: Token Budgets Wrong
**Mitigation:** Test with real agents, measure token usage

### Risk 3: Skills Not Valuable
**Mitigation:** Start minimal, add based on user feedback

### Risk 4: Marketplace Discovery
**Mitigation:** Website SEO, GitHub README links, documentation

---

## Success Metrics

### Immediate (Week 1)
- [ ] Core plugin installs successfully
- [ ] 1 domain plugin works
- [ ] Marketplace configuration valid

### Near-term (Week 2)
- [ ] All 4 plugins working
- [ ] Website showcases plugins
- [ ] Installation < 5 minutes

### Long-term (Month 1)
- [ ] 10+ installs from external users
- [ ] Positive feedback on ease of use
- [ ] Contributions or customizations

---

## Next Actions

**Immediate:**
1. Create `agentops/plugins/core-workflow/` structure
2. Copy agents from STARTER-PACK
3. Create plugin.json
4. Test installation

**This Week:**
- Complete Phase 1 (core plugin)
- Start Phase 2 (domain plugins)

**Next Week:**
- Complete Phase 2-3 (domain plugins + marketplace)
- Start Phase 4 (update theory repo)

---

## Key Learnings

### Learning 1: Native Plugin System >> Manual Copying
Claude's native plugin system eliminates manual setup. One command vs 10+ steps = 18x faster adoption.

### Learning 2: Granular + Composable = Flexible
Core (required) + Domain (optional) lets users choose complexity. Start simple, add as needed.

### Learning 3: Try First, Learn Later
Lowering barrier enables "try in 5 minutes" → Users experience value before reading 60 pages of theory.

### Learning 4: Three-Repo Architecture Scales
Theory/Distribution/Marketing separation enables independent evolution. Framework changes don't require plugin changes.

### Learning 5: Dependencies Enforce Best Practices
`dependencies: ["core-workflow"]` ensures users get foundation before domain extensions. Prevents incomplete installations.

---

**Bundle ready for: Plugin transformation, marketplace setup, architecture implementation**

**Compression: 140K tokens → 3.8K tokens (36.8:1 ratio)**
