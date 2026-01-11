-- Copy
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("v", "y", '"+y')
vim.keymap.set("v", "Y", '"+Y')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.profiler = false -- a neovim lua profiler in snacks.nvim

vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.number =true
vim.opt.laststatus = 3
vim.opt.encoding = "UTF-8"
vim.opt.undodir = "~/.local/share/nvim/"

require("config.lazy")

-- LspSaga
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

-- CRLF
-- vim.opt.fileformats = { "dos", "unix" }
-- vim.opt.fileformat = "dos"
-- vim.opt.fixendofline = false
