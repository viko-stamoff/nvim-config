# Disable, for now, as it errors out and causes multiple formats
if true then return {}; end

return {
  {
    "joechrisellis/lsp-format-modifications.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "joechrisellis/lsp-format-modifications.nvim",
    },
    opts = function(_, opts)
      opts.on_attach = function(client, buffer)
        require("lsp-format-modifications").attach(client, buffer, {
          format_on_save = true,
        })
      end
    end,
  },
}
