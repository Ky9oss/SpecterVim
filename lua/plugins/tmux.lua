if vim.fn.has("win32") == 1 then
  return {}
else
  return {
    "aserowy/tmux.nvim",
  }
end
