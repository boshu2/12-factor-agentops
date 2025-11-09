# AI Agent Rules - agentops (Orchestration Layer)

**CRITICAL:** Read this BEFORE creating ANY file in this repository.

**Version:** 1.0.0
**Enforcement:** STRICT - Validation runs before every commit
**Authority:** [TRINITY-REPO-STANDARDS.md](../operations/TRINITY-REPO-STANDARDS.md)

---

## 🚨 THE ONE RULE THAT MATTERS

**ONLY 8 FILES ALLOWED IN ROOT. EVERYTHING ELSE GOES IN SUBDIRECTORIES.**

That's it. That's the rule. No exceptions. Not for "important" docs. Not for "just this one time."

---

## 📜 Allowed Root Files

```
agentops/
├── README.md              ✅ Entry point
├── LICENSE                ✅ Legal
├── CONTRIBUTING.md        ✅ How to contribute
├── CODE_OF_CONDUCT.md     ✅ Community standards
├── SECURITY.md            ✅ Security policy
├── CHANGELOG.md           ✅ Version history
├── VERSION                ✅ Semantic version
├── Makefile               ✅ Build/validation
├── CLAUDE.md              ✅ AI agent instructions (KEEP IN ROOT!)
└── CONSTITUTION.md        ✅ Core principles (optional)
```

**Everything else** → subdirectories (docs/, scripts/, core/, profiles/)

---

## ❌ Common Mistakes (STOP DOING THESE)

### Mistake #1: Creating docs in root

```bash
# ❌ WRONG
agentops/TRINITY.md
agentops/MISSION.md
agentops/IMPLEMENTATION_SUMMARY.md

# ✅ CORRECT
agentops/docs/architecture/TRINITY.md
agentops/docs/architecture/MISSION.md
agentops/docs/specification/IMPLEMENTATION-SUMMARY.md

# ✅ EXCEPTION: These stay in root
agentops/CLAUDE.md           # AI agent instructions (root = visible)
agentops/CONSTITUTION.md     # Core principles (optional)
```

### Mistake #2: Thinking "important" docs belong in root

```
WRONG THINKING:
"This doc is really important, so it should be in root"

CORRECT THINKING:
"Is this a critical ENTRY POINT for new users?"
  → Yes: It's one of the 8 allowed files
  → No: It goes in docs/subdirectory/
```

### Mistake #3: Skipping validation

```bash
# ❌ WRONG
git add .
git commit -m "Add awesome feature"
# (Didn't run validation - might have stray files)

# ✅ CORRECT
git add .
make validate-all  # Run validation FIRST
git commit -m "Add awesome feature"
```

---

## 📂 Where Does Each File Type Go?

| If you're creating... | Put it in... | Example |
|----------------------|--------------|---------|
| Architecture doc | docs/architecture/ | TRINITY.md, MISSION.md |
| AI agent instructions | ROOT | CLAUDE.md (stays in root!) |
| Core principles | ROOT | CONSTITUTION.md (optional) |
| Development guide | docs/development/ | setup-guide.md |
| How-to guide | docs/guides/ | create-agent.md, setup.md |
| Operations standard | docs/operations/ | OPERATIONAL-STANDARDS.md |
| Reference doc | docs/reference/ | command-reference.md, api-docs.md |
| Project management | docs/project/ | roadmap.md, strategy.md |
| Spec/plan/summary | docs/specification/ | implementation-summary.md |
| Automation script | scripts/ | validate.sh, deploy.sh |
| Agent definition | core/agents/ | spec-architect.md |
| Command definition | core/commands/ | plan.md, implement.md |
| Workflow pattern | core/workflows/ | complete-cycle.md |
| Profile config | profiles/{name}/ | base/, devops/ |

**When in doubt:** It goes in docs/. Then decide which subdirectory.

---

## 🤖 Workflow for AI Agents

### Before Creating ANY File

```
1. What am I creating?
   → Markdown file

2. Is it one of the 8 allowed root files?
   → No

3. Where does it go?
   → docs/subdirectory/

4. Which subdirectory?
   → (See table above)

5. Create file in correct location

6. Before committing:
   → make validate-all
```

### Every Time You Create/Move a File

```bash
# Step 1: Create or move file to correct location
mkdir -p docs/architecture
mv FILE.md docs/architecture/

# Step 2: Update any cross-references
# (Search for links to FILE.md and update paths)

# Step 3: VALIDATE (REQUIRED)
make validate-all

# Step 4: Only commit if validation passes
git add .
git commit -m "Move FILE.md to correct location"
```

---

## 🛡️ Validation Commands

### Main validation (use this)

```bash
make validate-all
```

**What it checks:**
- ✅ No stray markdown in root
- ✅ All required files present
- ✅ All required directories exist
- ✅ Documentation links not broken
- ✅ Trinity repos aligned

### Specific validations

```bash
# Check structure only
make validate-structure

# Check Trinity alignment
make validate-trinity

# Check doc links
make validate-docs
```

---

## 🚫 Never Do This

1. **Never** create markdown in root (except the 8 allowed)
2. **Never** skip validation before committing
3. **Never** create "exceptions" or "special cases"
4. **Never** move files without updating cross-references
5. **Never** ignore validation errors ("I'll fix it later")

---

## ✅ Always Do This

1. **Always** put docs in docs/ subdirectories
2. **Always** run `make validate-all` before committing
3. **Always** fix validation errors immediately
4. **Always** update links when moving files
5. **Always** follow the standard (no shortcuts)

---

## 📊 Validation Error? Fix It

### Error: "Stray markdown in root"

```bash
# See which file is the problem
make validate-structure

# Example output:
# ❌ Markdown file should be in docs/: TRINITY.md

# Fix: Move to correct subdirectory
mkdir -p docs/architecture
mv TRINITY.md docs/architecture/

# Update cross-references (search and replace)
# Validate again
make validate-all
```

### Error: "Missing required directory"

```bash
# See which directory is missing
make validate-structure

# Example output:
# ❌ Missing docs directory: docs/architecture

# Fix: Create directory
mkdir -p docs/architecture

# Validate again
make validate-all
```

### Error: "Script not executable"

```bash
# Fix: Make executable
chmod +x scripts/*.sh

# Validate again
make validate-all
```

---

## 🎯 Quick Reference Card

```
┌─────────────────────────────────────────────┐
│  AI AGENT QUICK REFERENCE                   │
├─────────────────────────────────────────────┤
│                                             │
│  ✅ ALLOWED IN ROOT (8 files only):        │
│     • README.md                             │
│     • LICENSE                               │
│     • CONTRIBUTING.md                       │
│     • CODE_OF_CONDUCT.md                    │
│     • SECURITY.md                           │
│     • CHANGELOG.md                          │
│     • VERSION                               │
│     • Makefile                              │
│                                             │
│  ❌ NOT ALLOWED IN ROOT:                   │
│     • ANY other .md files                   │
│     • "Important" docs (they go in docs/)   │
│     • Plans, specs, summaries               │
│     • Architecture docs                     │
│     • Development guides                    │
│                                             │
│  🔍 BEFORE EVERY COMMIT:                   │
│     make validate-all                       │
│                                             │
│  📚 ALL DOCS GO IN:                        │
│     docs/{architecture,development,         │
│           guides,operations,reference,      │
│           project,specification}/           │
│                                             │
└─────────────────────────────────────────────┘
```

---

## 📖 Full Documentation

For complete details, see:
- [TRINITY-REPO-STANDARDS.md](../operations/TRINITY-REPO-STANDARDS.md) - Full standard
- [OPERATIONAL-STANDARDS.md](../operations/OPERATIONAL-STANDARDS.md) - General standards
- [VALIDATION-WORKFLOW.md](../operations/VALIDATION-WORKFLOW.md) - Validation procedures

---

## ❓ Still Unsure?

**Decision tree:**

```
Is this one of the 8 allowed root files?
├─ Yes → Create in root
└─ No → Is it markdown?
    ├─ Yes → Create in docs/subdirectory/
    └─ No → Is it a script?
        ├─ Yes → Create in scripts/
        └─ No → Create in repo-specific directory
                (core/, profiles/, etc.)
```

**When in doubt:**
1. Put it in docs/
2. Run `make validate-all`
3. If validation passes, you chose correctly
4. If validation fails, fix and retry

---

## 🔒 This Is Not Negotiable

These rules are:
- ✅ Enforced by automated validation
- ✅ Required before every commit
- ✅ Applied to ALL contributors (human and AI)
- ✅ Part of the repository contract

You cannot:
- ❌ Create exceptions
- ❌ Skip validation
- ❌ Work around the rules
- ❌ "Fix it later"

**Follow the standard. Always.**

---

**Standards are not suggestions. They are contracts.** 🎯

**Last Updated:** 2025-11-08
**Standard Version:** TRINITY-REPO-STANDARDS v1.0.0
