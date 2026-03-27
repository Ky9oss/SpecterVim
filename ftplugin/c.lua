require("utils.shell")

local project = require("project_nvim.project")
local project_root = project.get_project_root()

vim.keymap.set("n", "<leader>mm", function()
	if project_root then
		for name, type in vim.fs.dir(project_root) do
			if name == "CMakeLists.txt" and type == "file" then -- Cmake
				if vim.fn.has("win32") ~= 1 then -- Linux
					local scriptpath = vim.fn.stdpath("config") .. "/lib/cmake.sh"
					local stat = vim.uv.fs_stat(scriptpath)
					if stat then -- file exists
						if stat.mode % 128 >= 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
							vim.bo.makeprg = "cd " .. project_root .. " && " .. scriptpath
						else
							vim.bo.makeprg = "cd "
								.. project_root
								.. " && chmod +x "
								.. scriptpath
								.. " && "
								.. scriptpath
						end
					end
				end

				vim.cmd("Make")
				vim.cmd("copen 10 | wincmd p")

				return
			end
		end
	end

	if vim.fn.has("win32") ~= 1 then -- Linux
		-- vim.bo.makeprg = "gcc-15 -Wall -O2 -o %< %"
		local scriptpath = vim.fn.stdpath("config") .. "/lib/gcc-compile.sh"
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
					.. " "
					.. filepath
					.. " "
					.. executable_path
			else
				vim.bo.makeprg = "cd "
					.. project_root
					.. " && chmod +x "
					.. scriptpath
					.. " && "
					.. scriptpath
					.. " "
					.. filepath
					.. " "
					.. executable_path
			end
		end
	end

  -- vim.notify("Current errorformat: " .. vim.bo.errorformat)
  vim.cmd("compiler gcc")
  -- vim.notify("Current errorformat: " .. vim.bo.errorformat)
	vim.cmd("copen 10 | wincmd p")
  -- TODO: A controllable compile command instaed of Make
	vim.cmd("Make")

	-- vim.cmd("make | copen 10 | wincmd p")
end, { buffer = true, desc = "Make (C)" })

-- Run executable binary by runscript-tmux.sh
-- If we are in a Project. Then run executable binary in project_root/bin. Else run exectubale binary in current dir.
vim.keymap.set("n", "<leader>mt", function()
	local executable_path
	if project_root then
		executable_path = project_root .. "/bin/" .. vim.api.nvim_buf_get_name(0):match(".*/(%S+)%.c$")
	else
		executable_path = vim.api.nvim_buf_get_name(0):match("^(%S+)%.c$") -- This is a absolute path
	end
	local scriptpath = vim.fn.stdpath("config") .. "/lib/runscript-tmux.sh"
	local params = { executable_path }

	if project_root then
		for name, type in vim.fs.dir(project_root) do
			if name == "CMakeLists.txt" and type == "file" then -- Cmake
				if vim.fn.has("win32") ~= 1 then -- Linux
					-- TODO Cmake runner
					return
				end
			end
		end

		-- vim.notify(
		-- 	[=[<leader>mt: This file must in a project.
		--   Use `git init` in your project's root path to initialize a project]=],
		-- 	vim.log.levels.ERROR
		-- )
	end

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
