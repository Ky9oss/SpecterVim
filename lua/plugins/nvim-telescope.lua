return {
'nvim-telescope/telescope.nvim', branch = 'master',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').load_extension('projects')
    vim.keymap.set('n', '<leader>fp', function()
      require('telescope').extensions.projects.projects()
    end, { noremap = true, silent = true, desc = "Find Projects" })

    local ok, builtin = pcall(require, 'telescope.builtin')
    if ok then
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, silent = true })
      vim.keymap.set('n', 'gr', builtin.lsp_references, { noremap = true, silent = true })
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
    end

  end
}
