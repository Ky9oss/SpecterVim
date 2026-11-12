return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	lazy = true,
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- Telescope Keymaps
		require("telescope").load_extension("projects")
		vim.keymap.set("n", "<leader>fp", function()
			require("telescope").extensions.projects.projects()
		end, { noremap = true, silent = true, desc = "Find Projects" })

		local ok, builtin = pcall(require, "telescope.builtin")
		if ok then
			-- vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true })
			-- vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true })
			-- vim.keymap.set("n", "gi", builtin.lsp_implementations, { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"<leader>gi",
				"<cmd>Telescope lsp_implementations<cr>",
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
			vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

			vim.keymap.set(
				"n",
				"<leader>sgd",
				"<cmd>split | Telescope lsp_definitions<cr>",
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>sgr",
				"<cmd>split | Telescope lsp_references<cr>",
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>sgi",
				"<cmd>split | Telescope lsp_implementations<cr>",
				{ noremap = true, silent = true }
			)

			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
			vim.keymap.set("n", "<leader>faf", "<cmd>Telescope find_files no_ignore=true hidden=true<cr>")

			local live_grep_ignore = {
				"-g",
				"!node_modules/**",
				"-g",
				"!autom4te.cache/**",
				"-g",
				"!tags",
				"-g",
				"!.git/**",
				"-g",
				"!snippets/**",
			}
			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({
					additional_args = live_grep_ignore,
				})
			end)
			vim.keymap.set("n", "<leader>fag", function()
				builtin.live_grep({
					additional_args = vim.list_extend({
						"--hidden",
						"-u",
					}, live_grep_ignore),
				})
			end)
		-- vim.keymap.set("n", "g]", function()
		-- 	builtin.tags({
		-- 		default_text = vim.fn.expand("<cword>"),
		-- 		ctags_file = nil,
		-- 		-- ctags_file = project_root .. "/tagfiles/**/tags",
		-- 	})
		-- end, { desc = "Telescope: search project tags for word under cursor" })
		else
			vim.notify("Telescope load failed.", vim.log.levels.ERROR)
		end

		-- Notice:
		-- 1. telescope.actions只能在telescope加载后加载。
		--  Lazy.nvim的opts配置会在插件加载时同时加载（因此不能使用actions），而config配置会在插件加载后加载
		-- 2. actions.select_vertical 需要用在Picker上下文中，所以必须setup。
		--  而builtin会自动启动Picker，所以可以用vim.keymap.set
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
