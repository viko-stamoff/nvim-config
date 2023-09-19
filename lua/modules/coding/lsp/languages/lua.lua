-- Lua LS server setup and loaded by mason-lspconfig
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
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'lua-language-server' })
      end
    end,
  },

  -- Set up LSP
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('lspconfig').lua_ls.setup {}
    end,
  },

  -- Set up linter
  {

	}
}

