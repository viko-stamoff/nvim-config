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
    keys = {
      {
        "<leader>cF",
        function()
          local start_pos = vim.fn.getpos("v")
          local end_pos = vim.fn.getpos(".")

          local range = {
            start = { start_pos[1], 0 },
            ["end"] = { end_pos[1] + 1, 0 },
          }

          require("conform").format({ async = true, lsp_fallback = true, range = range })
        end,
        mode = { "x", "v" },
        desc = "Format in selection",
      },
    },
  },
}
