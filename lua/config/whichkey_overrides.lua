vim.schedule(function()
  local wk = require("which-key")
  wk.add({ { "<leader>ft", hidden = true }, { "<leader>fT", hidden = true } })
end)
