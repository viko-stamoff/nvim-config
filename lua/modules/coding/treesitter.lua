-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    init = function()
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
      load_textobjects = true
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufRead', 'BufNewFile' },
    cmd = { 'TSUpdateSync' },
    keys = {
      { '<C-Space>', desc = 'Increment selection' },
      { '<BS>', desc = 'Decrement selection', mode = 'x' }
    },
    ---@type TSConfig
    opts = {
      ensure_installed = { 'vim' },
      auto_install = true,
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
       select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      }
    }
 --    opts = function()
 --      require('nvim-treesitter.configs').setup({
	-- ---@type table<string>
 --        ensure_installed = { 'vim' },
 --        -- ensure_installed = { 'javascript', 'jsdoc', 'css', 'html', 'svelte', 'vim','c_sharp' },
 --        auto_install = true,
 --        highlight = {
 --          enable = true
 --        },
 --        indent = {
 --          enable = true
 --        },
 --        incremental_selection = {
 --          enable = true,
 --          keymaps = {
 --            init_selection = '<C-space>',
 --            node_incremental = '<C-space>',
 --            scope_incremental = '<C-s>',
 --            node_decremental = '<M-space>',
 --          },
 --        },
 --        textobjects = {
 --         select = {
 --            enable = true,
 --            lookahead = true,
 --            keymaps = {
 --              ['aa'] = '@parameter.outer',
 --              ['ia'] = '@parameter.inner',
 --              ['af'] = '@function.outer',
 --              ['if'] = '@function.inner',
 --              ['ac'] = '@class.outer',
 --              ['ic'] = '@class.inner',
 --            },
 --          },
 --          move = {
 --            enable = true,
 --            set_jumps = true, -- whether to set jumps in the jumplist
 --            goto_next_start = {
 --              [']m'] = '@function.outer',
 --              [']]'] = '@class.outer',
 --            },
 --            goto_next_end = {
 --              [']M'] = '@function.outer',
 --              [']['] = '@class.outer',
 --            },
 --            goto_previous_start = {
 --              ['[m'] = '@function.outer',
 --              ['[['] = '@class.outer',
 --            },
 --            goto_previous_end = {
 --              ['[M'] = '@function.outer',
 --              ['[]'] = '@class.outer',
 --            },
 --          },
 --          swap = {
 --            enable = true,
 --            swap_next = {
 --              ['<leader>a'] = '@parameter.inner',
 --            },
 --            swap_previous = {
 --              ['<leader>A'] = '@parameter.inner',
 --            },
 --          },
 --        }
 --      })
 --    end,
    ---@param opts TSConfig
    -- config = function(_, opts)
      -- if type(opts.ensure_installed) == 'table' then
      --   ---@type table<string, boolean>
      --   local added = {}
      --   opts.ensure_installed = vim.tbl_filter(function(lang)
      --     if added[lang] then
      --       return false
      --     end
      --     added[lang] = true
      --     return true
      --   end, opts.ensure_installed)
      -- end
      -- require('nvim-treesitter.configs').setup(opts)

      -- if load_textobjects then
      --   if opts.textobjects then
      --     for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
      --       if opts.textobjects[mod] and opts.textobjects[mod].enable then
      --         local Loader = require('lazy.core.loader')
      --         Loader.disabled_rtp_plugins['nvim-treesitter-textobjects'] = nil
      --         local plugin = require('lazy.core.config').plugins['nvim-treesitter-textobjects']
      --         require('lazy.core.loader').source_runtime(plugin.dir, 'plugin')
      --         break
      --       end
      --     end
      --   end
      -- end
    -- end,
  },
}
