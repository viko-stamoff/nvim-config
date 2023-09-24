return {
  -- LSP Servers Setup
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  },

  -- LSP Package Manager (UI)
  {
    'williamboman/mason.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
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
    opts =  function()
      -- This is where all the LSP shenanigans will live
      local lsp = require('lsp-zero')
      lsp.extend_lspconfig()

      lsp.on_attach(function(_, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({buffer = bufnr})
      end)

      return {
        automatic_installation = true,
        ensure_installed = {},
        handlers = {
          lsp.default_setup,
	},
      }
    end,
  },

  -- -- mason-nvim-dap.nvim closes some gaps that exist between mason.nvim and nvim-dap. Its main responsibilities are:
  -- -- 1. provide extra convenience APIs such as the :DapInstall command
  -- -- 2. allow you to (i) automatically install, and (ii) automatically set up a predefined list of adapters
  -- -- 3. translate between dap adapter names and mason.nvim package names (e.g. python <-> debugpy)
  -- {
  --   'jay-babu/mason-nvim-dap.nvim',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'williamboman/mason.nvim',
  --     'mfussenegger/nvim-dap',
  --   },
  --   opts = {
  --     automatic_setup = true,
  --   }
  -- },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    },
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
};
