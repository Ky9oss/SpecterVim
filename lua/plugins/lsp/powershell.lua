if vim.fn.has("win32") == 1 then
  return {
    "TheLeoP/powershell.nvim",
    lazy = true,
    ft = "ps1",
    config = function()
      require("powershell").setup({
        -- https://github.com/PowerShell/PowerShellEditorServices/releases/tag/v4.4.0
        bundle_path = vim.fn.stdpath("data") .. "\\PowerShellEditorServices",
        shell = "powershell.exe",
        settings = {
          powershell = {
            scriptAnalysis = {
              enable = true,
              settingsPath = vim.fn.stdpath("config") .. "\\lib\\PSScriptAnalyzerSettings.psd1", -- (optional)
            },
            codeFormatting = {
              Preset = "OTBS",
              enable = true,
            },
          },
        },
      })

      -- diagnostic level
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ps1",
        callback = function()
          vim.diagnostic.config({
            virtual_text = {
              severity = { min = vim.diagnostic.severity.WARN },
            },
            signs = {
              severity = { min = vim.diagnostic.severity.WARN },
            },
            underline = {
              severity = { min = vim.diagnostic.severity.WARN },
            },
          })
        end,
      })
    end,
  }
else
  return {}
end
