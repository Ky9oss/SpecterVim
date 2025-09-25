return {
  "voldikss/vim-floaterm",
  config = function()
    -- 全局变量记录浮动终端状态
    vim.g.myfloat_created = false

    -- 动态浮动终端函数
    function _G.toggle_floaterm()
      if not vim.g.myfloat_created then
        -- 第一次按，创建浮动终端
        vim.cmd("FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2")
        vim.g.myfloat_created = true
      else
        -- 后续按，切换浮动终端
        vim.cmd("FloatermToggle myfloat")
      end
    end

    -- 映射 <leader>sh
    vim.keymap.set('n', '<leader>sh', _G.toggle_floaterm, { noremap = true, silent = true })
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")

  end
}
