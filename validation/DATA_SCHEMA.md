# Validation Data Collection Schema

**Purpose:** Standard format for collecting and aggregating validation data across domains and teams

**Version:** 1.0.0
**Last Updated:** 2025-11-09

---

## Overview

This schema defines the standard data format for community validation submissions. Using a consistent format enables:
- Aggregation across multiple teams and domains
- Statistical meta-analysis
- Cross-domain comparison
- Reproducible validation methodology

---

## Submission Formats

### Accepted Formats

1. **Markdown** (`.md`) - Structured using templates
2. **JSON** (`.json`) - For programmatic submission
3. **CSV** (`.csv`) - For tabular metrics data
4. **YAML** (`.yaml`) - For configuration-style data

### Recommended Format

**Markdown with embedded YAML frontmatter:**

```markdown
---
schema_version: "1.0.0"
submission_type: "community_validation"
contributor:
  handle: "github_username"
  domain: "product_development"
date: "2025-11-09"
---

# Validation Data

[Detailed narrative and evidence...]
```

---

## Core Schema

### Metadata (Required)

```yaml
schema_version: "1.0.0"           # This schema version
submission_type: string           # "community_validation" | "quantitative_study"
submission_date: "YYYY-MM-DD"     # Date of submission
contributor:
  handle: string                  # GitHub handle or name
  org: string | null              # Organization (optional)
  contact: string | null          # Email (optional)
```

### Context (Required)

```yaml
context:
  domain: string                  # Primary domain of use
    # Valid values: "product_dev" | "infrastructure" | "data_science" |
    #               "research" | "content" | "other"
  team_size: string               # "solo" | "small" | "medium" | "large"
  ai_tools: array<string>         # e.g., ["claude-code", "gpt-4", "cursor"]
  duration: string                # e.g., "3 months", "6 weeks"
  session_count: integer | null   # Approximate number of sessions
  complexity: string              # "simple" | "moderate" | "complex"
```

### Factors Applied (Required)

```yaml
factors_applied: array<integer>   # List of factor numbers used (1-12)
  # Example: [1, 2, 3, 4, 11] means used Factors I, II, III, IV, XI
```

### Outcomes (Required - at least qualitative)

```yaml
outcomes:
  qualitative:
    what_worked: string           # Narrative description
    what_failed: string           # Narrative description
    adaptations: string           # Modifications made

  quantitative: object | null     # Optional but valuable
    metrics:
      - name: string              # e.g., "task_completion_time"
        before: number            # Baseline value
        after: number             # After framework value
        unit: string              # e.g., "hours", "minutes", "%"
        sample_size: integer      # n value
      - name: "success_rate"
        before: number            # e.g., 0.70 (70%)
        after: number             # e.g., 0.95 (95%)
        unit: "percentage"
        sample_size: integer
```

### Evidence (Optional)

```yaml
evidence:
  commits: array<string> | null   # Sanitized commit messages
  workflows: string | null        # Description of typical workflow
  artifacts: array<object> | null # Links, screenshots, etc.
    - type: string                # "link" | "file" | "screenshot"
      url: string                 # Location
      description: string         # What it shows
```

### Recommendations (Required)

```yaml
recommendations:
  would_recommend: string         # "yes" | "yes_with_adaptations" | "mixed" | "no"
  target_audience: string         # Who benefits most
  improvements: string            # Suggested framework improvements
```

### Consent (Required)

```yaml
consent:
  publication: string             # "public_anonymized" | "aggregate_only" | "private"
  attribution: string             # "by_name" | "by_role" | "anonymous"
  follow_up: boolean              # Willing to answer questions?
```

---

## JSON Schema (Formal)

**File:** `validation/schemas/community-validation.schema.json`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "12-Factor AgentOps Community Validation",
  "type": "object",
  "required": [
    "schema_version",
    "submission_type",
    "submission_date",
    "contributor",
    "context",
    "factors_applied",
    "outcomes",
    "recommendations",
    "consent"
  ],
  "properties": {
    "schema_version": {
      "type": "string",
      "pattern": "^[0-9]+\\.[0-9]+\\.[0-9]+$",
      "description": "Schema version (semver)"
    },
    "submission_type": {
      "type": "string",
      "enum": ["community_validation", "quantitative_study"]
    },
    "submission_date": {
      "type": "string",
      "format": "date"
    },
    "contributor": {
      "type": "object",
      "required": ["handle"],
      "properties": {
        "handle": { "type": "string" },
        "org": { "type": ["string", "null"] },
        "contact": { "type": ["string", "null"] }
      }
    },
    "context": {
      "type": "object",
      "required": ["domain", "team_size", "ai_tools"],
      "properties": {
        "domain": {
          "type": "string",
          "enum": [
            "product_dev",
            "infrastructure",
            "data_science",
            "research",
            "content",
            "other"
          ]
        },
        "team_size": {
          "type": "string",
          "enum": ["solo", "small", "medium", "large"]
        },
        "ai_tools": {
          "type": "array",
          "items": { "type": "string" },
          "minItems": 1
        },
        "duration": { "type": "string" },
        "session_count": { "type": ["integer", "null"] },
        "complexity": {
          "type": "string",
          "enum": ["simple", "moderate", "complex"]
        }
      }
    },
    "factors_applied": {
      "type": "array",
      "items": {
        "type": "integer",
        "minimum": 1,
        "maximum": 12
      },
      "minItems": 1
    },
    "outcomes": {
      "type": "object",
      "required": ["qualitative"],
      "properties": {
        "qualitative": {
          "type": "object",
          "required": ["what_worked", "what_failed"],
          "properties": {
            "what_worked": { "type": "string" },
            "what_failed": { "type": "string" },
            "adaptations": { "type": "string" }
          }
        },
        "quantitative": {
          "type": ["object", "null"],
          "properties": {
            "metrics": {
              "type": "array",
              "items": {
                "type": "object",
                "required": ["name", "unit", "sample_size"],
                "properties": {
                  "name": { "type": "string" },
                  "before": { "type": "number" },
                  "after": { "type": "number" },
                  "unit": { "type": "string" },
                  "sample_size": { "type": "integer" }
                }
              }
            }
          }
        }
      }
    },
    "recommendations": {
      "type": "object",
      "required": ["would_recommend", "target_audience"],
      "properties": {
        "would_recommend": {
          "type": "string",
          "enum": ["yes", "yes_with_adaptations", "mixed", "no"]
        },
        "target_audience": { "type": "string" },
        "improvements": { "type": "string" }
      }
    },
    "consent": {
      "type": "object",
      "required": ["publication", "attribution", "follow_up"],
      "properties": {
        "publication": {
          "type": "string",
          "enum": ["public_anonymized", "aggregate_only", "private"]
        },
        "attribution": {
          "type": "string",
          "enum": ["by_name", "by_role", "anonymous"]
        },
        "follow_up": { "type": "boolean" }
      }
    }
  }
}
```

---

## Example Submissions

### Example 1: Minimal Valid Submission (Markdown + YAML)

```markdown
---
schema_version: "1.0.0"
submission_type: "community_validation"
submission_date: "2025-02-15"
contributor:
  handle: "dev_alice"
  org: null
  contact: null
context:
  domain: "product_dev"
  team_size: "solo"
  ai_tools: ["claude-code"]
  duration: "2 months"
  session_count: 40
  complexity: "moderate"
factors_applied: [1, 3, 4]
outcomes:
  qualitative:
    what_worked: "Factor IV (validation gates) caught 12 bugs before commit. Factor I (git memory) made reviewing past decisions easy."
    what_failed: "Factor III (single-responsibility) hard to apply when AI suggests comprehensive solutions."
    adaptations: "Split AI output manually after generation."
  quantitative: null
recommendations:
  would_recommend: "yes_with_adaptations"
  target_audience: "Solo developers working on web apps"
  improvements: "Provide examples of splitting comprehensive AI output"
consent:
  publication: "public_anonymized"
  attribution: "by_role"
  follow_up: false
---

# Validation Report

## Context
Solo web developer using Claude Code for React application development...

[Rest of narrative]
```

### Example 2: Complete Quantitative Submission (JSON)

```json
{
  "schema_version": "1.0.0",
  "submission_type": "quantitative_study",
  "submission_date": "2025-03-01",
  "contributor": {
    "handle": "research_team_b",
    "org": "University Research Lab",
    "contact": "research@university.edu"
  },
  "context": {
    "domain": "data_science",
    "team_size": "small",
    "ai_tools": ["gpt-4", "claude-code"],
    "duration": "12 weeks",
    "session_count": 150,
    "complexity": "complex"
  },
  "factors_applied": [1, 2, 3, 4, 5, 7],
  "outcomes": {
    "qualitative": {
      "what_worked": "Context engineering (Factor II) eliminated context collapse completely. Validation gates caught data pipeline errors early.",
      "what_failed": "Factor VII (intelligent routing) required custom implementation for our tools.",
      "adaptations": "Built simple routing logic based on task keywords."
    },
    "quantitative": {
      "metrics": [
        {
          "name": "pipeline_development_time",
          "before": 8.5,
          "after": 2.1,
          "unit": "hours",
          "sample_size": 45
        },
        {
          "name": "success_rate",
          "before": 0.73,
          "after": 0.94,
          "unit": "percentage",
          "sample_size": 150
        },
        {
          "name": "context_collapse_rate",
          "before": 0.18,
          "after": 0.0,
          "unit": "percentage",
          "sample_size": 150
        }
      ]
    }
  },
  "recommendations": {
    "would_recommend": "yes",
    "target_audience": "Data science teams building pipelines with AI assistance",
    "improvements": "Provide data science-specific examples and routing templates"
  },
  "consent": {
    "publication": "public_anonymized",
    "attribution": "by_name",
    "follow_up": true
  }
}
```

---

## CSV Format (Metrics Only)

For simple quantitative data submission:

```csv
contributor_handle,domain,team_size,factor,metric_name,before,after,unit,sample_size,date
dev_alice,product_dev,solo,4,bug_catch_rate,0.60,0.95,percentage,40,2025-02-15
dev_bob,infrastructure,small,2,context_collapse,0.15,0.02,percentage,75,2025-02-20
researcher_c,data_science,medium,1,time_to_solution,120,30,minutes,50,2025-03-01
```

**Required columns:**
- contributor_handle
- domain
- factor (1-12)
- metric_name
- sample_size
- date

**Optional columns:**
- before, after (for comparison studies)
- unit
- team_size
- Additional custom columns

---

## Aggregation Process

### Phase 1: Collection

Community submits via:
1. GitHub Issues (labeled `validation-data`)
2. Pull Requests to `validation/community/`
3. Email (during beta period)

### Phase 2: Validation

Each submission checked for:
- Schema compliance (JSON schema validation)
- Completeness (required fields present)
- Plausibility (metrics within reasonable ranges)

### Phase 3: Aggregation

Data combined for meta-analysis:
- By factor (which factors work best)
- By domain (domain-specific patterns)
- By team size (solo vs. team differences)
- Overall metrics (cross-domain validation)

### Phase 4: Publication

Results published in:
- `validation/SYNTHESIS.md` - Aggregated findings
- `validation/by-factor/` - Per-factor analysis
- `validation/by-domain/` - Domain-specific results

---

## Data Privacy

### Personal Information

**Never include:**
- Real names (unless consented)
- Email addresses
- Company proprietary information
- Customer data
- Credentials or secrets

**Always anonymize:**
- Contributor identity (if requested)
- Organization names (unless consented)
- Specific project details

### Sensitive Metrics

**Acceptable:**
- Relative improvements (3x speedup)
- Percentages (95% success rate)
- Aggregated data (average time)

**Not acceptable:**
- Absolute revenue numbers
- Customer counts
- Proprietary KPIs
- Competitive intelligence

---

## Validation Tools

### Schema Validator

**Coming soon:** Automated validation tool

```bash
# Validate your submission
./scripts/validate-submission.sh my-validation.md

# Output:
✅ Schema version: valid (1.0.0)
✅ Required fields: complete
✅ Factor numbers: valid (1-12)
✅ Date format: valid
⚠️  Warning: No quantitative data provided (optional)

Submission ready for GitHub PR!
```

### Metrics Calculator

**Coming soon:** Helper for calculating common metrics

```bash
# Calculate speedup from before/after times
./scripts/calculate-metrics.sh --metric speedup --before 120 --after 30
# Output: 4.0x speedup

# Calculate success rate improvement
./scripts/calculate-metrics.sh --metric success_rate --before 70 --after 95
# Output: +25 percentage points improvement
```

---

## Questions?

**Schema questions:** Open an issue with label `schema-question`

**Submission help:** See [validation/templates/community-validation.md](./templates/community-validation.md) for guided template

**Privacy concerns:** Contact maintainers before submitting

---

**This schema enables community validation at scale while protecting privacy and ensuring data quality.**
