return {
  "APZelos/blamer.nvim",
  init = function()
    vim.g.blamer_enabled = true
    vim.g.blamer_delay = 100
    vim.g.blamer_prefix = " > "
  end,
}
