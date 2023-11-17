return {
  { "nvimtools/none-ls.nvim", enabled = false },

  {
    "stevearc/conform.nvim",
    opts = {
      format = {
        async = true, -- Not a good idea to enable
        lsp_fallback = true,
      },
    },
  },
}
