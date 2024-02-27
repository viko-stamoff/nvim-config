local treesitter = { 'css', 'scss' }
local mason = {
  'biome',
  'prettierd',
}

return {
  { import = 'lazyvim.plugins.extras.lang.tailwind' },

  -- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, treesitter)
      end
    end,
  },


  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, mason)
    end,
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['css'] = { { 'biome', 'prettierd' } },
        ['scss'] = { 'prettierd' },
        ['less'] = { 'prettierd' },
        ['html'] = { { 'biome', 'prettierd' } },
      },
    },
  },

}
