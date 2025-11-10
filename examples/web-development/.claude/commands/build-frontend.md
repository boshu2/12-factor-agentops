# /build-frontend - Build and Validate Frontend

**Comprehensive frontend build and validation command**

This slash command runs all validation gates before committing or deploying frontend code: TypeScript compilation, linting, formatting, and production build.

---

## What This Command Does

Runs the following checks in sequence:

1. **TypeScript Validation** - Ensures all code compiles without errors
2. **ESLint** - Checks code quality and accessibility (a11y)
3. **Prettier** - Validates code formatting
4. **Production Build** - Verifies build succeeds
5. **Bundle Analysis** (optional) - Checks bundle size

**Use this before:**
- Committing code
- Creating pull requests
- Deploying to production

---

## Usage

```bash
# In Claude Code
/build-frontend

# Or manually:
npm run build:validate
```

---

## What Gets Checked

### 1. TypeScript Compilation

```bash
tsc --noEmit

# Checks:
# ✅ No type errors
# ✅ Strict mode compliance
# ✅ All imports resolve
# ✅ No 'any' types (if strict config)
```

**Example errors caught:**
```
error TS2345: Argument of type 'string' is not assignable to parameter of type 'number'.
error TS2322: Type '{ foo: string; }' is not assignable to type 'Props'.
```

### 2. ESLint (Code Quality + Accessibility)

```bash
eslint . --ext .ts,.tsx,.js,.jsx --max-warnings 0

# Checks:
# ✅ No console.log statements
# ✅ No unused variables
# ✅ Accessibility violations (jsx-a11y)
# ✅ React hooks rules
# ✅ Import ordering
```

**Example warnings/errors caught:**
```
error: img elements must have an alt prop (jsx-a11y/alt-text)
error: Visible, non-interactive elements with click handlers must have keyboard listeners (jsx-a11y/click-events-have-key-events)
warning: 'handleClick' is defined but never used (no-unused-vars)
```

### 3. Prettier (Code Formatting)

```bash
prettier --check "src/**/*.{ts,tsx,js,jsx,json,css}"

# Checks:
# ✅ Consistent indentation
# ✅ Semicolons (or not, based on config)
# ✅ Quote style
# ✅ Line breaks
```

**Auto-fix available:**
```bash
# Fix formatting issues
prettier --write "src/**/*.{ts,tsx,js,jsx,json,css}"
```

### 4. Production Build

```bash
npm run build

# For Next.js:
next build

# For Vite:
vite build

# Checks:
# ✅ Build completes without errors
# ✅ No runtime errors during SSR/SSG
# ✅ Bundle size within limits
```

**Example errors caught:**
```
error: Build failed compiling /app/page.tsx
error: ReferenceError: document is not defined (SSR issue)
error: Maximum bundle size exceeded (500KB limit)
```

### 5. Bundle Analysis (Optional)

```bash
npm run analyze

# Shows:
# - Bundle size breakdown
# - Largest dependencies
# - Code splitting effectiveness
```

---

## Expected Output

### ✅ All Checks Passing

```
✓ TypeScript compilation successful (0 errors)
✓ ESLint passed (0 warnings, 0 errors)
✓ Prettier formatting correct
✓ Production build successful
  - Build time: 12.3s
  - Bundle size: 285KB (compressed: 95KB)
✓ All validation gates passed

✨ Ready to commit!
```

### ❌ Validation Failed

```
✗ TypeScript compilation failed (3 errors)
  src/components/Button.tsx:15:23 - error TS2322: Type 'string' is not assignable to type 'number'.

✗ ESLint failed (1 error, 2 warnings)
  src/components/ProductCard.tsx:23:7 - error: img elements must have an alt prop (jsx-a11y/alt-text)
  src/app/page.tsx:45:9 - warning: 'handleClick' is defined but never used

✓ Prettier formatting correct
- Production build skipped (fix errors first)

❌ Validation failed. Fix errors above before committing.
```

---

## Configuration Files

### TypeScript Config (tsconfig.json)

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "jsx": "preserve",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src"],
  "exclude": ["node_modules", ".next", "out", "dist"]
}
```

### ESLint Config (.eslintrc.js)

```javascript
module.exports = {
  extends: [
    'next/core-web-vitals',
    'plugin:@typescript-eslint/recommended',
    'plugin:jsx-a11y/recommended',
    'prettier',
  ],
  plugins: ['@typescript-eslint', 'jsx-a11y'],
  rules: {
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/no-explicit-any': 'error',
    'jsx-a11y/alt-text': 'error',
    'jsx-a11y/anchor-is-valid': 'error',
    'no-console': 'warn',
  },
};
```

### Prettier Config (.prettierrc)

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false
}
```

---

## CI/CD Integration

### GitHub Actions

```yaml
name: Frontend Validation
on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
          cache: 'npm'

      - run: npm ci
      - run: npm run build:validate

      - name: Upload build artifacts
        if: success()
        uses: actions/upload-artifact@v3
        with:
          name: build
          path: .next/
```

### GitLab CI

```yaml
stages:
  - validate
  - build

validate:
  stage: validate
  script:
    - npm ci
    - npm run type-check
    - npm run lint
    - npm run format:check

build:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - .next/
```

---

## Package.json Scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "build:validate": "npm run type-check && npm run lint && npm run format:check && npm run build",
    "type-check": "tsc --noEmit",
    "lint": "eslint . --ext .ts,.tsx,.js,.jsx --max-warnings 0",
    "lint:fix": "eslint . --ext .ts,.tsx,.js,.jsx --fix",
    "format": "prettier --write \"src/**/*.{ts,tsx,js,jsx,json,css}\"",
    "format:check": "prettier --check \"src/**/*.{ts,tsx,js,jsx,json,css}\"",
    "analyze": "ANALYZE=true next build",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage"
  }
}
```

---

## Troubleshooting

### TypeScript Errors

**Problem:** `Type 'X' is not assignable to type 'Y'`

**Solutions:**
1. Check prop types match component interface
2. Ensure imports are correct
3. Add explicit type annotations
4. Check for typos in type names

### ESLint Errors

**Problem:** `img elements must have an alt prop`

**Solution:**
```tsx
// ❌ Bad
<img src="/product.jpg" />

// ✅ Good
<img src="/product.jpg" alt="Product name" />
```

**Problem:** `Visible, non-interactive elements with click handlers must have keyboard listeners`

**Solution:**
```tsx
// ❌ Bad
<div onClick={handleClick}>Click me</div>

// ✅ Good (use button)
<button onClick={handleClick}>Click me</button>

// OR add keyboard handler
<div
  onClick={handleClick}
  onKeyDown={(e) => e.key === 'Enter' && handleClick()}
  role="button"
  tabIndex={0}
>
  Click me
</div>
```

### Build Errors

**Problem:** `ReferenceError: window is not defined`

**Solution:** Use client-side only code with dynamic imports or useEffect

```tsx
// ❌ Bad (fails in SSR)
const width = window.innerWidth;

// ✅ Good
const [width, setWidth] = useState(0);

useEffect(() => {
  setWidth(window.innerWidth);
}, []);
```

---

## Performance Thresholds

### Bundle Size Limits

```javascript
// next.config.js
module.exports = {
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.performance = {
        maxAssetSize: 500000, // 500KB
        maxEntrypointSize: 500000,
        hints: 'error',
      };
    }
    return config;
  },
};
```

**Recommended limits:**
- Initial bundle: <300KB (compressed)
- Total bundle: <1MB (compressed)
- Per-route chunks: <200KB

---

## What's Next?

After `/build-frontend` passes:

1. **Run tests:** `/test-components`
2. **Commit changes:** Follow semantic commit conventions
3. **Push to remote:** CI will validate again
4. **Deploy:** Automated deployment triggers

---

## 12-Factor AgentOps Alignment

This command implements:

- **Factor IV: Validation Gates** - Catches errors before commit
- **Factor VIII: Stateless Execution** - Reproducible builds
- **Factor X: Dev/Prod Parity** - Same validation in all environments
- **Factor XII: Transparency** - Clear feedback on what passed/failed

---

## Version & Status

**Command Version:** 1.0.0
**Compatible With:**
- Next.js 13+
- React 18+
- TypeScript 5+
- ESLint 8+
- Prettier 3+

---

**Build with confidence. Validate before commit.**

**Use `/build-frontend` before every commit.**
