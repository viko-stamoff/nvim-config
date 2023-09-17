-- Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches.
return {
  -- Undo tree
  {
    'mbbill/undotree',
    keys = {
      -- Loaded from Telescope below
      -- { '<leader>u', vim.cmd.UndotreeToggle, 'n', desc = 'Undo Tree' },
    },
  },

  -- Telescope extensions for undo tree
  {
    'debugloop/telescope-undo.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    keys = {
      { '<leader>u', function() require('telescope').extensions.undo.undo() end, desc = 'Undo Tree' },
    },
    config = function()
      telescope.setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = 'vertical',
            layout_config = {
              preview_height = 0.8,
            },
            mappings = {
              i = {
                ['<CR>'] = require('telescope_actions').yank_additions,
                ['<S-CR>'] = require('telescope_actions').yank_deletions,
                ['<C-CR>'] = require('telescope_actions').restore,
              }
            }
          },
        },
      })

      telescope.load_extension('undo')
    end,
  },
}
