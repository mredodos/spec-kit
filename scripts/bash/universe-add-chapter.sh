#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"
usage() { echo "Usage: universe-add-chapter.sh <book-id> <chapter-id>"; echo "  --help  Show help."; }
[[ "$1" == "--help" || "$1" == "-h" ]] && { usage; exit 0; }
BOOK_ID="${1:?Error: book-id required}"; CHAPTER_ID="${2:?Error: chapter-id required}"
validate_slug "$BOOK_ID" "book-id" || exit 1
validate_slug "$CHAPTER_ID" "chapter-id" || exit 1
PROJECT_DIR="${PROJECT_DIR:-.}"
BOOK_DIR="$PROJECT_DIR/universe/books/$BOOK_ID"
[[ ! -d "$BOOK_DIR" ]] && { echo "Error: book not found: $BOOK_ID. Run universe-add-book first." >&2; exit 1; }
TEMPLATES="$(get_universe_content_templates_dir)"
CHAPTER_DIR="$BOOK_DIR/chapters/$CHAPTER_ID"
mkdir -p "$CHAPTER_DIR"
cp "$TEMPLATES/chapter-guide-template.md" "$CHAPTER_DIR/guide.md"
cp "$TEMPLATES/chapter-content-template.md" "$CHAPTER_DIR/content.md"
echo "Chapter '$CHAPTER_ID' created. Edit guide.md then write content.md."
