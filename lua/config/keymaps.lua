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

-- Telescope Keymaps
require("telescope").load_extension("projects")
vim.keymap.set("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects()
end, { noremap = true, silent = true, desc = "Find Projects" })

local ok, builtin = pcall(require, "telescope.builtin")
if ok then
	vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true })
	vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true })
	vim.keymap.set("n", "gi", builtin.lsp_implementations, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
	vim.keymap.set("n", "<leader>faf", "<cmd>Telescope find_files no_ignore=true hidden=true<cr>")
	-- vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
	vim.keymap.set("n", "<leader>fg", function()
		builtin.live_grep({
			additional_args = {
				"-g",
				"!node_modules/**",
				"-g",
				"!autom4te.cache/**",
				"-g",
				"!tags",
				"-g",
				"!doc/**",
			},
		})
	end)
	vim.keymap.set("n", "<leader>fag", function()
		builtin.live_grep({
			additional_args = {
				"--hidden",
				"-u",
				"-g",
				"!node_modules/**",
				"-g",
				"!autom4te.cache/**",
				"-g",
				"!tags",
				"-g",
				"!.git/**",
			},
		})
	end)
	vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
	vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
	-- vim.keymap.set("n", "g]", function()
	-- 	builtin.tags({
	-- 		default_text = vim.fn.expand("<cword>"),
	-- 		ctags_file = nil,
	-- 		-- ctags_file = project_root .. "/tagfiles/**/tags",
	-- 	})
	-- end, { desc = "Telescope: search project tags for word under cursor" })
else
	vim.notify("Telescope load failed.", vim.log.levels.ERROR)
end

-- Use quickfix for ctags
vim.keymap.set("n", "g]", function()
	-- local tags = vim.fn.taglist("^" .. vim.fn.expand("<cword>") .. "$")
	local tags = vim.fn.taglist(vim.fn.expand("<cword>"))

	local max_name = 0
	local max_kind = 0

	for _, tag in ipairs(tags) do
		max_name = math.max(max_name, #tag.name)
		max_kind = math.max(max_kind, #(tag.kind or ""))
	end

	local items = {}
	table.insert(items, {
		module = "ctags",
		-- lnum = 1,
		text = string.format("%-" .. max_name .. "s\t%-" .. max_kind .. "s\t%s", "Tag", "Kind", "File"),
	})
	for _, tag in ipairs(tags) do
		table.insert(items, {
			filename = tag.filename,
			module = "ctags",
			-- lnum = 1,
			text = string.format(
				"%-" .. max_name .. "s\t%-" .. max_kind .. "s\t%s",
				-- "%-50s\t%-" .. max_kind .. "s\t%s",
				tag.name,
				tag.kind or "",
				tag.filename
			),
			user_data = {
				cmd = tag.cmd,
				-- filename = tag.filename,
			},
		})
	end

	vim.fn.setqflist({}, " ", { title = "Tags", items = items })
	vim.cmd("copen")
end, { desc = "A dirty hack to disable noice when use g]" })

-- vim.keymap.set("n", "gO", function()
--   vim.cmd("set splitright | vert lopen | vertical resize 50")
-- end, { noremap = true, silent = true, desc = "Vim-help files navigation" })
