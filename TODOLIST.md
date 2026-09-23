# Fix bugs

## Normal Bugs

- [ ] The first paste based on shada always overlay the current one.
- [ ] Lsp failed sometimes and :LspRestart cause error
- [ ] ui layout is borken in lazy.nvim.txt
  - 🛠️的在neovim中的实际宽度（1格）和界面渲染宽度（2格）为何不一致？

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

## From Lsp to Ctags

> [!TIP]
> Why?
> Because all I need is a lighter, more customizable, and controllable index jump and code completion.
> No more dependencies, complex configurations, inconsistent behavior, or overly heavy applications.

### Lua
- [ ] Lua neovim API

### C
- [ ] how to deal with token pasting(##). maybe a fuzzy matching which just drop all unknown token?
- [ ] support locate in AssemblyExplorer
- [ ] support function-like macro such as `pow` in `/usr/include/bits/mathcalls.h`
- [x] support `makefile` in ctags
- [x] support GNU Manual

## Others

- [ ] Homepage 
- [ ] Auto-switch Input Method

- assmebly explorer:
  -  linux compatibility
    - [x] gcc
    - [x] msvc
  - [x] accept more compile options
  - [ ] optimize msvc by env cache

- [x] <C-'> <g-'>: Ctags jumps: auto split
    - <C-x> and <C-y> in Quickfix
    - <C-w><C-x> <C-w><C-y>


- [ ] Debug comment

- [ ] Support tagbar in Man

- [ ] Bug: Scroll bar will cover the code
- [ ] Scroll bar smoothly scroll in C-F/C-B

- [ ] keymap to Quickfix Bar hide and replay

- [ ] Close `vim.cmd(make)` notify

- [ ] Persistent storage modified-history to use `u` undo whenever you want

- [ ] Requirements init and checker
  - [ ] Mason init
  - [ ] Ensure the libs(bash-scripts/executable) is executable and grant it if it's not.
  - [ ] Test ( See [mini.test](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-test.md) )

- [x] Edit-compile-run config with toml.lua to select builder

- [ ] hex editor with lua FFI (lua_CFunction)

- [ ] Refactor Edit-compile-run-edit flow

# New Plugins

- [ ] Database connecter
