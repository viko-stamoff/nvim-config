local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'modules' },
    { import = 'modules.coding' },
    { import = 'modules.coding.lang' }
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },
  install = {
    missing = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "tutor",
        "matchit",
        "matchparen",
        "netrwPlugin",
	-- "gzip",
        -- "tarPlugin",
        -- "tohtml",
        -- "zipPlugin",
      },
    },
  },
})
