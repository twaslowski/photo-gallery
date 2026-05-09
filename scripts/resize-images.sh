#!/usr/bin/env bash
# Generates multiple width variants of AVIF images for srcset usage.
# Requires ImageMagick 7+ with AVIF support: brew install imagemagick
#
# Usage: ./scripts/resize-images.sh <input-dir> [output-dir]
#   If output-dir is omitted, resized images are written alongside originals.
#
# Output filenames: <name>-<width>w.avif  (e.g. boats-1-800w.avif)

set -euo pipefail

WIDTHS=(480 800 1200 1600)
QUALITY=75

INPUT_DIR="${1:?Usage: $0 <input-dir> [output-dir]}"
OUTPUT_DIR="${2:-$INPUT_DIR}"

if ! command -v magick &>/dev/null; then
  echo "Error: ImageMagick 7+ is required. Install with: brew install imagemagick"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

for file in "$INPUT_DIR"/*.avif; do
  [ -f "$file" ] || continue
  basename="$(basename "$file" .avif)"

  # Skip files that are already resized variants
  if [[ "$basename" =~ -[0-9]+w$ ]]; then
    continue
  fi

  orig_width=$(magick identify -format "%w" "$file")

  for w in "${WIDTHS[@]}"; do
    outfile="$OUTPUT_DIR/${basename}-${w}w.avif"

    # Skip if target width is larger than original
    if [ "$w" -ge "$orig_width" ]; then
      echo "  skip ${w}w (original is ${orig_width}px)"
      continue
    fi

    # Skip if already exists
    if [ -f "$outfile" ]; then
      echo "  skip ${basename}-${w}w.avif (exists)"
      continue
    fi

    echo "  ${basename}.avif → ${w}w"
    magick "$file" -resize "${w}x" -quality "$QUALITY" "$outfile"
  done
done

echo "Done."

