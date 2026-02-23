#!/usr/bin/env bash
# Chapter version and book edition tracking. add-version | set-current <version-id>; add-edition | set-edition-chapters.
# Usage: universe-versioning.sh <book-id> <chapter-id> add-version | set-current <version-id>
#        universe-versioning.sh <book-id> add-edition [edition-id] | set-edition-chapters <edition-id> <chapter-id>:<version-id> ...
# Metadata in chapters/<id>/chapter-versions.yaml and books/<id>/editions.md (or .yaml).

set -e

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"

usage() {
    echo "Usage: universe-versioning.sh <book-id> <chapter-id> add-version | set-current <version-id>"
    echo "       universe-versioning.sh <book-id> add-edition [edition-id]"
    echo "  --help  Show help."
}

[[ "$1" == "--help" || "$1" == "-h" ]] && { usage; exit 0; }
BOOK_ID="${1:-}"; shift || true
CHAPTER_ID="${2:-}"; shift 2>/dev/null || true
ACTION="${1:-}"; shift || true

PROJECT_DIR="${PROJECT_DIR:-.}"
BOOK_DIR="$PROJECT_DIR/universe/books/$BOOK_ID"
[[ ! -d "$BOOK_DIR" ]] && { echo "Error: book not found: $BOOK_ID." >&2; exit 1; }

if [[ "$ACTION" == "add-edition" ]]; then
    EDITION_ID="${1:-edition-$(date +%Y%m%d)}"
    EDITIONS_FILE="$BOOK_DIR/editions.md"
    echo "- edition_id: $EDITION_ID" >> "$EDITIONS_FILE"
    echo "  label: $EDITION_ID" >> "$EDITIONS_FILE"
    echo "  chapter_version_refs: {}" >> "$EDITIONS_FILE"
    echo "Edition '$EDITION_ID' added. Edit editions.md to set chapter_version_refs."
    exit 0
fi

CHAPTER_DIR="$BOOK_DIR/chapters/$CHAPTER_ID"
[[ ! -d "$CHAPTER_DIR" ]] && { echo "Error: chapter not found: $CHAPTER_ID." >&2; exit 1; }
META_FILE="$CHAPTER_DIR/chapter-versions.yaml"
[[ ! -f "$META_FILE" ]] && echo "versions: []" > "$META_FILE"
VID="${1:-}"
if [[ "$ACTION" == "add-version" ]]; then
    echo "  - version_id: ${VID:-v1}" >> "$META_FILE"
    echo "    current: false" >> "$META_FILE"
    echo "Version added for chapter $CHAPTER_ID. Edit $META_FILE to set current."
elif [[ "$ACTION" == "set-current" ]]; then
    echo "Set current version to $VID (edit $META_FILE to mark current: true for $VID)."
fi
