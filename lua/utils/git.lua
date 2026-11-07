function is_git_repo()
end

-- Used to auto add Session.vim in .gitignore
function live_grep(filepath, pattern)
end

-- local function file_contains_rg_async(path, pattern, callback)
--   path = vim.fn.expand(path)
--   vim.system(
--     { 'rg', '-q', '--fixed-strings', pattern, path },
--     { text = true },
--     function(obj)
--       callback(obj.code == 0)
--     end
--   )
-- end
--
-- file_contains_rg_async('path/to/file', 'target text', function(found)
--   if found then
--     print('found')
--   end
-- end)
