# Initialize a new universe: create universe/ and core files from templates.
# Usage: Universe-Init.ps1 [-ProjectDir path]
# Default ProjectDir is current directory. Author-facing: no "spec" or "feature" in messages.

param(
    [string]$ProjectDir = ".",
    [switch]$Help
)

. (Join-Path $PSScriptRoot "Common-Universe.ps1")

function Show-Usage {
    @"
Usage: Universe-Init.ps1 [-ProjectDir path] [-Help]

  Initialize a new writing universe in the given directory.
  Creates universe/, universe.md, continuity-log.md, timeline.md, and foreshadowing-register.md from templates.

  -ProjectDir  Optional. Default: current directory.
  -Help        Show this help.

"@
}

if ($Help) {
    Show-Usage
    exit 0
}

if (-not (Test-Path $ProjectDir -PathType Container)) {
    Write-Error "Error: directory does not exist: $ProjectDir"
    exit 1
}

$templatesDir = Get-UniverseContentTemplatesDir
if (-not (Test-Path $templatesDir -PathType Container)) {
    Write-Error "Error: framework templates not found. Ensure .universe/templates/universe/ exists."
    exit 1
}

$universeDir = Join-Path $ProjectDir "universe"
New-Item -ItemType Directory -Path $universeDir -Force | Out-Null

Copy-Item (Join-Path $templatesDir "universe-template.md") (Join-Path $universeDir "universe.md")
Copy-Item (Join-Path $templatesDir "continuity-log-template.md") (Join-Path $universeDir "continuity-log.md")
Copy-Item (Join-Path $templatesDir "timeline-template.md") (Join-Path $universeDir "timeline.md")
Copy-Item (Join-Path $templatesDir "foreshadowing-register-template.md") (Join-Path $universeDir "foreshadowing-register.md")

Write-Host "Universe initialized in $universeDir. Edit universe/universe.md to set genre, style, and world rules."
