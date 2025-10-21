-- vim.cmd('source ~/.config/nvim/init.vim')
vim.cmd([[
  set expandtab
  set number
  set laststatus=3
  set encoding=UTF-8
  set noshowmode
  set undodir=~/.local/share/nvim/
]])

-- Copy
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("v", "y", '"+y')
vim.keymap.set("v", "Y", '"+Y')

require("config.lazy")

-- LspSaga
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

-- CRLF
-- vim.opt.fileformats = { "dos", "unix" }
-- vim.opt.fileformat = "dos"
-- vim.opt.fixendofline = false
