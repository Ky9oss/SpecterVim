return {
  "mason-org/mason.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
    ensure_installed = { "csharpier", "netcoredbg" },
    registries = {
      "github:mason-org/mason-registry",
      "github:Crashdummyy/mason-registry",
    },
  }
}
