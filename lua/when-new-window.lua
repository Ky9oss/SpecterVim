vim.api.nvim_create_autocmd("WinNew", {
  callback = function(ev)
    local bufnr = vim.api.nvim_win_get_buf(ev.win)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    -- 根据 buffer 名称判断是不是 minimap
    if bufname:match("-MINIMAP-") then
      -- 给minimap窗口设置标记变量
      vim.api.nvim_win_set_var(ev.win, "skip_for_ctrlw", true)
    end
  end,
})
