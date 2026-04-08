return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	lazy = true,
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()

		-- 这里被坑了，注意：
		-- 1. telescope.actions只能在telescope加载后加载。Lazy.nvim的opts配置会在插件加载时同时加载（因此不能使用actions），而config配置会在插件加载后加载
		-- 2. actions.select_vertical 需要用在Picker上下文中，所以必须setup。而builtin会自动启动Picker，所以可以用vim.keymap.set
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<c-y>"] = actions.select_vertical,
						["<c-x>"] = actions.select_horizontal,
					},
					n = {
						["<c-y>"] = actions.select_vertical,
						["<c-x>"] = actions.select_horizontal,
					},
				},
			},
		})
	end,
}
