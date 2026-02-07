vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.profiler = true -- a neovim lua profiler in snacks.nvim
vim.g.copy_to_system = true -- duplicate 'y' in keymaps.lua

if vim.env.TMUX == nil or vim.env.TMUX == "" then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
else
  vim.g.clipboard = {
    name = "tmux-osc52-fallback",
    copy = {
      ["+"] = { "tmux", "load-buffer", "-w", "-" },
      ["*"] = { "tmux", "load-buffer", "-w", "-" },
    },
    paste = {
      ["+"] = { "tmux", "save-buffer", "-" },
      ["*"] = { "tmux", "save-buffer", "-" },
    },
    cache_enabled = true,
  }
end

vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.encoding = "UTF-8"
vim.opt.undodir = "~/.local/share/nvim/"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.o.autoread = true

-- CRLF
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fileformat = "unix"
vim.opt.fixendofline = false

-- load .env
function _G.load_env(path)
  local env = {}
  local file = io.open(path, "r")
  if not file then
    return env
  end

  local content = file:read("*a")
  file:close()

  for line in (content .. "\n"):gmatch("(.-)\n") do
    line = line:match("^%s*(.-)%s*$") -- trim
    if line == "" or line:match("^#") then
      goto skip
    end

    local key, value = line:match("^([A-Za-z_][%w_]*)%s*=%s*(.*)$")
    if not key then
      goto skip
    end

    value = value:match("^[\"']?(.-)[\"']?$") or value
    value = value:gsub('\\"', '"'):gsub("\\'", "'"):gsub("\\n", "\n"):gsub("\\t", "\t"):gsub("\\\\", "\\")

    env[key] = value
    ::skip::
  end

  return env
end

vim.g.myenv = _G.load_env(vim.fn.stdpath("config") .. "/.env")

require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("config.commands")
require("config.lsp")

function _G.find_segment_without_ucrt()
  local kept_lines = {}
  local buf = 0

  local positions = {}

  -- Get .rdata
  vim.fn.cursor(1, 1)
  while true do
    local start_pos = vim.fn.searchpos([[CONST]] .. "\t" .. [[SEGMENT]], "cW")
    if start_pos[1] == 0 then
      break
    end

    local end_pos = vim.fn.searchpos([[CONST]] .. "\t" .. [[ENDS]], "cnW")
    if end_pos[1] == 0 then
      break
    end

    table.insert(positions, { start = start_pos, end_ = end_pos })

    vim.fn.cursor(end_pos[1], end_pos[2] + 1)
  end

  -- Get .text
  vim.fn.cursor(1, 1)
  while true do
    local start_pos = vim.fn.searchpos([[_TEXT]] .. "\t" .. [[SEGMENT]], "cW")
    if start_pos[1] == 0 then
      break
    end

    local end_pos = vim.fn.searchpos([[TEXT]] .. "\t" .. [[ENDS]], "cnW")
    if end_pos[1] == 0 then
      break
    end

    local has_ucrt = vim.fn.searchpos([[ucrt]], "cnW", end_pos[1])
    if has_ucrt[1] == 0 or has_ucrt[1] > end_pos[1] then
      table.insert(positions, { start = start_pos, end_ = end_pos })
    end

    vim.fn.cursor(end_pos[1], end_pos[2] + 1)
  end

  if #positions == 0 then
    return
  end

  for _, r in ipairs(positions) do
    local lines = vim.api.nvim_buf_get_lines(buf, r.start[1] - 1, r.end_[1], false)
    for _, line in ipairs(lines) do
      table.insert(kept_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, true, kept_lines)

  vim.fn.cursor(1, 1)
end
