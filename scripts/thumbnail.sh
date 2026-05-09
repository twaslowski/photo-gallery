#!/usr/bin/env bash
# Generate a 480px-wide thumbnail from a single AVIF image.
# Requires ImageMagick 7+: brew install imagemagick
#
# Usage: ./scripts/thumbnail.sh <input.avif> [output.avif]
#   If output is omitted, writes <name>-480w.avif next to the original.

set -euo pipefail

QUALITY=80
WIDTH=600

INPUT="${1:?Usage: $0 <input.avif> [output.avif]}"

if ! command -v magick &>/dev/null; then
  echo "Error: ImageMagick 7+ is required. Install with: brew install imagemagick"
  exit 1
fi

if [ ! -f "$INPUT" ]; then
  echo "Error: file not found: $INPUT"
  exit 1
fi

basename="$(basename "$INPUT" .avif)"
dir="$(dirname "$INPUT")"
OUTPUT="${2:-${dir}/${basename}-${WIDTH}w.avif}"

echo "${INPUT} → ${OUTPUT}"
magick "$INPUT" -resize "${WIDTH}x" -quality "$QUALITY" "$OUTPUT"
echo "Done."

