# Reference Profile Workflows

**Domain-agnostic examples showing Research → Plan → Implement → Learn cycle**

---

## Workflow 1: Adding API Feature

**Scenario:** Add user profile endpoint to REST API

### Research Phase (45 min)
```bash
/research

Question: How does our API handle user data?

Agent explores:
- API structure (routes, handlers, models)
- Authentication (who can access user profiles?)
- Data storage (where user data lives)
- Validation patterns (how we validate inputs)

Output: Research bundle
- Current architecture: RESTful, Express.js, MongoDB
- Auth: JWT middleware required
- User model exists: name, email, created_at
- Need to add: profile fields (bio, avatar_url, location)
```

### Plan Phase (90 min)
```bash
/plan user-profiles-research

Agent designs:
- API endpoint: GET /users/:id/profile
- Response format: { bio, avatar_url, location, updated_at }
- Database migration: Add profile fields to users collection
- Tests: Unit + integration
- Security: Only user can edit own profile

Tasks (6 hours estimated):
1. Add profile fields to User model (1h)
2. Create GET /profile endpoint (2h)
3. Create PUT /profile endpoint (2h)
4. Add tests (1h)

Output: Implementation specification
```

### Implement Phase (6 hours)
```bash
/implement user-profiles-plan

Agent executes with validation:
- ✅ Task 1: Model updated, tests pass
- ✅ Task 2: GET endpoint works, returns profile
- ✅ Task 3: PUT endpoint validates + updates
- ✅ Task 4: 95% test coverage

Metrics:
- Estimated: 6h, Actual: 6.5h
- Tests added: 15
- Validation failures caught: 2 (before commit)
```

### Learn Phase (30 min)
```bash
/learn

Patterns extracted:
- Profile data pattern (reusable for teams, orgs)
- JWT auth check pattern (use for all endpoints)

Improvements identified:
- Add API versioning (medium priority, 4h effort)
- Extract validation into middleware (high priority, 2h)

Documentation updated: API endpoint list, auth patterns
```

**Total:** 9 hours (Research 45min + Plan 90min + Implement 6.5h + Learn 30min)

---

## Workflow 2: Writing Documentation

**Scenario:** Document how our caching system works

### Research Phase (30 min)
```bash
/research

Question: How does caching work in our system?

Agent reads:
- Cache configuration files
- Cache middleware code
- Existing docs mentioning caching
- Performance logs

Output: Research findings
- Redis-based caching
- TTL: 5 minutes default
- Invalidation: Manual + expiry
- Hit rate: 78% (good!)
```

### Plan Phase (45 min)
```bash
/plan caching-research

Agent plans documentation:
- Audience: Backend developers
- Structure: Overview → Configuration → Usage → Troubleshooting
- Examples: 3 code snippets
- Diagrams: 1 architecture diagram

Tasks (2 hours estimated):
1. Write overview section (30min)
2. Document configuration (30min)
3. Add usage examples (45min)
4. Create troubleshooting guide (15min)

Output: Documentation outline
```

### Implement Phase (2 hours)
```bash
/implement caching-docs-plan

Agent writes docs with validation:
- ✅ Overview: Clear, concise (readability score: 65)
- ✅ Configuration: All options documented
- ✅ Examples: Working code snippets tested
- ✅ Troubleshooting: Common issues covered

Validation: Spell check, link check, code snippets compile
```

### Learn Phase (15 min)
```bash
/learn

Pattern extracted:
- Troubleshooting format (problem → solution → prevention)
- Documentation template for infrastructure components

Improvement: Add "Quick Start" section next time (saves reader time)
```

**Total:** 3.5 hours

---

## Workflow 3: Refactoring Code

**Scenario:** Extract duplicate validation logic

### Research Phase (1 hour)
```bash
/research

Question: Where is validation logic duplicated?

Agent searches:
- Grep for "validate" patterns
- Identifies 5 files with similar logic
- Reads each implementation
- Documents differences

Output: 5 validators doing same thing slightly differently
```

### Plan Phase (1.5 hours)
```bash
/plan validation-refactor-research

Agent designs refactoring:
- Extract to validators/user.js
- Consolidate differences (choose best approach)
- Update all 5 call sites
- Add tests for extracted validator

Tasks (incremental, safe):
1. Create validators/user.js with tests (1h)
2. Update file 1 to use new validator (30min)
3. Update file 2-5 (2h)
4. Remove old validation code (30min)

Rollback: Each step independently reversible
```

### Implement Phase (4 hours)
```bash
/implement validation-refactor-plan

Agent refactors incrementally:
- ✅ Validator extracted, all tests pass
- ✅ File 1 updated, tests pass (validation working)
- ✅ Files 2-5 updated, full test suite passes
- ✅ Old code removed, codebase cleaner

Metrics:
- Lines removed: 120
- Lines added: 45 (net: -75 lines)
- Test coverage: 92% → 95%
```

### Learn Phase (20 min)
```bash
/learn

Pattern: Incremental refactoring (safe, reversible)
Improvement: Use static analysis to find duplication earlier
```

**Total:** 6.5 hours

---

## Key Takeaways

**All workflows follow same pattern:**
1. Research → Understand
2. Plan → Design
3. Implement → Execute
4. Learn → Extract

**Time splits consistently:**
- Research: 15-20%
- Plan: 20-30%
- Implement: 50-60%
- Learn: 5-10%

**Benefits:**
- No premature optimization (research first)
- Clear specifications (plan before code)
- Safe execution (validate continuously)
- Compounding knowledge (extract patterns)

**The reference profile works for ANY domain because it follows universal cognitive patterns, not domain-specific tools.**
