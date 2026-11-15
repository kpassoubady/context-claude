#!/bin/bash
# Build Marp slide decks to HTML
# Usage: ./scripts/build-slides-html.sh [-p <path>] [-o <output-dir>]
#   -p <path>         Build all slide decks found recursively under <path>
#                     (defaults to <repo>/day1/slides or <repo>/slides)
#   -o <output-dir>   Custom output directory (defaults to <day-dir>/html, a
#                     sibling of slides/, so relative ../ image links resolve)
#   A bare <path> argument is also accepted; if it contains a slides/ folder
#   (e.g. day1), that folder is used as the slide directory.

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
THEME="$REPO_ROOT/assets/theme.css"

# Default to day1/slides if it exists, otherwise slides
if [ -d "$REPO_ROOT/day1/slides" ]; then
  DEFAULT_SLIDE_DIR="$REPO_ROOT/day1/slides"
elif [ -d "$REPO_ROOT/slides" ]; then
  DEFAULT_SLIDE_DIR="$REPO_ROOT/slides"
else
  DEFAULT_SLIDE_DIR="$REPO_ROOT"
fi

SLIDE_DIR="$DEFAULT_SLIDE_DIR"
CUSTOM_OUT_DIR=""

while getopts "p:o:h" opt; do
  case "$opt" in
    p) SLIDE_DIR="$OPTARG" ;;
    o) CUSTOM_OUT_DIR="$OPTARG" ;;
    h)
      echo "Usage: $0 [-p <path>] [-o <output-dir>]"
      echo "  -p <path>         Slide directory to build (default: $DEFAULT_SLIDE_DIR)"
      echo "  -o <output-dir>   Custom output directory (default: <day-dir>/html, sibling of slides/)"
      exit 0
      ;;
    *) echo "Usage: $0 [-p <path>] [-o <output-dir>]" >&2; exit 1 ;;
  esac
done

shift $((OPTIND - 1))
if [ -n "${1:-}" ]; then
  SLIDE_DIR="$1"
fi

# If given a day directory (e.g. day1) that contains slides/, build from slides/
if [ -d "$SLIDE_DIR/slides" ]; then
  SLIDE_DIR="$SLIDE_DIR/slides"
fi

if [ ! -d "$SLIDE_DIR" ]; then
  echo "No slides directory found at $SLIDE_DIR" >&2
  exit 1
fi

SLIDE_DIR="$(cd "$SLIDE_DIR" && pwd)"

if [ -n "$CUSTOM_OUT_DIR" ]; then
  HTML_DIR="$CUSTOM_OUT_DIR"
else
  # Output beside slides/ (not inside) so ../diagrams and ../../images links resolve
  if [ "$(basename "$SLIDE_DIR")" = "slides" ]; then
    HTML_DIR="$(dirname "$SLIDE_DIR")/html"
  else
    HTML_DIR="$SLIDE_DIR/html"
  fi
fi

md_count=$(find "$SLIDE_DIR" -name '*.md' -not -name 'README.md' -not -path '*/\.*' | wc -l | tr -d ' ')
if [ "$md_count" -eq 0 ]; then
  echo "No .md files found under $SLIDE_DIR" >&2
  exit 1
fi

mkdir -p "$HTML_DIR"
echo "Building slides → $HTML_DIR/"

MARP_ARGS=(--html --allow-local-files)
if [ -f "$THEME" ]; then
  MARP_ARGS+=(--theme "$THEME")
fi

find "$SLIDE_DIR" -name '*.md' -not -name 'README.md' -not -path '*/\.*' -print0 | sort -z | while IFS= read -r -d '' md_file; do
  rel_path="${md_file#"$SLIDE_DIR"/}"
  rel_dir=$(dirname "$rel_path")
  filename=$(basename "$md_file" .md)

  # Avoid re-processing files inside html or pdf output directories
  case "$rel_path" in
    html/*|pdf/*) continue ;;
  esac

  if [ "$rel_dir" = "." ]; then
    out_dir="$HTML_DIR"
    out_label="$filename.html"
  else
    out_dir="$HTML_DIR/$rel_dir"
    out_label="$rel_dir/$filename.html"
  fi
  mkdir -p "$out_dir"

  echo "  $rel_path → $out_label"
  marp "${MARP_ARGS[@]}" "$md_file" -o "$out_dir/$filename.html" < /dev/null
done

echo "Done."
