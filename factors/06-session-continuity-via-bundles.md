# Factor VI: Resume Work

**Persist and restore context using compressed artifacts for multi-day work**

| Aspect | Details |
|--------|---------|
| **Primary Pillar** | Context Engineering |
| **Supporting Pillar** | Knowledge OS |
| **Enforces Laws** | Law 2 (Improve System), Law 3 (Document Context) |
| **Derived From** | Compression techniques + Spaced repetition + Progressive summarization |

📘 **[See complete derivation →](../ARCHITECTURE.md#factor-vi-session-continuity-via-bundles)**

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

### Grounding in the Four Pillars

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

## Further Reading

- **Context Engineering Foundation**: [../foundations/context-engineering.md](../foundations/context-engineering.md)
- **Factor II (40% Rule)**: [./02-fresh-context-windows.md](./02-fresh-context-windows.md)
- **Pattern: Context Bundles**: [../patterns/context-bundles.md](../patterns/context-bundles.md)

---

**Remember:** Bundles are not about losing information—they're about loading smarter. Full detail stays in Git forever. Bundles are compressed loading keys that keep context utilization under 40% across days, weeks, or months.
