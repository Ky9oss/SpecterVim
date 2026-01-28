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
vim.keymap.set("n", "<leader>dp", function ()
  vim.cmd.pedit(vim.fn.stdpath('cache') .. '/draftpaper.txt')
end, { noremap = true, silent = true })

-- This can fix vim-floaterm
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")

-- Assembly Explorer
vim.keymap.set("n", "<leader>as", "<cmd>AssemblyExplorer<CR>")
