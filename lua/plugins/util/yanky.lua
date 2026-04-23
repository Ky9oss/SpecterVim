return {
  "gbprod/yanky.nvim",
  opts = { },
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>pp",
      function()
          Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  }
}
