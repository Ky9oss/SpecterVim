--- Print debug informations
--- @param message string
--- @param level number log level
--- @return nil
function debug_print(message, level)
	--[[ vim.log.levels = {
    DEBUG = 1,
    ERROR = 4,
    INFO = 2,
    OFF = 5,
    TRACE = 0,
    WARN = 3,
  } ]]
	info = debug.getinfo(2, "Sl")
	vim.notify(string.format("^_^ %s:%d\nMessage: %s", info.source, info.currentline, message), level)
end

-- vim.api.nvim_create_augroup("DEBUG", { clear = true })
-- vim.api.nvim_create_user_command("SpecterDebug", function(opts)
-- 	vim.api.nvim_create_autocmd({ "CursorHold" }, {
-- 		group = "DEBUG",
-- 		callback = function(args)
-- 			print("DEBUG: Buf Event:", args.event, args.buf)
-- 		end,
-- 	})
-- end, { desc = "Get events", nargs = "?" })

-- Hook paste for Shada
-- vim.paste = (function(overridden)
-- 	return function(lines, phase)
-- 		print("SpecterVim: hook paste")
-- 		vim.cmd("rshada")
-- 		return overridden(lines, phase)
-- 	end
-- end)(vim.paste)
