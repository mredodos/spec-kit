#!/usr/bin/env bash
# List chapters (and optionally scenes) that reference a world-rule category or character id. MVP: chapter-level.
# Usage: universe-list-affected.sh --world-rule <category> | universe-list-affected.sh --character-id <id>
set -e
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"
usage() { echo "Usage: universe-list-affected.sh (--world-rule <category> | --character-id <id>)"; echo "  Output: list of chapter paths to stdout."; echo "  --help  Show help."; }
[[ "$1" == "--help" || "$1" == "-h" ]] && { usage; exit 0; }
WORLD_RULE=""; CHAR_ID=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --world-rule) WORLD_RULE="$2"; shift 2 ;;
        --character-id) CHAR_ID="$2"; shift 2 ;;
        --help|-h) usage; exit 0 ;;
        *) shift ;;
    esac
done
PROJECT_DIR="${PROJECT_DIR:-.}"
UNIVERSE_DIR="$PROJECT_DIR/universe"
if [[ ! -d "$UNIVERSE_DIR" ]]; then echo "Error: universe/ not found. Run universe-init first." >&2; exit 1; fi
if [[ -z "$WORLD_RULE" && -z "$CHAR_ID" ]]; then echo "Error: provide exactly one of --world-rule or --character-id." >&2; exit 1; fi
if [[ -n "$WORLD_RULE" && -n "$CHAR_ID" ]]; then echo "Error: provide only one of --world-rule or --character-id." >&2; exit 1; fi
PATTERN="$CHAR_ID"
[[ -n "$WORLD_RULE" ]] && PATTERN="$WORLD_RULE"
find "$UNIVERSE_DIR/books" -path "*/chapters/*/guide.md" -o -path "*/chapters/*/content.md" 2>/dev/null | while read -r f; do
    if grep -qi "$PATTERN" "$f" 2>/dev/null; then
        dirname "$f"
    fi
done | sort -u
