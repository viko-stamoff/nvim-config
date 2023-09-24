return {
  -- Enable startup screen
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    opts = function()
      local header_art = 
      [[
       ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
       │││├┤ │ │╰┐┌╯││││
       ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
      ]]

      local starter = require('mini.starter')
      starter.setup({
        -- evaluate_single = true,
        items = {
          starter.sections.sessions(77, true),
          starter.sections.builtin_actions(),
        },
        content_hooks = {
          function(content)
            local blank_content_line = { { type = 'empty', string = '' } }
            local section_coords = starter.content_coords(content, 'section')
            -- Insert backwards to not affect coordinates
            for i = #section_coords, 1, -1 do
              table.insert(content, section_coords[i].line + 1, blank_content_line)
            end
            return content
          end,
          starter.gen_hook.adding_bullet("» "),
          starter.gen_hook.aligning('center', 'center'),
        },
        header = header_art,
        footer = '',
      })
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
}
