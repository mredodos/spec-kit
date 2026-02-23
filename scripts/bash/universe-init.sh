#!/usr/bin/env bash
# Initialize a new universe: create universe/ and core files from templates.
# Usage: universe-init.sh [project-dir]
# Default project-dir is current directory. Author-facing: no "spec" or "feature" in messages.

set -e

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"

usage() {
    cat <<EOF
Usage: universe-init.sh [project-dir]

  Initialize a new writing universe in the given directory.
  Creates universe/, universe.md, continuity-log.md, timeline.md, and foreshadowing-register.md from templates.

  project-dir  Optional. Default: current directory.

  --help       Show this help.

EOF
}

PROJECT_DIR="${1:-.}"

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    usage
    exit 0
fi

if [[ -z "$PROJECT_DIR" ]]; then
    echo "Error: project-dir must be non-empty. Use . for current directory." >&2
    exit 1
fi

if [[ ! -d "$PROJECT_DIR" ]]; then
    echo "Error: directory does not exist: $PROJECT_DIR" >&2
    exit 1
fi

TEMPLATES="$(get_universe_content_templates_dir)"
if [[ ! -d "$TEMPLATES" ]]; then
    echo "Error: framework templates not found. Ensure .universe/templates/universe/ exists." >&2
    exit 1
fi

UNIVERSE_DIR="$PROJECT_DIR/universe"
mkdir -p "$UNIVERSE_DIR"

cp "$TEMPLATES/universe-template.md" "$UNIVERSE_DIR/universe.md"
cp "$TEMPLATES/continuity-log-template.md" "$UNIVERSE_DIR/continuity-log.md"
cp "$TEMPLATES/timeline-template.md" "$UNIVERSE_DIR/timeline.md"
cp "$TEMPLATES/foreshadowing-register-template.md" "$UNIVERSE_DIR/foreshadowing-register.md"

echo "Universe initialized in $UNIVERSE_DIR. Edit universe/universe.md to set genre, style, and world rules."
