vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local git = {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },
}

local theme = {
  -- Theme inspired by Atom
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
}

local vim_keymaps = {
  {
    'mrjones2014/legendary.nvim',
    priority = 10000,
    lazy = false,
    init = function()
      vim.wo.relativenumber = true
      vim.o.hlsearch = false
      vim.o.mouse = 'a'
      vim.o.clipboard = 'unnamedplus'
      vim.o.breakindent = true
      vim.o.undofile = true
      vim.o.ignorecase = true
      vim.o.smartcase = true
      vim.o.updatetime = 250
      vim.o.timeoutlen = 300
      vim.o.completeopt = 'menuone,noselect'
      vim.o.termguicolors = true
      vim.o.scrolloff = 5
      vim.wo.number = true
      vim.wo.signcolumn = 'yes'
      vim.wo.relativenumber = true
    end,
    opts = {
      lazy_nvim = {
        auto_register = true
      },
      keymaps = {
        { '<Space>', '<Nop>', opts = { silent = true }, mode = { 'n', 'v' } },
        { 'k', "v:count == 0 ? 'gk' : 'k'", opts = { expr = true, silent = true }, mode = { 'n', 'v' } },
        { 'j', "v:count == 0 ? 'gj' : 'j'", opts = { expr = true, silent = true }, mode = { 'n', 'v' } },
        { '[d', vim.diagnostic.goto_prev, description = 'Go to previous diagnostic message', mode = { 'n', 'v' } },
        { ']d', vim.diagnostic.goto_next, description = 'Go to next diagnostic message', mode = { 'n', 'v' } },

        -- { '<leader>?', function() require('telescope.builtin').oldfiles() end, description = '[?] Find recently opened files', mode = { 'n' } },
        -- { '<leader><Space>', function() require('telescope.builtin').buffers() end, description = '[ ] Find existing buffers', mode = { 'n' } },
        -- { '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find(
        --     require('telescope.themes').get_dropdown {
        --       winblend = 10,
        --       previewer = false,
        --     }) end,
        --     description = '[/] Fuzzily search in current buffer' },

        { '<leader>e', vim.diagnostic.open_float, description = 'Open floating diagnostic message', mode = { 'n' } },
        { '<leader>q', vim.diagnostic.setloclist, description = 'Open diagnostics list', mode = { 'n' } },
      },
      autocmds = {
        {
          name = 'YankHighlight',
          clear = true,
          {
            'TextYankPost',
            function()
              vim.highlight.on_yank()
            end,
            opts = {
               pattern = '*',
            }
          },
        }
      }
    },
    which_key = {
      auto_register = true,
      mappings = {},
      opts = {},
      do_binding = true,
      use_groups = true,
    },
  }
}

local autocompletion = {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end,
  },
}

local fuzzyfinder = {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      local enable_native = pcall(require('telescope').load_extension, 'fzf')
      local can_build_with_make = vim.fn.executable 'make' == 1

      return enable_native and can_build_with_make
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      { "<leader>gf", function() require("telescope.builtin").git_files() end,   desc = "Search [G]it [F]iles" },
      { "<leader>sf", function() require("telescope.builtin").find_files() end,  desc = "[S]earch [F]iles" },
      { "<leader>sh", function() require("telescope.builtin").help_tags() end,   desc = "[S]earch [H]elp" },
      { "<leader>sw", function() require("telescope.builtin").grep_string() end, desc = "[S]earch current [W]ord" },
      { "<leader>sg", function() require("telescope.builtin").live_grep() end,   desc = "[S]earch by [G]rep" },
      { "<leader>sd", function() require("telescope.builtin").diagnostics() end, desc = "[S]earch [D]iagnostics" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }
  },
}

local editing = {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
}

local ui = {
  -- Set lualine as statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- Better UI elements
  {
    'stevearc/dressing.nvim',
    opts = {},
  }
}

local lsp = {
  {
    'folke/neodev.nvim',
    opts = true
  },

  -- Useful status updates for LSP
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {}
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    keys = {
     { 'gd', vim.lsp.buf.definition, 'n', desc = '[G]oto [D]efinition' },
     { 'gD', vim.lsp.buf.declaration, 'n', desc = '[G]oto [D]eclaration' },
     { 'gr', function() require('telescope.builtin').lsp_references() end, 'n', desc = '[G]oto [R]eferences' },
     { 'gI', vim.lsp.buf.implementation, 'n', desc = '[G]oto [I]mplementation' },

     { '<leader>sr', vim.lsp.buf.rename, 'n', desc = '[R]ename' },
     { '<leader>ca', vim.lsp.buf.code_action, 'n', desc = '[C]ode [A]ction' },
     { '<leader>ct', vim.lsp.buf.type_definition, 'n', desc = '[C]ode [T]ype Definition' },
     { '<leader>cs', function() require('telescope.builtin').lsp_document_symbols() end, 'n', desc = '[C]ode [S]ymbols' },
     { '<leader>cf', function() vim.lsp.buf.format() end, 'n', desc = '[C]ode [F]ormat' },

     { 'K', vim.lsp.buf.hover, 'n', desc = 'Hover Documentation' },
     { '<C-k>', vim.lsp.buf.signature_help, 'n', desc = 'Signature Documentation' },
     { '<leader>wa', vim.lsp.buf.add_workspace_folder, 'n', desc = '[W]orkspace [A]dd Folder' },
     { '<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, 'n', desc = '[W]orkspace [S]ymbols' },
     { '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'n', desc = '[W]orkspace [R]emove Folder' },
     { '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'n', desc = '[W]orkspace [L]ist Folders' },
    }
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      automatic_installation = true,
      ensure_installed = { 'html', 'rust_analyzer', 'tsserver', 'lua_ls' },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {}
        end,

        ["rust_analyzer"] = function()
          require("rust-tools").setup {}
        end,

        ["lua_ls"] = function ()
          require("lspconfig").lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        end,
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
  },
}

local code = {
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = "VeryLazy"
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<C-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
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
    },
  },

  {
    'mfussenegger/nvim-dap'
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap'
    },
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

require('lazy').setup({
  vim_keymaps,
  git,
  theme,
  autocompletion,
  fuzzyfinder,
  editing,
  lsp,
  code,
  ui,

  rust,
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
