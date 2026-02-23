# Add a plotline to a book. Creates universe/books/<book-id>/plotlines/<plotline-id>.md.
param([Parameter(Mandatory=$true)][string]$BookId, [Parameter(Mandatory=$true)][string]$PlotlineId, [ValidateSet("main","secondary")][string]$Type="secondary", [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { @"
Usage: Universe-AddPlotline.ps1 -BookId <id> -PlotlineId <id> [-Type main|secondary] [-Help]
"@; exit 0 }
if (-not (Test-UniverseSlug -Id $BookId -Name "book-id")) { exit 1 }
if (-not (Test-UniverseSlug -Id $PlotlineId -Name "plotline-id")) { exit 1 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
$bookDir = Join-Path $projectDir "universe/books/$BookId"
if (-not (Test-Path $bookDir -PathType Container)) { Write-Error "Error: book not found: $BookId. Run Universe-AddBook first."; exit 1 }
$templatesDir = Get-UniverseContentTemplatesDir
Copy-Item (Join-Path $templatesDir "plotline-template.md") (Join-Path $bookDir "plotlines/$PlotlineId.md")
Write-Host "Plotline '$PlotlineId' ($Type) created. Edit arc and link to theme."
