-- dap
vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>DapStepInto<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>u", "<cmd>DapStepOut<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>DapStepOver<CR>", { noremap = true, silent = true })


-- lspsaga
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     -- 给所有 LSP buffer 强制设置
--     vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {
--       buffer = ev.buf,
--       noremap = true,
--       silent = true,
--     })
--   end,
-- })

-- Copy
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("v", "y", '"+y')
vim.keymap.set("v", "Y", '"+Y')


-- Floaterm
vim.keymap.set("n", "<leader>nsh", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2<CR>")

-- Bufferline
vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true })
vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true })
vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true })
vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true })
vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true })
vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true })
vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true })
vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true })
vim.keymap.set("n", "BN", ":BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "BP", ":BufferLineMovePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>cr", ":BufferLineCloseRight<CR>", { silent = true })
vim.keymap.set("n", "<leader>cl", ":BufferLineCloseLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-n>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<C-p>", ":BufferLineCyclePrev<CR>", { silent = true })


-- Tagbar
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>")
