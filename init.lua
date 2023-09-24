require('core.neovim')
require('core.lazy')

local code = {

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
