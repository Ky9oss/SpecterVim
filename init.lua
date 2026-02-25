vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.profiler = true -- a neovim lua profiler in snacks.nvim
vim.g.copy_to_system = true -- duplicate 'y' in keymaps.lua

if vim.fn.has("win32") ~= 1 then
  if vim.env.TMUX == nil or vim.env.TMUX == "" then
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },
      paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
      },
    }
  else
    vim.g.clipboard = {
      name = "tmux-osc52-fallback",
      copy = {
        ["+"] = { "tmux", "load-buffer", "-w", "-" },
        ["*"] = { "tmux", "load-buffer", "-w", "-" },
      },
      paste = {
        ["+"] = { "tmux", "save-buffer", "-" },
        ["*"] = { "tmux", "save-buffer", "-" },
      },
      cache_enabled = true,
    }
  end
end

vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.encoding = "UTF-8"
vim.opt.undodir = "~/.local/share/nvim/"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.o.autoread = true

-- CRLF to LF
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fileformat = "unix"
vim.opt.fixendofline = false

vim.diagnostic.config({
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

require("config.env")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("config.commands")
require("config.lsp")
