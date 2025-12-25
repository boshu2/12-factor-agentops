# Factor XII: Package Patterns

**Bundle what works for reuse - capture successful workflows as reusable packages**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Knowledge OS |
| **Supporting Pillar** | DevOps + SRE |
| **Enforces Laws** | Law 1 (Extract Learnings), Law 5 (Share Patterns) |
| **Derived From** | Code reuse + Package systems + Profile systems + Domain-driven design |


---

## Summary

Agent workflows, patterns, and knowledge accumulated in one domain should be packaged and portable to other domains. Domain packages are self-contained bundles (agents, workflows, patterns, configurations) that enable instant productivity in new contexts. Build once, reuse everywhere.

## The Problem

Without domain portability:
- Start from zero in each new domain
- Rediscover patterns already known
- Can't transfer knowledge across contexts
- Waste time rebuilding what exists
- No compounding returns on investment

**Familiar pattern:**
```
Domain 1 (Customer Service): Build 52 workflows over 2 years
Domain 2 (Sales): Start from zero, rebuild workflows
Domain 3 (Research): Start from zero again
Result: 3× the work, no knowledge transfer
```

**Traditional approach:** Build domain-specific solutions, no reuse

**12-Factor AgentOps approach:** Package domain knowledge, instant deployment

---

## Why This Factor Exists

### Grounding in the Five Pillars

**Primary: Knowledge OS**

Domain portability operationalizes Knowledge OS's principle that knowledge should compound, not duplicate. Building 52 workflows for customer service over 2 years represents enormous knowledge capital—but if this knowledge can't transfer to sales or research domains, you start from zero three times. The "Don't Repeat Yourself" principle from software engineering applies to knowledge: package once, reuse everywhere.

Package systems demonstrate this well: templates (reusable workflows) + values (configurable parameters) = install anywhere. Domain packages apply the same pattern to agent workflows: agents (reusable workflows) + config (configurable parameters) = deploy in any domain. The first package takes 2 years to develop, the second takes 2 weeks to adapt, the third takes 1 week. This is knowledge compound interest.

**Supporting: DevOps + SRE**

DevOps provides the domain-driven design pattern: capture domain knowledge in bounded contexts. Customer Service Operations is a bounded context with entities (Customers, Tickets, Refunds), operations (Resolve, Escalate, Follow-up), and language (SLA, CSAT, first-contact resolution). Packaging this context as a domain package makes the knowledge portable and reusable across any customer service environment.

---

## What This Factor Enforces

### Law 1: Extract Learnings

Domain packages enforce learning extraction by requiring generalization from specific implementations. To create a package, you must abstract: "We gave customer #1234 a 20% discount" becomes "Proportional compensation for service failures." This abstraction process IS learning extraction—converting specific solutions into general principles.

**Concrete example:** Building customer service package forces extraction: which patterns are customer-service-specific vs. universally applicable? The research→plan→execute workflow generalizes across all domains. The empathetic-resolution pattern is customer-service-specific. Package creation forces this categorization, extracting reusable learnings from domain context.

### Law 5: Share Patterns Publicly

Domain packages operationalize Law 5 by packaging knowledge for distribution. A package is a shareable artifact: package specification, agent definitions, workflow patterns, documentation. Publishing to a public registry enables community use and contribution.

**Concrete example:** Customer-service package published to public registry → 1000 downloads → 25 issues reported → 15 pull requests with improvements → Your package improves through community contributions → Your team benefits from community enhancements. Public sharing creates network effects where private hoarding creates isolated stagnation. Law 5 enforcement through shareable package format.

---

## The Principle

### What is a Domain Package?

**A portable package containing:**

1. **Agents** - Domain-specific agent definitions
2. **Workflows** - Common workflow patterns for this domain
3. **Patterns** - Documented solutions to domain problems
4. **Configurations** - Domain-specific settings
5. **Documentation** - How to operate in this domain
6. **Validations** - Domain-specific quality gates

**Example: Customer Service Package**
```
packages/customer-service/
├── agents/
│   ├── handle-inquiry.md
│   ├── process-refund.md
│   ├── escalate-complaint.md
│   └── follow-up-satisfaction.md
├── workflows/
│   ├── resolve-ticket.md
│   ├── handle-escalation.md
│   └── proactive-outreach.md
├── patterns/
│   ├── empathetic-resolution.md
│   ├── proactive-compensation.md
│   └── satisfaction-recovery.md
├── config/
│   ├── validation-rules.yaml
│   ├── escalation-thresholds.yaml
│   └── default-settings.yaml
├── docs/
│   ├── getting-started.md
│   ├── best-practices.md
│   └── troubleshooting.md
└── README.md
```

### Package Lifecycle

```
1. DEVELOP in one domain
   - Build agents, workflows, patterns
   - Validate through production use
   - Document what works

2. EXTRACT common knowledge
   - Identify domain-specific patterns
   - Separate domain logic from implementation
   - Create generalized templates

3. PACKAGE as domain bundle
   - Bundle agents, workflows, patterns
   - Version and release
   - Publish to registry

4. INSTALL in new domain
   - Download package
   - Configure for local context
   - Deploy instantly

5. ADAPT for local needs
   - Customize configurations
   - Add domain-specific extensions
   - Contribute improvements back
```

---

## Why This Works

### 1. Code Reuse (Software Engineering)

**DRY principle:**
> "Don't Repeat Yourself"

**For domain knowledge:**
```
Without packages:
  Customer Service domain: 2 years, 52 workflows
  Sales domain: 2 years, 48 workflows
  Total: 4 years, 100 workflows

With packages:
  Customer Service domain: 2 years, 52 workflows
  Customer Service package: Package knowledge
  Sales domain: Install package, adapt (2 weeks)
  Total: 2 years + 2 weeks, 52+ workflows

Savings: 95% time reduction for second domain
```

### 2. Package Systems Pattern

**Package principle:**
> "Bundle applications for reuse"

**For agent workflows:**
```
Package system:
  - Templates (reusable definitions)
  - Values (configurable parameters)
  - Install anywhere

Agent package:
  - Agents (reusable workflows)
  - Config (configurable parameters)
  - Deploy anywhere
```

### 3. Domain-Driven Design (DDD)

**DDD principle:**
> "Capture domain knowledge in bounded contexts"

**For agent packages:**
```
Bounded context: Customer Service Operations
- Entities: Customers, Tickets, Refunds
- Operations: Resolve, Escalate, Follow-up
- Patterns: Empathetic resolution, Proactive compensation
- Language: SLA, CSAT, first-contact resolution

Package captures this knowledge → Reusable in any customer service context
```

### 4. Network Effects of Sharing

**Problem:** Private packages stay private

**Solution:** Public packages benefit everyone
```
Private package:
  Your team: 10 people
  Benefit: 10×

Public package:
  Community: 1000 people
  Benefit: 1000×
  Contributions: Community improves your package
  Result: Compound returns
```

---

## Implementation

### Package Structure Specification

**Standard package format:**
```yaml
# package.yaml
name: customer-service
version: 1.2.0
description: Customer service workflows and patterns
author: Your Team
license: MIT

dependencies:
  - core-workflow@^2.0.0
  - communication-patterns@^1.5.0

agents:
  - agents/handle-inquiry.md
  - agents/process-refund.md
  - agents/escalate-complaint.md

workflows:
  - workflows/resolve-ticket.md
  - workflows/handle-escalation.md

patterns:
  - patterns/empathetic-resolution.md
  - patterns/proactive-compensation.md

config:
  validation_rules: config/validation-rules.yaml
  escalation_thresholds: config/escalation-thresholds.yaml
  defaults: config/default-settings.yaml

documentation:
  getting_started: docs/getting-started.md
  best_practices: docs/best-practices.md
```

### Package Installation

**Command-line tool:**
```bash
# Install package
agentops package install customer-service@1.2.0

# What it does:
# 1. Download package from registry
# 2. Validate package integrity
# 3. Install agents to agents/
# 4. Install workflows to workflows/
# 5. Install patterns to patterns/
# 6. Merge configurations
# 7. Generate documentation

# List installed packages
agentops package list

# Output:
# customer-service@1.2.0 (installed 2025-01-27)
# sales-operations@0.9.0 (installed 2025-02-15)
# research-workflow@1.0.0 (installed 2025-03-01)
```

**Installation implementation:**
```python
class PackageInstaller:
    def install(self, package_name, version):
        # 1. Download from registry
        package = self.download_package(package_name, version)

        # 2. Validate
        if not self.validate_package(package):
            raise InvalidPackageError()

        # 3. Check dependencies
        for dep in package.dependencies:
            if not self.is_installed(dep):
                self.install(dep.name, dep.version)

        # 4. Install components
        self.install_agents(package.agents)
        self.install_workflows(package.workflows)
        self.install_patterns(package.patterns)

        # 5. Merge configurations
        self.merge_config(package.config)

        # 6. Register installation
        self.register_package(package)

        return package
```

### Package Customization

**Local overrides:**
```yaml
# packages/customer-service.local.yaml
# Customizations for this specific deployment

config:
  # Override default escalation threshold
  escalation_threshold: $500

  # Add custom validation rules
  custom_validations:
    - require_satisfaction_check: true
    - enforce_follow_up: true

agents:
  # Add local agent
  custom_agents:
    - local/agents/vip-customer-handler.md

workflows:
  # Disable workflow not needed here
  disabled:
    - workflows/proactive-outreach.md
```

### Package Registry

**Public package registry:**
```
https://packages.12factor-agentops.dev/

Available packages:
- customer-service (1.2.0) - 52 agents, 15 workflows
- sales-operations (0.9.0) - 30 agents, 10 workflows
- research-workflow (1.0.0) - 25 agents, 8 workflows
- support-escalation (0.8.0) - 20 agents, 7 workflows
- data-analysis (1.1.0) - 18 agents, 6 workflows
- content-creation (1.0.0) - 22 agents, 9 workflows
```

**Package publishing:**
```bash
# Package for distribution
agentops package build

# Output: customer-service-1.2.0.tar.gz

# Publish to registry
agentops package publish customer-service-1.2.0.tar.gz

# Validates:
# - Package structure correct
# - All files present
# - Documentation complete
# - Version not already published
# - License specified
```

---

## Validation

### ✅ You're doing this right if:
- Domains packaged as portable bundles
- Packages installable in minutes (not days)
- Packages versioned and released
- Community contributes to public packages
- New domains productive immediately (not months)

### ❌ You're doing this wrong if:
- No packages (everything ad-hoc)
- Packages not portable (hardcoded assumptions)
- Packages not versioned (breaking changes)
- Packages not shared (private only)
- Each domain starts from zero

---

## Real-World Evidence

### Package Development Timeline

**Customer Service Package:**
```
Year 1: Develop in production
- Built 52 agents over 24 months
- Validated 15 workflows
- Extracted 12 patterns
- Investment: 2 years

Year 2: Package as bundle
- Extracted common knowledge
- Created package structure
- Published version 1.0.0
- Investment: 2 weeks
```

**Sales Operations Package (Second Domain):**
```
Using Customer Service package as template:
- Installed customer-service package
- Adapted for sales domain
- Created sales-operations package
- Time: 2 weeks (vs. 2 years from scratch)

Productivity: 52× faster (2 weeks vs. 2 years)
```

**Research Workflow Package (Third Domain):**
```
Using both previous packages as references:
- Installed customer-service + sales-operations
- Identified common patterns
- Created research-workflow package
- Time: 1 week

Productivity: 104× faster (1 week vs. 2 years)
```

**Learning curve:**
```
Domain 1: 2 years
Domain 2: 2 weeks (52× faster)
Domain 3: 1 week (104× faster)
Domain 4+: Estimated <1 week

Marginal cost decreases with each package
```

### Community Impact

**Public package sharing:**
```
Your package: customer-service
Downloads: 1000
Issues reported: 25
Pull requests: 15
Improvements contributed: 8

Result:
- Your package improves through community contributions
- Your team benefits from improvements
- Community benefits from your work
- Network effects compound
```

---

## Anti-Patterns

### ❌ The "Monolithic Package" Trap
**Wrong:** One massive package for everything
**Right:** Focused packages per domain, composable

### ❌ The "Hardcoded Assumptions" Trap
**Wrong:** Package assumes specific environment
**Right:** Configurable, works anywhere with config

### ❌ The "No Versioning" Trap
**Wrong:** Update package, break all users
**Right:** Semantic versioning, backward compatibility

### ❌ The "Private Hoarding" Trap
**Wrong:** Keep all packages private
**Right:** Share publicly (Law 5), benefit from network effects

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Packages versioned in persistent memory
- **Factor III: Focused Agents**: Packages contain single-responsibility agents
- **Factor IX: Mine Patterns**: Packages bundle extracted patterns
- **Factor X: Small Iterations**: Package updates driven by improvement backlog
- **Factor XI: Fail-Safe Checks**: Packages include domain-specific guardrails

---

## Package Categories

### Category 1: Domain Packages

**Examples:**
- customer-service
- sales-operations
- research-workflow
- content-creation
- data-analysis

**Contents:** Domain-specific agents, workflows, patterns

### Category 2: Industry Packages

**Examples:**
- healthcare-compliance
- financial-services
- e-commerce-operations
- education-support

**Contents:** Industry-specific operations, regulations

### Category 3: Process Packages

**Examples:**
- agile-workflow
- kanban-operations
- incident-response
- quality-assurance

**Contents:** Process workflows, templates, checklists

### Category 4: Meta Packages

**Examples:**
- agentops-core (this framework)
- documentation-standards
- quality-gates
- compliance-requirements

**Contents:** Cross-cutting concerns, standards, governance

---

## Package Composition

**Packages can depend on other packages:**

```yaml
# sales-operations package.yaml
name: sales-operations
version: 0.9.0

dependencies:
  - core-workflow@^2.0.0        # Base workflow operations
  - communication-patterns@^1.5.0  # Communication utilities
  - validation-gates@^1.0.0     # Quality gates

# Inherits agents from dependencies
# Adds sales-specific agents
# Composes into complete package
```

**Composition enables:**
- **Reuse:** Don't rebuild common capabilities
- **Focus:** Package only domain-specific knowledge
- **Evolution:** Update dependencies independently
- **Modularity:** Mix and match packages

---

## Migration from Unstructured to Packages

**Step-by-step migration:**

```markdown
# Phase 1: Inventory (Week 1)
- List all agents in current use
- List all workflows
- List all patterns
- Categorize by domain

# Phase 2: Extract (Week 2)
- Group agents by domain
- Identify domain boundaries
- Extract common patterns
- Document domain knowledge

# Phase 3: Package (Week 3)
- Create package structure
- Populate package.yaml
- Organize files
- Write documentation

# Phase 4: Test (Week 4)
- Install package in clean environment
- Verify all agents work
- Test workflows end-to-end
- Fix issues

# Phase 5: Publish (Week 5)
- Version package (1.0.0)
- Publish to registry
- Announce to community
- Gather feedback

Total time: 5 weeks
Result: Portable, reusable domain knowledge
```

---

## Next Steps

1. **Inventory current agents** by domain
2. **Create first package** (start with most mature domain)
3. **Package and version** bundle
4. **Test installation** in clean environment
5. **Publish publicly** (GitHub, registry)
6. **Document lessons learned** for next package

---

## Further Reading

- **Knowledge OS Pillar**: [../docs/principles/knowledge-os.md](../docs/principles/knowledge-os.md)
- **Law 1 (Extract Learnings)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-1)
- **Law 5 (Share Patterns)**: [../docs/principles/nine-laws.md](../docs/principles/nine-laws.md#law-5)
- **Factor IX: Mine Patterns**: [./09-mine-patterns.md](./09-mine-patterns.md)
- **Domain-Driven Design**: [Wikipedia: Domain-driven design](https://en.wikipedia.org/wiki/Domain-driven_design)

---

**Remember:** Domain knowledge is valuable. Package it, version it, share it. Packages enable instant productivity in new domains. Build once, reuse everywhere. The first package takes years. The second takes weeks. The third takes days. Compound your knowledge investment.
