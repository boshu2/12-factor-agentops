# Pre-Mortem: Operator-Model Phase 2 Refinement

## Objective

Pressure-test the next `12factor` doctrine refinement wave before implementation.

## Verdict

`WARN`

## Main Risks

### 1. Product-language drift

The most likely failure is that the secondary-doc update imports AgentOps product language too directly:

- three gaps
- software factory
- coding-agent-specific contract wording

That would weaken the broader doctrine surface even if the content is directionally correct.

### 2. Over-broad scope

Once secondary docs are in play, it becomes easy to slide from a five-file refinement wave into another repo-wide cleanup.

That would dilute quality, slow review, and create unnecessary churn.

### 3. Fitness gradient added too abstractly

`fitness gradient` is the strongest remaining missing primitive, but it can read as imported theory if it is not tied directly to:

- goals
- measurements
- gates
- decisions

### 4. Provenance treated as archive hygiene instead of trust surface

If provenance is presented as mere documentation hygiene, the update will miss the actual operator insight:

- provenance determines what the environment is allowed to trust

## Mitigations

### For product-language drift

- keep AgentOps product terms inside comparison/explanation surfaces
- keep factor docs in `12factor` voice
- describe AgentOps as a narrower implementation layer, not the doctrine itself

### For scope creep

- restrict implementation to the five planned work items
- defer any new opportunistic doc cleanup unless it blocks consistency

### For fitness-gradient abstraction

- anchor the concept in Factor IX
- tie it to concrete questions:
  - what counts as success?
  - what gates enforce it?
  - what metrics move decisions?

### For provenance dilution

- anchor it in Factor VII and the explanation docs
- explicitly connect provenance to trust, citations, and promotion eligibility

## Recommended Adjustment

Keep the next wave narrow:

1. Factor VII
2. Factor IX
3. comparison-table
4. evolution-of-12-factor
5. from-theory-to-production

Do not expand further unless those five surfaces reveal a hard dependency.
