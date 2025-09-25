return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".editorconfig" },
    }

  end
  -- config = function()
  --   require("project_nvim").setup({
  --     -- statusline
  --     local project = require("project_nvim.project") 
  --     local project_root_path = project.get_project_root() 
  --     local project_name = ""
  --
  --     if project_root_path == nil then
  --       project_root_path = ""
  --     else
  --       project_name = "[ " .. project_root_path:match("([^/\\]+)$"):upper() .. " ]"
  --     end
  --
  --     vim.g.lightline = {
  --       active = {
  --         left = {
  --           { "mode", "paste" },
  --           { "readonly", "project_name", "filename", "modified" },
  --         },
  --         right = {
  --           { "lineinfo" },
  --           { "percent" },
  --           { "project", "fileformat", "fileencoding", "filetype"}
  --
  --         }
  --       },
  --       component = {
  --         project = project_root_path,
  --         project_name = project_name,
  --       },
  --       enable = {
  --         tabline = 0,
  --       },
  --     }
  --   })
  --
  -- end
}
