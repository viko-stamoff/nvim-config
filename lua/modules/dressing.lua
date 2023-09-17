-- Better and improved UI elements
return {
  'stevearc/dressing.nvim',
  opts = {
    input = {
      title_pos = "left",
      -- These are passed to nvim_open_win
      border = "rounded",
      -- 'editor' and 'win' will default to being centered
      relative = "cursor",
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<C-c"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
    },
    builtin = {
      mappings = {
        ["<Esc>"] = "Close",
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
      },
    },
    select = {
      get_config = function(opts)
        if opts.kind == 'codeaction' then
          return {
            backend = 'nui',
            nui = {
              relative = 'cursor',
              max_width = 40,
            }
          }
        end
      end
    },
  },
}
