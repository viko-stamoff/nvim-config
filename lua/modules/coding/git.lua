local M = {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      { '<leader>gp', function() require('gitsigns').prev_hunk() end, desc = 'Go to Previous Hunk' },
      { '<leader>gn', function() require('gitsigns').next_hunk() end, desc = 'Go to Next Hunk' },
      { '<leader>gh', function() require('gitsigns').preview_hunk() end, desc = 'Preview Hunk' },
    },
  },
}

return M;
