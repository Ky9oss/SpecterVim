vim.keymap.set("n", "<leader>mm", function()
  vim.cmd("%lua")
end, { buffer = true, desc = "Run Lua in Neovim" })

vim.keymap.set("n", "<leader>mv", function()
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
