# Add a character to the universe. Creates universe/characters/<character-id>.md from template.
param([Parameter(Mandatory=$true)][string]$CharacterId, [string]$Name="", [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { @"
Usage: Universe-AddCharacter.ps1 -CharacterId <id> [-Name <name>] [-Help]
"@; exit 0 }
if (-not (Test-UniverseSlug -Id $CharacterId -Name "character-id")) { exit 1 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
if (-not (Test-Path (Join-Path $projectDir "universe") -PathType Container)) { Write-Error "Error: universe/ not found. Run Universe-Init first."; exit 1 }
$templatesDir = Get-UniverseContentTemplatesDir
$charDir = Join-Path $projectDir "universe/characters"
New-Item -ItemType Directory -Path $charDir -Force | Out-Null
Copy-Item (Join-Path $templatesDir "character-template.md") (Join-Path $charDir "$CharacterId.md")
Write-Host "Character '$CharacterId' created. Edit role, traits, goals, backstory, flaw."
