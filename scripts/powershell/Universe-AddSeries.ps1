# Add a series to the universe. Creates universe/series/<series-id>/series.md from template.
# Usage: Universe-AddSeries.ps1 -SeriesId <id> [-Name <name>]

param(
    [Parameter(Mandatory = $true)]
    [string]$SeriesId,
    [string]$Name = "",
    [switch]$Help
)

. (Join-Path $PSScriptRoot "Common-Universe.ps1")

function Show-Usage {
    @"
Usage: Universe-AddSeries.ps1 -SeriesId <id> [-Name <name>] [-Help]

  Create a new series in universe/series/<series-id>/series.md from template.

  -SeriesId  Required. Slug (lowercase, hyphens allowed).
  -Name      Optional. Display name for the series.
  -Help      Show this help.

"@
}

if ($Help) { Show-Usage; exit 0 }

if (-not (Test-UniverseSlug -Id $SeriesId -Name "series-id")) { exit 1 }

$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
if (-not (Test-Path (Join-Path $projectDir "universe") -PathType Container)) {
    Write-Error "Error: universe/ not found. Run Universe-Init first."
    exit 1
}

$templatesDir = Get-UniverseContentTemplatesDir
$seriesDir = Join-Path $projectDir "universe/series/$SeriesId"
New-Item -ItemType Directory -Path $seriesDir -Force | Out-Null
Copy-Item (Join-Path $templatesDir "series-template.md") (Join-Path $seriesDir "series.md")

if ($Name) {
    (Get-Content (Join-Path $seriesDir "series.md")) -replace '^# Series', "# $Name" | Set-Content (Join-Path $seriesDir "series.md")
}

Write-Host "Series '$SeriesId' created at $seriesDir/series.md. Edit to set central conflict, ending, POV, tense, tone."
