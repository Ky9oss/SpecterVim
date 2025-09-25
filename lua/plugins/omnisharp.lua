return {
  "Hoffs/omnisharp-extended-lsp.nvim",
  lazy = true,
  ft = { 'cs', 'vb' },
  config = function()
    local config = {
      handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
        ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
        ["textDocument/references"] = require('omnisharp_extended').references_handler,
        ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
      },
      enable_roslyn_analyzers = true,
      organize_imports_on_format = true,
      enable_import_completion = true,
    }
    require 'lspconfig'.omnisharp.setup(config)

    vim.keymap.set(
      "n",
      "gr",
      function() require("omnisharp_extended").telescope_lsp_references(require("telescope.themes").get_ivy({ excludeDefinition = true })) end,
      { noremap = true }
    )
    vim.keymap.set("n", "gd", require("omnisharp_extended").telescope_lsp_definition, { noremap = true })
    vim.keymap.set("n", "<leader>D", function() require("omnisharp_extended").telescope_lsp_references() end,
      { noremap = true })
    vim.keymap.set("n", "gi", require("omnisharp_extended").telescope_lsp_implementation, { noremap = true })

    -- vim.lsp.config('omnisharp', {
    --   handlers = {
    --     ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
    --     ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
    --     ["textDocument/references"] = require('omnisharp_extended').references_handler,
    --     ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
    --   },
    --   enable_roslyn_analyzers = true,
    --   organize_imports_on_format = true,
    --   enable_import_completion = true,
    -- })
    -- vim.lsp.enable('omnisharp')
  end
}
