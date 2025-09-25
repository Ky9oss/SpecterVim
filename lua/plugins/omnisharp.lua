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
