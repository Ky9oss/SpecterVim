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

    -- 创建你的自定义装饰器类  
    local MyCustomDecorator = require("nvim-tree.api").decorator.UserDecorator:extend()  
      
    function MyCustomDecorator:new()  
      self.enabled = true  
      self.highlight_range = "all"  -- 或者 "all", "icon", "none"  
      self.icon_placement = "none"  
    end  
      
    -- 自定义高亮逻辑
    function MyCustomDecorator:highlight_group(node)  
      local target_files = {  
        vim.api.nvim_buf_get_name(0), -- 当前文件的绝对路径
      }  
        
      for _, target_path in ipairs(target_files) do  
        if node.absolute_path == target_path then  
          return "NvimTreeOpenedHL"  -- 高亮样式，可更换 
        end  
      end  
        
      return nil  
    end

    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,

      -- 👇关键设置：不要在 session 文件里保存 nvim-tree
      respect_buf_cwd = true,
      sync_root_with_cwd = true,

      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      update_focused_file = {
        enable = true,        -- 打开文件时自动高亮
        update_cwd = false,    -- 切换目录
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        -- highlight_opened_files = "name",  -- 高亮所有打开文件
        highlight_hidden = "name",
        root_folder_modifier = ":t",
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        -- root_folder_label = ":p",
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
          MyCustomDecorator,  -- 添加你的自定义装饰器  
          "Cut",  
        },
      },
      filters = {
        dotfiles = false, -- show hidden files
      },
      actions = {
        open_file = {
          quit_on_open = false,  -- 打开文件后不关闭 tree
        },
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
        -- return
      end

    end

    vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


    -- 查找和聚焦目录（with telescope）
    function find_directory_and_focus()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function open_nvim_tree(prompt_bufnr, _)
        actions.select_default:replace(function()
          local api = require("nvim-tree.api")

          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          api.tree.open()
          api.tree.find_file(selection.cwd .. "/" .. selection.value)
        end)
        return true
      end

      require("telescope.builtin").find_files({
        find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
        attach_mappings = open_nvim_tree,
      })
    end

    vim.keymap.set("n", "fd", find_directory_and_focus)

    -- highlight the focused file
    local api = require("nvim-tree.api")

    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            if (vim.fn.bufname() == "NvimTree_1") then return end

            api.tree.find_file({ buf = vim.fn.bufnr() })
        end,
    })
  end
}
