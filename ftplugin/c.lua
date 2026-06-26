require("utils.shell")
require("utils.config")
require("utils.file")

local project = require("project_nvim.project")
local project_root = project.get_project_root()

-- Get builder for c
-- Priority: custom > autotools > Makefile
--
-- @param use_toml boolean
-- @return string, string | nil
local function get_builder4c(use_toml)
	local builder = "gcc" -- default
	local builder_config_path = nil -- default

	-- Read config
	if not project_root then
		project_root = "."
	end

	if use_toml == true then
		local config_file = project_root .. "/specterv.toml"
		local stat = vim.uv.fs_stat(config_file)
		if stat then -- file exists
			content = read_config(config_file)
		end
		if content["edit-compile-run"].builder and content["edit-compile-run"].builder ~= "" then
			builder = content["edit-compile-run"].builder
		end
		if builder == "make" then
			files = { "Makefile" }
			builder_config_path = find_files_upward(files, vim.fs.dirname(vim.api.nvim_buf_get_name(0)), project_root)
		end
	else
		files = { "Makefile.am", "Makefile" }
		builder_config_path = find_files_upward(files, vim.fs.dirname(vim.api.nvim_buf_get_name(0)), project_root)
		if builder_config_path then
			if builder_config_path:match(files[1]) then
				builder = "autotools"
			elseif builder_config_path:match(files[2]) then
				builder = "make"
			end
		end
	end

	return builder, builder_config_path
end

-- @return string
local function get_command4c()
	local command

	-- Read config
	if project_root then
		local config_file = project_root .. "/specterv.toml"
		local stat = vim.uv.fs_stat(config_file)
		if stat then -- file exists
			content = read_config(config_file)
		end

		if content["edit-compile-run"].custom_command and content["edit-compile-run"].custom_command ~= "" then
			command = content["edit-compile-run"].custom_command
			return command
		end
	end

	return command
end

-- @param builder string
-- @param builder_config_path string
-- @return nil
local function build(builder, builder_config_path)
	local current_window_width = vim.api.nvim_win_get_width(0)
	local scriptpath = vim.fn.stdpath("config") .. "/scripts/compile/main.sh"
	local filepath = vim.api.nvim_buf_get_name(0)

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
		if not builder_config_path then
			builder_config_path = project_root .. "/Makefile"
		end

		local stat = vim.uv.fs_stat(scriptpath)
		if stat then -- file exists
			if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
				vim.bo.makeprg = "cd "
          .. vim.fs.dirname(builder_config_path)
					.. " && "
					.. scriptpath
					.. " "
					.. builder
					.. " "
					.. filepath
					.. " "
					.. current_window_width
					.. " "
					.. builder_config_path
			end
		end

		vim.cmd("make | belowright copen 10 | wincmd p")
	elseif builder == "custom" then -- Or use <leader>mc to compile custom
		local bin_path
		if vim.g.project_root_path then
			bin_path = vim.g.project_root_path .. "/bin"
		else
			bin_path = vim.api.nvim_buf_get_name(0):match("^(%S+)/.+$") -- This is a absolute path
		end

		-- $@ is current file's absolute path
		-- $bin is project's bin folder
		local command = get_command4c()
		if command then
			command = string.gsub(command, "$@", filepath)
			command = string.gsub(command, "$bin", bin_path)

			local stat = vim.uv.fs_stat(scriptpath)
			if stat then -- file exists
				if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
					vim.bo.makeprg =
						-- "cd " .. vim.g.project_root_path
						-- .. " && " ..
						scriptpath .. " " .. builder .. ' "' .. command .. '" ' .. current_window_width
				end
			end

			vim.cmd("make | belowright copen 10 | wincmd p")
		else
			vim.notify("Specterv: `custom` set but `command` not found", vim.log.levels.ERROR)
		end
	elseif vim.fn.has("win32") ~= 1 and builder == "gcc" then -- Linux
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
					.. " "
					.. builder
					.. " "
					.. filepath
					.. " "
					.. current_window_width
					.. " "
					.. executable_path
			end
		end

		vim.cmd("make | belowright copen 10 | wincmd p")
	else
		vim.notify('The builder "' .. builder .. '" is not support on your os', vim.log.levels.ERROR)
	end
end

vim.keymap.set("n", "<leader>mt", function()
	local builder, builder_config_path = get_builder4c(true)
	build(builder, builder_config_path)
end, { buffer = true, desc = "Compilation with specter.toml" })

vim.keymap.set("n", "<leader>mm", function()
	local builder, builder_config_path = get_builder4c(false)
	build(builder, builder_config_path)
end, { buffer = true, desc = "Compilation without specter.toml" })

-- Run executable binary in tmux
-- If we are in a Project. Then run executable binary in project_root/bin. Else run exectubale binary in current dir.
vim.keymap.set("n", "<leader>rt", function()
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
vim.keymap.set("n", "<leader>rv", function()
	local executable_path
	if project_root then
		executable_path = project_root .. "/bin/" .. vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.c$")
	else
		executable_path = vim.api.nvim_buf_get_name(0):match("^(%S+)%.c$") -- This is a absolute path
	end
	exec_bash_scripts(executable_path)
end, { buffer = true, desc = "Run C Program with Tmux" })
