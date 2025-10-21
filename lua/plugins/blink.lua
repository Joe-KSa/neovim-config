return {
  "saghen/blink.cmp",
  lazy = true,
  dependencies = { "saghen/blink.compat" },
  opts = {
    keymap = {
      preset = "default",
      ["<C-x>"] = { "show" },
      ["<C-Space>"] = { "show" },
    },
    sources = {
      default = {
        "lsp", -- autocompletado de LSP (React/TS/Angular/Nix)
        "path", -- rutas ./ ../
        "buffer", -- sugerencias del buffer actual
        "snippets", -- snippets (LuaSnip)
        "avante_commands",
        "avante_mentions",
        "avante_files",
      },
      providers = {
        lsp = {
          name = "lsp",
          module = "blink.cmp.sources.lsp", -- fuente oficial de blink
          score_offset = 100,
        },
        snippets = {
          name = "snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = 80,
        },
        path = {
          name = "path",
          module = "blink.cmp.sources.path",
          score_offset = 70,
        },
        buffer = {
          name = "buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = 60,
        },
        avante_commands = {
          name = "avante_commands",
          module = "blink.compat.source",
          score_offset = 50,
        },
        avante_files = {
          name = "avante_files",
          module = "blink.compat.source",
          score_offset = 40,
        },
        avante_mentions = {
          name = "avante_mentions",
          module = "blink.compat.source",
          score_offset = 30,
        },
      },
    },
  },
}
