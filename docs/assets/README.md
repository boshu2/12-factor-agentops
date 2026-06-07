# Visual Assets

Visual diagrams for the 12-Factor AgentOps framework.

## Available Visuals

The factor diagram ships in three interchangeable files (identical content, same
four-phase loop): `12-factor-landscape.svg`, `12-factor-landscape-animated.svg`,
and `12-factor-animated.svg`.

### The Factor Loop

**Purpose:** The 12 factors as a four-phase control loop.

**Shows:**
- All 12 factors grouped into four phases of three
- Four phases: Prepare (I–III), Bound (IV–VI), Select (VII–IX), Govern (X–XII)
- The forward flow Prepare → Bound → Select → Govern
- The feedback edge: Govern feeds back into Prepare ("the loop closes")

**Use cases:** repository README, docs overview, talks, social sharing.

**Dimensions:** 960×410px (scales fluidly). Subtle phase pulse; disabled under
`prefers-reduced-motion`.

## Design Principles

The visuals follow the **Construct** identity — a phosphor terminal dressed as an
engineering drawing set:

1. **Near-black ground** (`#070a08`).
2. **One phosphor signal — amber.** Lead amber `#f59e0b` / bright `#fbbf24`; other
   colors stay semantic and singular (green = passing, red = failure, gray =
   structure). No decorative third hue.
3. **Monospace throughout** — JetBrains Mono.
4. **Hairline borders with glow, corner registration ticks, blueprint feel.**
5. **Accessibility** — high contrast; motion is decorative and guarded by
   `prefers-reduced-motion`.
6. **Standalone SVG** — embedded styles, no build step or external dependencies.

## Usage

Licensed **CC BY-SA 4.0**, same as the framework docs. Attribution:
"12-Factor AgentOps by Boden Fuller."

---

**Updated:** June 2026 · **License:** CC BY-SA 4.0
