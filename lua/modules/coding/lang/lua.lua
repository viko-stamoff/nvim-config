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

  -- Add LSP
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'lua-language-server' })
      end
    end,
  },

  -- Set up LSP
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.handlers, { lua_ls = function()
        local lsp = require('lsp-zero')
        local lua_opts = lsp.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end})
    end,
  },

  -- Set up linter
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
