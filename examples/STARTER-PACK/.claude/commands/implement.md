# /implement - Implementation Phase

**Purpose:** Execute approved plan with continuous validation

**When to use:** After plan approved, ready to build

**What it does:** Invokes implement-agent to execute plan mechanically

---

## Usage

```bash
# Load plan and implement
/implement [plan-name]
```

**Agent will:**
1. Load implementation plan
2. Execute tasks sequentially
3. Validate after each change
4. Track metrics and progress
5. Document deviations
6. Commit with learnings

**Output:** Working solution + implementation report

---

**Demonstrates:** Factor IV (Validation Gates), Factor V (Operational Telemetry), Factor XI (Constitutional Guardrails)
