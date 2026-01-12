return {
  "nvimdev/lspsaga.nvim",
  lazy = true,
  event = { "BufEnter" },
  opts = {
    lightbulb = {
      enable = false,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
