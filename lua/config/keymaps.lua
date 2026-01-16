-- Copy
if vim.fn.has("win32") == 1 then
  vim.keymap.set("n", "y", '"+y')
  vim.keymap.set("n", "Y", '"+Y')
  vim.keymap.set("v", "y", '"+y')
  vim.keymap.set("v", "Y", '"+Y')
end

-- Git Push
vim.api.nvim_create_user_command("GitPush", function(opts)
  if opts.args == nil then
    vim.notify("GitPush need 1 argument at least.", vim.log.levels.ERROR)
  else
    local project = require("project_nvim.project")
    local project_root_path = project.get_project_root()

    if project_root_path == nil then
      vim.notify("Can't find the project's root path", vim.log.levels.ERROR)
    else
      local result = vim.system({
        "cmd",
        "/c",
        "cd",
        project_root_path,
        "&&",
        "git",
        "add",
        ".",
        "&&",
        "git",
        "commit",
        "-m",
        opts.args,
        "&&",
        "git",
        "push",
        "-u",
        "origin",
        "main",
      }, { text = true }, function(obj)
        if obj.code == 0 then
          vim.notify("STDOUT:" .. obj.stdout)
        else
          vim.notify("[" .. obj.code .. "] " .. "STDERR: " .. obj.stderr)
        end
      end)
    end
  end
end, { desc = "Push codes to 'origin' in main branch.", nargs = 1 })

-- LspSaga
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

-- LspSaga
vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeOpen<CR>", { noremap = true, silent = true })
