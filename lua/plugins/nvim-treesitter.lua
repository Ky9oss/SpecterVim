-- Treesitter-based highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,             -- last release is way too old and doesn't work on Windows
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  event = { "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts_extend = { "ensure_installed" },
  ---@class lazyvim.TSConfig: TSConfig
  opts = {
    indent = { enable = true },
    highlight = {
      enable = true,
    },
    folds = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "css",
      "c_sharp",
      "rust",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "ninja",
      "printf",
      "python",
      "query",
      "razor",
      "regex",
      "rst",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  config = function(_, opts)
    local TS = require("nvim-treesitter")

    -- setup treesitter
    TS.setup(opts)
  end
}
