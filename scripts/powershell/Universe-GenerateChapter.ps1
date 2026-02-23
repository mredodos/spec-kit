param([string]$BookId, [string]$ChapterId, [string]$Agent, [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { Write-Host "Usage: Universe-GenerateChapter.ps1 -BookId id -ChapterId id [-Agent name]"; exit 0 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
$chapterDir = Join-Path $projectDir ("universe/books/" + $BookId + "/chapters/" + $ChapterId)
$promptPath = Join-Path $env:TEMP ("universe-chapter-prompt-" + $PID + ".md")
$ctx = "# Context for chapter " + $ChapterId + "`n"
$universePath = Join-Path $projectDir "universe/universe.md"
if (Test-Path $universePath) { $ctx += "## Universe`n" + (Get-Content $universePath -Raw) }
$guidePath = Join-Path $chapterDir "guide.md"
if (Test-Path $guidePath) { $ctx += "## Chapter guide`n" + (Get-Content $guidePath -Raw) }
$ctx += "`n---`nWrite the chapter narrative. Output only the prose."
Set-Content $promptPath $ctx
if ($Agent) {
    $outPath = Join-Path $env:TEMP ("universe-chapter-out-" + $PID + ".md")
    try {
        & $Agent (Get-Content $promptPath -Raw) 2>&1 | Set-Content $outPath
        if ($LASTEXITCODE -ne 0) { Write-Error "Generation failed. Chapter content was not modified."; exit 2 }
        Copy-Item $outPath (Join-Path $chapterDir "content.md") -Force
        Write-Host "Chapter content updated from $Agent."
    } finally { Remove-Item $outPath -ErrorAction SilentlyContinue }
} else { Write-Host "Prompt written to $promptPath. Paste output into content.md or run with -Agent name." }
Remove-Item $promptPath -ErrorAction SilentlyContinue
