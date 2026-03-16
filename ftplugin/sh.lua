require("utils.shell")

-- A better choice than <leader>mm
vim.keymap.set("n", "<leader>mt", function()
	if vim.fn.has("win32") ~= 1 then -- Linux
		local scriptpath = vim.fn.stdpath("config") .. "/lib/runscript-tmux.sh"
		local filename = vim.api.nvim_buf_get_name(0)
		local params = { filename }
		exec_bash_scripts(scriptpath, params)
	end
end, { buffer = true, desc = "Run Bash Scripts with Tmux" })

vim.keymap.set("n", "<leader>mm", function()
	if vim.fn.has("win32") ~= 1 then -- Linux
		local filename = vim.api.nvim_buf_get_name(0)
		local stat = vim.uv.fs_stat(filename)

		if stat then -- file exists
			if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
				vim.bo.makeprg = filename
			else
				vim.bo.makeprg = "chmod +x " .. filename .. " && " .. filename
			end
		end

		vim.bo.errorformat = "%+G%f:%l:%m,%+G%m"
	end

	vim.cmd("Make")

	-- :make and :copen may be disorder.
	-- I didn't find a simple way to figure out whether the `Make` have done.
	-- So I set set errorformat to match all lines with error.
	-- Perhaps `Tmux + Bash Scripts` has always been a good choice because I like controllable things :-)
	--
	-- local timer = vim.loop.new_timer()
	-- timer:start(
	-- 	0,
	-- 	300, -- 0.3s
	-- 	vim.schedule_wrap(function()
	-- 		vim.cmd("Copen")
	-- 	end)
	-- )
	--
	-- vim.defer_fn(function()
	-- 	timer:stop()
	-- end, 300) -- 0.3s
end, { buffer = true, desc = "Make (Bash)" })
