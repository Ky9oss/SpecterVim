return {
  "editorconfig/editorconfig-vim",
  config = function()
    local project = require("project_nvim.project")

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      callback = function()
        local default_editorconfig = ([[
            root = true

            [*]
            indent_style = space
            indent_size = 4
            tab_width = 4
            end_of_line = lf
            insert_final_newline = true
        ]]):gsub("^%s+", ""):gsub("\n%s+", "\n")

        local editorconfig_exists = vim.fn.findfile(".editorconfig", ".;") ~= ""
        if not editorconfig_exists then
          local project_root = project.get_project_root()
          if not project_root then return end

          local editorconfig_path = project_root .. "/.editorconfig"

          if vim.fn.filereadable(editorconfig_path) == 0 then
            vim.notify = require("notify")
            local f = io.open(editorconfig_path, "w")
            if f then
              f:write(default_editorconfig)
              f:close()
              vim.notify(".editorconfig created automatically", "info")
            else
              vim.notify("Failed to create .editorconfig", "error")
            end
          end
        end
      end
    })
  end
}
