#!/usr/bin/env bash
# Generate non-chapter content (character-draft, scene-draft, summary). Same context as chapter; output under universe/drafts/ or universe/characters/<id>-draft.md.
# Usage: universe-generate-content.sh <type> [--target-id <id>] [--agent <name>]
# Types: character-draft, scene-draft, summary. On failure: do not overwrite; exit 2.

set -e

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"

usage() {
    echo "Usage: universe-generate-content.sh <type> [--target-id <id>] [--agent <name>]"
    echo "  type: character-draft | scene-draft | summary. For character-draft, --target-id is required."
    echo "  Output: character-draft -> universe/characters/<id>-draft.md; others -> universe/drafts/<type>-<slug>.md"
    echo "  --help  Show help."
}

TYPE="${1:-}"
TARGET_ID=""
AGENT=""
shift 2>/dev/null || true
while [[ $# -gt 0 ]]; do
    case "$1" in
        --target-id) TARGET_ID="$2"; shift 2 ;;
        --agent) AGENT="$2"; shift 2 ;;
        --help|-h) usage; exit 0 ;;
        *) shift ;;
    esac
done

if [[ "$TYPE" != "character-draft" && "$TYPE" != "scene-draft" && "$TYPE" != "summary" ]]; then
    echo "Error: type must be character-draft, scene-draft, or summary." >&2
    exit 1
fi
if [[ "$TYPE" == "character-draft" ]] && ! validate_slug "$TARGET_ID" "target-id"; then
    exit 1
fi

PROJECT_DIR="${PROJECT_DIR:-.}"
UNIVERSE_DIR="$PROJECT_DIR/universe"
mkdir -p "$UNIVERSE_DIR/drafts"

if [[ "$TYPE" == "character-draft" ]]; then
    OUT_FILE="$UNIVERSE_DIR/characters/${TARGET_ID}-draft.md"
else
    SLUG="${TARGET_ID:-$(date +%s)}"
    OUT_FILE="$UNIVERSE_DIR/drafts/${TYPE}-${SLUG}.md"
fi

# Minimal prompt for non-chapter content
PROMPT_FILE="${TMPDIR:-/tmp}/universe-content-prompt-$$.md"
{
    [[ -f "$UNIVERSE_DIR/universe.md" ]] && cat "$UNIVERSE_DIR/universe.md"
    echo "---"
    echo "Generate: $TYPE. Target: ${TARGET_ID:-general}. Output only the requested content."
} > "$PROMPT_FILE"

if [[ -n "$AGENT" ]]; then
    if ! command -v "$AGENT" >/dev/null 2>&1; then
        echo "Error: agent '$AGENT' not found." >&2
        exit 2
    fi
    TMPOUT="$(mktemp)"
    if ! "$AGENT" < "$PROMPT_FILE" > "$TMPOUT" 2>/dev/null; then
        echo "Error: generation failed. No file was overwritten." >&2
        rm -f "$TMPOUT" "$PROMPT_FILE"
        exit 2
    fi
    cat "$TMPOUT" > "$OUT_FILE"
    rm -f "$TMPOUT"
    echo "Content written to $OUT_FILE"
else
    echo "Prompt in $PROMPT_FILE. Run with --agent <name> to generate, or paste output into $OUT_FILE"
fi
rm -f "$PROMPT_FILE"
