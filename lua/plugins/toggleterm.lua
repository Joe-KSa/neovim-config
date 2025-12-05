return {
  "akinsho/nvim-toggleterm.lua",
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      open_mapping = [[<c-]>]],
      hide_number = true,
      start_in_insert = true,
      direction = "float", -- vertical | float | tab,
      shell = "pwsh.exe -NoLogo -NoExit --ExecutionPolicy Bypass",
      float_opts = {
        border = "curved",
        winblend = 0,
      },
      auto_scroll = true, -- hacer scroll automático al final
      shade_filetypes = {}, -- sombrear terminal según filetype
      shading_factor = 2, -- intensidad de sombreado (0-3)
      close_on_exit = true, -- cerrar terminal al salir del proceso
      persist_size = true, -- recordar tamaño de la terminal

      highlights = {
        FloatBorder = {
          guifg = "#5c6170",
          guibg = "NONE",
        },
      },
    })
  end,
}
