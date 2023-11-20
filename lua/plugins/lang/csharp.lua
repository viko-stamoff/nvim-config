-- DISABLED!
if true then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "omnisharp")
      -- table.insert(opts.ensure_installed, "omnisharp-mono")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = { "cs", "csproj", "sln" },
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(args)
              print("wtf")
              return require("omnisharp_extended").handler(args)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        --TODO: Not sure what the ft should be. Try these: csproj, cs, csharp, c_sharp, etc
        csharp = { "csharpier" },
      },
    },
  },
}