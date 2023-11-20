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
          local start_line = vim.fn.getpos("'<")[1]
          local end_line = vim.fn.getpos("'>")[1]
          local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
          vim.print(lines)

          -- if args.count ~= -1 then
          --   local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          --   range = {
          --     start = { args.line1, 0 },
          --     ["end"] = { args.line2, end_line:len() },
          --   }
          -- end
          --
          -- require("conform").format({ async = true, lsp_fallback = true, range = range })
        end,
        mode = { "x", "v" },
        desc = "Format in selection",
      },
    },
  },
}
