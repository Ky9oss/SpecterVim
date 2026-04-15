local project = require("project_nvim.project")
vim.g.project_root_path = project.get_project_root()

if not vim.g.project_root_path then
  vim.notify("Setting vim.g.project_root_path failed", vim.log.levels.WARN)
end
