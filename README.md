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

A personal Neovim setup built on Lazy.nvim with curated plugins. It's not a user-facing "Neovim distribution" like [LazyVim](https://github.com/LazyVim/LazyVim), but rather some configurations and extensions I use in my daily work.

## Requirements
- neovim >= 0.12
- Git >= 2.19.0 (for partial clones support)
- luarocks >= 3.13.0
- C compiler && Make (for treesitter parsers)
- [toml.lua](https://github.com/LebJe/toml.lua)
- [tmux](https://github.com/tmux/tmux) (optional)
- a [Nerd Font](https://www.nerdfonts.com/) (optional)

## Installation

### Linux (recommand)

```bash
mv ~/.config/nvim ~/.config/nvim_bak
git clone https://github.com/Ky9oss/SpecterVim ~/.config/nvim
```

### Windows
> [!WARNING]
> Some new features have become dependent on Linux, including certain Bash scripts and optimizations that involve Linux system calls.

```ps1

# Stylua encountered an unexpected error when installed via Mason on Windows, so we install it using cargo
cargo install stylua --features luajit

Move-Item -Path "$env:USERPROFILE\AppData\Local\nvim" -Destination "$env:USERPROFILE\AppData\Local\nvim_bak"
git clone https://github.com/Ky9oss/SpecterVim "$env:USERPROFILE\AppData\Local\nvim"
```

---

After that, just open Neovim. All pluggins will be installed automatically.

> If you need a proxy to access Github, you can install [proxychains-ng](https://github.com/rofl0r/proxychains-ng) on linux or [proxychains-windows](https://github.com/shunf4/proxychains-windows) on windows, and use `proxychains -q nvim` to install the plugins.


## Configurations

### Global configuration
In your neovim's config path (Use :lua vim.fn.stdpath("config") to show it), add `.env`:
```txt
# This is used for AssemblyExplorer
SSHSERVER=user@ip
SSHPORT=2222
SSHPASS=xxxx
```

### Project configuration
In your project's root path, add `specterv.toml`: 
```toml
[edit-compile-run]
builder = "gcc" # gcc clang make autotools cmake custom
custom_compile = 
```

