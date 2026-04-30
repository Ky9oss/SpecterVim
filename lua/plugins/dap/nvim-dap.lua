return {
  "mfussenegger/nvim-dap",
  lazy = true,
  keys = {
    {
      "<leader>db",
      "<cmd>DapToggleBreakpoint<CR>",
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>di",
      "<cmd>DapStepInto<CR>",
      desc = "Step Into",
    },
    {
      "<leader>du",
      "<cmd>DapStepOut<CR>",
      desc = "Step Out",
    },
    {
      "<leader>dv",
      "<cmd>DapStepOver<CR>",
      desc = "Step Over",
    },
    {
      "<leader>dc",
      "<cmd>DapContinue<CR>",
      desc = "Start",
    },
    {
      "<leader>dn",
      "<cmd>DapNew<CR>",
      desc = "Start",
    },
    {
      "<leader>de",
      "<cmd>DapTerminate<CR>",
      desc = "Terminate",
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

  end,
}
