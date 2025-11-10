# /plan - Planning Phase

**Purpose:** Design solution and create implementation specification

**When to use:** After research complete, before implementing

**What it does:** Invokes plan-agent to design solution from research findings

---

## Usage

```bash
# Load research bundle and plan
/plan [research-bundle-name]

# Or plan from scratch (if research already known)
/plan
```

**Agent will:**
1. Load research findings
2. Design solution architecture
3. Break down into tasks
4. Specify acceptance criteria
5. Document decisions and risks
6. Create implementation specification

**Output:** Implementation plan ready for `/implement`

---

**Demonstrates:** Factor III (Single-Responsibility), Factor IX (Pattern Extraction), Factor XII (Domain Portability)
