return {
  "voldikss/vim-floaterm",
  config = function()
    -- 浮动终端状态
    vim.g.myfloat_created = false

    -- <leader>sh, 避免重复FLoatermNew
    function _G.toggle_floaterm()
      if not vim.g.myfloat_created then
        vim.cmd("FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 powershell.exe")
        vim.g.myfloat_created = true
      else
        vim.cmd("FloatermToggle myfloat")
      end
    end

    vim.keymap.set("n", "<leader>sh", _G.toggle_floaterm, { noremap = true, silent = true })
    vim.keymap.set(
      "n",
      "<leader>nsh",
      ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 powershell.exe <CR>"
    )
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")
  end,
}
