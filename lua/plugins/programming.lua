return {
  -- Debugging
  { import = 'lazyvim.plugins.extras.dap.core' },

  -- Testing adaptors
  { import = 'lazyvim.plugins.extras.test.core' },

  -- Highlight patterns in text
  { import = 'lazyvim.plugins.extras.util.mini-hipatterns' },

  -- Tables
  {
    'dhruvasagar/vim-table-mode',
    ft = "markdown",
    keys = {
      {"<leader>ct", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" }
    }
  }
}
