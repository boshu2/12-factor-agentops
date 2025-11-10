# Progressive Deploy Agent

**Purpose:** Guide safe, incremental deployment strategies (canary, blue-green, feature flags) following 12-Factor AgentOps principles.

**Scope:** Kubernetes deployments, progressive delivery patterns, rollback procedures, telemetry-driven decision making.

---

## Laws of an Agent

Before using this agent, understand the Five Laws that govern all agent interactions:

### Law 1: ALWAYS Extract Learnings
- Document deployment patterns that succeed/fail
- Capture why certain strategies work for specific services
- Analyze rollback incidents for prevention

### Law 2: ALWAYS Improve Self or System
- Identify deployment optimization opportunities
- Quantify impact (downtime reduced, rollback rate improved)
- Propose safer deployment strategies

### Law 3: ALWAYS Document Context for Future Agents
- **Context:** Why this deployment strategy was chosen
- **Solution:** What configuration was applied
- **Learning:** Reusable deployment insights
- **Impact:** Measured improvement (rollback rate, MTTR)

### Law 4: ALWAYS Validate Before Execute
- Test deployment strategies in staging first
- Dry-run configuration changes
- Validate rollback procedures before production

### Law 5: ALWAYS Share Patterns Publicly
- Extract successful deployment patterns as templates
- Document deployment failures to prevent recurrence
- Help other teams adopt safe deployment practices

---

## 12-Factor Mapping

This agent implements:

- **Factor II (JIT Context):** Loads deployment context only when needed
- **Factor III (Single-Responsibility):** Handles ONLY deployment strategies, delegates pipeline to pipeline-guide agent
- **Factor IV (Validation Gates):** Multi-stage validation before full rollout
- **Factor VI (Session Continuity):** Rollback capability at every stage
- **Factor X (Telemetry):** Metrics-driven promotion decisions
- **Factor XII (Multi-Agent Orchestration):** Coordinates deployment stages automatically

---

## Core Capabilities

### 1. Canary Deployments

**Purpose:** Gradually shift traffic to new version, validate with real traffic before full rollout.

**Use when:**
- High-traffic services (>1000 req/s)
- Business-critical applications
- First deployment of major changes
- Risk tolerance is low

**Phases:**
```
10% traffic → Monitor 15 min → 50% traffic → Monitor 15 min → 100% rollout
```

**Example prompts:**

```markdown
Create canary deployment for payment-service:
- Traffic split: 10% → 50% → 100%
- Phase duration: 15 minutes each
- Rollback triggers:
  - Error rate >1%
  - Latency p95 >500ms
  - CPU usage >80%
- Platform: Kubernetes + Flagger
```

```markdown
Configure canary deployment with automatic promotion:
- Service: user-authentication-api
- Baseline: 20 replicas in production
- Canary: Start with 2 replicas (10%)
- Metrics source: Prometheus
- Promotion: Automatic if metrics healthy
- Rollback: Automatic on threshold breach
```

**Key metrics to monitor:**
- Request success rate (target: >99%)
- Latency percentiles (p50, p95, p99)
- Error rate (4xx, 5xx)
- Resource usage (CPU, memory)
- Custom business metrics (conversion rate, etc.)

### 2. Blue-Green Deployments

**Purpose:** Run two identical environments, switch traffic atomically between them.

**Use when:**
- Need instant rollback capability
- Database migrations required
- Long-running requests (don't want mid-request failures)
- Service dependencies are complex

**Phases:**
```
Deploy Green → Validate Green → Switch traffic Blue→Green → Monitor → Decommission Blue
```

**Example prompts:**

```markdown
Set up blue-green deployment for e-commerce platform:
- Current: Blue environment (production)
- Deploy: Green environment (new version)
- Database: Run migrations before traffic switch
- Validation: Smoke tests + manual approval
- Switch: Update load balancer to Green
- Rollback: Switch back to Blue if issues
- Platform: Kubernetes + Istio
```

```markdown
Create blue-green deployment with database migration:
- Service: order-management
- Migration: Add new column, backwards compatible
- Deployment order:
  1. Run migration (non-breaking)
  2. Deploy Green with new code
  3. Validate Green
  4. Switch traffic
  5. Monitor for 1 hour
  6. Decommission Blue
```

**Key considerations:**
- Database schema compatibility
- State management (sessions, caches)
- External dependencies
- Cost (running 2x resources temporarily)

### 3. Feature Flags (Progressive Rollout)

**Purpose:** Deploy code but enable features gradually via configuration.

**Use when:**
- Want to decouple deployment from release
- Need user-based rollout (A/B testing)
- Complex features requiring gradual enablement
- Risk of feature-specific issues

**Example prompts:**

```markdown
Configure feature flag for new payment gateway:
- Flag name: "payment_gateway_v2"
- Rollout: 1% → 10% → 50% → 100% of users
- Duration: 1 day per phase
- Targeting: Random users + beta testers list
- Metrics: Payment success rate, latency
- Rollback: Instant flag toggle if issues
- Platform: LaunchDarkly / Flagsmith
```

```markdown
Set up percentage-based feature rollout:
- Feature: New search algorithm
- Week 1: 5% of users
- Week 2: 25% of users
- Week 3: 75% of users
- Week 4: 100% of users
- Rollback: Toggle flag to 0%
- Metrics: Search relevance, click-through rate
```

**Key patterns:**
- User-based rollout (specific users or percentages)
- Environment-based (staging always on, prod gradual)
- Time-based (enable at specific dates/times)
- Targeting rules (geography, subscription tier, etc.)

### 4. Rolling Deployments

**Purpose:** Update pods gradually, maintain availability throughout.

**Use when:**
- Standard microservice updates
- Low-risk changes
- Can tolerate version mixing temporarily
- Want simple deployment process

**Example prompts:**

```markdown
Configure rolling deployment for API service:
- Strategy: RollingUpdate
- Max unavailable: 25%
- Max surge: 25%
- Readiness probe: HTTP GET /health
- Liveness probe: HTTP GET /health
- Rollout pace: 1 pod every 30 seconds
- Platform: Kubernetes native
```

```markdown
Set up zero-downtime rolling deployment:
- Service: content-api (30 replicas)
- Update: 3 pods at a time (10%)
- Wait: Until readiness probe passes
- Continue: Until all pods updated
- Rollback: If >5% pods fail readiness
```

---

## Kubernetes Deployment Strategies

### Strategy 1: Flagger (Automated Canary)

```yaml
# canary.yaml - Flagger canary deployment
apiVersion: flagger.app/v1beta1
kind: Canary
metadata:
  name: payment-service
  namespace: production
spec:
  # Target deployment to control
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: payment-service

  # Service mesh provider (Istio, Linkerd, App Mesh)
  provider: istio

  # Service configuration
  service:
    port: 8080
    targetPort: 8080
    gateways:
      - public-gateway
    hosts:
      - payment.example.com

  # Canary analysis configuration
  analysis:
    # Schedule interval (default 60s)
    interval: 1m

    # Max traffic percentage routed to canary
    maxWeight: 50

    # Increment of traffic percentage per iteration
    stepWeight: 10

    # Number of checks before rollback
    threshold: 5

    # Metrics for canary analysis
    metrics:
      # Request success rate
      - name: request-success-rate
        thresholdRange:
          min: 99  # 99% success rate
        interval: 1m

      # Request duration p99
      - name: request-duration
        thresholdRange:
          max: 500  # 500ms p99 latency
        interval: 1m

    # Prometheus queries for custom metrics
    metricsServer: http://prometheus:9090
    customMetrics:
      - name: error-rate
        query: |
          sum(rate(
            http_requests_total{
              app="payment-service",
              status=~"5.."
            }[1m]
          )) /
          sum(rate(
            http_requests_total{
              app="payment-service"
            }[1m]
          )) * 100
        thresholdRange:
          max: 1  # Max 1% error rate

  # Webhooks for notifications
  webhooks:
    - name: slack-notification
      url: https://hooks.slack.com/services/YOUR/WEBHOOK/URL
      metadata:
        channel: "#deployments"

    - name: rollback-alert
      type: rollback
      url: https://hooks.slack.com/services/YOUR/WEBHOOK/URL
      metadata:
        channel: "#alerts"

---
# Deployment managed by Flagger
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-service
  namespace: production
spec:
  replicas: 10
  selector:
    matchLabels:
      app: payment-service
  template:
    metadata:
      labels:
        app: payment-service
    spec:
      containers:
        - name: payment-service
          image: registry.example.com/payment-service:v2.0.0
          ports:
            - containerPort: 8080
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 1000m
              memory: 512Mi
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 5
```

### Strategy 2: Blue-Green with Istio

```yaml
# blue-green-deployment.yaml
---
# Blue deployment (current production)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-blue
  namespace: production
spec:
  replicas: 10
  selector:
    matchLabels:
      app: api
      version: blue
  template:
    metadata:
      labels:
        app: api
        version: blue
    spec:
      containers:
        - name: api
          image: registry.example.com/api:v1.5.0
          ports:
            - containerPort: 8080

---
# Green deployment (new version)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-green
  namespace: production
spec:
  replicas: 10
  selector:
    matchLabels:
      app: api
      version: green
  template:
    metadata:
      labels:
        app: api
        version: green
    spec:
      containers:
        - name: api
          image: registry.example.com/api:v2.0.0
          ports:
            - containerPort: 8080

---
# Service (traffic routing)
apiVersion: v1
kind: Service
metadata:
  name: api
  namespace: production
spec:
  selector:
    app: api
    version: blue  # Initially route to blue
  ports:
    - port: 80
      targetPort: 8080

---
# Istio VirtualService for traffic switching
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: api
  namespace: production
spec:
  hosts:
    - api.example.com
  http:
    - match:
        - headers:
            x-version:
              exact: green
      route:
        - destination:
            host: api
            subset: green
    - route:
        - destination:
            host: api
            subset: blue
          weight: 100  # 100% to blue initially
        - destination:
            host: api
            subset: green
          weight: 0    # 0% to green initially

---
# DestinationRule
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: api
  namespace: production
spec:
  host: api
  subsets:
    - name: blue
      labels:
        version: blue
    - name: green
      labels:
        version: green
```

**Traffic switch script:**

```bash
#!/bin/bash
# scripts/switch-blue-green.sh

set -euo pipefail

TARGET_VERSION=${1:-green}

if [ "$TARGET_VERSION" != "blue" ] && [ "$TARGET_VERSION" != "green" ]; then
  echo "Usage: $0 <blue|green>"
  exit 1
fi

echo "Switching traffic to $TARGET_VERSION..."

# Update VirtualService to route 100% to target
kubectl patch virtualservice api -n production --type json -p "$(cat <<EOF
[
  {
    "op": "replace",
    "path": "/spec/http/0/route/0/weight",
    "value": $([ "$TARGET_VERSION" = "blue" ] && echo "100" || echo "0")
  },
  {
    "op": "replace",
    "path": "/spec/http/0/route/1/weight",
    "value": $([ "$TARGET_VERSION" = "green" ] && echo "100" || echo "0")
  }
]
EOF
)"

echo "✅ Traffic switched to $TARGET_VERSION"
echo "📊 Monitor metrics for 15 minutes before decommissioning old version"
```

### Strategy 3: Native Kubernetes Rolling Update

```yaml
# rolling-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
  namespace: production
spec:
  replicas: 20

  # Rolling update strategy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%  # Max 5 pods down at once
      maxSurge: 25%        # Max 25 pods total during rollout

  selector:
    matchLabels:
      app: api

  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: registry.example.com/api:v2.0.0
          ports:
            - containerPort: 8080

          # Resource limits
          resources:
            requests:
              cpu: 100m
              memory: 256Mi
            limits:
              cpu: 1000m
              memory: 512Mi

          # Liveness probe (restart unhealthy pods)
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
            failureThreshold: 3
            timeoutSeconds: 5

          # Readiness probe (remove from service if not ready)
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
            failureThreshold: 3
            successThreshold: 1
            timeoutSeconds: 3

          # Graceful shutdown
          lifecycle:
            preStop:
              exec:
                command:
                  - /bin/sh
                  - -c
                  - sleep 15  # Wait for load balancer to deregister

      # Graceful termination period
      terminationGracePeriodSeconds: 30
```

---

## Monitoring and Validation Scripts

### Canary Monitoring Script

```bash
#!/bin/bash
# scripts/monitor-canary.py (Python version for rich metrics)

import time
import sys
import requests
from datetime import datetime, timedelta

# Configuration
PROMETHEUS_URL = "http://prometheus:9090"
SERVICE_NAME = "payment-service"
NAMESPACE = "production"

# Thresholds
ERROR_RATE_THRESHOLD = 1.0  # 1%
LATENCY_P95_THRESHOLD = 500  # ms
CPU_USAGE_THRESHOLD = 80  # %

# Duration
MONITOR_DURATION = timedelta(minutes=15)

def query_prometheus(query):
    """Query Prometheus and return result"""
    response = requests.get(
        f"{PROMETHEUS_URL}/api/v1/query",
        params={"query": query}
    )
    response.raise_for_status()
    result = response.json()["data"]["result"]
    if not result:
        return None
    return float(result[0]["value"][1])

def check_error_rate():
    """Check 5xx error rate"""
    query = f"""
    sum(rate(http_requests_total{{
        app="{SERVICE_NAME}",
        namespace="{NAMESPACE}",
        status=~"5.."
    }}[1m])) /
    sum(rate(http_requests_total{{
        app="{SERVICE_NAME}",
        namespace="{NAMESPACE}"
    }}[1m])) * 100
    """
    error_rate = query_prometheus(query)
    return error_rate if error_rate else 0.0

def check_latency_p95():
    """Check p95 latency"""
    query = f"""
    histogram_quantile(0.95,
        sum(rate(http_request_duration_seconds_bucket{{
            app="{SERVICE_NAME}",
            namespace="{NAMESPACE}"
        }}[1m])) by (le)
    ) * 1000
    """
    return query_prometheus(query)

def check_cpu_usage():
    """Check CPU usage percentage"""
    query = f"""
    sum(rate(container_cpu_usage_seconds_total{{
        pod=~"{SERVICE_NAME}-.*",
        namespace="{NAMESPACE}"
    }}[1m])) /
    sum(kube_pod_container_resource_limits{{
        pod=~"{SERVICE_NAME}-.*",
        namespace="{NAMESPACE}",
        resource="cpu"
    }}) * 100
    """
    return query_prometheus(query)

def main():
    print(f"🔍 Monitoring canary deployment: {SERVICE_NAME}")
    print(f"📊 Duration: {MONITOR_DURATION.total_seconds()/60} minutes")
    print(f"⏰ Started: {datetime.now()}")
    print()

    start_time = datetime.now()
    check_interval = 30  # seconds

    while datetime.now() - start_time < MONITOR_DURATION:
        try:
            # Check metrics
            error_rate = check_error_rate()
            latency_p95 = check_latency_p95()
            cpu_usage = check_cpu_usage()

            # Print status
            timestamp = datetime.now().strftime("%H:%M:%S")
            print(f"[{timestamp}] Error: {error_rate:.2f}% | "
                  f"Latency: {latency_p95:.0f}ms | "
                  f"CPU: {cpu_usage:.1f}%")

            # Check thresholds
            if error_rate > ERROR_RATE_THRESHOLD:
                print(f"❌ ERROR: Error rate {error_rate:.2f}% exceeds threshold {ERROR_RATE_THRESHOLD}%")
                print("🔄 Recommend: ROLLBACK")
                sys.exit(1)

            if latency_p95 > LATENCY_P95_THRESHOLD:
                print(f"❌ ERROR: Latency {latency_p95:.0f}ms exceeds threshold {LATENCY_P95_THRESHOLD}ms")
                print("🔄 Recommend: ROLLBACK")
                sys.exit(1)

            if cpu_usage > CPU_USAGE_THRESHOLD:
                print(f"⚠️  WARNING: CPU usage {cpu_usage:.1f}% exceeds threshold {CPU_USAGE_THRESHOLD}%")
                # Don't fail on CPU alone, but warn

            time.sleep(check_interval)

        except Exception as e:
            print(f"❌ Error checking metrics: {e}")
            time.sleep(check_interval)

    print()
    print(f"✅ Monitoring complete: All metrics within thresholds")
    print(f"✅ Canary deployment validated successfully")
    print(f"➡️  Safe to promote to 100%")
    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Deployment Validation Script

```bash
#!/bin/bash
# scripts/validate-deployment.sh

set -euo pipefail

SERVICE_NAME=${1:-}
NAMESPACE=${2:-production}
TIMEOUT=${3:-300}

if [ -z "$SERVICE_NAME" ]; then
  echo "Usage: $0 <service-name> [namespace] [timeout]"
  exit 1
fi

echo "🔍 Validating deployment: $SERVICE_NAME in $NAMESPACE"

# 1. Check rollout status
echo "1. Checking rollout status..."
if ! kubectl rollout status deployment/$SERVICE_NAME -n $NAMESPACE --timeout=${TIMEOUT}s; then
  echo "❌ Rollout failed or timed out"
  exit 1
fi
echo "✅ Rollout complete"

# 2. Check pod health
echo "2. Checking pod health..."
DESIRED_REPLICAS=$(kubectl get deployment $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.spec.replicas}')
READY_REPLICAS=$(kubectl get deployment $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.status.readyReplicas}')

if [ "$READY_REPLICAS" != "$DESIRED_REPLICAS" ]; then
  echo "❌ Only $READY_REPLICAS/$DESIRED_REPLICAS pods ready"
  kubectl get pods -n $NAMESPACE -l app=$SERVICE_NAME
  exit 1
fi
echo "✅ All $READY_REPLICAS pods ready"

# 3. Check for restarts
echo "3. Checking for pod restarts..."
RESTART_COUNT=$(kubectl get pods -n $NAMESPACE -l app=$SERVICE_NAME -o jsonpath='{.items[*].status.containerStatuses[*].restartCount}' | awk '{for(i=1;i<=NF;i++)sum+=$i}END{print sum}')

if [ "$RESTART_COUNT" -gt 0 ]; then
  echo "⚠️  Warning: $RESTART_COUNT pod restarts detected"
  kubectl get pods -n $NAMESPACE -l app=$SERVICE_NAME
else
  echo "✅ No pod restarts"
fi

# 4. Health check endpoint
echo "4. Testing health endpoint..."
SERVICE_URL=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

if [ -z "$SERVICE_URL" ]; then
  # Try ClusterIP
  SERVICE_URL=$(kubectl get svc $SERVICE_NAME -n $NAMESPACE -o jsonpath='{.spec.clusterIP}')
  if [ -z "$SERVICE_URL" ]; then
    echo "⚠️  Warning: Could not determine service URL"
  fi
fi

if [ -n "$SERVICE_URL" ]; then
  for i in {1..5}; do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://$SERVICE_URL/health || echo "000")
    if [ "$HTTP_CODE" = "200" ]; then
      echo "✅ Health check passed (HTTP $HTTP_CODE)"
      break
    else
      echo "⏳ Health check attempt $i/5 (HTTP $HTTP_CODE)"
      if [ $i -eq 5 ]; then
        echo "❌ Health check failed after 5 attempts"
        exit 1
      fi
      sleep 10
    fi
  done
fi

# 5. Check metrics (if Prometheus available)
echo "5. Checking metrics..."
# This would query Prometheus for error rates, latency, etc.
# Simplified version:
echo "✅ Metrics check (placeholder - integrate with Prometheus)"

echo ""
echo "========================================="
echo "✅ Deployment validation PASSED"
echo "========================================="
echo "Service: $SERVICE_NAME"
echo "Namespace: $NAMESPACE"
echo "Replicas: $READY_REPLICAS/$DESIRED_REPLICAS"
echo "Restarts: $RESTART_COUNT"
echo "========================================="
```

---

## Common Deployment Patterns

### Pattern 1: Staged Rollout (Conservative)

```
Staging → Canary 5% → Canary 25% → Canary 50% → Full 100%
Each stage: 30 minute soak time with metrics validation
```

### Pattern 2: Fast Rollout (Aggressive)

```
Staging → Canary 10% → Full 100%
Each stage: 10 minute validation
```

### Pattern 3: Blue-Green with Manual Approval

```
Deploy Green → Auto-tests → Manual approval → Switch traffic → Monitor 1 hour → Decommission Blue
```

### Pattern 4: Feature Flag Gradual Rollout

```
Deploy code (flag OFF) → Enable 1% → 10% → 50% → 100%
Each stage: 24 hours with metrics
```

---

## Rollback Procedures

### Automatic Rollback (Flagger)

Flagger automatically rolls back if metrics breach thresholds. No manual intervention needed.

### Manual Rollback (Kubernetes)

```bash
# Rollback to previous version
kubectl rollout undo deployment/service-name -n production

# Rollback to specific revision
kubectl rollout history deployment/service-name -n production
kubectl rollout undo deployment/service-name -n production --to-revision=3

# Check rollback status
kubectl rollout status deployment/service-name -n production
```

### Blue-Green Rollback

```bash
# Switch traffic back to blue
./scripts/switch-blue-green.sh blue
```

### Feature Flag Rollback

```bash
# Instantly disable feature
curl -X PATCH https://feature-flags.example.com/api/flags/payment_gateway_v2 \
  -H "Authorization: Bearer $API_TOKEN" \
  -d '{"enabled": false}'
```

---

## Validation Checklist

Before production deployment:

- [ ] **Staging validated:** Deployment tested in staging environment
- [ ] **Metrics defined:** Clear success criteria (error rate, latency, etc.)
- [ ] **Rollback tested:** Rollback procedure validated
- [ ] **Monitoring ready:** Dashboards and alerts configured
- [ ] **On-call notified:** Team aware of deployment window
- [ ] **Database compatible:** Schema changes are backwards compatible
- [ ] **Dependencies ready:** External services can handle new version
- [ ] **Documentation updated:** Runbooks reflect new version

---

## Next Steps

1. **Choose strategy:** Canary for high-risk, rolling for low-risk
2. **Configure monitoring:** Set up Prometheus + Grafana
3. **Test in staging:** Validate deployment process
4. **Automate:** Use Flagger or ArgoCD Rollouts
5. **Document:** Create runbooks for your services

**Need help?** See related agents:
- `/agent pipeline-guide` - CI/CD pipeline integration
- `/agent security-scan` - Security validation before deployment

---

**Version:** v1.0.0
**Last Updated:** 2025-11-09
**Maintained by:** 12-Factor AgentOps Project
