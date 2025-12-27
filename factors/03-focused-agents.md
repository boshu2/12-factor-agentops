# Factor III: Focused Agents

**Compose workflows from focused agents; avoid monolith prompts**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Learning Science |
| **Supporting Pillar** | DevOps + SRE |
| **Enforces Laws** | Law 2 (Improve System), Law 5 (Share Patterns) |
| **Derived From** | Progressive disclosure + Single Responsibility Principle + Unix philosophy |


---

## Summary

Each agent should do one thing well. Complex workflows are composed from multiple single-responsibility agents working in sequence or parallel, not from a single monolithic prompt trying to do everything. This principle applies to both AI agents and reusable skills/commands.

## Why This Factor Exists

**Pillar Grounding:**

This factor derives from the **Learning Science** pillar:

Progressive disclosure is fundamental to effective learning: present information in layers, starting simple and building complexity. Focused Agents operationalize this principle by ensuring each agent handles one clear responsibility—one level of abstraction, one type of work. When agents try to do everything (research + planning + implementation + testing), they violate progressive complexity and create cognitive overload. The learner (whether human or AI) cannot distinguish what's fundamental from what's detail.

**From cognitive load research:** Experts chunk information into meaningful units; novices get overwhelmed by undifferentiated complexity. Single-responsibility agents create these chunks: each agent is a discrete unit of capability. Compose them into workflows, and you build complexity progressively—exactly how effective learning works.

**Supporting from DevOps + SRE:**

The Unix philosophy (1978) and Single Responsibility Principle (SRP) aren't new—they're battle-tested wisdom from decades of software engineering. DevOps practices reinforce this: microservices over monoliths, single-purpose containers, independently deployable services. Each service does one thing, does it well, and composes with others. Focused Agents apply the same proven architecture to AI operations. The result: maintainable, testable, reusable capabilities instead of monolithic, brittle, one-off solutions.

---

## The Problem

Monolithic prompts that try to do everything:
- Become unmaintainable quickly
- Fail unpredictably
- Can't be reused across contexts
- Violate context budgets (Factor II: Context Loading)
- Have unclear failure modes

**Familiar pattern:**
```
Super-Agent 3000:
├─ Research the problem
├─ Design the solution
├─ Write the code
├─ Test the code
├─ Review the code
├─ Document the code
├─ Deploy the code
└─ Monitor the deployment

Result: 8000-token prompt, 70% context usage, unpredictable failures
```

**Traditional approach:** "One prompt to rule them all"

**12-Factor AgentOps approach:** Compose specialized agents, each with clear responsibility

---

## The Principle

### Unix Philosophy for AI Agents

The Unix philosophy (1978) still applies:
1. **Do one thing well**: Each agent has a single, clear purpose
2. **Work together**: Agents compose into workflows
3. **Handle text streams**: Use standard interfaces (markdown, JSON)

**Translation for AI:**
```
research-agent:      Focuses only on information gathering
plan-agent:          Focuses only on solution design
implement-agent:     Focuses only on code writing
validation-agent:    Focuses only on quality checks
```

### Single Responsibility Principle (SRP)

From software engineering (Robert C. Martin):
> "A class should have only one reason to change"

**For AI agents:**
> "An agent should have only one reason to execute"

**Examples:**
- ✅ `generate-kubernetes-manifest`: One responsibility (manifest generation)
- ❌ `do-everything-kubernetes`: Multiple responsibilities (generate + validate + deploy + monitor)

### Composition Over Complexity

**Wrong:**
```markdown
# Mega Prompt (8000 tokens)
You are an expert system that will:
1. Research Kubernetes best practices
2. Design a StatefulSet
3. Generate YAML
4. Validate the YAML
5. Create tests
6. Deploy to cluster
7. Monitor the deployment
[...8000 more tokens...]
```

**Right:**
```markdown
# Workflow composition
research → plan → implement → validate → deploy → monitor

Each step uses a focused agent:
- research-k8s-patterns (500 tokens)
- plan-statefulset (600 tokens)
- generate-manifest (400 tokens)
- validate-yaml (300 tokens)
- create-tests (500 tokens)
- deploy-to-cluster (400 tokens)
- monitor-deployment (300 tokens)

Total: Same work, 7× clarity, composable, reusable
```

---

## Why This Works

### 1. Maintainability

**Monolithic agent:**
- Changes ripple unpredictably
- Hard to test individual pieces
- Debugging is guess-and-check

**Single-responsibility agents:**
- Changes are isolated
- Each agent is testable
- Debugging is straightforward

### 2. Reusability

**Monolithic agent:**
- Tied to specific use case
- Can't reuse parts
- Duplication across workflows

**Single-responsibility agents:**
- Reuse across many workflows
- Mix and match for new use cases
- Build libraries of capabilities

**Example:**
```
validate-yaml:
  Used in: manifest-generation, config-updates, ci-pipelines,
           deployment-workflows, template-rendering
  Reuse count: 47 workflows
```

### 3. Context Efficiency (Factor II: Context Loading)

**Monolithic agent:**
- Loads all knowledge for all tasks
- Exceeds 40% context limit
- Triggers degradation

**Single-responsibility agents:**
```
research-agent:  20% context (only research materials)
plan-agent:      25% context (only planning templates)
implement-agent: 30% context (only relevant code)

Each stays under 40% → optimal performance
```

### 4. Clear Failure Modes

**Monolithic agent fails:**
- Where did it fail? Research? Planning? Implementation?
- Why did it fail? Too many concurrent responsibilities
- How to fix? Unclear—debug the whole thing

**Single-responsibility agent fails:**
- Where: Exactly which agent failed
- Why: Clear responsibility boundary
- How to fix: Isolated change

---

## Implementation

### Define Agent Boundaries

**Ask: What is the ONE thing this agent does?**

✅ Good boundaries:
- `research-best-practices`: Gathers information from docs
- `generate-tests`: Creates test cases from specifications
- `validate-yaml`: Checks YAML syntax and schema

❌ Poor boundaries:
- `do-kubernetes-stuff`: What stuff? Too vague
- `research-and-implement`: Two responsibilities
- `everything-for-statefulsets`: Not focused

### Agent Composition Pattern

```yaml
workflow: create-kubernetes-application
  phases:
    - research:
        agent: research-k8s-patterns
        output: research-bundle.md

    - plan:
        agent: plan-statefulset
        inputs: [research-bundle.md]
        output: design-spec.md

    - implement:
        agents:
          - generate-manifest
          - create-tests
        inputs: [design-spec.md]
        outputs: [manifest.yaml, tests/]
        execution: parallel

    - validate:
        agents:
          - validate-yaml
          - run-tests
        inputs: [manifest.yaml, tests/]
        execution: sequential
```

### Skill Libraries

Reusable capabilities that agents can use:

```
skills/
├── file-operations.md       # Read, write, edit files
├── yaml-processing.md       # Parse, validate, transform YAML
├── git-operations.md        # Commit, push, branch management
├── testing.md               # Generate and run tests
└── documentation.md         # Generate docs from code
```

**Agents compose skills:**
```markdown
# manifest-generator agent

Responsibilities:
- Generate Kubernetes manifests

Skills used:
- yaml-processing (to structure output)
- file-operations (to write manifests)
- git-operations (to commit results)

Does NOT handle:
- Research (use research-agent)
- Validation (use validate-agent)
- Deployment (use deploy-agent)
```

### Interface Contracts

Agents communicate through standard formats:

**Input contract:**
```yaml
agent: plan-statefulset
  inputs:
    required:
      - research-findings: markdown file
      - requirements: yaml spec
    optional:
      - constraints: list of limitations
```

**Output contract:**
```yaml
agent: plan-statefulset
  outputs:
    - design-spec.md: detailed design
    - architecture.diagram: mermaid diagram
    - validation-criteria.md: success criteria
```

**Standard formats:**
- Markdown for documentation
- YAML for structured config
- JSON for data interchange
- Mermaid for diagrams

---

## Validation

### ✅ You're doing this right if:
- Each agent has a clear, single responsibility
- Agents compose into larger workflows
- You can explain agent purpose in one sentence
- Agents are reused across multiple workflows
- Failures isolate to specific agents

### ❌ You're doing this wrong if:
- Agents do "everything"
- Can't reuse agents across contexts
- Failures are mysterious and hard to debug
- Agent prompts exceed 2000 tokens
- Changing one thing breaks everything

---

## Real-World Evidence

### Refactoring a Monolith

**Before (monolithic agent):**
```
Task: Create Kubernetes application
Agent: super-k8s-agent (8000 token prompt)
Success rate: 40%
Time: 2 hours per attempt
Reuse: 0 times (too specific)
Context usage: 75%
```

**After (composed agents):**
```
Task: Create Kubernetes application
Agents: research → plan → generate → validate → deploy
Individual prompts: 300-600 tokens each
Success rate: 95%
Time: 20 minutes per attempt
Reuse: Each agent used in 10-47 other workflows
Context usage: 20-30% per agent
```

**Improvement:** 6x faster, 2.4x more reliable, infinitely more reusable

### The 52-Agent Validation

**Production system:** 52 specialized agents
**Composition:** Workflows use 2-7 agents each
**Reuse factor:** Average agent used in 8.3 workflows
**Maintenance:** Bug fixes affect only 1 agent, not entire system

**Specific examples:**
- `validate-yaml`: Used in 47 workflows
- `generate-tests`: Used in 23 workflows
- `commit-with-context`: Used in 52 workflows (all of them)

**Result:** Library of capabilities that compounds over time

---

## What This Factor Enforces

This factor is the operational expression of:

**Law 2: Improve System**

Focused Agents enforce Law 2 by making **modularity the improvement mechanism**. When each agent does one thing well, improvements are isolated and safe. You can improve the validation agent without risking the implementation agent. This architectural separation is the system improvement—it enables continuous refinement without cascading failures.

**Enforcement mechanisms:**
1. **One responsibility per agent:** Agent definitions must answer "What is the ONE thing this agent does?" If the answer contains "and," split it (design-time enforcement)
2. **Reuse metrics tracked:** Agents used in fewer than 3 workflows are candidates for deprecation or merger (utilization-based enforcement)
3. **Composition over complexity:** Workflows must compose agents (research → plan → implement), never embed all logic in one monolithic agent (architectural enforcement)

**Example:**
```markdown
# ❌ WRONG: God Agent (violates Law 2)
research-plan-implement-test-deploy-monitor-agent.md
- Responsibility: Everything
- Reuse: Impossible (too specific)
- Improvement: Risky (change breaks everything)

# ✅ RIGHT: Focused Agents (enforces Law 2)
research-agent.md        → Reused in 47 workflows
plan-agent.md            → Reused in 45 workflows
implement-agent.md       → Reused in 43 workflows
validation-agent.md      → Reused in 52 workflows (all)

Result: Each improved independently, composes into any workflow
```

**Law 5: Share Patterns**

Focused Agents enforce Law 5 by making **agents themselves the shareable patterns**. A monolithic "do everything" agent can't be shared—it's too specific to its context. But a focused "validate YAML syntax" agent? That's universally useful. Single responsibility enables pattern sharing because focused agents solve focused problems that recur across domains.

**Enforcement mechanisms:**
1. **Public agent library required:** All single-responsibility agents published to shared library (organizational enforcement)
2. **Cross-domain reuse tracked:** Agents must demonstrate applicability beyond original domain (generalization enforcement)
3. **Pattern extraction from agents:** When an agent is reused 5+ times, extract the pattern to documentation (Law 5 compliance enforcement)

**Example:**
```markdown
# validate-yaml agent (single responsibility)
- Used in: kubernetes-ops, terraform-iac, ci-cd-pipelines, config-management
- Domains: 4 different contexts
- Pattern: "Validation agents should use schema-based checking"
- Shared: Published publicly, reused by 1000+ users

# super-k8s-agent (monolithic)
- Used in: kubernetes-ops only
- Domains: 1 specific context
- Pattern: None (too specific)
- Shared: Can't share (too tightly coupled)

Result: Single-responsibility enables sharing; monoliths don't
```

**Why this enforcement matters:**

Without single-responsibility: Monolithic agents (8000 tokens), 40% success rate, 0 reuse
With single-responsibility: Focused agents (300-800 tokens), 95% success rate, 8.3× average reuse

Single responsibility is how you turn one-time solutions into compounding assets.

---

## Anti-Patterns

### ❌ The God Agent
**Wrong:** Single agent that handles all tasks
```markdown
# Super Agent (12,000 tokens)
You are an expert in:
- Research
- Design
- Implementation
- Testing
- Deployment
- Monitoring
[...everything...]
```
**Right:** Specialized agents for each responsibility

### ❌ Overlapping Responsibilities
**Wrong:**
- `research-and-plan`: Two responsibilities
- `implement-and-test`: Two responsibilities

**Right:**
- `research`: One responsibility
- `plan`: One responsibility
- `implement`: One responsibility
- `test`: One responsibility

### ❌ Hyper-Specialization
**Wrong:** Agent per line of code
```
- generate-yaml-line-1
- generate-yaml-line-2
- generate-yaml-line-3
```
**Right:** Agent per cohesive task
```
- generate-kubernetes-manifest
```

**Balance:** Specialized enough to be clear, general enough to be useful

### ❌ No Composition Strategy
**Wrong:** 52 agents, no workflows that use them
**Right:** Agents designed to compose into workflows

---

## Relationship to Other Factors

- **Factor II: Context Loading**: Smaller agents delegate to sub-agents, keeping main context clean
- **Factor IV: Continuous Validation**: Validation agents check output of implementation agents
- **Factor VIII: Smart Routing**: Router selects best-fit single-responsibility agent
- **Factor XII: Package Patterns**: Agents packaged into reusable profiles

---

## The Microservices Parallel

If you've built microservices, you already understand this:

| Microservices | Focused Agents |
|---------------|------------------------------|
| Service per business capability | Agent per workflow responsibility |
| API contracts | Input/output contracts |
| Service composition | Agent composition |
| Independent deployment | Independent execution |
| Service libraries | Agent/skill libraries |

**Same principle, different domain.**

---

## Implementation Patterns

From production deployments (Houston, Fractal, ai-platform), we've identified concrete patterns for implementing focused agents in multi-agent systems.

### Pattern 1: Event-Driven Activation

**Principle:** Agents respond to events, not schedules.

Events create context; timers create noise. An event (GitLab push, Jira ticket created, Slack message) carries the **why** an agent should activate. A cron schedule just says "run now" without context.

**Trigger Taxonomy:**

| Trigger Type | When to Use | Example |
|--------------|-------------|---------|
| **Webhook** | External system events | GitLab push → commitReviewer<br/>Jira ticket → issueTriager<br/>Slack mention → helpAssistant |
| **API Call** | CI/CD jobs, automation scripts | Pipeline complete → verificationAnalyst<br/>Deployment success → notificationAgent |
| **Chat** | User-initiated requests | "Explain this code" → codeExplainer<br/>"Search docs" → knowledgeAssistant |
| **Cron** | Periodic aggregation only (last resort) | Daily summary → statusReporter<br/>Weekly metrics → metricsAggregator |

**Why webhooks > cron:**
```
Cron-based (wrong):
- Every 5 minutes: "Check if there's work"
- 99% wasted invocations
- No context about what changed
- Race conditions with concurrent jobs

Event-based (right):
- GitLab push → immediate review
- 100% useful invocations
- Event payload contains full context
- Naturally serialized per event
```

**Production validation:** ai-platform runs 8 specialized agents, all event-driven except 2 reporting agents (cron for daily/weekly summaries).

---

### Pattern 2: Webhook-First, Orchestrator-Last

**Principle:** Let events flow directly to agents. Orchestrators are for chat only.

**Wrong mental model:**
```
Every event → Orchestrator → Dispatch to agent → Return to orchestrator → Response

Problem: Orchestrator becomes a bottleneck and single point of failure
```

**Right mental model:**
```
GitLab Push ────────► commitReviewer (direct webhook)
GitLab MR Created ──► mrReviewer (direct webhook)
Pipeline Complete ──► verificationAnalyst (direct webhook)
Jira Ticket ────────► issueTriager (direct webhook)

User Chat (multi-agent query) → Orchestrator → Agents → Synthesize
```

**Orchestrators exist for ONE purpose:** When a user asks something in chat that requires multiple specialized agents to answer.

**Example:**
```yaml
# Direct webhook (preferred)
apiVersion: kagent.dev/v1alpha2
kind: Agent
metadata:
  name: commit-reviewer
spec:
  description: "Reviews code quality on every commit"
  integrations:
    gitlab:
      enabled: true
      events: ["push"]
      webhook: true  # Direct delivery

# Orchestrator-dispatched (only for multi-agent chat)
apiVersion: kagent.dev/v1alpha2
kind: Agent
metadata:
  name: code-qa-orchestrator
spec:
  description: "Coordinates code quality analysis"
  integrations:
    slack:
      enabled: true
      events: ["mention"]
  delegates:
    - commit-reviewer
    - test-coverage-analyzer
    - security-scanner
```

**Why this matters:**
- **Latency:** Webhook → Agent (100ms) vs Webhook → Orchestrator → Agent (500ms+)
- **Reliability:** Direct path = fewer failure points
- **Clarity:** Event source visible in agent config

**Production validation:** ai-platform has 6 webhook-triggered agents (direct), 1 orchestrator (chat-only), 1 cron agent (reporting).

---

### Pattern 3: Agent Decision Tree

**Use this decision tree when designing a new agent:**

```
START: What triggers this agent?
│
├─► External event (webhook)?
│   └─► Create specialized agent with webhook trigger
│       Example: commitReviewer (gitlab-push)
│       Pattern: Single responsibility, event payload as context
│
├─► CI/CD job completion?
│   └─► Create specialized agent with API trigger
│       Example: verificationAnalyst (pipeline-complete)
│       Pattern: Reads job artifacts, writes summary
│
├─► User chat request?
│   │
│   ├─► Single focused task?
│   │   └─► Create specialized agent with chat trigger
│   │       Example: knowledgeAssistant (search docs)
│   │       Pattern: Query → Search → Response
│   │
│   └─► Requires multiple agents?
│       └─► Use orchestrator to dispatch
│           Example: "Review MR thoroughly" → Orchestrator dispatches:
│                    - mrReviewer (code quality)
│                    - verificationAnalyst (build/test status)
│                    - securityScanner (vulnerability check)
│           Pattern: Orchestrator aggregates results
│
└─► Periodic aggregation?
    └─► Create agent with cron trigger (use sparingly)
        Example: statusReporter (weekly summaries)
        Pattern: Queries historical data, generates report
```

**Key insight:** Most agents are webhook-triggered. Orchestrators are rare (only for multi-agent chat queries).

---

### Pattern 4: KAgent CRD Definition (Kubernetes-Native)

For production Kubernetes deployments, agents are defined as Custom Resource Definitions (CRDs).

**Example: Webhook-triggered agent**
```yaml
apiVersion: kagent.dev/v1alpha2
kind: Agent
metadata:
  name: merge-request-reviewer
  namespace: team-platform
spec:
  description: "Reviews merge request code changes for quality and standards"

  # Single responsibility
  declarative:
    modelConfig: devstral  # Shared model routing
    systemPrompt: |
      You are a code reviewer for the platform team.
      Focus on:
      - Code quality and standards adherence
      - Potential bugs or edge cases
      - Documentation completeness

      Do NOT review:
      - Security (handled by security-scanner agent)
      - Test coverage (handled by test-analyzer agent)
      - Build correctness (handled by verification-analyst agent)

    tools:
      - type: McpServer
        mcpServer: gitlab-mcp  # Shared MCP tools
        toolNames:
          - gitlab_get_mr_diff
          - gitlab_post_mr_comment
      - type: McpServer
        mcpServer: code-graph-mcp
        toolNames:
          - query_code_graph

  # Event-driven activation
  integrations:
    gitlab:
      enabled: true
      events: ["merge_request.opened", "merge_request.updated"]
      webhook: true
      filters:
        targetBranches: ["main", "develop"]
```

**Key elements:**
- **Single responsibility:** Clearly stated in description and systemPrompt
- **Event-driven:** GitLab webhook triggers, not cron
- **Scoped tools:** Only the MCP tools needed for code review
- **Shared infrastructure:** modelConfig and mcpServer are cluster-wide

**Anti-pattern (avoid):**
```yaml
# ❌ WRONG: God agent
metadata:
  name: do-everything-gitlab
spec:
  description: "Handles all GitLab events and does everything"
  systemPrompt: "You are an expert at everything..."
  integrations:
    gitlab:
      events: ["*"]  # All events - too broad
```

---

### Pattern 5: The Anti-Patterns (Production Failures)

From real deployments, these patterns cause failures:

#### ❌ The God Agent
```
BAD: One agent that does everything
- Reviews code
- Analyzes builds
- Writes docs
- Answers questions
- Generates reports
- Monitors deployments

Result: 12,000-token prompt, 75% context usage, unpredictable failures
```

**Fix:** Split into specialized agents:
```
GOOD: Specialized agents that compose
- mrReviewer: Code quality only
- verificationAnalyst: Build/test analysis only
- docWriter: Documentation generation only
- knowledgeAssistant: Q&A only
- statusReporter: Reporting only

Result: 300-800 token prompts, 20-30% context usage each, 95% success rate
```

#### ❌ The Orchestrator-First Design
```
BAD: Everything goes through an orchestrator
GitLab Push → Orchestrator → commitReviewer → Orchestrator → Response
Jira Ticket → Orchestrator → issueTriager → Orchestrator → Response

Result: Orchestrator bottleneck, 500ms+ latency, single point of failure
```

**Fix:** Direct webhook delivery
```
GOOD: Events flow directly to agents
GitLab Push ────────► commitReviewer (direct, 100ms)
Jira Ticket ────────► issueTriager (direct, 100ms)

Orchestrator only for: User chat queries requiring multiple agents
```

#### ❌ The Stateful Agent
```
BAD: Agent maintains conversation state internally
"Remember what we discussed earlier..."

Result: State loss on pod restart, memory leaks, race conditions
```

**Fix:** Stateless execution with external memory
```
GOOD: Agent is stateless, memory is external
Agent invocation: Input (Event + Context) → Output (Response + Actions)
Memory: PostgreSQL (time-series), Neo4j (graph), pgvector (semantic)

Result: Restartable, scalable, debuggable
```

---

## Levels of Composition

### Level 1: Skills
Reusable capabilities (100-300 tokens)
```
- read-file
- write-file
- validate-yaml
```

### Level 2: Agents
Focused responsibilities (300-800 tokens)
```
- research-best-practices (uses: read-file)
- generate-manifest (uses: write-file, validate-yaml)
```

### Level 3: Workflows
Composed sequences (2-7 agents)
```
workflow: create-application
  └─ research → plan → implement → validate → deploy
```

### Level 4: Profiles
Domain-specific packages (10-50 workflows)
```
profile: kubernetes-ops
  ├─ 23 agents
  ├─ 15 skills
  └─ 12 workflows
```

**Build from bottom up, use from top down.**

---

## Next Steps

1. **Audit existing agents**: Are they single-responsibility?
2. **Identify duplication**: Where are you repeating similar prompts?
3. **Extract skills**: What capabilities are reused?
4. **Define contracts**: What are inputs/outputs?
5. **Test composition**: Do agents work together?

---

## Further Reading

- **Pattern: Multi-Agent Orchestration**: [../patterns/multi-agent-orchestration.md](../patterns/multi-agent-orchestration.md)
- **Pattern: Intelligent Routing**: [../patterns/intelligent-routing.md](../patterns/intelligent-routing.md)
- **Learning Science Pillar**: [../docs/principles/four-pillars.md#pillar-2-learning-science](../docs/principles/four-pillars.md#pillar-2-learning-science)

---

**Remember:** Complexity through composition, not through monoliths. Each agent should do one thing well, and together they accomplish everything.
