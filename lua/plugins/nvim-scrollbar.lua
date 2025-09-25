return {
  'petertriho/nvim-scrollbar',
  dependencies = {
    'folke/tokyonight.nvim',
  },
  opts = function()
    local colors = require("tokyonight.colors").setup()
    return {
      handle = {
          color = colors.bg_highlight,
      },
      marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
      }
    }
  end
}
