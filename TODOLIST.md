# Fix bugs

## Normal Bugs

- [x] `<leader>ql` reopen other files
- [ ] Lsp failed sometimes and :LspRestart cause error

# New Features

## About .NET

- [ ] Debugger
- [ ] Add PDB support for source link to audit source code instead of decompiled code in .NET runtime / aspnetcore
- [ ] (?) Performance Analyzer like Visual Studio 2026

## About C/Cpp

- [ ] Debugger

- Edit-compile-edit for all c-compilation-env by Quickfix
  - [x] normal gcc
  - [ ] Makefile
  - [ ] Cmake
  - [ ] Meson
  - [ ] Ninja
  - [ ] A controllable compile command instead of :Make

## About Tmux

- [x] restore neovim pages(`<leader>ql`) when restore tmux

## From Lsp to Ctags

> [!TIP]
> Why?
> Because all I need is a lighter, more customizable, and controllable index jump and code completion.
> No more dependencies, complex configurations, inconsistent behavior, or overly heavy applications.

- [ ] support locate in AssemblyExplorer
- [ ] support function-like macro such as `pow` in `/usr/include/bits/mathcalls.h`
- [ ] support GNU Manual in `:help`
- [x] support `makefile` in ctags

## Others

- assmebly explorer:
  -  linux compatibility
    - [x] gcc
    - [x] msvc
  - [x] accept more compile options
  - [ ] optimize msvc by env cache

- [x] encrypt password

- [ ] Ensure the libs(bash-scripts/executable) is executable and grant it if it's not.

- [ ] a more grace way to replace hover() with signature_help() in roslyn

# New Plugins

- [ ] Homepage
- [ ] Database connecter
