return {
	"ahmedkhalf/project.nvim",
	lazy = false,
	config = function()
		require("project_nvim").setup({
			detection_methods = { "pattern", "lsp" },
			-- cmd: `touch .r00t_here` to mark a project
			patterns = {
				"specterv.toml",
				".r00t_here",
				".git",
				"package.json",
				"Cargo.toml",
				"*.sln",
			},
		})

		local project = require("project_nvim.project")
		vim.g.project_root_path = project.get_project_root()

		if not vim.g.project_root_path then
			vim.notify("Setting vim.g.project_root_path failed", vim.log.levels.WARN)
		end
	end,
}
