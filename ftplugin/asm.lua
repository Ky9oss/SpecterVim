require("utils.shell")

local project = require("project_nvim.project")
local project_root = project.get_project_root()
local exe_abpath = nil

vim.keymap.set("n", "<leader>mm", function()
	local builder = "fasm"
	local current_window_width = vim.api.nvim_win_get_width(0)
	local current_dir = vim.api.nvim_buf_get_name(0):match("^(%S+)/[^%/]*$") -- return string | ""
	local target_file = vim.api.nvim_buf_get_name(0)
	local output_name = vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.asm$")
	local scriptpath = vim.fn.stdpath("config") .. "/scripts/compile/main.sh"
	local stat = vim.uv.fs_stat(scriptpath)
	local output_dir = "./"

	if project_root then
		output_dir = project_root .. "/bin/"
	end

	if stat then -- file exists
		if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
			vim.cmd("cd " .. current_dir)
			vim.bo.makeprg = scriptpath
				.. " "
				.. builder
				.. " "
				.. target_file
				.. " "
				.. current_window_width
				.. " "
				.. output_dir
				.. "/"
				.. output_name
			exe_abpath = output_dir .. output_name
		else
			vim.notify("Permission Denied:" .. scriptpath .. " is not executable", vim.log.levels.ERROR)
		end
	end

	vim.cmd("make | belowright copen 10 | wincmd p ")
end, { buffer = true, desc = "Compile (fasm)" })

vim.keymap.set("n", "<leader>mt", function()
	if not exe_abpath then
		if project_root then
			exe_abpath = project_root .. "/bin/" .. vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.asm$")
		else
			exe_abpath = vim.api.nvim_buf_get_name(0):match("^(%S+)%.asm$")
		end
	end

	local scriptpath = vim.fn.stdpath("config") .. "/scripts/loader/tmux.sh"
	local params = { exe_abpath }

	exec_bash_scripts(scriptpath, params)
end, { buffer = true, desc = "Run Asm Program with Tmux" })
