#!/usr/bin/env bash
# Converts an AVIF file to JPG using ImageMagick 7+.
# Usage: ./scripts/to-jpg.sh <input.avif> [output.jpg]
#   If output is omitted, the file is written to the same directory
#   with the .avif suffix replaced by .jpg.

set -euo pipefail

INPUT="${1:?Usage: $0 <input.avif> [output.jpg]}"
OUTPUT="${2:-${INPUT%.avif}.jpg}"

if ! command -v magick &>/dev/null; then
  echo "Error: ImageMagick 7+ is required. Install with: brew install imagemagick"
  exit 1
fi

echo "Converting: $INPUT → $OUTPUT"
magick "$INPUT" "$OUTPUT"
echo "Done."

