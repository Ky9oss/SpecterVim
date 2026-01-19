-- auto open nvim-tree
local function open_nvim_tree(data)
  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if real_file and not no_name then
    -- local dir = vim.fn.fnamemodify(data.file, ":p:h")
    -- vim.cmd.cd(dir)
    -- require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
  elseif no_name then
    require("nvim-tree.api").tree.open()
  else
    require("nvim-tree.api").tree.open()
  end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
