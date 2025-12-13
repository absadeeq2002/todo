param(
    [switch]$Rebuild,
    [switch]$Down,
    [switch]$Logs
)

Write-Host "=== TODO App Automation Script (Windows) ==="

if ($Down) {
    Write-Host "`nStopping all containers..." -ForegroundColor Yellow
    docker compose down
}

if ($Rebuild) {
    Write-Host "`nRebuilding all Docker images..." -ForegroundColor Cyan
    docker compose build --no-cache
}

Write-Host "`nStarting containers..." -ForegroundColor Green
docker compose up -d

if ($Logs) {
    Write-Host "`nShowing logs..." -ForegroundColor Magenta
    docker compose logs -f
}

Write-Host "`nDone!"
