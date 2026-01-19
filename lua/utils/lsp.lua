--- Get Current Buffer's LSP
--- @return string | nil
function GetLsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  local client_names = {}
  for _, client in ipairs(clients) do
    if client and client.name then
      table.insert(client_names, client.name)
    end
  end

  if #client_names > 0 then
    return table.concat(client_names, ", ")
  end
end
