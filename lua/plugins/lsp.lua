return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayVariableTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
              },
            },
          },
        },
        angularls = {
          mason = false,
          cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
          end,
        },
        nil_ls = {
          mason = false,
          cmd = { "nil" },
          autostart = true,
          settings = {
            ["nil"] = {
              formatting = { command = { "nixpkgs-fmt" } },
            },
          },
        },
      },
    },
  },
}
