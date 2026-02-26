Write-Host "=== GBA Vault Engine Setup ===" -ForegroundColor Cyan
New-Item -Force -ItemType Directory "js/video","resources" | Out-Null

$baseJs  = "https://raw.githubusercontent.com/andychase/gbajs2/master/js"
$baseRes = "https://raw.githubusercontent.com/andychase/gbajs2/master/resources"

$jsFiles = @(
  "util.js","core.js","arm.js","thumb.js","mmu.js",
  "io.js","audio.js","video.js",
  "video/proxy.js","video/software.js","video/worker.js",
  "irq.js","keypad.js","sio.js","savedata.js","gpio.js","gba.js"
)

$failed = 0
Write-Host "Downloading JS engine files..."
foreach ($f in $jsFiles) {
  Write-Host -NoNewline ("  {0,-22}" -f $f)
  try {
    Invoke-WebRequest "$baseJs/$f" -OutFile "js/$f" -TimeoutSec 20 -EA Stop | Out-Null
    Write-Host "✓" -ForegroundColor Green
  } catch { Write-Host "✗ FAILED" -ForegroundColor Red; $failed++ }
}

Write-Host "`nDownloading BIOS..."
Write-Host -NoNewline "  bios.bin              "
try {
  Invoke-WebRequest "$baseRes/bios.bin" -OutFile "resources/bios.bin" -TimeoutSec 20 -EA Stop | Out-Null
  Write-Host "✓" -ForegroundColor Green
} catch { Write-Host "✗ FAILED" -ForegroundColor Red; $failed++ }

Write-Host ""
if ($failed -eq 0) { Write-Host "✓ Done! Upload js/, resources/, index.html, vercel.json to GitHub." -ForegroundColor Green }
else { Write-Host "✗ $failed file(s) failed." -ForegroundColor Red; exit 1 }
