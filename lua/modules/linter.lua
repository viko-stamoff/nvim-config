-- Linter
return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
  },
  opts = {
    sources = {
      require('null-ls').builtins.formatting.fish_indent,
      require('null-ls').builtins.diagnostics.fish,
      require('null-ls').builtins.formatting.stylua,
      require('null-ls').builtins.formatting.shfmt,
      -- require('null-ls').builtins.diagnostics.flake8,
    },
    root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
  }
}
