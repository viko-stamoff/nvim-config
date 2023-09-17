-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to 
-- help you solve all the trouble your code is causing.
return {
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
    { '<leader>xp', function() require('trouble').open() end, desc = 'Open problems' },
    { '<leader>xw', function() require('trouble').open('workspace_diagnostics') end, desc = 'Open workspace diagnostics' },
    { '<leader>xd', function() require('trouble').open('document_diagnostics') end, desc = 'Open document diagnostics' },
    { '<leader>xq', function() require('trouble').close() end, desc = 'Close quickfix window' },
  }
}
