#!/usr/bin/env bash
# Add a series to the universe. Creates universe/series/<series-id>/series.md from template.
# Usage: universe-add-series.sh <series-id> [name]
# Requires universe/ to exist. Exit 1 if universe/ missing or invalid slug.

set -e

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"

usage() {
    cat <<'EOF'
Usage: universe-add-series.sh <series-id> [name]

  Create a new series in universe/series/<series-id>/series.md from template.

  series-id  Required. Slug (lowercase, hyphens allowed).
  name       Optional. Display name for the series.

  --help     Show this help.

EOF
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    usage
    exit 0
fi

SERIES_ID="${1:-}"
NAME="${2:-}"

if ! validate_slug "$SERIES_ID" "series-id"; then
    exit 1
fi

PROJECT_DIR="${PROJECT_DIR:-.}"
if [[ ! -d "$PROJECT_DIR/universe" ]]; then
    echo "Error: universe/ not found. Run universe-init first." >&2
    exit 1
fi

TEMPLATES="$(get_universe_content_templates_dir)"
SERIES_DIR="$PROJECT_DIR/universe/series/$SERIES_ID"
mkdir -p "$SERIES_DIR"
cp "$TEMPLATES/series-template.md" "$SERIES_DIR/series.md"

echo "Series '$SERIES_ID' created at $SERIES_DIR/series.md. Edit to set central conflict, ending, POV, tense, tone."
