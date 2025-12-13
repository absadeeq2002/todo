#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="../reports"
mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="$REPORT_DIR/scan-$TIMESTAMP.txt"

echo "=== Running security scan ==="
if command -v trivy >/dev/null 2>&1; then
  echo "Found trivy — scanning local images..."
  # scan all images built with todo- prefix, adapt as needed
  for img in $(docker images --format '{{.Repository}}:{{.Tag}}' | grep '^todo-' || true); do
    echo "----- Scan for $img -----" | tee -a "$REPORT_FILE"
    trivy image --quiet --exit-code 0 --no-progress "$img" | tee -a "$REPORT_FILE"
    echo >> "$REPORT_FILE"
  done
  echo "Report saved to $REPORT_FILE"
else
  echo "trivy not found. Install it: https://aquasecurity.github.io/trivy/v0.39.0/installation/"
  echo "Skipping scan. To create an empty report file for proof, creating $REPORT_FILE"
  echo "SKIPPED: trivy not installed" > "$REPORT_FILE"
fi
