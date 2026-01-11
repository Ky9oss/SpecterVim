return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions", -- directory where session files are saved
    need = 1,
    branch = true, -- use git branch to save session
  },
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
        require("nvim-tree.api").tree.open()
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}
