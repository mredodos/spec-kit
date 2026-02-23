#!/usr/bin/env bash
# Author-facing wrapper: delegate to universe-add-book with same args.
SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/universe-add-book.sh" "$@"
