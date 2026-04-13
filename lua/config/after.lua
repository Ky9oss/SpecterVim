local project = require("project_nvim.project")
local project_root_path = project.get_project_root()

if project_root_path then
  local doc_tags = vim.fn.stdpath("config") .. "/doc/**/tags"
  local man_tags = vim.fn.stdpath("config") .. "/doc/man/**/tags"
	vim.opt.tags = { project_root_path .. "/tagfiles/**/tags", doc_tags, man_tags }
else
	vim.opt.tags = "tagfiles/**/tags"
end
