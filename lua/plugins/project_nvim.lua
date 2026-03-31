return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern", "lsp" },
      -- cmd: `touch .r00t_here` to mark a project
      patterns = { ".git", ".gitignore", ".r00t_here", "package.json", ".editorconfig", "Cargo.toml", "*.sln", "CMakeLists.txt" },
    })
  end,
}
