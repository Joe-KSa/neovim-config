return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { buffer = buffer, desc = "Rename File" })
        end)
      end,
    },
    event = "VeryLazy",
    opts = {
      inlay_hints = { enabled = false },
      servers = {

        -- Usa tu instalación global de TypeScript
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", -- muestra nombres en parámetros
                includeInlayVariableTypeHints = true, -- muestra tipo de variables
                includeInlayFunctionLikeReturnTypeHints = true, -- muestra tipo retorno
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
        -- Usa tu instalación global de Angular
        --
        angularls = {
          mason = false,
          cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("angular.json", "project.json")(fname)
          end,
        },
        -- Usa tu instalación global de Nix
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
        tailwindcss = {
          mason = false,
          cmd = { "tailwindcss-language-server", "--stdio" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.ts",
              "postcss.config.js",
              "package.json",
              ".git"
            )(fname)
          end,
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "clsx\\(([^)]*)\\)", "'([^']*)'" },
                  { "cn\\(([^)]*)\\)", "'([^']*)'" },
                },
              },
            },
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
