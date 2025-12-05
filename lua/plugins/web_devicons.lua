return {
  "nvim-mini/mini.icons",
  lazy = true,
  opts = {
    extension = {
      ["test.tsx"] = { glyph = "󰂖", hl = "MiniIconsBlue" },
      ["test.ts"] = { glyph = "󰂖", hl = "MiniIconsBlue" },
      ["otf"] = { glyph = "", hl = "MiniIconsOrange" },
    },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
