if vim.g.use_lsp == 1 then
	return {
		"neovim/nvim-lspconfig",
		ft = { "c", "cpp", "rust", "python", "asm", "lua", "ps1" },
		lazy = false,
	}
else
	return {
		"neovim/nvim-lspconfig",
		lazy = true,
	}
end
