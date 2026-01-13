vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.profiler = true -- a neovim lua profiler in snacks.nvim

vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.encoding = "UTF-8"
vim.opt.undodir = "~/.local/share/nvim/"

require("config.keymaps")
require("config.lazy")

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

vim.lsp.config("clangd", {
  filetypes = { "c", "cpp" },
})
vim.lsp.enable("clangd")

vim.lsp.config("pylsp", {
  -- on_new_config = function(new_config, root_dir) -- use python with pyenv
  --   if not vim.fn.has("win32") == 1 then
  --     local python_path = vim.fn.systemlist("pyenv which python")[1]
  --     if vim.fn.filereadable(python_path) == 1 then
  --       new_config.settings.pylsp.configurationSources = { "pycodestyle" }
  --       new_config.settings.pylsp.plugins.jedi = { environment = python_path }
  --     end
  --   end
  -- end,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        mypy = { enabled = true },
      },
    },
  },
})
vim.lsp.enable("pylsp")

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
})
vim.lsp.enable("rust_analyzer")

vim.lsp.enable("asm_lsp")

vim.lsp.enable("lua_ls")

-- CRLF
-- vim.opt.fileformats = { "dos", "unix" }
-- vim.opt.fileformat = "dos"
-- vim.opt.fixendofline = false
