param([string]$BookId, [string]$ChapterId, [string]$Action, [string]$VersionId, [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { Write-Host "Usage: Universe-Versioning.ps1 -BookId <id> [-ChapterId <id>] -Action AddVersion|SetCurrent|AddEdition [-VersionId <id>]"; exit 0 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
$bookDir = Join-Path $projectDir "universe/books/$BookId"
if (-not (Test-Path $bookDir)) { Write-Error "Book not found: $BookId"; exit 1 }
if ($Action -eq "AddEdition") {
    $eid = if ($VersionId) { $VersionId } else { "edition-" + (Get-Date -Format "yyyyMMdd") }
    Add-Content (Join-Path $bookDir "editions.md") "`n- edition_id: $eid`n  label: $eid`n  chapter_version_refs: {}"
    Write-Host "Edition $eid added. Edit editions.md to set chapter_version_refs."
    exit 0
}
$chapterDir = Join-Path $bookDir "chapters/$ChapterId"
if (-not (Test-Path $chapterDir)) { Write-Error "Chapter not found: $ChapterId"; exit 1 }
$metaFile = Join-Path $chapterDir "chapter-versions.yaml"
if (-not (Test-Path $metaFile)) { Set-Content $metaFile "versions: []" }
if ($Action -eq "AddVersion") { $vid = if ($VersionId) { $VersionId } else { "v1" }; Add-Content $metaFile "  - version_id: $vid`n    current: false"; Write-Host "Version added. Edit $metaFile to set current." }
if ($Action -eq "SetCurrent") { Write-Host "Set current version to $VersionId (edit $metaFile to mark current: true)." }
