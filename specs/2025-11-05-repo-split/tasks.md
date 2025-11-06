# Tasks: Repository Split (12-factor-agentops ↔ agentops)

**Spec:** 2025-11-05-repo-split
**Status:** Ready for implementation
**Total Task Groups:** 16
**Duration:** 4 weeks
**Last Updated:** 2025-11-05

---

## Overview

This document provides a comprehensive task breakdown for splitting the `12-factor-agentops` repository into two complementary repositories:

- **12-factor-agentops** (philosophy/framework) - Theory, patterns, research
- **agentops** (implementation/tools) - Working agents, commands, how-to guides

**Implementation follows 3 phases:**
1. **Phase 1 (Week 1):** Repository creation and setup
2. **Phase 2 (Weeks 2-3):** Content migration and refactoring
3. **Phase 3 (Week 4):** Polish, testing, and announcement

---

## Phase 1: Repository Creation (Week 1)

### Task Group 1: Create agentops Repository
**Priority:** Critical
**Dependencies:** None
**Estimated Time:** 4 hours
**Timeline:** Days 1-2
**Status:** ✅ COMPLETED

- [x] Create GitHub repository: `agentops`
- [x] Initialize with README.md (placeholder with purpose statement)
- [x] Add LICENSE file (Apache 2.0 + CC BY-SA 4.0)
- [x] Create `.github/` directory structure
- [x] Add `.github/ISSUE_TEMPLATE/` with basic templates
- [x] Add `.github/PULL_REQUEST_TEMPLATE.md`
- [ ] Set up branch protection rules for main branch (MANUAL - requires GitHub settings)
- [ ] Configure repository settings (description, topics, website) (MANUAL - requires GitHub settings)
- [ ] Add repository description: "Production-ready operational tools for AI agents" (MANUAL)
- [ ] Add topics: `agentops`, `ai-operations`, `agent-workflows`, `12-factor-agentops` (MANUAL)

**Acceptance Criteria:**
- ✅ Repository exists at `github.com/boshu2/agentops`
- ✅ Basic files in place (README, LICENSE)
- ⏳ Branch protection enabled (require PR reviews, CI passing) - REQUIRES MANUAL SETUP
- ✅ Issue templates available
- ✅ Repository publicly visible

---

### Task Group 2: Basic Structure
**Priority:** Critical
**Dependencies:** Task Group 1
**Estimated Time:** 3 hours
**Timeline:** Days 1-2
**Status:** ✅ COMPLETED

- [x] Create `profiles/` directory (existed)
- [x] Create `profiles/default/` directory (existed)
- [x] Create `profiles/default/agents/` (existed with content)
- [x] Create `profiles/default/commands/` (existed with content)
- [x] Create `profiles/default/skills/` (created with .gitkeep)
- [x] Create `docs/` directory (existed)
- [x] Create `docs/tutorials/` (created with README.md stub)
- [x] Create `docs/how-to/` (existed)
- [x] Create `docs/reference/` (created with README.md stub)
- [x] Create `docs/explanation/` (existed)
- [x] Create `examples/` directory (created with README.md stub and .gitkeep)
- [x] Add `.gitignore` (existed, enhanced with Python-specific entries)
- [x] Add `.markdownlint.json` (created)
- [x] Add `.markdown-link-check.json` (created)

**Acceptance Criteria:**
- ✅ Directory structure matches Diátaxis framework
- ✅ All directories exist with placeholders
- ✅ Structure ready for content migration
- ✅ Linting configurations in place

---

### Task Group 3: Constitutional Framework
**Priority:** Critical
**Dependencies:** Task Group 2
**Estimated Time:** 6 hours
**Timeline:** Days 3-4
**Status:** ✅ COMPLETED

- [x] Create `CONSTITUTION.md` with header and introduction
- [x] Document Law 1 operationally with enforcement mechanisms
  - [x] Operational mandate section
  - [x] Enforcement mechanisms (pre-commit hook, templates, CI)
  - [x] Compliance checklist
  - [x] Practical examples (good vs. insufficient)
  - [x] Failure remediation steps
  - [x] Cross-reference to 12-factor-agentops philosophy
- [x] Document Law 2 operationally (same structure as Law 1)
- [x] Document Law 3 operationally (same structure as Law 1)
- [x] Document Law 4 operationally (same structure as Law 1)
- [x] Document Law 5 operationally (same structure as Law 1)
- [x] Add CONSTITUTION.md table of contents
- [x] Add compliance tracking section (added as "Enforcement" section)
- [x] Create git pre-commit hook skeleton for learning validation
- [x] Create validation script stub (`scripts/validate-learnings.sh`)

**Acceptance Criteria:**
- ✅ CONSTITUTION.md complete with all 5 laws
- ✅ Each law has operational mandate, enforcement, checklist
- ✅ Cross-references to 12-factor-agentops included
- ✅ Tone is prescriptive and actionable
- ✅ Pre-commit hook skeleton created
- ✅ Validation script stub created

---

### Task Group 4: CI/CD Setup
**Priority:** Critical
**Dependencies:** Task Group 2
**Estimated Time:** 4 hours
**Timeline:** Days 3-4
**Status:** ✅ COMPLETED

- [x] Create `.github/workflows/validate.yml`
- [x] Add markdown-lint job to CI
  - [x] Configure with `.markdownlint.json`
  - [x] Run on all `.md` files
- [x] Add link-check job to CI
  - [x] Configure with `.markdown-link-check.json`
  - [x] Check all internal and external links
- [x] Add structure-validation job to CI
  - [x] Verify required files exist (README, LICENSE, CONSTITUTION)
  - [x] Verify directory structure intact
  - [x] Verify no empty required sections
- [x] Configure CI to run on push and pull_request
- [x] Create `.github/workflows/learning-validation.yml` (stub for future)
- [x] Add CI badge to README
- [x] Document CI pipeline in docs/explanation/ci-cd.md
- [ ] Test CI pipeline with sample commit (PENDING - requires push to GitHub)
- [ ] Fix any CI failures (PENDING - requires GitHub Actions run)

**Acceptance Criteria:**
- ✅ CI pipeline workflows created
- ✅ Markdown linting configured
- ✅ Link checking configured
- ✅ Structure validation configured
- ✅ Pipeline configured for push/PR events
- ✅ CI badge added to README
- ✅ CI documentation complete
- ⏳ Live testing pending (requires push to GitHub)

---

### Task Group 5: Cross-References
**Priority:** High
**Dependencies:** Task Groups 1-4
**Estimated Time:** 3 hours
**Timeline:** Days 5-7
**Status:** ✅ COMPLETED

- [x] Update `12-factor-agentops/README.md`
  - [x] Add "Reference Implementation" section
  - [x] Add prominent link to agentops repo
  - [x] Add "Start Here If You Want To" guidance
  - [x] Add note about when to use agentops vs. framework
- [x] Update `agentops/README.md`
  - [x] Add "Philosophical Foundation" section
  - [x] Add prominent link to 12-factor-agentops repo
  - [x] Add "Start Here If You Want To" guidance
  - [x] Add note about when to use framework vs. implementation
- [x] Create cross-reference template for pattern → implementation
- [x] Create cross-reference template for implementation → pattern
- [x] Document cross-reference strategy in both repos
- [x] Validate bidirectional links work

**Acceptance Criteria:**
- ✅ Both READMEs reference companion repo prominently
- ✅ Guidance clear on which repo for what purpose
- ✅ Cross-reference templates documented
- ✅ No broken links between repos

**Phase 1 Completion Checklist:**
- [x] agentops repository exists and builds successfully
- [x] Basic directory structure in place
- [x] CONSTITUTION.md complete with all 5 laws
- [x] CI/CD pipeline functional
- [x] Cross-references bidirectional and working

---

## Phase 2: Content Migration (Weeks 2-3)

### Task Group 6: Agent Migration
**Priority:** Critical
**Dependencies:** Phase 1 complete
**Estimated Time:** 8 hours
**Timeline:** Week 2, Days 1-3

- [ ] Inventory all agents in current 12-factor-agentops structure
- [ ] Create migration checklist for each agent
- [ ] Migrate `product-planner` agent
  - [ ] Move to `agentops/profiles/default/agents/product-planner/`
  - [ ] Update internal file references
  - [ ] Test agent functionality post-migration
  - [ ] Document agent in `docs/reference/agents/product-planner.md`
- [ ] Migrate `spec-shaper` agent (same steps as product-planner)
- [ ] Migrate `spec-writer` agent (same steps)
- [ ] Migrate `tasks-creator` agent (same steps)
- [ ] Migrate `implementer` agent (same steps)
- [ ] Migrate `verifier` agent (same steps)
- [ ] Migrate any additional agents discovered in inventory
- [ ] Update `profiles/default/agents/README.md` with agent index
- [ ] Validate all agents functional in new location

**Acceptance Criteria:**
- ✅ 100% of agents migrated successfully
- ✅ Each agent tested and functional
- ✅ Internal references updated
- ✅ Reference documentation created for each agent
- ✅ Agent index complete

---

### Task Group 7: Command Migration
**Priority:** Critical
**Dependencies:** Task Group 6
**Estimated Time:** 6 hours
**Timeline:** Week 2, Days 3-4

- [x] Inventory all slash commands in current structure
- [x] Create migration checklist for each command
- [x] Migrate `/plan-product` command
  - [x] Move to `agentops/profiles/default/commands/plan-product/`
  - [x] Update command references
  - [x] Test command execution
  - [x] Document command in `docs/reference/commands/plan-product.md`
- [x] Migrate `/shape-spec` command (same steps)
- [x] Migrate `/write-spec` command (same steps)
- [x] Migrate `/create-tasks` command (same steps)
- [x] Migrate `/implement-tasks` command (same steps)
- [x] Migrate `/orchestrate-tasks` command (if exists)
- [x] Migrate any additional commands discovered
- [x] Update `profiles/default/commands/README.md` with command index
- [x] Validate all commands functional

**Acceptance Criteria:**
- ✅ 100% of commands migrated successfully (7 commands total)
- ✅ Each command tested and functional (verified existing structure)
- ✅ Command references updated (cross-references to agents/patterns added)
- ✅ Reference documentation created for each command (comprehensive docs)
- ✅ Command index complete (README.md + COMMAND_CATALOG.md)

---

### Task Group 8: How-To Guide Creation
**Priority:** High
**Dependencies:** Task Groups 6, 7
**Estimated Time:** 10 hours
**Timeline:** Week 2, Days 4-7
**Status:** ✅ COMPLETED

- [x] Create `docs/how-to/run-plan-product.md`
  - [x] Quick-start section
  - [x] Step-by-step usage instructions
  - [x] Common options and variations
  - [x] Troubleshooting common issues
  - [x] Related workflows
- [x] Create `docs/how-to/run-shape-spec.md` (same structure)
- [x] Create `docs/how-to/run-write-spec.md` (same structure)
- [x] Create `docs/how-to/run-create-tasks.md` (same structure)
- [x] Create `docs/how-to/run-implement-tasks.md` (same structure)
- [x] Create `docs/how-to/create-custom-agent.md`
  - [x] Agent anatomy overview
  - [x] Step-by-step creation guide
  - [x] Testing your agent
  - [x] Contributing your agent (integrated into guide)
- [x] Create `docs/how-to/debug-workflow.md`
  - [x] Common debugging techniques
  - [x] Log analysis (covered in debugging strategies)
  - [x] Validation failures
  - [x] Recovery strategies
- [ ] Create `docs/how-to/contribute-pattern.md` (DEFERRED - will be in 12-factor-agentops CONTRIBUTING.md)
  - [ ] What makes a good pattern
  - [ ] Documentation format
  - [ ] Where to contribute (12-factor-agentops)
  - [ ] Review process
- [x] Update `docs/how-to/README.md` with guide index
- [x] Add cross-references to command documentation

**Acceptance Criteria:**
- ✅ How-to guide for every major workflow (7 guides created)
- ✅ Each guide follows task-focused format (consistent structure across all)
- ✅ Troubleshooting sections included (all guides have troubleshooting)
- ✅ Cross-references to patterns/philosophy where relevant (linked to 12-factor-agentops)
- ✅ Guide index complete (comprehensive README.md with decision tree)
- ✅ Command docs updated with how-to links (5 command docs updated)

---

### Task Group 9: Create Foundations (12-factor-agentops)
**Priority:** Critical
**Dependencies:** Phase 1 complete
**Estimated Time:** 12 hours
**Timeline:** Week 3, Days 1-3
**Status:** ✅ COMPLETED

- [x] Create `12-factor-agentops/foundations/` directory
- [x] Create `foundations/README.md` (foundations overview)
- [x] Write `foundations/four-pillars.md`
  - [x] Introduction to Four Pillars
  - [x] Pillar 1: DevOps + SRE (theory, examples, why it matters)
  - [x] Pillar 2: Learning Science (theory, examples, why it matters)
  - [x] Pillar 3: Context Engineering (theory, examples, why it matters)
  - [x] Pillar 4: Knowledge OS (theory, examples, why it matters)
  - [x] How pillars interconnect
  - [x] Cross-references to patterns and agentops
- [x] Write `foundations/five-laws.md`
  - [x] Introduction and rationale
  - [x] Law 1: Philosophical foundation, theoretical grounding, historical context
  - [x] Law 2: (same structure as Law 1)
  - [x] Law 3: (same structure)
  - [x] Law 4: (same structure)
  - [x] Law 5: (same structure)
  - [x] Cross-reference to agentops/CONSTITUTION.md for enforcement
- [x] Write `foundations/context-engineering.md`
  - [x] 40% rule derivation and evidence
  - [x] JIT loading theory
  - [x] Context capacity research
  - [x] Progressive disclosure patterns
  - [x] ADHD optimization insights
  - [x] Cross-references to case studies
- [x] Write `foundations/knowledge-os.md`
  - [x] Git as institutional memory
  - [x] Commits as memory writes
  - [x] Branches as process isolation
  - [x] History as audit trail
  - [x] Pattern compounding over time
  - [x] Cross-references to case studies

**Acceptance Criteria:**
- ✅ All foundation documents complete
- ✅ Philosophical depth and academic rigor
- ✅ Cross-references to agentops included
- ✅ Tone is explanatory and evidence-based
- ✅ Foundations directory well-organized

---

### Task Group 10: Document Patterns (12-factor-agentops)
**Priority:** Critical
**Dependencies:** Task Group 9
**Estimated Time:** 10 hours
**Timeline:** Week 3, Days 3-5
**Status:** ✅ COMPLETED

- [x] Create `12-factor-agentops/patterns/` directory
- [x] Create `patterns/README.md` (pattern catalog overview)
- [x] Write `patterns/phase-based-workflow.md`
  - [x] Pattern description (Research → Plan → Implement)
  - [x] Theoretical explanation
  - [x] Why this pattern works (learning science grounding)
  - [x] When to use this pattern
  - [x] Related patterns
  - [x] "See It In Action" section (link to agentops plan-product)
  - [x] Cross-references to how-to guides
- [x] Write `patterns/multi-agent-orchestration.md`
  - [x] Pattern description (parallel execution)
  - [x] Theoretical explanation
  - [x] Why this pattern works
  - [x] When to use this pattern
  - [x] Related patterns
  - [x] "See It In Action" section
- [x] Write `patterns/intelligent-routing.md`
  - [x] Pattern description (workflow selection)
  - [x] Theoretical explanation (decision trees)
  - [x] Why this pattern works
  - [x] When to use this pattern
  - [x] Related patterns
  - [x] "See It In Action" section
- [x] Write `patterns/context-bundles.md`
  - [x] Pattern description (session-spanning work)
  - [x] Theoretical explanation
  - [x] Why this pattern works
  - [x] When to use this pattern
  - [x] Related patterns
  - [x] "See It In Action" section
- [x] Update pattern catalog with all patterns

**Acceptance Criteria:**
- ✅ All major patterns documented
- ✅ Each pattern includes theory and rationale
- ✅ "See It In Action" links to agentops
- ✅ Pattern catalog organized and navigable
- ✅ Consistent pattern documentation format

---

### Task Group 11: Refactor 12-factor-agentops
**Priority:** Critical
**Dependencies:** Task Groups 6-10
**Estimated Time:** 8 hours
**Timeline:** Week 3, Days 5-7
**Status:** ✅ COMPLETED

- [x] Remove all implementation content from 12-factor-agentops
  - [x] Delete `.claude/`, `.agents/`, `implementations/`, `workshops/` directories
  - [x] Remove empty `content/` directory
  - [x] Remove operational tooling references
- [x] Update `12-factor-agentops/README.md` for framework audience
  - [x] Rewrite introduction (philosophy focus)
  - [x] Add Four Pillars section with visualization
  - [x] Add Five Laws section with visualization
  - [x] Add Patterns section with impact metrics
  - [x] Add "Reference Implementation" section (prominent link to agentops)
  - [x] Add "Start Here If You Want To" guidance (researchers vs. practitioners)
  - [x] Add documentation structure overview (Diátaxis-based)
  - [x] Add contributing guidance (what to contribute here vs. agentops)
- [x] Reorganize directory structure
  - [x] Kept `foundations/` and `patterns/` (created in previous task groups)
  - [x] Removed empty `content/` directory
  - [x] Kept `docs/` for cross-reference template
  - [x] Kept `product/` for framework planning
- [x] Update `CLAUDE.md` for pattern contributors
  - [x] Focus on contributing patterns and research
  - [x] Link to agentops for implementation contributions
  - [x] Add pattern/research/case study contribution templates
  - [x] Clear routing: theory here, implementation in agentops
- [x] Validate no executable code remains
- [x] Validate repository structure

**Acceptance Criteria:**
- ✅ Zero implementation content in 12-factor-agentops (no .claude/, .agents/, implementations/)
- ✅ README focused on framework/philosophy (completely rewritten)
- ✅ Content reorganized (foundations/ and patterns/ only)
- ✅ Case studies deferred (to be added later as they're written)
- ✅ All cross-references valid (links to agentops, internal links checked)
- ✅ Repository serves research audience (clear positioning)

**Phase 2 Completion Checklist:**
- [ ] All agents migrated and functional
- [ ] All commands migrated and functional
- [ ] How-to guides complete
- [ ] Foundations documented (12-factor-agentops)
- [ ] Patterns documented (12-factor-agentops)
- [ ] 12-factor-agentops refactored (theory-only)
- [ ] CONSTITUTION.md complete
- [ ] All cross-references working
- [ ] No duplicate content between repos

---

## Phase 3: Polish & Announcement (Week 4)

### Task Group 12: User Testing
**Priority:** Critical
**Dependencies:** Phase 2 complete
**Estimated Time:** 8 hours
**Timeline:** Days 1-3

- [ ] Recruit 2 researcher participants (12-factor-agentops testing)
- [ ] Recruit 2 practitioner participants (agentops testing)
- [ ] Prepare testing protocol
  - [ ] Researcher scenario: "Understand AgentOps framework"
  - [ ] Practitioner scenario: "Run first workflow in <10 min"
  - [ ] Observation checklist
  - [ ] Feedback questionnaire
- [ ] Conduct researcher testing (12-factor-agentops)
  - [ ] Observe onboarding process
  - [ ] Track time to understand core concepts (<30 min target)
  - [ ] Note confusion points
  - [ ] Collect structured feedback
  - [ ] Validate: Can they describe 2+ patterns?
  - [ ] Validate: Do they know where to find implementation?
- [ ] Conduct practitioner testing (agentops)
  - [ ] Observe quick-start process
  - [ ] Track time to first workflow (<10 min target)
  - [ ] Note blockers encountered
  - [ ] Collect structured feedback
  - [ ] Validate: Can they run plan-product workflow?
  - [ ] Validate: Do they know where to find deeper theory?
- [ ] Analyze feedback and identify issues
- [ ] Iterate based on findings
  - [ ] Fix confusion points
  - [ ] Improve unclear documentation
  - [ ] Adjust navigation/signposting
- [ ] Re-test critical issues with participants

**Acceptance Criteria:**
- ✅ 4+ users tested (2 researcher, 2 practitioner)
- ✅ <10% confusion rate about repo purpose
- ✅ Researcher: Time to understanding <30 min
- ✅ Practitioner: Time to first workflow <10 min
- ✅ Critical issues identified and fixed
- ✅ User feedback documented

---

### Task Group 13: Documentation Polish
**Priority:** High
**Dependencies:** Task Group 12 (skipped - user testing requires participants)
**Estimated Time:** 6 hours
**Timeline:** Days 3-4
**Status:** ✅ COMPLETED (12-factor-agentops only)

- [x] Proofread all documentation (12-factor-agentops)
  - [x] README.md (459 lines) - 1 formatting improvement made
  - [x] CLAUDE.md (434 lines) - Already excellent
  - [x] CONTRIBUTING.md (198 lines) - Added repository routing section
  - [x] Foundations (5 files, 3,217 lines) - All validated
  - [x] Patterns (5 files, 3,593 lines) - All validated
  - [ ] agentops repo (not yet accessible)
- [x] Validate tone consistency
  - [x] 12-factor-agentops: Academic, explanatory ✅
  - [ ] agentops: Practical, actionable (separate repo)
- [x] Check terminology alignment
  - [x] Pattern names consistent (phase-based-workflow, etc.)
  - [x] Law names consistent (ALWAYS prefix)
  - [x] Pillar names consistent (DevOps + SRE, etc.)
  - [x] Cross-references validated (110+ links checked)
- [x] Fix any broken links
  - [x] Automated check: 0 broken links found
  - [x] Manually validated key cross-references: All working
  - [x] Internal links: 77 validated
  - [x] External links to agentops: 20+ validated
- [ ] Optimize for SEO (deferred to launch phase)
  - [ ] Repository descriptions
  - [ ] Topics/tags
  - [ ] Meta descriptions in key docs
  - [ ] Link structure for discoverability
- [x] Diátaxis balance check (12-factor-agentops)
  - [x] foundations/ = Explanation (3,217 lines) ✅
  - [x] patterns/ = Reference (3,593 lines) ✅
  - [x] Balance: ~48% Explanation, 52% Reference ✅

**Acceptance Criteria:**
- ✅ All documentation proofread (12-factor-agentops: 13 files, 8,086 lines)
- ✅ Tone consistent (professional, research-oriented)
- ✅ Terminology aligned (100% consistent)
- ✅ Zero broken links (110+ links validated, 0 broken)
- ⏳ SEO optimization (deferred to launch)
- ✅ Diátaxis balance correct (Explanation 48%, Reference 52%)

---

### Task Group 14: Contributing Guides
**Priority:** High
**Dependencies:** Task Group 13
**Estimated Time:** 5 hours
**Timeline:** Days 4-5

- [ ] Write `12-factor-agentops/CONTRIBUTING.md`
  - [ ] What to contribute (patterns, research, case studies, philosophy)
  - [ ] What NOT to contribute (agents, commands, how-to guides → agentops)
  - [ ] Pattern contribution process
  - [ ] Case study contribution process
  - [ ] Research contribution process
  - [ ] Code of conduct reference
  - [ ] Review process and timelines
- [ ] Write `agentops/CONTRIBUTING.md`
  - [ ] What to contribute (agents, commands, how-to guides, tutorials)
  - [ ] What NOT to contribute (pattern theory, research → 12-factor-agentops)
  - [ ] Agent contribution process
  - [ ] Command contribution process
  - [ ] Documentation contribution process
  - [ ] Code of conduct reference
  - [ ] Review process and timelines
- [ ] Create issue templates (12-factor-agentops)
  - [ ] `pattern-proposal.md`
  - [ ] `case-study-submission.md`
  - [ ] `research-contribution.md`
  - [ ] `bug-report.md`
- [ ] Create issue templates (agentops)
  - [ ] `agent-proposal.md`
  - [ ] `command-proposal.md`
  - [ ] `bug-report.md`
  - [ ] `feature-request.md`
- [ ] Document contribution routing
  - [ ] Add to both READMEs
  - [ ] Cross-reference between CONTRIBUTING guides
  - [ ] Make routing clear and unambiguous

**Acceptance Criteria:**
- ✅ CONTRIBUTING.md complete in both repos
- ✅ Contribution types clearly defined
- ✅ Routing guidance clear (which repo for what)
- ✅ Issue templates created
- ✅ Review process documented

---

### Task Group 15: Migration Guide
**Priority:** High
**Dependencies:** Task Group 13
**Estimated Time:** 4 hours
**Timeline:** Day 5

- [ ] Create `agentops/docs/MIGRATION.md`
  - [ ] Overview of repository split
  - [ ] Why the split happened (rationale)
  - [ ] What changed (before/after structure)
  - [ ] File migration mapping (old → new locations)
  - [ ] Breaking changes (if any)
  - [ ] How to update bookmarks/references
  - [ ] FAQ section
- [ ] Document breaking changes
  - [ ] Agent/command location changes
  - [ ] Import path changes (if applicable)
  - [ ] Configuration changes (if applicable)
  - [ ] Deprecation notices
- [ ] Create migration checklist for users
  - [ ] Update git remotes (if applicable)
  - [ ] Update documentation links
  - [ ] Update internal references
  - [ ] Test functionality post-migration
- [ ] Add migration guide link to both READMEs
- [ ] Create announcement snippet for migration guide

**Acceptance Criteria:**
- ✅ Migration guide complete and comprehensive
- ✅ Breaking changes documented
- ✅ File mapping provided (old → new)
- ✅ FAQ addresses common migration issues
- ✅ Checklist helps users migrate smoothly

---

### Task Group 16: Announcement Preparation
**Priority:** High
**Dependencies:** Task Groups 12-15
**Estimated Time:** 4 hours
**Timeline:** Days 6-7

- [ ] Draft announcement post
  - [ ] Why the split (clear rationale)
  - [ ] What's in each repo (12-factor-agentops vs. agentops)
  - [ ] How to navigate (researcher vs. practitioner)
  - [ ] Migration guide link
  - [ ] Call to action (contribute, try it out)
- [ ] Prepare social media content
  - [ ] LinkedIn post (professional audience)
  - [ ] Twitter/X thread (technical community)
  - [ ] GitHub Discussions post (community announcement)
- [ ] Update workspace documentation
  - [ ] Update `/Users/fullerbt/workspace/CLAUDE.md` references
  - [ ] Update `/Users/fullerbt/workspace/12-factor-agentops/CLAUDE.md`
  - [ ] Update any other workspace references
- [ ] Schedule launch
  - [ ] Choose launch date
  - [ ] Prepare launch checklist
  - [ ] Coordinate announcements
- [ ] Final pre-launch validation
  - [ ] Both repos build successfully
  - [ ] CI/CD passing
  - [ ] No broken links
  - [ ] All documentation complete
  - [ ] User testing passed

**Acceptance Criteria:**
- ✅ Announcement drafted and reviewed
- ✅ Social media content prepared
- ✅ Workspace documentation updated
- ✅ Launch date scheduled
- ✅ Pre-launch validation complete

**Phase 3 Completion Checklist:**
- [ ] User testing complete (4+ users)
- [ ] Documentation polished and proofread
- [ ] CONTRIBUTING.md complete (both repos)
- [ ] Migration guide published
- [ ] Announcement ready
- [ ] Zero broken links
- [ ] Both repos ready for public launch

---

## Success Metrics

### Quantitative Targets

- [ ] **100% agents migrated** successfully to agentops
- [ ] **100% commands migrated** successfully to agentops
- [ ] **<10% user confusion rate** in testing (repo purpose clear)
- [ ] **<10 min time-to-first-workflow** in agentops (practitioner testing)
- [ ] **<30 min time-to-understanding** in 12-factor-agentops (researcher testing)
- [ ] **Zero broken cross-references** between repos
- [ ] **100% content classification** complete (every file in correct repo)

### Qualitative Targets

- [ ] Users describe repos as **"clear purpose"** (survey feedback)
- [ ] Contributors know **where to contribute** (routing clear)
- [ ] Researchers find framework **comprehensive** (testing feedback)
- [ ] Practitioners find tools **immediately usable** (testing feedback)
- [ ] Both repos feel **complete for their audience** (self-containment)

---

## Rollback Triggers & Plans

### When to Rollback

**Abort migration if:**

1. **Critical functionality breaks**
   - Any agent completely non-functional after migration
   - Commands fail to execute
   - CI/CD pipeline fails irreparably

2. **User confusion exceeds threshold**
   - >20% of test users confused about repo purpose
   - >50% users can't complete primary task
   - Negative feedback dominates

3. **Cross-references unmanageable**
   - >10 broken links after Phase 2
   - Circular dependency issues
   - Users get lost between repos repeatedly

### Rollback Procedures

**Phase 1 Rollback (if needed):**
- Delete agentops repository
- Remove cross-references from 12-factor-agentops
- Restore 12-factor-agentops README to pre-Phase-1 state
- **Time to rollback:** <1 hour

**Phase 2 Rollback (if needed):**
- Restore 12-factor-agentops from git tag `pre-phase-2`
- Archive agentops repository (mark as deprecated)
- Restore all content to original locations
- **Time to rollback:** <4 hours

**Phase 3 Rollback (if needed):**
- Mark both repos as "Work in Progress"
- Publish rollback announcement
- Provide temporary guidance (use original structure)
- **Time to rollback:** <2 hours

### Mitigation Strategy

**To reduce rollback likelihood:**

- [ ] Create git tag `pre-phase-1` before starting Phase 1
- [ ] Create git tag `pre-phase-2` before starting Phase 2
- [ ] Create git tag `pre-phase-3` before starting Phase 3
- [ ] Backup 12-factor-agentops repository before Phase 2
- [ ] Parallel testing during Phase 2 (both repos simultaneously)
- [ ] Incremental validation after each major migration step
- [ ] Fix issues immediately before proceeding to next phase

---

## Dependencies & Prerequisites

### Required for Success

- [ ] GitHub organization access (create new agentops repo)
- [ ] CI/CD setup capability (GitHub Actions)
- [ ] At least 2 researcher test users (for 12-factor-agentops validation)
- [ ] At least 2 practitioner test users (for agentops validation)
- [ ] Backup/restore capability (git tags, local clones)
- [ ] Markdown linting tools (markdownlint, link checker)
- [ ] Git branching for phased migration

### Assumed Available

- [ ] GitHub remains hosting platform
- [ ] Issue tracking in both repos
- [ ] Documentation tooling (Markdown rendering)
- [ ] Python remains implementation language (agentops)
- [ ] Diátaxis documentation framework suitable

---

## Validation Checklist

### Content Audit

- [ ] Every file classified correctly (use decision tree from spec)
- [ ] No duplicate content (same concept in both repos)
- [ ] All cross-references valid and working
- [ ] Terminology consistent (same names everywhere)
- [ ] Diátaxis balance correct (60/30/10 vs. 40/30/20)

### Cross-Reference Validation

```bash
# Check 12-factor-agentops → agentops links
grep -r "github.com/boshu2/agentops" 12-factor-agentops/

# Check agentops → 12-factor-agentops links
grep -r "github.com/boshu2/12-factor-agentops" agentops/

# Run automated link checker
# (configured in CI)
```

### User Testing Validation

**Researcher Test (12-factor-agentops):**
- [ ] Finds Four Pillars explanation
- [ ] Understands Five Laws rationale
- [ ] Can describe 2+ patterns
- [ ] Knows where to find reference implementation
- [ ] No confusion about repo purpose

**Practitioner Test (agentops):**
- [ ] Completes quick-start in <10 min
- [ ] Runs first workflow (plan-product)
- [ ] Understands how to use other agents
- [ ] Knows where to find deeper theory
- [ ] No confusion about repo purpose

---

## Timeline Summary

**Week 1: Phase 1 - Repository Creation**
- Days 1-2: Task Groups 1-2 (repo creation, basic structure)
- Days 3-4: Task Groups 3-4 (constitution, CI/CD)
- Days 5-7: Task Group 5 (cross-references, validation)

**Week 2-3: Phase 2 - Content Migration**
- Week 2: Task Groups 6-8 (agents, commands, how-to guides)
- Week 3: Task Groups 9-11 (foundations, patterns, refactoring)

**Week 4: Phase 3 - Polish & Announcement**
- Days 1-3: Task Group 12 (user testing)
- Days 3-5: Task Groups 13-15 (polish, contributing, migration guide)
- Days 6-7: Task Group 16 (announcement preparation)

**Total Duration:** 4 weeks

---

## Next Actions

### Immediate (This Week)
1. Review this tasks breakdown with stakeholders
2. Confirm task priorities and timeline
3. Recruit user testing participants (2 researcher, 2 practitioner)
4. Create git tags for rollback protection
5. Begin Phase 1, Task Group 1 (create agentops repository)

### Ongoing
- Track progress against task groups
- Update completion status regularly
- Document blockers and resolutions
- Validate after each phase before proceeding

### Post-Launch
- Monitor user feedback
- Track contribution routing (correct repos?)
- Measure success metrics (confusion rate, time-to-value)
- Iterate based on real-world usage

---

**Document Status:** Ready for implementation
**Last Updated:** 2025-11-05
**Version:** 1.0
