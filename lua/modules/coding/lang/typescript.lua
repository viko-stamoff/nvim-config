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

  -- Add LSP
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'typescript-language-server', 'eslint_d' })
      end
    end,
  },

  -- Set up lsp
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.handlers, { tsserver = function()
        require('lspconfig').tsserver.setup()
      end})
    end,
  },

  -- Linter
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')

      vim.list_extend(opts.sources, {
        nls.builtins.code_actions.eslint_d,
        nls.builtins.code_actions.refactoring,
        -- nls.builtins.diagnostics.semgrep
      })
    end,
  },

  -- Debugger
  -- Problematic, for some reason
  -- {
  --   'mfussenegger/nvim-dap',
  --   -- optional = true,
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
    opts = {
      adapters = {
        ['neotest-vitest'] = {},
        ['neotest-jest'] = {},
      },
    },
  },
}
