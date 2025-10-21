return {
  "nvim-tree/nvim-tree.lua",
  opts = {},
  lazy = false,
  config = function()
    -- nvim-tree
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    -- 自定义装饰器类
    ---@class MyCustomDecorator : UserDecorator
    ---@field enabled boolean
    ---@field highlight_range string
    ---@field icon_placement string
    local MyCustomDecorator = require("nvim-tree.api").decorator.UserDecorator:extend()

    function MyCustomDecorator:new()
      self.enabled         = true
      self.highlight_range = "all" -- 或者 "all", "icon", "none"
      self.icon_placement  = "after"
      self.my_icon_node    = { str = ">", hl = { "DevIconNushell" } }
    end

    -- 自定义高亮逻辑
    ---@param node any
    ---@return string|nil
    function MyCustomDecorator:highlight_group(node)
      local target_files = {
        vim.api.nvim_buf_get_name(0),
      }
      for _, target_path in ipairs(target_files) do
        if node.absolute_path == target_path then
          return "Substitute" -- 高亮样式，可更换
        end
      end
      return nil
    end

    function MyCustomDecorator:icon_node(node)
      local target_files = {
        vim.api.nvim_buf_get_name(0),
      }
      for _, target_path in ipairs(target_files) do
        if node.absolute_path == target_path then
          return self.my_icon_node
        end
      end
      return nil
    end

    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,

      respect_buf_cwd = true,
      sync_root_with_cwd = true,

      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      update_focused_file = {
        enable = true,      -- 打开文件时自动高亮
        update_cwd = false, -- 切换目录
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        -- highlight_opened_files = "name", -- 高亮所有打开文件
        highlight_hidden = "name",
        root_folder_modifier = ":t",
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        root_folder_label = ":p",
        icons = {
          show = {
            git = false,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
        decorators = {
          "Git",
          "Open",
          "Hidden",
          "Modified",
          "Bookmark",
          "Diagnostics",
          "Copied",
          "Cut",
          MyCustomDecorator,
        },
      },
      filters = {
        dotfiles = false, -- show hidden files
      },
      actions = {
        open_file = {
          quit_on_open = false, -- 打开文件后不关闭 tree
        },
      },
      git = {
        enable = true,
        timeout = 200 -- (in ms)
      },
    })

    -- auto open nvim-tree
    local function open_nvim_tree(data)
      -- buffer is a real file on the disk
      local real_file = vim.fn.filereadable(data.file) == 1

      -- buffer is a [No Name]
      local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

      if real_file and not no_name then
        local dir = vim.fn.fnamemodify(data.file, ":p:h")
        vim.cmd.cd(dir)
        require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
      elseif no_name then
        require("nvim-tree.api").tree.open()
      else
        require("nvim-tree.api").tree.open()
      end
    end

    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

  end
}
