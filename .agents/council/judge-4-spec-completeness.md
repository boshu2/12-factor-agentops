# Judge: spec-completeness

## Verdict: WARN
## Confidence: HIGH

## Key Insight
v2 adds GOALS.yaml substance checks but leaves critical Phase 1 boundaries undefined: no archival manifest, no README acceptance criteria, no factor depth specification.

## Findings

### Finding 1: GOALS.yaml Improvements Are Real But Incomplete
- **Severity:** significant
- **Category:** spec-completeness
- **Description:** v2 adds 6 substance checks (Factor I symptoms, Factor VIII flywheel, README quickstart/no-tooling language, Scale tier marking). These are mechanically verifiable and address the v1 "structure not substance" critique. However, they check for *presence* of content snippets, not *completeness* of rewrites. A factor file could contain "observable symptoms" in a single sentence and still pass.
- **Recommendation:** Add minimum word count checks per factor file (e.g., `wc -w factors/01-*.md | awk '{if ($1 < 800) exit 1}'`) to prevent stub files from passing. Add check that each factor contains all required sections (Rule:, Rationale:, What Good Looks Like:, and for I-III: Without Tooling:).
- **Why:** Current checks validate presence of keywords but not depth of content. An implementer could game the checks with minimal stubs.

### Finding 2: README Acceptance Criteria Missing
- **Severity:** critical
- **Category:** spec-completeness
- **Description:** Plan states "Rewrite README" with a 6-section structure (Hero, Pitch, Quickstart, 12 Factors, Go Deeper, Reference Impl) but GOALS.yaml only checks for *absence* of old content and *presence* of "Operational Discipline" tagline. No checks for: (1) knowledge compounding as hero content, (2) 30-second pitch exists, (3) tiered factor structure, (4) quickstart section completeness. An implementer could pass all checks with a 50-word README that says "Operational Discipline for Agents" and nothing else.
- **Recommendation:** Add positive checks for each README section: `grep -q '## 30-Second Pitch\|## The Pitch' README.md`, `grep -q 'quickstart\|5-minute\|getting started' -i README.md`, `grep -q 'Foundation.*Workflow.*Knowledge.*Scale' README.md` (tiering structure), `grep -q 'knowledge compound\|smarter over time\|institutional memory' -i README.md` (hero positioning).
- **Why:** Negative checks prevent regression but don't ensure the new content actually exists. v1 pre-mortem explicitly flagged this (Finding #8).

### Finding 3: Archival Scope Undefined
- **Severity:** significant
- **Category:** spec-completeness
- **Description:** Plan says "Move current factors/ to _archived/factors-v1/ with mapping table" but provides no specification for what the mapping table must contain. What are the columns? Which old factors map to which new ones? Is the collision resolution (old Factor II → new Factor I) documented in the table? Does the archival process preserve git history? An implementer could create an empty directory and claim completion.
- **Recommendation:** Add explicit archival checklist to plan: (1) _archived/factors-v1/ contains all 12 current factor files, (2) _archived/factors-v1/MAPPING.md exists with columns [Old Number, Old Title, New Number, New Title, Content Disposition (rewrite/merge/split)], (3) Factor II collision documented in MAPPING.md, (4) Archive preserves file timestamps via `cp -p`.
- **Why:** "Archive with mapping table" is not mechanically verifiable without a spec for what the table contains. Scope creep risk if implementer interprets differently.

### Finding 4: "Complete Rewrites" Has No Depth Specification
- **Severity:** significant
- **Category:** spec-completeness
- **Description:** Plan states factors need "complete rewrites (not reframes)" and v2 acknowledges pre-mortem finding that current factors are 300-800 lines each. But there's no acceptance criteria for what "complete" means. Must new factors also be 300-800 lines? What's the minimum acceptable depth? The required sections (Rule, Rationale, What Good Looks Like, Without Tooling for I-III) are structural but not depth-bounded.
- **Recommendation:** Add minimum depth criteria: each factor must contain (1) all required sections, (2) minimum 500 words of substantive content (not counting headers/examples), (3) at least 2 concrete examples in "What Good Looks Like", (4) for Factors I-III: "Without Tooling" section demonstrates manual practice without installing anything.
- **Why:** Without depth specification, an implementer could write 150-word factors that technically have all sections but lack the depth the plan acknowledges is necessary (300-800 lines). This becomes a post-merge argument ("I wrote all sections, you didn't say how long").

### Finding 5: Phase 1 Boundary Is Incomplete
- **Severity:** significant
- **Category:** spec-completeness
- **Description:** Plan explicitly excludes marketplace skills, Olympus cross-refs, tutorial rewrites, new tooling from Phase 1. But it *includes* "Resolve Factor I/II collision" which requires reading 200+ lines of old Factor II, deciding what migrates, rewriting Factor I to incorporate it. This is content research + synthesis work that could take 3-6 hours and wasn't listed in the task breakdown. Additionally, the plan says "brief mentions" of Olympus for Scale factors but doesn't define "brief" (one sentence? one paragraph? one example?).
- **Recommendation:** Add explicit constraints: (1) Factor I/II collision resolution = migrate all "40% rule" and "observable symptoms" content from old Factor II to new Factor I (specific content targets), (2) Olympus mentions limited to exactly one sentence per Scale factor (X-XII), (3) no external links beyond AgentOps plugin and Olympus repo in Phase 1.
- **Why:** Vague boundaries create scope disputes during implementation. "Brief mentions" is not mechanically verifiable.

### Finding 6: GOALS.yaml Substance Checks Are Not Exhaustive
- **Severity:** minor
- **Category:** spec-completeness
- **Description:** v2 adds 6 substance checks, addressing v1 critique. But critical plan elements lack checks: (1) Factors I-III "Without Tooling" sections exist, (2) Scale factors (X-XII) marked as "OPTIONAL" or "Advanced Tier", (3) README contains all 6 planned sections, (4) archival mapping table exists. An implementer could skip these and still pass GOALS.yaml.
- **Recommendation:** Add missing checks: `for f in factors/0[1-3]-*.md; do grep -q 'Without [Tt]ooling' "$f" || exit 1; done`, `grep -q 'OPTIONAL\|Advanced' factors/1[0-2]-*.md`, `grep -q '## Hero\|## 30-Second\|## Quickstart\|## The 12 Factors\|## Go Deeper\|## Reference' README.md` (structural sections check), `[ -f _archived/factors-v1/MAPPING.md ]`.
- **Why:** GOALS.yaml is the contract for completion. If critical plan elements aren't checked, they become optional in practice.

## Recommendation

v2 is a meaningful improvement over v1 (substance checks are real progress), but Phase 1 completion remains only 60% mechanically verifiable. Before implementation:

1. Add README section checks to GOALS.yaml (hero, pitch, quickstart, tiering structure)
2. Specify archival manifest columns and add check for `_archived/factors-v1/MAPPING.md` existence
3. Add minimum word count checks per factor (500+ words substantive content)
4. Add "Without Tooling" section checks for Factors I-III
5. Add "OPTIONAL" marking check for Factors X-XII
6. Define "brief Olympus mentions" as exactly 1 sentence per Scale factor

With these additions, a different agent could pick up this plan and know EXACTLY when Phase 1 is done.
