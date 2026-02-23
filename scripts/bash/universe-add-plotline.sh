#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"
usage() { echo "Usage: universe-add-plotline.sh <book-id> <plotline-id> [main|secondary]"; echo "  --help  Show help."; }
[[ "$1" == "--help" || "$1" == "-h" ]] && { usage; exit 0; }
BOOK_ID="${1:?Error: book-id required}"; PLOTLINE_ID="${2:?Error: plotline-id required}"; TYPE="${3:-secondary}"
validate_slug "$BOOK_ID" "book-id" || exit 1
validate_slug "$PLOTLINE_ID" "plotline-id" || exit 1
PROJECT_DIR="${PROJECT_DIR:-.}"
BOOK_DIR="$PROJECT_DIR/universe/books/$BOOK_ID"
[[ ! -d "$BOOK_DIR" ]] && { echo "Error: book not found: $BOOK_ID. Run universe-add-book first." >&2; exit 1; }
TEMPLATES="$(get_universe_content_templates_dir)"
cp "$TEMPLATES/plotline-template.md" "$BOOK_DIR/plotlines/$PLOTLINE_ID.md"
echo "Plotline '$PLOTLINE_ID' ($TYPE) created. Edit arc and link to theme."
