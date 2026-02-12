return {
  "nvimdev/lspsaga.nvim",
  lazy = true,
  event = { "BufEnter" },
  opts = {
    lightbulb = {
      enable = false,
    },
    outline = {
      enable = false,
    },
    rename = {
      enable = false,
    },
    diagnostic = {
      enable = false,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
