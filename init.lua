-- vim.cmd('source ~/.config/nvim/init.vim')
vim.cmd([[
  set expandtab
  set number
  set laststatus=3
  set encoding=UTF-8
  set noshowmode
  set undodir=~/.local/share/nvim/
]])

require("config.lazy")
require("check-enviroment")
require("keys")
