-- Projects management
return {
  'ahmedkhalf/project.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim'
  },
  opts = {},
  event = 'VeryLazy',
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require('telescope').load_extension('projects')
  end,
  keys = {
    { '<leader>fp', function() require('telescope').extensions.projects.projects{} end, desc = 'Open Projects' },
    { '<leader>fr', function() require('project_nvim').get_recent_projects() end, desc = 'Open Recent Projects' },
  },
}
