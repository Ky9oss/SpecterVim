local toml = require("toml")

--- Read config toml
--- @param config_file string
--- @return table | nil
function read_config(config_file)

	local stat = vim.uv.fs_stat(config_file)
	if not stat then -- file exists
		vim.notify("File not found: " .. config_file, vim.log.levels.ERROR)
    return nil
  end

	-- Decode from file
	local succeeded, content = pcall(toml.decodeFromFile, config_file)

	if succeeded then
		-- print(vim.inspect(content))
    return content
	else
		vim.notify("Failed to read config file: " .. config_file .. "\n" .. vim.inspect(content), vim.log.levels.ERROR)
    return nil
	end
end

