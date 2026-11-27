if vim.g.is_windows ~= 1 then
	return {
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- use latest release, remove to use latest commit
		---@module 'obsidian'
		---@type obsidian.config
		opts = {
			legacy_commands = false, -- this will be removed in 4.0.0
			workspaces = {
				{
					name = "personal",
					path = "~/notes/personal",
				},
				{
					name = "work",
					path = "~/notes/work",
				},
			},
		},
	}
else
	return {}
end
