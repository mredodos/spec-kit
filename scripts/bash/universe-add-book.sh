#!/usr/bin/env bash
# Add a book to the universe. Creates universe/books/<book-id>/ with book.md, plotlines/, chapters/.
# Usage: universe-add-book.sh <book-id> [--series-id <id>] [name]
# Optionally write series_id into book.md. Exit 1 if universe/ missing or invalid slug.

set -e

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"

usage() {
    cat <<'EOF'
Usage: universe-add-book.sh <book-id> [--series-id <id>] [name]

  Create a new book: universe/books/<book-id>/book.md, plotlines/, chapters/.

  book-id     Required. Slug (lowercase, hyphens allowed).
  --series-id Optional. Link this book to a series.
  name        Optional. Display name for the book.

  --help      Show this help.

EOF
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    usage
    exit 0
fi

BOOK_ID="${1:-}"
shift || true
SERIES_ID=""
NAME=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --series-id) SERIES_ID="$2"; shift 2 ;;
        --help|-h) usage; exit 0 ;;
        *) NAME="$1"; shift ;;
    esac
done

if ! validate_slug "$BOOK_ID" "book-id"; then
    exit 1
fi
[[ -n "$SERIES_ID" ]] && ! validate_slug "$SERIES_ID" "series-id" && exit 1

PROJECT_DIR="${PROJECT_DIR:-.}"
if [[ ! -d "$PROJECT_DIR/universe" ]]; then
    echo "Error: universe/ not found. Run universe-init first." >&2
    exit 1
fi

TEMPLATES="$(get_universe_content_templates_dir)"
BOOK_DIR="$PROJECT_DIR/universe/books/$BOOK_ID"
mkdir -p "$BOOK_DIR/plotlines" "$BOOK_DIR/chapters"
cp "$TEMPLATES/book-template.md" "$BOOK_DIR/book.md"

if [[ -n "$SERIES_ID" ]]; then
    (echo ""; echo "## Series ID"; echo "$SERIES_ID") >> "$BOOK_DIR/book.md"
fi

echo "Book '$BOOK_ID' created at $BOOK_DIR/book.md. Edit outline and act structure."
