#!/usr/bin/env bash
# Build web images from img/src/<lang>/. Requires cwebp and sips (macOS).
# Output per source: <name>-1920.webp (q80), <name>-960.webp (q78), <name>.jpg (1600px, q82).
# qr-login video (mp4/webm) is copied as-is; its poster becomes a 1600 jpg + webp.
set -euo pipefail

cd "$(dirname "$0")/.."
SRC="img/src"
count=0

for lang in en tr; do
  for src in "$SRC/$lang"/*.jpg; do
    name="$(basename "$src" .jpg)"
    [ "$name" = "qr-login-poster" ] && continue
    out="img/$lang"
    mkdir -p "$out"
    cwebp -quiet -q 80 "$src" -o "$out/$name-1920.webp"
    sips -Z 960 "$src" --out "$out/$name.tmp960.jpg" >/dev/null
    cwebp -quiet -q 78 "$out/$name.tmp960.jpg" -o "$out/$name-960.webp"
    rm "$out/$name.tmp960.jpg"
    sips -Z 1600 -s formatOptions 82 "$src" --out "$out/$name.jpg" >/dev/null
    count=$((count + 1))
  done
done

for lang in en tr; do
  out="img/$lang"
  mkdir -p "$out"
  cp "$SRC/$lang/qr-login.mp4" "$SRC/$lang/qr-login.webm" "$out/"
  sips -Z 1600 -s formatOptions 82 "$SRC/$lang/qr-login-poster.jpg" --out "$out/qr-login-poster.jpg" >/dev/null
  cwebp -quiet -q 80 "$out/qr-login-poster.jpg" -o "$out/qr-login-poster.webp"
done

echo "images: built webp 960/1920 + jpg 1600 for $count sources per language"
