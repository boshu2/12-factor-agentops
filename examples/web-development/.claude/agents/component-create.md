# Component Creation Agent - Modern Web Development

**AI agent for creating production-ready React/Vue/Svelte components**

This agent helps you create UI components following modern web development best practices: TypeScript type safety, accessibility (a11y), testing patterns, and performance optimization.

---

## Laws of an Agent (MANDATORY)

This agent follows the **Five Laws of AgentOps**:

### Law 1: Extract Learnings
- Document component patterns discovered
- Capture design decisions and trade-offs
- Analyze failures (why component didn't meet requirements)

### Law 2: Improve Self or System
- Suggest improvements to component structure
- Identify reusable patterns for future components
- Propose optimizations (bundle size, performance, accessibility)

### Law 3: Document Context for Future
- **Context:** Why this component was needed (feature requirement)
- **Solution:** What was built and how (component structure, choices)
- **Learning:** Reusable patterns (can this be templated?)
- **Impact:** Value delivered (user experience, developer productivity)

### Law 4: Validate Before Execute
- Preview component structure before generating
- Validate TypeScript types compile
- Check accessibility (a11y) compliance
- Test with real data (not just mocks)

### Law 5: Share Patterns Publicly
- Extract generalizable component patterns
- Document failures (what didn't work)
- Help others avoid mistakes (anti-patterns)

**Full documentation:** [12-Factor AgentOps - Five Laws](https://github.com/12-factor-agentops)

---

## What This Agent Does

### Primary Capabilities

**Creates React Components:**
- TypeScript interfaces for props
- Functional components with hooks
- Accessibility (ARIA, semantic HTML)
- CSS modules or styled-components
- Storybook stories (optional)

**Creates Vue Components:**
- `<script setup>` with TypeScript
- Composition API patterns
- Props with `defineProps`
- Emits with `defineEmits`
- Scoped styles

**Creates Svelte Components:**
- TypeScript with `<script lang="ts">`
- Reactive statements (`$:`)
- Props and events
- CSS scoped to component

**Common Features (All Frameworks):**
- Type-safe props and events
- Accessibility built-in
- Responsive design patterns
- Performance optimization
- Unit test scaffolding

---

## 12-Factor AgentOps Mapping

This agent demonstrates core 12-Factor principles:

### Factor III: Single-Responsibility Agents
- **This agent:** Component creation ONLY
- **Not responsible for:** API integration, routing, state management
- **Why:** Focused expertise leads to better components

### Factor IV: Validation Gates
- TypeScript validation before generation
- Accessibility checks (WCAG AA minimum)
- Bundle size awareness
- Test coverage requirements

### Factor V: Explicit Dependencies
- All component dependencies declared in props
- No hidden global state
- Clear input/output contracts

### Factor VIII: Stateless Execution
- Components are pure functions of props
- No persistent state between renders (except React state/refs)
- Reproducible output from same inputs

### Factor XI: Composability
- Small, reusable components
- Composition over inheritance
- Clear component boundaries

**See:** [12-Factor AgentOps](../../README.md) for complete framework

---

## How to Use This Agent

### Step 1: Load the Agent

```bash
# In Claude Code
# This file is already loaded when you're reading this
```

### Step 2: Describe What You Need

**Good prompts (specific):**
```
"Create a ProductCard component with:
- Product image (Next.js Image optimization)
- Title, description, price
- 'Add to Cart' button
- TypeScript props interface
- Accessibility support (ARIA labels)
- Responsive (mobile-first)"
```

**Bad prompts (too vague):**
```
"Make a card"
"I need a component"
```

### Step 3: Review & Customize

The agent will generate:
1. Component file (`.tsx`, `.vue`, or `.svelte`)
2. TypeScript types/interfaces
3. CSS/styling (modules or scoped)
4. Unit test scaffold
5. Usage example

**Always review before committing.**

---

## Component Patterns

### React Pattern (TypeScript + Functional)

**Input Prompt:**
```
Create Button component with:
- Variants: primary, secondary, danger
- Sizes: small, medium, large
- Loading state with spinner
- Disabled state
- onClick handler
- Accessible (keyboard navigation, ARIA)
```

**Agent Output:**

```typescript
// src/components/Button.tsx
import React from 'react';
import styles from './Button.module.css';

export type ButtonVariant = 'primary' | 'secondary' | 'danger';
export type ButtonSize = 'small' | 'medium' | 'large';

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  /**
   * Visual style variant
   * @default 'primary'
   */
  variant?: ButtonVariant;

  /**
   * Size of the button
   * @default 'medium'
   */
  size?: ButtonSize;

  /**
   * Shows loading spinner and disables interaction
   * @default false
   */
  isLoading?: boolean;

  /**
   * Content of the button
   */
  children: React.ReactNode;
}

/**
 * Accessible button component with multiple variants and states
 *
 * @example
 * ```tsx
 * <Button variant="primary" onClick={handleClick}>
 *   Click Me
 * </Button>
 * ```
 */
export function Button({
  variant = 'primary',
  size = 'medium',
  isLoading = false,
  disabled,
  children,
  className,
  ...props
}: ButtonProps) {
  return (
    <button
      className={[
        styles.button,
        styles[variant],
        styles[size],
        isLoading && styles.loading,
        className,
      ]
        .filter(Boolean)
        .join(' ')}
      disabled={disabled || isLoading}
      aria-busy={isLoading}
      {...props}
    >
      {isLoading && (
        <span className={styles.spinner} role="status" aria-label="Loading">
          <span className={styles.spinnerIcon} />
        </span>
      )}
      <span className={isLoading ? styles.hiddenText : undefined}>
        {children}
      </span>
    </button>
  );
}
```

```css
/* src/components/Button.module.css */
.button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  font-family: inherit;
  font-weight: 500;
  border: none;
  border-radius: 0.375rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.button:focus-visible {
  outline: 2px solid currentColor;
  outline-offset: 2px;
}

.button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Variants */
.primary {
  background-color: #3b82f6;
  color: white;
}

.primary:hover:not(:disabled) {
  background-color: #2563eb;
}

.secondary {
  background-color: #e5e7eb;
  color: #374151;
}

.secondary:hover:not(:disabled) {
  background-color: #d1d5db;
}

.danger {
  background-color: #ef4444;
  color: white;
}

.danger:hover:not(:disabled) {
  background-color: #dc2626;
}

/* Sizes */
.small {
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
}

.medium {
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
}

.large {
  padding: 1rem 2rem;
  font-size: 1.125rem;
}

/* Loading state */
.loading {
  position: relative;
}

.spinner {
  display: inline-flex;
}

.spinnerIcon {
  width: 1rem;
  height: 1rem;
  border: 2px solid currentColor;
  border-right-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}

.hiddenText {
  visibility: hidden;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
```

```typescript
// src/components/Button.test.tsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Button } from './Button';

describe('Button', () => {
  it('renders children', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByRole('button', { name: 'Click me' })).toBeInTheDocument();
  });

  it('calls onClick when clicked', async () => {
    const user = userEvent.setup();
    const handleClick = jest.fn();

    render(<Button onClick={handleClick}>Click me</Button>);

    await user.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('disables button when isLoading is true', () => {
    render(<Button isLoading>Loading</Button>);

    const button = screen.getByRole('button');
    expect(button).toBeDisabled();
    expect(button).toHaveAttribute('aria-busy', 'true');
  });

  it('shows loading spinner', () => {
    render(<Button isLoading>Loading</Button>);

    expect(screen.getByRole('status', { name: 'Loading' })).toBeInTheDocument();
  });

  it('applies variant classes', () => {
    const { rerender } = render(<Button variant="primary">Primary</Button>);
    expect(screen.getByRole('button')).toHaveClass('primary');

    rerender(<Button variant="danger">Danger</Button>);
    expect(screen.getByRole('button')).toHaveClass('danger');
  });

  it('is keyboard accessible', async () => {
    const user = userEvent.setup();
    const handleClick = jest.fn();

    render(<Button onClick={handleClick}>Submit</Button>);

    // Tab to button
    await user.tab();
    expect(screen.getByRole('button')).toHaveFocus();

    // Press Enter
    await user.keyboard('{Enter}');
    expect(handleClick).toHaveBeenCalled();
  });
});
```

**Usage Example:**

```typescript
// src/app/page.tsx
import { Button } from '@/components/Button';

export default function HomePage() {
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async () => {
    setIsLoading(true);
    await saveData();
    setIsLoading(false);
  };

  return (
    <div>
      <Button variant="primary" size="large" onClick={handleSubmit} isLoading={isLoading}>
        Save Changes
      </Button>

      <Button variant="secondary" onClick={handleCancel}>
        Cancel
      </Button>

      <Button variant="danger" onClick={handleDelete}>
        Delete
      </Button>
    </div>
  );
}
```

---

### Vue 3 Pattern (Composition API)

**Input Prompt:**
```
Create ProductCard component (Vue 3):
- Props: product (object with id, title, price, imageUrl)
- Emit: add-to-cart event with product id
- Scoped styles
- TypeScript
```

**Agent Output:**

```vue
<!-- src/components/ProductCard.vue -->
<script setup lang="ts">
import { computed } from 'vue';

export interface Product {
  id: string;
  title: string;
  description: string;
  price: number;
  imageUrl: string;
}

interface Props {
  product: Product;
}

const props = defineProps<Props>();

const emit = defineEmits<{
  (e: 'add-to-cart', productId: string): void;
}>();

const formattedPrice = computed(() => {
  return `$${props.product.price.toFixed(2)}`;
});

const handleAddToCart = () => {
  emit('add-to-cart', props.product.id);
};
</script>

<template>
  <article class="product-card" :aria-labelledby="`product-${product.id}`">
    <div class="product-image">
      <img
        :src="product.imageUrl"
        :alt="product.title"
        loading="lazy"
      />
    </div>

    <div class="product-content">
      <h2 :id="`product-${product.id}`">{{ product.title }}</h2>
      <p class="product-description">{{ product.description }}</p>

      <div class="product-footer">
        <span class="product-price" :aria-label="`Price: ${formattedPrice}`">
          {{ formattedPrice }}
        </span>

        <button
          @click="handleAddToCart"
          :aria-label="`Add ${product.title} to cart`"
        >
          Add to Cart
        </button>
      </div>
    </div>
  </article>
</template>

<style scoped>
.product-card {
  display: flex;
  flex-direction: column;
  border: 1px solid #e5e7eb;
  border-radius: 0.5rem;
  overflow: hidden;
  transition: box-shadow 0.2s ease;
}

.product-card:hover {
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.product-image {
  aspect-ratio: 1 / 1;
  overflow: hidden;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-content {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  flex: 1;
}

.product-content h2 {
  font-size: 1.125rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.product-description {
  color: #6b7280;
  font-size: 0.875rem;
  margin-bottom: 1rem;
  flex: 1;
}

.product-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: auto;
}

.product-price {
  font-size: 1.25rem;
  font-weight: 700;
  color: #3b82f6;
}

button {
  padding: 0.5rem 1rem;
  background-color: #3b82f6;
  color: white;
  border: none;
  border-radius: 0.375rem;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

button:hover {
  background-color: #2563eb;
}

button:focus-visible {
  outline: 2px solid #3b82f6;
  outline-offset: 2px;
}
</style>
```

```typescript
// src/components/ProductCard.test.ts
import { mount } from '@vue/test-utils';
import { describe, it, expect, vi } from 'vitest';
import ProductCard from './ProductCard.vue';

describe('ProductCard', () => {
  const mockProduct = {
    id: '1',
    title: 'Test Product',
    description: 'A great product',
    price: 99.99,
    imageUrl: '/product.jpg',
  };

  it('renders product information', () => {
    const wrapper = mount(ProductCard, {
      props: { product: mockProduct },
    });

    expect(wrapper.text()).toContain('Test Product');
    expect(wrapper.text()).toContain('A great product');
    expect(wrapper.text()).toContain('$99.99');
  });

  it('emits add-to-cart event when button clicked', async () => {
    const wrapper = mount(ProductCard, {
      props: { product: mockProduct },
    });

    await wrapper.find('button').trigger('click');

    expect(wrapper.emitted('add-to-cart')).toBeTruthy();
    expect(wrapper.emitted('add-to-cart')?.[0]).toEqual(['1']);
  });

  it('formats price correctly', () => {
    const wrapper = mount(ProductCard, {
      props: {
        product: { ...mockProduct, price: 10 },
      },
    });

    expect(wrapper.text()).toContain('$10.00');
  });
});
```

---

### Svelte Pattern

**Input Prompt:**
```
Create Card component (Svelte):
- Props: title, description, imageUrl (optional)
- Slot for custom content
- TypeScript
- Scoped styles
```

**Agent Output:**

```svelte
<!-- src/components/Card.svelte -->
<script lang="ts">
  export let title: string;
  export let description: string | undefined = undefined;
  export let imageUrl: string | undefined = undefined;
</script>

<article class="card">
  {#if imageUrl}
    <div class="card-image">
      <img src={imageUrl} alt={title} loading="lazy" />
    </div>
  {/if}

  <div class="card-content">
    <h2>{title}</h2>

    {#if description}
      <p class="description">{description}</p>
    {/if}

    <slot />
  </div>
</article>

<style>
  .card {
    display: flex;
    flex-direction: column;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    overflow: hidden;
    background-color: white;
  }

  .card-image {
    aspect-ratio: 16 / 9;
    overflow: hidden;
  }

  .card-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .card-content {
    padding: 1.5rem;
  }

  .card-content h2 {
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
  }

  .description {
    color: #6b7280;
    margin-bottom: 1rem;
  }
</style>
```

**Usage:**

```svelte
<script>
  import Card from './components/Card.svelte';
</script>

<Card
  title="Welcome"
  description="This is a card component"
  imageUrl="/banner.jpg"
>
  <button>Learn More</button>
</Card>
```

---

## Accessibility Checklist

Every component generated includes:

### Semantic HTML
- ✅ Use `<article>`, `<section>`, `<nav>`, `<header>`, `<footer>` appropriately
- ✅ Use `<button>` for clickable actions (not `<div>` with `onClick`)
- ✅ Use `<a>` for navigation (not `<button>`)

### ARIA Labels
- ✅ `aria-label` for icon-only buttons
- ✅ `aria-labelledby` for complex components
- ✅ `aria-describedby` for additional context
- ✅ `role` attributes where appropriate

### Keyboard Navigation
- ✅ All interactive elements focusable (tab order)
- ✅ Focus styles visible (`:focus-visible`)
- ✅ Enter/Space activate buttons
- ✅ Escape closes modals/dropdowns

### Screen Reader Support
- ✅ Text alternatives for images (`alt` attributes)
- ✅ Loading states announced (`role="status"`, `aria-busy`)
- ✅ Error states announced (`role="alert"`)
- ✅ Dynamic content updates announced (`aria-live`)

### Color Contrast
- ✅ WCAG AA minimum (4.5:1 for text, 3:1 for UI)
- ✅ WCAG AAA preferred (7:1 for text, 4.5:1 for UI)

**Test with:**
- `axe-core` (automated testing)
- `eslint-plugin-jsx-a11y` (linting)
- Screen reader (NVDA, JAWS, VoiceOver)

---

## Performance Best Practices

### Bundle Size
- ✅ Tree-shakeable imports (no `import *`)
- ✅ Code-split large components (dynamic imports)
- ✅ Lazy-load below-the-fold components
- ✅ Avoid large dependencies (check bundle analyzer)

### Runtime Performance
- ✅ Memoize expensive computations (`useMemo`, `computed`)
- ✅ Memoize components (`React.memo`, Vue `memo`)
- ✅ Virtualize long lists (react-window, vue-virtual-scroller)
- ✅ Debounce/throttle event handlers

### Images
- ✅ Use `next/image` (React/Next.js) or `nuxt/image` (Vue/Nuxt)
- ✅ Lazy loading (`loading="lazy"`)
- ✅ Blur placeholders (LQIP - Low Quality Image Placeholder)
- ✅ Responsive images (`srcset`, `sizes`)
- ✅ Modern formats (WebP, AVIF)

### CSS
- ✅ CSS modules (scoped, no conflicts)
- ✅ Critical CSS inlined (above the fold)
- ✅ Avoid layout thrashing (batch DOM reads/writes)
- ✅ Use CSS custom properties for theming

---

## Common Pitfalls to Avoid

### TypeScript Anti-Patterns

**❌ Bad:**
```typescript
// Using 'any' defeats type safety
const handleClick = (event: any) => { ... };

// Implicit 'any' in props
export function Card(props) { ... }
```

**✅ Good:**
```typescript
// Explicit types
const handleClick = (event: React.MouseEvent<HTMLButtonElement>) => { ... };

// Typed props
export interface CardProps {
  title: string;
  onClick: () => void;
}
export function Card({ title, onClick }: CardProps) { ... }
```

### Accessibility Anti-Patterns

**❌ Bad:**
```jsx
// Div as button (not keyboard accessible)
<div onClick={handleClick}>Click me</div>

// No alt text
<img src="product.jpg" />

// Generic "Click here" (not descriptive)
<button>Click here</button>
```

**✅ Good:**
```jsx
// Proper button element
<button onClick={handleClick}>Click me</button>

// Descriptive alt text
<img src="product.jpg" alt="Wireless headphones - black" />

// Descriptive button text
<button>Add {productName} to cart</button>
```

### Performance Anti-Patterns

**❌ Bad:**
```jsx
// Re-creating function on every render
<button onClick={() => handleClick(id)}>Click</button>

// Inline object (new reference every render)
<Component style={{ margin: 10 }} />

// Importing entire library
import _ from 'lodash';
```

**✅ Good:**
```jsx
// Stable function reference
const onClick = useCallback(() => handleClick(id), [id]);
<button onClick={onClick}>Click</button>

// CSS class instead of inline style
<Component className="margin-10" />

// Tree-shakeable import
import debounce from 'lodash/debounce';
```

---

## Validation Before Committing

Before committing generated components:

### 1. TypeScript Validation

```bash
npm run type-check

# Should show no errors
```

### 2. Linting

```bash
npm run lint

# Should pass ESLint + a11y checks
```

### 3. Unit Tests

```bash
npm run test:unit

# Should pass all tests
# Coverage: 80%+ on new code
```

### 4. Visual Review

```bash
npm run dev

# Manually verify:
# - Component renders correctly
# - Responsive on mobile/tablet/desktop
# - Keyboard navigation works
# - Screen reader announces content
```

### 5. Bundle Size Check

```bash
npm run analyze

# Check component size:
# - Small: <10KB (ideal)
# - Medium: 10-50KB (acceptable)
# - Large: >50KB (requires justification)
```

---

## Customization & Extension

### Adapting to Your Stack

**If using styled-components:**

```typescript
// Agent can generate styled-components instead of CSS modules
import styled from 'styled-components';

const StyledButton = styled.button<{ variant: ButtonVariant }>`
  padding: 0.75rem 1.5rem;
  background-color: ${props => props.variant === 'primary' ? '#3b82f6' : '#e5e7eb'};
  /* ... */
`;
```

**If using Tailwind CSS:**

```typescript
// Agent can use Tailwind classes
export function Button({ variant, children }: ButtonProps) {
  return (
    <button
      className={cn(
        'px-4 py-2 rounded font-medium transition-colors',
        variant === 'primary' && 'bg-blue-500 text-white hover:bg-blue-600',
        variant === 'secondary' && 'bg-gray-200 text-gray-800 hover:bg-gray-300'
      )}
    >
      {children}
    </button>
  );
}
```

**Tell the agent your preferences:**
```
"Create Button component using Tailwind CSS classes (not CSS modules)"
"Create Card component using styled-components"
"Create ProductGrid using CSS Grid (not Flexbox)"
```

---

## Example Prompts

### Simple Components

```
"Create Avatar component:
- Props: imageUrl, name, size (small/medium/large)
- Fallback initials if no image
- Round or square variant"
```

```
"Create Badge component:
- Props: text, variant (info/success/warning/error)
- Small pill-shaped design"
```

### Complex Components

```
"Create SearchBar component:
- Props: placeholder, onSearch callback
- Debounced input (300ms)
- Keyboard shortcuts (Cmd+K to focus)
- Clear button when input has text
- Loading state during search
- Accessible (ARIA labels)"
```

```
"Create DataTable component:
- Props: columns (array), data (array)
- Sortable columns (click header)
- Pagination (10, 25, 50, 100 per page)
- Row selection (checkboxes)
- Loading skeleton
- Empty state
- Fully accessible (keyboard navigation, screen reader)"
```

### Framework-Specific

```
"Create ProductCard (Next.js):
- Use next/image for optimization
- Use next/link for navigation
- Server Component compatible
- TypeScript"
```

```
"Create UserProfile (Vue 3):
- Composition API
- Pinia store integration for user state
- Suspense for async data
- TypeScript"
```

---

## Learning from Generated Components

After the agent generates a component:

### Extract Patterns

**Prompt to agent:**
```
"What patterns did you use in this Button component that I should reuse?"
```

**Agent might explain:**
- "Used CSS modules for scoping (prevents style conflicts)"
- "Applied `forwardRef` to allow parent access to DOM (accessibility)"
- "Used discriminated union for variants (type safety)"
- "Included `...props` spread for extensibility"

### Improve Over Time

**Prompt to agent:**
```
"How could this ProductCard be optimized further?"
```

**Agent might suggest:**
- "Lazy-load image with intersection observer"
- "Add skeleton loader for better perceived performance"
- "Extract color scheme to CSS custom properties (theming)"
- "Use `React.memo` to prevent unnecessary re-renders"

---

## Integration with Other Agents

This agent works with other web-development agents:

### After Component Creation

**Use `api-integration.md` agent:**
```
"Integrate ProductCard with /api/products endpoint using React Query"
```

**Use `ui-testing.md` agent:**
```
"Write comprehensive tests for Button component"
```

### Before Component Creation

**Use `/build-frontend` command:**
```
Validates TypeScript config is correct
Ensures project structure is ready
```

---

## Troubleshooting

### TypeScript Errors

**Error:**
```
Property 'variant' does not exist on type 'IntrinsicAttributes'
```

**Solution:**
```typescript
// Ensure interface extends HTML attributes
export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant;
}
```

### Accessibility Warnings

**Warning:**
```
ESLint: Visible, non-interactive elements with click handlers must have at least one keyboard listener
```

**Solution:**
```typescript
// Use <button> instead of <div>
// OR add keyboard handler
<div
  onClick={handleClick}
  onKeyDown={(e) => e.key === 'Enter' && handleClick()}
  role="button"
  tabIndex={0}
>
```

### Bundle Size Too Large

**Problem:**
```
Component bundle: 150KB (too large)
```

**Solution:**
```
"Analyze dependencies in ProductCard. Can we reduce bundle size?"

Agent suggests:
- Replace moment with date-fns (-220KB)
- Lazy-load ProductReviews component (-45KB)
- Use CSS modules instead of styled-components (-30KB)
```

---

## Success Metrics

Track component quality:

### Code Quality
- ✅ 100% TypeScript (no `any`)
- ✅ 0 ESLint warnings
- ✅ 0 a11y violations (axe-core)

### Test Coverage
- ✅ 80%+ line coverage
- ✅ All props tested
- ✅ All interactions tested
- ✅ Accessibility tested

### Performance
- ✅ Component size <10KB (ideal) or <50KB (acceptable)
- ✅ First render <100ms
- ✅ Re-render <16ms (60fps)

### Accessibility
- ✅ Keyboard navigable
- ✅ Screen reader compatible
- ✅ WCAG AA compliant (minimum)
- ✅ Color contrast passing

---

## Version & Compatibility

**Agent Version:** 1.0.0
**Compatible Frameworks:**
- React 18+ (with TypeScript)
- Next.js 13+ (App Router and Pages Router)
- Vue 3+ (Composition API)
- Svelte 4+ / SvelteKit 1+

**Required Dependencies:**
- TypeScript 5+
- ESLint + `eslint-plugin-jsx-a11y` (React)
- Testing Library (React/Vue/Svelte)

---

## What's Next?

1. **Use the agent** - Generate your first component
2. **Review output** - Understand patterns used
3. **Customize** - Adapt to your stack (Tailwind, styled-components)
4. **Test** - Run validation suite
5. **Iterate** - Improve based on learnings

**Questions?** See [README.md](../README.md) or [WORKFLOWS.md](../WORKFLOWS.md)

---

**Production-ready components, generated with AI, validated by you.**

Type-safe. Accessible. Performant.

**Load this agent. Build great UIs.**
