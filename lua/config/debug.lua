vim.api.nvim_create_augroup("DEBUG", { clear = true })
vim.api.nvim_create_user_command("SpecterDebug", function(opts)
	vim.api.nvim_create_autocmd({ "CursorHold" }, {
		group = "DEBUG",
		callback = function(args)
			print("DEBUG: Buf Event:", args.event, args.buf)
		end,
	})
end, { desc = "Get events", nargs = "?" })
