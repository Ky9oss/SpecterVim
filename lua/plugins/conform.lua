-- formatter
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>fm",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff", bufnr).available then
          return { "ruff" }
        else
          return { "isort", "black" }
        end
      end,
      rust = { "rustfmt", lsp_format = "fallback" },
      cs = { "csharpier" },
      astro = { "prettier" },
      yaml = { "prettier" },
      toml = { "prettier" },
      markdown = { "prettier" },
      javascript = { "biome" },
      graphql = { "biome" },
      javascriptreact = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
      svelte = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      vue = { "biome" },
      css = { "biome" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
      csharpier = {
        command = "dotnet-csharpier",
        args = { "--write-stdout" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
