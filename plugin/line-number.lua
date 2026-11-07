-- Local Options
local DEFAULT_OPTIONS = {
	auto_switch = {
		enable = true,
    disc = "Automatically switch the line number format when entering and living Insert-Mode.",
    config = {},
	},
}

-- Global Options
vim.opt.number = true

-- Autocommand
local augroup = vim.api.nvim_create_augroup("line-number", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			-- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
			-- Workaround for https://github.com/neovim/neovim/issues/32068
			if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
				vim.cmd("redraw")
			end
		end
	end,
})

-- Keymaps

-- Commands
