# Common-Universe: shared helpers for Universe-* scripts (book/universe framework).
# Dot-source this from scripts that need $RepoRoot, template paths, or slug validation.
# Usage: . (Join-Path $PSScriptRoot 'Common-Universe.ps1')

function Get-UniverseRepoRoot {
    $scriptDir = $PSScriptRoot
    # scripts/powershell -> two levels up = repo root
    $candidate = (Resolve-Path (Join-Path $scriptDir "../..")).Path
    if (Test-Path (Join-Path $candidate ".universe")) {
        return $candidate
    }
    try {
        $result = git rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -eq 0) { return $result }
    } catch { }
    return $candidate
}

$script:RepoRoot = if ($script:RepoRoot) { $script:RepoRoot } else { Get-UniverseRepoRoot }

function Get-UniverseTemplatesDir {
    return Join-Path $script:RepoRoot ".universe/templates"
}

function Get-UniverseContentTemplatesDir {
    return Join-Path $script:RepoRoot ".universe/templates/universe"
}

# Validate slug: non-empty, lowercase, hyphens allowed, no path separators or spaces.
# Returns $true if valid, $false otherwise. Writes error to stderr on failure.
function Test-UniverseSlug {
    param(
        [string]$Id,
        [string]$Name = "ID"
    )
    if ([string]::IsNullOrWhiteSpace($Id)) {
        Write-Error "Error: $Name is required and must be non-empty."
        return $false
    }
    if ($Id -match '[^-a-z0-9]') {
        Write-Error "Error: $Name must be a slug (lowercase, hyphens allowed, no spaces or path separators): $Id"
        return $false
    }
    if ($Id -match '/') {
        Write-Error "Error: $Name must not contain path separators: $Id"
        return $false
    }
    return $true
}

# Alias for scripts that expect Validate-Slug style name
function Validate-Slug { param([string]$Id, [string]$Name = "ID"); Test-UniverseSlug -Id $Id -Name $Name }
