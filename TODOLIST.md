# Fix bugs

## Normal Bugs

- [ ] The first paste based on shada always overlay the current one.
- [ ] Lsp failed sometimes and :LspRestart cause error

# New Features

## About .NET

- [ ] Debugger
- [ ] Add PDB support for source link to audit source code instead of decompiled code in .NET runtime / aspnetcore
- [ ] (?) Performance Analyzer like Visual Studio 2026
- [ ] a more grace way to replace hover() with signature_help() in roslyn

## About C/Cpp

- [x] Debugger

- Edit-compile-edit for all c-compilation-env by Quickfix
  - [x] normal gcc
  - [x] Makefile
  - [ ] autotools
  - [ ] Cmake
  - [ ] Meson
  - [ ] Custom

## From Lsp to Ctags

> [!TIP]
> Why?
> Because all I need is a lighter, more customizable, and controllable index jump and code completion.
> No more dependencies, complex configurations, inconsistent behavior, or overly heavy applications.

- [ ] how to deal with token pasting(##). maybe a fuzzy matching which just drop all unknown token?
- [ ] support locate in AssemblyExplorer
- [ ] support function-like macro such as `pow` in `/usr/include/bits/mathcalls.h`
- [x] support `makefile` in ctags
- [x] support GNU Manual

## Others

- assmebly explorer:
  -  linux compatibility
    - [x] gcc
    - [x] msvc
  - [x] accept more compile options
  - [ ] optimize msvc by env cache

- [x] encrypt password

- [x] <C-'> <g-'>: Ctags jumps: auto split
    - <C-x> and <C-y> in Quickfix
    - <C-w><C-x> <C-w><C-y>

- [ ] Requirements init and checker
  - [ ] Mason init
  - [ ] Ensure the libs(bash-scripts/executable) is executable and grant it if it's not.
  - [ ] Test ( See [mini.test](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-test.md) )

- [ ] Edit-compile-run config with toml.lua to select builder

- [ ] hex editor with lua FFI (lua_CFunction)

- [ ] Refactor Edit-compile-run-edit flow

# New Plugins

- [ ] Database connecter
