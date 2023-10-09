return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {},
    keys = {
      { '<leader>f', desc = 'Find/File' },
      { '<leader>ff', function() require('telescope.builtin').git_files() end, desc = 'Search Git Files' },
      { '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = 'Search Recent Files' },
      { '<leader>fF', function() require('telescope.builtin').find_files() end, desc = 'Search Files' },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Search Help' },

      { '<leader>s', desc = 'Search' },
      { '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = 'Search for current Word' },
      { '<leader>sg', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = 'Search with Grep' },
      { '<leader>sG', function() require('telescope.builtin').live_grep() end, desc = 'Search Grep Globally' },
      { '<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = 'Search Diagnostics' },

      { '<leader>b', desc = 'Buffers' },
      { '<leader>bl', function() require('telescope.builtin').buffers() end, desc = 'Buffer List' },
    }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    build = 'make',
    opts = {},
    config = function()
      require('telescope').load_extension('fzf')
    end
  }
}
