local DEFAULT_OPTIONS = {
	disable_buftypes = {},
	disable_filetypes = { "NvimTree", "tagbar" },
	cursorword = {
		enable = true,
		min_length = 2,
		hl = { underline = true },
	},
}

local w = vim.w
local a = vim.api
local fn = vim.fn
local hl = a.nvim_set_hl
local au = a.nvim_create_autocmd
local ag = a.nvim_create_augroup

local function clear_cursorword_match()
	if w.cursorword_id then
		fn.matchdelete(w.cursorword_id)
		w.cursorword_id = nil
	end
end

local function list_contains(list, target)
	for _, value in ipairs(list) do
		if value == target then
			return true
		end
	end
	return false
end

local function is_disabled_buffer()
	return list_contains(DEFAULT_OPTIONS.disable_filetypes, vim.bo.filetype)
		or list_contains(DEFAULT_OPTIONS.disable_buftypes, vim.bo.buftype)
end

local function matchadd()
	if is_disabled_buffer() then
		w.cursorword = nil
		clear_cursorword_match()
		return
	end

	local column = a.nvim_win_get_cursor(0)[2]
	local line = a.nvim_get_current_line()
	local cursorword = fn.matchstr(line:sub(1, column + 1), [[\k*$]])
		.. fn.matchstr(line:sub(column + 1), [[^\k*]]):sub(2)

	if cursorword == w.cursorword then
		return
	end
	w.cursorword = cursorword
	clear_cursorword_match()
	if
		cursorword == ""
		or #cursorword > 100
		or #cursorword < DEFAULT_OPTIONS.cursorword.min_length
		or string.find(cursorword, "[\192-\255]+") ~= nil
	then
		return
	end
	local pattern = [[\V\<]] .. fn.escape(cursorword, [[\]]) .. [[\>]]
	w.cursorword_id = fn.matchadd("CursorWord", pattern, -1)
end

local group_id = ag("cursorword", { clear = true })

if DEFAULT_OPTIONS.cursorword.enable then
	au("VimEnter", {
		group = group_id,
		callback = function()
			hl(0, "CursorWord", DEFAULT_OPTIONS.cursorword.hl)
			matchadd()
		end,
	})
	au({ "CursorMoved", "CursorMovedI" }, {
		group = group_id,
		callback = function()
			matchadd()
		end,
	})
end
