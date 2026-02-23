#!/usr/bin/env bash
# Build context for chapter generation; write prompt file. With --agent: invoke agent. On failure: do not overwrite; exit 2.
set -e
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"
usage() { echo "Usage: universe-generate-chapter.sh <book-id> <chapter-id> [--agent <name>]"; echo "  --help  Show help."; }
BOOK_ID=""; CHAPTER_ID=""; AGENT=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --agent) AGENT="$2"; shift 2 ;;
        --help|-h) usage; exit 0 ;;
        *) if [[ -z "$BOOK_ID" ]]; then BOOK_ID="$1"; elif [[ -z "$CHAPTER_ID" ]]; then CHAPTER_ID="$1"; fi; shift ;;
    esac
done
validate_slug "$BOOK_ID" "book-id" || exit 1
validate_slug "$CHAPTER_ID" "chapter-id" || exit 1
PROJECT_DIR="${PROJECT_DIR:-.}"
UNIVERSE_DIR="$PROJECT_DIR/universe"
BOOK_DIR="$UNIVERSE_DIR/books/$BOOK_ID"
CHAPTER_DIR="$BOOK_DIR/chapters/$CHAPTER_ID"
CONTENT_FILE="$CHAPTER_DIR/content.md"
[[ ! -f "$CHAPTER_DIR/guide.md" ]] && { echo "Error: chapter guide not found." >&2; exit 1; }
PROMPT_FILE="${TMPDIR:-/tmp}/universe-chapter-prompt-$$.md"
echo "# Context for chapter $CHAPTER_ID" > "$PROMPT_FILE"
[[ -f "$UNIVERSE_DIR/universe.md" ]] && echo "## Universe" >> "$PROMPT_FILE" && cat "$UNIVERSE_DIR/universe.md" >> "$PROMPT_FILE"
for f in "$UNIVERSE_DIR/series"/*/series.md; do [[ -f "$f" ]] && echo "## Series" >> "$PROMPT_FILE" && cat "$f" >> "$PROMPT_FILE"; done 2>/dev/null || true
[[ -f "$BOOK_DIR/book.md" ]] && echo "## Book" >> "$PROMPT_FILE" && cat "$BOOK_DIR/book.md" >> "$PROMPT_FILE"
echo "## Characters" >> "$PROMPT_FILE"
for f in "$UNIVERSE_DIR/characters"/*.md; do [[ -f "$f" ]] && cat "$f" >> "$PROMPT_FILE"; done 2>/dev/null || true
echo "## Plotlines" >> "$PROMPT_FILE"
for f in "$BOOK_DIR/plotlines"/*.md; do [[ -f "$f" ]] && cat "$f" >> "$PROMPT_FILE"; done 2>/dev/null || true
echo "## Chapter guide" >> "$PROMPT_FILE" && cat "$CHAPTER_DIR/guide.md" >> "$PROMPT_FILE"
echo "---" >> "$PROMPT_FILE"
echo "Write the chapter narrative. Output only the prose." >> "$PROMPT_FILE"
if [[ -n "$AGENT" ]]; then
    command -v "$AGENT" >/dev/null 2>&1 || { echo "Error: agent $AGENT not found." >&2; exit 2; }
    OUT="$(mktemp)"
    if ! "$AGENT" < "$PROMPT_FILE" > "$OUT" 2>/dev/null; then
        echo "Error: generation failed. Chapter content was not modified." >&2
        rm -f "$OUT" "$PROMPT_FILE"; exit 2
    fi
    cat "$OUT" > "$CONTENT_FILE"; rm -f "$OUT"
    echo "Chapter content updated from $AGENT."
else
    echo "Prompt written to $PROMPT_FILE. Paste output into $CONTENT_FILE or run with --agent <name>."
fi
rm -f "$PROMPT_FILE"
