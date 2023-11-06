return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "solidity",
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "nomicfoundation-solidity-language-server",
        "solhint",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solidity_ls_nomicfoundation = {},
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.solhint,
        nls.builtins.formatting.prettierd.with({
          extra_filetypes = { "solidity" },
          condition = function()
            local util = require("lspconfig.util")
            return util.root_pattern(".prettierrc", ".prettierrc.json")
          end,
        }),
      })
    end,
  },
}
