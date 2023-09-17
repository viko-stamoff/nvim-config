local M = {
  -- Theme inspired by Atom
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
}

return M;
