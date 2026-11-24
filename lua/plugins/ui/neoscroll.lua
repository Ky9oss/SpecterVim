local DEBUG = false
local ENABLE = true

if ENABLE == false then
  return {}
elseif DEBUG == true then
	return {
		name = "neoscroll.nvim",
		dir = "~/workspace/dev/lua/common-plugins/neoscroll.nvim",
		opts = {
			duration_multiplier = 0.1,
			performance_mode = false,
		},
	}
else
	return {
		"karb94/neoscroll.nvim",
		opts = {
			duration_multiplier = 0.5,
			performance_mode = false,
		},
	}
end
