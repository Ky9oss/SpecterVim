-- Copy
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("v", "y", '"+y')
vim.keymap.set("v", "Y", '"+Y')

-- LspSaga
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

-- LspSaga
vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeOpen<CR>", { noremap = true, silent = true })
