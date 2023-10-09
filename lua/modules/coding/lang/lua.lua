-- Lua lang config
return {
  -- Add syntax highlight
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'lua', 'luadoc' })
      end
    end,
  },

  -- Download LSP Server
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'lua_ls' })
      end
    end,
  },

  -- Setup LSP server
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   opts = function()
  --     local lsp = require('lsp-zero')
  --     local lua_opts = lsp.nvim_lua_ls()
  --     require('lspconfig').lua_ls.setup(lua_opts)
  --   end,
  -- },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)

      local server_config = {
        ['lua_ls'] = function(server, opts)
          local setup_config = {
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                  Lua = {
                    runtime = {
                      version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                      }
                      -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                      -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                  }
                })

                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
              return true
            end
          };

          require('lspconfig').lua_ls.setup(setup_config)
          return true;
        end
      }

      if type(opts.setup) == 'table' then
        vim.list_extend(opts.setup, server_config)

        for k, v in pairs(opts.setup) do
          print(k, v)
        end
      end
    end
  },

  -- Setup linter
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')

      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.luacheck,
        nls.builtins.code_actions.refactoring,
        -- nls.builtins.completion.luasnip,
        nls.builtins.formatting.lua_format,
      })
    end,
  },
}
