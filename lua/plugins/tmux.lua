if vim.fn.has("win32") == 1 then
  return {
    "aserowy/tmux.nvim",
    lazy = true
  }
else
  return {
    "aserowy/tmux.nvim",
    lazy = false
  }
end
