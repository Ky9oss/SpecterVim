return {
  "voldikss/vim-floaterm",
  lazy = true,
  event = { "VeryLazy" },
  config = function()
    vim.g.myfloat_created = false

    -- <leader>sh
    function _G.toggle_floaterm()
      if not vim.g.myfloat_created then
        if vim.fn.has("win32") == 1 then
          vim.cmd("FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 powershell.exe")
        else
          vim.cmd("FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2")
        end
        vim.g.myfloat_created = true
      else
        vim.cmd("FloatermToggle myfloat")
      end
    end

    vim.keymap.set("n", "<leader>sh", _G.toggle_floaterm, { noremap = true, silent = true })
    if vim.fn.has("win32") == 1 then
      vim.keymap.set(
        "n",
        "<leader>nsh",
        ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 powershell.exe <CR>"
      )
    else
      vim.keymap.set("n", "<leader>nsh", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 <CR>")
    end

    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")
  end,
}
