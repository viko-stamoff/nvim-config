return {
  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    branch = 'v3.x',
  },

  -- LSP Package Manager (UI)
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗'
        }
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 8,
    },
  },

  -- LSP Package manager integration with LSP server
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {},
      handlers = {},
    },
  },

  -- LSP Servers Setup
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
}
