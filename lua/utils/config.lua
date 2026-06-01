local toml = require("toml")

function read_config(config_file)
	-- Decode from file
	local succeeded, content = pcall(toml.decodeFromFile, config_file)

	if succeeded then
    -- TODO: Parser
		print(vim.inspect(content))
	else
		vim.notify("Failed to read config file: " .. config_file .. "\n" .. vim.inspect(content), vim.log.levels.ERROR)
	end
end
