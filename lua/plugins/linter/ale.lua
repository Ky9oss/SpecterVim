return {
  "dense-analysis/ale",
  config = function()
    -- g.ale_disable_lsp = 1
    vim.g.ale_disable_lsp = "auto"
    vim.g.ale_linters_explicit = 1 -- only enable the linter I set in g.ale_linters
    vim.g.ale_echo_cursor = 0 -- no echo when cursor move

    vim.g.ale_linters = {
      sh = { "shellcheck" },
    }

    vim.g.ale_pattern_options = {
      ["configure$"] = { ale_enabled = 0 },
      ["config.status$"] = { ale_enabled = 0 },
      ["config.guess$"] = { ale_enabled = 0 },
      ["config.sub$"] = { ale_enabled = 0 },
    }
  end,
}
