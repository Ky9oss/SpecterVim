return {
  "dense-analysis/ale",
  config = function()
    local g = vim.g

    -- g.ale_disable_lsp = 1
    vim.g.ale_disable_lsp = "auto"
    vim.g.ale_linters_explicit = 1 -- only enable the linter I set in g.ale_linters

    g.ale_linters = {
      sh = { "shellcheck" },
    }
  end,
}
