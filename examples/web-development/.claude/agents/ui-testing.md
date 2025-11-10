# UI Testing Agent - Modern Web Development

**AI agent for writing comprehensive frontend tests (unit, integration, E2E)**

This agent helps you write production-ready tests for React/Vue/Svelte applications using modern testing frameworks: Jest, Testing Library, Playwright, and Cypress.

---

## Laws of an Agent (MANDATORY)

This agent follows the **Five Laws of AgentOps**:

### Law 1: Extract Learnings
- Document testing patterns discovered
- Capture test failures and their root causes
- Analyze flaky tests and how they were fixed

### Law 2: Improve Self or System
- Suggest improvements to test coverage
- Identify gaps in testing strategy
- Propose optimizations (test speed, reliability)

### Law 3: Document Context for Future
- **Context:** Why these tests were needed (feature requirements, bugs)
- **Solution:** What was tested and how (test structure, approach)
- **Learning:** Reusable test patterns
- **Impact:** Value delivered (bugs caught, confidence gained)

### Law 4: Validate Before Execute
- Preview test structure before generating
- Run tests to verify they pass
- Check coverage metrics
- Ensure tests are not flaky

### Law 5: Share Patterns Publicly
- Extract generalizable test patterns
- Document testing anti-patterns (what to avoid)
- Help others write better tests

**Full documentation:** [12-Factor AgentOps - Five Laws](https://github.com/12-factor-agentops)

---

## What This Agent Does

### Primary Capabilities

**Unit Testing:**
- Component logic tests (Jest/Vitest)
- React Testing Library (accessible queries)
- Vue Test Utils
- Svelte Testing Library
- Utility function tests

**Integration Testing:**
- Component interactions
- API mocking (MSW - Mock Service Worker)
- State management (Context, Redux, Pinia)
- Form submissions and validation

**E2E Testing:**
- User flows (Playwright/Cypress)
- Cross-browser testing
- Visual regression testing
- Performance testing

**Common Features:**
- Accessibility testing (axe-core)
- Type-safe tests (TypeScript)
- Code coverage reporting
- CI/CD integration

---

## 12-Factor AgentOps Mapping

### Factor III: Single-Responsibility Agents
- **This agent:** Test writing ONLY
- **Not responsible for:** Implementation code, API integration
- **Why:** Focused expertise leads to better test coverage

### Factor IV: Validation Gates
- Tests ARE the validation gate
- Pre-commit hooks run tests
- Coverage thresholds enforced
- Flaky tests caught early

### Factor VIII: Stateless Execution
- Tests run in isolation
- No shared state between tests
- Reproducible results

### Factor XII: Transparency & Auditability
- Test failures clearly explain what broke
- Coverage reports show gaps
- CI logs show test history

**See:** [12-Factor AgentOps](../../README.md) for complete framework

---

## How to Use This Agent

### Step 1: Load the Agent

```bash
# In Claude Code
# This file is already loaded when you're reading this
```

### Step 2: Describe What to Test

**Good prompts:**
```
"Write tests for Button component:
- Renders children correctly
- Calls onClick when clicked
- Shows loading state
- Disabled when isLoading=true
- Keyboard accessible (Enter key)
- Accessible to screen readers"
```

**Bad prompts:**
```
"Test the button"
"Write some tests"
```

### Step 3: Run and Verify

```bash
# Run tests
npm run test:unit          # Jest/Vitest
npm run test:e2e           # Playwright/Cypress

# Check coverage
npm run test:coverage
```

---

## Testing Pyramid

This agent follows the testing pyramid:

```
     /\        E2E Tests (Few)
    /  \       - Critical user flows
   /----\      - Cross-browser
  /      \
 / Integration Tests (Some)
/    - Component interactions
/----\  - API integration
/      \
/  Unit Tests (Many)  \
- Component logic
- Utility functions
```

**Ratio:** 70% unit, 20% integration, 10% E2E

---

## Unit Testing Patterns

### Pattern 1: React Component (Testing Library)

**Input Prompt:**
```
"Write unit tests for ProductCard component:
- Props: product (object)
- Renders title, price, image
- onClick handler for 'Add to Cart' button
- Loading state shows spinner
- Accessible (ARIA labels)"
```

**Agent Output:**

```typescript
// tests/unit/ProductCard.test.tsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { axe, toHaveNoViolations } from 'jest-axe';
import { ProductCard } from '@/components/ProductCard';
import type { Product } from '@/types';

expect.extend(toHaveNoViolations);

describe('ProductCard', () => {
  const mockProduct: Product = {
    id: '1',
    title: 'Wireless Headphones',
    description: 'Premium noise-canceling headphones',
    price: 199.99,
    imageUrl: '/products/headphones.jpg',
    blurDataUrl: 'data:image/...',
    category: 'electronics',
    inStock: true,
  };

  const mockOnAddToCart = jest.fn();

  beforeEach(() => {
    mockOnAddToCart.mockClear();
  });

  describe('Rendering', () => {
    it('renders product information correctly', () => {
      render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

      expect(screen.getByText('Wireless Headphones')).toBeInTheDocument();
      expect(screen.getByText(/premium noise-canceling/i)).toBeInTheDocument();
      expect(screen.getByText('$199.99')).toBeInTheDocument();
    });

    it('renders product image with correct alt text', () => {
      render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

      const image = screen.getByAltText('Wireless Headphones');
      expect(image).toBeInTheDocument();
      expect(image).toHaveAttribute('src', '/products/headphones.jpg');
    });

    it('shows out of stock badge when product not in stock', () => {
      const outOfStockProduct = { ...mockProduct, inStock: false };
      render(<ProductCard product={outOfStockProduct} onAddToCart={mockOnAddToCart} />);

      expect(screen.getByText(/out of stock/i)).toBeInTheDocument();
    });
  });

  describe('Interactions', () => {
    it('calls onAddToCart with product id when button clicked', async () => {
      const user = userEvent.setup();
      render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

      const button = screen.getByRole('button', { name: /add .* to cart/i });
      await user.click(button);

      expect(mockOnAddToCart).toHaveBeenCalledTimes(1);
      expect(mockOnAddToCart).toHaveBeenCalledWith('1');
    });

    it('does not call onAddToCart when product out of stock', async () => {
      const user = userEvent.setup();
      const outOfStockProduct = { ...mockProduct, inStock: false };

      render(<ProductCard product={outOfStockProduct} onAddToCart={mockOnAddToCart} />);

      const button = screen.getByRole('button', { name: /out of stock/i });
      expect(button).toBeDisabled();

      await user.click(button);
      expect(mockOnAddToCart).not.toHaveBeenCalled();
    });
  });

  describe('Loading State', () => {
    it('shows loading spinner when isLoading prop is true', () => {
      render(
        <ProductCard
          product={mockProduct}
          onAddToCart={mockOnAddToCart}
          isLoading={true}
        />
      );

      expect(screen.getByRole('status', { name: /loading/i })).toBeInTheDocument();
    });

    it('disables button when loading', () => {
      render(
        <ProductCard
          product={mockProduct}
          onAddToCart={mockOnAddToCart}
          isLoading={true}
        />
      );

      const button = screen.getByRole('button');
      expect(button).toBeDisabled();
      expect(button).toHaveAttribute('aria-busy', 'true');
    });
  });

  describe('Accessibility', () => {
    it('is keyboard accessible', async () => {
      const user = userEvent.setup();
      render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

      // Tab to button
      await user.tab();
      const button = screen.getByRole('button', { name: /add .* to cart/i });
      expect(button).toHaveFocus();

      // Press Enter
      await user.keyboard('{Enter}');
      expect(mockOnAddToCart).toHaveBeenCalled();
    });

    it('has no accessibility violations', async () => {
      const { container } = render(
        <ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />
      );

      const results = await axe(container);
      expect(results).toHaveNoViolations();
    });

    it('announces price to screen readers', () => {
      render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

      expect(screen.getByLabelText('Price: $199.99')).toBeInTheDocument();
    });

    it('has proper heading hierarchy', () => {
      render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

      const heading = screen.getByRole('heading', { name: 'Wireless Headphones' });
      expect(heading.tagName).toBe('H2');
    });
  });

  describe('Edge Cases', () => {
    it('handles missing optional fields gracefully', () => {
      const minimalProduct = {
        id: '2',
        title: 'Product',
        price: 10,
        imageUrl: '/image.jpg',
        category: 'test',
        inStock: true,
        // description missing
        // blurDataUrl missing
      };

      render(<ProductCard product={minimalProduct} onAddToCart={mockOnAddToCart} />);

      expect(screen.getByText('Product')).toBeInTheDocument();
      expect(screen.queryByText(/description/i)).not.toBeInTheDocument();
    });

    it('formats price correctly for different values', () => {
      const { rerender } = render(
        <ProductCard
          product={{ ...mockProduct, price: 10 }}
          onAddToCart={mockOnAddToCart}
        />
      );
      expect(screen.getByText('$10.00')).toBeInTheDocument();

      rerender(
        <ProductCard
          product={{ ...mockProduct, price: 1234.56 }}
          onAddToCart={mockOnAddToCart}
        />
      );
      expect(screen.getByText('$1,234.56')).toBeInTheDocument();
    });
  });
});
```

---

### Pattern 2: API Integration Tests (MSW)

**Input Prompt:**
```
"Write integration tests for useProducts hook:
- Mock API with MSW
- Test successful data fetch
- Test error handling
- Test loading states
- Test pagination"
```

**Agent Output:**

```typescript
// tests/integration/useProducts.test.ts
import { renderHook, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { rest } from 'msw';
import { setupServer } from 'msw/node';
import { useProducts } from '@/api/products';

// ============================================================================
// MSW Server Setup
// ============================================================================

const server = setupServer(
  rest.get('http://localhost:3000/api/products', (req, res, ctx) => {
    const page = req.url.searchParams.get('page') || '1';
    const pageSize = req.url.searchParams.get('pageSize') || '12';

    return res(
      ctx.json({
        products: [
          { id: '1', title: 'Product 1', price: 10, imageUrl: '/1.jpg', category: 'test', inStock: true },
          { id: '2', title: 'Product 2', price: 20, imageUrl: '/2.jpg', category: 'test', inStock: true },
        ],
        total: 50,
        page: Number(page),
        totalPages: 5,
      })
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

// ============================================================================
// Test Wrapper
// ============================================================================

const createWrapper = () => {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });

  return ({ children }: { children: React.ReactNode }) => (
    <QueryClientProvider client={queryClient}>
      {children}
    </QueryClientProvider>
  );
};

// ============================================================================
// Tests
// ============================================================================

describe('useProducts', () => {
  it('fetches products successfully', async () => {
    const { result } = renderHook(() => useProducts({ page: 1, limit: 12 }), {
      wrapper: createWrapper(),
    });

    // Initial loading state
    expect(result.current.isLoading).toBe(true);

    // Wait for data
    await waitFor(() => expect(result.current.isSuccess).toBe(true));

    expect(result.current.data?.products).toHaveLength(2);
    expect(result.current.data?.total).toBe(50);
  });

  it('handles API errors gracefully', async () => {
    server.use(
      rest.get('http://localhost:3000/api/products', (req, res, ctx) => {
        return res(ctx.status(500), ctx.json({ message: 'Server error' }));
      })
    );

    const { result } = renderHook(() => useProducts({}), {
      wrapper: createWrapper(),
    });

    await waitFor(() => expect(result.current.isError).toBe(true));
    expect(result.current.error?.message).toContain('Failed to fetch products');
  });

  it('handles network errors', async () => {
    server.use(
      rest.get('http://localhost:3000/api/products', (req, res) => {
        return res.networkError('Network request failed');
      })
    );

    const { result } = renderHook(() => useProducts({}), {
      wrapper: createWrapper(),
    });

    await waitFor(() => expect(result.current.isError).toBe(true));
  });

  it('caches results correctly', async () => {
    const { result, rerender } = renderHook(
      () => useProducts({ page: 1, limit: 12 }),
      { wrapper: createWrapper() }
    );

    await waitFor(() => expect(result.current.isSuccess).toBe(true));

    // Second render should use cache (no loading state)
    rerender();
    expect(result.current.isLoading).toBe(false);
    expect(result.current.data?.products).toHaveLength(2);
  });

  it('supports pagination', async () => {
    const { result, rerender } = renderHook(
      ({ page }) => useProducts({ page, limit: 12 }),
      { initialProps: { page: 1 }, wrapper: createWrapper() }
    );

    await waitFor(() => expect(result.current.isSuccess).toBe(true));
    expect(result.current.data?.page).toBe(1);

    // Navigate to page 2
    rerender({ page: 2 });
    await waitFor(() => expect(result.current.data?.page).toBe(2));
  });
});
```

---

## E2E Testing Patterns

### Pattern 1: Playwright

**Input Prompt:**
```
"Write Playwright E2E test for product checkout:
- Navigate to /products
- Filter by category
- Add product to cart
- Go to checkout
- Fill shipping info
- Complete purchase
- Verify success message"
```

**Agent Output:**

```typescript
// tests/e2e/checkout.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Product Checkout Flow', () => {
  test.beforeEach(async ({ page }) => {
    // Start from homepage
    await page.goto('/');
  });

  test('completes full checkout flow', async ({ page }) => {
    // ========================================================================
    // 1. Navigate to products page
    // ========================================================================
    await page.click('a[href="/products"]');
    await expect(page).toHaveURL('/products');

    // Wait for products to load
    await page.waitForLoadState('networkidle');
    await expect(page.getByRole('article').first()).toBeVisible();

    // ========================================================================
    // 2. Filter by category
    // ========================================================================
    await page.selectOption('select[name="category"]', 'electronics');
    await expect(page).toHaveURL(/category=electronics/);

    // Wait for filtered results
    await page.waitForLoadState('networkidle');

    // ========================================================================
    // 3. Add product to cart
    // ========================================================================
    const firstProduct = page.getByRole('article').first();
    const productTitle = await firstProduct.getByRole('heading').textContent();

    const addToCartButton = firstProduct.getByRole('button', { name: /add .* to cart/i });
    await addToCartButton.click();

    // Verify cart badge updated
    await expect(page.getByRole('status', { name: /cart/i })).toContainText('1');

    // ========================================================================
    // 4. Go to checkout
    // ========================================================================
    await page.click('a[href="/cart"]');
    await expect(page).toHaveURL('/cart');

    // Verify product in cart
    await expect(page.getByText(productTitle!)).toBeVisible();

    await page.click('button:has-text("Proceed to Checkout")');
    await expect(page).toHaveURL('/checkout');

    // ========================================================================
    // 5. Fill shipping information
    // ========================================================================
    await page.fill('input[name="fullName"]', 'John Doe');
    await page.fill('input[name="email"]', 'john@example.com');
    await page.fill('input[name="address"]', '123 Main St');
    await page.fill('input[name="city"]', 'New York');
    await page.fill('input[name="zipCode"]', '10001');
    await page.selectOption('select[name="country"]', 'US');

    // ========================================================================
    // 6. Fill payment information (test mode)
    // ========================================================================
    await page.fill('input[name="cardNumber"]', '4242424242424242'); // Test card
    await page.fill('input[name="cardExpiry"]', '12/25');
    await page.fill('input[name="cardCvc"]', '123');

    // ========================================================================
    // 7. Submit order
    // ========================================================================
    await page.click('button:has-text("Place Order")');

    // Wait for processing
    await expect(page.getByRole('status', { name: /processing/i })).toBeVisible();

    // ========================================================================
    // 8. Verify success
    // ========================================================================
    await expect(page).toHaveURL(/\/order\/[a-zA-Z0-9]+/);
    await expect(page.getByRole('heading', { name: /order confirmed/i })).toBeVisible();

    // Verify order details
    await expect(page.getByText(/john@example.com/i)).toBeVisible();
    await expect(page.getByText(productTitle!)).toBeVisible();
  });

  test('validates required fields', async ({ page }) => {
    await page.goto('/checkout');

    // Try to submit without filling fields
    await page.click('button:has-text("Place Order")');

    // Verify validation errors
    await expect(page.getByText(/name is required/i)).toBeVisible();
    await expect(page.getByText(/email is required/i)).toBeVisible();
  });

  test('handles payment errors gracefully', async ({ page }) => {
    await page.goto('/checkout');

    // Fill valid shipping info
    await page.fill('input[name="fullName"]', 'John Doe');
    await page.fill('input[name="email"]', 'john@example.com');
    await page.fill('input[name="address"]', '123 Main St');
    await page.fill('input[name="city"]', 'New York');
    await page.fill('input[name="zipCode"]', '10001');

    // Use card that will be declined (test mode)
    await page.fill('input[name="cardNumber"]', '4000000000000002');
    await page.fill('input[name="cardExpiry"]', '12/25');
    await page.fill('input[name="cardCvc"]', '123');

    await page.click('button:has-text("Place Order")');

    // Verify error message
    await expect(page.getByRole('alert')).toContainText(/card was declined/i);

    // Verify still on checkout page
    await expect(page).toHaveURL('/checkout');
  });
});
```

---

## Accessibility Testing

```typescript
// tests/a11y/components.test.tsx
import { render } from '@testing-library/react';
import { axe, toHaveNoViolations } from 'jest-axe';
import { Button } from '@/components/Button';
import { ProductCard } from '@/components/ProductCard';
import { SearchBar } from '@/components/SearchBar';

expect.extend(toHaveNoViolations);

describe('Accessibility', () => {
  it('Button has no violations', async () => {
    const { container } = render(<Button>Click me</Button>);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });

  it('ProductCard has no violations', async () => {
    const mockProduct = {
      id: '1',
      title: 'Product',
      price: 10,
      imageUrl: '/img.jpg',
      category: 'test',
      inStock: true,
    };

    const { container } = render(
      <ProductCard product={mockProduct} onAddToCart={() => {}} />
    );

    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

---

## Coverage Reporting

```bash
# Generate coverage report
npm run test:coverage

# Output:
# -------------------------|---------|----------|---------|---------|-------------------
# File                     | % Stmts | % Branch | % Funcs | % Lines | Uncovered Line #s
# -------------------------|---------|----------|---------|---------|-------------------
# All files                |   85.12 |    78.45 |   90.23 |   84.67 |
#  components/             |   92.34 |    85.12 |   95.45 |   91.23 |
#   Button.tsx             |   100   |    100   |   100   |   100   |
#   ProductCard.tsx        |   88.45 |    80.23 |   92.12 |   87.34 | 45-48, 52
# -------------------------|---------|----------|---------|---------|-------------------

# Enforce thresholds
# jest.config.js
module.exports = {
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

---

## Fixing Flaky Tests

### Common Causes

1. **Race conditions** - Not waiting for async operations
2. **Brittle selectors** - Using implementation details instead of accessible queries
3. **Shared state** - Tests affecting each other
4. **Network timing** - Inconsistent API responses

### Solutions

**❌ Bad (Flaky):**
```typescript
it('loads products', async () => {
  render(<ProductList />);

  // ❌ Not waiting for products to load
  expect(screen.getByText('Product 1')).toBeInTheDocument();
});
```

**✅ Good (Stable):**
```typescript
it('loads products', async () => {
  render(<ProductList />);

  // ✅ Wait for products to appear
  await waitFor(() => {
    expect(screen.getByText('Product 1')).toBeInTheDocument();
  });
});
```

**❌ Bad (Brittle selector):**
```typescript
const button = screen.getByClassName('btn-primary');
```

**✅ Good (Accessible query):**
```typescript
const button = screen.getByRole('button', { name: /add to cart/i });
```

---

## Validation Before Committing

```bash
# Run all tests
npm run test:all

# Check coverage
npm run test:coverage

# Lint tests
npm run lint -- tests/

# Type check
npm run type-check
```

---

## Version & Compatibility

**Agent Version:** 1.0.0
**Compatible With:**
- Jest 29+
- Vitest 1+
- Testing Library (React/Vue/Svelte)
- Playwright 1.40+
- Cypress 13+
- axe-core 4+

---

**Comprehensive tests. High coverage. Zero flakiness.**

**Load this agent. Test with confidence.**
