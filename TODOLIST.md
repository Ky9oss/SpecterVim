# Fix bugs

## Low-level Bugs
- [ ] **Debug the OS(Windows11 & WSL2 & Neovim11)**: Gets stuck when enter files and tigger BufRead/BufNewFile/BufEnter/FileType events to start LSP on WSL2. The Custom User Event is Fine.

## Normal Bugs
- [ ] Powershell hover_doc error
- [ ] Powershell do not auto dap
- [ ] Gets stuck when :w in ps1

# New Features

## About Git

- [x] New command to git push, a tap for what will update

## About .NET

- [ ] .slnx resolve
- [ ] Auto load lib in .NET (Visual Studio)
- [ ] PDB support for source link to .NET runtime and aspnetcore
- [ ] Debugger
- [ ] Formatter
- [ ] Runner
- [ ] (?) Performance Analyzer like Visual Studio 2026 

## Optimize

- [x] ~~E211: File "xxx" no longer available -> nvim-notify~~ nvim-notify just takeover vim.fn.notify(), but error message come from C functions. Use noice.nvim can fix it.

## Lualine

- [ ] remove project path && add page path
- [ ] Limit the length of page path
- [ ] Show More LSP information for current buffer, include LSP name, code-language or runtime versions.

## Nvimtree

- [x] Do not change dir in nvimtree when 'gd'
- [x] Limit the length of project names
- [x] When enter neovim by `nvim`, auto open nvimtree. When enter neovim by `nvim xxx`, do not auto open nvimtree.

## Floaterm

- [ ] Preload shell in `VeryLazy`

# New Plugins

- [ ] Homepage
- [ ] Database connecter
