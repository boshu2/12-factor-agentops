# Web Development Workflows - Day-in-the-Life Scenarios

**Real-world examples of using 12-Factor AgentOps for web development**

This document shows complete workflows from start to finish—what a typical day looks like when using AI agents for modern web development.

---

## Overview

These workflows demonstrate:

- **Complete feature development** - From idea to production
- **Agent coordination** - Using multiple agents together
- **12-Factor principles** - Applied to real tasks
- **Realistic timelines** - Hours/days, not theory

**Target Audience:** Frontend developers, full-stack developers, tech leads

---

## Workflow 1: Building a Product Listing Page

**Context:** E-commerce site needs a product listing with filtering, search, and pagination.

**Stack:** React + Next.js + TypeScript + React Query

**Estimated Time:** 4-6 hours (with agents) vs 8-12 hours (manual)

### Phase 1: Component Structure (1 hour)

#### Step 1: Load Component Creation Agent

```bash
# In Claude Code
# Load: .claude/agents/component-create.md
```

#### Step 2: Create Base Components

**Prompt to agent:**
```
Create ProductCard component with:
- Product image (optimized)
- Title, description, price
- "Add to Cart" button
- TypeScript props interface
- Accessibility support
```

**Agent Output:**

```typescript
// src/components/ProductCard.tsx
import Image from 'next/image';
import { Product } from '@/types';

interface ProductCardProps {
  product: Product;
  onAddToCart: (productId: string) => void;
}

export function ProductCard({ product, onAddToCart }: ProductCardProps) {
  return (
    <article className="product-card" aria-labelledby={`product-${product.id}`}>
      <div className="product-image">
        <Image
          src={product.imageUrl}
          alt={product.title}
          width={300}
          height={300}
          placeholder="blur"
          blurDataURL={product.blurDataUrl}
        />
      </div>

      <div className="product-content">
        <h2 id={`product-${product.id}`}>{product.title}</h2>
        <p className="product-description">{product.description}</p>

        <div className="product-footer">
          <span className="product-price" aria-label={`Price: $${product.price}`}>
            ${product.price.toFixed(2)}
          </span>

          <button
            onClick={() => onAddToCart(product.id)}
            aria-label={`Add ${product.title} to cart`}
          >
            Add to Cart
          </button>
        </div>
      </div>
    </article>
  );
}
```

**12-Factor Application:**
- **Factor III** - Single-responsibility agent (components only)
- **Factor IV** - TypeScript validation built-in
- **Accessibility** - Semantic HTML, ARIA labels

#### Step 3: Create Product Grid Container

**Prompt to agent:**
```
Create ProductGrid component that:
- Takes array of products as props
- Renders ProductCard for each
- Responsive grid (1 col mobile, 3 cols desktop)
- Loading skeleton state
- Empty state when no products
```

**Agent Output:**

```typescript
// src/components/ProductGrid.tsx
import { ProductCard } from './ProductCard';
import { ProductCardSkeleton } from './ProductCardSkeleton';
import { Product } from '@/types';

interface ProductGridProps {
  products: Product[];
  isLoading?: boolean;
  onAddToCart: (productId: string) => void;
}

export function ProductGrid({ products, isLoading, onAddToCart }: ProductGridProps) {
  if (isLoading) {
    return (
      <div className="product-grid" role="status" aria-label="Loading products">
        {Array.from({ length: 6 }).map((_, i) => (
          <ProductCardSkeleton key={i} />
        ))}
      </div>
    );
  }

  if (products.length === 0) {
    return (
      <div className="empty-state" role="status">
        <p>No products found. Try adjusting your filters.</p>
      </div>
    );
  }

  return (
    <div className="product-grid">
      {products.map((product) => (
        <ProductCard
          key={product.id}
          product={product}
          onAddToCart={onAddToCart}
        />
      ))}
    </div>
  );
}
```

**Validation:**

```bash
# Run TypeScript validation
npm run type-check

# Agent automatically suggests fixes if errors
```

### Phase 2: API Integration (1.5 hours)

#### Step 1: Load API Integration Agent

```bash
# In Claude Code
# Load: .claude/agents/api-integration.md
```

#### Step 2: Create API Client

**Prompt to agent:**
```
Create API client for /api/products endpoint:
- Fetch with filtering (category, price range, search)
- Pagination support
- TypeScript types for request/response
- Error handling
- React Query integration
```

**Agent Output:**

```typescript
// src/api/products.ts
import { useQuery } from '@tanstack/react-query';

export interface ProductFilters {
  category?: string;
  minPrice?: number;
  maxPrice?: number;
  search?: string;
  page?: number;
  limit?: number;
}

export interface ProductsResponse {
  products: Product[];
  total: number;
  page: number;
  totalPages: number;
}

async function fetchProducts(filters: ProductFilters): Promise<ProductsResponse> {
  const params = new URLSearchParams();

  Object.entries(filters).forEach(([key, value]) => {
    if (value !== undefined) {
      params.append(key, String(value));
    }
  });

  const response = await fetch(`/api/products?${params.toString()}`);

  if (!response.ok) {
    throw new Error(`Failed to fetch products: ${response.statusText}`);
  }

  return response.json();
}

export function useProducts(filters: ProductFilters) {
  return useQuery({
    queryKey: ['products', filters],
    queryFn: () => fetchProducts(filters),
    staleTime: 5 * 60 * 1000, // 5 minutes
    keepPreviousData: true, // Smooth pagination
  });
}
```

**12-Factor Application:**
- **Factor V** - Explicit dependencies (React Query)
- **Factor VIII** - Stateless (no client-side caching beyond React Query)
- **Error handling** - Built-in, user-friendly

#### Step 3: Integrate with Components

**Prompt to agent:**
```
Create ProductListingPage that:
- Uses useProducts hook
- Handles loading and error states
- Implements filters (category, price, search)
- Pagination controls
```

**Agent Output:**

```typescript
// src/app/products/page.tsx
'use client';

import { useState } from 'react';
import { ProductGrid } from '@/components/ProductGrid';
import { ProductFilters } from '@/components/ProductFilters';
import { Pagination } from '@/components/Pagination';
import { useProducts } from '@/api/products';

export default function ProductListingPage() {
  const [filters, setFilters] = useState({
    page: 1,
    limit: 12,
  });

  const { data, isLoading, error } = useProducts(filters);

  if (error) {
    return (
      <div className="error-state" role="alert">
        <h2>Failed to load products</h2>
        <p>{error.message}</p>
        <button onClick={() => window.location.reload()}>
          Try Again
        </button>
      </div>
    );
  }

  return (
    <main className="product-listing">
      <h1>Our Products</h1>

      <ProductFilters
        filters={filters}
        onChange={setFilters}
      />

      <ProductGrid
        products={data?.products || []}
        isLoading={isLoading}
        onAddToCart={(id) => console.log('Add to cart:', id)}
      />

      {data && (
        <Pagination
          currentPage={data.page}
          totalPages={data.totalPages}
          onPageChange={(page) => setFilters({ ...filters, page })}
        />
      )}
    </main>
  );
}
```

**Validation:**

```bash
# Use build-frontend command
/build-frontend

# Validates:
# - TypeScript compiles
# - ESLint passes
# - Production build succeeds
```

### Phase 3: Testing (1.5 hours)

#### Step 1: Load UI Testing Agent

```bash
# In Claude Code
# Load: .claude/agents/ui-testing.md
```

#### Step 2: Unit Tests for Components

**Prompt to agent:**
```
Write tests for ProductCard component:
- Renders product data correctly
- Calls onAddToCart when button clicked
- Accessible to screen readers
```

**Agent Output:**

```typescript
// tests/unit/ProductCard.test.tsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { ProductCard } from '@/components/ProductCard';

describe('ProductCard', () => {
  const mockProduct = {
    id: '1',
    title: 'Wireless Headphones',
    description: 'Premium noise-canceling headphones',
    price: 199.99,
    imageUrl: '/products/headphones.jpg',
    blurDataUrl: 'data:image/...',
  };

  const mockOnAddToCart = jest.fn();

  it('renders product information', () => {
    render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

    expect(screen.getByText('Wireless Headphones')).toBeInTheDocument();
    expect(screen.getByText('Premium noise-canceling headphones')).toBeInTheDocument();
    expect(screen.getByText('$199.99')).toBeInTheDocument();
  });

  it('calls onAddToCart when button clicked', async () => {
    const user = userEvent.setup();
    render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

    const button = screen.getByRole('button', { name: /add .* to cart/i });
    await user.click(button);

    expect(mockOnAddToCart).toHaveBeenCalledWith('1');
  });

  it('is accessible to screen readers', () => {
    render(<ProductCard product={mockProduct} onAddToCart={mockOnAddToCart} />);

    // Product title is properly labeled
    expect(screen.getByRole('heading', { name: 'Wireless Headphones' })).toBeInTheDocument();

    // Price has aria-label
    expect(screen.getByLabelText('Price: $199.99')).toBeInTheDocument();

    // Button has descriptive label
    expect(screen.getByRole('button', { name: 'Add Wireless Headphones to cart' })).toBeInTheDocument();
  });
});
```

#### Step 3: Integration Tests for API

**Prompt to agent:**
```
Write tests for useProducts hook:
- Fetches products successfully
- Handles errors gracefully
- Caches results
```

**Agent Output:**

```typescript
// tests/integration/useProducts.test.ts
import { renderHook, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useProducts } from '@/api/products';

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

describe('useProducts', () => {
  beforeEach(() => {
    fetchMock.resetMocks();
  });

  it('fetches products successfully', async () => {
    const mockData = {
      products: [{ id: '1', title: 'Product 1', price: 10 }],
      total: 1,
      page: 1,
      totalPages: 1,
    };

    fetchMock.mockResponseOnce(JSON.stringify(mockData));

    const { result } = renderHook(
      () => useProducts({ page: 1, limit: 12 }),
      { wrapper: createWrapper() }
    );

    await waitFor(() => expect(result.current.isSuccess).toBe(true));
    expect(result.current.data).toEqual(mockData);
  });

  it('handles errors gracefully', async () => {
    fetchMock.mockRejectOnce(new Error('Network error'));

    const { result } = renderHook(
      () => useProducts({ page: 1 }),
      { wrapper: createWrapper() }
    );

    await waitFor(() => expect(result.current.isError).toBe(true));
    expect(result.current.error?.message).toContain('Network error');
  });
});
```

#### Step 4: E2E Tests

**Prompt to agent:**
```
Write Playwright test for product listing:
- Navigate to /products
- Filter by category
- Paginate through results
- Add product to cart
```

**Agent Output:**

```typescript
// tests/e2e/product-listing.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Product Listing Page', () => {
  test('filters products by category', async ({ page }) => {
    await page.goto('/products');

    // Wait for products to load
    await expect(page.getByRole('article').first()).toBeVisible();

    // Select "Electronics" category
    await page.getByRole('combobox', { name: /category/i }).selectOption('electronics');

    // Verify URL updated
    await expect(page).toHaveURL(/category=electronics/);

    // Verify products filtered
    const productCards = page.getByRole('article');
    await expect(productCards).toHaveCount(12); // One page
  });

  test('paginates through results', async ({ page }) => {
    await page.goto('/products');

    // Click page 2
    await page.getByRole('button', { name: 'Page 2' }).click();

    // Verify URL updated
    await expect(page).toHaveURL(/page=2/);

    // Verify new products loaded
    await expect(page.getByRole('article').first()).toBeVisible();
  });

  test('adds product to cart', async ({ page }) => {
    await page.goto('/products');

    // Find first "Add to Cart" button
    const firstProduct = page.getByRole('article').first();
    const addButton = firstProduct.getByRole('button', { name: /add .* to cart/i });

    await addButton.click();

    // Verify cart updated (depends on your implementation)
    await expect(page.getByRole('status', { name: /cart/i })).toContainText('1 item');
  });
});
```

**Run Tests:**

```bash
# Use test-components command
/test-components

# Or manually:
npm run test:unit          # Jest tests
npm run test:e2e           # Playwright tests
```

### Phase 4: Optimization (1 hour)

#### Step 1: Analyze Bundle Size

```bash
npm run analyze

# Shows:
# - ProductGrid: 45KB (acceptable)
# - React Query: 35KB (necessary)
# - Image components: optimized by Next.js
```

#### Step 2: Apply Lazy Loading

**Prompt to agent:**
```
Optimize ProductListingPage:
- Lazy load ProductFilters (below fold)
- Prefetch images on hover
- Debounce search input
```

**Agent Output:**

```typescript
// src/app/products/page.tsx (optimized)
'use client';

import { useState } from 'react';
import dynamic from 'next/dynamic';
import { ProductGrid } from '@/components/ProductGrid';
import { useProducts } from '@/api/products';
import { useDebouncedValue } from '@/hooks/useDebouncedValue';

// Lazy load filters (not critical for initial render)
const ProductFilters = dynamic(() => import('@/components/ProductFilters'), {
  loading: () => <div>Loading filters...</div>,
});

export default function ProductListingPage() {
  const [filters, setFilters] = useState({ page: 1, limit: 12 });

  // Debounce search to reduce API calls
  const debouncedFilters = useDebouncedValue(filters, 300);

  const { data, isLoading, error } = useProducts(debouncedFilters);

  // ... rest of component
}
```

### Phase 5: Final Validation (30 min)

```bash
# Full build and test
/build-frontend

# Checks:
# ✅ TypeScript compiles
# ✅ ESLint passes (0 warnings)
# ✅ Tests pass (100% new code)
# ✅ Build succeeds
# ✅ Bundle size acceptable

# Commit
git add .
git commit -m "feat(products): add product listing page with filters

- ProductCard component with accessibility
- React Query integration for API
- Comprehensive tests (unit + E2E)
- Performance optimizations (lazy loading, debounce)
- Bundle size: +80KB (acceptable)

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Results

**Time Saved:** 4-6 hours (with agents) vs 8-12 hours (manual) = ~50% faster

**Quality:**
- ✅ TypeScript type safety
- ✅ Accessibility (a11y) built-in
- ✅ 80%+ test coverage
- ✅ Performance optimized
- ✅ Production-ready code

**12-Factor Principles Applied:**
- Factor III (agents single-responsibility)
- Factor IV (validation gates)
- Factor V (explicit dependencies)
- Factor VIII (stateless API)

---

## Workflow 2: Adding GraphQL Integration

**Context:** Existing REST API is slow. Migrating to GraphQL for efficiency.

**Stack:** React + Next.js + Apollo Client + GraphQL Code Generator

**Estimated Time:** 3-4 hours (with agents) vs 6-8 hours (manual)

### Phase 1: Setup GraphQL Client (45 min)

#### Step 1: Load API Integration Agent

```bash
# In Claude Code
# Load: .claude/agents/api-integration.md
```

#### Step 2: Configure Apollo Client

**Prompt to agent:**
```
Set up Apollo Client for Next.js:
- Apollo Provider in app layout
- Error handling (network, GraphQL errors)
- Cache configuration
- TypeScript support
```

**Agent Output:**

```typescript
// src/lib/apollo-client.ts
import { ApolloClient, InMemoryCache, HttpLink, from } from '@apollo/client';
import { onError } from '@apollo/client/link/error';

const httpLink = new HttpLink({
  uri: process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT,
});

const errorLink = onError(({ graphQLErrors, networkError }) => {
  if (graphQLErrors) {
    graphQLErrors.forEach(({ message, locations, path }) => {
      console.error(`[GraphQL error]: Message: ${message}, Path: ${path}`);
    });
  }

  if (networkError) {
    console.error(`[Network error]: ${networkError}`);
  }
});

export const apolloClient = new ApolloClient({
  link: from([errorLink, httpLink]),
  cache: new InMemoryCache({
    typePolicies: {
      Query: {
        fields: {
          products: {
            keyArgs: ['filters'],
            merge(existing, incoming, { args }) {
              if (args?.pagination?.offset === 0) {
                return incoming;
              }
              return [...(existing || []), ...incoming];
            },
          },
        },
      },
    },
  }),
});
```

```typescript
// src/app/layout.tsx
'use client';

import { ApolloProvider } from '@apollo/client';
import { apolloClient } from '@/lib/apollo-client';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <ApolloProvider client={apolloClient}>
          {children}
        </ApolloProvider>
      </body>
    </html>
  );
}
```

### Phase 2: Generate TypeScript Types (30 min)

#### Step 1: Create GraphQL Schema

**Prompt to agent:**
```
Write GraphQL query for products:
- id, title, description, price, imageUrl
- Filtering (category, priceRange, search)
- Pagination (offset, limit)
- Include fragment for reusability
```

**Agent Output:**

```graphql
# src/graphql/queries/products.graphql
fragment ProductFields on Product {
  id
  title
  description
  price
  imageUrl
  category
  inStock
}

query GetProducts(
  $filters: ProductFilters
  $pagination: PaginationInput
) {
  products(filters: $filters, pagination: $pagination) {
    items {
      ...ProductFields
    }
    total
    hasNextPage
  }
}
```

#### Step 2: Generate Types

**Prompt to agent:**
```
Configure GraphQL Code Generator:
- Generate TypeScript types from schema
- Generate React hooks for queries/mutations
- Include type-safe variables
```

**Agent Output:**

```yaml
# codegen.yml
schema: ${GRAPHQL_ENDPOINT}
documents: 'src/graphql/**/*.graphql'
generates:
  src/graphql/generated.ts:
    plugins:
      - typescript
      - typescript-operations
      - typescript-react-apollo
    config:
      withHooks: true
      withHOC: false
      withComponent: false
```

```bash
# Generate types
npm run codegen

# Result: src/graphql/generated.ts with:
# - Product type
# - GetProductsQuery type
# - GetProductsQueryVariables type
# - useGetProductsQuery hook
```

### Phase 3: Integrate with Components (1 hour)

**Prompt to agent:**
```
Refactor ProductListingPage to use GraphQL:
- Replace useProducts with useGetProductsQuery
- Handle loading/error states
- Implement pagination with fetchMore
```

**Agent Output:**

```typescript
// src/app/products/page.tsx (GraphQL version)
'use client';

import { useState } from 'react';
import { useGetProductsQuery } from '@/graphql/generated';
import { ProductGrid } from '@/components/ProductGrid';

export default function ProductListingPage() {
  const [filters, setFilters] = useState({
    category: undefined,
    priceRange: undefined,
    search: '',
  });

  const { data, loading, error, fetchMore } = useGetProductsQuery({
    variables: {
      filters,
      pagination: { offset: 0, limit: 12 },
    },
  });

  const loadMore = () => {
    fetchMore({
      variables: {
        pagination: {
          offset: data?.products.items.length || 0,
          limit: 12,
        },
      },
    });
  };

  if (error) {
    return <div role="alert">Error: {error.message}</div>;
  }

  return (
    <main className="product-listing">
      <h1>Our Products</h1>

      <ProductGrid
        products={data?.products.items || []}
        isLoading={loading}
        onAddToCart={(id) => console.log('Add to cart:', id)}
      />

      {data?.products.hasNextPage && (
        <button onClick={loadMore}>
          Load More
        </button>
      )}
    </main>
  );
}
```

**Benefits:**
- ✅ Type safety (GraphQL types generated)
- ✅ Single request (no overfetching)
- ✅ Optimistic UI (Apollo cache)
- ✅ Pagination built-in

### Phase 4: Testing GraphQL (1 hour)

**Prompt to agent:**
```
Write tests for GraphQL integration:
- Mock Apollo responses
- Test loading states
- Test error handling
- Test pagination
```

**Agent Output:**

```typescript
// tests/integration/graphql-products.test.tsx
import { render, screen, waitFor } from '@testing-library/react';
import { MockedProvider } from '@apollo/client/testing';
import { GetProductsDocument } from '@/graphql/generated';
import ProductListingPage from '@/app/products/page';

const mocks = [
  {
    request: {
      query: GetProductsDocument,
      variables: {
        filters: {},
        pagination: { offset: 0, limit: 12 },
      },
    },
    result: {
      data: {
        products: {
          items: [
            { id: '1', title: 'Product 1', price: 10, imageUrl: '/img.jpg' },
          ],
          total: 1,
          hasNextPage: false,
        },
      },
    },
  },
];

describe('ProductListingPage (GraphQL)', () => {
  it('renders products from GraphQL', async () => {
    render(
      <MockedProvider mocks={mocks} addTypename={false}>
        <ProductListingPage />
      </MockedProvider>
    );

    // Loading state
    expect(screen.getByRole('status', { name: /loading/i })).toBeInTheDocument();

    // Products loaded
    await waitFor(() => {
      expect(screen.getByText('Product 1')).toBeInTheDocument();
    });
  });
});
```

### Results

**Time Saved:** 3-4 hours (with agents) vs 6-8 hours (manual) = ~50% faster

**Quality:**
- ✅ Type-safe GraphQL (generated types)
- ✅ Optimized queries (no overfetching)
- ✅ Error handling built-in
- ✅ Tests passing

---

## Workflow 3: Debugging Flaky UI Tests

**Context:** E2E tests intermittently failing in CI. Need to identify and fix root cause.

**Stack:** Playwright + React Testing Library

**Estimated Time:** 2-3 hours (with agents) vs 4-6 hours (manual)

### Phase 1: Identify Flaky Test (30 min)

#### Step 1: Run Tests Multiple Times

```bash
# Run tests 10 times to find flakiness
for i in {1..10}; do npm run test:e2e; done

# Result: "Add to cart" test fails 3/10 times
```

#### Step 2: Load UI Testing Agent

```bash
# In Claude Code
# Load: .claude/agents/ui-testing.md
```

**Prompt to agent:**
```
Analyze this flaky Playwright test:
[paste test code]

It fails intermittently with "Button not found" error.
What are common causes and how to fix?
```

**Agent Response:**

```
Common causes of "Button not found" in Playwright:

1. Race condition (element not rendered yet)
2. Animation/transition timing
3. Dynamic content loading
4. CSS selector too brittle
5. Network request not completed

Recommended fixes:
1. Use waitFor with proper timeout
2. Use accessible queries (getByRole)
3. Wait for network idle
4. Avoid hard-coded delays
```

### Phase 2: Fix Root Cause (1 hour)

#### Original Flaky Test

```typescript
// tests/e2e/product-listing.spec.ts (BEFORE)
test('adds product to cart', async ({ page }) => {
  await page.goto('/products');

  // ❌ Race condition: products might not be loaded yet
  const addButton = page.locator('button:has-text("Add to Cart")').first();
  await addButton.click();

  // ❌ No verification that action succeeded
});
```

#### Fixed Test (Agent-Suggested)

```typescript
// tests/e2e/product-listing.spec.ts (AFTER)
test('adds product to cart', async ({ page }) => {
  await page.goto('/products');

  // ✅ Wait for products to load (network idle)
  await page.waitForLoadState('networkidle');

  // ✅ Use accessible query (more reliable)
  const firstProduct = page.getByRole('article').first();
  await expect(firstProduct).toBeVisible();

  // ✅ Wait for button specifically
  const addButton = firstProduct.getByRole('button', { name: /add .* to cart/i });
  await expect(addButton).toBeEnabled();

  await addButton.click();

  // ✅ Verify action succeeded
  await expect(page.getByRole('status', { name: /cart/i })).toContainText('1');
});
```

**Fixes Applied:**
1. ✅ Wait for network idle (no race conditions)
2. ✅ Use accessible queries (less brittle)
3. ✅ Verify element visible and enabled
4. ✅ Assert action succeeded

### Phase 3: Add Retry Logic (30 min)

**Prompt to agent:**
```
Add retry logic to Playwright config for:
- Network failures (retry 2x)
- Flaky selectors (implicit wait 5s)
- Screenshot on failure
```

**Agent Output:**

```typescript
// playwright.config.ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
  retries: process.env.CI ? 2 : 0, // Retry in CI only

  use: {
    // Implicit wait for elements
    actionTimeout: 5000,
    navigationTimeout: 10000,

    // Screenshots on failure
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',

    // Trace on failure (debugging)
    trace: 'on-first-retry',
  },

  // Run tests in parallel
  workers: process.env.CI ? 2 : undefined,
});
```

### Phase 4: Validate Fix (30 min)

```bash
# Run tests 20 times to confirm fix
for i in {1..20}; do npm run test:e2e || break; done

# Result: 20/20 passing ✅

# Commit fix
git add tests/e2e/
git commit -m "fix(tests): resolve flaky product cart test

- Wait for network idle before interactions
- Use accessible queries (getByRole)
- Verify elements visible/enabled
- Assert action succeeded
- Add retry config for CI

Flakiness: 30% → 0% (20/20 runs passing)

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Results

**Time Saved:** 2-3 hours (with agents) vs 4-6 hours (manual) = ~50% faster

**Quality:**
- ✅ Root cause identified systematically
- ✅ Fix applied based on best practices
- ✅ Verified with multiple runs
- ✅ Flakiness eliminated (30% → 0%)

---

## Workflow 4: Performance Optimization

**Context:** Product listing page has slow Time to Interactive (TTI). Lighthouse score: 65. Need 90+.

**Stack:** Next.js + React + Webpack Bundle Analyzer

**Estimated Time:** 3-4 hours (with agents) vs 6-8 hours (manual)

### Phase 1: Identify Bottlenecks (1 hour)

#### Step 1: Run Lighthouse Audit

```bash
npm run lighthouse -- --url http://localhost:3000/products

# Results:
# - Performance: 65 (target: 90+)
# - TTI: 4.2s (target: <3s)
# - FCP: 2.1s (target: <1.8s)
# - LCP: 3.5s (target: <2.5s)
```

#### Step 2: Analyze Bundle Size

```bash
npm run analyze

# Results:
# - Total bundle: 850KB (too large)
# - @apollo/client: 150KB (necessary)
# - lodash: 120KB (unused utilities)
# - moment: 230KB (can replace with date-fns)
# - react-icons: 180KB (importing entire library)
```

#### Step 3: Load Component Agent for Optimization

```bash
# In Claude Code
# Load: .claude/agents/component-create.md
```

**Prompt to agent:**
```
Analyze bundle for ProductListingPage:
[paste webpack-bundle-analyzer output]

What can be optimized to reduce bundle size by 30%?
```

**Agent Response:**

```
Optimization opportunities:

1. Replace moment (230KB) with date-fns (10KB)
   - Savings: 220KB

2. Tree-shake lodash (only import used functions)
   - Current: import _ from 'lodash' (120KB)
   - Optimized: import debounce from 'lodash/debounce' (5KB)
   - Savings: 115KB

3. Optimize react-icons imports
   - Current: import { FaShoppingCart } from 'react-icons/fa' (180KB)
   - Optimized: import { FaShoppingCart } from 'react-icons/fa/FaShoppingCart' (5KB)
   - Savings: 175KB

4. Code-split ProductFilters
   - Current: Bundled with main page (45KB)
   - Optimized: Lazy load (below fold)
   - Savings: 45KB (from initial bundle)

Total potential savings: ~555KB (65% reduction)
```

### Phase 2: Apply Optimizations (1.5 hours)

#### Optimization 1: Replace moment with date-fns

**Prompt to agent:**
```
Replace all moment usage with date-fns in ProductListingPage
```

**Agent Output:**

```typescript
// BEFORE
import moment from 'moment';

function formatDate(date: string) {
  return moment(date).format('MMM D, YYYY');
}

// AFTER
import { format, parseISO } from 'date-fns';

function formatDate(date: string) {
  return format(parseISO(date), 'MMM d, yyyy');
}

// Savings: 220KB
```

#### Optimization 2: Tree-shake lodash

```typescript
// BEFORE
import _ from 'lodash';

const debouncedSearch = _.debounce(handleSearch, 300);

// AFTER
import debounce from 'lodash/debounce';

const debouncedSearch = debounce(handleSearch, 300);

// Savings: 115KB
```

#### Optimization 3: Optimize react-icons

```typescript
// BEFORE
import { FaShoppingCart, FaFilter, FaSearch } from 'react-icons/fa';

// AFTER (using tree-shakeable imports)
import FaShoppingCart from 'react-icons/fa/FaShoppingCart';
import FaFilter from 'react-icons/fa/FaFilter';
import FaSearch from 'react-icons/fa/FaSearch';

// Savings: 175KB
```

#### Optimization 4: Code-split ProductFilters

```typescript
// BEFORE
import { ProductFilters } from '@/components/ProductFilters';

// AFTER
import dynamic from 'next/dynamic';

const ProductFilters = dynamic(() => import('@/components/ProductFilters'), {
  loading: () => <div>Loading filters...</div>,
  ssr: false, // Not critical for SEO
});

// Savings: 45KB from initial bundle
```

### Phase 3: Image Optimization (1 hour)

**Prompt to agent:**
```
Optimize images in ProductCard:
- Lazy load images below fold
- Use next/image blur placeholder
- Optimize image formats (WebP)
- Implement responsive images
```

**Agent Output:**

```typescript
// src/components/ProductCard.tsx (optimized)
import Image from 'next/image';

export function ProductCard({ product }: ProductCardProps) {
  return (
    <article className="product-card">
      <div className="product-image">
        <Image
          src={product.imageUrl}
          alt={product.title}
          width={300}
          height={300}

          // ✅ Lazy loading
          loading="lazy"

          // ✅ Blur placeholder
          placeholder="blur"
          blurDataURL={product.blurDataUrl}

          // ✅ Modern formats
          formats={['image/webp', 'image/avif']}

          // ✅ Responsive sizing
          sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
        />
      </div>
      {/* ... */}
    </article>
  );
}
```

### Phase 4: Validate Improvements (30 min)

```bash
# Rebuild with optimizations
npm run build

# New bundle size
npm run analyze
# Result: 295KB (from 850KB) = 65% reduction ✅

# Run Lighthouse again
npm run lighthouse -- --url http://localhost:3000/products

# New Results:
# - Performance: 92 ✅ (was 65)
# - TTI: 2.1s ✅ (was 4.2s)
# - FCP: 1.2s ✅ (was 2.1s)
# - LCP: 1.8s ✅ (was 3.5s)

# Commit optimizations
git add .
git commit -m "perf(products): optimize bundle size and load times

Optimizations:
- Replace moment with date-fns (-220KB)
- Tree-shake lodash (-115KB)
- Optimize react-icons imports (-175KB)
- Code-split ProductFilters (-45KB from initial)
- Lazy load images with blur placeholders
- Use WebP/AVIF formats

Results:
- Bundle size: 850KB → 295KB (65% reduction)
- Lighthouse Performance: 65 → 92
- TTI: 4.2s → 2.1s (50% faster)
- LCP: 3.5s → 1.8s (49% faster)

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Results

**Time Saved:** 3-4 hours (with agents) vs 6-8 hours (manual) = ~50% faster

**Quality:**
- ✅ Bundle size reduced 65%
- ✅ Lighthouse score improved from 65 to 92
- ✅ TTI improved 50%
- ✅ All Core Web Vitals passing

---

## Summary: Cumulative Impact

### Time Savings Across Workflows

| Workflow | Manual Time | Agent Time | Savings |
|----------|-------------|------------|---------|
| Product Listing Page | 8-12h | 4-6h | 50% |
| GraphQL Integration | 6-8h | 3-4h | 50% |
| Debugging Flaky Tests | 4-6h | 2-3h | 50% |
| Performance Optimization | 6-8h | 3-4h | 50% |
| **Total** | **24-34h** | **12-17h** | **~50%** |

**Average:** ~17 hours saved per week

### Quality Improvements

**Code Quality:**
- ✅ 100% TypeScript coverage (no `any`)
- ✅ 80%+ test coverage on new code
- ✅ Accessibility (a11y) built into every component
- ✅ Performance optimizations applied systematically

**Developer Experience:**
- ✅ Faster iteration (validation in seconds)
- ✅ Fewer bugs (validation gates catch errors early)
- ✅ Better documentation (agents explain patterns)
- ✅ Consistent patterns (agents follow style guide)

### 12-Factor Principles Demonstrated

**Factor I:** Git tracks all agent changes (full history)
**Factor II:** Agents loaded JIT (only when needed)
**Factor III:** Single-responsibility agents (components, APIs, tests)
**Factor IV:** Validation gates (TypeScript, ESLint, tests)
**Factor V:** Explicit dependencies (package.json)
**Factor VI:** Session continuity (multi-day workflows)
**Factor VIII:** Stateless execution (reproducible builds)
**Factor X:** Dev/prod parity (same config everywhere)
**Factor XII:** Transparency (commit messages show what/why)

---

## What's Next?

1. **Try these workflows** - Copy `.claude/` to your project
2. **Adapt to your stack** - Vue/Svelte/other frameworks
3. **Measure your results** - Track time saved, quality improved
4. **Share learnings** - Contribute improvements back

**Questions?** See [README.md](README.md) for more details.

---

**Web development with AI agents done right.**

Faster iteration. Higher quality. Production-ready code.

**Load an agent. Ship features.**
