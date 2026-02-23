#!/usr/bin/env bash
# Common-Universe: shared helpers for universe-* scripts (book/universe framework).
# Source this from scripts that need REPO_ROOT, template paths, or slug validation.
# Usage: source "$(dirname "${BASH_SOURCE[0]}")/common-universe.sh" (from universe-*.sh)

# Resolve repository root (directory containing .universe/ and scripts/).
# When author runs from project root, we assume scripts are in $REPO_ROOT/scripts/bash
# and templates in $REPO_ROOT/.universe/templates.
get_universe_repo_root() {
    local script_dir
    script_dir="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]:-.}")" && pwd)"
    # scripts/bash -> two levels up = repo root
    local candidate
    candidate="$(cd "$script_dir/../.." && pwd)"
    if [[ -d "$candidate/.universe" ]]; then
        echo "$candidate"
        return
    fi
    # Fallback: same as common.sh get_repo_root for when run from spec-kit repo
    if git rev-parse --show-toplevel >/dev/null 2>&1; then
        git rev-parse --show-toplevel
    else
        echo "$candidate"
    fi
}

# Export REPO_ROOT for universe scripts (framework root: has .universe/ and scripts/).
REPO_ROOT="${REPO_ROOT:-$(get_universe_repo_root)}"

# Template path helpers.
get_universe_templates_dir() {
    echo "$REPO_ROOT/.universe/templates"
}
get_universe_content_templates_dir() {
    echo "$REPO_ROOT/.universe/templates/universe"
}

# Validate slug: non-empty, lowercase, hyphens allowed, no path separators or spaces.
# Returns 0 if valid, 1 otherwise. Prints error to stderr on failure.
validate_slug() {
    local id="$1"
    local name="${2:-ID}"
    if [[ -z "$id" ]]; then
        echo "Error: $name is required and must be non-empty." >&2
        return 1
    fi
    if [[ "$id" =~ [^-a-z0-9] ]]; then
        echo "Error: $name must be a slug (lowercase, hyphens allowed, no spaces or path separators): $id" >&2
        return 1
    fi
    if [[ "$id" == */* ]]; then
        echo "Error: $name must not contain path separators: $id" >&2
        return 1
    fi
    return 0
}
