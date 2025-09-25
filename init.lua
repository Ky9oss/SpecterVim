-- vim.cmd('source ~/.config/nvim/init.vim')
vim.cmd([[
  set expandtab
  set number
  set laststatus=3
  set encoding=UTF-8
  set noshowmode
  set undodir=~/.local/share/nvim/
]])

require("config.lazy")

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git', '.editorconfig', '.gitignore' },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      },
      cargo = {
        allFeatures = true
      },
      procMacro = {
        enable = true
      }
    }
  }
})

vim.lsp.config('pylsp', {
  on_new_config = function(new_config, root_dir) -- 自动用当前 pyenv 激活的 python
    local python_path = vim.fn.systemlist("pyenv which python")[1]
    if vim.fn.filereadable(python_path) == 1 then
      new_config.settings.pylsp.configurationSources = { "pycodestyle" }
      new_config.settings.pylsp.plugins.jedi = { environment = python_path }
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

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- 避免 'vim' 未定义警告
      },

    }
  }
})

vim.lsp.config("asm_lsp", {
  default_config = {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "s", "S" },
    settings = {
      default_config = {
        assembler = "gas",
        instruction_set = "x86/x86-64",
      },
      opts = {
        compiler = "gcc",
        diagnostics = true,
        default_diagnostics = true,
      },
    },
  }
})

vim.lsp.config("roslyn", {
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})

vim.lsp.enable('pylsp')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('asm_lsp')
vim.lsp.enable('bashls')
vim.lsp.enable('roslyn')

require("check-enviroment")
require("keys")
