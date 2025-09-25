return {
  "Hoffs/omnisharp-extended-lsp.nvim",
  lazy = true,
  ft = { 'cs', 'vb' },
  config = function()
    vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definition, { noremap = true })
  end
}
