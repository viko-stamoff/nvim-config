-- C# lang config
return {
  -- Add syntax highlight
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'c_sharp' })
      end
    end,
  },

  -- Download LSP Server
  {
    'williamboman/mason-lspconfig.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'omnisharp', 'omnisharp_mono' })
      end
    end,
  },

  -- Setup LSP server
  {
    'VonHeikemen/lsp-zero.nvim',
    opts = function()
      require('lspconfig').omnisharp.setup({})
      -- require('lspconfig').omnisharp_mono.setup({})
    end,
  },

  -- Setup linter
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')

      vim.list_extend(opts.sources, {
        nls.builtins.formatting.csharpier,
	-- nls.builtins.formatting.astyle,
      })
    end,
  },
}
