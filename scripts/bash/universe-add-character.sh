#!/usr/bin/env bash
# Add a character to the universe. Creates universe/characters/<character-id>.md from template.
# Usage: universe-add-character.sh <character-id> [name]

set -e

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"

usage() {
    cat <<'EOF'
Usage: universe-add-character.sh <character-id> [name]

  Create universe/characters/<character-id>.md from template.

  character-id  Required. Slug (lowercase, hyphens allowed).
  name          Optional. Display name.

  --help        Show this help.

EOF
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    usage
    exit 0
fi

CHAR_ID="${1:-}"
NAME="${2:-}"

if ! validate_slug "$CHAR_ID" "character-id"; then
    exit 1
fi

PROJECT_DIR="${PROJECT_DIR:-.}"
if [[ ! -d "$PROJECT_DIR/universe" ]]; then
    echo "Error: universe/ not found. Run universe-init first." >&2
    exit 1
fi

TEMPLATES="$(get_universe_content_templates_dir)"
CHAR_FILE="$PROJECT_DIR/universe/characters/$CHAR_ID.md"
mkdir -p "$PROJECT_DIR/universe/characters"
cp "$TEMPLATES/character-template.md" "$CHAR_FILE"
echo "Character '$CHAR_ID' created at $CHAR_FILE. Edit role, traits, goals, backstory, flaw."
