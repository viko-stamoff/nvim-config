-- Lua LS server setup and loaded by mason-lspconfig
return {
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('lspconfig').lua_ls.setup {}
    end,
  }
}

