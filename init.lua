require('core.neovim')
require('core.lazy')

local code = {
  {
    'nvim-neotest/neotest',
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {},
      -- Example for loading neotest-go with a custom config
      -- adapters = {
      --   ['neotest-go'] = {
      --     args = { '-tags=integration' },
      --   },
      -- },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if require('lazyvim.util').has('trouble.nvim') then
            vim.cmd('Trouble quickfix')
          else
            vim.cmd('copen')
          end
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == 'number' then
            if type(config) == 'string' then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == 'table' and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error('Adapter ' .. name .. ' does not support setup')
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require('neotest').setup(opts)
    end,
    -- stylua: ignore
    keys = {
      { '<leader>ctt', function() require('neotest').run.run(vim.fn.expand('%')) end,                      desc =
      'Run File' },
      { '<leader>ctT', function() require('neotest').run.run(vim.loop.cwd()) end,                          desc =
      'Run All Test Files' },
      { '<leader>ctr', function() require('neotest').run.run() end,                                        desc =
      'Run Nearest' },
      { '<leader>cts', function() require('neotest').summary.toggle() end,                                 desc =
      'Toggle Summary' },
      { '<leader>cto', function() require('neotest').output.open({ enter = true, auto_close = true }) end,
                                                                                                             desc =
        'Show Output' },
      { '<leader>ctO', function() require('neotest').output_panel.toggle() end,                            desc =
      'Toggle Output Panel' },
      { '<leader>ctS', function() require('neotest').run.stop() end,                                       desc = 'Stop' },
    },
  },

  {
    'rcarriga/nvim-dap-ui',
    opts = {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
      {
        '<F5>',
        function() require('dap').continue() end,
        desc =
        'Debug: Start/Continue'
      },
      {
        '<F1>',
        function() require('dap').step_into() end,
        desc =
        'Debug: Step Into'
      },
      {
        '<F2>',
        function() require('dap').step_over() end,
        desc =
        'Debug: Step Over'
      },
      {
        '<F3>',
        function() require('dap').step_out() end,
        desc =
        'Debug: Step Out'
      },
      {
        '<leader>cb',
        function() require('dap').toggle_breakpoint() end,
        desc =
        'Debug: Toggle Breakpoint'
      },
      {
        '<leader>cB',
        function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')() end,
        desc =
        'Debug: Set Breakpoint with Condition'
      },
      { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Debug Nearest' },
    }
  },
}

local rust = {
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
  }
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
