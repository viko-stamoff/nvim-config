# Disable, for now, as it errors out for every server
if true then return {}; end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        tsserver = {},
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({
            server = opts,
            on_attach = function(client, bufnr)
              local augroup_id =
                vim.api.nvim_create_augroup("FormatModificationsDocumentFormattingGroup", { clear = false })
              vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

              vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                group = augroup_id,
                buffer = bufnr,
                callback = function()
                  local lsp_format_modifications = require("lsp-format-modifications")
                  lsp_format_modifications.format_modifications(client, bufnr)
                end,
              })
            end,
          })

          return true
        end,

        -- Specify * to use this function as a fallback for any server
        ["*"] = function(server, opts)
          return true
        end,
      },
    },
  },
}
