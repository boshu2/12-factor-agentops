# Web Development + 12-Factor AgentOps

**Complete AI-assisted web development using 12-factor operational patterns**

This example demonstrates how web developers can use AI agents reliably for modern frontend development (React, Vue, Svelte) while maintaining code quality, type safety, and testing discipline.

---

## What's Included

This `.claude/` configuration provides:

- **3 AI Agents** - Component creation, API integration, UI testing
- **2 Slash Commands** - Build/validate, test execution
- **Complete Workflows** - Day-in-the-life scenarios
- **12-Factor Compliance** - Maps to AgentOps principles

**Target Stack:**
- **Primary:** React + Next.js + TypeScript
- **Adaptable to:** Vue 3, Svelte/SvelteKit, other modern frameworks
- **Testing:** Jest (unit), Playwright/Cypress (E2E)
- **APIs:** REST, GraphQL, tRPC

---

## Quick Start

### 1. Copy This Configuration

```bash
# Copy entire .claude/ directory to your web project
cp -r examples/web-development/.claude /path/to/your/web/project/

# Or symlink for development
ln -s $(pwd)/examples/web-development/.claude /path/to/your/web/project/.claude
```

### 2. Install Dependencies (if needed)

```bash
# TypeScript + Testing (if not already installed)
npm install -D typescript @types/react @types/node
npm install -D jest @testing-library/react @testing-library/jest-dom
npm install -D playwright @playwright/test
```

### 3. Use the Agents

```bash
# In Claude Code, use slash commands:
/build-frontend              # Build and validate
/test-components             # Run component tests

# Or load agents directly:
# - component-create.md → Creating new UI components
# - api-integration.md → Integrating APIs
# - ui-testing.md → Writing tests
```

---

## What This Enables

### Component-Driven Development

**Agent:** `component-create.md`

- React components with TypeScript
- Props validation and type inference
- Accessibility (a11y) patterns built-in
- CSS modules or styled-components
- Storybook integration (optional)

**Example:**
```bash
# Ask agent: "Create ProductCard component with image, title, price"
# Result: TypeScript component + props interface + accessibility + tests
```

### API Integration Patterns

**Agent:** `api-integration.md`

- RESTful API clients (fetch, axios)
- GraphQL queries (Apollo, urql)
- tRPC type-safe endpoints
- Error handling and loading states
- Request caching and optimization

**Example:**
```bash
# Ask agent: "Integrate /api/products with React Query"
# Result: Type-safe hooks + error handling + caching
```

### Comprehensive Testing

**Agent:** `ui-testing.md`

- Unit tests (Jest + Testing Library)
- Integration tests (component interactions)
- E2E tests (Playwright/Cypress)
- Visual regression testing (optional)
- Accessibility testing

**Example:**
```bash
# Ask agent: "Write tests for ProductCard component"
# Result: Unit tests + a11y checks + E2E scenarios
```

---

## 12-Factor Mapping

This configuration demonstrates core 12-Factor AgentOps principles:

### Factor I: Git Memory as Knowledge OS
- `.claude/` configuration versioned with your project
- Testing patterns evolve with codebase
- Agent memory = git history of this folder

### Factor II: JIT Context Loading
- Agents load only when needed (not all at once)
- Each agent focused on one domain (components, APIs, testing)
- Workspace settings stay minimal

### Factor III: Single-Responsibility Agents
- `component-create` → UI components only
- `api-integration` → API clients only
- `ui-testing` → Test writing only
- No monolithic "web-dev agent"

### Factor IV: Validation Gates
- `/build-frontend` validates TypeScript + linting before commit
- `/test-components` runs tests before deployment
- Pre-commit hooks catch errors early

### Factor V: Explicit Dependencies
- `package.json` tracks all dependencies
- TypeScript ensures type safety
- Testing frameworks explicitly configured

### Factor VI: Session Continuity
- Component creation → testing is seamless
- API integration → error handling is one flow
- Multi-day work preserved via git

### Factor VIII: Stateless Execution
- Agents don't maintain state between runs
- Fresh context from codebase each time
- Reproducible builds via package-lock.json

### Factor X: Dev/Prod Parity
- Same TypeScript config in dev and prod
- Tests run in CI identical to local
- Environment variables for API endpoints

### Factor XII: Transparency & Auditability
- All agent actions logged to git
- Code reviews show what agent changed
- Commit messages explain "why"

---

## Workflow Examples

See [WORKFLOWS.md](WORKFLOWS.md) for complete day-in-the-life scenarios:

1. **Building a Product Listing Page** - Components + API + tests
2. **Adding GraphQL Integration** - Apollo setup + type generation
3. **Debugging UI Tests** - Fixing flaky tests systematically
4. **Optimizing Performance** - Bundle analysis + lazy loading

---

## Stack-Specific Adaptations

### React + Next.js (Primary)

```typescript
// component-create.md optimized for:
- Next.js App Router patterns
- Server Components vs Client Components
- next/image, next/link optimizations
- Route handlers for APIs
```

### Vue 3 + Composition API

```typescript
// Agents adapt to:
- <script setup> syntax
- defineProps with TypeScript
- Composables for logic reuse
- Pinia for state management
```

### Svelte/SvelteKit

```typescript
// Agents adapt to:
- Reactive $: statements
- Store patterns (writable, derived)
- SvelteKit routing and endpoints
- Svelte's built-in transitions
```

**Note:** Agents detect framework from `package.json` and adapt patterns automatically.

---

## Testing Strategy

This configuration implements the **testing pyramid:**

```
        /\      E2E Tests (Playwright)
       /  \     - User flows
      /----\    - Cross-browser
     /      \
    / Integration Tests (Testing Library)
   /   - Component interactions
  /    - API mocking
 /-------------------------\
/     Unit Tests (Jest)      \
- Component logic
- Utility functions
- Type validation
```

**Coverage targets:**
- Unit: 80%+ (logic, utilities)
- Integration: Key user flows
- E2E: Critical paths only

---

## Performance Optimization

Agents include performance best practices:

### Bundle Size
- Code splitting via dynamic imports
- Tree-shaking unused dependencies
- Analyzing with `@next/bundle-analyzer`

### Loading Patterns
- Lazy loading components below fold
- Image optimization (next/image, blur placeholders)
- Font optimization (next/font, preload)

### Runtime Performance
- Memoization (React.memo, useMemo)
- Virtualization for long lists
- Web Workers for heavy computation

---

## Accessibility (a11y)

All components include:

- ✅ Semantic HTML (header, nav, main, article)
- ✅ ARIA labels where needed
- ✅ Keyboard navigation (tab order, focus management)
- ✅ Screen reader testing
- ✅ Color contrast validation (WCAG AA minimum)

**Tools integrated:**
- `eslint-plugin-jsx-a11y` (linting)
- `axe-core` (automated testing)
- `@testing-library/jest-dom` (a11y assertions)

---

## Common Pitfalls Avoided

### Type Safety
- ❌ `any` types discouraged
- ✅ Strict TypeScript config
- ✅ Props interfaces required
- ✅ API response types validated

### State Management
- ❌ Prop drilling beyond 2 levels
- ✅ Context for global state
- ✅ React Query for server state
- ✅ Zustand/Pinia for complex client state

### Testing
- ❌ Testing implementation details
- ✅ Testing user behavior
- ✅ Accessible queries (getByRole, getByLabelText)
- ✅ Avoiding brittle selectors

### Performance
- ❌ Large bundle sizes (>500KB)
- ✅ Code splitting routes
- ✅ Lazy loading heavy components
- ✅ Image optimization mandatory

---

## Agent Capabilities

### What Agents CAN Do

- ✅ Generate TypeScript components with proper types
- ✅ Write comprehensive tests (unit + integration + E2E)
- ✅ Integrate APIs with error handling
- ✅ Apply accessibility best practices
- ✅ Suggest performance optimizations
- ✅ Debug TypeScript errors
- ✅ Refactor for code quality

### What Agents CANNOT Do

- ❌ Make product decisions (UX, features)
- ❌ Choose tech stack (you decide React/Vue/Svelte)
- ❌ Design UI/UX (provide designs or references)
- ❌ Deploy to production (CI/CD responsibility)
- ❌ Monitor production (observability tools needed)

**Rule:** Agents are assistants, not decision-makers.

---

## Validation Gates

### Pre-Commit (Automatic)

```bash
# Via husky + lint-staged
npm run lint          # ESLint + Prettier
npm run type-check    # TypeScript validation
npm run test:unit     # Fast unit tests
```

### Pre-Push (Recommended)

```bash
# Via /build-frontend command
npm run build         # Production build
npm run test:all      # Full test suite
npm run analyze       # Bundle size check
```

### Pre-Deploy (Required)

```bash
# CI/CD pipeline
npm run build         # Build succeeds
npm run test:e2e      # E2E tests pass
npm run lighthouse    # Performance scores meet thresholds
```

---

## File Structure

```
your-web-project/
├── .claude/                        # AI agent configuration
│   ├── agents/
│   │   ├── component-create.md     # React/Vue/Svelte components
│   │   ├── api-integration.md      # API clients (REST/GraphQL)
│   │   └── ui-testing.md           # Jest + Playwright tests
│   ├── commands/
│   │   ├── build-frontend.md       # Build + validate
│   │   └── test-components.md      # Run tests
│   └── settings.json               # Permissions, hooks
├── src/
│   ├── components/                 # React components
│   ├── pages/                      # Next.js routes
│   ├── api/                        # API clients
│   ├── hooks/                      # Custom hooks
│   └── utils/                      # Utility functions
├── tests/
│   ├── unit/                       # Jest tests
│   ├── integration/                # Testing Library
│   └── e2e/                        # Playwright/Cypress
├── package.json                    # Dependencies
├── tsconfig.json                   # TypeScript config
├── jest.config.js                  # Jest config
└── playwright.config.ts            # E2E config
```

---

## Integration with CI/CD

### GitHub Actions Example

```yaml
name: Web App CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: 'npm'

      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm run test:unit
      - run: npm run build

      - name: E2E Tests
        run: npx playwright test

      - name: Upload Coverage
        uses: codecov/codecov-action@v3
```

### GitLab CI Example

```yaml
stages:
  - test
  - build
  - deploy

test:
  stage: test
  script:
    - npm ci
    - npm run lint
    - npm run type-check
    - npm run test:all
  coverage: '/Lines\s*:\s*(\d+\.\d+)%/'

build:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - .next/
      - out/
```

---

## Learning Path

### Week 1: Component Development
- Use `component-create.md` for 5+ components
- Focus on TypeScript types and props
- Run `/test-components` after each component

### Week 2: API Integration
- Use `api-integration.md` for REST and GraphQL
- Implement error handling patterns
- Add loading and error states

### Week 3: Testing Mastery
- Use `ui-testing.md` to write comprehensive tests
- Achieve 80%+ coverage on new code
- Run E2E tests in CI

### Week 4: Optimization
- Use agents to identify performance bottlenecks
- Implement code splitting and lazy loading
- Monitor bundle size trends

---

## Troubleshooting

### TypeScript Errors

```bash
# Agent can help debug:
# "TypeScript error: Property 'foo' does not exist on type 'Bar'"
# → Agent suggests type fixes or interfaces
```

### Test Failures

```bash
# Use ui-testing.md agent:
# "Test failing: Unable to find element by role 'button'"
# → Agent suggests accessible queries or updates test
```

### Build Failures

```bash
# Use /build-frontend command:
# Shows exact error with context
# Agent suggests fixes based on error type
```

### Performance Issues

```bash
# Agent can analyze:
npm run analyze    # Shows bundle size breakdown
# → Agent suggests dynamic imports or optimization
```

---

## Resources

### Official Docs
- [React](https://react.dev) - Official React documentation
- [Next.js](https://nextjs.org/docs) - Next.js framework
- [TypeScript](https://www.typescriptlang.org/docs) - TypeScript handbook
- [Testing Library](https://testing-library.com) - Testing best practices
- [Playwright](https://playwright.dev) - E2E testing framework

### Community Resources
- [12-Factor AgentOps](../../README.md) - This framework's methodology
- [Patterns for Modern Web Apps](https://www.patterns.dev) - Design patterns
- [Web.dev](https://web.dev) - Performance and best practices

### Tools
- [Bundle Analyzer](https://www.npmjs.com/package/@next/bundle-analyzer) - Bundle size analysis
- [Lighthouse](https://developers.google.com/web/tools/lighthouse) - Performance auditing
- [axe DevTools](https://www.deque.com/axe/devtools/) - Accessibility testing

---

## What's Next?

1. **Copy `.claude/` to your project** - Start using agents immediately
2. **Read [WORKFLOWS.md](WORKFLOWS.md)** - See day-in-the-life scenarios
3. **Try an agent** - Use `/build-frontend` or load `component-create.md`
4. **Customize** - Adapt agents to your stack (Vue, Svelte, etc.)
5. **Share learnings** - Contribute improvements back to this example

---

## Version & License

**Version:** 1.0.0 (2025-11-09)
**License:** MIT (same as 12-Factor AgentOps)
**Compatibility:** Claude Code 0.5.0+

**Maintained by:** 12-Factor AgentOps community
**Issues:** Open issues on main 12-Factor AgentOps repo

---

**Welcome to AI-assisted web development done right.**

Components created. APIs integrated. Tests passing. All with 12-factor operational discipline.

**Load an agent. Build something great.**
