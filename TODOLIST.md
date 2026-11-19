# Fix bugs

## Normal Bugs

- [ ] The first paste based on shada always overlay the current one.
- [ ] Lsp failed sometimes and :LspRestart cause error
- [ ] ui layout is borken in lazy.nvim.txt
  - 🛠️的在neovim中的实际宽度（1格）和界面渲染宽度（2格）为何不一致？

- [ ] `:checkhealth` stuck
- [ ] Command-Mode keymaps error (keymaps.lua 20)

# New Features

## About .NET

- [ ] Debugger
- [ ] Add PDB support for source link to audit source code instead of decompiled code in .NET runtime / aspnetcore
- [ ] (?) Performance Analyzer like Visual Studio 2026
- [ ] a more grace way to replace hover() with signature_help() in roslyn

## About C/Cpp
- Code Completion:
  - [ ] important macros such as STDIN_FILENO

- Edit-compile-edit for all c-compilation-env by Quickfix
  - [x] normal gcc
  - [x] Makefile
  - [x] Custom
  - [ ] autotools
  - [ ] Cmake
  - [ ] Meson

## About Man
- [ ] Man page with relative line number and fixed page width
- [ ] tagbar

## About Lua
- [ ] LSP
- [ ] Lua neovim API

## About Java / Cpp / Python / Rust / Go / Powershell
- To be determined

## About C

### Ctags
- [ ] how to deal with token pasting(##). maybe a fuzzy matching which just drop all unknown token?
- [ ] support locate in AssemblyExplorer
- [ ] support function-like macro such as `pow` in `/usr/include/bits/mathcalls.h`
- [x] support `makefile` in ctags
- [x] support GNU Manual

## Plugins

### jump
- [ ] a jump plugin
  - Self-developed: jump by ctags
  - https://github.com/obsidian-nvim/obsidian.nvim
  - https://github.com/nvim-telekasten/telekasten.nvim
  - https://github.com/echaya/neowiki.nvim

### dashboard
- [ ] Dashboard
  - projects lists
  - lists classification
  - projects search
  - open new projects (Windows: File Explorer)
  - open new projects (Linux: fzf)
  - delete projects from lists
  - Return to homepage from current project, quit everything, restore env, and then open new projects

### auto-switch srf
- [ ] Auto-switch Input Method

### line number
- [ ] line number operation for every windows

### assmebly explorer
- assmebly explorer:
  -  linux compatibility
    - [x] gcc
    - [x] msvc
  - [x] accept more compile options
  - [ ] optimize msvc by env cache

- [x] <C-'> <g-'>: Ctags jumps: auto split
    - <C-x> and <C-y> in Quickfix
    - <C-w><C-x> <C-w><C-y>

### comment.nvim
- [ ] Debug comment

### tagbar
- [ ] Support tagbar in Man and help
- [ ] Fix Lua tags with too many meaningless "callback"

### scroll bar
- [ ] Bug: Scroll bar will cover the code
- [ ] Scroll bar smoothly scroll in C-F/C-B

### edit-compile-run
- [x] Edit-compile-run config with toml.lua to select builder
- [ ] Close `vim.cmd(make)` notify
- [ ] Refactor Edit-compile-run-edit flow

### persistent u
- [ ] Persistent storage modified-history to use `u` undo whenever you want

### specter vim init
- [ ] Requirements init and checker
  - [ ] Mason init
  - [ ] Ensure the libs(bash-scripts/executable) is executable and grant it if it's not.
  - [ ] Test ( See [mini.test](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-test.md) )

### hex editor
- [ ] hex editor with lua FFI (lua_CFunction)

### database
- [ ] Database connecter

### fold
- [ ] Better fold

### floaterm
- [ ] Replace `\sh` with tmux float term

### Others
- [ ] Sessions.vim never pushed

## Keymaps
- [ ] keymap to Quickfix Bar hide and replay


