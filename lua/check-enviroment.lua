vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    local editorconfig_exists = vim.fn.findfile(".editorconfig", ".;") ~= ""
    if not editorconfig_exists then
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
    end
  end
})

local project = require("project_nvim.project")

-- 创建默认 EditorConfig 内容
local default_editorconfig = [[
root = true

[*]
indent_style = space
indent_size = 4
tab_width = 4
end_of_line = lf
insert_final_newline = true

[*.lua]
indent_size = 2
tab_width = 2
max_line_length = 120

[{Makefile,**/Makefile,runtime/doc/*.txt,*.md}]
indent_style = tab
indent_size = 4
]]

-- 当 project.nvim 确定项目根目录后触发
vim.api.nvim_create_autocmd("User", {
  pattern = "ProjectChanged",
  callback = function()
    local project_root = project.get_project_root()
    if not project_root then return end

    local editorconfig_path = project_root .. "/.editorconfig"

    -- 如果没有 .editorconfig 就创建
    if vim.fn.filereadable(editorconfig_path) == 0 then
      -- 写入默认内容
      local f = io.open(editorconfig_path, "w")
      if f then
        f:write(default_editorconfig)
        f:close()
        vim.notify(".editorconfig 自动创建完成 🎉", vim.log.levels.INFO)
      else
        vim.notify("无法创建 .editorconfig", vim.log.levels.ERROR)
      end
    end
  end,
})
