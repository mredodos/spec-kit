#!/usr/bin/env bash
# Check universe/ exists and required structure present. Author-facing messages. Replaces check-prerequisites for book-universe context.
set -e
usage() { echo "Usage: validate-setup.sh [--help]"; echo "  Check that universe/ and core files exist."; }
[[ "$1" == "--help" || "$1" == "-h" ]] && { usage; exit 0; }
PROJECT_DIR="${PROJECT_DIR:-.}"
UNIVERSE_DIR="$PROJECT_DIR/universe"
if [[ ! -d "$UNIVERSE_DIR" ]]; then
    echo "Setup incomplete: universe/ not found. Run universe-init first." >&2
    exit 1
fi
[[ ! -f "$UNIVERSE_DIR/universe.md" ]] && { echo "Setup incomplete: universe/universe.md missing." >&2; exit 1; }
echo "Universe setup OK: universe/ and universe.md present."
