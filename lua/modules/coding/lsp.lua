return {
  -- LSP Servers Setup
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
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
    opts = {
      automatic_installation = true,
      ensure_installed = {},
    },
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
    config = function()
      local lsp = require('lsp-zero')

      -- see :h lsp-zero-keybindings
      lsp.on_attach(function(_, bufnr)
	print('base on-attach')
        lsp.default_keymaps({buffer = bufnr})
      end)
    end,
    keys = {
      { 'gd', vim.lsp.buf.definition, 'n', desc = 'Goto Definition' },
      { 'gD', vim.lsp.buf.declaration, 'n', desc = 'Goto Declaration' },
      { 'gr', require('telescope.builtin').lsp_references, 'n', desc = 'Goto References' },
      { 'gi', vim.lsp.buf.implementation, 'n', desc = 'Goto Implementation' },
      { 'gp', vim.diagnostic.goto_prev, 'n', desc = 'Goto Previous' },
      { 'gn', vim.diagnostic.goto_next, 'n', desc = 'Goto Next' },

      { '<leader>ca', vim.lsp.buf.code_action, 'n', desc = 'Code Action' },
      { '<leader>ct', vim.lsp.buf.type_definition, 'n', desc = 'Code Type Definition' },
      { '<leader>cs', require('telescope.builtin').lsp_document_symbols, 'n', desc = 'Code Symbols' },
      { '<leader>ck', vim.lsp.buf.signature_help, 'n', desc = 'Signature Documentation' },
      { '<leader>cf', vim.lsp.buf.format, 'n', desc = 'Code Format' },
      { '<leader>cr', vim.lsp.buf.rename, 'n', desc = 'Rename' },

      { 'K', vim.lsp.buf.hover, 'n', desc = 'Hover Documentation' },
    }
  },
};
