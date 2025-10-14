<div align="center">
    <h1>SpecterVim</h1>
    <img src="https://img.shields.io/badge/Made%20with-Lua-1f425f.svg" alt="made-with-lua">
    <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" alt="Maintenance">
    <img src="https://img.shields.io/badge/Maintainer-Ky9oss-red" alt="Maintainer">
    <br>
    <br>
    <img src="img/ghost.png" alt="" width="203.5" height="203.5">
    <br>
    <br>
</div>

A personal Neovim setup built on Lazy.nvim with curated plugins. It's lightweight and continuously updated for my own workflow, offering an easy plug-and-play experience.

## Installation

### Linux
```bash
mv ~/.config/nvim ~/.config/nvim_bak
git clone https://github.com/Ky9oss/SpecterVim ~/.config/nvim
```

### Windows
```powershell
Move-Item -Path "$env:USERPROFILE\AppData\Local\nvim" -Destination "$env:USERPROFILE\AppData\Local\nvim_bak"
git clone https://github.com/Ky9oss/SpecterVim "$env:USERPROFILE\AppData\Local\nvim"
```

---

After that, just open Neovim. All pluggins will be installed automatically.
If you need a proxy to access Github, you can install [proxychains-ng](https://github.com/rofl0r/proxychains-ng) on linux or [proxychains-windows](https://github.com/shunf4/proxychains-windows) on windows, and use `proxychains -q nvim` to install the plugins.

