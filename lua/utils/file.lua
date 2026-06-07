require("utils.debug")

--- Find file by traversing upward through parent directories from current_path.
---
--- @param files table
---   Search by table order in files.
--- @param current_path string | nil
--- @param project_path string | nil
--- @return string | nil
---   Return absolute path of found file
function find_files_upward(files, current_path, project_path)
	local pp
	if project_path then
		pp = project_path .. "/../"
	else
		pp = nil
	end

  local cp
  if current_path then
    cp = current_path
  else
    cp = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  end

	local found = vim.fs.find(files, {
		limit = 1, -- math.huge
		upward = true,
		type = "file",
		path = cp,
		stop = pp,
	})

	if #found == 1 then
    return found[1]
  elseif #found > 1 then 
    log_error("Found file should limit to 1")
    return nil
  else
    return nil
  end
end

function test()
  local files = { "config.lua", "buffer.lua" }
  print(find_files_upward(files))
end
