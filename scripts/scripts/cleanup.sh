#!/bin/bash

echo "=== TODO APP AUTOMATION: CLEANUP SCRIPT ==="

echo "[INFO] Removing unused containers..."
docker container prune -f

echo "[INFO] Removing unused images..."
docker image prune -a -f

echo "[INFO] Removing unused networks..."
docker network prune -f

echo "[INFO] Removing unused volumes..."
docker volume prune -f

echo "[INFO] Cleanup complete!"
