-- Copy
if vim.g.copy_to_system == true then
  vim.keymap.set("n", "y", '"+y')
  vim.keymap.set("n", "Y", '"+Y')
  vim.keymap.set("v", "y", '"+y')
  vim.keymap.set("v", "Y", '"+Y')
end

-- LspSaga
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

-- NvimTree
vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeOpen<CR>", { noremap = true, silent = true })

-- Draft Paper
vim.keymap.set("n", "<leader>dp", function()
  vim.cmd.pedit(vim.fn.stdpath("cache") .. "/draftpaper.txt")
end, { noremap = true, silent = true })

-- Lua Temp Script
vim.keymap.set("n", "<leader>sr", function()
  vim.cmd.pedit(vim.fn.stdpath("cache") .. "/_temp_script.lua")
end, { noremap = true, silent = true })

-- Lua Runner
vim.keymap.set("n", "<leader>lu", function()
  vim.system({
    "luajit",
    vim.fn.expand("%:p"),
  }, { text = true }, function(obj)
    if obj.code == 0 then
      vim.notify(obj.stdout:gsub("^%s*(.-)%s*$", "%1"), vim.log.levels.INFO) -- %1 is the first pattern in (.-)
    else
      vim.notify("[Lua Runner Error]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
    end
  end)
end, { noremap = true, silent = true })

-- This can fix vim-floaterm
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")

-- Assembly Explorer
vim.keymap.set("n", "<leader>as", "<cmd>AssemblyExplorer<CR>")
