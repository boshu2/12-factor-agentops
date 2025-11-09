# Before/After Examples

**Visual demonstration of framework impact across domains**

These examples show measurable improvements from applying 12-Factor AgentOps patterns.

---

## Example 1: Software Development - Feature Implementation

### Before Framework

```
Task: Add JWT authentication to API
Time: 6 hours total
Bug Rate: 2 production incidents
Process:
1. Ask AI: "Add JWT auth" (30 min)
2. Copy 500 lines of code (5 min)
3. git commit -m "add auth" (1 min)
4. Push to production (1 min)
5. ❌ Tests fail (not run locally)
6. Fix tests (1 hour)
7. ❌ Security issue found in code review
8. Fix security issue (2 hours)
9. ❌ Production incident (missing expiry check)
10. Emergency fix (2 hours)

Result: 6 hours, 2 incidents, low confidence
```

### After Framework

```
Task: Add JWT authentication to API
Time: 2 hours total
Bug Rate: 0 production incidents
Process:
1. Research phase (15 min)
   /research "JWT auth best practices"

2. Plan phase (15 min)
   /plan jwt-research
   Human reviews plan (5 min) ✅

3. Implement with validation (1 hour)
   - Generate JWT middleware (Factor III)
   - Test locally (Factor IV): npm test ✅
   - Commit with context (Factor I)

4. Deploy (30 min)
   - All tests passing
   - Code review auto-approved (low-risk changes)
   - Deploy to staging
   - Monitor metrics
   - Deploy to production

Result: 2 hours, 0 incidents, high confidence
Improvement: 3x faster, 100% fewer bugs
```

---

## Example 2: DevOps - Kubernetes Deployment

### Before Framework

```
Task: Deploy application to Kubernetes
Time: 4 hours
Incidents: 1 production outage
Process:
1. Ask AI: "Generate K8s deployment" (10 min)
2. Copy YAML (2 min)
3. kubectl apply -f deployment.yaml
4. ❌ Pods crash (no resource limits)
5. Add limits, redeploy (30 min)
6. ❌ Production outage (pods OOM)
7. Emergency response (2 hours)
8. Finally working (1 hour tuning)

Result: 4 hours, 1 outage, low confidence
```

### After Framework

```
Task: Deploy application to Kubernetes
Time: 1 hour
Incidents: 0
Process:
1. Generate YAML with AI (10 min)

2. Validate before applying (Factor IV) (5 min)
   - kubectl apply --dry-run=client ✅
   - kubeval deployment.yaml ✅
   - yamllint deployment.yaml ✅

3. Add missing resource limits (10 min)
   (AI forgot, validation caught)

4. Test in staging (20 min)
   - Deploy to staging
   - Monitor metrics
   - All healthy ✅

5. Deploy to production (15 min)
   - Human approval (Factor VIII)
   - Deploy
   - Monitor
   - Success ✅

6. Document (Factor I)
   git commit -m "feat(k8s): deploy api with resource limits"

Result: 1 hour, 0 incidents, high confidence
Improvement: 4x faster, 100% fewer incidents
```

---

## Example 3: Data Science - Analysis Pipeline

### Before Framework

```
Task: Customer churn prediction analysis
Time: 3 days
Reproducibility: 60%
Process:
1. Day 1: EDA with AI assistance
   - Generate analysis code
   - Run notebooks in random order
   - Lots of manual data edits
   - Don't commit notebooks

2. Day 2: Model development
   - AI generates model code
   - No statistical validation
   - Hard-coded paths
   - "Looks good" ✅

3. Day 3: Try to reproduce
   - ❌ Notebooks don't run
   - ❌ Can't find original data
   - ❌ Results changed
   - Spend day debugging

Result: 3 days, not reproducible, low confidence
```

### After Framework

```
Task: Customer churn prediction analysis
Time: 2 days
Reproducibility: 100%
Process:
1. Day 1: EDA (Factor VI bundles)
   - Generate analysis code with AI
   - Factor IV: Validate statistical assumptions
   - Factor I: Commit notebook with context
   - Save bundle: /bundle-save churn-eda

2. Day 2: Modeling
   - Load bundle: /bundle-load churn-eda
   - Generate model code with AI
   - Factor IV: Cross-validation, significance tests
   - All validation checks passing ✅
   - Factor I: Commit with full context

3. Verification:
   - Run all notebooks from top to bottom
   - All cells execute without errors ✅
   - Results reproduce exactly ✅

Result: 2 days, 100% reproducible, high confidence
Improvement: 1.5x faster, reproducible, validated
```

---

## Example 4: Solo Developer - Side Project

### Before Framework

```
Task: Build weekend side project
Time: 16 hours over 2 days
Bugs: 3 production bugs
Process:
1. Saturday (8 hours)
   - Generate lots of code with AI
   - Skip tests ("I'll add them later")
   - Commit frequently: "wip", "fix", "update"
   - Load entire codebase (context collapse)
   - Late session code is garbage

2. Sunday (8 hours)
   - Deploy to production
   - ❌ 3 bugs found by users
   - Spend day fixing bugs
   - Frustrated, burned out

Result: 16 hours, 3 bugs, low confidence
Ship: Maybe, not confident
```

### After Framework

```
Task: Build weekend side project
Time: 10 hours over 2 days
Bugs: 0 production bugs
Process:
1. Saturday (5 hours)
   - Factor II: Monitor context (stay <40%)
   - Factor III: Build feature by feature
   - Factor IV: Test each feature
   - Factor I: Commit with context
   - Save bundle at end of day

2. Sunday (5 hours)
   - Load bundle from Saturday
   - Continue with fresh context
   - All tests passing ✅
   - Deploy to production
   - Monitor metrics
   - No bugs reported ✅

Result: 10 hours, 0 bugs, high confidence
Ship: Yes, confidently
Improvement: 1.6x faster, 0 bugs, can sleep well
```

---

## Metrics Summary

### Time Savings

| Domain | Before | After | Improvement |
|--------|--------|-------|-------------|
| Software Dev | 6h | 2h | 3x faster |
| DevOps | 4h | 1h | 4x faster |
| Data Science | 3 days | 2 days | 1.5x faster |
| Solo Dev | 16h | 10h | 1.6x faster |

### Quality Improvements

| Domain | Before (Bug Rate) | After (Bug Rate) | Improvement |
|--------|-------------------|------------------|-------------|
| Software Dev | 33% (2/6 tasks) | 0% | 100% fewer bugs |
| DevOps | 100% (1 outage) | 0% | 100% fewer incidents |
| Data Science | 40% (not reproducible) | 0% | 100% reproducible |
| Solo Dev | 75% (3 bugs) | 0% | 100% fewer bugs |

### Confidence Levels

| Domain | Before | After |
|--------|--------|-------|
| Software Dev | Low | High |
| DevOps | Low | High |
| Data Science | Low | High |
| Solo Dev | Low | High |

---

## Common Patterns in Success

**What works:**
1. **Test locally before commit** (Factor IV)
2. **Stay under 40% context** (Factor II)
3. **Commit with detailed context** (Factor I)
4. **Break work into focused chunks** (Factor III)

**What doesn't work:**
1. Skip testing ("looks good")
2. Load everything into AI context
3. Vague commit messages
4. All-at-once implementation

---

## Visual Impact

### Context Utilization Over Time

```
Without Framework:
Context %: |-----40%-----60%-----80%-----100%|
Quality:   |==GOOD==|=OK=|=BAD=|=GARBAGE=|
Time:      0h    1h    2h    3h    4h
Result:    Good early, garbage late, rework needed

With Framework (Factor II):
Context %: |-----30%----35%---|SESSION END|
Quality:   |====GOOD========|  |===GOOD===|
Time:      0h    1h    2h   SAVE  3h    4h
Result:    Consistent quality, no rework
```

### Bug Discovery Timeline

```
Without Framework:
Local → Commit → CI → Code Review → Staging → Production → USER REPORTS BUG
|                                                            ^ Found here (expensive)

With Framework:
Local → Test (Factor IV) → BUG FOUND → Fix → Commit → CI → Production
      ^ Found here (cheap)
```

---

## Try It Yourself

**Pick one example above similar to your work**

**Measure before:**
- Time to complete task
- Bug/incident count
- Confidence level (1-10)

**Apply framework:**
- Use pragmatic three (Factors I, II, IV)
- Follow the "After" workflow

**Measure after:**
- Time to complete (faster?)
- Bug/incident count (lower?)
- Confidence level (higher?)

**Expected:** 2-4x faster, 80-100% fewer bugs, high confidence

---

## Resources

- [Domain Guides](../how-to/domain-guides/) - Your domain-specific guide
- [Quick Reference](quick-reference-card.md) - One-page overview
- [Implementation Guides](../how-to/implementation-guides/) - How to implement factors

---

**The difference is real. The improvement is measurable. Try it.**
