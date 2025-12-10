#!/bin/bash

echo "=== TODO APP AUTOMATION: STARTUP SCRIPT ==="

# Flags
REBUILD=false
DOWN=false

# Parse flags
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --rebuild) REBUILD=true ;;
        --down) DOWN=true ;;
        *) echo "Unknown flag: $1" ;;
    esac
    shift
done

# Shut down containers if --down flag used
if [ "$DOWN" = true ]; then
    echo "[INFO] Stopping containers..."
    docker compose down
fi

# Rebuild images if --rebuild flag used
if [ "$REBUILD" = true ]; then
    echo "[INFO] Rebuilding Docker images..."
    docker compose build --no-cache
fi

echo "[INFO] Starting containers..."
docker compose up -d

echo "[INFO] Containers are running:"
docker ps
function Start-Todo {
    param(
        [string]$Action = "-Rebuild"
    )
    powershell -ExecutionPolicy Bypass -File "C:\Users\USER\Documents\todo\scripts\start.ps1" $Action
}

