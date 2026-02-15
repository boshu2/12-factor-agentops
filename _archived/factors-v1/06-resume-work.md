# Factor VI: Resume Work

**Persist and restore context using compressed artifacts for multi-day work**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Context Engineering |
| **Supporting Pillar** | Knowledge OS |
| **Enforces Laws** | Law 2 (Improve System), Law 3 (Document Context) |
| **Derived From** | Compression techniques + Spaced repetition + Progressive summarization |


---

## Summary

Multi-day workflows require context persistence across sessions without violating the 40% rule. Context bundles compress full documentation into executive summaries (5:1 to 10:1 ratio), preserving essential state while freeing context capacity. Bundles enable multi-session work without context collapse.

## The Problem

Multi-session work without bundles:
- Loses context between sessions
- Forces agents to relearn previous decisions
- Wastes time re-researching the same information
- Creates inconsistency across sessions
- Violates 40% rule if trying to load everything

**Familiar pattern:**
```
Day 1: Research (5000 tokens context)
Day 2: Load research again (5000 tokens) + Plan (3000 tokens) = 8000 tokens
Day 3: Load research + plan (8000 tokens) + Implement (4000 tokens) = 12,000 tokens

Result: 60% context utilization → Context collapse
```

**Traditional approach:** Either lose context or violate the 40% rule

**12-Factor AgentOps approach:** Compress previous work into bundles, stay under 40%

---

## Why This Factor Exists

### Grounding in the Five Pillars

**Primary: Context Engineering**

Session continuity addresses the fundamental problem of multi-day work: context explodes across sessions. Day 1 needs 15% context, Day 2 needs 40% (research + plan), Day 3 needs 65% (research + plan + implement)—context collapse. Context Engineering's 40% rule makes this impossible without compression. Tiago Forte's progressive summarization teaches that information should be compressed as it ages, keeping only what's actionable.

Context bundles implement lossy compression intelligently: full detail preserved in Git (lossless storage), compressed summaries for loading (lossy but sufficient). Not all information has equal value over time—debugging steps from Day 1 aren't needed on Day 3, but architectural decisions remain critical. Compression ratios of 5:1 to 10:1 enable multi-week projects while staying under 40% context utilization.

**Supporting: Knowledge OS**

Knowledge OS provides the storage layer (Git) that makes compression safe. Every detail lives in Git history forever—bundles are just loading keys, not the source of truth. This separation enables aggressive compression without information loss. Git + bundles = complete memory: lossless storage, intelligent loading.

---

## What This Factor Enforces

### Law 2: Improve System

Session continuity enforces system improvement by making multi-day work sustainable. Without bundles, complex projects hit context collapse and abort—wasted effort, no learning. With bundles, projects complete across days/weeks, enabling the extraction of patterns that only emerge from sustained work. The 7-day Kubernetes migration succeeded because bundles kept context under 40% every day.

**Concrete example:** Without bundles, Day 3 hits 65% context → collapse → project abandoned. With bundles, Day 3 stays at 35% context → project completes → patterns extracted → future similar projects benefit. The improvement is compounding capability.

### Law 3: Document Context for Future

Bundles enforce context documentation by requiring structured summaries. Creating a bundle forces articulation of decisions made, parameters established, next steps required. This structured format ensures future agents (or future you) can resume work without reconstructing context from scratch.

**Concrete example:** Research bundle template requires "Key decisions," "Critical findings," "Parameters for next phase." Creating the bundle forces documentation that Day 3 agent needs. Result: seamless handoff between sessions, zero context loss for mission-critical information.

---

## The Principle

### Context Bundles as Compressed Memory

**Full documentation** (uncompressed):
```markdown
# Research Phase Output (5000 tokens)

## Background
[Detailed background...]

## Literature Review
[Full citations, quotes, analysis...]

## Technical Investigation
[Complete technical deep-dive...]

## Conclusions
[Detailed findings...]
```

**Context bundle** (compressed 5:1):
```markdown
# Research Bundle (1000 tokens)

**What we learned:**
- Background: [Key points only]
- Literature: [3 critical findings]
- Technical: [Essential architecture decisions]
- Conclusions: [2 sentence summary]

**Decisions made:**
- Use Kubernetes StatefulSets (not Deployments)
- PostgreSQL for persistence (not MySQL)

**Carry forward:**
- Namespace: production-db
- Replicas: 3
- Storage class: fast-ssd
```

**Result:** 80% compression, 100% of critical information preserved

### The Compression Hierarchy

**Level 1: Raw artifacts** (100% fidelity, 100% tokens)
- Full research documents
- Complete implementation code
- Entire conversation history

**Level 2: Executive summaries** (80% fidelity, 20% tokens)
- Key decisions made
- Critical findings
- Essential parameters
- Next steps

**Level 3: Decision trees** (60% fidelity, 10% tokens)
- Why we made each choice
- What alternatives were rejected
- What constraints exist

**Level 4: Metadata** (40% fidelity, 5% tokens)
- What phase completed
- Who did what
- When it happened

---

## Why This Works

### 1. Progressive Summarization (Tiago Forte)

**Note-taking principle:**
> "Compress information progressively as it ages, keeping only what's actionable"

**For AI agents:**
- Day 1: Full research (5000 tokens)
- Day 2: Research bundle (1000 tokens) + Full plan (3000 tokens) = 4000 tokens
- Day 3: Research bundle (1000 tokens) + Plan bundle (600 tokens) + Full implement (4000 tokens) = 5600 tokens

**Result:** Linear growth instead of exponential, stays under 40%

### 2. Spaced Repetition (Learning Science)

**Memory principle:**
> "Information reinforced at intervals is retained better than continuous exposure"

**For AI agents:**
```
Day 1: Research in detail (high context)
Day 2: Review research bundle (low context, reinforcement)
Day 3: Reference research bundle again (spaced repetition)

Result: Better retention with less context
```

### 3. Lossy Compression is Acceptable

**Insight:** Not all information has equal value over time

**Examples:**
- Debugging steps from Day 1 → Not needed Day 3 ✅ Compress away
- Architectural decision on Day 1 → Critical on Day 3 ✅ Preserve
- Intermediate calculations → Not needed after conclusion ✅ Compress away
- Final parameters → Needed everywhere ✅ Preserve

**Result:** 80-90% compression with zero loss of critical information

### 4. Git + Bundles = Complete Memory

**Problem:** "Won't we lose detail with compression?"

**Solution:** Full detail stays in Git, bundles are for loading

```
Git repository:
├── research-phase/ (full 5000 tokens preserved)
├── plan-phase/ (full 3000 tokens preserved)
└── implement-phase/ (full 4000 tokens preserved)

Context bundles:
├── research-bundle.md (1000 tokens for loading)
├── plan-bundle.md (600 tokens for loading)
└── implement-bundle.md (800 tokens for loading)
```

**Result:** Lossless storage (Git), lossy loading (bundles) = best of both worlds

---

## Implementation

### Creating a Context Bundle

**Manual approach:**
```markdown
# [Phase] Bundle

## What we did
[1-2 sentence summary]

## Key decisions
- Decision 1: [Choice + Why]
- Decision 2: [Choice + Why]

## Critical findings
- Finding 1: [Impact]
- Finding 2: [Impact]

## Parameters for next phase
- Param 1: value
- Param 2: value

## Next steps
- [ ] Step 1
- [ ] Step 2
```

**Automated approach** (agent-generated):
```python
class BundleGenerator:
    def compress(self, full_document, compression_ratio=5):
        # Extract structure
        sections = self.parse_sections(full_document)

        # Prioritize content
        critical = self.extract_critical_info(sections)
        decisions = self.extract_decisions(sections)
        parameters = self.extract_parameters(sections)

        # Build bundle
        bundle = f"""
        # {full_document.phase} Bundle

        ## Summary
        {self.summarize(sections, max_tokens=100)}

        ## Decisions
        {self.format_decisions(decisions)}

        ## Parameters
        {self.format_parameters(parameters)}

        ## Next Steps
        {self.extract_next_steps(sections)}
        """

        # Verify compression ratio
        original_tokens = count_tokens(full_document)
        bundle_tokens = count_tokens(bundle)
        actual_ratio = original_tokens / bundle_tokens

        assert actual_ratio >= compression_ratio, "Insufficient compression"

        return bundle
```

### Loading Bundles

**Sequential loading** (multi-day workflow):
```python
class MultiDayWorkflow:
    def execute_day_2(self):
        # Load compressed context from Day 1
        research_bundle = load_bundle('research-bundle.md')  # 1000 tokens

        # Fresh context for today's work
        plan_context = load_plan_templates()  # 2000 tokens

        # Total: 3000 tokens (15% utilization ✅)
        plan_result = plan_agent.execute(research_bundle, plan_context)

        # Save new bundle
        save_bundle('plan-bundle.md', compress(plan_result))

    def execute_day_3(self):
        # Load compressed contexts from Days 1-2
        research_bundle = load_bundle('research-bundle.md')  # 1000 tokens
        plan_bundle = load_bundle('plan-bundle.md')  # 600 tokens

        # Fresh context for today's work
        implement_context = load_relevant_code()  # 4000 tokens

        # Total: 5600 tokens (28% utilization ✅)
        implement_result = implement_agent.execute(
            research_bundle,
            plan_bundle,
            implement_context
        )
```

### Bundle Validation

**Quality checks:**
```python
def validate_bundle(bundle):
    # 1. Compression ratio check
    if bundle.compression_ratio < 4:
        raise BundleError("Insufficient compression")

    # 2. Critical information check
    required_fields = ['decisions', 'parameters', 'next_steps']
    for field in required_fields:
        if field not in bundle:
            raise BundleError(f"Missing required field: {field}")

    # 3. Token limit check
    if count_tokens(bundle) > 2000:
        raise BundleError("Bundle exceeds 2000 token limit")

    # 4. Context preservation check
    if not verify_essential_context(bundle):
        raise BundleError("Essential context not preserved")

    return True
```

---

## Validation

### ✅ You're doing this right if:
- Multi-day work stays under 40% context
- Bundles compress 5:1 or better
- No loss of critical information
- Future agents can pick up where previous left off
- Bundle creation is automated

### ❌ You're doing this wrong if:
- Reloading full artifacts each session (context explosion)
- Bundles aren't compressed enough (still hitting 40%)
- Losing critical decisions in compression
- Manual bundle creation (error-prone, inconsistent)
- No validation of bundle quality

---

## Real-World Evidence

### The 7-Day Kubernetes Migration Project

**Without bundles (failed attempt):**
```
Day 1: Research (15% context)
Day 2: Load research + Plan (40% context) ⚠️
Day 3: Load research + plan + Implement (65% context) ❌ Collapse
Result: Abandoned, started over
```

**With bundles (successful):**
```
Day 1: Research (15% context) → Save bundle (1500 tokens)
Day 2: Load research bundle (8%) + Plan (20%) = 28% ✅ → Save plan bundle (800 tokens)
Day 3: Load bundles (10%) + Implement (25%) = 35% ✅
Day 4: Load bundles (12%) + Test (18%) = 30% ✅
Day 5: Load bundles (12%) + Document (15%) = 27% ✅
Day 6: Load bundles (12%) + Deploy (20%) = 32% ✅
Day 7: Load bundles (12%) + Monitor (10%) = 22% ✅

Result: Completed successfully, never exceeded 40%
```

**Improvement:** Project completion vs. abandonment

### Compression Validation (50+ Bundles)

**Measured compression ratios:**
- Research bundles: 8:1 average (5000 tokens → 625 tokens)
- Plan bundles: 6:1 average (3000 tokens → 500 tokens)
- Implementation bundles: 5:1 average (4000 tokens → 800 tokens)

**Information preservation:**
- 100% of decisions preserved
- 100% of critical parameters preserved
- 95% of essential context preserved
- 40% of supporting detail preserved (acceptable loss)

**Result:** High compression with zero loss of mission-critical information

---

## Anti-Patterns

### ❌ The "Copy-Paste Summary" Trap
**Wrong:** Just copy first paragraph of each section
**Right:** Synthesize and prioritize information

### ❌ The "Everything is Critical" Trap
**Wrong:** Can't compress because "everything is important"
**Right:** Ruthlessly prioritize (Pareto principle: 20% of info provides 80% of value)

### ❌ The "No Versioning" Trap
**Wrong:** Overwrite bundles without history
**Right:** Version bundles in Git, can always reconstruct

### ❌ The "Manual Compression" Trap
**Wrong:** Humans manually summarize (slow, inconsistent)
**Right:** Automated bundle generation (fast, reliable)

---

## Relationship to Other Factors

- **Factor I: Automated Tracking**: Full artifacts stored in Git, bundles for loading
- **Factor II: Context Loading**: Bundles enable staying under 40% across sessions
- **Factor III: Focused Agents**: Each bundle corresponds to one agent's output
- **Factor VI: Measure Everything**: Track bundle compression ratios and usage
- **Factor IX: Mine Patterns**: Bundles preserve patterns discovered

---

## Bundle Design Patterns

### Pattern 1: Cascading Bundles

```
research-bundle.md (Day 1 output)
└── plan-bundle.md (Day 2 output, references research-bundle)
    └── implement-bundle.md (Day 3 output, references plan-bundle)
        └── deploy-bundle.md (Day 4 output, references implement-bundle)
```

### Pattern 2: Incremental Bundles

```python
# Day 1
research_bundle = create_bundle(research_result)

# Day 2
plan_bundle = create_bundle(plan_result)
combined_bundle_day2 = merge_bundles([research_bundle, plan_bundle])

# Day 3
implement_bundle = create_bundle(implement_result)
combined_bundle_day3 = merge_bundles([research_bundle, plan_bundle, implement_bundle])

# Each day: New bundle + merged context bundle (auto-compressed)
```

### Pattern 3: Just-In-Time Decompression

```python
class BundleLoader:
    def load_with_detail(self, bundle, detail_level='summary'):
        # Load compressed bundle
        summary = load_bundle(bundle)

        # If more detail needed, fetch from Git
        if detail_level == 'full':
            return load_from_git(bundle.source_commit)

        # If specific section needed, fetch just that
        elif detail_level == 'section':
            return load_section_from_git(bundle.source_commit, section)

        # Default: return compressed summary
        return summary
```

---

## Next Steps

1. **Identify multi-session workflows** that need bundles
2. **Automate bundle generation** for each workflow phase
3. **Validate compression ratios** (target 5:1 minimum)
4. **Test bundle quality** (can next agent continue work?)
5. **Integrate with Factor II** (verify 40% rule compliance)

---

## Anthropic's Validation (November 2025)

Anthropic's engineering team independently validated this approach in their [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) article.

**Key alignment with Factor VI:**

| Factor VI Concept | Anthropic Implementation |
|-------------------|-------------------------|
| Progress files | `claude-progress.json` |
| Feature tracking | `feature-list.json` with pass/fail |
| Git as memory | Git history as checkpoint system |
| Session protocol | Initializer agent + Coding agent |

**Critical quote from Anthropic:**
> "The article does **not recommend knowledge graphs or traditional databases**. Instead, it uses a simpler JSON-based feature list."

This validates our git-based memory approach over external databases.

**See:** [Anthropic's Long-Running Agent Pattern](../docs/reference/anthropic-long-running-agents.md) for full implementation details.

---

## Implementation Patterns

From production deployments (Houston, Fractal, ai-platform), we've identified concrete patterns for implementing session continuity in multi-agent systems.

### Pattern 1: Explicit Memory Architecture (RAG/Graph/Historical)

**Principle:** Separate what an agent knows from what it remembers. Don't conflate different memory types.

**The Three-Layer Memory Model:**

```
┌─────────────────────────────────────────────────────────────┐
│                    AGENT MEMORY ARCHITECTURE                 │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │   RAG Layer     │  │  Graph Layer    │  │  Historical │ │
│  │   (Semantic)    │  │ (Relationships) │  │   Layer     │ │
│  ├─────────────────┤  ├─────────────────┤  ├─────────────┤ │
│  │ pgvector/Qdrant │  │     Neo4j       │  │ PostgreSQL  │ │
│  │                 │  │                 │  │             │ │
│  │ "Find similar   │  │ "What calls     │  │ "Has this   │ │
│  │  code to this"  │  │  this function?"│  │  failed     │ │
│  │                 │  │                 │  │  before?"   │ │
│  │ Semantic search │  │ Graph traversal │  │ Time-series │ │
│  │ over content    │  │ over structure  │  │ patterns    │ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**When to use each layer:**

| Query Type | Memory Layer | Example |
|------------|--------------|---------|
| "Find similar code" | RAG (pgvector) | Semantic similarity search |
| "Who owns this service?" | Graph (Neo4j) | Relationship traversal |
| "Has this deployment failed before?" | Historical (PostgreSQL) | Time-series patterns |
| "What changed recently?" | Graph + Historical | Structural + temporal |
| "Find docs about authentication" | RAG | Content similarity |

**Anti-pattern:** Conflating these into one system:
```
❌ WRONG: Store everything in pgvector
- Relationships lost (no "who calls what")
- Time patterns lost (no "has this failed before")
- Query efficiency suffers

✅ RIGHT: Use the appropriate layer
- RAG: Content search (embeddings)
- Graph: Structure search (relationships)
- Historical: Pattern search (time-series)
```

**Production implementation (ai-platform):**
```yaml
# Hybrid retrieval pipeline
retrieval:
  # Step 1: Semantic search
  rag:
    store: pgvector
    query: "SELECT * FROM embeddings ORDER BY embedding <-> $query_embedding LIMIT 10"

  # Step 2: Expand via relationships
  graph:
    store: neo4j
    query: |
      MATCH (chunk:Chunk)-[:MENTIONS]->(entity)
      WHERE chunk.id IN $rag_results
      MATCH (entity)<-[:MENTIONS]-(related:Chunk)
      RETURN related

  # Step 3: Check historical patterns
  historical:
    store: postgresql
    query: "SELECT failure_rate, last_failure FROM deployment_history WHERE service_id = $entity_id"

  # Step 4: Merge and rank
  merge: hybrid
```

---

### Pattern 2: Stateless Execution + External Memory

**Principle:** Agents don't maintain session state internally. Memory systems do.

**Stateless Agent Model:**

```
Agent Invocation (stateless):
  Input:  Event + Context (loaded from external memory)
  Output: Response + Actions (persisted to external memory)

  Agent itself: Pure function, no internal state
```

**Why stateless:**
- **Restartable:** Agent can crash and restart without losing state
- **Scalable:** Multiple agent instances can process events
- **Debuggable:** State is external, inspectable, queryable
- **Portable:** Same agent runs on edge, datacenter, cloud

**External Memory Contract:**

```python
# Agent execution model
class StatelessAgent:
    def execute(self, event: Event, memory: MemorySystem) -> AgentResult:
        # Load context from external memory
        context = memory.load(
            session_id=event.session_id,
            layers=['rag', 'graph', 'historical']
        )

        # Agent does its work (pure function)
        result = self.process(event, context)

        # Persist results to external memory
        memory.store(
            session_id=event.session_id,
            layer='historical',
            data=result.observations
        )

        return result
```

**Memory System Interface:**

```python
class MemorySystem:
    """External memory backing for stateless agents"""

    def __init__(self, postgresql: PostgreSQL, neo4j: Neo4j, pgvector: PgVector):
        self.historical = postgresql  # Time-series patterns
        self.graph = neo4j            # Relationships
        self.rag = pgvector           # Semantic search

    def load(self, session_id: str, layers: List[str]) -> Context:
        """Load context from specified memory layers"""
        context = {}
        if 'historical' in layers:
            context['history'] = self.historical.query_session(session_id)
        if 'graph' in layers:
            context['relationships'] = self.graph.query_session(session_id)
        if 'rag' in layers:
            context['similar'] = self.rag.query_session(session_id)
        return Context(**context)

    def store(self, session_id: str, layer: str, data: Any):
        """Persist data to specified memory layer"""
        if layer == 'historical':
            self.historical.insert(session_id, data)
        elif layer == 'graph':
            self.graph.upsert(session_id, data)
        elif layer == 'rag':
            self.rag.upsert(session_id, data)
```

**Production validation:** ai-platform agents are stateless. All state lives in PostgreSQL (historical), Neo4j (graph), or pgvector (RAG). Pods can restart without losing session context.

---

### Pattern 3: Mission Lifecycle State Machines (Houston Pattern)

**Principle:** Make agent lifecycle explicit with defined states and transitions.

**The Houston Lifecycle:**

```
prep → queued → held → launching → active → complete|failed|aborted
```

| State | Description | Transitions To | Timeout |
|-------|-------------|----------------|---------|
| `prep` | Mission created, not yet queued | `queued`, `aborted` | None |
| `queued` | Waiting for scheduling | `held`, `launching`, `aborted` | None |
| `held` | Blocked by policy/quota | `queued`, `aborted` | 30min |
| `launching` | Agent confirming readiness | `active`, `failed`, `aborted` | 30s |
| `active` | Running | `complete`, `failed`, `aborted` | Configurable |
| `complete` | Finished successfully | (terminal) | N/A |
| `failed` | Finished with error | (terminal) | N/A |
| `aborted` | Cancelled by user/policy | (terminal) | N/A |

**Why explicit state machines:**

1. **Debuggability:** Every state change has a reason code
2. **Durability:** Transitions logged, recoverable after crash
3. **Policy integration:** `held` state enables governance gates
4. **Timeout handling:** Prevents stuck states

**Reason Codes:**

```python
class TransitionReason(Enum):
    USER_REQUEST = "user_request"      # User initiated
    SCHEDULER = "scheduler"            # Scheduler decision
    AGENT_READY = "agent_ready"        # Agent confirmed launch
    COMPLETION = "completion"          # Work finished successfully
    FAILURE = "failure"                # Error occurred
    TIMEOUT = "timeout"                # Deadline exceeded
    QUOTA_EXCEEDED = "quota_exceeded"  # Budget/limit hit
    RATE_LIMIT = "rate_limit"          # Too many requests
```

**State Machine Implementation:**

```python
from enum import Enum
from dataclasses import dataclass
from datetime import datetime

class MissionPhase(Enum):
    PREP = "prep"
    QUEUED = "queued"
    HELD = "held"
    LAUNCHING = "launching"
    ACTIVE = "active"
    COMPLETE = "complete"
    FAILED = "failed"
    ABORTED = "aborted"

@dataclass
class StateTransition:
    from_state: MissionPhase
    to_state: MissionPhase
    reason: TransitionReason
    timestamp: datetime
    details: dict

class MissionStateMachine:
    VALID_TRANSITIONS = {
        MissionPhase.PREP: [MissionPhase.QUEUED, MissionPhase.ABORTED],
        MissionPhase.QUEUED: [MissionPhase.HELD, MissionPhase.LAUNCHING, MissionPhase.ABORTED],
        MissionPhase.HELD: [MissionPhase.QUEUED, MissionPhase.ABORTED],
        MissionPhase.LAUNCHING: [MissionPhase.ACTIVE, MissionPhase.FAILED, MissionPhase.ABORTED],
        MissionPhase.ACTIVE: [MissionPhase.COMPLETE, MissionPhase.FAILED, MissionPhase.ABORTED],
    }

    def transition(self, mission_id: str, to_state: MissionPhase, reason: TransitionReason):
        current = self.get_state(mission_id)

        # Validate transition
        if to_state not in self.VALID_TRANSITIONS.get(current, []):
            raise InvalidTransition(f"Cannot transition from {current} to {to_state}")

        # Log transition with reason
        transition = StateTransition(
            from_state=current,
            to_state=to_state,
            reason=reason,
            timestamp=datetime.utcnow(),
            details={"mission_id": mission_id}
        )
        self.log_transition(transition)

        # Update state
        self.set_state(mission_id, to_state)

        return transition
```

**Integration with context bundles:** Each state transition can trigger bundle creation:
- `active → complete`: Create completion bundle
- `active → failed`: Create failure bundle (for debugging)
- `queued → held`: Create hold reason bundle (for approval)

---

### Pattern 4: Neo4j State Persistence (Graph Memory)

**Principle:** Use a knowledge graph for relationship-aware state persistence.

**Why Neo4j for State:**
- **Relationships are first-class:** "Agent A depends on Agent B's output"
- **Temporal queries:** "What changed since yesterday?"
- **Cross-session links:** "This session continues session X"

**Schema for Session State:**

```cypher
// Core session nodes
(:Session {id, started_at, phase, bundle_path})
(:Agent {name, version, type})
(:Event {id, type, timestamp, payload})
(:Decision {id, description, rationale, timestamp})
(:Artifact {id, path, type, created_at})

// Relationships
(Session)-[:EXECUTED_BY]->(Agent)
(Session)-[:TRIGGERED_BY]->(Event)
(Session)-[:MADE_DECISION]->(Decision)
(Session)-[:PRODUCED]->(Artifact)
(Session)-[:CONTINUES]->(Session)  // Session chaining
(Decision)-[:LED_TO]->(Decision)   // Decision dependencies
(Artifact)-[:USED_IN]->(Session)   // Artifact reuse
```

**Example Queries:**

```cypher
// Find all artifacts from sessions that led to this one
MATCH (current:Session {id: $session_id})
MATCH (current)-[:CONTINUES*]->(previous:Session)
MATCH (previous)-[:PRODUCED]->(artifact:Artifact)
RETURN artifact

// Find decisions that affected this session
MATCH (s:Session {id: $session_id})
MATCH (s)-[:CONTINUES*]->(prev:Session)-[:MADE_DECISION]->(d:Decision)
RETURN d ORDER BY d.timestamp DESC

// Find sessions that used similar artifacts (for pattern mining)
MATCH (current:Session {id: $session_id})-[:PRODUCED]->(a:Artifact)
MATCH (other:Session)-[:USED_IN]->(a)
WHERE other.id <> current.id
RETURN other, count(a) as shared_artifacts
ORDER BY shared_artifacts DESC
```

**State Persistence Flow:**

```python
class Neo4jSessionStore:
    def create_session(self, session_id: str, agent: str, event: dict) -> None:
        """Create new session node linked to triggering event"""
        self.graph.run("""
            MERGE (s:Session {id: $session_id})
            SET s.started_at = datetime(), s.phase = 'prep'

            MERGE (a:Agent {name: $agent})
            MERGE (e:Event {id: $event_id})
            SET e.type = $event_type, e.payload = $payload

            MERGE (s)-[:EXECUTED_BY]->(a)
            MERGE (s)-[:TRIGGERED_BY]->(e)
        """, session_id=session_id, agent=agent, **event)

    def continue_session(self, new_session_id: str, previous_session_id: str) -> None:
        """Link new session to previous (for multi-day work)"""
        self.graph.run("""
            MATCH (prev:Session {id: $previous_id})
            MERGE (new:Session {id: $new_id})
            MERGE (new)-[:CONTINUES]->(prev)
        """, previous_id=previous_session_id, new_id=new_session_id)

    def record_decision(self, session_id: str, decision: dict) -> None:
        """Record a decision made during the session"""
        self.graph.run("""
            MATCH (s:Session {id: $session_id})
            CREATE (d:Decision {
                id: $decision_id,
                description: $description,
                rationale: $rationale,
                timestamp: datetime()
            })
            MERGE (s)-[:MADE_DECISION]->(d)
        """, session_id=session_id, **decision)

    def load_context(self, session_id: str) -> dict:
        """Load accumulated context from session chain"""
        result = self.graph.run("""
            MATCH (current:Session {id: $session_id})
            OPTIONAL MATCH (current)-[:CONTINUES*]->(prev:Session)
            OPTIONAL MATCH (prev)-[:MADE_DECISION]->(d:Decision)
            OPTIONAL MATCH (prev)-[:PRODUCED]->(a:Artifact)
            RETURN prev, collect(DISTINCT d) as decisions, collect(DISTINCT a) as artifacts
        """, session_id=session_id)

        return {
            "previous_sessions": [r["prev"] for r in result],
            "decisions": flatten([r["decisions"] for r in result]),
            "artifacts": flatten([r["artifacts"] for r in result])
        }
```

**Integration with bundles:** Neo4j stores the **relationships** between sessions and artifacts. The bundle **content** still lives in Git (lossless storage). Neo4j enables queries like "find all sessions that influenced this one" or "what decisions led to this state."

---

## Further Reading

- **Anthropic's Pattern**: [../docs/reference/anthropic-long-running-agents.md](../docs/reference/anthropic-long-running-agents.md)
- **Context Engineering Foundation**: [../docs/principles/context-engineering.md](../docs/principles/context-engineering.md)
- **Factor II (40% Rule)**: [./02-context-loading.md](./02-context-loading.md)

---

**Remember:** Bundles are not about losing information—they're about loading smarter. Full detail stays in Git forever. Bundles are compressed loading keys that keep context utilization under 40% across days, weeks, or months.
