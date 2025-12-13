Write-Host "=== TODO APP CLEANUP SCRIPT (Windows) ===" -ForegroundColor Yellow

Write-Host "`nStopping all containers..."
docker compose down

Write-Host "`nRemoving unused containers, images, networks, and volumes..."
docker system prune -a --volumes -f

Write-Host "`nCleanup completed!" -ForegroundColor Green
