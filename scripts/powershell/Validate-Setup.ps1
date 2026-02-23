# Check universe/ exists and required structure present. Author-facing messages.
param([switch]$Help)
if ($Help) { "Usage: Validate-Setup.ps1 [-Help]"; exit 0 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }; $universeDir = Join-Path $projectDir "universe"
if (-not (Test-Path $universeDir)) { Write-Error "Setup incomplete: universe/ not found. Run Universe-Init first."; exit 1 }
if (-not (Test-Path (Join-Path $universeDir "universe.md"))) { Write-Error "Setup incomplete: universe/universe.md missing."; exit 1 }
Write-Host "Universe setup OK: universe/ and universe.md present."
