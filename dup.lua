vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
vim.opt.autochdir = true

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
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      { '<leader>gp', function() require('gitsigns').prev_hunk() end,    desc = 'Go to Previous Hunk' },
      { '<leader>gn', function() require('gitsigns').next_hunk() end,    desc = 'Go to Next Hunk' },
      { '<leader>gh', function() require('gitsigns').preview_hunk() end, desc = 'Preview Hunk' },
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
    opts = {
      lazy_nvim = {
        auto_register = true
      },
      keymaps = {
        { '<Space>', '<Nop>',                     opts = { silent = true },              mode = { 'n', 'v' } },
        { 'k',       'v:count == 0 ? "gk" : "k"', opts = { expr = true, silent = true }, mode = { 'n', 'v' } },
        { 'j',       'v:count == 0 ? "gj" : "j"', opts = { expr = true, silent = true }, mode = { 'n', 'v' } },
        {
          '[d',
          vim.diagnostic.goto_prev,
          description = 'Go to previous diagnostic message',
          mode = { 'n',
            'v' }
        },
        { ']d',         vim.diagnostic.goto_next,  description = 'Go to next diagnostic message',    mode = { 'n', 'v' } },
        { '<leader>cm', vim.diagnostic.open_float, description = 'Open floating diagnostic message', mode = { 'n' } },
        { '<leader>ck', vim.diagnostic.setloclist, description = 'Open diagnostics list',            mode = { 'n' } },
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
        },
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
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      local tabfn = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end

      local stabfn = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

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
          ['<Tab>'] = cmp.mapping(tabfn, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(stabfn, { 'i', 's' }),
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
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    keys = {
      { '<leader>sf', function() require('telescope.builtin').git_files() end,                 desc = 'Search Git Files' },
      { '<leader>sF', function() require('telescope.builtin').find_files() end,                desc = 'Search Files' },
      { '<leader>sh', function() require('telescope.builtin').help_tags() end,                 desc = 'Search Help' },
      { '<leader>sw', function() require('telescope.builtin').grep_string() end,               desc = 'Search for current Word' },
      { '<leader>sg', function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = 'Search with Grep' },
      { '<leader>sG', function() require('telescope.builtin').live_grep() end,                 desc = 'Search Grep Globally' },
      { '<leader>sd', function() require('telescope.builtin').diagnostics() end,               desc = 'Search Diagnostics' },
      { '<leader>bl', function() require('telescope.builtin').buffers() end,                   desc = 'Buffer List' },
    }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require("telescope").load_extension("fzf")
    end,
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
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '│',
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  -- Active indent guide and indent text objects. When you're browsing code, this highlights the current level of indentation, and animates the highlighting.
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- symbol = '▏',
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
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
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { '<leader>x',  desc = 'Quick Fix' },
      { '<leader>xp', function() require('trouble').open() end,                        desc = 'Open problems' },
      { '<leader>xw', function() require('trouble').open('workspace_diagnostics') end, desc = 'Open workspace diagnostics' },
      { '<leader>xd', function() require('trouble').open('document_diagnostics') end,  desc = 'Open document diagnostics' },
      { '<leader>xq', function() require('trouble').close() end,                       desc = 'Close quickfix window' },
    }
  },

  {
    'ahmedkhalf/project.nvim',
    opts = {},
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension('projects')
    end,
    keys = {
      { '<leader>sp', '<Cmd>Telescope projects<CR>', desc = 'Projects' },
    },
  },

  {
    'numToStr/FTerm.nvim',
    lazy = false,
    init = function()
      vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
      vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
      vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })
      vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
    end,
    opts = {
      auto_close = false,
    },
    keys = {
      { '<C-_>', function() require('FTerm').toggle() end, desc = 'Toggle Terminal', mode = 'n' },
      { '<C-_>', function() require('FTerm').close() end,  desc = 'Close Terminal',  mode = 't' },
    },
  },
}

local lsp = {
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        plugins = { 'nvim-dap-ui' },
        types = true
      },
    }
  },

  -- Useful status updates for LSP
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    opts = {},
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      automatic_setup = true,
    }
  },

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
      max_concurrent_installers = 4,
    },
    keys = {
      {
        'gd',
        vim.lsp.buf.definition,
        'n',
        desc =
        'Goto Definition'
      },
      {
        'gD',
        vim.lsp.buf.declaration,
        'n',
        desc =
        'Goto Declaration'
      },
      {
        'gr',
        function() require('telescope.builtin').lsp_references() end,
        'n',
        desc =
        'Goto References'
      },
      {
        'gI',
        vim.lsp.buf.implementation,
        'n',
        desc =
        'Goto Implementation'
      },

      { '<leader>sr', vim.lsp.buf.rename,      'n', desc = 'Rename' },
      { '<leader>ca', vim.lsp.buf.code_action, 'n', desc = 'Code Action' },
      {
        '<leader>ct',
        vim.lsp.buf.type_definition,
        'n',
        desc =
        'Code Type Definition'
      },
      { '<leader>cs', function() require('telescope.builtin').lsp_document_symbols() end, 'n', desc = 'Code Symbols' },
      { '<leader>cf', function() vim.lsp.buf.format() end,                                'n', desc = 'Code Format' },
      {
        'K',
        vim.lsp.buf.hover,
        'n',
        desc =
        'Hover Documentation'
      },
      {
        '<C-k>',
        vim.lsp.buf.signature_help,
        'n',
        desc =
        'Signature Documentation'
      },
    }
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      automatic_installation = true,
      ensure_installed = { 'rust_analyzer', 'lua_ls' },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {}
        end,

        ['rust_analyzer'] = function()
          require('rust-tools').setup {}
        end,

        ['lua_ls'] = function()
          require('lspconfig').lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
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
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = false,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectory = { mode = 'auto' },
          },
        },
        jsonls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeys[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
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
    --@param opts PluginLspOpts
    config = function(_, opts)
    end,
    ---@param opts PluginLspOpts
    -- config = function(_, opts)
    --   local Util = require("util")
    --
    --   if Util.has("neoconf.nvim") then
    --     local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
    --     require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
    --   end
    --   -- setup autoformat
    --   require("lazyvim.plugins.lsp.format").setup(opts)
    --   -- setup formatting and keymaps
    --   Util.on_attach(function(client, buffer)
    --     require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    --   end)
    --
    --   local register_capability = vim.lsp.handlers["client/registerCapability"]
    --
    --   vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    --     local ret = register_capability(err, res, ctx)
    --     local client_id = ctx.client_id
    --     ---@type lsp.Client
    --     local client = vim.lsp.get_client_by_id(client_id)
    --     local buffer = vim.api.nvim_get_current_buf()
    --     require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    --     return ret
    --   end
    --
    --   -- diagnostics
    --   for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
    --     name = "DiagnosticSign" .. name
    --     vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    --   end
    --
    --   local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    --
    --   if opts.inlay_hints.enabled and inlay_hint then
    --     Util.on_attach(function(client, buffer)
    --       if client.supports_method('textDocument/inlayHint') then
    --         inlay_hint(buffer, true)
    --       end
    --     end)
    --   end
    --
    --   if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
    --     opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
    --         or function(diagnostic)
    --           local icons = require("lazyvim.config").icons.diagnostics
    --           for d, icon in pairs(icons) do
    --             if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
    --               return icon
    --             end
    --           end
    --         end
    --   end
    --
    --   vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
    --
    --   local servers = opts.servers
    --   local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    --   local capabilities = vim.tbl_deep_extend(
    --     "force",
    --     {},
    --     vim.lsp.protocol.make_client_capabilities(),
    --     has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    --     opts.capabilities or {}
    --   )
    --
    --   local function setup(server)
    --     local server_opts = vim.tbl_deep_extend("force", {
    --       capabilities = vim.deepcopy(capabilities),
    --     }, servers[server] or {})
    --
    --     if opts.setup[server] then
    --       if opts.setup[server](server, server_opts) then
    --         return
    --       end
    --     elseif opts.setup["*"] then
    --       if opts.setup["*"](server, server_opts) then
    --         return
    --       end
    --     end
    --     require("lspconfig")[server].setup(server_opts)
    --   end
    --
    --   -- get all the servers that are available through mason-lspconfig
    --   local have_mason, mlsp = pcall(require, "mason-lspconfig")
    --   local all_mslp_servers = {}
    --   if have_mason then
    --     all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    --   end
    --
    --   local ensure_installed = {} ---@type string[]
    --   for server, server_opts in pairs(servers) do
    --     if server_opts then
    --       server_opts = server_opts == true and {} or server_opts
    --       -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
    --       if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
    --         setup(server)
    --       else
    --         ensure_installed[#ensure_installed + 1] = server
    --       end
    --     end
    --   end
    --
    --   if have_mason then
    --     mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    --   end
    --
    --   if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
    --     local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
    --     Util.lsp_disable("tsserver", is_deno)
    --     Util.lsp_disable("denols", function(root_dir)
    --       return not is_deno(root_dir)
    --     end)
    --   end
    -- end,
  },
}

local code = {
  -- 'gc' to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    event = 'VeryLazy'
  },

  {
    'windwp/nvim-autopairs',
    opts = {}
  },

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

  -- Undo tree
  { 'mbbill/undotree' },

  -- Telescope extensions for undo tree
  {
    'debugloop/telescope-undo.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    },
    keys = {
      { '<leader>u', function() require('telescope').extensions.undo.undo() end, desc = 'Undo Tree' },
    },
    config = function()
      telescope.setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = 'vertical',
            layout_config = {
              preview_height = 0.8,
            },
            mappings = {
              i = {
                ['<CR>'] = require('telescope_actions').yank_additions,
                ['<S-CR>'] = require('telescope_actions').yank_deletions,
                ['<C-CR>'] = require('telescope_actions').restore,
              }
            }
          },
        },
      })

      telescope.load_extension('undo')
    end,
  },

  -- Linter
  --{
    --'jose-elias-alvarez/null-ls.nvim',
    --event = { 'BufReadPre', 'BufNewFile' },
    --dependencies = 
    --{
      --'williamboman/mason.nvim',
    --},
    --opts = {
      --sources = {
        --require('null-ls').builtins.formatting.fish_indent,
        --require('null-ls').builtins.diagnostics.fish,
        --require('null-ls').builtins.formatting.stylua,
        --require('null-ls').builtins.formatting.shfmt,
        ---- require('null-ls').builtins.diagnostics.flake8,
      --},
      --root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
    --}
  --},

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    init = function()
      require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
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
      { '<c-space>', desc = 'Increment selection' },
      { '<bs>',      desc = 'Decrement selection', mode = 'x' }
    },
    opts = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'lua', 'luadoc', 'rust', 'tsx', 'javascript', 'jsdoc', 'css', 'html', 'svelte', 'vim',
          'c_sharp' },
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
            scope_incremental = '<C-s>',
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
      };
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)

      if load_textobjects then
        if opts.textobjects then
          for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              local Loader = require('lazy.core.loader')
              Loader.disabled_rtp_plugins['nvim-treesitter-textobjects'] = nil
              local plugin = require('lazy.core.config').plugins['nvim-treesitter-textobjects']
              require('lazy.core.loader').source_runtime(plugin.dir, 'plugin')
              break
            end
          end
        end
      end
    end,
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
--
