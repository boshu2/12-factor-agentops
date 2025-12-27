---
date: 2025-12-27
type: Research
topic: "Sync agentops-showcase website with v2.0 factor updates"
tags: [research, website, showcase, sync, implementation-patterns]
status: COMPLETE
---

# Research: agentops-showcase Website Sync

**Created:** 2025-12-27
**Goal:** Update agentops-showcase website to display new Implementation Patterns sections

---

## Executive Summary

The agentops-showcase website is already fully configured to display the new Implementation Patterns sections. **No code changes are required.** The factor markdown files have already been synced (commit `30b2e8f`), and the website's MDX processing pipeline automatically renders all markdown content including the new sections.

**Recommendation:** Verify the build succeeds and preview the rendered output. The website is ready.

---

## Current State

### What Exists

The agentops-showcase is a Next.js 15 static site that renders factor documentation:

```
12-factor-agentops/factors/ → (synced) → agentops-showcase/docs/factors/
                                              ↓
                               src/lib/factors.ts (loads markdown)
                                              ↓
                               MDXRemote (remark-gfm, rehype-highlight, rehype-slug)
                                              ↓
                               src/components/MDXComponents.tsx (renders)
                                              ↓
                               src/app/factors/[slug]/page.tsx (displays)
```

### Key Files

| File | Purpose | Relevance |
|------|---------|-----------|
| `src/lib/factors.ts` | Loads and transforms markdown | Handles all markdown generically |
| `src/components/MDXComponents.tsx` | Custom React components for MDX | Supports h2, h3, tables, code, lists |
| `src/app/factors/[slug]/page.tsx` | Factor page template | Uses MDXRemote with rehype plugins |
| `src/components/TableOfContents.tsx` | Dynamic TOC from DOM | Auto-discovers h2/h3 headings |
| `docs/factors/*.md` | Factor markdown files | **Already synced** with v2.0 content |

### Sync Status

Factors were synced in commit `30b2e8f` (2025-12-27):
- 13 files changed, +8,824/-4,607 lines
- All 12 factors now include Implementation Patterns sections
- Build verified successful

---

## Findings

### Finding 1: No Code Changes Required

The Implementation Patterns sections are **standard markdown** (h2/h3 headings, tables, code blocks, lists). The existing MDX pipeline processes them identically to other content:

```markdown
## Implementation Patterns              → <h2 id="implementation-patterns">
### Pattern 1: Event-Driven Activation  → <h3 id="pattern-1-event-driven...">
| Column | Data |                       → <table>...</table>
```

**Evidence:** `src/lib/factors.ts:cleanContent()` transforms Vue syntax but passes through standard markdown unchanged.

### Finding 2: Table of Contents Auto-Updates

The TableOfContents component (`src/components/TableOfContents.tsx:40-60`) scans the rendered DOM for `h2` and `h3` elements:

```typescript
const headings = article.querySelectorAll("h2, h3");
headings.forEach((heading) => {
  if (heading.id) {
    items.push({
      id: heading.id,
      text: heading.textContent,
      level: heading.tagName === "H2" ? 2 : 3,
    });
  }
});
```

**Evidence:** `rehypeSlug` plugin (line 145, page.tsx) auto-generates IDs for all headings.

### Finding 3: All Content Types Supported

The MDXComponents configuration supports everything in Implementation Patterns:

| Content Type | Component | Status |
|--------------|-----------|--------|
| h2/h3 headings | Custom with Tailwind | ✅ |
| Tables | table, th, td components | ✅ |
| Code blocks | CodeBlock with highlight.js | ✅ |
| Inline code | Custom with bg-neutral-800 | ✅ |
| Lists | ul, ol, li components | ✅ |
| Callout boxes | Callout component | ✅ |

---

## Constraints

| Constraint | Impact | Mitigation |
|------------|--------|------------|
| Static export | No runtime markdown processing | Pre-build generates all pages |
| docs/philosophy in .gitignore | Can't sync pattern-heritage.md | Intentional - internal docs |
| Build verification | Must pass TypeScript + ESLint | Already verified |

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Long pages cause performance issues | Low | Medium | TOC provides navigation; lazy loading if needed |
| New markdown syntax breaks rendering | Very Low | High | All syntax is standard markdown, no Vue/VitePress directives |
| TOC becomes too long | Low | Low | Collapsible TOC already implemented |

---

## Verification

### Build Status
```
✓ TypeScript types valid
✓ ESLint passed
✓ Production build succeeds
✓ 17 static pages generated
```

### Manual Verification Needed

1. **Preview Factor III** - Verify Implementation Patterns section renders
2. **Check TOC** - Verify "Implementation Patterns" appears in sidebar
3. **Test code blocks** - Verify syntax highlighting works on Go/YAML examples
4. **Test tables** - Verify pattern tables render correctly
5. **Test mobile** - Verify TOC toggle works with longer content

---

## Recommendation

**Approach:** No development work required. Deploy the already-synced content.

**Why:**
- Factors already synced (commit `30b2e8f`)
- Build already passes
- MDX pipeline handles all markdown generically
- TOC auto-discovers new sections

**Verification Steps:**
1. Run `npm run dev` to preview locally
2. Check `/factors/03-focused-agents` for Implementation Patterns
3. Verify TOC includes new sections
4. Deploy to production

**Alternatives Considered:**
1. Add special styling for Implementation Patterns - Rejected (unnecessary, standard sections work)
2. Create dedicated Implementation Patterns pages - Rejected (breaks factor document continuity)

---

## Action Items

| Action | Status | Notes |
|--------|--------|-------|
| Sync factor markdown | ✅ Complete | Commit 30b2e8f |
| Build verification | ✅ Complete | All checks pass |
| Local preview | ⏳ Pending | Run `npm run dev` |
| Production deploy | ⏳ Pending | Vercel auto-deploys on push |

---

## Next Steps

No `/plan` needed - the sync is already complete:

1. ~~Sync factors to showcase~~ ✅ Done
2. ~~Verify build~~ ✅ Done
3. Preview locally (optional manual verification)
4. Production auto-deploys via Vercel

---

**Output:** .agents/research/2025-12-27-agentops-showcase-sync.md
