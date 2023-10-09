return {
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

  -- LSP Support
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   dependencies = {
  --     'neovim/nvim-lspconfig',
  --   },
  --   branch = 'v3.x',
  -- },

  -- LSP Package manager integration with LSP server
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
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
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
    end,
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      autoformat = true,
      format_notify = false,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        jsonls = {},
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
};
