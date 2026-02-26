#!/bin/bash
echo "=== GBA Vault Engine Setup ==="
mkdir -p js/video resources

BASE_JS="https://raw.githubusercontent.com/andychase/gbajs2/master/js"
BASE_RES="https://raw.githubusercontent.com/andychase/gbajs2/master/resources"

JS_FILES=(
  "util.js" "core.js" "arm.js" "thumb.js" "mmu.js"
  "io.js" "audio.js" "video.js"
  "video/proxy.js" "video/software.js" "video/worker.js"
  "irq.js" "keypad.js" "sio.js" "savedata.js" "gpio.js" "gba.js"
)

FAILED=0
echo "Downloading JS engine files..."
for f in "${JS_FILES[@]}"; do
  printf "  %-22s" "$f"
  if curl -sf --max-time 20 -o "js/$f" "$BASE_JS/$f"; then
    echo "✓  ($(wc -c < js/$f) bytes)"
  else
    echo "✗  FAILED"; FAILED=$((FAILED+1))
  fi
done

echo ""
echo "Downloading BIOS..."
printf "  %-22s" "bios.bin"
if curl -sf --max-time 20 -o "resources/bios.bin" "$BASE_RES/bios.bin"; then
  echo "✓  ($(wc -c < resources/bios.bin) bytes)"
else
  echo "✗  FAILED"; FAILED=$((FAILED+1))
fi

echo ""
if [ $FAILED -eq 0 ]; then
  echo "✓ All files downloaded! Upload js/, resources/, index.html, vercel.json to GitHub."
else
  echo "✗ $FAILED file(s) failed. Check your internet connection and retry."
  exit 1
fi
