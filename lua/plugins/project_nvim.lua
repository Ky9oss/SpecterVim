return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "Makefile", "package.json", ".editorconfig", "Cargo.toml", "*.sln", "CMakeLists.txt" },
    })
  end,
}
