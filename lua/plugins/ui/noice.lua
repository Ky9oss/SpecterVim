-- return {}
return {
	"folke/noice.nvim",
	dev = false,
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},

			views = {
				confirm = {
					backend = "popup",
					relative = "editor",
					focusable = false,
					align = "center",
					enter = false,
					zindex = 210,
					format = { "{confirm}" },
					position = {
						row = 8,
						col = "50%",
					},
					size = "auto",
					border = {
						style = "rounded",
						padding = { 0, 1 },
						text = {
							top = " Confirm ",
						},
					},
					win_options = {
						winhighlight = {
							Normal = "NoiceConfirm",
							FloatBorder = "NoiceConfirmBorder",
						},
						winbar = "",
						foldenable = false,
					},
				},
			},
			cmdline = {
				backend = "popup",
				relative = "editor",
				align = "center",
				focusable = true,
				position = {
					row = "100%",
					col = 0,
				},
				size = {
					height = "auto",
					width = "100%",
				},
				border = {
					style = "none",
				},
				win_options = {
					winhighlight = {
						Normal = "NoiceCmdline",
						IncSearch = "",
						CurSearch = "",
						Search = "",
					},
				},
			},

			routes = {
				-- {
				-- 	view = "cmdline",
				-- 	filter = {
				-- 		any = {
				-- 			{ event = "msg_show", kind = "confirm" },
				-- 			{ event = "msg_show", kind = "confirm_sub" },
				-- 			{ event = "msg_show", kind = "number_prompt" },
				-- 		},
				-- 	},
				-- 	-- opts = { skip = true, stop = false },
				-- },

				-- {
				-- 	filter = { event = "msg_show", kind = "confirm" },
				-- 	opts = { skip = true },
				-- },
				-- {
				-- 	filter = { event = "msg_show", kind = "confirm_sub" },
				-- 	opts = { skip = true },
				-- },
				-- {
				-- 	filter = { event = "msg_show", kind = "number_prompt" },
				-- 	opts = { skip = true },
				-- },
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
	end,
}
