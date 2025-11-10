# Visual Assets

This directory contains visual diagrams and assets for the 12-Factor AgentOps framework.

## Available Visuals

### 12-Factor Landscape (`12-factor-landscape.svg`)

**Purpose:** Comprehensive overview of all 12 factors organized by their operational layers.

**Shows:**
- All 12 factors in a clear 3×4 grid layout
- Three operational layers: Foundation (I-IV), Operations (V-VIII), Improvement (IX-XII)
- Brief description of what each factor does
- Visual flow showing how factors build on each other
- Continuous feedback loop from Improvement back to Foundation

**Use cases:**
- Repository README
- Documentation overview
- Presentations and talks
- Educational materials
- Social media sharing

**Dimensions:** 1200×900px

---

### Workflow Flow (`workflow-flow.svg`)

**Purpose:** Simplified diagram showing how the factors work together in practice.

**Shows:**
- Three-stage operational flow: Foundation → Operations → Improvement
- Key insight: AI agents aren't deterministic, infrastructure patterns work
- Operations breakdown: Telemetry → Continuity → Routing + Human oversight
- Continuous feedback loop back to Foundation
- Expected results: 80% → 99%+ reliability

**Use cases:**
- Quick understanding of the framework
- Onboarding materials
- Blog posts and articles
- Social media (more compact than landscape)
- Slide decks

**Dimensions:** 800×600px

---

## Design Principles

All visuals follow these principles:

1. **Clarity over complexity** - Simple, clean layouts
2. **Warm, vibrant color palette** - Inspired by Anthropic's design language:
   - **Background:** Warm cream (#FAF8F5)
   - **Foundation (I-IV):** Vibrant blue (#1A7FCC) with light blue fill (#E8F4FD)
   - **Operations (V-VIII):** Fresh green (#15B871) with light green fill (#E8F7EC)
   - **Improvement (IX-XII):** Warm orange (#D97948) with light peach fill (#FFF4ED)
   - **Text:** Deep charcoal (#1A1A1A, #2D2A24) with earth tone accents (#5A5449, #7A6F5D)
3. **Typography** - Inter font family (modern, clean, similar to Anthropic's aesthetic) with system font fallbacks
4. **Accessibility** - High contrast, readable fonts, proper font weights
5. **Scalability** - SVG format, scales to any size
6. **Consistency** - Matches the framework's structure and terminology

## Usage

These visuals are licensed under **CC BY-SA 4.0**, same as the main framework documentation.

You may:
- ✅ Use in presentations and talks
- ✅ Share on social media (with attribution)
- ✅ Adapt for your domain-specific guides
- ✅ Include in blog posts and articles

Attribution: "12-Factor AgentOps by Brian T. Fuller"

## Contributing

To contribute new visuals:

1. Follow the existing color scheme and design principles
2. Use SVG format for scalability
3. Keep file sizes reasonable (<50KB)
4. Add clear documentation here
5. Submit via pull request

## Source Files

All visuals are created as standalone SVG files with embedded styles. No external dependencies or build tools required.

---

**Version:** v1.0.0
**Updated:** November 2025
**License:** CC BY-SA 4.0
