# /research - Research Phase

**Purpose:** Start Research → Plan → Implement workflow with research phase

**When to use:** Beginning complex work where requirements aren't fully clear

**What it does:** Invokes research-agent to gather context and understand problem space

---

## Usage

```bash
/research
```

**Agent will:**
1. Clarify research question with you
2. Choose appropriate research approach (codebase, API, requirements, problem analysis)
3. Gather context using JIT loading (stay under 40%)
4. Document findings
5. Create research bundle for plan phase

**Output:** Research document + bundle ready for `/plan`

---

## Example

```
You: /research

Agent: What are we researching?

You: How does user authentication work in this API?

Agent: I'll use codebase exploration approach.
[Discovers auth files, reads strategically, documents findings]

Research complete! Key findings:
- JWT-based authentication
- Redis blacklist for logout
- No refresh tokens

Create bundle? (yes/no)

You: yes

Bundle saved: user-auth-research.md
Ready for: /plan user-auth-research
```

---

**Demonstrates:** Factor II (JIT Context), Factor VI (Session Continuity), Factor VII (Intelligent Routing)
