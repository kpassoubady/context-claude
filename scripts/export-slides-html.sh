#!/bin/bash
# Export Marp slide decks to HTML format
# Delegates to build-slides-html.sh

exec "$(dirname "$0")/build-slides-html.sh" "$@"
