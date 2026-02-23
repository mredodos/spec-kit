param([string]$WorldRule, [string]$CharacterId, [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { Write-Host "Usage: Universe-ListAffected.ps1 [-WorldRule <cat>] [-CharacterId <id>]. Exactly one required."; exit 0 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
$universeDir = Join-Path $projectDir "universe"
if (-not (Test-Path $universeDir)) { Write-Error "universe/ not found. Run Universe-Init first."; exit 1 }
if (-not $WorldRule -and -not $CharacterId) { Write-Error "Provide exactly one of -WorldRule or -CharacterId."; exit 1 }
$pattern = if ($WorldRule) { $WorldRule } else { $CharacterId }
Get-ChildItem -Path (Join-Path $universeDir "books") -Recurse -Include "guide.md","content.md" -ErrorAction SilentlyContinue | Where-Object { (Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue) -match [regex]::Escape($pattern) } | ForEach-Object { $_.DirectoryName } | Sort-Object -Unique
