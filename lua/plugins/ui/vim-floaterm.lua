return {
  "voldikss/vim-floaterm",
  lazy = false,
  keys = {
    {
      "<leader>sh",
      "<cmd>FloatermToggle default<cr>",
      desc = "Toggle to default floaterm.",
    },
    {
      "<leader>ms",
      "<cmd>FloatermToggle msvc<cr>",
      desc = "Toggle to MSVC cmd.",
    },
    {
      "<leader>nsh",
      function()
        if vim.fn.has("win32") == 1 then
          vim.cmd("FloatermKill default")
          vim.cmd("FloatermNew --name=default --height=0.8 --width=0.7 --autoclose=2 powershell.exe")
        else
          vim.cmd("FloatermKill default")
          vim.cmd("FloatermNew --name=default --height=0.8 --width=0.7 --autoclose=2")
        end
      end,
      desc = "Create new floaterm and close the default term.",
    },
    {
      "<leader>nf",
      "<cmd>FloatermNext<cr>",
      desc = "Toggle to next floaterm.",
    },
    {
      "<leader>pf",
      "<cmd>FloatermPrev<cr>",
      desc = "Toggle to prev floaterm.",
    },
  },
  config = function()
    if vim.fn.has("win32") == 1 then
      vim.cmd("FloatermNew --name=default --height=0.8 --width=0.7 --autoclose=2 powershell.exe")
      vim.cmd("FloatermHide default")

      -- After FloatermHide, current buffer enter modified mode unexpected. So we auto execute <ESC> to fix that.
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    else
      vim.cmd("FloatermNew --name=default --height=0.8 --width=0.7 --autoclose=2")
      vim.cmd("FloatermHide default")

      -- After FloatermHide, current buffer enter modified mode unexpected. So we auto execute <ESC> to fix that.
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    end
  end,
}
