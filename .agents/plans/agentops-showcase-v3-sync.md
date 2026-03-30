---
id: plan-2026-02-15-agentops-showcase-v3-sync
type: plan
date: '2026-02-15'
rig: 12factor
---

# Prompt: agentops-showcase v3 Sync

## Goal

Update the agentops-showcase site (~/workspaces/personal/agentops-showcase) to match the current v3 12-Factor AgentOps content at ~/gt/12factor.

## Context

The 12factor repo just completed a v3 pivot — all 12 factors were rewritten, the framing changed from "shift-left validation" to "operational discipline for working with AI agents", and a major cleanup pass was run. The showcase site has v3 factor names in `src/lib/constants.ts` already, but the actual content files and README are stale.

## What Needs Updating

### 1. Sync Factor Content Files (HIGH PRIORITY)

Copy all 12 factor markdown files from the canonical source:

```bash
cp ~/gt/12factor/factors/01-context-is-everything.md ~/workspaces/personal/agentops-showcase/docs/factors/
cp ~/gt/12factor/factors/07-extract-learnings.md ~/workspaces/personal/agentops-showcase/docs/factors/
```

Only 2 files are actually different:
- **Factor I** (01-context-is-everything.md): Missing the new "Hitting the Compaction Wall" anti-pattern section and "Deliberate Compression" rename
- **Factor VII** (07-extract-learnings.md): Showcase has the old 933-line version; 12factor has the trimmed 499-line version

The other 10 files are identical (verified by line count). But copy all 12 to be safe — the content in `~/gt/12factor/factors/*.md` is the canonical source of truth.

### 2. Update README.md (HIGH PRIORITY)

The showcase README has stale v2 framing:
- **Remove:** "Make AI agents as reliable as infrastructure" tagline
- **Remove:** The BUILD→WORK→RUN ecosystem table with "This is the SRE to their DevOps"
- **Remove:** "v2.0.0" version badge and references
- **Update tagline** to: "The Operational Discipline for Working With AI Agents"
- **Update version** to 3.0.0
- **Update the hero description** to match the 12factor README framing: knowledge compounding, not SRE/infrastructure metaphors
- **Keep** the tech badges (Next.js, TypeScript, etc.) and marketplace counts
- **Keep** the skeptics callout (that's unique to the showcase site and good)

Reference: ~/gt/12factor/README.md for the canonical v3 framing, pitch, and structure.

### 3. Update Homepage Content (MEDIUM PRIORITY)

File: `src/app/page.tsx`

The homepage hero already says "the operational discipline for AI agents" — good. But check these sections against the 12factor README:
- **Hero subtitle:** Currently "Make each session smarter than the last" — this is fine, keep it
- **Description text:** Verify it matches v3 framing (operational discipline, knowledge compounding)
- **Factor cards:** These pull from `constants.ts` which is already v3 — verify rendering is correct
- **Any "Before/After" or comparison sections:** Should reference v3 metrics and framing

### 4. Check for Stale v1/v2 References (LOW PRIORITY)

Search the entire codebase for old factor names that might appear in:
- Component files (`src/components/*.tsx`)
- Homepage content (`src/app/page.tsx`)
- Factor listing page (`src/app/factors/page.tsx`)
- Docs directory (`docs/`)
- Test files (`tests/`, `e2e/`)

Old v1 factor names to search for:
```
Automated Tracking, Context Loading, Focused Agents, Continuous Validation,
Measure Everything, Resume Work, Smart Routing, Human Validation,
Mine Patterns, Small Iterations, Fail-Safe Checks, Package Patterns
```

Old framing strings to search for:
```
"Shift-Left Validation", "DevOps for Vibe-Coding", "coding agents only",
"SRE to their DevOps", "reliable as infrastructure"
```

### 5. Update CHANGELOG.md (LOW PRIORITY)

Add a v3.0.0 entry documenting:
- Factor content synced from canonical 12factor repo
- README updated to v3 framing
- Factor VII trimmed (933 → 499 lines)
- Factor I updated with compaction anti-pattern

## Key Principles

- **~/gt/12factor/factors/*.md is the canonical source** for all factor content. The showcase site serves these files — it should never have its own divergent versions.
- **The v3 framing is:** "The Operational Discipline for Working With AI Agents" — knowledge compounds over time, the model isn't the problem, the operations are.
- **Factor VIII (Compound Knowledge) is the hero factor** — the knowledge flywheel that can't be commoditized.
- **Scale factors (X-XII) are optional** — for multi-agent only, solo developers can skip them.
- **Compaction is bad** — automatic context compaction is lossy and uncontrolled. Deliberate summarization is the discipline that prevents it. Factor I now has an explicit anti-pattern about this.

## Verification

After making changes:
1. `cd ~/workspaces/personal/agentops-showcase && npm run build` — verify it builds
2. `npm run test` — verify tests pass
3. Visually check `npm run dev` — homepage renders correctly, factor pages load
4. Search for old factor names — should find zero in active content
5. Diff factor files against canonical: `diff ~/gt/12factor/factors/01-context-is-everything.md docs/factors/01-context-is-everything.md` — should be identical
