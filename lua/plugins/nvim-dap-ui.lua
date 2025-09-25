return { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, 
config = function()
  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  map("n", "<leader>o", function()
    require("dapui").open()
  end, opts)

  map("n", "<leader>c", function()
    require("dapui").close()
  end, opts)

  map("n", "<leader>t", function()
    require("dapui").toggle()
  end, opts)
end
}
