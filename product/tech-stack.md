# Tech Stack

**Framework:** 12-Factor AgentOps (documentation framework, not software product)
**Last Updated:** 2025-11-05

---

## Philosophy

12-Factor AgentOps is a **documentation-based framework**, not a software product. The "tech stack" consists primarily of:
- Documentation formats and tools
- Community engagement platforms
- Publishing and distribution mechanisms
- Content creation and management systems

**Core principle:** Keep it simple. Avoid unnecessary tooling. Focus on content quality over infrastructure complexity.

---

## Documentation Format & Standards

### Primary Format: Markdown

**Tool:** GitHub-flavored Markdown (GFM)
**Files:** `.md` extension throughout repository

**Rationale:**
- Universal readability (GitHub, VS Code, web browsers, etc.)
- Version control friendly (clear diffs)
- No build process required
- Platform-independent
- Future-proof plain text format
- Community familiar (low barrier to contribution)

**Standards followed:**
- Consistent heading hierarchy (# → ## → ###)
- Code blocks with language hints (```bash, ```yaml, etc.)
- Mermaid diagrams for visual content
- Tables for structured comparisons
- Admonitions (GitHub alerts: `> [!NOTE]`, `> [!IMPORTANT]`)

### Documentation Framework: Diátaxis

**Framework:** [Diátaxis](https://diataxis.fr/) (documentation architecture)
**Structure:** Learning-oriented, goal-oriented, understanding-oriented, information-oriented

**Applied to 12-Factor AgentOps:**
- **Tutorials:** Hands-on workshops (future in `workshops/`)
- **How-to guides:** Pattern implementations (in `content/patterns/`)
- **Explanation:** Factor deep-dives (in `content/factors/`)
- **Reference:** Quick lookups, tables, indexes (in `content/foundations/`)

**Rationale:**
- Proven framework for technical documentation
- User-centric organization (find what you need quickly)
- Clear separation of documentation types
- Scales as content grows
- Familiar to technical audiences

### Diagrams: Mermaid.js

**Tool:** [Mermaid.js](https://mermaid.js.org/) (text-based diagrams)
**Formats:** Flowcharts, mindmaps, timelines, graphs

**Examples in use:**
- Four Pillars mindmap (README.md)
- Five Laws workflow (README.md)
- Intersection diagram (README.md)
- Timeline roadmap (README.md)

**Rationale:**
- Text-based (version control friendly)
- Renders natively in GitHub
- No external image files to manage
- Easy to update and iterate
- Accessible (screen readers can parse)

**Configuration:**
- Light color themes for accessibility
- High contrast borders (black `#000`)
- Consistent color palette across diagrams
- Clear node labels (concise, readable)

---

## Repository & Version Control

### Platform: GitHub

**Repository:** [12-factor-agentops](https://github.com/boshu2/12-factor-agentops) (public)
**Organization:** Personal account (boshu2)

**Rationale:**
- Industry standard for open source
- Excellent collaboration features (issues, discussions, PRs)
- Free for public repositories
- Strong community presence
- Integrated tools (Actions, Pages, etc.)

**Repository structure:**
```
12-factor-agentops/
├── README.md                 # Framework overview (entry point)
├── CLAUDE.md                 # AgentOps principles & contributing guide
├── CONTRIBUTING.md           # Community contribution guidelines
├── LICENSE                   # Apache 2.0 (code) + CC BY-SA 4.0 (docs)
├── ROADMAP.md                # Phased development plan
├── VALIDATION_CRITERIA.md    # Advancement criteria per phase
├── POSITIONING.md            # Tone/style master reference
├── EARLY_TESTER_GUIDE.md     # Beta collaborator onboarding
├── LAUNCH_CHECKLIST.md       # Launch preparation tracker
├── product/                  # Product planning (this directory)
│   ├── mission.md
│   ├── roadmap.md
│   └── tech-stack.md
├── content/                  # Framework content
│   ├── factors/              # 12-factor deep-dives
│   ├── patterns/             # Reusable pattern library
│   └── foundations/          # Core concepts
├── implementations/          # Reference implementations
└── workshops/                # Hands-on learning materials
```

**Rationale:**
- Clear information hierarchy
- Progressive disclosure (start with README)
- Logical grouping by purpose
- Easy navigation for contributors
- Scales as content grows

### Version Control: Git

**Workflow:** GitHub Flow (simplified)
- `main` branch is always deployable
- Feature branches for significant changes
- Pull requests for review
- Merge to main when ready

**Commit conventions:**
- Semantic commits: `feat:`, `fix:`, `docs:`, `chore:`
- Clear, descriptive commit messages
- Reference issues when applicable

**Rationale:**
- Simple workflow for documentation project
- Clear history of changes
- Easy to revert if needed
- Familiar to contributors

---

## Licensing

### Dual License Model

**Code:** Apache 2.0 License
- Permissive open source license
- Commercial use allowed
- Attribution required
- Patent grant included

**Documentation/Content:** CC BY-SA 4.0 (Creative Commons Attribution-ShareAlike)
- Share and adapt freely
- Attribution required
- Share-alike (derivatives under same license)
- Commercial use allowed

**Rationale:**
- Standard for open source projects
- Protects content while enabling reuse
- Clear expectations for contributors
- Encourages derivative works
- No barriers to adoption

**License file:** [LICENSE](../LICENSE) (combined, clearly separated)

---

## Community Tools

### GitHub Issues

**Purpose:** Bug reports, feature requests, questions, discussions

**Configuration:**
- Issue templates (planned for Beta)
- Labels for categorization (bug, enhancement, question, pattern, etc.)
- Milestones for phase tracking (Alpha, Beta, v1.0)

**Rationale:**
- Built into GitHub (no extra tools)
- Searchable and linkable
- Notification system
- Community can self-organize

### GitHub Discussions

**Purpose:** Long-form conversations, pattern sharing, community Q&A

**Configuration:**
- Categories: Ideas, Patterns, Q&A, Show and Tell, General
- Pinned discussions for important topics
- Polls for community input (if needed)

**Rationale:**
- Separate from issues (discussions vs. tasks)
- Community-friendly interface
- Built-in upvoting
- Better for open-ended conversations

### LinkedIn (Primary Social Platform)

**Purpose:** Content sharing, network building, professional engagement

**Strategy:**
- 1-2 posts per week (sustainable cadence)
- Problem-first framing (not hype)
- Authentic voice (explorer, not guru)
- Engagement in comments (build relationships)

**Rationale:**
- Professional network (target audience)
- Visibility for career goals (NVIDIA, consulting)
- Platform for thought leadership
- Engagement drives discovery

**Content types:**
- Framework announcements (launches, milestones)
- Pattern deep-dives (technical posts)
- Case studies (success stories)
- Lessons learned (failures and adaptations)
- Community highlights (contributor recognition)

### Email Newsletter (Secondary Channel)

**Purpose:** Deeper updates, long-form content, curated learnings

**Platform:** TBD (options: Substack, Ghost, Buttondown)
**Cadence:** Bi-weekly or monthly (low pressure)

**Rationale:**
- Direct communication with engaged audience
- Less ephemeral than social media
- Better for long-form content
- Builds owned audience (not platform-dependent)

**Not yet implemented:** Planned for Beta if community engagement warrants

### Discord/Slack (Optional Real-Time Community)

**Purpose:** Real-time discussions, community bonding, quick questions

**Platform:** TBD (Discord or Slack)
**Status:** Not implemented (post-launch decision)

**Rationale for considering:**
- Real-time community engagement
- Faster feedback loops
- Community self-organization
- Social bonding (not just technical)

**Rationale for deferring:**
- Adds moderation burden
- Fragments communication
- Async-first is more inclusive (time zones, schedules)
- Wait until community size warrants it

---

## Content Creation Tools

### Writing: Plain Text Editors

**Primary:** VS Code, Neovim, or any text editor
**Format:** Markdown (`.md` files)

**Rationale:**
- Simple, distraction-free writing
- Syntax highlighting for Markdown
- Git integration
- No vendor lock-in
- Fast and lightweight

### AI Assistance: Claude Code / Claude.ai

**Purpose:** Content refinement, brainstorming, editing, structure

**Usage:**
- Drafting initial content outlines
- Refining phrasing and clarity
- Identifying gaps in documentation
- Generating examples and diagrams
- Proofreading and consistency checks

**Transparency:**
- Framework built using AI agents (Claude Code)
- Documented in README: "Built with AI Agents"
- Practicing what we document (AgentOps principles)

**Rationale:**
- Speed and iteration efficiency
- Consistency in tone and style
- Pattern recognition for structure
- Dogfooding AgentOps principles
- Honest about AI assistance (transparency)

### Visual Assets: Mermaid + Simple Graphics

**Diagrams:** Mermaid.js (text-based, rendered by GitHub)
**Other visuals:** TBD if needed (badges, screenshots, etc.)

**Current assets:**
- Badges (status, license)
- Mermaid diagrams (mindmaps, flowcharts, timelines)
- No custom graphics yet (keep simple)

**Rationale:**
- Text-based diagrams are version-control friendly
- GitHub renders automatically (no build step)
- Accessible (screen readers can parse text)
- Easy to update and maintain

---

## Publishing & Distribution

### GitHub Repository (Primary)

**URL:** https://github.com/boshu2/12-factor-agentops
**Visibility:** Public
**Hosting:** GitHub Pages (optional, not yet implemented)

**Content delivery:**
- Directly via GitHub web interface
- Clone/fork for offline reading
- Raw Markdown accessible
- Rendered automatically by GitHub

**Rationale:**
- Zero build process required
- Fast publishing (commit and push)
- Community can fork and adapt
- Searchable via GitHub search
- No hosting costs

### GitHub Pages (Optional Static Site)

**Status:** Not implemented (deferred to Beta if needed)
**Generator:** TBD (options: Jekyll, Hugo, MkDocs)

**Potential benefits:**
- Custom domain possible
- Better navigation (sidebar, search)
- Cleaner reading experience
- Analytics (if needed)

**Why deferred:**
- Adds build complexity
- GitHub rendering is sufficient for now
- Can add later without disruption
- Focus on content, not presentation

### Social Media (LinkedIn Primary)

**Platform:** LinkedIn (professional network)
**Cadence:** 1-2 posts per week
**Content:** Framework updates, patterns, case studies, learnings

**Strategy:**
- Problem-first framing (not hype)
- Authentic voice (explorer mindset)
- Engage in comments (build relationships)
- Share community contributions

**Rationale:**
- Reach target audience (operations practitioners, AI teams)
- Build professional network
- Visibility for career goals
- Thought leadership platform

**Other platforms:**
- Twitter/X: Considered but lower priority
- Reddit: Possible for r/devops, r/MachineLearning (organic, not spammy)
- Hacker News: Share if genuinely relevant (no self-promotion spam)
- Dev.to: Cross-post technical deep-dives (if warranted)

---

## Development Tools

### Text Editor / IDE

**Options:** VS Code, Neovim, Sublime, any Markdown-friendly editor
**Extensions:** Markdown preview, spell check, Git integration

**Rationale:**
- Simple text editing needs
- No special tooling required
- Contributor-friendly (any editor works)

### Git Client

**Options:** Command-line Git, GitHub Desktop, GitKraken, etc.
**Workflow:** GitHub Flow (main + feature branches)

**Rationale:**
- Version control is essential
- Familiar to technical contributors
- Clear change history

### Link Checking (Future)

**Tool:** TBD (markdown-link-check or similar)
**Purpose:** Ensure internal/external links don't break

**Status:** Not implemented yet
**When:** Add during Beta when link volume grows

### Spell Check / Grammar

**Tool:** Basic spell check in editor
**Optional:** Grammarly, LanguageTool (if desired)

**Rationale:**
- Quality documentation requires clean writing
- Catch typos and clarity issues
- Low-overhead quality gate

---

## Validation & Quality Tools

### Markdown Linting (Future)

**Tool:** markdownlint or similar
**Purpose:** Consistent Markdown style

**Status:** Not implemented yet
**When:** Add if inconsistencies emerge

**Rationale:**
- Keeps Markdown clean
- Easier to read and maintain
- Prevents rendering issues

### Link Validation (Future)

**Tool:** markdown-link-check or GitHub Actions
**Purpose:** Detect broken links

**Status:** Not implemented yet
**When:** Add during Beta when link volume grows

### CI/CD: GitHub Actions (Future)

**Purpose:** Automated validation on commits
**Possible workflows:**
- Markdown linting
- Link checking
- Spell checking
- Build test (if static site added)

**Status:** Not implemented yet
**When:** Add when quality issues justify automation

**Rationale:**
- Automated quality gates
- Catch issues before merge
- Consistent contributor experience
- No manual validation burden

---

## Analytics (Deferred)

### GitHub Insights (Built-in)

**Available:** Stars, forks, traffic, clones, popular content
**Use:** Basic understanding of usage

**Rationale:**
- No setup required
- Basic metrics sufficient for now
- Avoid vanity metric obsession

### Google Analytics (Not Planned)

**Status:** Not implementing
**Rationale:** Privacy concerns, adds complexity, not needed for Alpha/Beta

**Alternative:** GitHub traffic insights sufficient

### Community Feedback (Qualitative)

**Primary metric:** Quality of feedback, not quantity
**Sources:** Issues, discussions, emails, beta collaborators

**Rationale:**
- Learning over metrics
- Quality engagement over traffic
- Real feedback drives improvement
- Avoid vanity metric optimization

---

## Roadmap for Tech Stack Evolution

### Alpha Phase (Current)
- ✅ GitHub repository (public)
- ✅ Markdown documentation
- ✅ Mermaid diagrams
- ✅ GitHub issues/discussions
- ✅ LinkedIn content sharing
- ⏳ Beta collaborator recruitment

### Beta Phase (Future)
- [ ] Issue templates for feedback
- [ ] GitHub Discussions structured categories
- [ ] Email newsletter (optional)
- [ ] Link validation (CI/CD)
- [ ] Markdown linting (quality gate)
- [ ] GitHub Pages static site (optional)

### v1.0 Phase (Future)
- [ ] Full CI/CD quality pipeline
- [ ] Contributor documentation (templates, guides)
- [ ] Community governance structure
- [ ] Multi-language support (if community-driven)
- [ ] Workshops/hands-on materials

---

## Principles Governing Tech Choices

**Simplicity first:**
- Avoid unnecessary tooling
- Prefer built-in GitHub features
- No build process unless essential
- Plain text over proprietary formats

**Contributor-friendly:**
- Low barrier to entry
- Familiar tools (Git, Markdown, GitHub)
- Clear documentation of process
- No special software required

**Future-proof:**
- Plain text formats (Markdown)
- Open standards (Git, Mermaid)
- Portable (not locked to platforms)
- Degrades gracefully (raw Markdown readable)

**Quality over quantity:**
- Content quality matters most
- Avoid metric obsession
- Automated quality gates when needed
- Human review for critical content

**Sustainable:**
- Tools author can maintain alone if needed
- Low ongoing cost (free tier usage)
- Minimal moderation burden
- Scales with community growth

---

## What We're NOT Using (And Why)

### Static Site Generators (Yet)
**Why not:** Adds build complexity, GitHub rendering sufficient for now
**When:** Consider in Beta if navigation/search becomes critical

### Complex CMS
**Why not:** Overkill for Markdown documentation, adds vendor lock-in
**When:** Never planned (plain text principle)

### Notion / Proprietary Docs
**Why not:** Not open source, not version-control friendly, platform lock-in
**When:** Never planned (open source commitment)

### Dedicated Forums (Discourse, etc.)
**Why not:** Fragments community, adds moderation burden, GitHub Discussions sufficient
**When:** Only if community explicitly requests and commits to moderating

### Commercial Support Tools (Zendesk, Intercom, etc.)
**Why not:** This is not a commercial product, no support SLAs
**When:** Never planned (community support only)

### Advanced Analytics (Mixpanel, Amplitude, etc.)
**Why not:** Vanity metrics, privacy concerns, not needed for documentation framework
**When:** Never planned (qualitative feedback > quantitative metrics)

---

## Tech Stack Summary

| Category | Tool/Platform | Status | Rationale |
|----------|---------------|--------|-----------|
| **Documentation Format** | Markdown (GFM) | ✅ Active | Universal, simple, version-control friendly |
| **Doc Framework** | Diátaxis | ✅ Active | User-centric organization, scales well |
| **Diagrams** | Mermaid.js | ✅ Active | Text-based, GitHub-native, accessible |
| **Repository** | GitHub | ✅ Active | Industry standard, excellent collaboration |
| **Version Control** | Git | ✅ Active | Essential for open source projects |
| **Licensing** | Apache 2.0 + CC BY-SA 4.0 | ✅ Active | Standard open source licenses |
| **Community (Issues)** | GitHub Issues | ✅ Active | Built-in, searchable, familiar |
| **Community (Discussions)** | GitHub Discussions | ✅ Active | Long-form, community-friendly |
| **Social Platform** | LinkedIn | ✅ Active | Professional network, target audience |
| **Writing Tools** | VS Code / Claude | ✅ Active | Simple, AI-assisted, transparent |
| **Publishing** | GitHub direct | ✅ Active | Zero build process, fast iteration |
| **Email Newsletter** | TBD | ⏸️ Deferred | Beta consideration if warranted |
| **Real-time Chat** | Discord/Slack | ⏸️ Deferred | Post-launch decision based on community |
| **Static Site** | GitHub Pages | ⏸️ Deferred | Beta consideration if navigation needed |
| **CI/CD** | GitHub Actions | ⏸️ Deferred | Beta when quality automation needed |
| **Analytics** | GitHub Insights | ✅ Active | Built-in, sufficient for now |

---

## Evolution Criteria

**When to add tooling:**
- Community explicitly requests it
- Clear pain point identified
- Benefit justifies complexity
- Author can maintain it sustainably
- Aligns with open source principles

**When to remove tooling:**
- Not providing value
- Adds unnecessary burden
- Community not using it
- Better alternative emerges
- Simplification possible

**Decision authority:**
- Author decides for Alpha
- Community input for Beta+
- Transparent rationale always
- Reversible when possible

---

**This tech stack prioritizes simplicity, contributor-friendliness, and sustainability over complexity and features. Tools serve the content and community, not the other way around.**

**Last updated:** 2025-11-05
**Next review:** After Alpha completion (Q1 2026)
