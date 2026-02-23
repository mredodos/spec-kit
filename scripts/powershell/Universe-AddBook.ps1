# Add a book to the universe. Creates universe/books/<book-id>/ with book.md, plotlines/, chapters/.
# Usage: Universe-AddBook.ps1 -BookId <id> [-SeriesId <id>] [-Name <name>]

param(
    [Parameter(Mandatory = $true)]
    [string]$BookId,
    [string]$SeriesId = "",
    [string]$Name = "",
    [switch]$Help
)

. (Join-Path $PSScriptRoot "Common-Universe.ps1")

function Show-Usage {
    @"
Usage: Universe-AddBook.ps1 -BookId <id> [-SeriesId <id>] [-Name <name>] [-Help]

  Create a new book: universe/books/<book-id>/book.md, plotlines/, chapters/.

  -BookId    Required. Slug (lowercase, hyphens allowed).
  -SeriesId  Optional. Link this book to a series.
  -Name      Optional. Display name for the book.
  -Help      Show this help.

"@
}

if ($Help) { Show-Usage; exit 0 }

if (-not (Test-UniverseSlug -Id $BookId -Name "book-id")) { exit 1 }
if ($SeriesId -and -not (Test-UniverseSlug -Id $SeriesId -Name "series-id")) { exit 1 }

$projectDir = if ($env:PROJECT_DIR) { $env:PROJECT_DIR } else { "." }
if (-not (Test-Path (Join-Path $projectDir "universe") -PathType Container)) {
    Write-Error "Error: universe/ not found. Run Universe-Init first."
    exit 1
}

$templatesDir = Get-UniverseContentTemplatesDir
$bookDir = Join-Path $projectDir "universe/books/$BookId"
New-Item -ItemType Directory -Path $bookDir -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $bookDir "plotlines") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $bookDir "chapters") -Force | Out-Null
Copy-Item (Join-Path $templatesDir "book-template.md") (Join-Path $bookDir "book.md")

if ($SeriesId) {
    $bookPath = Join-Path $bookDir "book.md"
    $content = Get-Content $bookPath -Raw
    if ($content -match "## Series ID") {
        $content = $content -replace "(?s)(## Series ID\r?\n).*?(\r?\n## )", "`$1$SeriesId`$2"
    } else {
        $content += "`n## Series ID`n$SeriesId`n"
    }
    Set-Content $bookPath $content -NoNewline:$false
}
if ($Name) {
    $bookPath = Join-Path $bookDir "book.md"
    (Get-Content $bookPath) -replace '^# Book', "# $Name" | Set-Content $bookPath
}

Write-Host "Book '$BookId' created at $bookDir/book.md. Edit outline and act structure."
