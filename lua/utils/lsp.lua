--- Get Current Buffer's LSP
--- @return string | nil
function GetLspInfo()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if #clients == 1 then
    local lsp_name = clients[1].name
    local lsp_info = nil

    if lsp_name == "lua_ls" then
      -- Lua_ls
      local runtime_version = clients[1].settings.Lua.runtime.version
      if runtime_version == nil then
        runtime_version = "default(lua5.3)"
      elseif runtime_version == "LuaJIT" then
        runtime_version = runtime_version .. "(lua5.1)"
      end
      lsp_info =  lsp_name .. "  " .. string.lower(runtime_version)
    else
      -- For other Lsp. TO BE EXTENDED.
      lsp_info = lsp_name
    end

    return "'" .. lsp_info

  else
    return ""
  end
end
