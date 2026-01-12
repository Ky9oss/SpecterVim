-- indentation lines
return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = { "BufEnter" },
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
}
