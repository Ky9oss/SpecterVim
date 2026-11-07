-- Local Options
local DEFAULT_OPTIONS = {
	cursorline = {
		enable = true
	},
}

local a = vim.api
local wo = vim.wo
local au = a.nvim_create_autocmd
local ag = a.nvim_create_augroup

-- Autocommand
local group_id = ag("cursorline", { clear = true })
if DEFAULT_OPTIONS.cursorline.enable then
	au("WinEnter", {
		group = group_id,
		callback = function()
			wo.cursorline = true
		end,
	})
	au("WinLeave", {
		group = group_id,
		callback = function()
			wo.cursorline = false
		end,
	})

	-- Ky9: This slows down responses speed in cursorline.
	-- au({ "CursorMoved", "CursorMovedI" }, {
	--   group = group_id,
	--   callback = function()
	--     if is_disabled_buffer() then
	--       timer:stop()
	--       wo.cursorline = false
	--       return
	--     end
	--     if DEFAULT_OPTIONS.cursorline.number then
	--       wo.cursorline = false
	--     else
	--       wo.cursorlineopt = "number"
	--     end
	--     timer:start(
	--       DEFAULT_OPTIONS.cursorline.timeout,
	--       0,
	--       vim.schedule_wrap(function()
	--         if DEFAULT_OPTIONS.cursorline.number then
	--           wo.cursorline = true
	--         else
	--           wo.cursorlineopt = "both"
	--         end
	--       end)
	--     )
	--   end,
	-- })
end
