require("../utils.buffer")

local project = require("project_nvim.project")
local project_root_path = project.get_project_root()

--- Execute shell command in project's root path on Linux
--- Cmd is split by space: "git add ."
---
--- @param cmd string
--- @param on_result function(success: bool)
local function shellExecute(cmd, on_result)
  return vim.system(vim.split(cmd, "%s+"), { cwd = vim.split(project_root_path, "%s+")[1] }, function(obj)
    if obj.code == 0 then
      if obj.stdout ~= nil and obj.stdout:gsub("^%s*(.-)%s*$", "%1") ~= "" then
        vim.notify("STDOUT:" .. obj.stdout)
      end
      if on_result then
        on_result(true)
      end
    else
      vim.notify("[" .. obj.code .. "] " .. "Failed! STDERR: " .. obj.stderr, vim.log.levels.ERROR)
      if on_result then
        on_result(false)
      end
    end
  end)
end

-- Git Push
vim.api.nvim_create_user_command("GitPush", function(opts)
  if opts.args == nil then
    vim.notify("GitPush need 1 argument at least.", vim.log.levels.ERROR)
  else
    if project_root_path == nil then
      vim.notify("Can't find the project's root path", vim.log.levels.ERROR)
    else
      if vim.fn.has("win32") == 1 then
        -- Windows with proxychains
        vim.system({
          "cmd",
          "/c",
          "cd",
          project_root_path,
          "&&",
          "git",
          "add",
          ".",
          "&&",
          "git",
          "commit",
          "-m",
          opts.args,
          "&&",
          "proxychains",
          "-q",
          "git",
          "push",
          "-u",
          "origin",
          "main",
        }, { text = true }, function(obj)
          if obj.code == 0 then
            vim.notify("STDOUT:" .. obj.stdout)
          else
            vim.notify("[" .. obj.code .. "] " .. "GitPush Failed! STDERR: " .. obj.stderr, vim.log.levels.ERROR)
          end
        end)
      else
        -- Linux with proxychains
        shellExecute("git add .", function(success)
          if success then
            shellExecute("git commit -m " .. opts.args, function(success)
              if success then
                shellExecute("git push -u origin main")
              end
            end)
          end
        end)
      end
    end
  end
end, { desc = "Push codes to 'origin' in main branch.", nargs = 1 })

-- filter useless info in msvc assembly
local function filterMSVC()
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
  vim.cmd.write()
end

-- MSVC EXPLORER
--
-- /Fa             产生 .asm 文件（默认文件名是源文件名+后缀 .asm）
-- /Faoutput.asm   指定输出汇编文件名
--
-- /c              只编译不链接（避免链接器相关符号污染）
--
-- /O1             小代码优化（通常比 /Od 更干净，比 /O2 更可读）
-- /Od             不优化（保留最多源代码痕迹，但会多很多栈操作）
-- /O2             速度优化
--
-- /GS-            关闭 Buffer Security Check
-- /guard:cf-      关闭 Control Flow Guard
--
-- /EHs- /EHc-     关闭 C++ 异常（C++异常会产生非常多展开代码）
-- /GR-            关闭 RTTI（关闭 type_info 等）
--
-- /MT             使用静态多线程运行时（/MD 会引入很多 DLL 导入符号）
--
-- /Oy-            不要省略帧指针（保留 ebp，便于理解栈帧）
-- /Ob0            关闭内联
--
-- /nologo         不要输出版本信息（美观用）
--
function AssemblyExplorerMSVC()
  local filetype = vim.bo[vim.api.nvim_get_current_buf()].filetype
  local filepath = vim.api.nvim_buf_get_name(0)

  if (filetype == "c" or filetype == "cpp") and filepath ~= nil then
    local asm_path = vim.fn.stdpath("cache") .. "\\_temp_assembly_explorer.asm"
    local old_win = vim.api.nvim_get_current_win()
    local asm_win
    local asm_bufnr

    vim.cmd(
      'FloatermSend --name=msvc cl /Fa"'
        .. asm_path:gsub([[\]], [[\\]])
        .. '" /c /O1 /GS- /guard:cf- /EHs- /EHc- /GR- /MT /Oy- /Ob0 /nologo /Zc:inline- '
        .. filepath
    )
    asm_bufnr = IsFileVisible("_temp_assembly_explorer.asm")

    if asm_bufnr == -1 then
      asm_win = vim.api.nvim_open_win(0, true, {
        split = "right",
        vertical = true,
        width = 55,
      })
      vim.api.nvim_set_current_win(asm_win) -- toggle to asm win
      vim.cmd.edit(vim.fn.fnameescape(asm_path)) -- read file to asm buffer
      vim.api.nvim_set_current_win(old_win) -- toggle back
      asm_bufnr = vim.api.nvim_win_get_buf(asm_win)
    else
      asm_win = NvimBufGetWin(asm_bufnr)
    end

    vim.api.nvim_create_autocmd("FileChangedShellPost", {
      callback = function(args)
        if args.buf == asm_bufnr then
          vim.api.nvim_set_current_win(asm_win) -- toggle to asm win
          filterMSVC()
          vim.api.nvim_set_current_win(old_win) -- toggle back
        end
      end,
      desc = "Asm file have changed",
      -- once = true,
    })

    local timer = vim.loop.new_timer()
    timer:start(
      0,
      300, -- 0.3s
      vim.schedule_wrap(function()
        vim.cmd("silent! checktime") -- 20 checks
      end)
    )
    vim.defer_fn(function()
      timer:stop()
    end, 6000) -- 6s
  end
end

-- GCC Remote EXPLORER
--
-- -fno-exceptions  关闭 C++ 异常支持（throw / catch / try 等）
-- -fno-asynchronous-unwind-tables  阻止生成 异步栈展开表（.eh_frame 段中的 DWARF CFI 信息）
-- -fstack-protector  金丝雀
--
function AssemblyExplorerGCC()
  local asm_bufnr = IsFileVisible("_temp_assembly_explorer_remote_gcc.s")
  local asm_path = vim.fn.stdpath("cache") .. "\\_temp_assembly_explorer_remote_gcc.s"
  local old_win = vim.api.nvim_get_current_win()

  -- asynchronous
  vim.system({
    vim.fn.stdpath("config") .. "\\lib\\sshpass.exe",
    "-p",
    vim.g.myenv["SSHPASS"],
    "scp",
    "-P" .. vim.g.myenv["SSHPORT"],
    vim.api.nvim_buf_get_name(0),
    vim.g.myenv["SSHSERVER"] .. ":/tmp/nvim_generate_asm.c",
  }, { text = true }, function(obj)
    if obj.code == 0 then
      vim.system({
        vim.fn.stdpath("config") .. "\\lib\\sshpass.exe",
        "-p",
        vim.g.myenv["SSHPASS"],
        "ssh",
        vim.g.myenv["SSHSERVER"],
        "-p" .. vim.g.myenv["SSHPORT"],
        "gcc -S -masm=intel -fno-asynchronous-unwind-tables -fno-exceptions /tmp/nvim_generate_asm.c -o /tmp/nvim_generate_asm.s",
      }, { text = true }, function(obj)
        if obj.code == 0 then
          vim.system({
            vim.fn.stdpath("config") .. "\\lib\\sshpass.exe",
            "-p",
            vim.g.myenv["SSHPASS"],
            "scp",
            "-P" .. vim.g.myenv["SSHPORT"],
            vim.g.myenv["SSHSERVER"] .. ":/tmp/nvim_generate_asm.s",
            vim.fn.stdpath("cache") .. "\\_temp_assembly_explorer_remote_gcc.s",
          }, { text = true }, function(obj)
            if obj.code ~= 0 then
              vim.notify("[AssemblyExplorer Failed 3]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
              return
            end
          end)
        else
          vim.notify("[AssemblyExplorer Failed 2]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
          return
        end
      end)
    else
      vim.notify("[AssemblyExplorer Failed 1]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
      return
    end
  end)

  if asm_bufnr == -1 then
    local asm_win = vim.api.nvim_open_win(0, true, {
      split = "right",
      vertical = true,
      width = 55,
    })
    vim.api.nvim_set_current_win(asm_win) -- toggle to asm win
    vim.cmd.edit(vim.fn.fnameescape(asm_path)) -- read file to asm buffer
    vim.api.nvim_set_current_win(old_win) -- toggle back
  end

  local timer = vim.loop.new_timer()
  timer:start(
    0,
    300, -- 0.3s
    vim.schedule_wrap(function()
      vim.cmd("silent! checktime") -- 20 checks
    end)
  )
  vim.defer_fn(function()
    timer:stop()
  end, 6000) -- 6s
end

if vim.fn.has("win32") == 1 then
  vim.api.nvim_create_user_command("AssemblyExplorer", function(opts)
    if opts.args == nil then
      vim.notify("AssemblyExplorer need 1 argument at least.", vim.log.levels.ERROR)
    else
      if string.lower(opts.args) == "msvc" then
        AssemblyExplorerMSVC()
      elseif string.lower(opts.args) == "gcc" then
        AssemblyExplorerGCC()
      end
    end
  end, { desc = "Get assembly for current buffer.", nargs = 1 })
end
