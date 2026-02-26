# GBA Vault

## First-time setup

Run the setup script to download the GBA engine files (~17 JS files):

**Mac / Linux / WSL:**
```bash
bash setup.sh
```

**Windows (PowerShell):**
```powershell
.\setup.ps1
```

This creates a `js/` folder. Upload ALL of these to your GitHub repo:
```
index.html
vercel.json
js/util.js
js/core.js
js/arm.js
js/thumb.js
js/mmu.js
js/io.js
js/audio.js
js/video.js
js/video/proxy.js
js/video/software.js
js/video/worker.js
js/irq.js
js/keypad.js
js/sio.js
js/savedata.js
js/gpio.js
js/gba.js
```

Vercel will auto-deploy. The emulator loads from your own domain with zero CDN dependency.
