local function LoadLsp(ev)
  local ft = vim.bo[ev.buf].filetype

  if (ft == "c" or ft == "cpp") and vim.g.clangd ~= true then
    vim.lsp.config("clangd", {
      filetypes = { "c", "cpp" },
    })

    vim.lsp.enable("clangd")
    vim.g.clangd = true
  elseif ft == "python" and vim.g.pylsp ~= true then
    vim.lsp.config("pylsp", {
      on_new_config = function(new_config, root_dir) -- use python with pyenv
        if not vim.fn.has("win32") == 1 then
          local python_path = vim.fn.systemlist("pyenv which python")[1]
          if vim.fn.filereadable(python_path) == 1 then
            new_config.settings.pylsp.configurationSources = { "pycodestyle" }
            new_config.settings.pylsp.plugins.jedi = { environment = python_path }
          end
        end
      end,
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
    vim.g.pylsp = true
  elseif ft == "rust" and vim.g.rust_analyzer ~= true then
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
    vim.g.rust_analyzer = true

  elseif ft == "asm" and vim.g.asm_lsp ~= true then
    vim.lsp.enable("asm_lsp")
    vim.g.asm_lsp = true

  elseif ft == "lua" and vim.g.lua_ls ~= true then
    vim.lsp.enable("lua_ls")
    vim.g.lua_ls = true

  end
end

vim.api.nvim_create_augroup("LoadLspGroup", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = "LoadLspGroup",
  pattern = "NvimLspconfigLoaded",
  callback = LoadLsp, -- callback = function(ev) vim.schedule(LoadLsp(ev)) end,
  desc = "Nvim-lspconfig: Set vim.lsp.config for different language when this plugin has loaded",
})

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  group = "LoadLspGroup",
  pattern = { "*.c", "*.h", "*.cpp", "*.rs", "*.py", "*.asm", "*.lua" },
  callback = LoadLsp,
  desc = "Nvim-lspconfig: Set vim.lsp.config for different language",
})
