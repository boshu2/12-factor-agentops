# The Five Laws of AgentOps

**Constitutional Foundation**: These laws apply to ALL agents, workflows, and sessions.

**Status**: Mandatory (enforced by git hooks)

---

## Law 1: ALWAYS Extract Learnings

**What it means:** Document patterns discovered, capture decision rationale, analyze failures for prevention.

**Why it matters:** Patterns are valuable. One-time solutions are not. Every session should produce reusable knowledge.

**In practice:**
- ✅ Document "why" decisions were made
- ✅ Capture patterns that could apply elsewhere
- ✅ Analyze what worked and what didn't
- ✅ Share learnings in commit messages

**Example:**
```markdown
## Learning
Discovered that JWT tokens should expire in 15 minutes (not 60).
Pattern: Short-lived access tokens + refresh tokens = better security.
Reusable for: Any API authentication system.
```

---

## Law 2: ALWAYS Improve Self or System

**What it means:** Identify at least 1 improvement opportunity with impact and implementation path.

**Why it matters:** Stagnation is regression. Continuous improvement is mandatory.

**In practice:**
- ✅ Find at least one thing to improve
- ✅ Specify impact (time saved, quality improved)
- ✅ Propose implementation (effort, priority)
- ✅ Track improvements over time

**Example:**
```markdown
## Improvements Identified
1. Add rate limiting (High impact, 2 hours effort)
   - Current: No protection against abuse
   - Impact: Prevent DoS, improve reliability

2. Extract token service (Medium impact, 3 hours effort)
   - Current: Token logic scattered across 3 files
   - Impact: Better testability, reusability
```

---

## Law 3: ALWAYS Document Context for Future

**What it means:** Include Context (why needed), Solution (what was done), Learning (insights), Impact (value).

**Why it matters:** Future contributors (or future you) will thank you. Context prevents repeated mistakes.

**In practice:**
- ✅ Explain WHY change was needed
- ✅ Describe WHAT was implemented
- ✅ Capture LEARNING for next time
- ✅ Quantify IMPACT when possible

**Commit template:**
```markdown
<type>(<scope>): <subject>

## Context
[Why was this change needed? What problem does it solve?]

## Solution
[What was implemented? How does it work?]

## Learning
[What patterns were discovered? What would you do differently?]

## Impact
[What's the measured improvement? Time saved? Quality gained?]
```

---

## Law 4: ALWAYS Validate Before Execute

**What it means:** Preview changes, test in safe environments, validate before applying.

**Why it matters:** Prevention is cheaper than recovery. Validation gates catch errors before they reach production.

**In practice:**
- ✅ Use `--dry-run` or `--check-only` flags
- ✅ Run tests after each change
- ✅ Show diffs before committing
- ✅ Validate syntax before execution

**Validation hierarchy:**
1. Syntax validation (immediate)
2. Unit tests (per change)
3. Integration tests (after related changes)
4. Full test suite (before commit)

**Hook loop prevention:**
- ❌ NEVER commit files modified by post-commit hooks
- ✅ ALWAYS check git status after push
- ✅ STOP if hooks modified files

---

## Law 5: ALWAYS Share Patterns Publicly

**What it means:** Extract generalizable insights, document failures, help others avoid mistakes.

**Why it matters:** Rising tide lifts all boats. Building collective knowledge benefits everyone.

**In practice:**
- ✅ Document patterns in reusable format
- ✅ Share failures as openly as successes
- ✅ Contribute to pattern libraries
- ✅ Help community avoid your mistakes

**What to share:**
- Patterns that worked (copy-paste ready)
- Patterns that failed (lessons learned)
- Improvements discovered (Factor X)
- Cross-domain insights (meta-patterns)

---

## Enforcement

### Git Hooks (Automated)

**prepare-commit-msg**: Injects template if missing
**commit-msg**: Validates commit follows Laws
**post-commit**: Extracts learnings to session log
**post-push**: Checks for hook loop violations (Law 4)

### Agent Behavior (Constitutional)

All agents inherit these Laws from CONSTITUTION.md:
- Research agents: Extract learnings (Law 1)
- Plan agents: Identify improvements (Law 2)
- Implement agents: Validate before execute (Law 4)
- Learn agents: Share patterns (Law 5)

### Session Reviews

Weekly/quarterly retrospectives check:
- Are we extracting learnings? (Law 1)
- Are we identifying improvements? (Law 2)
- Are commits documenting context? (Law 3)
- Are we validating before execute? (Law 4)
- Are we sharing patterns? (Law 5)

---

## Examples

### Good Commit (Follows All Laws)

```markdown
feat(auth): Add JWT refresh token rotation

## Context
Users complained about frequent re-authentication (every 15 minutes).
Current system: Short-lived access tokens, no refresh mechanism.
Need: Long-lived sessions without compromising security.

## Solution
Implemented refresh token rotation:
- Access tokens: 15 minutes (unchanged)
- Refresh tokens: 7 days (new)
- Rotation: New refresh token issued on each use
- Storage: Redis with automatic expiration

## Learning
Discovered pattern: "Refresh token rotation prevents token theft"
- If token stolen, max lifetime is 7 days (vs infinite)
- Each use invalidates old token (stolen token detected faster)
- Pattern applies to any session management system

## Impact
- User satisfaction: +40% (fewer re-auths)
- Security: +60% (shorter max token lifetime)
- Implementation time: 4 hours (vs 2 days estimated)
- Pattern reusable for: Any API with authentication

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### Bad Commit (Violates Laws)

```markdown
fix stuff

# Violates Law 3: No context, no learning, no impact
# Cannot learn from this commit
# Cannot reuse any patterns
# Future developers: "What was broken? Why this fix?"
```

---

## Integration with 12 Factors

| Law | Related Factors | Connection |
|-----|----------------|------------|
| Law 1 (Extract Learnings) | Factor IX (Pattern Extraction) | Learnings become patterns |
| Law 2 (Improve) | Factor X (Continuous Improvement) | Improvements compound over time |
| Law 3 (Document Context) | Factor I (Git Memory) | Context captured in git history |
| Law 4 (Validate) | Factor IV (Validation Gates) | Validation prevents errors |
| Law 5 (Share) | Factor XII (Domain Portability) | Sharing enables cross-domain learning |

---

## Version & Status

**Version:** 1.0.0 (Stable)
**Status:** Constitutional (mandatory)
**Enforcement:** Git hooks + agent behavior
**Origin:** Extracted from 200+ production sessions (95% success rate)

**See also:**
- `../../foundations/five-laws.md` - Complete philosophical explanation
- `git-hooks/` - Hook implementations
- `../WORKFLOWS.md` - Laws in practice

---

**These Laws are not suggestions. They are requirements.**

Follow them, and your work will compound over time.
Ignore them, and you'll repeat the same mistakes forever.
