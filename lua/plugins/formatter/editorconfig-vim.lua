local create_file = function(filename, dcontent)
  local project = require("project_nvim.project")
  local content = dcontent:gsub("^%s+", ""):gsub("\n%s+", "\n")
  local project_root = project.get_project_root()
  if not project_root then
    return
  end

  local filepath = project_root .. "/" .. filename
  local is_exists = vim.fn.findfile(filepath, ".;") ~= ""

  if not is_exists then
    if vim.fn.filereadable(filepath) == 0 then
      local f = io.open(filepath, "w")
      if f then
        f:write(content)
        f:close()
        vim.notify(filename .. " created automatically", "info")
      else
        vim.notify("Failed to create " .. filename, "error")
      end
    end
  end
end

return {
  "editorconfig/editorconfig-vim",
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype

        local default_editorconfig = [[
            root = true

            [*]
            indent_style = space
            indent_size = 4
            tab_width = 4
            end_of_line = crlf
            insert_final_newline = true
        ]]

        local default_gitignore = [[
            *.log
        ]]

        if ft == "asm" then
          local default_toml = [[

[default_config]
# Configure documentation available for features like hover and completions
assembler = "fasm"
instruction_set = "x86/x86-64"

[opts]
# The `compiler` field is the name of a compiler/assembler on your path
# (or the absolute path to the file) that is used to build your source files
# This program will be used to generate diagnostics
compiler = "gcc" # need "cc" as the first argument in `compile_flags.txt`
diagnostics = true
default_diagnostics = true

        ]]

          create_file(".asm-lsp.toml", default_toml)
        end

        create_file(".editorconfig", default_editorconfig)
        create_file(".gitignore", default_gitignore)
      end,
    })
  end,
}
