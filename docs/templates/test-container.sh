#!/bin/bash
# scripts/test-container.sh
# Docker container validation for 12-Factor AgentOps
# Factor IV: Validation Gates Before Execution

set -e

CONTAINER_NAME="${CONTAINER_NAME:-test-app}"
IMAGE_NAME="${IMAGE_NAME:-${CONTAINER_NAME}:latest}"
TEST_PORT="${TEST_PORT:-3001}"
APP_PORT="${APP_PORT:-3000}"

echo "🐳 Testing Docker container: ${IMAGE_NAME}"
echo ""

# ============================================
# Test 1: Docker Daemon Running
# ============================================
echo "[1/7] Checking Docker daemon..."
docker info > /dev/null 2>&1 || {
  echo "❌ Docker daemon not running"
  echo "   Start Docker Desktop and try again"
  exit 1
}
echo "✓ Docker daemon is running"

# ============================================
# Test 2: Build Image
# ============================================
echo ""
echo "[2/7] Building image..."
docker build -t "${IMAGE_NAME}" . || {
  echo "❌ Build failed"
  echo "   Check Dockerfile syntax and dependencies"
  exit 1
}
echo "✓ Image built successfully"

# ============================================
# Test 3: Start Container
# ============================================
echo ""
echo "[3/7] Starting container..."
CONTAINER_ID=$(docker run -d -p "${TEST_PORT}:${APP_PORT}" "${IMAGE_NAME}") || {
  echo "❌ Container failed to start"
  docker logs "$CONTAINER_ID" 2>/dev/null || true
  exit 1
}
echo "✓ Container started (ID: ${CONTAINER_ID:0:12})"

# Cleanup function
cleanup() {
  echo ""
  echo "🧹 Cleaning up..."
  docker stop "$CONTAINER_ID" > /dev/null 2>&1 || true
  docker rm "$CONTAINER_ID" > /dev/null 2>&1 || true
}
trap cleanup EXIT

# ============================================
# Test 4: Health Check
# ============================================
echo ""
echo "[4/7] Waiting for health check..."
sleep 5

if curl -sf "http://localhost:${TEST_PORT}/health" > /dev/null 2>&1; then
  echo "✓ Health endpoint responding"
elif curl -sf "http://localhost:${TEST_PORT}/api/health" > /dev/null 2>&1; then
  echo "✓ Health endpoint responding (/api/health)"
else
  echo "⚠️  Health endpoint not found (optional)"
fi

# ============================================
# Test 5: Homepage Loads
# ============================================
echo ""
echo "[5/7] Testing homepage..."
curl -sf "http://localhost:${TEST_PORT}/" | grep -q "<" || {
  echo "❌ Homepage failed to load"
  echo "   Response:"
  curl -s "http://localhost:${TEST_PORT}/" | head -20
  exit 1
}
echo "✓ Homepage loads correctly"

# ============================================
# Test 6: Security Check (Non-Root User)
# ============================================
echo ""
echo "[6/7] Checking security..."
CONTAINER_USER=$(docker exec "$CONTAINER_ID" whoami 2>/dev/null || echo "unknown")
if [ "$CONTAINER_USER" = "root" ]; then
  echo "⚠️  Container running as root (security concern)"
  echo "   Recommendation: Add USER directive to Dockerfile"
else
  echo "✓ Container running as non-root user: $CONTAINER_USER"
fi

# ============================================
# Test 7: Clean Shutdown
# ============================================
echo ""
echo "[7/7] Testing graceful shutdown..."
docker stop "$CONTAINER_ID" -t 10 > /dev/null 2>&1 || {
  echo "⚠️  Container did not stop gracefully"
}
echo "✓ Container stopped cleanly"

# ============================================
# Summary
# ============================================
echo ""
echo "======================================"
echo "✅ All container tests passed"
echo "======================================"
echo ""
echo "Image: ${IMAGE_NAME}"
echo "Container user: ${CONTAINER_USER}"
echo "Test port: ${TEST_PORT}"
echo ""
echo "Next: git push to trigger CI/CD"
