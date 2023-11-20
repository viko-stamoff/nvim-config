return {
  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "solidity",
      })
    end,
  },

  -- LSP Server
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "nomicfoundation-solidity-language-server",
        "solhint",
        "prettier",
        --TODO: Additionally, a plugin must also be installed for prettier:
        -- `npm install --save-dev prettier-plugin-solidity`
      })
    end,
  },

  -- LSP Server Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solidity_ls_nomicfoundation = {},
      },
    },
  },


  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        solidity = { "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--plugin=prettier-plugin-solidity" },
        },
      },
    },
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      linters_by_ft = {
        solidity = { "solhint" },
      },
    },
  }
}
