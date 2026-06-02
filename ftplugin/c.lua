require("utils.shell")
require("utils.config")

local project = require("project_nvim.project")
local project_root = project.get_project_root()

-- Get builder for c
-- @return string
local function get_builder()
  local builder = "gcc" -- default

  -- Read config
	if project_root then
		local config_file = project_root .. "/specterv.toml"
		local stat = vim.uv.fs_stat(config_file)
		if stat then -- file exists
			content = read_config(config_file)
		end

    if content["edit-compile-run"].builder and content["edit-compile-run"].builder ~= "" then
      builder = content["edit-compile-run"].builder
      return builder
    end
	end

  -- Automatic check
  --
	-- TODO: pwd search Makefile
  return builder
end

vim.keymap.set("n", "<leader>mm", function()
  local content = {}
  local builder = get_builder()
	local current_window_width = vim.api.nvim_win_get_width(0)

	-- Makefile
	-- local current_dir = vim.api.nvim_buf_get_name(0):match("^(%S+)/[^%/]*$") -- return string | ""
	--  -- TODO: pwd search Makefile
	-- if vim.fn.findfile("Makefile", current_dir) ~= "" then
	-- 	-- vim.bo.makeprg = "cd " .. current_dir .. " && make"
	-- 	local target = vim.api.nvim_buf_get_name(0):match("^%S+/([^%/]*).c$") -- return string | ""
	-- 	local scriptpath = vim.fn.stdpath("config") .. "/lib/make-compile.sh"
	-- 	local stat = vim.uv.fs_stat(scriptpath)
	-- 	if stat then -- file exists
	-- 		if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
	-- 			vim.cmd("cd " .. current_dir)
	-- 			vim.bo.makeprg = scriptpath .. " " .. current_window_width .. " " .. target
	-- 		else
	-- 			vim.notify("Permission Denied:" .. scriptpath .. " is not executable", vim.log.levels.ERROR)
	-- 		end
	-- 	end
	-- 	vim.cmd("make | belowright copen 10 | wincmd p | cd ..")
	-- 	return
	-- end

  if builder == "make" then
    local a 
  elseif vim.fn.has("win32") ~= 1 and builder == "gcc" then -- Linux
		local scriptpath = vim.fn.stdpath("config") .. "/scripts/compile/main.sh"
		local filepath = vim.api.nvim_buf_get_name(0)
		local executable_path
		if project_root then
			executable_path = project_root .. "/bin/" .. vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.c$")
		else
			executable_path = vim.api.nvim_buf_get_name(0):match("^(%S+)%.c$") -- This is a absolute path
		end

		local stat = vim.uv.fs_stat(scriptpath)
		if stat then -- file exists
			if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
				vim.bo.makeprg = "cd "
					.. project_root
					.. " && "
					.. scriptpath
					.. " gcc "
					.. filepath
					.. " "
					.. current_window_width
					.. " "
					.. executable_path
			end
		end

		vim.cmd("make | belowright copen 10 | wincmd p")
  else
		vim.notify("The builder \"" .. builder .. "\" is not support on your os", vim.log.levels.ERROR)
	end
end, { buffer = true, desc = "Make (C)" })

-- Run executable binary in tmux
-- If we are in a Project. Then run executable binary in project_root/bin. Else run exectubale binary in current dir.
vim.keymap.set("n", "<leader>mt", function()
	local executable_path
	if project_root then
		executable_path = project_root .. "/bin/" .. vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.c$")
	else
		executable_path = vim.api.nvim_buf_get_name(0):match("^(%S+)%.c$") -- This is a absolute path
	end
	local scriptpath = vim.fn.stdpath("config") .. "/scripts/loader/tmux.sh"
	local params = { executable_path }

	exec_bash_scripts(scriptpath, params)
end, { buffer = true, desc = "Run C Program with Tmux" })

-- Run executable binary and output to vim.notify()
-- If we are in a Project. Then run executable binary in project_root/bin. Else run exectubale binary in current dir.
vim.keymap.set("n", "<leader>mv", function()
	local executable_path
	if project_root then
		executable_path = project_root .. "/bin/" .. vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.c$")
	else
		executable_path = vim.api.nvim_buf_get_name(0):match("^(%S+)%.c$") -- This is a absolute path
	end
	exec_bash_scripts(executable_path)
end, { buffer = true, desc = "Run C Program with Tmux" })
