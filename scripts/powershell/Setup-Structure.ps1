# Create initial outline and structure files from .universe/templates.
param([switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { "Usage: Setup-Structure.ps1 [-Help]"; exit 0 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }; $templatesDir = Get-UniverseTemplatesDir
foreach ($name in @("outline","structure")) {
    $tpl = Join-Path $templatesDir "$name-template.md"; $dest = Join-Path $projectDir "$name.md"
    if (Test-Path $tpl) { Copy-Item $tpl $dest; Write-Host "Created $dest" }
}
Write-Host "Structure setup done. Edit outline.md and structure.md."
