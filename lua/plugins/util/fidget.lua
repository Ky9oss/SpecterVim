if vim.g.use_lsp == 1 then
	return {
		"j-hui/fidget.nvim",
		lazy = true,
		event = { "BufEnter" },
		opts = {},
	}
else
	return {
		"j-hui/fidget.nvim",
		lazy = true,
	}
end
