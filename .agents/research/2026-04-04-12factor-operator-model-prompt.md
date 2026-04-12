# Prompt: Update 12-Factor AgentOps With Operator-Model Lessons

You are working in the latest source repo at:

- `/Users/fullerbt/gt/12factor`

Your job is to update the doctrine in this repo so it incorporates the newer control-plane/operator-model lessons **without** flattening the repo into AgentOps product language.

Read these files first:

### Primary target repo sources

- `/Users/fullerbt/gt/12factor/README.md`
- `/Users/fullerbt/gt/12factor/factors/README.md`
- `/Users/fullerbt/gt/12factor/factors/01-context-is-everything.md`
- `/Users/fullerbt/gt/12factor/factors/05-validate-externally.md`
- `/Users/fullerbt/gt/12factor/factors/08-compound-knowledge.md`
- `/Users/fullerbt/gt/12factor/factors/12-harvest-failures-as-wisdom.md`
- `/Users/fullerbt/gt/12factor/docs/plans/2026-02-15-pivot-design.md`
- `/Users/fullerbt/gt/12factor/docs/principles/comparison-table.md`
- `/Users/fullerbt/gt/12factor/.agents/research/2026-02-15-v3-docs-rewrite-inventory.md`
- `/Users/fullerbt/gt/12factor/.agents/research/2026-04-04-latest-source-gap-analysis.md`
- `/Users/fullerbt/gt/12factor/.agents/research/2026-04-04-12factor-operator-model-brief.md`

### External conceptual inputs to adapt, not copy wholesale

- `/Users/fullerbt/.agents/knowledge/operator-model.md`
- `/Users/fullerbt/.agents/knowledge/stateful-environment-stateless-agents.md`
- `/Users/fullerbt/.agents/knowledge/corpus-hidden-patterns.md`
- `/Users/fullerbt/gt/agentops/crew/nami/.agents/research/2026-04-03-what-is-agentops.md`
- `/Users/fullerbt/gt/agentops/crew/nami/.agents/research/2026-04-03-agentops-facing-argument.md`

## The key constraint

Do **not** rewrite `12factor` into AgentOps product language.

Keep this repo:

- factor-first
- principle-first
- broader than coding-only
- broader than the AgentOps plugin

The 12 factors remain the public surface.

## The actual delta to implement

Add a compression layer under the 12 factors that makes these ideas explicit:

1. the environment carries continuity
2. actors are replaceable
3. traces coordinate work across sessions
4. gates decide what survives
5. promotion loops compound intelligence
6. governance sets objective and boundaries

## Required changes

### 1. Add one new explanatory crosswalk doc

Create:

- `/Users/fullerbt/gt/12factor/docs/explanation/operator-model.md`

It should explain the operator model beneath the twelve factors and map the factors to that model.

### 2. Update the two core entry surfaces

Update:

- `/Users/fullerbt/gt/12factor/README.md`
- `/Users/fullerbt/gt/12factor/factors/README.md`

Add a short, clean explanation that the twelve factors are the public operating rules and the operator model is the compression layer underneath them.

### 3. Tighten the four most central factor docs

Update:

- `/Users/fullerbt/gt/12factor/factors/01-context-is-everything.md`
- `/Users/fullerbt/gt/12factor/factors/05-validate-externally.md`
- `/Users/fullerbt/gt/12factor/factors/08-compound-knowledge.md`
- `/Users/fullerbt/gt/12factor/factors/12-harvest-failures-as-wisdom.md`

Goals by file:

- Factor I: make environment-carried continuity and bounded activation clearer
- Factor V: make external selection gates and governance clearer
- Factor VIII: make promotion loops and compounding substrate clearer
- Factor XII: make negative knowledge, traces, and evolutionary adaptation clearer

## Optional follow-up only if needed

After the core doctrine lands cleanly, consider light follow-up in:

- `/Users/fullerbt/gt/12factor/docs/principles/comparison-table.md`
- `/Users/fullerbt/gt/12factor/docs/principles/evolution-of-12-factor.md`
- `/Users/fullerbt/gt/12factor/docs/explanation/from-theory-to-production.md`

Do not start there.

## Definition of done

The finished repo should make a strong reader think:

> The 12 factors are the practical rules. The operator model explains why they work together as one system.

It should **not** feel like:

> This repo was rewritten into another repo's vocabulary.

## Validation

Run:

```bash
rg -n 'operator model|stateful environment|replaceable actors|selection gates|governance|promotion' \
  /Users/fullerbt/gt/12factor/README.md \
  /Users/fullerbt/gt/12factor/factors/README.md \
  /Users/fullerbt/gt/12factor/factors/01-context-is-everything.md \
  /Users/fullerbt/gt/12factor/factors/05-validate-externally.md \
  /Users/fullerbt/gt/12factor/factors/08-compound-knowledge.md \
  /Users/fullerbt/gt/12factor/factors/12-harvest-failures-as-wisdom.md \
  /Users/fullerbt/gt/12factor/docs/explanation/operator-model.md
```

Also sanity-check that the repo has not been flattened into AgentOps product framing:

```bash
rg -n 'three gaps|judgment validation|durable learning|loop closure' \
  /Users/fullerbt/gt/12factor/README.md \
  /Users/fullerbt/gt/12factor/factors \
  /Users/fullerbt/gt/12factor/docs
```

Those phrases can exist, but they should not become the repo's primary organizing frame.

## Output expectation

Make the code/doc changes directly in `/Users/fullerbt/gt/12factor`, then provide:

1. the files changed
2. the doctrinal changes made
3. the validation results
