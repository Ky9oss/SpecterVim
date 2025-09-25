local ft = { "cs", "vb" }
local root_patterns = { "*.sln", "*.csproj", "omnisharp.json", "function.json" }

local function in_project()
  local cwd = vim.fn.getcwd()
  for _, pattern in ipairs(root_patterns) do
    if #vim.fn.globpath(cwd, pattern) > 0 then
      return true
    end
  end
  return false
end

return {
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
    ft = ft,
    cond = in_project,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    ft = ft,
    cond = in_project,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ft = ft,
    cond = in_project,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "csharpier", "netcoredbg" } },
    ft = ft,
    cond = in_project,
  },
  {
    "neovim/nvim-lspconfig",
    ft = ft,
    cond = in_project,
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              require("omnisharp_extended").telescope_lsp_definitions(),
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    ft = ft,
    cond = in_project,
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["netcoredbg"] then
        require("dap").adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    ft = ft,
    cond = in_project,
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          -- Here we can set options for neotest-dotnet
        },
      },
    },
  },
}
