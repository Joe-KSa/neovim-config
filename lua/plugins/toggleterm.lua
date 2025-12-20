return {
  "akinsho/toggleterm.nvim",
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      open_mapping = [[<c-]>]], -- Terminal principal (ID 1)
      hide_number = true,
      start_in_insert = true,
      direction = "horizontal",
      shell = "pwsh.exe -NoLogo -NoExit --ExecutionPolicy Bypass",
      float_opts = {
        border = "curved",
        winblend = 0,
      },
      auto_scroll = true,
      shade_filetypes = {},
      shading_factor = 2,
      close_on_exit = true,
      persist_size = true,
      highlights = {
        FloatBorder = {
          guifg = "#5c6170",
          guibg = "NONE",
        },
      },
    })

    -- Lógica para Terminales Personalizadas
    local Terminal = require("toggleterm.terminal").Terminal

    -- Función auxiliar para crear terminales rápidamente
    local function create_custom_term(opts)
      return Terminal:new({
        cmd = opts.cmd or "pwsh.exe -NoLogo -NoExit --ExecutionPolicy Bypass",
        direction = opts.direction or "horizontal",
        hidden = true,
      })
    end

    -- Definición de terminales
    local term2 = create_custom_term({ direction = "horizontal" })

    -- Mapeos usando la API moderna de Neovim
    -- Terminal 2
    vim.keymap.set("n", "<leader>t2", function()
      term2:toggle()
    end, { desc = "Toggle Segunda Terminal" })

    -- Mejorar la navegación dentro de las terminales
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end

    -- Aplicar mapeos solo cuando se abra una terminal
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
