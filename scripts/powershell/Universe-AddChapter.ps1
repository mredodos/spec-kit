# Add a chapter to a book. Creates guide.md and content.md in universe/books/<book-id>/chapters/<chapter-id>/.
param([Parameter(Mandatory=$true)][string]$BookId, [Parameter(Mandatory=$true)][string]$ChapterId, [switch]$Help)
. (Join-Path $PSScriptRoot "Common-Universe.ps1")
if ($Help) { @"
Usage: Universe-AddChapter.ps1 -BookId <id> -ChapterId <id> [-Help]
"@; exit 0 }
if (-not (Test-UniverseSlug -Id $BookId -Name "book-id")) { exit 1 }
if (-not (Test-UniverseSlug -Id $ChapterId -Name "chapter-id")) { exit 1 }
$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
$bookDir = Join-Path $projectDir "universe/books/$BookId"
if (-not (Test-Path $bookDir -PathType Container)) { Write-Error "Error: book not found: $BookId. Run Universe-AddBook first."; exit 1 }
$templatesDir = Get-UniverseContentTemplatesDir
$chapterDir = Join-Path $bookDir "chapters/$ChapterId"
New-Item -ItemType Directory -Path $chapterDir -Force | Out-Null
Copy-Item (Join-Path $templatesDir "chapter-guide-template.md") (Join-Path $chapterDir "guide.md")
Copy-Item (Join-Path $templatesDir "chapter-content-template.md") (Join-Path $chapterDir "content.md")
Write-Host "Chapter '$ChapterId' created. Edit guide.md then write content.md."
