return {
	"rcarriga/nvim-dap-ui",
	lazy = true,
	keys = {
		-- TODO: Resize all dapui-windows because do/dl/dt will disrupt the layout
		{
			"<leader>do",
			function()
				require("dapui").open()
				local winid = GetNvimTreeWinid()
				if winid ~= 0 then
					vim.api.nvim_set_current_win(winid)
					vim.cmd([[
	wincmd L
	vertical resize 30
	wincmd p
	    ]])
					vim.g.nvim_tree_moved = 1
				end
			end,
			desc = "Open Dap UI",
		},
		{
			"<leader>dl",
			function()
				require("dapui").close()
				local winid = GetNvimTreeWinid()
				if winid ~= 0 then
					vim.api.nvim_set_current_win(winid)
					vim.cmd([[
	wincmd H
	vertical resize 30
	wincmd p
	    ]])
					vim.g.nvim_tree_moved = 0
				end
			end,
			desc = "Close Dap UI",
		},
		{
			"<leader>dt",
			function()
				require("dapui").toggle()
				local winid = GetNvimTreeWinid()
				if winid ~= 0 then
					vim.api.nvim_set_current_win(winid)
					if vim.g.nvim_tree_moved == 1 then
						vim.cmd([[
	wincmd H
	vertical resize 30
	wincmd p
	    ]])
						vim.g.nvim_tree_moved = 0
					elseif vim.g.nvim_tree_moved == 0 then
						vim.cmd([[
	wincmd L
	vertical resize 30
	wincmd p
	    ]])
						vim.g.nvim_tree_moved = 1
					end
				end
			end,
			desc = "Toggle On/Off Dap UI",
		},
	},
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		require("dapui").setup()
	end,
}
