return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").load_extension("projects")
    vim.keymap.set("n", "<leader>fp", function()
      require("telescope").extensions.projects.projects()
    end, { noremap = true, silent = true, desc = "Find Projects" })

    local ok, builtin = pcall(require, "telescope.builtin")
    if ok then
      vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true })
      vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true })
      vim.keymap.set("n", "gi", builtin.lsp_implementations, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
    end

    -- 这里被坑了，注意：
    -- 1. telescope.actions只能在telescope加载后加载。Lazy.nvim的opts配置会在插件加载时同时加载（因此不能使用actions），而config配置会在插件加载后加载
    -- 2. actions.select_vertical 需要用在Picker上下文中，所以必须setup。而builtin会自动启动Picker，所以可以用vim.keymap.set
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<c-y>"] = actions.select_vertical,
          },
          n = {
            ["<c-y>"] = actions.select_vertical,
          },
        },
      },
    })
  end,
}
