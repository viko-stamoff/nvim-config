local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
    },

    -- Built in language support from LazyVim
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.json" },

    -- Languages
    { import = "lazyvim.plugins.extras.lang.rust" },

    -- Highlight patterns in text
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    -- Project management
    { import = "lazyvim.plugins.extras.util.project" },

    -- Debugging
    { import = "lazyvim.plugins.extras.dap.core" },

    -- Testing adaptors
    { import = "lazyvim.plugins.extras.test.core" },

    -- import/override with
    { import = "plugins" },
    { import = "plugins.lang" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
