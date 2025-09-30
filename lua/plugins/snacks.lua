return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = function()
    -- Toggle the profiler
    Snacks.toggle.profiler():map("<leader>pp")
    -- Toggle the profiler highlights
    Snacks.toggle.profiler_highlights():map("<leader>ph")
  end,
  keys = {
    { "<leader>ps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Bufer" },
  }
}
