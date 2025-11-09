# /test-components - Run Frontend Tests

**Comprehensive test execution command for frontend applications**

This slash command runs all frontend tests (unit, integration, E2E) with coverage reporting and validation.

---

## What This Command Does

Runs the following test suites:

1. **Unit Tests** - Component logic, utility functions (Jest/Vitest)
2. **Integration Tests** - Component interactions, API mocking (Testing Library)
3. **E2E Tests** - User flows, cross-browser (Playwright/Cypress)
4. **Accessibility Tests** - WCAG compliance (axe-core)
5. **Coverage Report** - Shows test coverage metrics

**Use this:**
- Before committing code
- During development (watch mode)
- In CI/CD pipelines
- Before deploying to production

---

## Usage

```bash
# In Claude Code
/test-components

# Or manually:
npm run test:all           # All tests
npm run test:unit          # Unit tests only
npm run test:e2e           # E2E tests only
npm run test:watch         # Watch mode (development)
npm run test:coverage      # With coverage report
```

---

## Test Suites

### 1. Unit Tests (Jest/Vitest)

**What gets tested:**
- Component rendering
- Props validation
- Event handlers
- Conditional logic
- Edge cases

**Example:**
```typescript
// Button.test.tsx
describe('Button', () => {
  it('renders children', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('calls onClick when clicked', async () => {
    const onClick = jest.fn();
    render(<Button onClick={onClick}>Click me</Button>);

    await userEvent.click(screen.getByRole('button'));
    expect(onClick).toHaveBeenCalledTimes(1);
  });
});
```

**Run:**
```bash
npm run test:unit

# Output:
# PASS  tests/unit/Button.test.tsx
# PASS  tests/unit/ProductCard.test.tsx
# PASS  tests/unit/SearchBar.test.tsx
#
# Test Suites: 3 passed, 3 total
# Tests:       24 passed, 24 total
# Time:        2.45s
```

---

### 2. Integration Tests (Testing Library + MSW)

**What gets tested:**
- Component interactions
- API integration (mocked)
- State management
- Form submissions
- User workflows

**Example:**
```typescript
// useProducts.test.ts
describe('useProducts', () => {
  it('fetches products successfully', async () => {
    const { result } = renderHook(() => useProducts({ page: 1 }), {
      wrapper: createQueryWrapper(),
    });

    await waitFor(() => expect(result.current.isSuccess).toBe(true));
    expect(result.current.data?.products).toHaveLength(12);
  });
});
```

**Run:**
```bash
npm run test:integration

# Output:
# PASS  tests/integration/useProducts.test.ts
# PASS  tests/integration/checkout-flow.test.tsx
#
# Test Suites: 2 passed, 2 total
# Tests:       15 passed, 15 total
# Time:        3.12s
```

---

### 3. E2E Tests (Playwright)

**What gets tested:**
- Complete user flows
- Cross-browser compatibility
- Real API interactions (staging)
- Visual regressions
- Performance

**Example:**
```typescript
// checkout.spec.ts
test('completes checkout flow', async ({ page }) => {
  await page.goto('/products');
  await page.click('button:has-text("Add to Cart")');
  await page.click('a[href="/cart"]');
  await page.click('button:has-text("Checkout")');

  await page.fill('input[name="email"]', 'test@example.com');
  await page.click('button:has-text("Place Order")');

  await expect(page).toHaveURL(/\/order\/[a-z0-9]+/);
  await expect(page.getByText('Order Confirmed')).toBeVisible();
});
```

**Run:**
```bash
npm run test:e2e

# Output:
# Running 12 tests using 4 workers
#
#   ✓  checkout.spec.ts:5:3 › completes checkout flow (chromium) (4.2s)
#   ✓  checkout.spec.ts:5:3 › completes checkout flow (firefox) (4.5s)
#   ✓  checkout.spec.ts:5:3 › completes checkout flow (webkit) (4.8s)
#
# 12 passed (23.4s)
```

---

### 4. Accessibility Tests (axe-core)

**What gets tested:**
- WCAG 2.1 compliance (Level AA)
- Color contrast
- Keyboard navigation
- Screen reader compatibility
- ARIA attributes

**Example:**
```typescript
// a11y.test.tsx
describe('Accessibility', () => {
  it('ProductCard has no violations', async () => {
    const { container } = render(
      <ProductCard product={mockProduct} onAddToCart={() => {}} />
    );

    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

**Run:**
```bash
npm run test:a11y

# Output:
# PASS  tests/a11y/components.test.tsx
#   ✓ Button has no violations
#   ✓ ProductCard has no violations
#   ✓ SearchBar has no violations
#
# All accessibility tests passed ✓
```

---

## Coverage Report

### Running Coverage

```bash
npm run test:coverage

# Generates:
# - coverage/lcov-report/index.html (HTML report)
# - coverage/lcov.info (CI/CD format)
# - coverage/coverage-summary.json (JSON summary)
```

### Example Output

```
-------------------------|---------|----------|---------|---------|-------------------
File                     | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s
-------------------------|---------|----------|---------|---------|-------------------
All files                |   87.45 |    82.12 |   91.23 |   86.78 |
 components/             |   92.34 |    88.45 |   95.67 |   91.89 |
  Button.tsx             |   100   |    100   |   100   |   100   |
  ProductCard.tsx        |   89.23 |    85.12 |   92.45 |   88.67 | 45-48,52
  SearchBar.tsx          |   95.67 |    90.34 |   98.12 |   94.89 | 78
 api/                    |   85.45 |    78.23 |   88.90 |   84.67 |
  products.ts            |   88.12 |    82.45 |   90.23 |   87.34 | 23-25,67-70
  users.ts               |   82.34 |    74.12 |   87.45 |   81.23 | 34-38,89-92
 utils/                  |   90.12 |    85.67 |   93.45 |   89.78 |
  formatters.ts          |   100   |    100   |   100   |   100   |
  validators.ts          |   82.45 |    75.34 |   88.90 |   81.23 | 12-15,45
-------------------------|---------|----------|---------|---------|-------------------
```

### Coverage Thresholds

```javascript
// jest.config.js
module.exports = {
  coverageThresholds: {
    global: {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },
    './src/components/': {
      statements: 90,
      branches: 85,
      functions: 90,
      lines: 90,
    },
  },
};
```

**If coverage is below thresholds:**
```
✗ Coverage thresholds not met:
  Global statements: 87.45% (required: 80%) ✓
  Global branches: 82.12% (required: 75%) ✓
  Global functions: 91.23% (required: 80%) ✓
  Global lines: 86.78% (required: 80%) ✓

  Components statements: 92.34% (required: 90%) ✓
  Components branches: 88.45% (required: 85%) ✓
  Components lines: 91.89% (required: 90%) ✓

❌ Tests failed: Coverage thresholds not met
```

---

## Watch Mode (Development)

```bash
npm run test:watch

# Interactive mode:
# › Press a to run all tests.
# › Press f to run only failed tests.
# › Press p to filter by a filename regex pattern.
# › Press t to filter by a test name regex pattern.
# › Press q to quit watch mode.
# › Press Enter to trigger a test run.
```

**Use during development:**
- Run tests automatically on file save
- Focus on specific tests
- Quick feedback loop

---

## Test Configuration

### Jest Config (jest.config.js)

```javascript
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
  },
  collectCoverageFrom: [
    'src/**/*.{ts,tsx}',
    '!src/**/*.d.ts',
    '!src/**/*.stories.tsx',
    '!src/**/*.test.{ts,tsx}',
  ],
  coverageThresholds: {
    global: {
      statements: 80,
      branches: 75,
      functions: 80,
      lines: 80,
    },
  },
};
```

### Playwright Config (playwright.config.ts)

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 2 : undefined,
  reporter: 'html',

  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

---

## CI/CD Integration

### GitHub Actions

```yaml
name: Test Suite
on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: 'npm'

      - run: npm ci
      - run: npm run test:unit
      - run: npm run test:coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info

  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: 'npm'

      - run: npm ci
      - run: npx playwright install --with-deps
      - run: npm run test:e2e

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: playwright-report
          path: playwright-report/
```

---

## Troubleshooting

### Tests Failing Locally but Passing in CI

**Possible causes:**
1. Environment differences (Node version, dependencies)
2. Timezone issues (use UTC in tests)
3. File system case sensitivity (macOS vs Linux)

**Solution:**
```bash
# Match CI environment
docker run -it node:18-alpine sh
npm ci
npm run test:all
```

### Flaky E2E Tests

**Symptoms:** Tests pass/fail intermittently

**Solutions:**
1. Add proper waits (`waitFor`, `waitForLoadState`)
2. Use accessible queries (not brittle selectors)
3. Increase timeouts in CI
4. Mock external APIs

**Example fix:**
```typescript
// ❌ Flaky
test('adds to cart', async ({ page }) => {
  await page.click('button:has-text("Add to Cart")');
  // Race condition - cart might not update yet
});

// ✅ Stable
test('adds to cart', async ({ page }) => {
  await page.click('button:has-text("Add to Cart")');
  await page.waitForLoadState('networkidle');
  await expect(page.getByRole('status', { name: /cart/i })).toContainText('1');
});
```

### Low Coverage on New Code

**Problem:** Coverage drops below threshold

**Solutions:**
1. Add tests for uncovered lines (check coverage report)
2. Remove dead code
3. Test edge cases

**Find uncovered lines:**
```bash
npm run test:coverage
open coverage/lcov-report/index.html

# Shows red highlighting on uncovered code
```

---

## Package.json Scripts

```json
{
  "scripts": {
    "test": "jest",
    "test:all": "npm run test:unit && npm run test:integration && npm run test:e2e",
    "test:unit": "jest --testPathPattern=tests/unit",
    "test:integration": "jest --testPathPattern=tests/integration",
    "test:e2e": "playwright test",
    "test:a11y": "jest --testPathPattern=tests/a11y",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:ci": "jest --ci --coverage --maxWorkers=2"
  }
}
```

---

## Expected Output

### ✅ All Tests Passing

```
✓ Unit tests passed (24/24 in 2.45s)
✓ Integration tests passed (15/15 in 3.12s)
✓ E2E tests passed (12/12 in 23.4s)
✓ Accessibility tests passed (8/8 in 1.23s)
✓ Coverage thresholds met (87.45% statements)

✨ All tests passed! (59/59 in 30.2s)
```

### ❌ Tests Failed

```
✗ Unit tests failed (22/24)
  ✗ Button › shows loading state
    Expected: <span role="status">Loading</span>
    Received: null

  ✗ ProductCard › handles out of stock
    Expected button to be disabled
    Received: enabled

✓ Integration tests passed (15/15)
✓ E2E tests passed (12/12)
✓ Accessibility tests passed (8/8)
✗ Coverage below threshold (73.12% < 80%)

❌ Tests failed: Fix 2 failing tests and increase coverage
```

---

## What's Next?

After `/test-components` passes:

1. **Build:** Run `/build-frontend`
2. **Commit:** Follow semantic commit conventions
3. **Push:** CI validates again
4. **Deploy:** Automated deployment triggers

---

## 12-Factor AgentOps Alignment

This command implements:

- **Factor IV: Validation Gates** - Tests catch bugs before deploy
- **Factor VIII: Stateless Execution** - Reproducible test runs
- **Factor X: Dev/Prod Parity** - Same tests in all environments
- **Factor XII: Transparency** - Clear feedback on test results

---

## Version & Status

**Command Version:** 1.0.0
**Compatible With:**
- Jest 29+
- Vitest 1+
- Playwright 1.40+
- Cypress 13+
- Testing Library (React/Vue/Svelte)

---

**Test early. Test often. Ship with confidence.**

**Use `/test-components` before every commit.**
