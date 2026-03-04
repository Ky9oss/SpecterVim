if vim.fn.has("win32") ~= 1 then -- Linux
	vim.bo.makeprg = "gcc -Wall -O2 -o %< %"
end
vim.keymap.set("n", "<leader>mm", ":Make<CR>", { buffer = true, desc = "Make (C)" })
