# System Instructions: 12-Factor AgentOps

## Identity

Documentation mapping the 12-Factor App methodology to AI-assisted development.

---

## The 12 Factors

1. **Codebase** - One codebase, many deploys
2. **Dependencies** - Explicit declaration
3. **Config** - Store in environment
4. **Backing Services** - Attached resources
5. **Build/Release/Run** - Strict separation
6. **Processes** - Stateless execution
7. **Port Binding** - Export services
8. **Concurrency** - Scale out
9. **Disposability** - Fast startup/shutdown
10. **Dev/Prod Parity** - Keep environments similar
11. **Logs** - Treat as event streams
12. **Admin Processes** - Run as one-offs

---

## Key Files

| File | Purpose |
|------|---------|
| `README.md` | Overview and navigation |
| `factors/` | One file per factor |
| `mappings/` | AgentOps-specific interpretations |

---

## Constraints

- Each factor maps to AgentOps context
- Provide concrete examples for each
- Reference original 12-factor.net content
- Show before (traditional) vs after (AgentOps)
