-- Exec bash scripts
--
--- @param scriptpath string
--- @param params table | nil
--- @param cwd string | nil
function exec_bash_scripts(scriptpath, params, cwd)
	local stat = vim.uv.fs_stat(scriptpath)
	if stat then -- file exists
		local run_command = scriptpath
		if params then
			for _, param in ipairs(params) do
				run_command = run_command .. " " .. param
			end
		end

		if stat.mode % 128 < 64 then -- mode is 12 bits int. owner: bits 8-6(rwx). x = 2^6 = 64
			vim.system(vim.split("chmod +x " .. scriptpath, "%s+"), { text = true, cwd = cwd }, function(obj)
				if obj.code == 0 then
					vim.system(vim.split(run_command, "%s+"), { text = true, cwd = cwd })
				end
			end)
		else
			vim.system(vim.split(run_command, "%s+"), { text = true, cwd = cwd })
		end
	end
end
