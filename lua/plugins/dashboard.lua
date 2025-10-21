return {
  "folke/snacks.nvim",
  lazy = false,
  -- aplicamos el hl después del setup
  config = function(_, opts)
    require("snacks").setup(opts)

     -- función para generar un color aleatorio en formato hexadecimal
    local function random_color()
      local r = math.random(0, 255)
      local g = math.random(0, 255)
      local b = math.random(0, 255)
      return string.format("#%02x%02x%02x", r, g, b)
    end

    -- semilla basada en el tiempo actual
    math.randomseed(os.time())

    -- color aleatorio
    local color_header = random_color()

    -- definir el hl principal con la variable
    vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = color_header, bold = true })

    local likely = {
      "SnacksHeader", "SnacksLogo", "SnacksDashboardHeader", "DashboardHeader",
      "DashboardLogo", "DashboardAscii", "AlphaHeader", "Title", "Normal"
    }

    local function force_link_groups()
      for _, g in ipairs(likely) do
        pcall(vim.cmd, ("hi link %s NeovimDashboardLogo1"):format(g))
        pcall(vim.cmd, ("hi %s guifg=%s gui=bold ctermfg=13 cterm=bold"):format(g, color_header))
      end
    end

    force_link_groups()
    vim.defer_fn(function()
      vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = color_header, bold = true })
      force_link_groups()
    end, 100)

    vim.api.nvim_create_autocmd({"ColorScheme","VimEnter","UIEnter","BufWinEnter","BufRead"}, {
      callback = function()
        vim.defer_fn(function()
          vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = color_header, bold = true })
          vim.cmd(("hi NeovimDashboardLogo1 guifg=%s gui=bold ctermfg=13 cterm=bold"):format(color_header))
          force_link_groups()
        end, 80)
      end,
    })
  end,

  opts = {
    notifier = {},
    image = {},
    picker = {
      exclude = {
        ".git",
        "node_modules",
      },
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        filename_bonus = true,
      },
      sources = {
        -- explorer = { ... },
      },
    },
    dashboard = {
      sections = {
        { section = "header", hl = "NeovimDashboardLogo1"},
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
      preset = {
        header = { [[


⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣤⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡗⠀⣠⣤⣤⡄⠈⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡷⠀⣠⣤⣤⡄⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡖⠒⠒⠒⠛⠀⢿⣿⣿⠇⠀⠓⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⡆⡖⠒⠒⠒⠒⠒⠒⠒⠛⠀⢿⣿⣿⠇⠀⠓⠒⠒⠒⠒⠒⠒⠒⡆⢶⠒⠒⠒⠒⠒⠒⢲⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⣾⣶⣶⣶⣶⣶⣶⣾⣶⣶⣶⣶⣶⠗⢀⣰⣶⣶⣶⣶⣶⣶⣶⣾⡆⠀⡇⡇⠀⣷⣶⣶⣶⣶⣶⣶⣷⣶⣶⣶⣶⣷⣶⣶⣶⣶⣶⣾⡆⠁⡇⣻⠀⣾⣶⣶⣶⡆⠸⠧⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⣄⡀⠀⠀⠀⠀⠀⠀⣠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠴⡄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⣿⣿⣿⣟⣿⣿⣟⣿⡿⣿⣻⠟⢁⣴⣿⣿⣿⣿⣻⣿⣿⡿⣿⣻⡇⢐⣇⡧⠈⣿⣿⣿⣟⣿⣿⣻⣿⣟⣿⣟⣿⣻⣿⣟⣿⣿⣟⣿⡧⠀⣇⢿⠀⣿⢿⡿⣿⣧⣤⣤⣤⣤⣦⣤⣤⣤⣤⣤⣤⣤⣶⣌⠈⠳⣄⠀⠀⠀⣠⠞⢁⣤⣦⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣦⡄⠈⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⣤⣤⣤⠄⠀⣤⣾⣿⣻⣽⠟⠁⣴⣾⠁⠀⢠⣤⣄⣄⠀⠀⣿⣿⢿⡇⠐⠋⠛⠀⠀⠀⠀⣾⣿⣽⣇⠂⠀⠀⠀⠀⠀⣿⣿⣽⡇⠀⠀⠀⠀⠛⠋⠀⣿⣿⢿⣟⣿⡿⣿⣿⢿⣿⡿⣿⣿⡿⣿⣿⣿⢿⣿⣷⣄⠈⠻⣤⠞⢁⣴⣾⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⢿⣿⡇⠀⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⣠⣾⣿⡿⣿⠟⢁⣤⣾⣿⣿⠐⠀⣹⣿⣿⣿⠀⠀⣿⣿⣿⡇⠀⢰⣿⣿⣿⣿⣿⣿⡿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣷⠀⠀⠙⠛⠛⠛⠛⠛⠛⠚⠛⠛⠛⠛⠓⠛⠛⠓⠛⠛⠛⠚⠛⢓⠀⢀⣰⣾⣿⣿⣻⡾⠛⠛⠛⠓⠛⠚⠓⠛⠚⠛⠛⠛⣺⣿⣿⣻⡇⠀⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⣠⣿⣿⣿⣿⠟⢁⣸⣆⠙⢻⣿⠛⠀⠠⢹⣿⣷⣿⠀⠀⣿⣿⣽⡇⠀⠈⢿⠿⠿⠽⠿⠷⠿⠿⠿⠽⠿⠯⠿⠿⠽⠯⠷⠿⢯⠿⢯⠿⠿⠟⠀⢿⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢶⠇⢸⣿⣿⣟⡷⠋⣀⡴⠒⠒⠛⠒⠒⠒⠒⠒⣲⠟⢠⣽⣿⣿⣻⡇⠀⡇
⠀⠀⠀⠀⠀⠀⠀⣠⠞⠁⣰⣿⣿⣿⣿⠟⢁⣰⣿⣿⣿⣷⣄⠀⠀⠀⠀⣹⣿⣟⣿⠀⠀⣿⣿⣿⡇⠀⡦⠤⢴⠀⢰⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣄⡀⠐⣦⡤⠤⣦⠀⣴⣤⣤⣴⣤⣤⣶⣤⣴⣦⣤⣶⣤⣴⣦⣤⣦⣤⣤⣦⣤⡄⠀⠰⣿⡿⠋⢀⡴⠋⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⣴⣿⣿⣿⣽⡿⠃⢠⡇
⠀⠀⠀⠀⠀⣠⠞⠁⣴⣿⣿⣿⣿⠟⠁⠄⣿⣿⣿⡿⣽⣾⣿⣷⣄⠀⠀⢼⣿⣿⣿⠀⠀⣿⣿⣿⡇⠀⡇⠀⢸⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⢳⡀⣽⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⡇⠀⠨⠛⢀⡴⠋⠀⠀⠀⠀⠀⠀⠀⣠⠞⢡⣶⣿⣿⣿⣟⡾⠋⢀⡼⠋⠀
⠀⠀⠀⣠⠞⠁⣰⣾⣿⣿⡿⠟⢁⡴⣯⠘⣿⣿⣿⡇⠘⠻⣯⣿⣿⠀⡀⢾⣿⣯⣿⠀⠀⣿⣿⣿⡇⠀⡇⠀⢸⠀⢸⣿⣿⣿⠉⠉⠉⡉⠉⡉⠉⢉⠉⠉⠙⣿⣿⣿⡇⢈⡇⣾⡄⠙⠛⠓⠛⠓⠛⠓⠛⠚⠓⠛⠚⠓⠛⠛⠛⠚⠛⠓⠛⠛⠃⠀⢀⡶⠋⠀⠀⠀⠀⠀⠀⠀⣠⠞⣡⣴⣿⣿⡿⣯⡷⠋⢀⡶⠋⠀⠀⠀
⠀⢠⣞⣁⣠⣀⣠⣀⣀⣀⣀⡴⠊⠀⡷⠀⣿⣿⣿⡇⢸⣄⠙⠻⣿⡄⠀⢾⣿⡿⣿⠀⠀⣿⣿⣿⡇⠀⡇⠀⢸⠀⢸⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠐⣻⣿⣾⡇⠀⡇⣽⢷⡶⢶⠶⠶⢶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢶⠶⢶⢶⣶⡏⠀⠀⠀⠀⠀⠀⠀⣠⠞⢡⣴⣿⣿⣿⣻⡽⠋⣠⡴⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡯⠀⣿⣿⣿⡇⠈⡏⢳⣤⠈⠃⡀⢺⣿⣿⣿⠀⠐⣿⣿⣿⡇⠀⡇⠀⢸⠀⢸⣿⣿⣿⠟⠻⠛⠿⠛⠿⠛⠿⠟⠋⢀⣿⣿⣿⡇⢌⡇⣿⠀⣰⣤⣤⣦⣤⣤⣦⣴⣤⣦⣴⣤⣦⣴⣤⣦⣴⣤⣤⣤⣤⣄⠰⡏⠀⠀⠀⠀⠀⣠⠞⣁⣼⣿⣿⣿⣯⡷⠋⣀⡼⠋⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡗⠀⣿⣿⣿⡇⢀⡇⠀⠙⢷⣵⠀⣽⣿⣿⣿⠀⠐⣿⣿⣿⡇⠀⡇⠀⢸⠀⢹⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣾⣿⣿⣽⠃⢠⠇⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠰⡇⠀⠀⠀⣠⠞⢁⣶⣿⣿⣿⢿⡾⠋⢀⡼⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣏⠀⣿⣿⣿⡇⠠⡇⠀⠀⠀⢻⠀⣹⣿⣷⣿⠀⠌⣿⣿⣿⡇⠐⡇⠀⢸⠀⣹⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⣨⠟⠀⣿⠆⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠚⠛⢿⣿⣽⣿⡇⠰⡇⠀⣠⠞⢡⣼⣿⣿⣿⣻⡿⠋⣀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣄⣐⣀⣃⣄⣒⡇⠀⠀⠀⢼⣢⣄⣠⣈⣄⣈⣐⣠⣀⣂⣐⣘⡇⠀⢾⣡⣄⣂⣄⣀⣂⣄⣠⣀⣄⣠⣀⣄⣠⣄⣡⣴⠴⠚⠁⠀⠐⠟⠛⠒⠒⠓⠒⠓⠒⠒⠒⠒⠒⠒⠒⠒⠒⠚⣾⠀⢿⣿⣿⢿⡇⢸⣧⠞⣁⣶⣿⣿⣿⣿⡽⠋⢄⡶⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                                                                ⢸⠌⣹⣿⣿⡿⠋⡄⣡⣶⣿⣿⣿⣿⡿⠋⣠⡼⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                                                                ⢹⢂⢽⡿⢋⡐⢌⣼⣿⣿⡿⣿⡷⢋⣐⡼⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                                                                ⢻⣪⣉⣔⣂⣌⣪⣉⣍⣉⣍⣩⣐⡶⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                                                                                ⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]},
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}