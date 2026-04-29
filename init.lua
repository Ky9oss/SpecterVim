vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.profiler = 0 -- a neovim lua profiler in snacks.nvim
vim.g.copy_to_system = true -- duplicate 'y' in keymaps.lua
vim.g.clangd = 1 -- enable clangd lsp OR use ctags without lsp (1 or 0)
vim.g.specter_debug = 0 -- enable debug (1 or 0)
vim.g.nvim_tree_moved = 0 -- nvim_tree has moved from left to right (1 or 0)

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
		-- This was valid until I upgraded Debian from 12 to 13. :-(
		--
		-- vim.g.clipboard = {
		--   name = "tmux-osc52-fallback",
		--   copy = {
		--     ["+"] = { "tmux", "load-buffer", "-w", "-" },
		--     ["*"] = { "tmux", "load-buffer", "-w", "-" },
		--   },
		--   paste = {
		--     ["+"] = { "tmux", "save-buffer", "-" },
		--     ["*"] = { "tmux", "save-buffer", "-" },
		--   },
		--   cache_enabled = true,
		-- }
		--
		local command = vim.fn.stdpath("config") .. "/lib/osc52-fixed.sh"

		vim.g.clipboard = {
			name = "tmux-osc52-fixed",

			-- neovim -> stdin-pipe -> command
			copy = {
				["+"] = { command },
				["*"] = { command },
			},
			paste = {
				["+"] = { "tmux", "save-buffer", "-" },
				["*"] = { "tmux", "save-buffer", "-" },
			},
			cache_enabled = true,
		}
	end
end

shada_path = vim.fn.stdpath("cache") .. "/shada"

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
vim.opt.shada = "'0,<1000,:0,n" .. shada_path
-- vim.opt.jumpoptions = "stack,view,clean"
vim.o.autoread = true
vim.opt.tags = "tagfiles/**/tags"
vim.opt.equalalways = false -- auto resize windows
vim.opt.winwidth = 35 -- expected width
vim.opt.winminwidth = 30 -- min width

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
require("config.keymaps")
require("config.commands")
require("config.autocmds")
require("config.lsp")
require("config.after")

-- Used for debug
if vim.g.specter_debug == 1 then
	require("config.debug")
end
