return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	cmd = { "NvimTreeOpen" },
	config = function()
		require("utils.str")
		-- Nvim-tree Custom Keymap
		local api = require("nvim-tree.api")
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		vim.keymap.set(
			"n",
			"<C-v>",
			api.node.open.vertical,
			opts("Open: Vertical Split"),
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<C-x>",
			api.node.open.horizontal,
			opts("Open: Horizontal Split"),
			{ noremap = true, silent = true }
		)

		-- local api = require("nvim-tree.api")
		-- local function opts(desc)
		-- 	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		-- end
		-- vim.keymap.set("n", "<c-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		-- vim.keymap.set("n", "<c-y>", api.node.open.vertical, opts("Open: Vertical Split"))

		-- Custom Decorator
		---@class MyDecorator : UserDecorator
		---@field enabled boolean
		---@field highlight_range string
		---@field icon_placement string
		local MyDecorator = require("nvim-tree.api").decorator.UserDecorator:extend()

		function MyDecorator:new()
			self.enabled = true
			self.highlight_range = "all" -- or "all", "icon", "none"
			self.icon_placement = "after"
			self.my_icon_node = { str = ">", hl = { "DevIconNushell" } }
		end

    -- TODO: Optimize the search algorithms
    -- 1. Do not query any nodes when in NvimTree_*
    -- 2. Do not query more nodes when we find the only highlight file we need
    --
		-- Custom Highlight
		---@param node any
		---@return string|nil
		function MyDecorator:highlight_group(node)
			local target_file
			local current_file = vim.api.nvim_buf_get_name(0)
			if current_file:find("NvimTree_") then
				target_file = vim.api.nvim_buf_get_name(vim.g.last_buf)
			else
				target_file = current_file
			end

			if node.absolute_path == target_file then
				return "Substitute" -- highlight format
			else
				return nil
			end

			-- More than one highlight
			-- local target_files = {
			-- 	current_file,
			-- }
			-- for _, target_path in ipairs(target_files) do
			-- 	if node.absolute_path == target_path then
			-- 		return "Substitute" -- highlight format
			-- 	end
			-- end
		end

		function MyDecorator:icon_node(node)
			local target_file
			local current_file = vim.api.nvim_buf_get_name(0)
			if current_file:find("NvimTree_") then
				target_file = vim.api.nvim_buf_get_name(vim.g.last_buf)
			else
				target_file = current_file
			end

			if node.absolute_path == target_file then
				return self.my_icon_node
			else
				return nil
			end

			-- local target_files = {
			-- 	current_file,
			-- }
			-- for _, target_path in ipairs(target_files) do
			-- 	if node.absolute_path == target_path then
			-- 		return self.my_icon_node
			-- 	end
			-- end
			-- return nil
		end

		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,

			respect_buf_cwd = false,
			sync_root_with_cwd = false,

			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			update_focused_file = {
				enable = true, -- auto highlight when open files
				update_cwd = false, -- change root dir when open files
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				highlight_hidden = "name",
				special_files = {
					"Cargo.toml",
					-- "Makefile",
					-- "Makefile.in",
					-- "Makefile.am",
					-- "configure",
					-- "configure.in",
					-- "configure.ac",
					-- "config.h",
					-- "config.h.in",
					"README.md",
					"readme.md",
				},
				root_folder_label = function(path)
					return LimitStr(vim.fn.fnamemodify(path, ":p"), 20)
				end,
				icons = {
					show = {
						git = false,
						folder = true,
						file = true,
						folder_arrow = true,
					},
				},
				decorators = {
					"Git",
					"Open",
					"Hidden",
					"Modified",
					"Copied",
					"Cut",
					MyDecorator,
				},
				-- "Bookmark",
				-- "Diagnostics",
			},
			filters = {
				dotfiles = false, -- show hidden files
				git_ignored = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
				},
			},
			git = {
				enable = true,
				timeout = 2000, -- (in ms)
			},
		})
	end,
}
