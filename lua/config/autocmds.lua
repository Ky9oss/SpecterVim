-- auto open nvim-tree
local function open_nvim_tree(data)
  local opened_with_file = vim.fn.argc() > 0

  if not opened_with_file then
    require("nvim-tree.api").tree.open()
  end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- auto change CRLF to LF
vim.api.nvim_create_autocmd("BufWrite", {
  pattern = "*",
  callback = function()
    if vim.bo.fileformat == "dos" then
      vim.bo.fileformat = "unix"
    end
  end,
})
