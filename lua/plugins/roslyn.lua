return {
  "seblyng/roslyn.nvim",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  lazy = true,
  event = { "BufEnter *.cs" },
  opts = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
    choose_target = function(target)
        return vim.iter(target):find(function(item)
            if string.match(item, "%.sln%") then
                return item
            end
        end)
    end
  },
}
