# Agent Interaction Standards

**Purpose:** Ensure consistent, predictable interaction patterns across all agents

**Version:** 1.0.0
**Status:** Mandatory for all agents

---

## The Problem

**Inconsistent prompting creates confusion:**
- Agent A uses `AskUserQuestion` for choosing approach
- Agent B uses freeform text for the same situation
- User doesn't know what to expect

**Result:** Cognitive overhead, slower workflow, frustration

---

## The Solution

**Same situation = Same interaction pattern (always)**

Use this guide to determine which interaction method to use:

---

## Decision Tree

```
Is the input:
├─ Structured choice from 2-4 options?
│  └─ Use: AskUserQuestion
│
├─ Multi-step configuration (name, path, type, etc.)?
│  └─ Use: AskUserQuestion (multiple questions)
│
├─ Creative/exploratory request?
│  └─ Use: Freeform text input
│
├─ Open-ended description or explanation?
│  └─ Use: Freeform text input
│
└─ Complex technical specification?
   └─ Use: Freeform text input
```

---

## When to Use `AskUserQuestion`

### ✅ Good Use Cases

**1. Structured Choices (2-4 options)**
```typescript
AskUserQuestion({
  question: "Which authentication method should we use?",
  header: "Auth method",
  options: [
    { label: "JWT", description: "Stateless, scalable" },
    { label: "Sessions", description: "Server-side, more control" },
    { label: "OAuth", description: "Third-party providers" }
  ]
})
```

**2. Multi-Step Setup**
```typescript
// Question 1: Choose profile type
AskUserQuestion({
  question: "What type of profile are you creating?",
  header: "Profile type",
  options: [
    { label: "Software Development", description: "Coding, testing, debugging" },
    { label: "Platform Operations", description: "K8s, infrastructure, monitoring" },
    { label: "Content Creation", description: "Docs, tutorials, writing" }
  ]
})

// Question 2: Choose language/stack
AskUserQuestion({
  question: "What's your primary language/stack?",
  header: "Language",
  options: [...]
})
```

**3. Configuration Preferences**
```typescript
AskUserQuestion({
  question: "Which validation level?",
  header: "Validation",
  options: [
    { label: "Basic", description: "Syntax only (fast)" },
    { label: "Standard", description: "Syntax + unit tests" },
    { label: "Comprehensive", description: "Full CI suite" }
  ]
})
```

**4. Multi-Select (Non-Exclusive Choices)**
```typescript
AskUserQuestion({
  question: "Which features do you want to enable?",
  header: "Features",
  multiSelect: true,  // Allow multiple
  options: [
    { label: "Authentication", description: "JWT-based auth" },
    { label: "Caching", description: "Redis caching" },
    { label: "Monitoring", description: "Prometheus metrics" }
  ]
})
```

---

## When to Use Freeform Text

### ✅ Good Use Cases

**1. Creative Requests**
```markdown
User: "Create a caching system that handles Redis failures gracefully
       and falls back to in-memory cache"

Agent: [Understands nuanced requirement, designs solution]
```

**2. Open-Ended Exploration**
```markdown
User: "Research how our authentication system works and identify
       potential security improvements"

Agent: [Explores codebase, analyzes patterns, suggests improvements]
```

**3. Complex Descriptions**
```markdown
User: "I need to refactor the user service. It currently does too many things:
       - User CRUD
       - Authentication
       - Profile management
       - Email notifications

       Help me break it into smaller services."

Agent: [Analyzes architecture, proposes separation]
```

**4. Technical Specifications**
```markdown
User: "Implement rate limiting:
       - 100 requests per minute per IP
       - 1000 requests per hour per user
       - Use sliding window algorithm
       - Store in Redis
       - Return 429 with Retry-After header"

Agent: [Implements exactly as specified]
```

**5. Questions/Clarifications**
```markdown
Agent: "I found 3 authentication implementations. Which one should I focus on?"
User: "The one in auth/jwt.go - the others are deprecated"
```

---

## Anti-Patterns (Don't Do This)

### ❌ Using AskUserQuestion for Open-Ended Input

**Bad:**
```typescript
AskUserQuestion({
  question: "Describe what you want to build",
  options: [
    { label: "Tell me", description: "..." }
  ]
})
```

**Good:**
```markdown
Agent: "What would you like to build? Please describe the feature,
        including any specific requirements or constraints."

User: [Provides detailed description]
```

---

### ❌ Using Freeform Text for Simple Choices

**Bad:**
```markdown
Agent: "Do you want to use JWT or session-based auth?
        Please type your preference."

User: "jwt"  # Might type "JWT", "Json Web Tokens", etc.
```

**Good:**
```typescript
AskUserQuestion({
  question: "Which authentication method?",
  options: [
    { label: "JWT", description: "..." },
    { label: "Sessions", description: "..." }
  ]
})
```

---

### ❌ Too Many Questions in Sequence

**Bad:**
```typescript
// Question 1
AskUserQuestion({ question: "Language?" })
// Question 2
AskUserQuestion({ question: "Framework?" })
// Question 3
AskUserQuestion({ question: "Database?" })
// Question 4
AskUserQuestion({ question: "Cache?" })
// ... (10 more questions)
```

**Good:**
```typescript
// Ask 2-4 critical questions, infer the rest
AskUserQuestion({
  question: "What's your stack?",
  options: [
    { label: "Python/Django/PostgreSQL", description: "..." },
    { label: "Node.js/Express/MongoDB", description: "..." },
    { label: "Go/Gin/PostgreSQL", description: "..." }
  ]
})

// Infer: Python → pytest, Node → jest, Go → go test
```

---

## Signaling Pattern

**ALWAYS signal to user what format you expect:**

### Before AskUserQuestion
```markdown
Agent: "I'll present some authentication options for you to choose from..."

[Then uses AskUserQuestion with options]
```

### Before Freeform Input
```markdown
Agent: "Please describe the feature you want to build. Include:
        - What it should do
        - Any constraints or requirements
        - Preferred approach (if you have one)"

[User provides detailed text]
```

---

## Consistency Rules

### Rule 1: Same Agent = Same Pattern

If your agent asks "Which auth method?" once, it should ALWAYS ask using the same pattern (AskUserQuestion with same options).

**Why:** Users learn your behavior and build mental models.

### Rule 2: Same Situation = Same Pattern Across Agents

If Agent A uses AskUserQuestion for "Choose validation level", Agent B should too (not freeform text).

**Why:** Cross-agent consistency reduces cognitive load.

### Rule 3: Document Your Pattern

Every agent should document in its header:
```markdown
## Interaction Pattern

**Configuration:** Structured questions (AskUserQuestion)
**Task description:** Freeform text
**Clarifications:** Freeform text
```

---

## Examples from STARTER-PACK Agents

### Research Agent (Freeform)

**Why:** Research topics are open-ended exploration

```markdown
Agent: "What would you like to research?

Examples:
- 'How does authentication work in this codebase?'
- 'What caching strategies are we using?'
- 'Analyze the error handling patterns'

Describe what you want to understand:"

User: [Provides detailed research question]
```

### Plan Agent (Structured + Freeform)

**Why:** Approach selection is structured, task description is open-ended

```markdown
# First: Ask for task (freeform)
Agent: "What do you want to plan? Describe the feature, change, or improvement:"
User: "Add refresh token support to our JWT auth"

# Then: Ask for approach (structured)
AskUserQuestion({
  question: "Which implementation approach?",
  options: [
    { label: "Minimal", description: "Basic refresh tokens" },
    { label: "Standard", description: "Refresh + rotation" },
    { label: "Advanced", description: "Refresh + rotation + device tracking" }
  ]
})
```

### Implement Agent (Freeform)

**Why:** Implementation is mechanical execution of plan (no choices needed)

```markdown
Agent: "Loading plan and executing changes...

        [Implements sequentially, validates continuously]

        Change 1: Add refresh_tokens table ✅
        Change 2: Update login endpoint ✅
        ..."
```

### Learn Agent (Freeform)

**Why:** Learning extraction benefits from open reflection

```markdown
Agent: "What did you learn from this session?

Consider:
- Patterns discovered
- What worked well
- What would you do differently
- Reusable insights"

User: [Reflects on learnings]
```

---

## Testing Your Interaction Pattern

**Ask yourself:**

1. **Is it predictable?**
   - Can user anticipate what format you expect?

2. **Is it consistent?**
   - Do you always handle this situation the same way?

3. **Is it appropriate?**
   - Structured choice → AskUserQuestion
   - Open-ended → Freeform text

4. **Is it documented?**
   - Does your agent header explain the pattern?

If all 4 answers are "yes", your pattern is good.

---

## Version History

**v1.0.0** (2025-11-09):
- Initial standards
- Decision tree for pattern selection
- Examples from STARTER-PACK agents
- Anti-patterns documented

---

## Enforcement

**Agent code reviews check:**
- [ ] Consistent pattern for same situations
- [ ] Clear signaling before gathering input
- [ ] AskUserQuestion used for structured choices
- [ ] Freeform text used for open-ended input
- [ ] Pattern documented in agent header

**User feedback:**
- If users express confusion about what format to use → Pattern needs improvement
- If users give wrong format frequently → Signaling needs improvement

---

**Follow these standards, and users will love interacting with your agents.**

**Ignore them, and every interaction becomes a guessing game.**
