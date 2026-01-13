# Fix bugs

## Low-level Bugs
- [ ] **Debug the OS(Windows11 & WSL2 & Neovim11)**: Gets stuck when enter files and tigger BufRead/BufNewFile/BufEnter/FileType events to start LSP on WSL2. The Custom User Event is Fine.

## Normal Bugs
- [ ] Powershell hover_doc error
- [ ] Powershell do not auto dap
- [ ] Gets stuck when :w in ps1

# New Features

## About Git

- [ ] New keymap to git push, a tap for what will update

## About .NET

- [ ] .slnx resolve
- [ ] Auto load lib in .NET (Visual Studio)
- [ ] PDB support for source link to .NET runtime and aspnetcore
- [ ] Debugger
- [ ] Formatter
- [ ] Runner
- [ ] (?) Performance Analyzer like Visual Studio 2026 

## Optimize

- [ ] E211: File "xxx" no longer available -> close buffer instead of warning

## Lualine

- [ ] remove project path && add page path
- [ ] change project name from project.nvim to .git
- [ ] Limit the length of project names
- [ ] Show More LSP information, include code-language or runtime versions.

## Nvimtree

- [x] Do not change dir in nvimtree when 'gd'
- [ ] Limit the length of project names
- [ ] When enter neovim by `nvim`, auto open nvimtree. When enter neovim by `nvim xxx`, do not auto open nvimtree.
- [ ] After `:NvimTreeOpen`, always locate to project root dir.

## Floaterm

- [ ] Preload shell in `VeryLazy`

## Others

- [ ] No auto `zm`

# New Plugins

- [ ] Homepage
- [ ] Database connecter
