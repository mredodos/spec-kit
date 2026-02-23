#!/usr/bin/env bash
# Create initial outline and structure files from .universe/templates in project root or under universe/.
set -e
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-universe.sh"
usage() { echo "Usage: setup-structure.sh [--help]"; echo "  Creates outline.md and structure.md from templates in current dir or universe/."; }
[[ "$1" == "--help" || "$1" == "-h" ]] && { usage; exit 0; }
PROJECT_DIR="${PROJECT_DIR:-.}"
TEMPLATES="$(get_universe_templates_dir)"
for name in outline structure; do
    tpl="$TEMPLATES/${name}-template.md"
    dest="$PROJECT_DIR/${name}.md"
    [[ -f "$tpl" ]] && cp "$tpl" "$dest" && echo "Created $dest"
done
echo "Structure setup done. Edit outline.md and structure.md."
