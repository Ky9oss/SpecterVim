-- Copy
if vim.g.copy_to_system == true then
  vim.keymap.set("n", "gy", '"+y')
  vim.keymap.set("n", "gY", '"+Y')
  vim.keymap.set("v", "gy", '"+y')
  vim.keymap.set("v", "gY", '"+Y')
  vim.keymap.set("n", "gp", '"+p')
  vim.keymap.set("n", "gP", '"+P')
end

-- Hover action: Use signature_help in csharp with roslyn; Otherwise use LspSaga's hover
vim.keymap.set("n", "K", function()
  local filetype = vim.bo[vim.api.nvim_get_current_buf()].filetype
  if filetype == "cs" then
    local mark = vim.api.nvim_win_get_cursor(0)

    vim.cmd.normal({ bang = true, args = { 'vf)"cy' } })
    local copied = vim.fn.getreg("c")
    local _, count = copied:gsub("%(", "")

    if count > 0 then
      local cmd = "f)"
      if count > 1 then
        for _ = 1, count - 1 do
          cmd = cmd .. ";"
        end
      end
      vim.cmd.normal({ bang = true, args = { cmd } })
      vim.lsp.buf.signature_help()
    end

    vim.fn.setreg('c', {}) -- clean "c
    vim.api.nvim_win_set_cursor(0, mark)
  else
    vim.cmd("Lspsaga hover_doc")
  end
end, { noremap = true, silent = true })

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
