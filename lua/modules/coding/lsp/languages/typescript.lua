return {
  -- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'typescript', 'javascript', 'tsx' })
      end
    end,
  },

  -- LSP
  {
    'williamboman/mason.nvim',
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'typescript-language-server' })
      end
    end,
  },

  -- Set up lsp
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ---@type lspconfig.options.tsserver
	tsserver = {
          keys = {
            -- Autofix entire buffer with eslint_d:
            { '<leader>cf', 'mF:%!eslint_d --stdin --fix-to-stdout<CR>`F', mode = 'n'},
            -- Autofix visual selection with eslint_d:
            { '<leader>cf', ':!eslint_d --stdin --fix-to-stdout<CR>gv', mode = 'x'},
          },
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          -- require('typescript').setup({ server = opts })
          return true
        end,
      },
    },
  },

  -- Linter
  {
    'mantoni/eslint_d.js',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          if type(opts.ensure_installed) == 'table' then
            vim.list_extend(opts.ensure_installed, { 'eslint_d' })
          end
        end,
      },
    },
  },

  -- Debugger
  -- Problematic, for some reason
  -- {
  --   'mfussenegger/nvim-dap',
  --   optional = true,
  --   dependencies = {
  --     {
  --       'williamboman/mason.nvim',
  --       opts = function(_, opts)
  --         if type(opts.ensure_installed) == 'table' then
  --           vim.list_extend(opts.ensure_installed, { 'js-debug-adapter' })
  --         end
  --       end,
  --     },
  --   },
  --   opts = function()
  --     local dap = require('dap')
  --     if not dap.adapters['pwa-node'] then
  --       require('dap').adapters['pwa-node'] = {
  --         type = 'server',
  --         host = 'localhost',
  --         port = '${port}',
  --         executable = {
  --           command = 'node',
  --           -- 💀 Make sure to update this path to point to your installation
  --           args = {
  --             require('mason-registry').get_package('js-debug-adapter'):get_install_path()
  --               .. '/js-debug/src/dapDebugServer.js',
  --             '${port}',
  --           },
  --         },
  --       }
  --     end
  --     for _, language in ipairs({ 'typescript', 'javascript' }) do
  --       if not dap.configurations[language] then
  --         dap.configurations[language] = {
  --           {
  --             type = 'pwa-node',
  --             request = 'launch',
  --             name = 'Launch file',
  --             program = '${file}',
  --             cwd = '${workspaceFolder}',
  --           },
  --           {
  --             type = 'pwa-node',
  --             request = 'attach',
  --             name = 'Attach',
  --             processId = require('dap.utils').pick_process,
  --             cwd = '${workspaceFolder}',
  --           },
  --         }
  --       end
  --     end
  --   end,
  -- },

  -- Test runner
  {
    'nvim-neotest/neotest',
    optional = true,
    opts = {
      adapters = {
        ['neotest-vitest'] = {},
        ['neotest-jest'] = {},
      },
    },
  },
}
