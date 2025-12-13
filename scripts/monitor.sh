#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="../logs"
mkdir -p "$LOG_DIR"

OUT="$LOG_DIR/containers-$(date +%Y-%m-%d_%H-%M-%S).log"

echo "=== Container status ===" > "$OUT"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" >> "$OUT" 2>&1

echo "" >> "$OUT"
echo "=== Docker inspect summary (short) ===" >> "$OUT"
for c in $(docker ps --format '{{.Names}}'); do
  echo "---- $c ----" >> "$OUT"
  docker inspect --format '{{.Name}} {{.State.Status}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$c" >> "$OUT" 2>&1 || true
done

echo "" >> "$OUT"
echo "=== Aggregated compose logs (last 500 lines) ===" >> "$OUT"
# last 500 lines from all compose logs
docker compose logs --tail 500 >> "$OUT" 2>&1 || docker logs --tail 500 $(docker ps -q) >> "$OUT" 2>&1 || true

echo "Monitor saved to $OUT"
# Also print summary to stdout
cat "$OUT"
