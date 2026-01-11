return {
  "kevinhwang91/nvim-ufo",
  lazy = true,
  keys = {
    -- neovim 自带原生折叠命令：
    --    使用za折叠当前区间
    --    使用zm/zr折叠所有
    {
      "zr",
      function()
        require("ufo").openAllFolds()
      end,
      mode = "n",
      desc = "Open All Folds",
    },
    {
      "zm",
      function()
        require("ufo").closeAllFolds()
      end,
      mode = "n",
      desc = "Close All Folds",
    },
  },
  dependencies = { "kevinhwang91/promise-async" },
  init = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    local ftMap = {
      vim = "indent",
      python = { "indent" },
      git = "",
    }

    ---@param bufnr number
    ---@return Promise
    local function customizeSelector(bufnr)
      local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return require("ufo")
        .getFolds(bufnr, "lsp")
        :catch(function(err)
          return handleFallbackException(err, "treesitter")
        end)
        :catch(function(err)
          return handleFallbackException(err, "indent")
        end)
    end

    require("ufo").setup({
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = { "imports", "comment" },
        json = { "array" },
        c = { "comment", "region" },
      },
      close_fold_current_line_for_ft = {
        default = true,
        c = false,
      },
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype] or customizeSelector
      end,
    })
  end,
}
