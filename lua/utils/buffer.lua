function GetActiveBuffers()
  local buffers = {}
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
      table.insert(buffers, vim.api.nvim_win_get_buf(win))
    end
  end

  return buffers
end

function NvimBufGetWin(bufnr)
  bufnr = bufnr or 0
  return vim
    .iter(vim.api.nvim_list_wins())
    :filter(function(w) return vim.api.nvim_win_get_buf(w) == bufnr end)
    :totable()
end

function IsBufferVisible(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
      if vim.api.nvim_win_get_buf(win) == bufnr then
        return true
      end
    end
  end
  return false
end

--- Check if the specific file is visible(active) in buffer
--- @param partial_filename string
--- @return number
function IsFileVisible(partial_filename)
  for _, buffer in ipairs(GetActiveBuffers()) do
    local status, result = pcall(function()
      return vim.api.nvim_buf_get_name(buffer)
    end)
    if status then
      if result ~= nil then
        if string.find(result, partial_filename) then
          return buffer
        end
      end
    end
  end
  return -1
end
