vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.profiler = true -- a neovim lua profiler in snacks.nvim

vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.number =true
vim.opt.laststatus = 3
vim.opt.encoding = "UTF-8"
vim.opt.undodir = "~/.local/share/nvim/"

require("config.autocmd")
require("config.lazy")
require("config.keymaps")

-- CRLF
-- vim.opt.fileformats = { "dos", "unix" }
-- vim.opt.fileformat = "dos"
-- vim.opt.fixendofline = false
