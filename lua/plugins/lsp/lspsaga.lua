if vim.g.use_lsp == 1 then
	return {
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = { "BufEnter" },
		opts = {
			lightbulb = {
				enable = false,
			},
			outline = {
				enable = false,
			},
			rename = {
				enable = false,
			},
			diagnostic = {
				enable = false,
			},
		},
		dependencies = {
			-- "nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	}
else
	return {
		"nvimdev/lspsaga.nvim",
		lazy = true,
	}
end
