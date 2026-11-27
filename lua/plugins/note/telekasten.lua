if vim.g.is_windows ~= 1 then
	return {
		"renerocksai/telekasten.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telekasten").setup({
				home = vim.fn.expand("~/notes/telkasten"),
			})
		end,
	}
else
	return {}
end
