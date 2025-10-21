return {
  "nvimdev/lspsaga.nvim",
  opts = {
    lightbulb = {
      enable = false,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  config = function()
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })
  end,
}
