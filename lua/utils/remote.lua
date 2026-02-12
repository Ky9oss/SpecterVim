sshpass = vim.fn.has("win32") == 1 and vim.fn.stdpath("config") .. "\\lib\\sshpass.exe" or "sshpass"

-- SCP: push file from local to remote by `sshpass`
--
--- @param from string
--- @param to string
--- @param on_exit function(bool)
function scp_push(from, to, on_exit)
  vim.system({
    sshpass,
    "-p",
    vim.g.myenv["SSHPASS"],
    "scp",
    "-P" .. vim.g.myenv["SSHPORT"],
    from,
    vim.g.myenv["SSHSERVER"] .. ":" .. to,
  }, { text = true }, function(obj)
    if on_exit then
      if obj.code ~= 0 then
        vim.notify("[SCP push failed]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
        on_exit(false)
      else
        on_exit(true)
      end
    end
  end)
end

-- SCP: pull file from remote to local by `sshpass`
--
--- @param from string
--- @param to string
--- @param on_exit function(bool)
function scp_pull(from, to, on_exit)
  vim.system({
    sshpass,
    "-p",
    vim.g.myenv["SSHPASS"],
    "scp",
    "-P" .. vim.g.myenv["SSHPORT"],
    vim.g.myenv["SSHSERVER"] .. ":" .. from,
    to,
  }, { text = true }, function(obj)
    if on_exit then
      if obj.code ~= 0 then
        vim.notify("[SCP pull failed]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
        on_exit(false)
      else
        on_exit(true)
      end
    end
  end)
end

-- SSH to remote server and exec command by `sshpass`
--
--- @param command string
--- @param on_exit function(bool)
function ssh(command, on_exit)
  vim.system({
    sshpass,
    "-p",
    vim.g.myenv["SSHPASS"],
    "ssh",
    vim.g.myenv["SSHSERVER"],
    "-p" .. vim.g.myenv["SSHPORT"],
    command,
  }, { text = true }, function(obj)
    if on_exit then
      if obj.code ~= 0 then
        vim.notify("[SSH execute command failed]" .. (obj.stderr or "?"), vim.log.levels.ERROR)
        on_exit(false)
      else
        on_exit(true)
      end
    end
  end)
end
