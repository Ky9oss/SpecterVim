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

--- Execute bash command
---
--- @param cmd string
--- @param cwd string | nil
--- @param on_result nil | function(bool)
function exec_bash_command(cmd, cwd, on_result)
	if vim.fn.has("win32") == 1 then
		vim.system(vim.split(cmd, "%s+"), { text = true, cwd = cwd }, function(obj)
			if obj.code == 0 then
				if obj.stdout ~= nil and obj.stdout:gsub("^%s*(.-)%s*$", "%1") ~= "" then
					vim.notify("[Command]\n" .. cmd .. "\n[STDOUT]\n" .. obj.stdout)
				end
				if on_result then
					on_result(true)
				end
			else
				vim.notify("[Command]\n" .. cmd .. "\n[STDERR(code:" .. obj.code .. ")]" .. obj.stderr, vim.log.levels.ERROR)
				if on_result then
					on_result(false)
				end
			end
		end)

	else
		vim.system({ "bash", "-c", cmd }, { text = true, cwd = cwd }, function(obj)
			if obj.code == 0 then
				if obj.stdout ~= nil and obj.stdout:gsub("^%s*(.-)%s*$", "%1") ~= "" then
					vim.notify("[Command]\n" .. cmd .. "\n[STDOUT]\n" .. obj.stdout)
				end
				if on_result then
					on_result(true)
				end
			else
				vim.notify("[Command]\n" .. cmd .. "\n[STDERR(code:" .. obj.code .. ")]" .. obj.stderr, vim.log.levels.ERROR)
				if on_result then
					on_result(false)
				end
			end
		end)
	end
end
