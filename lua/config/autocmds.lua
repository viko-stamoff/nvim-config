-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_user_command("DiffFormat", function()
  local current_file_name = vim.api.nvim_buf_get_name(0)
  local lines = vim.fn.system("git diff --unified=0 --no-color -- " .. current_file_name):gmatch("[^\n\r]+")
  local ranges = {}

  for line in lines do
    if line:find("^@@") then
      local line_nums = line:match("%+.- ")
      if line_nums:find(",") then
        local _, _, first, second = line_nums:find("(%d+),(%d+)")
        table.insert(ranges, {
          start = { tonumber(first), 0 },
          ["end"] = { tonumber(first) + tonumber(second), 0 },
        })
      else
        local first = tonumber(line_nums:match("%d+"))
        table.insert(ranges, {
          start = { first, 0 },
          ["end"] = { first + 1, 0 },
        })
      end
    end
  end

  local conform = require("conform")
  for _, range in pairs(ranges) do
    conform.format({
      range = range,
    })
  end
end, { desc = "Format changed lines" })
