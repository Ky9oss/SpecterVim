return {
  "folke/persistence.nvim",
  event = "BufReadPre",                             -- this will only start session saving when an actual file was opened
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions",   -- directory where session files are saved
    need = 1,
    branch = true,                                  -- use git branch to save session
  },
  config = function()
    vim.keymap.set("n", "<leader>qs", function() require("persistence").save() end)
    vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
    vim.keymap.set("n", "<leader>ql", function() require("persistence").load() end)
    vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistenceLoadPost",
      callback = function()
        require("nvim-tree.api").tree.open()
      end,
    })
  end

}
