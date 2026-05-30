# AGENTS.md — 12-factor-agentops repo contract

> `CLAUDE.md` is a symlink to this file. Edit here.

## What this repo is

**12-Factor AgentOps** is the public **doctrine** — the principles behind the
operational layer for coding agents (`agentops/`, the `ao` CLI). This is a docs
repo, not a runtime. It is NOT a Gas Town rig, NOT a Mayor coordinator, and has
no `gt`/town/rig/polecat machinery.

## Where the canonical content lives

- **`factors/`** — the twelve factor docs (`factors/01-...md` … `factors/12-...md`),
  indexed by `factors/README.md` in four tiers (Foundation I–III, Flow IV–VI,
  Knowledge VII–IX, Scale X–XII).
- **`docs/`** — supporting material: `docs/explanation/operator-model.md` (the
  compression layer under the factors), `docs/reference/`, `docs/getting-started/`,
  `docs/how-to/`, `docs/tutorials/`, `docs/case-studies/`.
- **`README.md`** — public landing page. `PRODUCT.md`, `GOALS.yaml`, `CHANGELOG.md`,
  `CONTRIBUTING.md` round out the project surface.

## How it relates to agentops

This repo is the **doctrine**; `~/dev/agentops/` is the **substrate** that
implements it (`ao` CLI, hooks, skills, daemon). Keep the two aligned — factor
docs here are the public rules; `agentops/` is the reference implementation.
For the full workspace map (doctrine → substrate → reference → support), see
`~/dev/CLAUDE.md`.

## Finding work

Issue tracking is `bd` (beads), prefix `1fa`, wired to the shared `bushido`
Dolt DB.

```bash
bd ready              # available work
bd show <id>          # issue details
bd update <id> --status in_progress  # claim
bd close <id>         # complete
```

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd dolt push
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
