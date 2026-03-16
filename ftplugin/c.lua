require("utils.shell")

local project = require("project_nvim.project")

vim.keymap.set("n", "<leader>mm", function()
	local project_root = project.get_project_root()

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

				return
			end
		end
	end

	if vim.fn.has("win32") ~= 1 then -- Linux
		vim.bo.makeprg = "gcc-15 -Wall -O2 -o %< %"
	end

	vim.cmd("Make")
end, { buffer = true, desc = "Make (C)" })

vim.keymap.set("n", "<leader>mt", function()
	local project_root = project.get_project_root()
	local filename = vim.api.nvim_buf_get_name(0):match("^(%S+)%.c$") -- This is a absolute path
	local scriptpath = vim.fn.stdpath("config") .. "/lib/runc-tmux.sh"
  local params = { filename }

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
