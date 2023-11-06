vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml.ansible" },
  desc = "ansible commentstring configuration",
  command = "setlocal commentstring=#\\ %s",
})

return {
  {
    "pearofducks/ansible-vim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "yaml",
        })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {},
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.diagnostics.ansiblelint,
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["yaml.ansible"] = { "ansible_lint", "yamllint" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["yaml.ansible"] = { "yamlfix" },
      },
    },
  },
}
