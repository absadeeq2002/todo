#!/bin/bash

# Start Script for Microservices TODO App
# Usage:
#   ./start.sh          → start normally
#   ./start.sh --build  → rebuild & start
#   ./start.sh --down   → stop & remove containers

set -e

echo "=== Microservices Automation Script (Linux) ==="

case "$1" in

  --build)
    echo "[+] Rebuilding and starting all services..."
    docker compose down
    docker compose build
    docker compose up -d
    ;;

  --down)
    echo "[+] Stopping and removing all containers..."
    docker compose down
    ;;

  *)
    echo "[+] Starting services..."
    docker compose up -d
    ;;

esac

echo "=== Done ==="
