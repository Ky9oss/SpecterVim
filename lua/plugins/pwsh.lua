if vim.fn.has("win32") == 1 then
  return {
    "TheLeoP/powershell.nvim",
    ---@type powershell.user_config
    opts = {
      bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
      shell = "powershell.exe",
    },
    lazy = true,
    event = { "BufEnter *.ps1" }
  }
else
  return {}
end
