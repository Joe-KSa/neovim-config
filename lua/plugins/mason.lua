return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", -- formateador de Lua
        "shellcheck", -- linter de Bash
        "shfmt", -- formateador de Bash
        "flake8", -- linter de Python
      },
    },
  },
}
