return {
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
}
