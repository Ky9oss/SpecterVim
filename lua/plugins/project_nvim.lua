return {
	"ahmedkhalf/project.nvim",
  lazy=false,
	config = function()
		require("project_nvim").setup({
			detection_methods = { "pattern", "lsp" },
			-- cmd: `touch .r00t_here` to mark a project
			patterns = {
				".r00t_here",
				".git",
				"package.json",
				"Cargo.toml",
				"*.sln",
			},
		})
	end,
}
