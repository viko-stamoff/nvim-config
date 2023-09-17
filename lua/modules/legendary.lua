return {
  'mrjones2014/legendary.nvim',
  dependencies = { 'kkharji/sqlite.lua' },
  version = 'v2.1.0',
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  opts = {
    lazy_nvim = {
      auto_register = true
    },
    keymaps = {
      { '<Space>', '<Nop>', opts = { silent = true }, mode = { 'n', 'v' } },
      { 'k', 'v:count == 0 ? "gk" : "k"', opts = { expr = true, silent = true }, mode = { 'n', 'v' } },
      { 'j', 'v:count == 0 ? "gj" : "j"', opts = { expr = true, silent = true }, mode = { 'n', 'v' } },
      { '[d', vim.diagnostic.goto_prev, description = 'Go to previous diagnostic message', mode = { 'n', 'v' }},
      { ']d', vim.diagnostic.goto_next,  description = 'Go to next diagnostic message', mode = { 'n', 'v' } },
      { '<leader>cm', vim.diagnostic.open_float, description = 'Open floating diagnostic message', mode = { 'n' } },
      { '<leader>ck', vim.diagnostic.setloclist, description = 'Open diagnostics list', mode = { 'n' } },
    },
    autocmds = {
      {
        name = 'YankHighlight',
        clear = true,
        {
          'TextYankPost',
          function()
            vim.highlight.on_yank()
          end,
          opts = {
            pattern = '*',
          }
        },
      },
    },
    which_key = {
      auto_register = true,
      mappings = {},
      opts = {},
      do_binding = true,
      use_groups = true,
    },
  }
};
