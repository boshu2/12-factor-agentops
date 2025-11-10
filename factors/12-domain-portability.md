# Factor XII: Package Patterns

**Bundle what works for reuse - capture successful workflows as reusable templates**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Knowledge OS |
| **Supporting Pillar** | DevOps + SRE |
| **Enforces Laws** | Law 1 (Extract Learnings), Law 5 (Share Patterns) |
| **Derived From** | Code reuse + Helm charts + Profile systems + Domain-driven design |

📘 **[See complete derivation →](../ARCHITECTURE.md#factor-xii-domain-portability)**

---

## Summary

Agent workflows, patterns, and knowledge accumulated in one domain should be packaged and portable to other domains. Domain profiles are self-contained packages (agents, workflows, patterns, configurations) that enable instant productivity in new contexts. Build once, reuse everywhere.

## The Problem

Without domain portability:
- Start from zero in each new domain
- Rediscover patterns already known
- Can't transfer knowledge across contexts
- Waste time rebuilding what exists
- No compounding returns on investment

**Familiar pattern:**
```
Domain 1 (Kubernetes): Build 52 workflows over 2 years
Domain 2 (Terraform): Start from zero, rebuild workflows
Domain 3 (Python): Start from zero again
Result: 3× the work, no knowledge transfer
```

**Traditional approach:** Build domain-specific solutions, no reuse

**12-Factor AgentOps approach:** Package domain knowledge, instant deployment

---

## Why This Factor Exists

### Grounding in the Four Pillars

**Primary: Knowledge OS**

Domain portability operationalizes Knowledge OS's principle that knowledge should compound, not duplicate. Building 52 workflows for Kubernetes over 2 years represents enormous knowledge capital—but if this knowledge can't transfer to Terraform or Python domains, you start from zero three times. The "Don't Repeat Yourself" principle from software engineering applies to knowledge: package once, reuse everywhere.

Helm charts demonstrated this for Kubernetes: templates (reusable YAML) + values (configurable parameters) = install anywhere. Domain profiles apply the same pattern to agent workflows: agents (reusable workflows) + config (configurable parameters) = deploy in any domain. The first profile takes 2 years to develop, the second takes 2 weeks to adapt, the third takes 1 week. This is knowledge compound interest.

**Supporting: DevOps + SRE**

DevOps provides the domain-driven design pattern: capture domain knowledge in bounded contexts. Kubernetes Operations is a bounded context with entities (Pods, Services, Deployments), operations (Create, Scale, Delete), and language (kubectl, YAML, manifests). Packaging this context as a profile makes the knowledge portable and reusable across any Kubernetes environment.

---

## What This Factor Enforces

### Law 1: Extract Learnings

Domain profiles enforce learning extraction by requiring generalization from specific implementations. To create a profile, you must abstract: "We used PostgreSQL StatefulSet with 3 replicas" becomes "Stateful services need replicated storage." This abstraction process IS learning extraction—converting specific solutions into general principles.

**Concrete example:** Building Kubernetes profile forces extraction: which patterns are Kubernetes-specific vs. universally applicable? The research→plan→implement workflow generalizes across all domains. The StatefulSet pattern is Kubernetes-specific. Profile creation forces this categorization, extracting reusable learnings from domain context.

### Law 5: Share Patterns Publicly

Domain profiles operationalize Law 5 by packaging knowledge for distribution. A profile is a shareable artifact: profile.yaml specification, agent definitions, workflow patterns, documentation. Publishing to a public registry (like Helm charts) enables community use and contribution.

**Concrete example:** Kubernetes-ops profile published to public registry → 1000 downloads → 25 issues reported → 15 pull requests with improvements → Your profile improves through community contributions → Your team benefits from community enhancements. Public sharing creates network effects where private hoarding creates isolated stagnation. Law 5 enforcement through shareable package format.

---

## The Principle

### What is a Domain Profile?

**A portable package containing:**

1. **Agents** - Domain-specific agent definitions
2. **Workflows** - Common workflow patterns for this domain
3. **Patterns** - Documented solutions to domain problems
4. **Configurations** - Domain-specific settings
5. **Documentation** - How to operate in this domain
6. **Validations** - Domain-specific quality gates

**Example: Kubernetes Operations Profile**
```
profiles/kubernetes-ops/
├── agents/
│   ├── create-deployment.md
│   ├── create-statefulset.md
│   ├── create-service.md
│   └── validate-manifest.md
├── workflows/
│   ├── deploy-application.md
│   ├── scale-workload.md
│   └── troubleshoot-pod.md
├── patterns/
│   ├── stateful-applications.md
│   ├── ingress-routing.md
│   └── persistent-storage.md
├── config/
│   ├── validation-rules.yaml
│   ├── naming-conventions.yaml
│   └── default-settings.yaml
├── docs/
│   ├── getting-started.md
│   ├── best-practices.md
│   └── troubleshooting.md
└── README.md
```

### Profile Lifecycle

```
1. DEVELOP in one domain
   - Build agents, workflows, patterns
   - Validate through production use
   - Document what works

2. EXTRACT common knowledge
   - Identify domain-specific patterns
   - Separate domain logic from implementation
   - Create generalized templates

3. PACKAGE as profile
   - Bundle agents, workflows, patterns
   - Version and release
   - Publish to registry

4. INSTALL in new domain
   - Download profile package
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
Without profiles:
  Kubernetes domain: 2 years, 52 workflows
  Terraform domain: 2 years, 48 workflows
  Total: 4 years, 100 workflows

With profiles:
  Kubernetes domain: 2 years, 52 workflows
  Kubernetes profile: Package knowledge
  Terraform domain: Install profile, adapt (2 weeks)
  Total: 2 years + 2 weeks, 52+ workflows

Savings: 95% time reduction for second domain
```

### 2. Helm Charts Pattern (Kubernetes)

**Helm principle:**
> "Package Kubernetes applications for reuse"

**For agent workflows:**
```
Helm chart:
  - Templates (reusable YAML)
  - Values (configurable parameters)
  - Install anywhere

Agent profile:
  - Agents (reusable workflows)
  - Config (configurable parameters)
  - Deploy anywhere
```

### 3. Domain-Driven Design (DDD)

**DDD principle:**
> "Capture domain knowledge in bounded contexts"

**For agent profiles:**
```
Bounded context: Kubernetes Operations
- Entities: Pods, Services, Deployments
- Operations: Create, Scale, Delete
- Patterns: StatefulSets for databases
- Language: kubectl, YAML, manifests

Profile packages this knowledge → Reusable in any Kubernetes context
```

### 4. Network Effects of Sharing

**Problem:** Private profiles stay private

**Solution:** Public profiles benefit everyone
```
Private profile:
  Your team: 10 people
  Benefit: 10×

Public profile:
  Community: 1000 people
  Benefit: 1000×
  Contributions: Community improves your profile
  Result: Compound returns
```

---

## Implementation

### Profile Structure Specification

**Standard profile format:**
```yaml
# profile.yaml
name: kubernetes-ops
version: 1.2.0
description: Kubernetes operations workflows and patterns
author: Your Team
license: MIT

dependencies:
  - cloud-infrastructure@^2.0.0
  - yaml-processing@^1.5.0

agents:
  - agents/create-deployment.md
  - agents/create-statefulset.md
  - agents/create-service.md

workflows:
  - workflows/deploy-application.md
  - workflows/scale-workload.md

patterns:
  - patterns/stateful-applications.md
  - patterns/ingress-routing.md

config:
  validation_rules: config/validation-rules.yaml
  naming_conventions: config/naming-conventions.yaml
  defaults: config/default-settings.yaml

documentation:
  getting_started: docs/getting-started.md
  best_practices: docs/best-practices.md
```

### Profile Installation

**Command-line tool:**
```bash
# Install profile
agentops profile install kubernetes-ops@1.2.0

# What it does:
# 1. Download profile from registry
# 2. Validate profile integrity
# 3. Install agents to .claude/agents/
# 4. Install workflows to .claude/workflows/
# 5. Install patterns to patterns/
# 6. Merge configurations
# 7. Generate documentation

# List installed profiles
agentops profile list

# Output:
# kubernetes-ops@1.2.0 (installed 2025-01-27)
# terraform-iac@0.9.0 (installed 2025-02-15)
# python-dev@1.0.0 (installed 2025-03-01)
```

**Installation implementation:**
```python
class ProfileInstaller:
    def install(self, profile_name, version):
        # 1. Download from registry
        profile = self.download_profile(profile_name, version)

        # 2. Validate
        if not self.validate_profile(profile):
            raise InvalidProfileError()

        # 3. Check dependencies
        for dep in profile.dependencies:
            if not self.is_installed(dep):
                self.install(dep.name, dep.version)

        # 4. Install components
        self.install_agents(profile.agents)
        self.install_workflows(profile.workflows)
        self.install_patterns(profile.patterns)

        # 5. Merge configurations
        self.merge_config(profile.config)

        # 6. Register installation
        self.register_profile(profile)

        return profile
```

### Profile Customization

**Local overrides:**
```yaml
# .agentops/profiles/kubernetes-ops.local.yaml
# Customizations for this specific deployment

config:
  # Override default namespace
  default_namespace: my-production-namespace

  # Add custom validation rules
  custom_validations:
    - require_resource_limits: true
    - enforce_pod_security: true

agents:
  # Add local agent
  custom_agents:
    - local/agents/deploy-to-my-cluster.md

workflows:
  # Disable workflow not needed here
  disabled:
    - workflows/scale-workload.md
```

### Profile Registry

**Public profile registry:**
```
https://profiles.12factor-agentops.dev/

Available profiles:
- kubernetes-ops (1.2.0) - 52 agents, 15 workflows
- terraform-iac (0.9.0) - 30 agents, 10 workflows
- python-development (1.0.0) - 25 agents, 8 workflows
- golang-services (0.8.0) - 20 agents, 7 workflows
- database-management (1.1.0) - 18 agents, 6 workflows
- ci-cd-pipelines (1.0.0) - 22 agents, 9 workflows
```

**Profile publishing:**
```bash
# Package profile for distribution
agentops profile package

# Output: kubernetes-ops-1.2.0.tar.gz

# Publish to registry
agentops profile publish kubernetes-ops-1.2.0.tar.gz

# Validates:
# - Profile structure correct
# - All files present
# - Documentation complete
# - Version not already published
# - License specified
```

---

## Validation

### ✅ You're doing this right if:
- Domains packaged as portable profiles
- Profiles installable in minutes (not days)
- Profiles versioned and released
- Community contributes to public profiles
- New domains productive immediately (not months)

### ❌ You're doing this wrong if:
- No profiles (everything ad-hoc)
- Profiles not portable (hardcoded assumptions)
- Profiles not versioned (breaking changes)
- Profiles not shared (private only)
- Each domain starts from zero

---

## Real-World Evidence

### Profile Development Timeline

**Kubernetes Operations Profile:**
```
Year 1: Develop in production
- Built 52 agents over 24 months
- Validated 15 workflows
- Extracted 12 patterns
- Investment: 2 years

Year 2: Package as profile
- Extracted common knowledge
- Created profile structure
- Published version 1.0.0
- Investment: 2 weeks
```

**Terraform IaC Profile (Second Domain):**
```
Using Kubernetes profile as template:
- Installed kubernetes-ops profile
- Adapted for Terraform domain
- Created terraform-iac profile
- Time: 2 weeks (vs. 2 years from scratch)

Productivity: 52× faster (2 weeks vs. 2 years)
```

**Python Development Profile (Third Domain):**
```
Using both previous profiles as references:
- Installed kubernetes-ops + terraform-iac
- Identified common patterns
- Created python-dev profile
- Time: 1 week

Productivity: 104× faster (1 week vs. 2 years)
```

**Learning curve:**
```
Domain 1: 2 years
Domain 2: 2 weeks (52× faster)
Domain 3: 1 week (104× faster)
Domain 4+: Estimated <1 week

Marginal cost decreases with each profile
```

### Community Impact

**Public profile sharing (hypothetical):**
```
Your profile: kubernetes-ops
Downloads: 1000
Issues reported: 25
Pull requests: 15
Improvements contributed: 8

Result:
- Your profile improves through community contributions
- Your team benefits from improvements
- Community benefits from your work
- Network effects compound
```

---

## Anti-Patterns

### ❌ The "Monolithic Profile" Trap
**Wrong:** One massive profile for everything
**Right:** Focused profiles per domain, composable

### ❌ The "Hardcoded Assumptions" Trap
**Wrong:** Profile assumes specific environment
**Right:** Configurable, works anywhere with config

### ❌ The "No Versioning" Trap
**Wrong:** Update profile, break all users
**Right:** Semantic versioning, backward compatibility

### ❌ The "Private Hoarding" Trap
**Wrong:** Keep all profiles private
**Right:** Share publicly (Law 5), benefit from network effects

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Profiles versioned in git
- **Factor III: Focused Agents**: Profiles contain single-responsibility agents
- **Factor IX: Mine Patterns**: Profiles package extracted patterns
- **Factor X: Small Iterations**: Profile updates driven by improvement backlog
- **Factor XI: Fail-Safe Checks**: Profiles include domain-specific guardrails

---

## Profile Categories

### Category 1: Domain Profiles

**Examples:**
- kubernetes-ops
- terraform-iac
- python-development
- golang-services
- database-management

**Contents:** Domain-specific agents, workflows, patterns

### Category 2: Platform Profiles

**Examples:**
- aws-cloud
- gcp-cloud
- azure-cloud
- on-premise-infrastructure

**Contents:** Platform-specific operations, integrations

### Category 3: Process Profiles

**Examples:**
- agile-scrum
- kanban-workflow
- sre-oncall
- incident-response

**Contents:** Process workflows, templates, checklists

### Category 4: Meta Profiles

**Examples:**
- agentops-core (this framework)
- documentation-standards
- quality-gates
- compliance-requirements

**Contents:** Cross-cutting concerns, standards, governance

---

## Profile Composition

**Profiles can depend on other profiles:**

```yaml
# terraform-iac profile.yaml
name: terraform-iac
version: 0.9.0

dependencies:
  - cloud-infrastructure@^2.0.0  # Base cloud operations
  - yaml-processing@^1.5.0       # YAML utilities
  - validation-gates@^1.0.0      # Quality gates

# Inherits agents from dependencies
# Adds Terraform-specific agents
# Composes into complete profile
```

**Composition enables:**
- **Reuse:** Don't rebuild common capabilities
- **Focus:** Profile only domain-specific knowledge
- **Evolution:** Update dependencies independently
- **Modularity:** Mix and match profiles

---

## Migration from Unstructured to Profiles

**Step-by-step migration:**

```markdown
# Phase 1: Inventory (Week 1)
- List all agents in .claude/agents/
- List all workflows
- List all patterns
- Categorize by domain

# Phase 2: Extract (Week 2)
- Group agents by domain
- Identify domain boundaries
- Extract common patterns
- Document domain knowledge

# Phase 3: Package (Week 3)
- Create profile structure
- Populate profile.yaml
- Organize files
- Write documentation

# Phase 4: Test (Week 4)
- Install profile in clean environment
- Verify all agents work
- Test workflows end-to-end
- Fix issues

# Phase 5: Publish (Week 5)
- Version profile (1.0.0)
- Publish to registry
- Announce to community
- Gather feedback

Total time: 5 weeks
Result: Portable, reusable domain knowledge
```

---

## Next Steps

1. **Inventory current agents** by domain
2. **Create first profile** (start with most mature domain)
3. **Package and version** profile
4. **Test installation** in clean environment
5. **Publish publicly** (GitHub, registry)
6. **Document lessons learned** for next profile

---

## Further Reading

- **Knowledge OS Pillar**: [../foundations/knowledge-os.md](../foundations/knowledge-os.md)
- **Law 1 (Extract Learnings)**: [../foundations/five-laws.md](../foundations/five-laws.md#law-1)
- **Law 5 (Share Patterns)**: [../foundations/five-laws.md](../foundations/five-laws.md#law-5)
- **Factor IX: Mine Patterns**: [./09-documented-pattern-extraction.md](./09-documented-pattern-extraction.md)
- **Helm Charts**: [https://helm.sh](https://helm.sh)
- **Domain-Driven Design**: [Wikipedia: Domain-driven design](https://en.wikipedia.org/wiki/Domain-driven_design)

---

**Remember:** Domain knowledge is valuable. Package it, version it, share it. Profiles enable instant productivity in new domains. Build once, reuse everywhere. The first profile takes years. The second takes weeks. The third takes days. Compound your knowledge investment.
