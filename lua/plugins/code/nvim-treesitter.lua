-- Treesitter-based highlighting

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
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
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
    })
  end,
}
