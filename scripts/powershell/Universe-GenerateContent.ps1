param([string]$Type, [string]$TargetId, [string]$Agent, [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { Write-Host "Usage: Universe-GenerateContent.ps1 -Type character-draft|scene-draft|summary [-TargetId <id>] [-Agent <name>]"; exit 0 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
$universeDir = Join-Path $projectDir "universe"
New-Item -ItemType Directory -Path (Join-Path $universeDir "drafts") -Force | Out-Null
if ($Type -eq "character-draft") { $outFile = Join-Path $universeDir "characters/$TargetId-draft.md" } else { $slug = if ($TargetId) { $TargetId } else { Get-Date -Format "yyyyMMddHHmmss" }; $outFile = Join-Path $universeDir "drafts/$Type-$slug.md" }
$promptPath = Join-Path $env:TEMP "universe-content-prompt-$PID.md"
$content = "Generate: $Type. Target: $TargetId. Output only the requested content."
Set-Content $promptPath $content
if ($Agent) {
    $tmp = Join-Path $env:TEMP "universe-content-out-$PID.md"
    try {
        & $Agent (Get-Content $promptPath -Raw) 2>&1 | Set-Content $tmp
        if ($LASTEXITCODE -ne 0) { Write-Error "Generation failed."; exit 2 }
        Copy-Item $tmp $outFile -Force
        Write-Host "Content written to $outFile"
    } finally { Remove-Item $tmp -ErrorAction SilentlyContinue }
} else { Write-Host "Prompt in $promptPath. Run with -Agent <name> or paste output into $outFile" }
Remove-Item $promptPath -ErrorAction SilentlyContinue
