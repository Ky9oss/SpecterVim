return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<leader>b",
      "<cmd>DapToggleBreakpoint<CR>",
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>i",
      "<cmd>DapStepInto<CR>",
      desc = "Step Into",
    },
    {
      "<leader>u",
      "<cmd>DapStepOut<CR>",
      desc = "Step Out",
    },
    {
      "<leader>v",
      "<cmd>DapStepOver<CR>",
      desc = "Step Over",
    },
  },
  config = function()
    -- dap for c/c++/rust
    local dap = require("dap")

    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

      -- On windows you may have to uncomment this:
      -- detached = false,
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    -- dap for bash
    dap.adapters.bashdb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
      name = "bashdb",
    }

    dap.configurations.sh = {
      {
        type = "bashdb",
        request = "launch",
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
        pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        argsString = "",
        env = {},
        terminalKind = "integrated",
      },
    }

    -- dap for dotnet
    -- dap.adapters.coreclr = {
    --   type = 'executable',
    --   command = '/path/to/dotnet/netcoredbg/netcoredbg',
    --   args = {'--interpreter=vscode'}
    -- }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
      },
    }

    -- dap for python
    -- dap.configurations.python = {
    --   {
    --     -- The first three options are required by nvim-dap
    --     type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    --     request = "launch",
    --     name = "Launch file",
    --     module = "mitmproxy.tools.main:mitmproxy",
    --
    --     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    --
    --     -- program = "${file}", -- This configuration will launch the current file if used.
    --     pythonPath = function()
    --       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
    --       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
    --       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
    --       if vim.fn.has("win32") == 1 then
    --           return "python.exe"
    --       else
    --         local cwd = vim.fn.getcwd()
    --         if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
    --           return cwd .. "/venv/bin/python"
    --         elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    --           return cwd .. "/.venv/bin/python"
    --         else
    --           return "/usr/bin/python"
    --         end
    --       end
    --     end,
    --   },
    -- }
    -- dap.adapters.python = function(cb, config)
    --   if config.request == 'attach' then
    --     ---@diagnostic disable-next-line: undefined-field
    --     local port = (config.connect or config).port
    --     ---@diagnostic disable-next-line: undefined-field
    --     local host = (config.connect or config).host or '127.0.0.1'
    --     cb({
    --       type = 'server',
    --       port = assert(port, '`connect.port` is required for a python `attach` configuration'),
    --       host = host,
    --       options = {
    --         source_filetype = 'python',
    --       },
    --     })
    --   else
    --     cb({
    --       type = 'executable',
    --       command = 'python',
    --       args = { '-m', 'debugpy.adapter' },
    --       -- args = { 'run', "--with", "debugpy", "python", "-m", "debugpy.adapter" },
    --       options = {
    --         source_filetype = 'python',
    --       },
    --     })
    --   end
    -- end
    -- dap.configurations.python = {
    --   {
    --     -- The first three options are required by nvim-dap
    --     type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    --     request = "launch",
    --     name = "mitmproxy",
    --
    --     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    --   },
    -- }
    -- dap.adapters.python = function(cb, config)
    --     cb({
    --       type = 'executable',
    --       command = 'uv',
    --       -- args = { 'run', "mitmproxy", "--with", "debugpy", "python", "-m", "debugpy.adapter" },
    --       args = { 'run', "mitmproxy" },
    --       options = {
    --         source_filetype = 'python',
    --       },
    --     })
    -- end
  end,
}
