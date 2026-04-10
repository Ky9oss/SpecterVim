-- Copy
if vim.g.copy_to_system == true then
	vim.keymap.set("n", "gy", '"+y')
	vim.keymap.set("n", "gY", '"+Y')
	vim.keymap.set("v", "gy", '"+y')
	vim.keymap.set("v", "gY", '"+Y')
	vim.keymap.set("n", "gp", '"+p')
	vim.keymap.set("n", "gP", '"+P')
end

-- Hover action: Use signature_help in csharp with roslyn; Otherwise use LspSaga's hover
vim.keymap.set("n", "K", function()
	local filetype = vim.bo[vim.api.nvim_get_current_buf()].filetype
	if filetype == "cs" then
		local mark = vim.api.nvim_win_get_cursor(0)

		vim.cmd.normal({ bang = true, args = { 'vf)"cy' } })
		local copied = vim.fn.getreg("c")
		local _, count = copied:gsub("%(", "")

		if count > 0 then
			local cmd = "f)"
			if count > 1 then
				for _ = 1, count - 1 do
					cmd = cmd .. ";"
				end
			end
			vim.cmd.normal({ bang = true, args = { cmd } })
			vim.lsp.buf.signature_help()
		end

		vim.fn.setreg("c", {}) -- clean "c
		vim.api.nvim_win_set_cursor(0, mark)
	else
		vim.cmd("Lspsaga hover_doc")
	end
end, { noremap = true, silent = true })

-- NvimTree
vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeOpen<CR>", { noremap = true, silent = true })

-- Obsession
vim.keymap.set("n", "<leader>ql", "<cmd>source Session.vim<CR>", { noremap = true, silent = true })

-- Close all vim.notify
vim.keymap.set("n", "<leader>ca", "<cmd>NoiceDismiss<CR>", { noremap = true, silent = true })

-- Search current word
vim.keymap.set("n", "<leader>cw", "<cmd>SearchCurrentWord<CR>", { noremap = true, silent = true })

-- Draft Paper
vim.keymap.set("n", "<leader>dp", function()
	vim.cmd.pedit(vim.fn.stdpath("cache") .. "/draftpaper.txt")
end, { noremap = true, silent = true })

-- Lua Temp Script
vim.keymap.set("n", "<leader>sr", function()
	local filetype = vim.bo[vim.api.nvim_get_current_buf()].filetype
	if filetype == "lua" then
		-- vim.cmd.pedit(vim.fn.stdpath("cache") .. "/_temp_script.lua")
		vim.cmd("TempScript lua")
	elseif filetype == "sh" then
		-- vim.cmd.pedit(vim.fn.stdpath("cache") .. "/_temp_script.sh")
		vim.cmd("TempScript sh")
	end
end, { noremap = true, silent = true })

-- Lua Runner
vim.keymap.set("n", "<leader>lu", function()
	vim.system({
		"luajit",
		vim.fn.expand("%:p"),
	}, { text = true }, function(obj)
		if obj.code == 0 then
			vim.notify(obj.stdout:gsub("^%s*(.-)%s*$", "%1"), vim.log.levels.INFO) -- %1 is the first pattern in (.-)
		else
			vim.notify("[Lua Runner Error]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
		end
	end)
end, { noremap = true, silent = true })

-- This can fix vim-floaterm
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")

-- Assembly Explorer
vim.keymap.set("n", "<leader>as", "<cmd>AssemblyExplorer<CR>")

-- Nvim-tree Custom Keymap
local api = require("nvim-tree.api")
local function opts(desc)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end
vim.keymap.set("n", "<C-y>", api.node.open.vertical, opts("Open: Vertical Split"))
vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))

-- Open quickfix for ctags lists
--- @param tags table
function QuickfixCtags(tags)
	-- Tag:
	--    cmd = "",
	--    filename = "",
	--    kind = "u",
	--    name = "games",
	--    static = 0
	--    .....
	local fields_display = {}
	local exclude = {
		["cmd"] = true,
		["static"] = true,
	}

	-- Get all fields displayed in quickfix
	for field, _ in pairs(tags[1]) do
		if not exclude[field] then
			local title = field:sub(1, 1):upper() .. field:sub(2, -1)
			table.insert(fields_display, { field = field, max_length = #title, title = title })
		end
	end

	-- sort fields
	for i, v in ipairs(fields_display) do
		if v.field == "name" then
			table.remove(fields_display, i)
			table.insert(fields_display, 1, v)
		elseif v.field == "filename" then
			table.remove(fields_display, i)
			table.insert(fields_display, v)
		end
	end
	for i, v in ipairs(fields_display) do
		if v.field == "kind" then
			table.remove(fields_display, i)
			table.insert(fields_display, 2, v)
			break
		end
	end

	-- Calculate max length of every fields to be displayed
	for _, tag in ipairs(tags) do
		tag.kind = tag.kind and tag.kind or ""
		tag.cmd = tag.cmd and tag.cmd or ""
		for _, f in ipairs(fields_display) do
			f.max_length = math.max(f.max_length, #tag[f.field])
		end
	end

	-- Concatenate titles for top row in quickfix
	local top_row = ""
	for _, f in ipairs(fields_display) do
		f.title = f.title == "Name" and "Tag" or f.title
		f.title = f.title == "Filename" and "File" or f.title
		top_row = top_row .. string.format("%-" .. f.max_length .. "s | ", f.title)
	end

	local items = {}
	table.insert(items, {
		module = "ctags",
		text = top_row,
	})

	-- Concatenate every rows in quickfix
	for _, tag in ipairs(tags) do
		local tag_row = ""
		for _, f in ipairs(fields_display) do
			tag_row = tag_row .. string.format("%-" .. f.max_length .. "s | ", tag[f.field])
		end

		table.insert(items, {
			filename = tag.filename,
			module = "ctags",
			-- lnum = 1,
			text = tag_row,
			user_data = {
				cmd = tag.cmd,
			},
		})
	end

	vim.fn.setqflist({}, " ", { title = "Tags", items = items })
	vim.cmd("copen")
end

vim.keymap.set("n", "g]", function()
	-- local tags = vim.fn.taglist("^" .. vim.fn.expand("<cword>") .. "$")
	local tags = vim.fn.taglist(vim.fn.expand("<cword>"))
	if #tags == 0 then
		vim.notify("Tag not found")
	else
		QuickfixCtags(tags)
	end
end, { desc = "Open quickfix for ctags lists in normal mode" })

vim.keymap.set("v", "g]", function()
	vim.cmd('normal! "vy')
	local tags = vim.fn.taglist(vim.fn.getreg("v"))
	if #tags == 0 then
		vim.notify("Tag not found")
	else
		QuickfixCtags(tags)
	end
end, { desc = "Open quickfix for ctags lists in visual mode" })

-- vim.keymap.set("n", "gO", function()
--   vim.cmd("set splitright | vert lopen | vertical resize 50")
-- end, { noremap = true, silent = true, desc = "Vim-help files navigation" })
