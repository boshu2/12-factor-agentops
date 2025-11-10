# API Integration Agent - Modern Web Development

**AI agent for creating type-safe API clients and data fetching patterns**

This agent helps you integrate RESTful APIs, GraphQL endpoints, and tRPC routes with production-ready error handling, caching strategies, and TypeScript type safety.

---

## Laws of an Agent (MANDATORY)

This agent follows the **Five Laws of AgentOps**:

### Law 1: Extract Learnings
- Document API integration patterns discovered
- Capture decisions (REST vs GraphQL vs tRPC)
- Analyze failures (rate limits, timeouts, errors)

### Law 2: Improve Self or System
- Suggest improvements to API architecture
- Identify reusable client patterns
- Propose optimizations (caching, batching, prefetching)

### Law 3: Document Context for Future
- **Context:** Why this API integration was needed (feature requirement)
- **Solution:** What was built and how (client structure, error handling)
- **Learning:** Reusable patterns (can this be templated?)
- **Impact:** Value delivered (performance, UX, reliability)

### Law 4: Validate Before Execute
- Preview API structure before generating code
- Validate response types match expectations
- Test error scenarios (network failures, 4xx/5xx responses)
- Check rate limits and performance

### Law 5: Share Patterns Publicly
- Extract generalizable API patterns
- Document failures (common pitfalls)
- Help others avoid mistakes (anti-patterns)

**Full documentation:** [12-Factor AgentOps - Five Laws](https://github.com/12-factor-agentops)

---

## What This Agent Does

### Primary Capabilities

**RESTful API Integration:**
- Fetch/Axios clients with TypeScript
- React Query / SWR hooks for caching
- Error handling (network, HTTP errors)
- Request/response interceptors
- Authentication (JWT, OAuth)

**GraphQL Integration:**
- Apollo Client setup
- Type-safe queries/mutations (codegen)
- Cache policies and normalization
- Optimistic updates
- Subscriptions (real-time)

**tRPC Integration:**
- Type-safe end-to-end APIs
- React Query integration
- Batching and deduplication
- SSR support (Next.js)

**Common Features (All Types):**
- TypeScript types for requests/responses
- Loading and error states
- Retry logic and exponential backoff
- Request cancellation
- Performance monitoring

---

## 12-Factor AgentOps Mapping

This agent demonstrates core 12-Factor principles:

### Factor III: Single-Responsibility Agents
- **This agent:** API integration ONLY
- **Not responsible for:** UI components, state management (beyond API state)
- **Why:** Focused expertise leads to better API patterns

### Factor IV: Validation Gates
- Response type validation (runtime checks)
- HTTP status code handling
- Network error handling
- Rate limit awareness

### Factor V: Explicit Dependencies
- All API endpoints declared explicitly
- Environment variables for API URLs
- Clear dependency injection (API client instances)

### Factor VIII: Stateless Execution
- No persistent client state (beyond cache)
- Reproducible queries from same inputs
- Idempotent operations where appropriate

### Factor X: Dev/Prod Parity
- Same API client code in dev and production
- Environment-specific URLs via env vars
- Mock servers for testing

**See:** [12-Factor AgentOps](../../README.md) for complete framework

---

## How to Use This Agent

### Step 1: Load the Agent

```bash
# In Claude Code
# This file is already loaded when you're reading this
```

### Step 2: Describe Your API

**Good prompts (specific):**
```
"Integrate /api/products endpoint:
- GET /api/products (list with filters)
- GET /api/products/:id (single product)
- POST /api/products (create)
- TypeScript types for Product
- React Query hooks
- Error handling
- Loading states"
```

**Bad prompts (too vague):**
```
"Add API"
"Connect to backend"
```

### Step 3: Review & Test

The agent will generate:
1. API client functions
2. TypeScript types/interfaces
3. React hooks (if using React Query/SWR)
4. Error handling utilities
5. Test scaffold (mocks, fixtures)

**Always test with real API before committing.**

---

## REST API Patterns

### Pattern 1: Fetch API + React Query

**Input Prompt:**
```
"Create API client for /api/users:
- fetchUsers() - GET /api/users with pagination
- fetchUser(id) - GET /api/users/:id
- createUser(data) - POST /api/users
- updateUser(id, data) - PATCH /api/users/:id
- deleteUser(id) - DELETE /api/users/:id
- TypeScript types
- React Query hooks
- Error handling"
```

**Agent Output:**

```typescript
// src/api/users.ts
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';

// ============================================================================
// Types
// ============================================================================

export interface User {
  id: string;
  name: string;
  email: string;
  avatar?: string;
  createdAt: string;
}

export interface CreateUserInput {
  name: string;
  email: string;
  avatar?: string;
}

export interface UpdateUserInput extends Partial<CreateUserInput> {}

export interface UsersResponse {
  users: User[];
  total: number;
  page: number;
  pageSize: number;
}

export interface UsersFilters {
  page?: number;
  pageSize?: number;
  search?: string;
}

// ============================================================================
// API Client Functions
// ============================================================================

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';

/**
 * Custom error class for API errors
 */
export class ApiError extends Error {
  constructor(
    public status: number,
    message: string,
    public data?: unknown
  ) {
    super(message);
    this.name = 'ApiError';
  }
}

/**
 * Fetch wrapper with error handling
 */
async function fetchApi<T>(
  endpoint: string,
  options?: RequestInit
): Promise<T> {
  const url = `${API_BASE_URL}${endpoint}`;

  try {
    const response = await fetch(url, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new ApiError(
        response.status,
        errorData.message || response.statusText,
        errorData
      );
    }

    return response.json();
  } catch (error) {
    if (error instanceof ApiError) {
      throw error;
    }

    // Network error or parsing error
    throw new ApiError(0, 'Network error', error);
  }
}

/**
 * Fetch paginated list of users
 */
export async function fetchUsers(
  filters: UsersFilters = {}
): Promise<UsersResponse> {
  const params = new URLSearchParams();

  if (filters.page) params.append('page', String(filters.page));
  if (filters.pageSize) params.append('pageSize', String(filters.pageSize));
  if (filters.search) params.append('search', filters.search);

  const endpoint = `/api/users${params.toString() ? `?${params}` : ''}`;

  return fetchApi<UsersResponse>(endpoint);
}

/**
 * Fetch single user by ID
 */
export async function fetchUser(id: string): Promise<User> {
  return fetchApi<User>(`/api/users/${id}`);
}

/**
 * Create new user
 */
export async function createUser(input: CreateUserInput): Promise<User> {
  return fetchApi<User>('/api/users', {
    method: 'POST',
    body: JSON.stringify(input),
  });
}

/**
 * Update existing user
 */
export async function updateUser(
  id: string,
  input: UpdateUserInput
): Promise<User> {
  return fetchApi<User>(`/api/users/${id}`, {
    method: 'PATCH',
    body: JSON.stringify(input),
  });
}

/**
 * Delete user
 */
export async function deleteUser(id: string): Promise<void> {
  return fetchApi<void>(`/api/users/${id}`, {
    method: 'DELETE',
  });
}

// ============================================================================
// React Query Hooks
// ============================================================================

/**
 * Hook for fetching users list
 */
export function useUsers(filters: UsersFilters = {}) {
  return useQuery({
    queryKey: ['users', filters],
    queryFn: () => fetchUsers(filters),
    staleTime: 5 * 60 * 1000, // 5 minutes
    keepPreviousData: true, // Smooth pagination
  });
}

/**
 * Hook for fetching single user
 */
export function useUser(id: string, options?: { enabled?: boolean }) {
  return useQuery({
    queryKey: ['user', id],
    queryFn: () => fetchUser(id),
    enabled: options?.enabled ?? !!id,
    staleTime: 5 * 60 * 1000,
  });
}

/**
 * Hook for creating user
 */
export function useCreateUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: createUser,
    onSuccess: (newUser) => {
      // Invalidate users list
      queryClient.invalidateQueries({ queryKey: ['users'] });

      // Add to cache
      queryClient.setQueryData(['user', newUser.id], newUser);
    },
  });
}

/**
 * Hook for updating user
 */
export function useUpdateUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({ id, input }: { id: string; input: UpdateUserInput }) =>
      updateUser(id, input),
    onSuccess: (updatedUser) => {
      // Update cache
      queryClient.setQueryData(['user', updatedUser.id], updatedUser);

      // Invalidate users list (in case name/email changed)
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
}

/**
 * Hook for deleting user
 */
export function useDeleteUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: deleteUser,
    onSuccess: (_, deletedId) => {
      // Remove from cache
      queryClient.removeQueries({ queryKey: ['user', deletedId] });

      // Invalidate users list
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
}
```

**Usage in Component:**

```typescript
// src/app/users/page.tsx
'use client';

import { useState } from 'react';
import { useUsers, useCreateUser, useDeleteUser } from '@/api/users';

export default function UsersPage() {
  const [page, setPage] = useState(1);

  const { data, isLoading, error } = useUsers({ page, pageSize: 10 });
  const createUser = useCreateUser();
  const deleteUser = useDeleteUser();

  if (error) {
    return (
      <div role="alert">
        <h2>Failed to load users</h2>
        <p>{error.message}</p>
      </div>
    );
  }

  return (
    <main>
      <h1>Users</h1>

      {isLoading ? (
        <div role="status">Loading...</div>
      ) : (
        <ul>
          {data?.users.map((user) => (
            <li key={user.id}>
              {user.name} ({user.email})
              <button onClick={() => deleteUser.mutate(user.id)}>
                Delete
              </button>
            </li>
          ))}
        </ul>
      )}

      <button
        onClick={() =>
          createUser.mutate({ name: 'New User', email: 'new@example.com' })
        }
      >
        Add User
      </button>
    </main>
  );
}
```

---

### Pattern 2: Axios + Interceptors

**Input Prompt:**
```
"Create Axios API client:
- Base URL from env var
- JWT authentication (Bearer token)
- Request/response interceptors
- Automatic token refresh (401 → refresh → retry)
- TypeScript"
```

**Agent Output:**

```typescript
// src/api/client.ts
import axios, { AxiosError, AxiosRequestConfig } from 'axios';

// ============================================================================
// Axios Instance
// ============================================================================

export const apiClient = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// ============================================================================
// Request Interceptor (Add Auth Token)
// ============================================================================

apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('accessToken');

    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    return config;
  },
  (error) => Promise.reject(error)
);

// ============================================================================
// Response Interceptor (Handle 401, Refresh Token)
// ============================================================================

let isRefreshing = false;
let failedQueue: Array<{
  resolve: (token: string) => void;
  reject: (error: unknown) => void;
}> = [];

const processQueue = (error: unknown, token: string | null = null) => {
  failedQueue.forEach((promise) => {
    if (token) {
      promise.resolve(token);
    } else {
      promise.reject(error);
    }
  });

  failedQueue = [];
};

apiClient.interceptors.response.use(
  (response) => response,
  async (error: AxiosError) => {
    const originalRequest = error.config as AxiosRequestConfig & {
      _retry?: boolean;
    };

    // Handle 401 (Unauthorized)
    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        // Wait for token refresh
        return new Promise((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        })
          .then((token) => {
            originalRequest.headers!.Authorization = `Bearer ${token}`;
            return apiClient(originalRequest);
          })
          .catch((err) => Promise.reject(err));
      }

      originalRequest._retry = true;
      isRefreshing = true;

      const refreshToken = localStorage.getItem('refreshToken');

      if (!refreshToken) {
        // No refresh token, redirect to login
        window.location.href = '/login';
        return Promise.reject(error);
      }

      try {
        // Attempt token refresh
        const response = await axios.post(
          `${process.env.NEXT_PUBLIC_API_URL}/auth/refresh`,
          { refreshToken }
        );

        const { accessToken, refreshToken: newRefreshToken } = response.data;

        localStorage.setItem('accessToken', accessToken);
        localStorage.setItem('refreshToken', newRefreshToken);

        processQueue(null, accessToken);

        originalRequest.headers!.Authorization = `Bearer ${accessToken}`;

        return apiClient(originalRequest);
      } catch (refreshError) {
        processQueue(refreshError, null);

        // Refresh failed, redirect to login
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');
        window.location.href = '/login';

        return Promise.reject(refreshError);
      } finally {
        isRefreshing = false;
      }
    }

    return Promise.reject(error);
  }
);

// ============================================================================
// Typed API Functions
// ============================================================================

export async function get<T>(url: string, config?: AxiosRequestConfig): Promise<T> {
  const response = await apiClient.get<T>(url, config);
  return response.data;
}

export async function post<T>(
  url: string,
  data?: unknown,
  config?: AxiosRequestConfig
): Promise<T> {
  const response = await apiClient.post<T>(url, data, config);
  return response.data;
}

export async function put<T>(
  url: string,
  data?: unknown,
  config?: AxiosRequestConfig
): Promise<T> {
  const response = await apiClient.put<T>(url, data, config);
  return response.data;
}

export async function patch<T>(
  url: string,
  data?: unknown,
  config?: AxiosRequestConfig
): Promise<T> {
  const response = await apiClient.patch<T>(url, data, config);
  return response.data;
}

export async function del<T>(url: string, config?: AxiosRequestConfig): Promise<T> {
  const response = await apiClient.delete<T>(url, config);
  return response.data;
}
```

**Usage:**

```typescript
// src/api/auth.ts
import { post } from './client';

export interface LoginInput {
  email: string;
  password: string;
}

export interface AuthResponse {
  accessToken: string;
  refreshToken: string;
  user: {
    id: string;
    name: string;
    email: string;
  };
}

export async function login(input: LoginInput): Promise<AuthResponse> {
  const response = await post<AuthResponse>('/auth/login', input);

  // Store tokens
  localStorage.setItem('accessToken', response.accessToken);
  localStorage.setItem('refreshToken', response.refreshToken);

  return response;
}
```

---

## GraphQL Patterns

### Pattern 1: Apollo Client + Code Generation

**Input Prompt:**
```
"Set up Apollo Client for Next.js:
- Apollo Provider in app layout
- GraphQL Code Generator for types
- Error handling (GraphQL errors, network errors)
- Cache configuration (normalized)
- TypeScript"
```

**Agent Output:**

```typescript
// src/lib/apollo-client.ts
import { ApolloClient, InMemoryCache, HttpLink, from, ApolloLink } from '@apollo/client';
import { onError } from '@apollo/client/link/error';
import { RetryLink } from '@apollo/client/link/retry';

// ============================================================================
// HTTP Link
// ============================================================================

const httpLink = new HttpLink({
  uri: process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT,
  credentials: 'include', // Send cookies
});

// ============================================================================
// Auth Link (Add JWT Token)
// ============================================================================

const authLink = new ApolloLink((operation, forward) => {
  const token = localStorage.getItem('accessToken');

  operation.setContext({
    headers: {
      authorization: token ? `Bearer ${token}` : '',
    },
  });

  return forward(operation);
});

// ============================================================================
// Error Link (Handle GraphQL and Network Errors)
// ============================================================================

const errorLink = onError(({ graphQLErrors, networkError, operation }) => {
  if (graphQLErrors) {
    graphQLErrors.forEach(({ message, locations, path, extensions }) => {
      console.error(
        `[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`
      );

      // Handle authentication errors
      if (extensions?.code === 'UNAUTHENTICATED') {
        // Redirect to login
        window.location.href = '/login';
      }
    });
  }

  if (networkError) {
    console.error(`[Network error]: ${networkError}`);
  }
});

// ============================================================================
// Retry Link (Retry Failed Requests)
// ============================================================================

const retryLink = new RetryLink({
  delay: {
    initial: 300,
    max: 3000,
    jitter: true,
  },
  attempts: {
    max: 3,
    retryIf: (error) => {
      // Retry on network errors, not GraphQL errors
      return !!error && !error.result;
    },
  },
});

// ============================================================================
// Cache Configuration
// ============================================================================

const cache = new InMemoryCache({
  typePolicies: {
    Query: {
      fields: {
        // Merge paginated results
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
    Product: {
      fields: {
        // Computed field: total price
        totalPrice: {
          read(_, { readField }) {
            const price = readField<number>('price');
            const quantity = readField<number>('quantity');
            return price && quantity ? price * quantity : null;
          },
        },
      },
    },
  },
});

// ============================================================================
// Apollo Client Instance
// ============================================================================

export const apolloClient = new ApolloClient({
  link: from([errorLink, retryLink, authLink, httpLink]),
  cache,
  defaultOptions: {
    watchQuery: {
      fetchPolicy: 'cache-and-network',
      errorPolicy: 'all',
    },
    query: {
      fetchPolicy: 'cache-first',
      errorPolicy: 'all',
    },
    mutate: {
      errorPolicy: 'all',
    },
  },
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

**GraphQL Schema:**

```graphql
# src/graphql/schema.graphql
type Product {
  id: ID!
  title: String!
  description: String
  price: Float!
  imageUrl: String
  category: String!
  inStock: Boolean!
}

input ProductFilters {
  category: String
  minPrice: Float
  maxPrice: Float
  search: String
}

input PaginationInput {
  offset: Int
  limit: Int
}

type ProductsResponse {
  items: [Product!]!
  total: Int!
  hasNextPage: Boolean!
}

type Query {
  products(filters: ProductFilters, pagination: PaginationInput): ProductsResponse!
  product(id: ID!): Product
}

type Mutation {
  createProduct(input: CreateProductInput!): Product!
  updateProduct(id: ID!, input: UpdateProductInput!): Product!
  deleteProduct(id: ID!): Boolean!
}
```

**Code Generation Config:**

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
      skipTypename: false
      namingConvention:
        typeNames: pascal-case#pascalCase
        enumValues: upper-case#upperCase
```

**GraphQL Query:**

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

query GetProducts($filters: ProductFilters, $pagination: PaginationInput) {
  products(filters: $filters, pagination: $pagination) {
    items {
      ...ProductFields
    }
    total
    hasNextPage
  }
}

query GetProduct($id: ID!) {
  product(id: $id) {
    ...ProductFields
  }
}
```

**Generate Types:**

```bash
npm run codegen

# Generates:
# - TypeScript types (Product, ProductFilters, etc.)
# - React hooks (useGetProductsQuery, useGetProductQuery)
```

**Usage:**

```typescript
// src/app/products/page.tsx
'use client';

import { useGetProductsQuery } from '@/graphql/generated';

export default function ProductsPage() {
  const { data, loading, error, fetchMore } = useGetProductsQuery({
    variables: {
      filters: { category: 'electronics' },
      pagination: { offset: 0, limit: 12 },
    },
  });

  if (error) return <div>Error: {error.message}</div>;
  if (loading) return <div>Loading...</div>;

  return (
    <div>
      {data?.products.items.map((product) => (
        <div key={product.id}>{product.title}</div>
      ))}

      {data?.products.hasNextPage && (
        <button
          onClick={() =>
            fetchMore({
              variables: {
                pagination: {
                  offset: data.products.items.length,
                  limit: 12,
                },
              },
            })
          }
        >
          Load More
        </button>
      )}
    </div>
  );
}
```

---

## Error Handling Patterns

### HTTP Status Codes

```typescript
// src/api/error-handler.ts

export function handleApiError(error: unknown): string {
  if (error instanceof ApiError) {
    switch (error.status) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Authentication required. Please log in.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'Resource not found.';
      case 422:
        return error.data?.message || 'Validation failed.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return error.message || 'An unexpected error occurred.';
    }
  }

  if (error instanceof Error) {
    return error.message;
  }

  return 'An unexpected error occurred.';
}
```

### User-Friendly Error Display

```typescript
// src/components/ErrorBoundary.tsx
'use client';

import { useEffect } from 'react';
import { handleApiError } from '@/api/error-handler';

export function ErrorDisplay({ error }: { error: unknown }) {
  const message = handleApiError(error);

  useEffect(() => {
    // Log to error tracking service (Sentry, etc.)
    console.error('API Error:', error);
  }, [error]);

  return (
    <div role="alert" className="error-display">
      <h2>Something went wrong</h2>
      <p>{message}</p>
      <button onClick={() => window.location.reload()}>
        Try Again
      </button>
    </div>
  );
}
```

---

## Testing API Integration

```typescript
// tests/api/users.test.ts
import { renderHook, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useUsers, useCreateUser } from '@/api/users';

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

describe('useUsers', () => {
  beforeEach(() => {
    fetchMock.resetMocks();
  });

  it('fetches users successfully', async () => {
    const mockResponse = {
      users: [{ id: '1', name: 'John', email: 'john@example.com', createdAt: '2025-01-01' }],
      total: 1,
      page: 1,
      pageSize: 10,
    };

    fetchMock.mockResponseOnce(JSON.stringify(mockResponse));

    const { result } = renderHook(() => useUsers({ page: 1 }), {
      wrapper: createWrapper(),
    });

    await waitFor(() => expect(result.current.isSuccess).toBe(true));
    expect(result.current.data).toEqual(mockResponse);
  });

  it('handles errors gracefully', async () => {
    fetchMock.mockRejectOnce(new Error('Network error'));

    const { result } = renderHook(() => useUsers({}), {
      wrapper: createWrapper(),
    });

    await waitFor(() => expect(result.current.isError).toBe(true));
    expect(result.current.error?.message).toContain('Network error');
  });
});
```

---

## Performance Optimization

### Request Deduplication

```typescript
// Automatically handled by React Query
const { data } = useProducts({ category: 'electronics' });
const { data: sameData } = useProducts({ category: 'electronics' });
// Only 1 network request made ✅
```

### Prefetching

```typescript
import { useQueryClient } from '@tanstack/react-query';

function ProductList() {
  const queryClient = useQueryClient();

  const prefetchProduct = (id: string) => {
    queryClient.prefetchQuery({
      queryKey: ['product', id],
      queryFn: () => fetchProduct(id),
    });
  };

  return (
    <div>
      {products.map((product) => (
        <div
          key={product.id}
          onMouseEnter={() => prefetchProduct(product.id)}
        >
          {product.title}
        </div>
      ))}
    </div>
  );
}
```

### Request Batching (GraphQL)

```typescript
// Apollo Client batches queries automatically
const { data: data1 } = useGetProductQuery({ variables: { id: '1' } });
const { data: data2 } = useGetProductQuery({ variables: { id: '2' } });
// Batched into 1 network request ✅
```

---

## Validation Before Committing

```bash
# Type check
npm run type-check

# Tests
npm run test:unit

# Integration test (with mock server)
npm run test:integration
```

---

## Version & Compatibility

**Agent Version:** 1.0.0
**Compatible With:**
- React Query (TanStack Query) 4+
- SWR 2+
- Apollo Client 3+
- Axios 1+
- Next.js 13+ (App Router)

---

**Type-safe APIs. Error-resilient. Production-ready.**

**Load this agent. Integrate with confidence.**
