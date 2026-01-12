return {
  "neovim/nvim-lspconfig",
  ft = { "c", "cpp", "rust", "python" },
  lazy = true,
  config = function()

    vim.lsp.config("*", {
      capabilities = {
        textDocument = {
          semanticTokens = {
            multilineTokenSupport = true,
          },
        },
      },
      root_markers = { ".git", ".editorconfig", ".gitignore" },
    })

    vim.api.nvim_exec_autocmds("User", { pattern = "NvimLspconfigLoaded" })
  end
}

